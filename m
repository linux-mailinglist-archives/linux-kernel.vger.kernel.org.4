Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9683B65129E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiLSTPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiLSTOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:14:54 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C481712AD0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:14:36 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id x2so9937837plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SQhg0NSz5mlnCPO3K0PCMWHFrY33VuwoGFY045s+FpA=;
        b=JZuSN9JQkUgss4MTccfEIIrdbFuZLj3W1ryQFBCodnTgcC4jk0crPHZ+TDOzv+76lA
         w7bGEVZsQrkv/R4dZDI8p0jJwKaP2C7BM3s8g1oka9cUGG29ZxfCvjrawe7/LrEAOv0Q
         B03UCBXwVfAKv1WLLomvtNyPTKK3V4J4jw1zGgP3yK8I18hZEZ3L+qKTVSfyV4fOGRlC
         npiDlYhArZyy4oRz+mp/DbJgpJntvdJO+D35Do+BWWk3liEeg+t8Cjv+fhGmZFm4XnZO
         VwzfWdisd9e2y/erw0QhWMZTKr1SnP1Ahz7kZcB5HKl+J271hrEp2B+FsAruCo4HEHBQ
         t51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQhg0NSz5mlnCPO3K0PCMWHFrY33VuwoGFY045s+FpA=;
        b=2D8MuhqF9QDmnzyKWASJYF130UA13EQYwhOCyYFaXTsBc4H529G1mCjHFqEV/iQ5J5
         8WE3tLcXEKrFPNKt2myMIAS8T7AClfepS4czH3gimFvLCYDWZbkalVzIsYiKC1fFwczT
         CWLLakvOQQZi0Te6CChV5mOI0UPZ56p1Y1cWLCqyjbMjqK68+OV6gpwy2Obv8dnvx5/O
         PEf55rtogtqRnwnUOveFQgy3cRNrMo8UfNbaFfESkqvTsmlzAM6Hhu244ldWR7fvbnjB
         zk8+7baJt4Asqi4urrfY5G4GPltS81n5nXhsRf42SDP4NW0jC3fGR3PM5X4E6Hmg5ry4
         NCXA==
X-Gm-Message-State: AFqh2krQuasvn5wP7cQ6DOETGfM63dItkIgP0U37kz3ITcT6llHe1SXF
        K27nKDnu3d3HxrmKtLnwyGW7
X-Google-Smtp-Source: AMrXdXvBJf3R3LEsIAilhll3hPKKv8RniteyINH36Qdj9N0SVSS+H7ZcHgBd22/g9KjtVy3lSAlV6g==
X-Received: by 2002:a17:90a:b384:b0:213:b6c8:2295 with SMTP id e4-20020a17090ab38400b00213b6c82295mr10254424pjr.22.1671477276293;
        Mon, 19 Dec 2022 11:14:36 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.17])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090a66c400b001f94d25bfabsm9485803pjl.28.2022.12.19.11.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:14:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bhelgaas@google.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] Qcom: Add GIC-ITS support to SM8450 PCIe controllers
Date:   Tue, 20 Dec 2022 00:44:24 +0530
Message-Id: <20221219191427.480085-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Hello,

This series adds GIC-ITS support to SM8450 PCIe controllers for receiving
the MSIs from endpoint devices.

The GIC-ITS MSI implementation provides an advantage over internal MSI
implementation using Locality-specific Peripheral Interrupts (LPI) that
would allow MSIs to be targeted for each CPU core.

This series has been tested on SM8450 based dev board that works using an
out-of-tree dts where the MSIs from endpoint devices are distributed across
the CPU cores.

Thanks,
Mani

Manivannan Sadhasivam (3):
  dt-bindings: PCI: qcom: Update maintainers
  dt-bindings: PCI: qcom: Document msi-map and msi-map-mask properties
  arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0 and PCIe1

 .../devicetree/bindings/pci/qcom,pcie.yaml     | 18 ++++++++++++++----
 arch/arm64/boot/dts/qcom/sm8450.dtsi           | 12 ++++++------
 2 files changed, 20 insertions(+), 10 deletions(-)

-- 
2.25.1

