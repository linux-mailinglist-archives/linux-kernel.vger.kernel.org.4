Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B886C49FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjCVMLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCVMLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:11:03 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 094AB5F6D6;
        Wed, 22 Mar 2023 05:11:01 -0700 (PDT)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id D3E7D7A00F2;
        Wed, 22 Mar 2023 13:10:59 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 00/32] pata_parport-bpck6: rework bpck6 protocol driver
Date:   Wed, 22 Mar 2023 13:10:42 +0100
User-Agent: KMail/1.9.10
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230307224627.28011-1-linux@zary.sk> <202303181955.41922.linux@zary.sk> <d16b4b27-f1d3-bf05-e062-516e7c708fa2@omp.ru>
In-Reply-To: <d16b4b27-f1d3-bf05-e062-516e7c708fa2@omp.ru>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202303221310.44235.linux@zary.sk>
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 March 2023 21:02:43 Sergey Shtylyov wrote:
> On 3/18/23 9:55 PM, Ondrej Zary wrote:
> 
> >>> This patch series simplifies bpck6 code, removing ppc6lnx.c file to match
> >>> the simplicity of other protocol drivers. It also converts the direct
> >>> port I/O access to paraport access functions. This conversion revealed that
> >>> there's no 8-bit and 16-bit EPP support in parport_pc so patch 11 implements
> >>> that.
> >>>
> >>> Tested with Backpack CD-RW 222011 and CD-RW 19350.
> >>>
> >>> Signed-off-by: Ondrej Zary <linux@zary.sk>
> >>> ---
> >>>  drivers/ata/pata_parport/bpck6.c   | 452 +++++++++++++++++++++++++++--------
> >>>  drivers/ata/pata_parport/ppc6lnx.c | 726 ---------------------------------------------------------
> >>>  drivers/parport/parport_pc.c       |  20 +-
> >>>  include/uapi/linux/parport.h       |   3 +
> >>>  4 files changed, 370 insertions(+), 831 deletions(-)
> >>
> >>    OK, it's finally clear I can't keep up with reviewing 32 patches posted
> >> at once...  Luckily, all those patches seem to be dealing with parallel port
> >> control), not the PATA control! Of course, when I volunteered to review the
> >> PATA driver patches, I didn't expect such patch volumes -- I mostly expected
> >> some odd fixes, not a massive driver rework... :-/
> > 
> > So you're going to review the (P)ATA parts (if any) only.
> 
>    I saw no PATA parts in this patcheset...
> 
> > Maybe Sudip (as parport maintainer) could review the parallel port parts?
> 
>    I have no objections! :-)

Looks like Sudip does not care. What needs to be done so this can be merged?

-- 
Ondrej Zary
