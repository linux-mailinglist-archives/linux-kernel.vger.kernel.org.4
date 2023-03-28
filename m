Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514C76CCBFE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjC1VP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjC1VP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:15:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A681BCE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 14:15:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E08CA61973
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 21:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3D1C433EF;
        Tue, 28 Mar 2023 21:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680038154;
        bh=r/+up7IBLePhqWvv9WmEvRBGSNPOe/2CnxDucQMfDmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYHDGgNaIe2yuUKKKx1D88ezDfwa/gXMpi0+8Cf+K9V3+whRjMhE9ivFkKw5M0riq
         vCJ98xFXh9pA44u0Up8Ji+E32S8KOUHh27PMpy1vqSH6O95E13EmyrrBfE8S6SbpvY
         ozgilh0Sfmef+3ofCpkS08tZO8KDq894y5enXENZ8ocmhQhObwgC187h+B8gZL05+d
         TgOA0HjsXeweo5HhBUg2lAU5/d1blhUHshjNgayZONMs8rQbKRG+JS2PxvRZQXJEMd
         OETYgNTmp+utnKKpzIfQ2ppw3I064XQK+xk6+kvypeUbPQc1P688OC1hiJwvdOQ70e
         5FlRp1CRbYr7w==
From:   Will Deacon <will@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Nick Child <nnac123@linux.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Juergen Gross <jgross@suse.com>,
        John Garry <john.garry@huawei.com>,
        WANG Xuerui <git@xen0n.name>, Borislav Petkov <bp@suse.de>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        James Morse <james.morse@arm.com>,
        Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PATCH v4] firmware: arm_sdei: Fix sleep from invalid context BUG
Date:   Tue, 28 Mar 2023 22:15:43 +0100
Message-Id: <168001329595.983896.13957861833923514918.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230216084920.144064-1-pierre.gondois@arm.com>
References: <20230216084920.144064-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 09:49:19 +0100, Pierre Gondois wrote:
> Running a preemp_rt kernel based on vv6.2-rc3-rt1 based kernel on an
> Ampere Altra triggers:
>   BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
>   in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 24, name: cpuhp/0
>   preempt_count: 0, expected: 0
>   RCU nest depth: 0, expected: 0
>   3 locks held by cpuhp/0/24:
>     #0: ffffda30217c70d0 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x5c/0x248
>     #1: ffffda30217c7120 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x5c/0x248
>     #2: ffffda3021c711f0 (sdei_list_lock){....}-{3:3}, at: sdei_cpuhp_up+0x3c/0x130
>   irq event stamp: 36
>   hardirqs last  enabled at (35): [<ffffda301e85b7bc>] finish_task_switch+0xb4/0x2b0
>   hardirqs last disabled at (36): [<ffffda301e812fec>] cpuhp_thread_fun+0x21c/0x248
>   softirqs last  enabled at (0): [<ffffda301e80b184>] copy_process+0x63c/0x1ac0
>   softirqs last disabled at (0): [<0000000000000000>] 0x0
>   CPU: 0 PID: 24 Comm: cpuhp/0 Not tainted 5.19.0-rc3-rt5-[...]
>   Hardware name: WIWYNN Mt.Jade Server [...]
>   Call trace:
>     dump_backtrace+0x114/0x120
>     show_stack+0x20/0x70
>     dump_stack_lvl+0x9c/0xd8
>     dump_stack+0x18/0x34
>     __might_resched+0x188/0x228
>     rt_spin_lock+0x70/0x120
>     sdei_cpuhp_up+0x3c/0x130
>     cpuhp_invoke_callback+0x250/0xf08
>     cpuhp_thread_fun+0x120/0x248
>     smpboot_thread_fn+0x280/0x320
>     kthread+0x130/0x140
>     ret_from_fork+0x10/0x20
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] firmware: arm_sdei: Fix sleep from invalid context BUG
      https://git.kernel.org/arm64/c/d2c48b2387eb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
