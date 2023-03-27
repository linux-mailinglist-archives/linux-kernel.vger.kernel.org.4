Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511AB6CAEE9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjC0Tin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjC0Tik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:38:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8B82D41
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:38:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r11so40738427edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679945917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2QU02QZqcsWxbNIoA4doC7Xt9Nnah2Ywv2Hy8C/OsKs=;
        b=lo8NIfcYiwKdB1RCkQW37pKPM68hzsBaSC7jKskOPnAavAxa6DBDCTWz+ioo+FbxrG
         Fnt55dDR23s1B4F+N/vztIcFa3lLX+VGAKvFm1dunuLH/KZb6cwG4TWeXEuKcfpyvJlm
         phNZ4rhS3elvof5NetxwNCFkBEy/4wHvUXu0tFfTZ5VYag9tWYOlyiez1qK2ACYy33So
         vbOcmrjHMkz3o8v9XZphdX1Y/IH+JizIGZ4sJnKyVNVUNTf7l8k2kANdafkNLUJ9Loc2
         D6mZ6AyvSKibq++ecB+KTj28o7NA+f0W3VKRMKq0y6EKlcaFMZes4Ss0x7IsRkiw5TdY
         HvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679945917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2QU02QZqcsWxbNIoA4doC7Xt9Nnah2Ywv2Hy8C/OsKs=;
        b=HOoZLWC30nasLmpxPG5lDKZbCNoON0OxVSvek5KodE2ng3xQpPqlI5NWD4R2uy3mKP
         ihw5ZWZ9ehVI1uZBryyklopGi4VTpIRiVjADzKoppsgbHT4huzUs+d5QfOo1JzfG/U0C
         igD3FnTwV3mz22oi5fgJcDRmKmWH7HWsBdHrdIbdRUrlJqqmHwYudty83P27D/fRcx84
         HHcf3+Cp3jwwoWABmnaA5bPYt5TPQIkQqRuN6gQmCGOnV0tnjcsLWEc9b+eQjYfry0eT
         KKlj3D+/cC/PJZ2knKH3x/pfMxQObkyky/MWjCw/UvsW/qmIWSWkeNT+BbB51CHXcFEF
         r5fg==
X-Gm-Message-State: AAQBX9ejr4r5kscF1Oz5tbw9sj5A2JoFkv7m9PSjXU3BEd5tayzV6b2v
        GYHFd6OHeTyj2kvYQWvrCw3Rwg==
X-Google-Smtp-Source: AKy350Ypsv2QkGJlBje8SS91Xz6ZgGJsh65MgKeyO60yTmdJsae4YAUIYIVnuHHX9X3fqNOWJBQ3jw==
X-Received: by 2002:a50:ec89:0:b0:4fa:4b1c:5ea3 with SMTP id e9-20020a50ec89000000b004fa4b1c5ea3mr13354358edr.23.1679945917173;
        Mon, 27 Mar 2023 12:38:37 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id kb1-20020a1709070f8100b00933c4a25735sm11701254ejc.100.2023.03.27.12.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 12:38:36 -0700 (PDT)
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
Subject: [PATCH v3 0/4] Allow genpd providers to power off domains on sync state
Date:   Mon, 27 Mar 2023 22:38:25 +0300
Message-Id: <20230327193829.3756640-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

V2 (RFC) of this patchset was here:
https://lore.kernel.org/all/20230320134217.1685781-1-abel.vesa@linaro.org/

Changes since v2:
 * renamed genpd_queue_power_off_work to pm_genpd_queue_power_off and added
   comment about its purpose w.r.t. it being exported.
 * added the qcom_cc generic sync state callback to all providers that
   register GDSCs, instead of SM8450 and SC8280XP

Changes since v1:
 * Added the qcom_cc sync state callback which calls in turn the gdsc one
 * dropped extra semicolon from pm_domain.h

