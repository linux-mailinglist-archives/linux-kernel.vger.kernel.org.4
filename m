Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90345EF448
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbiI2L1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiI2L1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:27:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2F3A14D4A2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:27:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2048315BF;
        Thu, 29 Sep 2022 04:27:51 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.81.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A2563F73B;
        Thu, 29 Sep 2022 04:27:42 -0700 (PDT)
Date:   Thu, 29 Sep 2022 12:27:39 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, Julia.Lawall@inria.fr, akpm@linux-foundation.org,
        andreyknvl@gmail.com, elver@google.com, wangkefeng.wang@huawei.com,
        zhouchengming@bytedance.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: module: Make plt_equals_entry() static
Message-ID: <YzWBK3fkxWAlZUYc@FVFF77S0Q05N>
References: <20220929094134.99512-1-lihuafei1@huawei.com>
 <20220929094134.99512-2-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929094134.99512-2-lihuafei1@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 05:41:32PM +0800, Li Huafei wrote:
> Since commit 4e69ecf4da1e ("arm64/module: ftrace: deal with place
> relative nature of PLTs"), plt_equals_entry() is not used outside of
> module-plts.c, so make it static.
> 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/module.h | 1 -
>  arch/arm64/kernel/module-plts.c | 3 ++-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
> index 4e7fa2623896..28514b989a0b 100644
> --- a/arch/arm64/include/asm/module.h
> +++ b/arch/arm64/include/asm/module.h
> @@ -58,7 +58,6 @@ static inline bool is_forbidden_offset_for_adrp(void *place)
>  }
>  
>  struct plt_entry get_plt_entry(u64 dst, void *pc);
> -bool plt_entries_equal(const struct plt_entry *a, const struct plt_entry *b);
>  
>  static inline bool plt_entry_is_initialized(const struct plt_entry *e)
>  {
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index a3d0494f25a9..5a0a8f552a61 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -37,7 +37,8 @@ struct plt_entry get_plt_entry(u64 dst, void *pc)
>  	return plt;
>  }
>  
> -bool plt_entries_equal(const struct plt_entry *a, const struct plt_entry *b)
> +static bool plt_entries_equal(const struct plt_entry *a,
> +			      const struct plt_entry *b)
>  {
>  	u64 p, q;
>  
> -- 
> 2.17.1
> 
