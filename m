Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6569362BBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbiKPL2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239335AbiKPL1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:27:08 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601C849B47
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:17:50 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso1209429wmp.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uJNbm/BEq4BvvQJ4DuY+WTXZwxIzZg57cNF+UvFbOgQ=;
        b=UvOPKeUkvHAHNER8lGOSCTiFAHtG2KmO2hU6Wr09tjcNAIHiT5WOaLrQ7dh0qeAOix
         fcgxSz7naOCBEGS3K8BVRLNaA2Slymjnz8+iDIJfafGXweRJl4uR1BE7Tm0DMIUalrwJ
         qPbb+P5scivk1Ulj/IOwsK3fC3DQOaElqjsilXl0UHE86xw+LtTcSsjmqIYKXzbkFcEV
         xMNQRv/uCmG/pflYhpZFmlZI51i2dq2ziUsPOgQGy1KWp9a1L+xpNrgrpnz1Yway+LpV
         CnoORtUIJY5mMBFH2G6LA3cGReWag+wrfGjTiWHDA+WjWKgcRxQOWb9KDTGqUPZBByAQ
         pA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJNbm/BEq4BvvQJ4DuY+WTXZwxIzZg57cNF+UvFbOgQ=;
        b=2qNoJJwoM7FaNkX4E2MgqNSPWcTp6KyxD7tOKKDhasw8ycsBLxsG0lcCVCWIL5ufeF
         RwqxD9/NWDD/tmHjAzNb39iYq58VPJFItG0GHi9syCo4dOG8uWx9eTjYs/h+nj1RVJ3s
         pMqeSOnuR7Ef7DeLyI/AUq83/v+JeMW+rEnhYirgCwg9SKxJsrwENFMwUb1p/aVX6cHj
         gwm6/divSl3gGxQYpsNNXWMS9TVaKmTCFAHi9Fh32gn0I2DYQbIiUJRVWl66UBdjb8xE
         s3jt2VxIj21FOUkOv45YCZ1tjJln6IxMQzU5pf94WV33sTpgfhYhuMCBbsOdhkJTAdzq
         Ak3w==
X-Gm-Message-State: ANoB5pkRULcUmllhtdKSucI6ZQOQVfth5r9qec6lQvppkavv+zvHaE/5
        pJZHV3oS31FEhXsHlYPCiTMBCg==
X-Google-Smtp-Source: AA0mqf4EfVmC3Ny/bNTCXXIYrw8XbIEbanKNFwWg+XY5cSND/ooSla/q7HqiZKwf5xpEezo5rxl5JQ==
X-Received: by 2002:a05:600c:54ec:b0:3cf:8443:e4a with SMTP id jb12-20020a05600c54ec00b003cf84430e4amr1838789wmb.27.1668597468977;
        Wed, 16 Nov 2022 03:17:48 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b003c6f8d30e40sm1875870wmq.31.2022.11.16.03.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:17:48 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/2] soc: rpmhpd: Add support for SM8550
Date:   Wed, 16 Nov 2022 13:17:43 +0200
Message-Id: <20221116111745.2633074-1-abel.vesa@linaro.org>
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

This patchset adds RPMh power domains support for the new
Qualcomm SM8550 SoC.

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

Abel Vesa (2):
  dt-bindings: power: rpmpd: Add SM8550 to rpmpd binding
  soc: qcom: rpmhpd: Add SM8550 power domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
 drivers/soc/qcom/rpmhpd.c                     | 24 +++++++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h        | 16 +++++++++++++
 3 files changed, 41 insertions(+)

-- 
2.34.1

