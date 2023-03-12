Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AC66B68D1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCLRfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCLRfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:35:03 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022EA28D1B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:35:02 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id da10so40015311edb.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678642500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RIh/Hblag8cnzqz8rq/TySc8lZL2yglYjsKAKBrZYCw=;
        b=IRsEk2tXUNyanAOhekWvhn/Ivkd3YJJ+NiMXDXeX3r5R4y4bUFdb3QpkMz+lZ0KhbH
         wz9kxBqFkmEDhkTW7lnsXmC7t76Mvvj+FzPchqByvkk8c0NbqrpBKKXZ8kEnt4neGsQ9
         LXxCjpGgv+v+e6Ir+4DYZvzfVO/r2pXLlS34IXODn3B0xcN57VmzfrflYQLyxxq9RJgA
         cz0KDjTMXf6/7gRsJmqzrvLRQkepi361VkiTj5/n5KICQhBxJObBTgSdkR+UmTwtgDaP
         zJ2Vas/noZSbCsOBpM7qW5guKjA9vU7kQ+nEl0i7ySTA1VOM3vdzRSP43plPIgL3B4Qy
         cWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678642500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIh/Hblag8cnzqz8rq/TySc8lZL2yglYjsKAKBrZYCw=;
        b=Q/X6klsHfnGI4Ccp3QcjJ52yjvkrlTWTy2lgsYaV/5D5YCFMc0R8ZVyUHh9mcZNpEk
         ncGuMer9saxDyvZ+8IGL6TCby963ZNPnHWn/jhhuHnEguuX26cP4MwN84weVts7V+XUR
         /NPwSMKF+oPFvZdYLbYGtR4xF6rTPohKGyUHfwUjVUEomaDYrp5wf0YM4I48c21qEWmK
         CPbU4e6wjUNAqkRJnJ6732K96Ia9oIe12h31h4fnCGMGGQIVikC4Ld14GQKEZgu7KK9w
         /eqKlKKLfeGX0q9la7uo52ImTZTtD51L49pQbZXSIHX5+r0pORm8N9OZeddXnHTxjAai
         RJEA==
X-Gm-Message-State: AO0yUKVj2gAaJGgn7p4IGyE6u/UHL0D2NIrW6WyhqBnZNRxrFqFCQPJN
        lhpWdtT1B0bP3bNQggitSEwilw==
X-Google-Smtp-Source: AK7set83spFsROfXcIe51agJSTsKdkPWKtewV2Jait57w3xtwEp6nGsWYr6UiyuBcVt6a9I6Ypx//A==
X-Received: by 2002:a17:907:3fa6:b0:877:a9d2:e5e9 with SMTP id hr38-20020a1709073fa600b00877a9d2e5e9mr41061683ejc.42.1678642500415;
        Sun, 12 Mar 2023 10:35:00 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id rn2-20020a170906d92200b00921c608b737sm1849904ejb.126.2023.03.12.10.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:35:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sda660-inforce: correct key node name
Date:   Sun, 12 Mar 2023 18:34:58 +0100
Message-Id: <20230312173458.411231-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

gpio-key bindings expect children to be named with generic prefix:

  sda660-inforce-ifc6560.dtb: gpio-keys: 'volup' does not match any of the regexes: ...

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
index 7c81918eee66..7459525d9982 100644
--- a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
+++ b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
@@ -29,7 +29,7 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		volup {
+		key-volup {
 			label = "Volume Up";
 			gpios = <&pm660l_gpios 7 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
-- 
2.34.1

