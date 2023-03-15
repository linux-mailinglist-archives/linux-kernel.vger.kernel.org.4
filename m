Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F426BB476
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjCONXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjCONXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:23:37 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9881126BD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:23:35 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id cn21so45311497edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678886614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dtiqQT9nTV40DMGtvhdCFZjllJ6LweZkSNTJ7S06oqQ=;
        b=ZrKz8ly+NS7Hqwl2lWmXNnT17/vsi92/+UUxZsVJqbbf5pXvdJqoqvuH55yItOQTfO
         8PO9IFt4aphG5Y8rL0Oe0MsvCpnecI8RdNDhUiJFKeBtKZ6kBFegrfEFTDvnNuqyBPv/
         R5H4DiBQxzjMgK9tfhF2hjQOEOLjryilpbw6tpPrHuSdek9KUKRhlbbR+7VZfK6EKSGo
         bMjkhBBaKtzkzS1ZEvnhj6P4HtBJo9xqVqmDnvyNuz2kYIixlNY4OdWRIJ1B6xYv2MCM
         6z9hP89/khEk8ollehcKOu8F8Po2sBqTI1zr3cWokrgewQPK17YsHyel9oZLTFL+g7Gq
         J8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678886614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtiqQT9nTV40DMGtvhdCFZjllJ6LweZkSNTJ7S06oqQ=;
        b=k+r9NrOmTLxzdozye9hBoCCjGDCeX1icq7qLjAgDnbRX9VGwjOieSMN+kTv/frMmrv
         084AW5umkWsQL2g8jQR9LVJpGmHNQcFrydB2MvHgO31yMmflZg9emIRQVcKiSV+ok2y8
         2C6CiBwlJOBc68XRZEVqlRebIcpRwOayEj+3F9MR9o2lMlO/JyzwXmkClE0UT2CcFZBV
         WXjtkppCZDCilkkjehu5qrqN31IknFKQIzfK0HReYOPCHzGhjl8uWz0ghm3YR/wS6GCl
         Zi/Xs+TkQTtWDr57Q26NHeYEDka+YnUmDdba8815IuEwxLZcgFcS1xzP860H2ZvaCW9Z
         AqLw==
X-Gm-Message-State: AO0yUKXF7e3ca94gN2pHfwQn5ywDkh+f2cH7HpcX8W53wVz6bpsYjTgQ
        hAVSMIegQx4xhECtqyfrbz5QBQ==
X-Google-Smtp-Source: AK7set+i/cYxKNr8y2dFpzx+Hv9vji6LJl3S0j9kXazbXdf5x3x3d25QEsG9uaexDUYc9GUTa+q21A==
X-Received: by 2002:a17:906:8489:b0:878:4a5e:3a56 with SMTP id m9-20020a170906848900b008784a5e3a56mr5991339ejx.15.1678886614047;
        Wed, 15 Mar 2023 06:23:34 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id pj18-20020a170906d79200b008b133f9b33dsm2497365ejb.169.2023.03.15.06.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:23:33 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [RFC PATCH 0/5] Allow genpd providers to power off domains on sync state
Date:   Wed, 15 Mar 2023 15:23:25 +0200
Message-Id: <20230315132330.450877-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been already a couple of tries to make the genpd "disable
unused" late initcall skip the powering off of domains that might be
needed until later on (i.e. until some consumer probes). The conclusion
was that the provider could return -EBUSY from the power_off callback
until the provider's sync state has been reached. This patch series tries
to provide a proof-of-concept that is working on Qualcomm platforms.

I've been doing extensive testing on SM8450, but I've also spinned this
on my X13s (SC8280XP). Both patches that add the sync state callback to
the SC8280XP and SM8450 are here to provide context. Once we agree on
the form, I intend to add the sync state callback to all gdsc providers.

Currently, some of the gdsc providers might not reach sync state due to
list of consumers not probing yet (or at all). The sync state can be
enforced by writing 1 to the state_synced sysfs attribute of the
provider, thanks to Saravana's commit [1] which has been already merged.

[1] https://lore.kernel.org/r/20230304005355.746421-3-saravanak@google.com

Abel Vesa (5):
  PM: domains: Allow power off queuing from providers
  soc: qcom: rpmhpd: Do proper power off when state synced
  clk: qcom: gdsc: Avoid actual power off until sync state
  clk: qcom: Add sync state callback to all SC8280XP providers
  clk: qcom: Add sync state callback to all SM8450 providers

 drivers/base/power/domain.c        |  3 ++-
 drivers/clk/qcom/camcc-sm8450.c    |  1 +
 drivers/clk/qcom/common.c          | 13 +++++++++++++
 drivers/clk/qcom/common.h          |  1 +
 drivers/clk/qcom/dispcc-sc8280xp.c |  1 +
 drivers/clk/qcom/dispcc-sm8450.c   |  1 +
 drivers/clk/qcom/gcc-sc8280xp.c    |  1 +
 drivers/clk/qcom/gcc-sm8450.c      |  1 +
 drivers/clk/qcom/gdsc.c            | 26 ++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h            |  6 ++++++
 drivers/clk/qcom/gpucc-sc8280xp.c  |  1 +
 drivers/soc/qcom/rpmhpd.c          | 19 +++++++------------
 include/linux/pm_domain.h          |  6 ++++++
 13 files changed, 67 insertions(+), 13 deletions(-)

-- 
2.34.1

