Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9AA602FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiJRP3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiJRP3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:29:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B609ABC60E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:28:55 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g7so18248115lfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UIeALh8fZBeYzvBT8RoZsVBwMsxQV7EeSc9KIgaLlgw=;
        b=kpeH0bz9eRnfvvtktOE/T2E70VrhjVcvAeYSRRVAuMs3K+90aVYoqiuQ59jrW+LdFd
         i+UTvad4xLM5mVmwSn7MDZNhcJPxw3fbU8NExMK10+tKhX2dOvuE5CcR9brexP/Q1rpK
         IHuFiq5n+Qs0GVgMQn6VFHxwa4AyZ3vVrCphDa1It0LOL5ZbZSJe0HNIPXVF3d1N3m/o
         1yLr9kAiA+pWpTmMBthXUADD1UFkfp6UbPG+Ll2CxZZ8qjhcrJR0i1SEnl983IXnr5Fr
         7nVuFKGJuTotJ0b5JrQQhbc2rRZOM/K/hPgudVsiDUR2zZItUhhnkIgqLx69gXv8KIOG
         Be+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIeALh8fZBeYzvBT8RoZsVBwMsxQV7EeSc9KIgaLlgw=;
        b=ONApOVkmeMjrwql3So3pDTMeydi+qyf/N8m/Z6zmLaySUmMlXS1wvg56smo8kW/QTx
         6FPhOGCYJ4A2DwGDmj9A77eH2XcSv8JO7RpSOqXOFONl/t2XeHoFfEDUgQK9RjKxEypW
         q3adNeRZ4vV8a+sNgp8s+zZ9Cw+eNNlF2lmqC0t1Pl4XnDuvHRNr7w2QHatoojk9ecoP
         fIVVoWXkaadrUQu3hH9kIjP30DXMf2//TFVFnikLHWSFp0zA48NjJJ4eI54Q5nhvsfH5
         u0dA5K07rGfEiJFXE8586/yT7MoOjjFBL91Ewlc5/LjLqKb40LQ0CQpzT9N7GuHGcpea
         3Elg==
X-Gm-Message-State: ACrzQf0nrBXG2I9HFlxm72yGwNo6Wqct1uQf88eLH2k/arjcNI8I7JzX
        xKz8rA8AP2BJRiatc9cJTcImNg==
X-Google-Smtp-Source: AMsMyM60LIozWQYCRb+12A7XPwe4sg4aiqTqYnKiIOle1SX8YxcVPpsrIV+Humq3U19eHlORKp3lew==
X-Received: by 2002:a19:f80c:0:b0:4a4:5923:5174 with SMTP id a12-20020a19f80c000000b004a459235174mr1250336lff.151.1666106933561;
        Tue, 18 Oct 2022 08:28:53 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id a9-20020a05651c030900b0026ddd41aecasm1998617ljp.135.2022.10.18.08.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:28:52 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] soc: qcom: Add APSS RSC to the CPU cluster PM domain
Date:   Tue, 18 Oct 2022 17:28:31 +0200
Message-Id: <20221018152837.619426-1-ulf.hansson@linaro.org>
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

Changes in v3:
	- Re-worked the genpd patch (patch4) and updated the commit-msg.
	- No other changes.

The APSS RSC is a part of the CPU cluster PM domain and it's responsible for
flushing 'sleep' and 'wake' votes to avoid wasting energy. In particular, this
needs to be done when last CPU in the cluster enters a deeper idlestate.

To make this work, this series makes the APSS RSC device to become attached to
its corresponding CPU cluster PM domain, which are being managed by the
cpuidle-psci-domain through genpd.

More details are available in the commit messages for each patch.

Assuming there is an agreement to apply this, I suggest Bjorn to funnel this via
his qcom tree for v6.2.

Note that, there is also a related error report [1], [2], that this series
should be fixing. Although, as $subject series seems a bit too heavy for stable
kernels there's another minor workarounds in pipe [2] for 6.1-rc back to v5.18.

That said, we may then need to make a revert of [2] for v6.2, assuming it gets
merged for v6.1-rc[n].

Kind regards
Ulf Hansson

[1]
https://lore.kernel.org/linux-pm/07c29682-41d7-5624-b08a-35dd0c223d1e@linaro.org/

[2]
https://lore.kernel.org/linux-arm-msm/20221018145348.4051809-1-amit.pundir@linaro.org/


Lina Iyer (1):
  soc: qcom: rpmh-rsc: Attach RSC to cluster PM domain

Maulik Shah (5):
  dt-bindings: soc: qcom: Update devicetree binding document for
    rpmh-rsc
  arm64: dts: qcom: Add power-domains property for apps_rsc
  PM: domains: Store the next hrtimer wakeup in genpd
  soc: qcom: rpmh-rsc: Save base address of drv
  soc: qcom: rpmh-rsc: Write CONTROL_TCS with next timer wakeup

 .../bindings/soc/qcom/qcom,rpmh-rsc.yaml      |   5 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |   1 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |   1 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |   1 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |   1 +
 drivers/base/power/domain.c                   |  26 ++++
 drivers/base/power/domain_governor.c          |   3 +
 drivers/soc/qcom/rpmh-internal.h              |   9 +-
 drivers/soc/qcom/rpmh-rsc.c                   | 146 ++++++++++++++++--
 drivers/soc/qcom/rpmh.c                       |   4 +-
 include/linux/pm_domain.h                     |   7 +
 11 files changed, 188 insertions(+), 16 deletions(-)

-- 
2.34.1

