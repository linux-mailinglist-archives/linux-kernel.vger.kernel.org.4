Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C96E73E2A2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjFZPAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjFZPAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:00:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FC712E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:00:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3113da5260dso2903678f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687791604; x=1690383604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ysbiVMlRUPpmijvxEgiqELqD4pocrI8KujWeqKckrNk=;
        b=rxS+vi8VhGBDXLjpUQcsEhtzPnyVlg1GpEc72GOwk1v07t5i1xxdc4FvqFuJPThvnc
         6tw0DaAPUYNCpOVkWW1maSwwu4be/ugnVKpuYrQtw7mYqtLCRnLYstsXEGgz1/zG0R6i
         JrEPstX17B7jx2V/aJbePsMziYnB+26omlQ0wbAABSllNmOIo44VDPFrOR+Dra9XQHZE
         PblvkvD/5/bogBc6PrYgJ1x3bahrGFlEhPBmlX8hhMbxhDpRtrQ8vYrqtxzwFJ98UoUx
         zfBycvUU0ukCpc2xTKq4M7932LqCa9ob01W3o3QVpFn7Bs/RLthho8a6Rg1EisyGfkI2
         lrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687791604; x=1690383604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysbiVMlRUPpmijvxEgiqELqD4pocrI8KujWeqKckrNk=;
        b=jfiSdjyiExSTZPDw0a8fdw1PekGQqX204M1nPVHM0dBVWMKRrMn1bHonIdb8sYHQOY
         zciOvbdOxy4bvyiczpLyBz9smCbrgp0i6czCnyj2Q+P0r8jEByB0jsqSJeofB9rCWKiH
         jNJSDroiXTxQtgW1V9wbiiXifkwWnFNdbh3rtXEZt0aCxonkDPvSzTKvHNgkcZEj4PJ+
         p0ggjHVjVcOq+6vUJUvhBCnvc/mI1nh/ejhbZi21OcBtQ4gM/4NHhqb/WQ7euXg7aDMY
         CZcdv6BUqOTx5dGujncbJzSDYcnJ8+En6Rsu+WcZKhlrv1MGS5JGB9jWecw1JAb7+rSV
         x8Dg==
X-Gm-Message-State: AC+VfDx+gjq9BfqloAHoIVi2OZlXuSV/3bHMKt9X5nfvI5dpw9XW8eV7
        eH7u8XNnDLqqUBMw3FpksTb/Kg==
X-Google-Smtp-Source: ACHHUZ7udFgKBee119WAQc9HfTv87IIlEp5QgIr91900E3CZgGj828TfAtq4gdInkQIw8Q/mNE+WyQ==
X-Received: by 2002:a5d:4ad0:0:b0:313:f98a:1fd3 with SMTP id y16-20020a5d4ad0000000b00313f98a1fd3mr29021wrs.27.1687791603958;
        Mon, 26 Jun 2023 08:00:03 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m16-20020a5d6250000000b003068f5cca8csm7585484wrv.94.2023.06.26.08.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:00:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2] arm64: dts: qcom: sm8350: fix BAM DMA crash and reboot
Date:   Mon, 26 Jun 2023 16:59:59 +0200
Message-Id: <20230626145959.646747-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8350 HDK and MTP boards were silently dying and rebooting during BAM
DMA probe, probably during reading BAM_REVISION register:

  [    1.574304] vreg_bob: Setting 3008000-3960000uV
  [    1.576918] bam-dFormat: Log Type - Time(microsec) - Message -
  Optional Info
  Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
  S - QC_IMAGE_VERSION_STRING=BOOT.MXF.1.0-00637.1-LAHAINA-1
  S - IMAGE_VARIANT_STRING=SocLahainaLAA
  S - OEM_IMAGE_VERSION_STRING=crm-ubuntu77
  S - Boot Interface: UFS

It seems that BAM DMA is not yet operational, thus mark it as failed and
disable also QCE because it won't work without BAM DMA.

Fixes: f1040a7fe8f0 ("arm64: dts: qcom: sm8350: Add Crypto Engine support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Disable the nodes instead of failing the probe. Due to this change,
   no Reviewed/Tested tags.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 88ef478cb5cc..ec451c616f3e 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1744,6 +1744,8 @@ cryptobam: dma-controller@1dc4000 {
 			qcom,controlled-remotely;
 			iommus = <&apps_smmu 0x594 0x0011>,
 				 <&apps_smmu 0x596 0x0011>;
+			/* FIXME: Probing BAM DMA causes some abort and system hang */
+			status = "fail";
 		};
 
 		crypto: crypto@1dfa000 {
@@ -1755,6 +1757,8 @@ crypto: crypto@1dfa000 {
 				 <&apps_smmu 0x596 0x0011>;
 			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
 			interconnect-names = "memory";
+			/* FIXME: dependency BAM DMA is disabled */
+			status = "disabled";
 		};
 
 		ipa: ipa@1e40000 {
-- 
2.34.1

