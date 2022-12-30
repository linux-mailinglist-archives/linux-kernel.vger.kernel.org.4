Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF90A659A51
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiL3QCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiL3QBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 11:01:44 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C27FC6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 08:01:44 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j17so22742938lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 08:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VGfyma8Qn7sSFvu2zSEpMZKY5/A9O53T6J2YqTZdXjc=;
        b=NsYdUEiXhzDWEhPP3sA+t1ou6d7qZpKv5r/C8chTf2MbxUME5Rg44kJBQZSyEvVyFl
         mt7oKYgToWrzQSasHWqRkSNKDfDyDqrteEhgykX6+AWLJ4XdU3ABZUkX0vqV1TY22qSG
         hdilPwDlNjCLlKMU79bIL365cRvLXGUhzRRjsqCrxmD4Ohl3AT1bKdYTrXVWTxAmVTAw
         DUXWDJFbPVL3BLO9rNQose7Ag3cC5nE3Kjf6c3RT16m0MtBHLfwjKBI3ATDRyrrsMLOH
         Yi9hiWARm8DLOFA/rZ4gSlf4GNcgwJxwiFffGDx/UcImFQFbBhjv9OoJXDFAYvzYrEwV
         Py3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGfyma8Qn7sSFvu2zSEpMZKY5/A9O53T6J2YqTZdXjc=;
        b=P72VGdEW/dwJ4xjpnTOw8L1vh75pTUkflQh8HNF2EbfCRSlxrgWe91od6eokRPJ043
         kFLEbmG2vj42oY4S0KRgD3mZ+ynGIWVpiKsZh8adWa4QRpdEYCzvTba0chpWEbF7nLrX
         LrJtyi/eI6w7yWuY6OyGoCyzdaOYMd3eOQavkWs6SR+nTKePks9ma9Y8IBY2c7lMAlnH
         7EfR70APQKKuK/mJoBGmf/n3MW7hnsPxMbjWAoPyWw3DgdTLYN2t3RN54678IYMU1LH6
         hGxe+O/akdMQS4QO9ly5R1FAviHrGYpxLsIH0TzWHKBciRyUOu41A2Nspp53eI9xEfeV
         VUgg==
X-Gm-Message-State: AFqh2koaSgAnu1AM8PjQ5YdxtJqhy2EpgY94rZ+CcqPQT6iPo4uLXkfy
        bkOA147NUyGOVj+Ui2QjQiwWpA==
X-Google-Smtp-Source: AMrXdXtPr6GRbIJtyKEHHxHJ4KM4PlNxVGE1BeXMpC5H5rLaL7uaPuFYwHKhVCKjpecLilQclnHJ2w==
X-Received: by 2002:a05:6512:31c5:b0:4b0:25f9:14ea with SMTP id j5-20020a05651231c500b004b025f914eamr10669569lfe.21.1672416102378;
        Fri, 30 Dec 2022 08:01:42 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p1-20020ac24ec1000000b004b15bc0ff63sm3520874lfr.277.2022.12.30.08.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 08:01:41 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/7] arm64: dts: qcom: sc8280xp: remove GCC from CX power domain
Date:   Fri, 30 Dec 2022 17:00:57 +0100
Message-Id: <20221230160103.250996-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings do not allow power-domain property in GCC clock controller and
documentation does not indicate that GCC is part of VDD_CX.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Maybe the bindings should be fixed? Maybe this was added as workaround?
Anyway looking at documentation I do not see such relation, except
downstream vdd_cx-supply (which is the same as in other SoCs and we do
not represent it in upstream).
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 1d1420c8720c..d14663c9f34c 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -799,7 +799,6 @@ gcc: clock-controller@100000 {
 				 <&pcie4_phy>,
 				 <0>,
 				 <0>;
-			power-domains = <&rpmhpd SC8280XP_CX>;
 		};
 
 		ipcc: mailbox@408000 {
-- 
2.34.1

