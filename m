Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AE167ADBD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjAYJ0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjAYJ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:26:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC1845F4C;
        Wed, 25 Jan 2023 01:26:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84AB1B818A0;
        Wed, 25 Jan 2023 09:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA9EC433D2;
        Wed, 25 Jan 2023 09:26:16 +0000 (UTC)
Date:   Wed, 25 Jan 2023 09:26:13 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: linux-next: manual merge of the arm64 tree with Linus' tree
Message-ID: <Y9D1tUQXlxL+US0H@arm.com>
References: <20230125083647.34067ee1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125083647.34067ee1@canb.auug.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 08:36:47AM +1100, Stephen Rothwell wrote:
> Today's linux-next merge of the arm64 tree got a conflict in:
> 
>   arch/arm64/Kconfig
> 
> between commit:
> 
>   68a63a412d18 ("arm64: Fix build with CC=clang, CONFIG_FTRACE=y and CONFIG_STACK_TRACER=y")
> 
> from Linus' tree and commit:
> 
>   baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")
> 
> from the arm64 tree.
[...]
> diff --cc arch/arm64/Kconfig
> index c5ccca26a408,de052d935832..000000000000
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@@ -184,6 -186,10 +186,8 @@@ config ARM6
>   	select HAVE_DEBUG_KMEMLEAK
>   	select HAVE_DMA_CONTIGUOUS
>   	select HAVE_DYNAMIC_FTRACE
>  -	select HAVE_DYNAMIC_FTRACE_WITH_ARGS \
>  -		if $(cc-option,-fpatchable-function-entry=2)
> + 	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
> + 		if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG)
>   	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
>   		if DYNAMIC_FTRACE_WITH_ARGS
>   	select HAVE_EFFICIENT_UNALIGNED_ACCESS

Thanks Stephen. It looks fine.

-- 
Catalin
