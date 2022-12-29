Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0616A658FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiL2RYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbiL2RXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:23:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368BB14D26;
        Thu, 29 Dec 2022 09:23:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1F8A6186A;
        Thu, 29 Dec 2022 17:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F27C433F0;
        Thu, 29 Dec 2022 17:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334631;
        bh=ARJbeLHsRwuQNjg9NTjzFgIS2ZjYokcRqa5fJeEftsk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SyAZRcazCJnzYwllbDg8uSeZ4DeULJRZmZqANzRrJUD4xUi39oZJHI+Sl0/zwEXO7
         8Al4cBbkIPF51KWSum73TfNJftf9r3SzgTyIgGOxgWvl82xTfQ0q5lg1ICb48+L+ur
         XZyM1r41OaGrsaWxk5cKDrkHjWjCRlnHDGX0TNE24Om28uwfIvMfpLuDnkcB8/iPJ7
         vNJl7IvEW9PEtfv3I0EBEPupOjFR+4CezbTl1sYupICQvj0TpDKnJvq5D0B4A1jL2y
         gCpfit1P59cXFshOWP+1y+d+ykV6WgFDbfSkPFqOgmLYe3iyYs9Sq8XTACEA+41rak
         U64vBbsgF4eNg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8250: add cache size
Date:   Thu, 29 Dec 2022 11:23:30 -0600
Message-Id: <167233461757.1099840.14274696553215554413.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221229132731.1193713-1-krzysztof.kozlowski@linaro.org>
References: <20221229132731.1193713-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2022 14:27:31 +0100, Krzysztof Kozlowski wrote:
> Add full cache description to DTS to avoid:
> 1. "Early cacheinfo failed" warnings,
> 2. Cache topology detection which leads to early memory allocations and
>    "BUG: sleeping function called from invalid context" on PREEMPT_RT
>    kernel:
> 
>   smp: Bringing up secondary CPUs ...
>   Detected VIPT I-cache on CPU1
>   BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
>   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
>   preempt_count: 1, expected: 0
>   RCU nest depth: 1, expected: 1
>   3 locks held by swapper/1/0:
>    #0: ffff5e337eee5f18 (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x20c/0xffc
>    #1: ffffa9e24a900b18 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x40/0xe4
>    #2: ffff5e337efc8918 (&zone->lock){+.+.}-{3:3}, at: rmqueue_bulk+0x54/0x720
>   irq event stamp: 0
>   Call trace:
>    __might_resched+0x17c/0x214
>    rt_spin_lock+0x5c/0x100
>    rmqueue_bulk+0x54/0x720
>    get_page_from_freelist+0xcfc/0xffc
>    __alloc_pages+0xec/0x1150
>    alloc_page_interleave+0x1c/0xd0
>    alloc_pages+0xec/0x160
>    new_slab+0x330/0x454
>    ___slab_alloc+0x5b8/0xba0
>    __kmem_cache_alloc_node+0xf4/0x20c
>    __kmalloc+0x60/0x100
>    detect_cache_attributes+0x2a8/0x5a0
>    update_siblings_masks+0x28/0x300
>    store_cpu_topology+0x58/0x70
>    secondary_start_kernel+0xc8/0x154
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8250: add cache size
      commit: ac1d8a8e2eb5bd67e266e3121bb6b39b7f28a9ec

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
