Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FE171F9A5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 07:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjFBFYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 01:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjFBFYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 01:24:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C94197
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 22:24:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26ABF64AEC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 05:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52375C433D2;
        Fri,  2 Jun 2023 05:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685683483;
        bh=FemDFhG1hyH4jM6vI9Lq2sLj6OgTdtg/euQ2DXx0WvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t1BemvWlLgKBYeMZQlmkUyjvGav/JI4A2Q44EFVWJN/Ea63zfd0eND/+2V8N9pfOH
         1qBUNbMs4I8CctgY2RkZE8Ms+5B2Fj0s4KQOksqLg1psgle5dTzTB3Li7Mb+wbicbl
         W/ch3BfemJnfbCd0KUv0IGpv1fNp9fvfx9UStkCQT56h7ZLKActW/V5S629OLpH9iF
         QD53RzH2PKwk4xqxbT5CfsOYdDDWWqeqeF+XFe94meG+TxfvjRU/DHxwrpkxHoybjw
         4VoE1nD8zhgnO3Qxyjfv81nr+2AecWPj/8asrxt3TNFDpFPWv3fd2yH/a6oK0Y3OFk
         00HFUgmbgSVPg==
Date:   Fri, 2 Jun 2023 08:24:14 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yuwei Guan <ssawgyw@gmail.com>
Cc:     akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        anshuman.khandual@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] memblock: Update nid info in memblock debugfs
Message-ID: <20230602052414.GG395338@kernel.org>
References: <20230601133149.37160-1-ssawgyw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601133149.37160-1-ssawgyw@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 09:31:49PM +0800, Yuwei Guan wrote:
> The node id for memblock reserved regions will be wrong,
> so let's show 'x' for reg->nid == MAX_NUMNODES in debugfs to keep it align.
> 
> Suggested-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Co-developed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>

Applied, thanks!

> ---
>  mm/memblock.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 9ddd1ecb9af8..f50b418ccb11 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2160,17 +2160,21 @@ static int memblock_debug_show(struct seq_file *m, void *private)
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
> 2.17.1
> 

-- 
Sincerely yours,
Mike.
