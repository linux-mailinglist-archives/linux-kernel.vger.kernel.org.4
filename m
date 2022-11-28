Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F2863AA70
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiK1OGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiK1OGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:06:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476E820F61;
        Mon, 28 Nov 2022 06:06:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F168EB80DDF;
        Mon, 28 Nov 2022 14:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEEAC433C1;
        Mon, 28 Nov 2022 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669644365;
        bh=PvFU14Tw+GunusKbVMruIGE8w1KDKd8yILQPKFFCjsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k7CZOHPWVqpuMVy0DiM+Qx7MRYjZ5zqcv7d3OUPVBd2DbjOweUDW47zyJhf6x6o5a
         tXytMHCFMWgFGsM/mMOm3ovtcdPK/kNziDAjJ8jb+SXg5iIMqIRxlg0OLBV+J8Ebeb
         7J7jzXiqVVTnQ9CfuuMFR9wnIWSSX48WcLUxH+NEdTEUQTg6n6FP6OizB8t5zi7LIT
         hSosMchmeoBnSPwLuFgKCsmbn2k1e/KKrikiMzQfKu2QP9IlgWKj9JAipXc/lmJ24G
         htl8Xc4mPxFm70D5V4+HsNOPaA7rjFlZeNjQFhXu1DGP6lq/UGap2bdVkT8sybUMT4
         XCEjaNkYl9mlw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1ozeln-0097Mn-Hr;
        Mon, 28 Nov 2022 14:06:03 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Replace PMU version number '0' with ID_AA64DFR0_EL1_PMUVer_NI
Date:   Mon, 28 Nov 2022 14:06:00 +0000
Message-Id: <166964435234.1494517.16237640748625443897.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128135629.118346-1-anshuman.khandual@arm.com>
References: <20221128135629.118346-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, anshuman.khandual@arm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, will@kernel.org, acme@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 19:26:29 +0530, Anshuman Khandual wrote:
> kvm_host_pmu_init() returns when detected PMU is either not implemented, or
> implementation defined. kvm_pmu_probe_armpmu() also has a similar situation
> Extracted ID_AA64DFR0_EL1_PMUVer value, when PMU is not implemented is '0',
> which can be replaced with ID_AA64DFR0_EL1_PMUVer_NI defined as '0b0000'.

Applied to next, thanks!

[1/1] KVM: arm64: Replace PMU version number '0' with ID_AA64DFR0_EL1_PMUVer_NI
      commit: 86815735aa571d493cf5768cad5fa8e6fd9c7ba8

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


