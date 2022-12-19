Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31745650E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiLSPPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiLSPPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:15:14 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75198DF5F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:15:12 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id cf42so14151996lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UBscDX32Qyn/0CwIAUKmTYxHhuxi4NwStBcWmmpiMug=;
        b=zFNgrdyF+mttnjY4vXjQS7/2/LOBBOMHjS4QQ1GQbSuki5CJHo1Sc7vndREPKidnCJ
         W52Uiaf5xR/3oRbV4gtSZjKNFGnAIz0KnLbAlhSTpGewIrVz5WYC8LI07G/K1i0lCW5n
         HFIMShYHlST+6CBpC6TxoNsPBLs14k7BSeaywzbVWHMmUiZXtgIsNowRmTtxSWFOhY/M
         SBwRlymqHmjH4Il/F4uADvtt/6aj6Vl6onDta5RS/Ez8DmrpXHXRzGhARbJn7VOXXnfO
         mGakFNEnt86QOoBuSGd79CM6yRoysSWFOr/4VLZBrR4Yk5MYhR9C0GnfKKx8p5128QrB
         jRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBscDX32Qyn/0CwIAUKmTYxHhuxi4NwStBcWmmpiMug=;
        b=apR/rmD6Ha+wbKldkIsDF1p/2tNRJzgYHJCZwDRPEaOvLrbMbeGB6h/RAbNjiPtF0x
         iYQaznlHaejO7tDGqgJoXjX/5bKNyF6Dym6e48WGB0cOOGFIzw3ph/AHdmjSIx/aj7EN
         TRDppdjxpEQY0937ln1294zwO59ar00IdDAR6UTNfOYnPl3HbSSeDp57L8OLzvaTSfwQ
         K3CHiEMfKpBK1NO9w9Qa8BXDFsogPv06hkRoYmXWcUGKmM2QEyoYXHSmJXtSP7ZibXHw
         XvbbbMh3FM0IPb+s9swJZd6BdnDM4ya2Qi9aTrusYf0tD/bN89GutZDty+9TFciWrhKG
         y+wA==
X-Gm-Message-State: ANoB5pnAUUunm23QKsLSNmj6i+MqhvQ5k/PaClA43HdmPqQxwx7UF8+J
        WbqN9dAIX1Tcqn5sEXDHU7iHnw==
X-Google-Smtp-Source: AA0mqf5UKUVcABReRnF5CXRK5v5ErUJaXMBrfO1u9voQcZQt9jDNWPYiCt5ftYFKFKtZJKWhskqvYA==
X-Received: by 2002:a05:6512:c09:b0:4b6:e64c:aec6 with SMTP id z9-20020a0565120c0900b004b6e64caec6mr12127074lfu.63.1671462910742;
        Mon, 19 Dec 2022 07:15:10 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e1-20020a05651236c100b004bd8534ebbcsm1109894lfs.37.2022.12.19.07.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:15:10 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v2 0/5] PM: Fixes for Realtime systems
Date:   Mon, 19 Dec 2022 16:14:58 +0100
Message-Id: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The goal is to make Linux kernel PM / PM domains / cpuidle friendlier for
Realtime systsems (PREEMPT_RT).  Realtime changes regular spinlocks into
sleeping primitives, thus other parts of the code must be ready for it.

Changes since v1
================
1. Patch #1: Add missing WARN for parent domain
2. New patches 3-5 for other issues encountered with PREEMPT_RT.

Best regards,
Krzysztof

---

Cc: Adrien Thierry <athierry@redhat.com>
Cc: Brian Masney <bmasney@redhat.com>
Cc: linux-rt-users@vger.kernel.org

Krzysztof Kozlowski (5):
  PM: domains: Add GENPD_FLAG_RT_SAFE for PREEMPT_RT
  cpuidle: psci: Mark as PREEMPT_RT safe
  cpuidle: psci: Do not suspend topology CPUs on PREEMPT_RT
  PM: Allow calling dev_pm_domain_set() with raw spinlock
  PM: domains: Do not call device_pm_check_callbacks() when holding
    genpd_lock()

 drivers/base/power/common.c           | 27 ++++++++++-
 drivers/base/power/domain.c           | 65 +++++++++++++++++++++++++--
 drivers/cpuidle/cpuidle-psci-domain.c |  3 +-
 drivers/cpuidle/cpuidle-psci.c        |  4 +-
 include/linux/pm_domain.h             | 16 +++++++
 5 files changed, 107 insertions(+), 8 deletions(-)

-- 
2.34.1

