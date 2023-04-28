Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A376F1D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346459AbjD1RCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346427AbjD1RCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D1659EB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:01:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6A41644B4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11C3C433EF;
        Fri, 28 Apr 2023 17:01:33 +0000 (UTC)
Date:   Fri, 28 Apr 2023 18:01:30 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Justin M. Forbes" <jforbes@fedoraproject.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jmforbes@linuxtx.org, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Revert arm64: drop ranges in definition of
 ARCH_FORCE_MAX_ORDER
Message-ID: <ZEv76qfIiJcUvdql@arm.com>
References: <20230428153646.823736-1-jforbes@fedoraproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428153646.823736-1-jforbes@fedoraproject.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Mike and Andrew

On Fri, Apr 28, 2023 at 10:36:45AM -0500, Justin M. Forbes wrote:
> While the ARCH_FORCE_MAX_ORDER changes clarified the descriptions quite
> a bit, the aarch64 specific change moved this config to sit behind
> CONFIG_EXPERT. This becomes problematic when distros are setting this to
> a non default value already. Pushing it behind EXPERT where it was not
> before will silently change the configuration for users building with
> oldconfig.  If distros patch out if EXPERT downstream, it still creates
> problems for users testing out upstream patches, or trying to bisect to
> find the root of problem, as the configuration will change unexpectedly,
> possibly leading to different behavior and false results.
> 
> Whem I asked about reverting the EXPERT, dependency, I was asked to add
> the ranges back.
> 
> This essentially reverts commit 34affcd7577a232803f729d1870ba475f294e4ea
> 
> Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b1201d25a8a4..dae18ac01e94 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1516,9 +1516,11 @@ config XEN
>  # 16K |       27          |      14      |       13        |         11         |
>  # 64K |       29          |      16      |       13        |         13         |
>  config ARCH_FORCE_MAX_ORDER
> -	int "Order of maximal physically contiguous allocations" if EXPERT && (ARM64_4K_PAGES || ARM64_16K_PAGES)
> +	int "Order of maximal physically contiguous allocations" if ARM64_4K_PAGES || ARM64_16K_PAGES
>  	default "13" if ARM64_64K_PAGES
> +	range 11 13 if ARM64_16K_PAGES
>  	default "11" if ARM64_16K_PAGES
> +	range 10 15 if ARM64_4K_PAGES
>  	default "10"
>  	help
>  	  The kernel page allocator limits the size of maximal physically

The revert looks fine to me:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

For the record, the original discussion:

Link: https://lore.kernel.org/r/CAFxkdAr5C7ggZ+WdvDbsfmwuXujT_z_x3qcUnhnCn-WrAurvgA@mail.gmail.com
