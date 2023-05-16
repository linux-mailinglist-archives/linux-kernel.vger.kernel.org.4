Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2FF704F38
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjEPNYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjEPNYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:24:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1C761AA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2DC163589
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27432C433EF;
        Tue, 16 May 2023 13:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684243473;
        bh=v955wWx7frM5aua9JiGRpiLnkxI6iEN+b14qBeS8htg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sbF4guWqOD8mHIzygGiLKs1TaU7izCz1lEHjLaWE7V/evztEOB+OjWPcE3BiAOuTT
         pJCyHAjzuS1gb73gXYtHeUl8eoJ3AfrvaAOM4FHtXEnB4pJX6JK1V4FH+1rfhdhe7K
         Iv/sVogMqvtuawf1PYPzqlN45tWiuAAIT2POP5pZjjDneBU/vs5IbadWrBjA6ZkH+R
         bfegHHga3ojh71j2gPFjSRsVzDpM0f6kh2Y/O5vJo6nyby3VQtXVOGsDs9rXKaMlQ1
         YtTag8zfqawlBMWSK4N2q8zauDXiCdiyr/mzBOPquy864Y13ctqoqvvOaJZ1NPIHEB
         1UQdYyhc4OnWg==
Date:   Tue, 16 May 2023 14:24:28 +0100
From:   Will Deacon <will@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     broonie@kernel.org, catalin.marinas@arm.com,
        kristina.martsenko@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: use bitmap_zero() API
Message-ID: <20230516132427.GA30894@willie-the-truck>
References: <202305061636313011243@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305061636313011243@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2023 at 04:36:31PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> bitmap_zero() is faster than bitmap_clear(), so use bitmap_zero()
> instead of bitmap_clear().

Is it? Don't these both boil down to:

	memset(asid_map, 0, NUM_USER_ASIDS / 8)

?

Will

> ---
>  arch/arm64/mm/context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> index e1e0dca01839..ed0bf7f8e8ce 100644
> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
> @@ -95,7 +95,7 @@ static void set_reserved_asid_bits(void)
>  	else if (arm64_kernel_unmapped_at_el0())
>  		set_kpti_asid_bits(asid_map);
>  	else
> -		bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
> +		bitmap_zero(asid_map, NUM_USER_ASIDS);
>  }
> 
>  #define asid_gen_match(asid) \
> -- 
> 2.25.1
