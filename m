Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35AF6951BC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjBMURv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjBMURt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:17:49 -0500
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C38521A3E;
        Mon, 13 Feb 2023 12:17:47 -0800 (PST)
Date:   Mon, 13 Feb 2023 12:17:45 -0800
From:   Patrick McLean <chutzpah@gentoo.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Disable READ LOG DMA EXT for Samsung
 MZ7LH
Message-ID: <20230213121745.2847a9ff@moya.linuxfreak.ca>
In-Reply-To: <dce110de-649d-cde8-9401-346675c95263@opensource.wdc.com>
References: <20230210215151.812839-1-chutzpah@gentoo.org>
        <dce110de-649d-cde8-9401-346675c95263@opensource.wdc.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Feb 2023 12:11:48 +0900
Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:

> On 2/11/23 06:51, Patrick McLean wrote:
> > Samsung MZ7LH drives are spewing messages like this in to dmesg with AMD
> > SATA controllers:
> > 
> > ata1.00: exception Emask 0x0 SAct 0x7e0000 SErr 0x0 action 0x6 frozen
> > ata1.00: failed command: SEND FPDMA QUEUED
> > ata1.00: cmd 64/01:88:00:00:00/00:00:00:00:00/a0 tag 17 ncq dma 512 out
> >          res 40/00:01:01:4f:c2/00:00:00:00:00/00 Emask
> >          0x4 (timeout)
> > 
> > Since this was seen previously with SSD 840 EVO drives in
> > https://bugzilla.kernel.org/show_bug.cgi?id=203475 let's add the same
> > fix for these drives as the EVOs have, since they likely have very
> > similar firmwares.
> > 
> > Signed-off-by: Patrick McLean <chutzpah@gentoo.org>
> > ---
> >  drivers/ata/libata-core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index 2ea572628b1c..c4c89d24f84c 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -4045,6 +4045,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
> >  	{ "Samsung SSD 870*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
> >  						ATA_HORKAGE_ZERO_AFTER_TRIM |
> >  						ATA_HORKAGE_NO_NCQ_ON_ATI },
> > +	{ "SAMSUNG*MZ7LH*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
> > +						ATA_HORKAGE_ZERO_AFTER_TRIM |
> > +						ATA_HORKAGE_NO_NCQ_ON_ATI, },
> >  	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
> >  						ATA_HORKAGE_ZERO_AFTER_TRIM },
> >    
> 
> Looks OK, but ATA_HORKAGE_NO_NCQ_ON_ATI is for PCI vendor ID 1002h. AMD
> also has vendor ID 1022h. Did you check you adapter vendor ID & tested
> this patch ?

We tested this patch, and it resolves the problem for us (we have been
using it for several months).

> -- 
> Damien Le Moal
> Western Digital Research
> 


-- 
