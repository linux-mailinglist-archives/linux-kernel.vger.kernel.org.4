Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267E1633518
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 07:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiKVGMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 01:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKVGMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:12:03 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40332A70E;
        Mon, 21 Nov 2022 22:12:01 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7522168D05; Tue, 22 Nov 2022 07:11:58 +0100 (CET)
Date:   Tue, 22 Nov 2022 07:11:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: linux-next: manual merge of the dma-mapping tree with Linus'
 tree
Message-ID: <20221122061158.GA14175@lst.de>
References: <20221122100611.13a374e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122100611.13a374e2@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 10:06:11AM +1100, Stephen Rothwell wrote:
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks Stephen,

the fix look good.  The being said the code in the sound tree here
is questionable to start with:

>   #ifdef CONFIG_SND_DMA_SGBUF
>  +	if (!sgt && !get_dma_ops(dmab->dev.dev)) {
>   		if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_WC_SG)
>   			dmab->dev.type = SNDRV_DMA_TYPE_DEV_WC_SG_FALLBACK;
>   		else

driver have no busuness calling get_dma_ops and poking into the
dma-mapping internals.
