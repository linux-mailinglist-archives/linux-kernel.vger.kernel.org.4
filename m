Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7570C706713
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjEQLqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjEQLqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:46:46 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F015340DB
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:46:44 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52079a12451so413010a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684324004; x=1686916004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RFzuu4N5fQjgRDDnnSeSZLGRU4lI0OQgLcecIxUQhiw=;
        b=zbIyMbv7Wj7QKL0JlRXH1I1LWAzjbwqYQZELjaaH5JBLnOMywqLLxlnqGGz90Nv0YD
         cOaR0Vx97w3xYx/z/lHkW5pzUvjdB+AJHz65heCAKNVgbhqhKDxsJSjSjytEebiU2iHD
         51P7j7JRY8echQFn1xXxQG9WyTGTCOn2WxfOMSukSGGugX8Ml1+Bqyk9eTQ/P/OfAdqH
         VUMfS2zM7xQOBj0hjfUYpc5NVV9GYPgw4FUDMfeyNQohgzo9d5MoosOeuSC8wySKOu4b
         yUSLoKvwWrXwQLSRFvboh2RvJPVo3mHI/VzPCGrcjWwK6mKvOoLEkOTtbX1Z0bZrMEA2
         2XgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684324004; x=1686916004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFzuu4N5fQjgRDDnnSeSZLGRU4lI0OQgLcecIxUQhiw=;
        b=MFrljjgkHV1Z9oPh8FFKVgDb8EWKXLaq6L3EK6hFvEahf1lvftGrbS8WEeAqS3xoIj
         ORqX3G8r2OpDHSxwDqEFOo2rZBRLfIV0s9ehjHjtBd4sTBeIKOfczSpCl0ccjthI9dXd
         Ce8odRlZAf3x6nPGiii1ch5RQp/93ixHPs/s9QDTx3n4dOWgi09mGy9sU9wRVOqpno+4
         gntXTvz+M34W11V153Ulvq6o9QErfxJqI9hO6LrlICQt3wbUuNVfuCUo5TuAYD71HQYx
         cwGd1OnNldRqBNKUNCPAHQ92ED81/X/iaDNQIeiIa0mcSKGDAbSzyBngmTmIEdSp6X8j
         dYIA==
X-Gm-Message-State: AC+VfDyGlLXd0QffCCuTSetuURNYnPd/VhcZtWmSmZrDWVmHvmd8mSfM
        p/UC8X2DGQrlmdSg3litoEdn
X-Google-Smtp-Source: ACHHUZ6fMetp6J+mojm2mXSpPEDIeSGJUTqYYffReV3Lh5yumI/isAX6OLVOH1wtaSGSvIEsoPXaDQ==
X-Received: by 2002:a17:90a:de91:b0:24b:2f85:13eb with SMTP id n17-20020a17090ade9100b0024b2f8513ebmr39318239pjv.30.1684324004344;
        Wed, 17 May 2023 04:46:44 -0700 (PDT)
Received: from localhost.localdomain ([117.207.26.28])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090aba0c00b0025289bc1ce4sm1366971pjr.17.2023.05.17.04.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:46:43 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v8 0/2] Fix crash when using Qcom LLCC/EDAC drivers
Date:   Wed, 17 May 2023 17:16:33 +0530
Message-Id: <20230517114635.76358-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

Thanks,
Mani

Changes in v8:

* Collected Ack
* Modified the patch 1/2 to remove the ret variable initialization

Changes in v7:

* Rebased on top of v6.4-rc1

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
  EDAC/qcom: Remove superfluous return variable assignment in
    qcom_llcc_core_setup()
  EDAC/qcom: Get rid of hardcoded register offsets

 drivers/edac/qcom_edac.c           | 118 ++++++++++++++---------------
 include/linux/soc/qcom/llcc-qcom.h |   6 --
 2 files changed, 59 insertions(+), 65 deletions(-)

-- 
2.25.1

