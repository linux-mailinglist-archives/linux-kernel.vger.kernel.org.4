Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1880C704548
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjEPG1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjEPG1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:27:07 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D68198D;
        Mon, 15 May 2023 23:27:07 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so12707901a12.0;
        Mon, 15 May 2023 23:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218426; x=1686810426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J/hLNN3H+lpepMaqTgLArXu+K/5Z87+b97kJZLWuHrw=;
        b=OEDwriibEMmE+wcy0oDS7CtPwvKCOmr/MZXOiwuixK6Ztzoio0Q7zmVPdwoSwE3hoE
         o5RlkQvJXCheWgHA6pOxXQu0n4/jKHO39GkpcPyr3pc+XPL6AIIwN97nJfLKFlfKkyo8
         HHqpmfQpU0GPm91zmKvG66gYkIpOch1CLBlEt2Pq1xcl1qXrj8siFGVezdx/tiidrHxm
         7rcSNI1NRJ/eXWRBU6yQ1gp45RfC23ZDfAeHhV0a5z2fnftPg+Q4sWiTkkCa78e2mB4g
         iymzeH98n2LuHPq+HT0XBtjIIjz+mKQ2g7bnJI65i8eVp4bHh5xP/IeCfjvrgtn9EB/n
         bcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218426; x=1686810426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/hLNN3H+lpepMaqTgLArXu+K/5Z87+b97kJZLWuHrw=;
        b=H+V1zHAbtlMYhd4xVdt1Zg+jAAeljGkL2ismMej/iUIQiyVRbh8drH9Jy9z/I+pgiQ
         FripAQMfw5obLSEbsOvhXIPnY00JDG+APerdpadKZxh9F+KBe4eEOGY2UMADoqLHxvoQ
         BK/PGQetvFD42GjIoFNOJwniLRKvlx7tanh4lg3sq879H7xermN3lM0d10LsKemAccJy
         CoxKDFbo7pXQ1Q2t1Vt1fWgxIGTWhP3ZnD7dARctiIaqFBZiL/UeFRby3ooHTXnInW9g
         m0MjRdKRe4udEYoa6P0xMzHVIsBj2ip2uuIRn1UbUGHldjHfvRKE+oDoca69KdjznV4+
         DQgA==
X-Gm-Message-State: AC+VfDxgoC37ZtAdxji6lRmA4957MynhbQOVdswo1t+j7V5j+74XSTCJ
        CmYbmdt+4nddwXqn9FqqfeU=
X-Google-Smtp-Source: ACHHUZ4ePe6mVpiWhceFcpuW5itW94mvZZseRbqudYhueRP7IMPA/WJ8v6jCFBN2/A0MXCCuNx3i2g==
X-Received: by 2002:a17:903:234c:b0:1ab:289f:65cf with SMTP id c12-20020a170903234c00b001ab289f65cfmr48674930plh.54.1684218426470;
        Mon, 15 May 2023 23:27:06 -0700 (PDT)
Received: from localhost.localdomain (n220246252240.netvigator.com. [220.246.252.240])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902da9200b001aaea7bdaa7sm14579710plx.50.2023.05.15.23.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:27:05 -0700 (PDT)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jianhua Lu <lujianhua000@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND,PATCH 1/3] arm64: dts: qcom: sm8250-xiaomi-elish-boe: fix panel compatible
Date:   Tue, 16 May 2023 14:26:55 +0800
Message-Id: <20230516062657.28616-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

The bindings expect "novatek,nt36523" fallback in the panel compatible:

  sm8250-xiaomi-elish-boe.dtb: panel@0: compatible: ['xiaomi,elish-boe-nt36523'] is too shor

Fixes: 51c4c2bd6f31 ("arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add mdss and dsi panel")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
index 8b2ae39950ff..de6101ddebe7 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
@@ -13,6 +13,6 @@ / {
 };
 
 &display_panel {
-	compatible = "xiaomi,elish-boe-nt36523";
+	compatible = "xiaomi,elish-boe-nt36523", "novatek,nt36523";
 	status = "okay";
 };
-- 
2.39.3