Abel Vesa (4):
  PM: domains: Allow power off queuing from providers
  soc: qcom: rpmhpd: Do proper power off when state synced
  clk: qcom: gdsc: Avoid actual power off until sync state
  clk: qcom: Add sync state callback to all providers

 drivers/base/power/domain.c            | 18 ++++++++++--------
 drivers/clk/qcom/apss-ipq6018.c        |  1 +
 drivers/clk/qcom/camcc-sc7180.c        |  1 +
 drivers/clk/qcom/camcc-sc7280.c        |  1 +
 drivers/clk/qcom/camcc-sdm845.c        |  1 +
 drivers/clk/qcom/camcc-sm6350.c        |  1 +
 drivers/clk/qcom/camcc-sm8250.c        |  1 +
 drivers/clk/qcom/camcc-sm8450.c        |  1 +
 drivers/clk/qcom/common.c              | 19 +++++++++++++++++++
 drivers/clk/qcom/common.h              |  2 ++
 drivers/clk/qcom/dispcc-qcm2290.c      |  1 +
 drivers/clk/qcom/dispcc-sc7180.c       |  1 +
 drivers/clk/qcom/dispcc-sc7280.c       |  1 +
 drivers/clk/qcom/dispcc-sc8280xp.c     |  1 +
 drivers/clk/qcom/dispcc-sdm845.c       |  1 +
 drivers/clk/qcom/dispcc-sm6115.c       |  1 +
 drivers/clk/qcom/dispcc-sm6125.c       |  1 +
 drivers/clk/qcom/dispcc-sm6350.c       |  1 +
 drivers/clk/qcom/dispcc-sm6375.c       |  1 +
 drivers/clk/qcom/dispcc-sm8250.c       |  1 +
 drivers/clk/qcom/dispcc-sm8450.c       |  1 +
 drivers/clk/qcom/dispcc-sm8550.c       |  1 +
 drivers/clk/qcom/gcc-apq8084.c         |  1 +
 drivers/clk/qcom/gcc-ipq806x.c         |  1 +
 drivers/clk/qcom/gcc-ipq8074.c         |  1 +
 drivers/clk/qcom/gcc-mdm9615.c         |  1 +
 drivers/clk/qcom/gcc-msm8660.c         |  1 +
 drivers/clk/qcom/gcc-msm8909.c         |  1 +
 drivers/clk/qcom/gcc-msm8916.c         |  1 +
 drivers/clk/qcom/gcc-msm8939.c         |  1 +
 drivers/clk/qcom/gcc-msm8953.c         |  1 +
 drivers/clk/qcom/gcc-msm8960.c         |  1 +
 drivers/clk/qcom/gcc-msm8974.c         |  1 +
 drivers/clk/qcom/gcc-msm8976.c         |  1 +
 drivers/clk/qcom/gcc-msm8994.c         |  1 +
 drivers/clk/qcom/gcc-msm8996.c         |  1 +
 drivers/clk/qcom/gcc-msm8998.c         |  1 +
 drivers/clk/qcom/gcc-qcm2290.c         |  1 +
 drivers/clk/qcom/gcc-qcs404.c          |  1 +
 drivers/clk/qcom/gcc-qdu1000.c         |  1 +
 drivers/clk/qcom/gcc-sa8775p.c         |  1 +
 drivers/clk/qcom/gcc-sc7180.c          |  1 +
 drivers/clk/qcom/gcc-sc7280.c          |  1 +
 drivers/clk/qcom/gcc-sc8180x.c         |  1 +
 drivers/clk/qcom/gcc-sc8280xp.c        |  1 +
 drivers/clk/qcom/gcc-sdm660.c          |  1 +
 drivers/clk/qcom/gcc-sdm845.c          |  1 +
 drivers/clk/qcom/gcc-sdx55.c           |  1 +
 drivers/clk/qcom/gcc-sdx65.c           |  1 +
 drivers/clk/qcom/gcc-sm6115.c          |  1 +
 drivers/clk/qcom/gcc-sm6125.c          |  1 +
 drivers/clk/qcom/gcc-sm6350.c          |  1 +
 drivers/clk/qcom/gcc-sm6375.c          |  1 +
 drivers/clk/qcom/gcc-sm7150.c          |  1 +
 drivers/clk/qcom/gcc-sm8150.c          |  1 +
 drivers/clk/qcom/gcc-sm8250.c          |  1 +
 drivers/clk/qcom/gcc-sm8350.c          |  1 +
 drivers/clk/qcom/gcc-sm8450.c          |  1 +
 drivers/clk/qcom/gcc-sm8550.c          |  1 +
 drivers/clk/qcom/gdsc.c                | 26 ++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h                |  6 ++++++
 drivers/clk/qcom/gpucc-msm8998.c       |  1 +
 drivers/clk/qcom/gpucc-sc7180.c        |  1 +
 drivers/clk/qcom/gpucc-sc7280.c        |  1 +
 drivers/clk/qcom/gpucc-sc8280xp.c      |  1 +
 drivers/clk/qcom/gpucc-sdm660.c        |  1 +
 drivers/clk/qcom/gpucc-sdm845.c        |  1 +
 drivers/clk/qcom/gpucc-sm6115.c        |  1 +
 drivers/clk/qcom/gpucc-sm6125.c        |  1 +
 drivers/clk/qcom/gpucc-sm6350.c        |  1 +
 drivers/clk/qcom/gpucc-sm6375.c        |  1 +
 drivers/clk/qcom/gpucc-sm8150.c        |  1 +
 drivers/clk/qcom/gpucc-sm8250.c        |  1 +
 drivers/clk/qcom/gpucc-sm8350.c        |  1 +
 drivers/clk/qcom/lcc-ipq806x.c         |  1 +
 drivers/clk/qcom/lpassaudiocc-sc7280.c |  1 +
 drivers/clk/qcom/lpasscc-sc7280.c      |  1 +
 drivers/clk/qcom/lpasscorecc-sc7180.c  |  2 ++
 drivers/clk/qcom/lpasscorecc-sc7280.c  |  2 ++
 drivers/clk/qcom/mmcc-apq8084.c        |  1 +
 drivers/clk/qcom/mmcc-msm8974.c        |  1 +
 drivers/clk/qcom/mmcc-msm8994.c        |  1 +
 drivers/clk/qcom/mmcc-msm8996.c        |  1 +
 drivers/clk/qcom/mmcc-msm8998.c        |  1 +
 drivers/clk/qcom/mmcc-sdm660.c         |  1 +
 drivers/clk/qcom/videocc-sc7180.c      |  1 +
 drivers/clk/qcom/videocc-sc7280.c      |  1 +
 drivers/clk/qcom/videocc-sdm845.c      |  1 +
 drivers/clk/qcom/videocc-sm8150.c      |  1 +
 drivers/clk/qcom/videocc-sm8250.c      |  1 +
 drivers/soc/qcom/rpmhpd.c              | 19 +++++++------------
 include/linux/pm_domain.h              |  4 ++++
 92 files changed, 161 insertions(+), 20 deletions(-)

-- 
2.34.1

