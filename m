Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF1F69E690
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjBUR5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjBUR5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:57:07 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6ED2FCFF;
        Tue, 21 Feb 2023 09:56:39 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2263C68B05; Tue, 21 Feb 2023 18:56:29 +0100 (CET)
Date:   Tue, 21 Feb 2023 18:56:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, tsbogend@alpha.franken.de,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        robh+dt@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com
Subject: Re: [PATCH 1/7] MIPS: Remove DMA_PERDEV_COHERENT
Message-ID: <20230221175628.GB15247@lst.de>
References: <20230221124613.2859-1-jiaxun.yang@flygoat.com> <20230221124613.2859-2-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221124613.2859-2-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 12:46:07PM +0000, Jiaxun Yang wrote:
> As now we are always managing DMA coherence on per dev bias,
> there is no need to have such option. And it's not selected
> by any platform.

I think the real point here is that this is dead code, so it can
obviously go away, but:

>  config MIPS_GENERIC_KERNEL
>  	bool "Generic board-agnostic MIPS kernel"
> -	select ARCH_HAS_SETUP_DMA_OPS
>  	select MIPS_GENERIC
>  	select BOOT_RAW
>  	select BUILTIN_DTB
> @@ -1079,11 +1078,6 @@ config FW_CFE
>  config ARCH_SUPPORTS_UPROBES
>  	bool

> @@ -1097,6 +1091,7 @@ config DMA_NONCOHERENT
>  	select ARCH_HAS_DMA_PREP_COHERENT
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select ARCH_HAS_DMA_SET_UNCACHED
> +	select ARCH_HAS_SETUP_DMA_OPS

This is an unrelated und undocument change.  If you want to do it,
please do that as a separate patch with a commit log documenting
the rationale.
