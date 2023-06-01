Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEC571921A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjFAFVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjFAFVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:21:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D974312C
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:21:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51C4D614CE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 05:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3D5C433EF;
        Thu,  1 Jun 2023 05:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685596903;
        bh=Koxe39K4Rpi6vC8WW4spnDTwr5GtFMwjDnN5f/mDfKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Znlc28ycUx7Q2gzFML6vW1pP7LS1yC266N7++xoSeif/pDycBYwl9E3HHAfo7fGCw
         17m6m6B6WCSyqQWPyekZiVyrgwDd/G3iFN6lvn/uureuSSmLGcpq93ULQ+c0SN9su0
         xbW9+KYYmizVg+Czp19NyaA3nnDMvwfAP8M6pvTsOl2cNI/JX8BUUhJjVtoSg6kOip
         SiISVDMIm7mpJ54S2NiagwtrPsTKJEAshsPbxNzdO88VdcPvCX9UNsqaoDhEVWbsDj
         gPuR16qOhCVlX0dNPzUbnfbdIoohVnFH1FJgCCH5tGkX0ftis4oYf1UZCvtRScOqcC
         JmenaeXsKyNDQ==
Date:   Thu, 1 Jun 2023 08:21:16 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yuwei Guan <ssawgyw@gmail.com>
Cc:     akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        anshuman.khandual@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: Update nid info in memblock debugfs
Message-ID: <20230601052116.GC395338@kernel.org>
References: <20230529062002.157-1-ssawgyw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529062002.157-1-ssawgyw@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 02:20:02PM +0800, Yuwei Guan wrote:
> The node id for memblock reserved regions will be wrong,
> so let's show 'x' for reg->nid == MAX_NUMNODES in debugfs to keep it align.
> 
> Suggested-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>

I believe this could use Co-developed-by tags.
Please take a look at Documentation/process/submitting-patches.rst

> ---
>  mm/memblock.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index c5c80d9bcea3..3d449aaba052 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2169,17 +2169,21 @@ static int memblock_debug_show(struct seq_file *m, void *private)
>  {
>  	struct memblock_type *type = m->private;
>  	struct memblock_region *reg;
> -	int i, j;
> +	int i, j, nid;
>  	unsigned int count = ARRAY_SIZE(flagname);
>  	phys_addr_t end;
>  
>  	for (i = 0; i < type->cnt; i++) {
>  		reg = &type->regions[i];
>  		end = reg->base + reg->size - 1;
> +		nid = memblock_get_region_node(reg);
>  
>  		seq_printf(m, "%4d: ", i);
>  		seq_printf(m, "%pa..%pa ", &reg->base, &end);
> -		seq_printf(m, "%4d ", memblock_get_region_node(reg));
> +		if (nid != MAX_NUMNODES)
> +			seq_printf(m, "%4d ", nid);
> +		else
> +			seq_printf(m, "%4c ", 'x');
>  		if (reg->flags) {
>  			for (j = 0; j < count; j++) {
>  				if (reg->flags & (1U << j)) {
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.
