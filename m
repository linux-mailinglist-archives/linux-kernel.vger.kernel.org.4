Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7664365741F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 09:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiL1Imj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 03:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiL1Il6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 03:41:58 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D177B10057
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:41:36 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f3so10194185pgc.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GFA6I79C1YmmOYQX1BIX7MOGuUjMMgmSjlJ7uhFCjc=;
        b=kW/WrjOWRlX5MKh1BPZ4cXc5hc/bKSSEGcp2PXOUo2es5F10/wYS4gPlhOP6Ag+TWH
         eZFdWMexS1F5KQc4XKr8auMDT2nf/td0WUOrpKUJW8UK7LGkLoGyVW53MLV/rGQTwyzd
         0PGEV2e/SDy4luCRc24OkAkwv4o5kKLi5pwOvMqZpfqlriOlicJrFCZQUsazH2cjc8Qn
         DPYjUlY/9hnhqjWpjyPT4R3ZpwtjDchZKTauIFAH0bro94vUSUVTGf8/vJ0bIxostFx7
         nIxYTpry7XX2mhOomqnXBfoFeXuuthoGzHr9+s8GMZLhI43iUWDfYAzotk12Kq1g3vbx
         oCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GFA6I79C1YmmOYQX1BIX7MOGuUjMMgmSjlJ7uhFCjc=;
        b=OwN1LTmt6mfl7AeAAUz4GyNdo4ZfVXd8SzkLzHgX6USBnhV4TQVxKwE6WIsHvPLlCV
         WvspTe4VhIvE1Ybyi7ywjEz9/iXEFlzRMmHFBubmMOozHeYy/KJjg4WGMFDn8sICSE5p
         0gJuX5HdSSFyfbjBIjr5pwQ+Jf/VLaZPK0B0cSA+PqWsynDk3r4KGuoJswjRY3NLBY1i
         b1ZAfmojRjNRpP4r76H66YrCfDlLQOknG6mg5k7oEQHBnmJEE/7Hh072IUajbjktwrHu
         QZz1ZX2catQBsp4q0mB/dHaoavymPBGuFINC4JbagjqwQHAyaJs78YrUJ80MXPBDc7cu
         YR0Q==
X-Gm-Message-State: AFqh2kpyEKpz20uZ103cx3EliyP8yqZojyrqRMHluG1gpn+asbKBi0V/
        gUeHWQyJzs5YbHFoYxmXbCVg
X-Google-Smtp-Source: AMrXdXsHMZKjsZPtwSaCA4yciZsfAMRUTiPiFIMBgtJ2CyJ6XFGBh135+6ARBuEBVQC24ILKicoVRQ==
X-Received: by 2002:aa7:8c56:0:b0:576:f89d:2c4b with SMTP id e22-20020aa78c56000000b00576f89d2c4bmr38550576pfd.32.1672216896063;
        Wed, 28 Dec 2022 00:41:36 -0800 (PST)
Received: from localhost.localdomain ([117.217.178.73])
        by smtp.gmail.com with ESMTPSA id d188-20020a6236c5000000b0057a9b146592sm9786286pfa.186.2022.12.28.00.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 00:41:34 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 07/17] arm64: dts: qcom: sc7180: Fix the base addresses of LLCC banks
Date:   Wed, 28 Dec 2022 14:10:18 +0530
Message-Id: <20221228084028.46528-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LLCC block has several banks each with a different base address
and holes in between. So it is not a correct approach to cover these
banks with a single offset/size. Instead, the individual bank's base
address needs to be specified in devicetree with the exact size.

On SC7180, there is only one LLCC bank available. So let's just pass that
as "llcc0_base".

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index f71cf21a8dd8..f861f692c9b1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2759,7 +2759,7 @@ dc_noc: interconnect@9160000 {
 		system-cache-controller@9200000 {
 			compatible = "qcom,sc7180-llcc";
 			reg = <0 0x09200000 0 0x50000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg-names = "llcc0_base", "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

