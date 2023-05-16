Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB7770454B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjEPG10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjEPG1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:27:24 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F043D35AF;
        Mon, 15 May 2023 23:27:19 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaebed5bd6so97247275ad.1;
        Mon, 15 May 2023 23:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218439; x=1686810439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEAnMpd6wdtOy2vwlfjPurAIrcJAUQpKXG37N4nz4YI=;
        b=Uj0ifojq6EdcNq4Y3rHaz5PpLggXKjIKq2yFOn/M3JX8nkWRlkQ7RKEjslcDd8nTl8
         qc6kX4Q5Yy3NpiPnTL1Mewb+7OOmEZJrkULw6r12N0w4K52VtnmmStn4zg9LXFxmF96v
         AMBLMpZQOHE2PQezUsJcau0SXcO6ymgoGMWWqd1rNWTxRm8oUlP1gD8z7/fF4MjpKdEe
         qBelsc6KXY1RZ4RyrXGnlhh9KklSe8mZQLPqWUpcK10zPUzKLSu1w1v9wImbzKenukOB
         t2Ozpbtxh+x7klmaLLBzdaX6jxAHz+bTsmDUOxFVt63prWOKXUzqdzjL+JvovX3KbAJW
         3rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218439; x=1686810439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEAnMpd6wdtOy2vwlfjPurAIrcJAUQpKXG37N4nz4YI=;
        b=UeWigwsgEPRmZ0F5nzBR+Ej7n/GsxMnkSnY6EbdadqZr7246uKTf5hVgdV7BWqahAl
         nDY4NnS1r2gHbciKgAD5H8J68bHks5Zd41lzPCEcl23uN9HGYS+ArWlyV3WJ7RJjKXud
         RF+YRx8AoLdo2dnG/mDvgPURJ1PdmlcSbG5kDhcqmkiwBH+e3vnjanAjq1Qygi59aYb0
         8XlzSQIHfX/BwcVmssRf1z7wad+mFH3+xsQR3i/2+rtEoqm3c2yZ+LYMApntuy2Ikl/u
         GiX1CC25ITzlw0U5nIE6f83mkYlWCg/5hn1qTpp8tidF1ABmsK5nznLqhX0N3ys9JpkJ
         3JTw==
X-Gm-Message-State: AC+VfDyCMdwykzdIKx8dmrgMjFm6SmwuQqqx5zKvRIhcWcLg2JJNKMRa
        TKwzeb03BfdtpM4qgrpsAy8hJZoS8pYKRQ==
X-Google-Smtp-Source: ACHHUZ6xUDJj3aEkckO8bCjAZDnv7vsKHZujw8XOx5aaR64Ac7kXg8RMgdLHug8IF1Z2l0jyMl1N0Q==
X-Received: by 2002:a17:902:c453:b0:1a9:a672:12b8 with SMTP id m19-20020a170902c45300b001a9a67212b8mr29330812plm.68.1684218439287;
        Mon, 15 May 2023 23:27:19 -0700 (PDT)
Received: from localhost.localdomain (n220246252240.netvigator.com. [220.246.252.240])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902da9200b001aaea7bdaa7sm14579710plx.50.2023.05.15.23.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:27:18 -0700 (PDT)
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
Subject: [RESEND,PATCH 2/3] arm64: dts: qcom: sm8250-xiaomi-elish-csot: fix panel compatible
Date:   Tue, 16 May 2023 14:26:56 +0800
Message-Id: <20230516062657.28616-2-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230516062657.28616-1-lujianhua000@gmail.com>
References: <20230516062657.28616-1-lujianhua000@gmail.com>
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

  sm8250-xiaomi-elish-csot.dtb: panel@0: compatible: ['xiaomi,elish-csot-nt36523'] is too short

Fixes: 8a786036c7b6 ("arm64: dts: qcom: sm8250-xiaomi-elish-csot: Add Xiaomi Mi Pad 5 Pro CSOT variant")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts
index a4d5341495cf..4cffe9c703df 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts
@@ -13,6 +13,6 @@ / {
 };
 
 &display_panel {
-	compatible = "xiaomi,elish-csot-nt36523";
+	compatible = "xiaomi,elish-csot-nt36523", "novatek,nt36523";
 	status = "okay";
 };
-- 
2.39.3

