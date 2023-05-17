Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67735706A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjEQNoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjEQNn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:43:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FC459D5
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:43:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35E7E61077
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FDBC433D2;
        Wed, 17 May 2023 13:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684331036;
        bh=30NDGJJUQ2ngQiq5TLIVzfaqaVwEFe2VeoyqyahSpjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gL7FAHfrNE/7yRDcy9u+56Cueii95xAEu6aeJEtdwuWYMhLII9uXwi5FZzPPcT1ur
         cia6QH1+vq2F5deS56R7lQAGrWI5ZuCUCXXbZpmJVyKJ5bJ7qWDEWp//sVr3x+Wey8
         2rC15gjTD44yj80TMpAoHXikCC7QvMwK9i5H2kHbkfIOHVBBdb0TXWQRnmf0PFk1at
         1UhgK+KMcXAqna39+1zsxWMKtGoYDgIQM75TfkL5KPt2TCXUFGrsgl2VfHHGDlbLjw
         DPPYKYyUpG4rWQm0CrxNLtt9hJ4obhz4VW5efoWBLO7zFfchPKrF63h9awhU0L5bW3
         LK5E3g3VWNeAQ==
Date:   Wed, 17 May 2023 16:43:51 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yuwei Guan <ssawgyw@gmail.com>
Cc:     akpm@linux-foundation.org, tsahu@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memblock: Add flags and nid info in memblock debugfs
Message-ID: <ZGTaF801Pjs+M48x@kernel.org>
References: <20230517025747.230-1-ssawgyw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517025747.230-1-ssawgyw@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 10:57:47AM +0800, Yuwei Guan wrote:
> Currently, the memblock debugfs can display the count of memblock_type and
> the base and end of the reg. However, when the following scenario occurs,
> the information in the existing debugfs cannot make it clear why the
> address is not consecutive.

...
 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 511d4783dcf1..b36fb6b31e0f 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2144,12 +2144,16 @@ static int memblock_debug_show(struct seq_file *m, void *private)
>  	int i;
>  	phys_addr_t end;
>  
> +	seq_puts(m, "cnt\tbase..end\tflags\tnid\n");
> +
>  	for (i = 0; i < type->cnt; i++) {
>  		reg = &type->regions[i];
>  		end = reg->base + reg->size - 1;
>  
> -		seq_printf(m, "%4d: ", i);
> -		seq_printf(m, "%pa..%pa\n", &reg->base, &end);
> +		seq_printf(m, "%d:\t", i);
> +		seq_printf(m, "%pa..%pa\t", &reg->base, &end);
> +		seq_printf(m, "0x%x\t", reg->flags);
> +		seq_printf(m, "0x%x\n", memblock_get_region_node(reg));

Please use "%4d" for nid.

>  	}
>  	return 0;
>  }
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.
