Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9FE6BFC2E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 19:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCRSzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 14:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCRSzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 14:55:49 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 257261CF45;
        Sat, 18 Mar 2023 11:55:47 -0700 (PDT)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 60C1F7A02C3;
        Sat, 18 Mar 2023 19:55:45 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 00/32] pata_parport-bpck6: rework bpck6 protocol driver
Date:   Sat, 18 Mar 2023 19:55:41 +0100
User-Agent: KMail/1.9.10
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230307224627.28011-1-linux@zary.sk> <b50705b2-0176-cdef-b02b-88449b3d29f6@omp.ru>
In-Reply-To: <b50705b2-0176-cdef-b02b-88449b3d29f6@omp.ru>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202303181955.41922.linux@zary.sk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 March 2023 21:00:01 Sergey Shtylyov wrote:
> Hello!
> 
> On 3/8/23 1:45 AM, Ondrej Zary wrote:
> 
> > This patch series simplifies bpck6 code, removing ppc6lnx.c file to match
> > the simplicity of other protocol drivers. It also converts the direct
> > port I/O access to paraport access functions. This conversion revealed that
> > there's no 8-bit and 16-bit EPP support in parport_pc so patch 11 implements
> > that.
> > 
> > Tested with Backpack CD-RW 222011 and CD-RW 19350.
> > 
> > Signed-off-by: Ondrej Zary <linux@zary.sk>
> > ---
> >  drivers/ata/pata_parport/bpck6.c   | 452 +++++++++++++++++++++++++++--------
> >  drivers/ata/pata_parport/ppc6lnx.c | 726 ---------------------------------------------------------
> >  drivers/parport/parport_pc.c       |  20 +-
> >  include/uapi/linux/parport.h       |   3 +
> >  4 files changed, 370 insertions(+), 831 deletions(-)
> 
>    OK, it's finally clear I can't keep up with reviewing 32 patches posted
> at once...  Luckily, all those patches seem to be dealing with parallel port
> control), not the PATA control! Of course, when I volunteered to review the
> PATA driver patches, I didn't expect such patch volumes -- I mostly expected
> some odd fixes, not a massive driver rework... :-/

So you're going to review the (P)ATA parts (if any) only.
Maybe Sudip (as parport maintainer) could review the parallel port parts?

-- 
Ondrej Zary
