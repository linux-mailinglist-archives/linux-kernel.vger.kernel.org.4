Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284E3705FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjEQGYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjEQGYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:24:32 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6841A44A8
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:24:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2502346bea0so360087a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684304670; x=1686896670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6xI3hUbCW+FwBwOTtLOPQqL67ArdQOyuoW/lXxNMjQ4=;
        b=TjIOj1nxjzJLlVoNwu90CZ1Y7QDf9vJ3j9fmZdGp/f5B+A7/VApd9RRGZN2yRj1SFx
         Chx+iKhybZ/WOnhRRBFc/ZVJImxF1/nFkumey7JukfAfkzlYWYBVUBySfZQ+gSUcaDB3
         Iczqs2/QELdaztltVlzQHhj4CYPe0nj/yZL6a9sqY+B4/lKwVYSDLex1NkDwthxevCrn
         fkxxXO/EcUhKBS+EUafD/mQ6+A6QoKAetJoii6Ob+64/atgfC4fh7iRnB0KMnYb5GtU5
         OL0N86zMpy+PG3/ntLVUbKUGDX3M9AS2GlJ8SbGxZCyCoVx5CVQSUi6jUYQiSthTr7b/
         Riew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684304670; x=1686896670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xI3hUbCW+FwBwOTtLOPQqL67ArdQOyuoW/lXxNMjQ4=;
        b=dR5E2/N6yTgX08/YX5PUmZkfzkGiZe+WKtDOi6n12NW5pRidzUl+J9As2qMtstzYzy
         UN/1Pay+ba0HhUHKoz9cIO9epDs08d0Zu6F8b1de/qHHSSZHArILsKDs7/HdfGXKNN0l
         hCZjKb5WJia183gFK6gxOQQXu/rp3jkAHAgHApQQVfDPFrIXK5nuNVZXZg/fpmCct4+8
         a6fNosa9euAtncrZOZ2yhgN4K+mwXjcl6IpK8AjKFfll+/qz9jXRNO+CU0njf0ZCFf2J
         ztVt5MynB448vYurj0cW3GwN0pJTP040yIGyQv/ddU7yEVIaVjgJVgdfwB7yg/wO/3rf
         htkA==
X-Gm-Message-State: AC+VfDzYJ8BPJW0m8iDNKAjqrvmK9/2G4jFdq6yBPWSrx6EK/ssV4ipF
        ICYLDa9X5Rg7CGT+Affinf75
X-Google-Smtp-Source: ACHHUZ6bDqUMdz7zLfRy8rwKL/pK9Dv4oR14RRfhpSlxq+QKBxvIZ7pOILsD7PldWRxwGTi5sAPKgA==
X-Received: by 2002:a17:90a:6b43:b0:253:3ca1:4b8c with SMTP id x3-20020a17090a6b4300b002533ca14b8cmr2178520pjl.4.1684304669737;
        Tue, 16 May 2023 23:24:29 -0700 (PDT)
Received: from localhost.localdomain ([59.92.102.59])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090acb1600b002508f0ac3edsm693282pjt.53.2023.05.16.23.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:24:29 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 0/2] Fix crash when using Qcom LLCC/EDAC drivers
Date:   Wed, 17 May 2023 11:54:18 +0530
Message-Id: <20230517062421.56970-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

[1] https://lore.kernel.org/linux-arm-msm/20230314053725.13623-1-manivannan.sadhasivam@linaro.org/

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
  EDAC/qcom: Remove extra error no assignment in qcom_llcc_core_setup()
  EDAC/qcom: Get rid of hardcoded register offsets

 drivers/edac/qcom_edac.c           | 119 ++++++++++++++---------------
 include/linux/soc/qcom/llcc-qcom.h |   6 --
 2 files changed, 59 insertions(+), 66 deletions(-)

-- 
2.25.1

