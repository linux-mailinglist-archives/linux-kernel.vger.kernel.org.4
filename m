Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FFF722DD4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjFERqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjFERqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:46:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE6CEA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:46:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29A4D628D3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 17:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C15BC433EF;
        Mon,  5 Jun 2023 17:46:04 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] arm64: Support for Armv8.8 memcpy instructions in userspace
Date:   Mon,  5 Jun 2023 18:46:02 +0100
Message-Id: <168598715797.875812.8370226994264203453.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509142235.3284028-1-kristina.martsenko@arm.com>
References: <20230509142235.3284028-1-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 May 2023 15:22:24 +0100, Kristina Martsenko wrote:
> The Armv8.8 extension adds new instructions to perform memcpy(), memset() and
> memmove() operations in hardware (FEAT_MOPS). This series adds support for
> using the new instructions in userspace. More information can be found in the
> cover letter for v1:
>   https://lore.kernel.org/linux-arm-kernel/20230216160012.272345-1-kristina.martsenko@arm.com/
> 
> Changes in v2:
>  - Removed booting.rst requirement for HCRX_EL2.MCE2
>  - Changed HCRX_EL2 cpucap to be STRICT_BOOT type
>  - Changed HCRX_EL2.SMPME to be set for the guest and unset for the host
>  - Moved HCRX_EL2 initialization into init_el2_state(), dropped ISB
>  - Simplified conditional checks in mops exception handler with XOR
>  - Added comments from Arm ARM into mops exception handler
>  - Converted cpucaps to use the new ARM64_CPUID_FIELDS() helper
>  - Added MOPS to hwcaps kselftest
>  - Improved commit messages
>  - Rebased onto v6.4-rc1
>  - v1: https://lore.kernel.org/linux-arm-kernel/20230216160012.272345-1-kristina.martsenko@arm.com/
> 
> [...]

Applied to arm64 (for-next/feat_mops), thanks!

[01/11] KVM: arm64: initialize HCRX_EL2
        https://git.kernel.org/arm64/c/af94aad4c915
[02/11] arm64: cpufeature: detect FEAT_HCX
        https://git.kernel.org/arm64/c/b0c756fe996a
[03/11] KVM: arm64: switch HCRX_EL2 between host and guest
        https://git.kernel.org/arm64/c/306b4c9f7120
[04/11] arm64: mops: document boot requirements for MOPS
        https://git.kernel.org/arm64/c/f32c053b9806
[05/11] arm64: mops: don't disable host MOPS instructions from EL2
        https://git.kernel.org/arm64/c/b1319c0e9559
[06/11] KVM: arm64: hide MOPS from guests
        https://git.kernel.org/arm64/c/3172613fbcbb
[07/11] arm64: mops: handle MOPS exceptions
        https://git.kernel.org/arm64/c/8536ceaa7471
[08/11] arm64: mops: handle single stepping after MOPS exception
        https://git.kernel.org/arm64/c/8cd076a67dc8
[09/11] arm64: mops: detect and enable FEAT_MOPS
        https://git.kernel.org/arm64/c/b7564127ffcb
[10/11] arm64: mops: allow disabling MOPS from the kernel command line
        https://git.kernel.org/arm64/c/3e1dedb29d0f
[11/11] kselftest/arm64: add MOPS to hwcap test
        https://git.kernel.org/arm64/c/d8a324f102cc

-- 
Catalin

