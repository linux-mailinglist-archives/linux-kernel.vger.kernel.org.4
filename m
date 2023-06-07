Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73887725FD8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbjFGMrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240352AbjFGMq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:46:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5381E198B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:46:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f4db9987f8so663483e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686142014; x=1688734014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M8pnkreZK5j88F8rmiuOcLlKy8lqP5lqOcKSXd8yI1k=;
        b=H9L811FPk662EGACYc/PJ+kN6yEorNVz0rgURrxSVptroj+V7NyicTpne8Shst6xcV
         NDdRr58V3tjfCyAwB75urA1GtiaWVjdSSmxFEyxoUu7ZASWnRzTRwRbEMV4olpirRcp2
         4JV7WIqhQvn2afszGT/s5jPNlOOKN2ORKMeOPJesMzePpKquDh24fkHJc8B1qSduqvsq
         BdsqIl2RRLELZXhiIOUNJYq6lLqJnAXI7XMRvZ4CkOiKsXRx+L4Paw1dCFpP6BOAKj2J
         r3dNvFGNj7rhIOE8dlGWQmjNNjxvEDqsQGP9sYWpILZ1OP8+be6ZrobhLzg9a7j5OuEe
         zIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142014; x=1688734014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8pnkreZK5j88F8rmiuOcLlKy8lqP5lqOcKSXd8yI1k=;
        b=BPuLuiPggiiLAU4PaOVaJheqVC18tJ5ZfIyjyX/j8jWOjZuTwqwU90UXdOPncvbEj1
         vK7MtSMyPe/pujA9b+YUwNYc971Ha8DntR81wlcN0yBST9pi0MDjNyPkIN7nPb3dYmtA
         G7d3/OOmhQ+4v8ZWLGGhj2UD5yFar9/aTgCSy4Dl1PAhdrrgWagmu7DD7FLgkQPxB/hW
         Qvfp93PG7Q5ToBABUTlWFPUUI9rJShv5T65sZGLJy8QcI82KnGC/vVMXn6gcN/We4v0F
         5MnzN22EteFrhHzcIxWUBj0lkGf9aUAimiNUqBfvUbvLRNx46ezY3NxqXxpw58j0w5Bx
         Z9Bg==
X-Gm-Message-State: AC+VfDwj4rQIWk4pywMknTZnOCjGXzXvaSxpRBiyyx7eE9izV+KOaAN3
        ZXh9z1i9QuVChBdT5kY8oQR+xw==
X-Google-Smtp-Source: ACHHUZ5A14nabfpP67OwVt67cCPKLUQvlJfYZ70xucnavemoLTzA/oFZqQs8mMqw07orUGFikDok5Q==
X-Received: by 2002:a05:6512:402:b0:4f3:89e6:23c0 with SMTP id u2-20020a056512040200b004f389e623c0mr1760313lfk.31.1686142014522;
        Wed, 07 Jun 2023 05:46:54 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b004f4b3e9e0cesm1781708lfe.297.2023.06.07.05.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:46:53 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/16] arm_scmi/opp/dvfs: Add generic performance scaling support
Date:   Wed,  7 Jun 2023 14:46:12 +0200
Message-Id: <20230607124628.157465-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current SCMI performance scaling support is limited to cpufreq. This series
extends the support, so it can be used for all kind of devices and not only for
CPUs.

The changes are spread over a couple of different subsystems, although the
changes that affects the other subsystems than the arm_scmi directory are
mostly smaller. The series is based upon v6.4-rc5. That said, let's figure out
on how to best move forward with this. I am of course happy to help in any way.

Note that, so far this is only be tested on the Qemu virt platform with Optee
running an SCMI server. If you want some more details about my test setup, I am
certainly open to share that with you!

Looking forward to get your feedback!

Kind regards
Ulf Hansson


Ulf Hansson (16):
  firmware: arm_scmi: Extend perf protocol ops to get number of domains
  firmware: arm_scmi: Extend perf protocol ops to get the name of a
    domain
  firmware: arm_scmi: Extend perf protocol ops to inform of set level
    support
  cpufreq: scmi: Prepare to move OF parsing of domain-id to cpufreq
  firmware: arm_scmi: Align perf ops to use domain-id as in-parameter
  firmware: arm_scmi: Drop redundant ->device_domain_id() from perf ops
  cpufreq: scmi: Avoid one OF parsing in scmi_get_sharing_cpus()
  PM: domains: Allow genpd providers to manage OPP tables directly by
    its FW
  dt-bindings: firmware: arm,scmi: Extend bindings for protocol@13
  firmware: arm_scmi: Add the SCMI performance domain
  OPP: Add dev_pm_opp_add_dynamic() to allow more flexibility
  OPP: Extend dev_pm_opp_data with performance level
  OPP: Extend dev_pm_opp_data with OPP provider support
  firmware: arm_scmi: Simplify error path in scmi_dvfs_device_opps_add()
  firmware: arm_scmi: Extend perf support with OPP from genpd providers
  firmware: arm_scmi: Add generic OPP support to the SCMI performance
    domain

 .../bindings/firmware/arm,scmi.yaml           |   4 +-
 drivers/base/power/domain.c                   |  11 +-
 drivers/cpufreq/scmi-cpufreq.c                |  40 ++--
 drivers/firmware/arm_scmi/Kconfig             |  12 ++
 drivers/firmware/arm_scmi/Makefile            |   1 +
 drivers/firmware/arm_scmi/perf.c              |  81 ++++----
 drivers/firmware/arm_scmi/scmi_perf_domain.c  | 189 ++++++++++++++++++
 drivers/opp/core.c                            |  69 ++++++-
 drivers/opp/of.c                              |  11 +-
 drivers/opp/opp.h                             |   3 +-
 include/linux/pm_domain.h                     |   5 +
 include/linux/pm_opp.h                        |  27 +++
 include/linux/scmi_protocol.h                 |  14 +-
 13 files changed, 388 insertions(+), 79 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/scmi_perf_domain.c

-- 
2.34.1

