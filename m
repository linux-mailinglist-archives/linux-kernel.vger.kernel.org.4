Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E7C6B8B66
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCNGkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjCNGkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:40:45 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8986696C20
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:40:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so5004045pjv.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678776041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=95XeM0miGBKUUWA0DgU6Gm2TVGYxwlhZNsyVIVOo//0=;
        b=S/H7gZ9VaHzF4gRhl0MN6iAS7CAFT/D11lbRNt5CIA8JA3AOB+2mME3TcIWu5x/yxP
         dA9tQ/BRUM8XIT8plGibFo6EwhUJ9bPCA5yXnd+SD+FCUU8v/YLt/d/sUAtAskZzirU3
         JXTT41pxY70dQbG2jegyQ6Vy9ItgDsiGAuJRxRP788Lmn6EYGR3Kgtk7Jh4zWyROYywJ
         vjG3B6LD0XhS+XmYTvVOIdmcu48FNjyC3KYhJT2U0myDGtLMTDaCD+CeW7812We2lw4b
         +UzzTMeMX6i2nuDjc47OhjDfFYWv4Dn83i9kvsuD52OLLb1v4vmE0jhd6ubjyt70bj+P
         nl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678776041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95XeM0miGBKUUWA0DgU6Gm2TVGYxwlhZNsyVIVOo//0=;
        b=JK4u/O34exAjhbewgM3csR3pvv5PI3Ig/sN4ASmH+Q+cmE7l3dnL99hMRZ23pKuKJn
         uX1a8OuZlN6KADioBIRk1pCb9fQo0JBLvsxlPPLvyz/Mghwmy+a4bvQMYJhtOyu/DwHa
         B47t96QRReCWfLpUugGLGgV8gMZFsMOYUpf6u0gQkJg+X//9Z6XOkxJbWfTwKlMRRhcM
         KjivZJqfL1yvYc6ccVu34c3eBIpm7qz/H2ALJSwMR9QibXqzS9GjEZYWs8YoSkdfr0ej
         S7ldC+BpHO7ZCb2y1rwVJEdZQ1/EMqSqV2/sCtPu4ApoxjJd0nL96V7ggMSJugiUlpc8
         HQxA==
X-Gm-Message-State: AO0yUKXlNcVn06A8HoHOSQj/QB2GyZpcX0NuPAotDtnfjvamyt3+ATn6
        jkHfRMyrecakBkMxP+XtBAbh
X-Google-Smtp-Source: AK7set+5S+GItfeGaV+EnZIeHmZFT8MZxkUeY1h0nq2mUniQ5gPF9oRAB/y52DUCdBxDB7u7IFWqvw==
X-Received: by 2002:a17:90a:540d:b0:23d:382e:992d with SMTP id z13-20020a17090a540d00b0023d382e992dmr1232656pjh.7.1678776040948;
        Mon, 13 Mar 2023 23:40:40 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id l15-20020a170902f68f00b0019f363ed8c0sm897497plg.226.2023.03.13.23.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 23:40:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_saipraka@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 0/2] Fix crash when using Qcom LLCC/EDAC drivers
Date:   Tue, 14 Mar 2023 12:10:30 +0530
Message-Id: <20230314064032.16433-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series fixes the crash seen on the Qualcomm SM8450 chipset with the
LLCC/EDAC drivers. The problem was due to the Qcom EDAC driver using the
fixed LLCC register offsets for detecting the LLCC errors.

This seems to have worked for SoCs till SM8450. But in SM8450, the LLCC
register offsets were changed. So accessing the fixed offsets causes the
crash on this platform.

So for fixing this issue, and also to make it work on future SoCs, let's
pass the LLCC offsets from the Qcom LLCC driver based on the individual
SoCs and let the EDAC driver make use of them.

This series has been tested on SM8450 based dev board.

Merging Strategy
================

Since there is another series under review [1] for reworking the LLCC/EDAC
base address along with dts patches, it is better to funnel this series too
through Qcom tree.

Thanks,
Mani

[1] https://lore.kernel.org/linux-arm-msm/20230314053725.13623-1-manivannan.sadhasivam@linaro.org/

Changes in v6:

* Rebased on top of v6.3-rc1
* Dropped the Kconfig patch that got applied

Changes in v5:

* Added fixes tag and CCed stable mentioning the dependency
* Added a patch to fix the build error with COMPILE_TEST

Changes in v4:

* Dropped the patches that were already applied
* Rebased on top of v6.1-rc5

Changes in v3:

* Instead of using SoC specific register offset naming convention, used
  LLCC version based as suggested by Sai
* Fixed the existing reg_offset naming convention to clearly represent
  the LLCC version from which the offsets were changed
* Added Sai's Acked-by to MAINTAINERS patch
* Added a new patch that removes an extra error no assignment

Changes in v2:

* Volunteered myself as a maintainer for the EDAC driver since the current
  maintainers have left Qualcomm and I couldn't get hold of them.

Manivannan Sadhasivam (2):
  EDAC/qcom: Remove extra error no assignment in qcom_llcc_core_setup()
  EDAC/qcom: Get rid of hardcoded register offsets

 drivers/edac/qcom_edac.c           | 119 ++++++++++++++---------------
 include/linux/soc/qcom/llcc-qcom.h |   6 --
 2 files changed, 59 insertions(+), 66 deletions(-)

-- 
2.25.1

