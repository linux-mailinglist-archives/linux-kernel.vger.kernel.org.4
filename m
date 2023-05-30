Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E619715773
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjE3HoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjE3HnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:43:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA36118
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:43:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B917A62085
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2111DC43321;
        Tue, 30 May 2023 07:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685432575;
        bh=6jju/VAgId7WFY8IzF0rQuEorc44IT7/dTNtYmexhZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oiXiH9nqKTl21coLlX+pxYML8p8cvS8za+/ikyCDVq+Ov8GKEJnvrNeZwmMNphOxH
         BZw8bg3+lJJ6mSkam8pKTKw/supmzJqI+qmxMhADh+HNk9w5tIAx4fZk7U5XQNucG+
         gTWjZ/tlLmHcOIyLgduZIiZgPKVhkEzdCiZJAJURyenFeTGxFZftuv2iarEAGnETXK
         WKsUiRrI7q0489jVRWtnqexRJv+g7a5BA+/ckHwcWRupPFiHM3qnCvvEP/SQjwxoeK
         QlPhWR0mlmbQ2MuK1T/bL+Mqd81ew0o7ZdZGG0d3koRUZ/XYm+qL8bWqtPZ6yTUXJe
         n87/OEcB4i+Jg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1q3u0K-001ERg-Tc;
        Tue, 30 May 2023 08:42:53 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH v2] KVM: arm64: Populate fault info for watchpoint
Date:   Tue, 30 May 2023 08:42:45 +0100
Message-Id: <168543255393.371814.2633669131732597562.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530024651.10014-1-akihiko.odaki@daynix.com>
References: <20230530024651.10014-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: akihiko.odaki@daynix.com, suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, james.morse@arm.com, will@kernel.org, yuzenghui@huawei.com, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, oliver.upton@linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 11:46:51 +0900, Akihiko Odaki wrote:
> When handling ESR_ELx_EC_WATCHPT_LOW, far_el2 member of struct
> kvm_vcpu_fault_info will be copied to far member of struct
> kvm_debug_exit_arch and exposed to the userspace. The userspace will
> see stale values from older faults if the fault info does not get
> populated.

Applied to fixes, thanks!

[1/1] KVM: arm64: Populate fault info for watchpoint
      commit: 811154e234db72f0a11557a84ba9640f8b3bc823

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


