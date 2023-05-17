Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3804706B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjEQOmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjEQOlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:41:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5B81708;
        Wed, 17 May 2023 07:41:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-307664010fdso886677f8f.0;
        Wed, 17 May 2023 07:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684334511; x=1686926511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfHgDGDyInqauASTk1yIDYU1/aT9MoRYa/mD4C6dxf8=;
        b=OYIF8BeFGkjq2BS1FcZdV+wBNyytqwUtzfeIKOaPxK681tMhv6bfvVVDXaGTAtlVTm
         5KOiHWXr2yj5LhkvEoZbPmCpsQX72ndoIjUla2KzWoGYhZ6YnPhlF6dT1WH3V1U5DVLO
         VcXTHA/x37aHGgE5E3mKNds2RnOU8NKTwf3zLzGSgcA5XH+HkcFPtnaPfSUjxD5sd/Qj
         iG3TAFqT4ghNB2pDcx2uKMoxulF+h6GdBuSEyUS9lLlKz4/VLvFJps7ngeC0ncVDn0yW
         ZZ/XcdKWwC+gZLh1tvothNckaNuRj9sLUlghHWobyRpED0wPleXlBpa20OjloQa7yJdg
         av9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684334511; x=1686926511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfHgDGDyInqauASTk1yIDYU1/aT9MoRYa/mD4C6dxf8=;
        b=FcJbKz9C+vU+zmBYAfQH0WtFSH+itwihVl9zXHwr9Sxxz5ONRaJh1NCXlU6NU/UULE
         /QjuZrVVoIsVGWlixnkqOlUBTJTWi0AcZrI++zqQW/PBkl0eQqsaBVEFY+xYEoaG9F1q
         6RVL2fwNyVfKDisJ1zB3tU+NDk3p+qdGKrGKr+8Nab67clA2Pv2bRNrUWoZpYbUF3Ggn
         pNZYQPv4JacmzIh360xLQDnXcUizE92c6fLNnlHVkDDRURlzuitLtYq6FHAYp6sknjcU
         l/kP3/XcMAIvwy+cmLS+AE2X2A89wmuJoN9oNSKgzEffKUs1RELr74gDiH8NdVrs04vt
         tEkA==
X-Gm-Message-State: AC+VfDyxUhjEAouwxHGKr3WrTsrr9rEO5hNYKhSLAHVc+ksG8vxMxcxM
        tgrZznUn0KXQHZpN9OEq0IQ=
X-Google-Smtp-Source: ACHHUZ6j9O9puGfxT2vkLL5TGO0mk7k61Y0n5SGQ/Ke/hMA4k7jfH5TmCv7X6tTEfEW4oxv77T1oKQ==
X-Received: by 2002:adf:f108:0:b0:306:45ff:b527 with SMTP id r8-20020adff108000000b0030645ffb527mr881672wro.45.1684334510951;
        Wed, 17 May 2023 07:41:50 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id r4-20020a056000014400b002f103ca90cdsm2976974wrx.101.2023.05.17.07.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:41:50 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] ARM: dts: mstar: Enable rtc for SSD20xD
Date:   Wed, 17 May 2023 16:41:44 +0200
Message-Id: <20230517144144.365631-4-romain.perier@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517144144.365631-1-romain.perier@gmail.com>
References: <20230517144144.365631-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the definition of the rtc device node. It enables RTC block
for SSD20xD SoCs and newer.
---
 arch/arm/boot/dts/mstar-infinity2m.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity2m.dtsi b/arch/arm/boot/dts/mstar-infinity2m.dtsi
index 1b485efd7156..75f9173ca703 100644
--- a/arch/arm/boot/dts/mstar-infinity2m.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity2m.dtsi
@@ -32,6 +32,11 @@ cpu1: cpu@1 {
 };
 
 &riu {
+	rtc@6800 {
+		compatible = "mstar,ssd20xd-rtc";
+		reg = <0x6800 0x200>;
+	};
+
 	smpctrl: smpctrl@204000 {
 		reg = <0x204000 0x200>;
 		status = "disabled";
-- 
2.39.2

