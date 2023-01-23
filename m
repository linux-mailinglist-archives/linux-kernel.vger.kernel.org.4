Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E326787B4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjAWU0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjAWU0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:26:38 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC476A59
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:26:37 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674505596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7o+6OInRK21WLYT3LKlDLpVnxva9ZKkaUMjhl61Gj4k=;
        b=g/OURUyB3DyGcemCmY+jBM/dm8sQVhzfXFQcK6PoJv7G8D61ZtVkUW8v7537uTEp6kRcG8
        vJpiGQEz/4gTPnQrqA2Wgz4cdSIpNVpWVhCemY2Gytk7yRagGQaXZygB9N/XyJp/6fS0De
        TI3fCKaDrzXwKX8SFMw1ZP7fkCs1uLY=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev,
        Dong Bo <dongbo4@huawei.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nianyao Tang <tangnianyao@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] KVM: arm64: Synchronize SMEN on vcpu schedule out
Date:   Mon, 23 Jan 2023 20:26:16 +0000
Message-Id: <167450416037.2570834.653110952434883435.b4-ty@linux.dev>
In-Reply-To: <20221220105024.13484-1-dongbo4@huawei.com>
References: <20221220105024.13484-1-dongbo4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2022 18:50:24 +0800, Dong Bo wrote:
> From: Nianyao Tang <tangnianyao@huawei.com>
> 
> If we have VHE and need to reenable SME for host in
> kvm_arch_vcpu_put_fp, CPACR.SMEN is modified from 0 to 1. Trap
> control for reading SVCR is modified from enable to disable.
> Synchronization is needed before reading SVCR later in
> fpsimd_save, or it may cause sync exception which can not be
> handled by host.
> 
> [...]

Applied to kvmarm/next, thanks!

[1/1] KVM: arm64: Synchronize SMEN on vcpu schedule out
      https://git.kernel.org/kvmarm/kvmarm/c/59d78a2ec0e9

--
Best,
Oliver
