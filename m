Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB9663BC20
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiK2Ivq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiK2IvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:51:17 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6E04C24F;
        Tue, 29 Nov 2022 00:51:16 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ha10so32095039ejb.3;
        Tue, 29 Nov 2022 00:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIHeFovEuwjGuythdoubrFT/SXANkAJoc/lUtd9ZW10=;
        b=m5uCgXks2HvW5R/x6dE35mrXeuAHQ3cr7K5plc0T2J/N4Mquzkf5TDcI83kXewzzRm
         DMStLtEeRJtLpRPDN9ycQ/djzbNYE4IeGwTeYzoRPXoHxCAshDduI2e//fvw3xlzBRBe
         aiVSPeHLte/Z/tYGosRqjQFmY9XGgRJY3Cdoe3gtqQBte9EcKJNPuXvFGobaesY1CItP
         wHpwPERqM6TNBYIYtX7Qwp/X10/4NPSkzOyXA/MJefaQouAHeM/nGcrLtgNZysRZREsr
         0HzAML7IUOKEJb7DM77mqFa6Kadv2Am2zVV9ZKaP9JbdwjiCGjeqv64ZHE3bJxTO34Ye
         jInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IIHeFovEuwjGuythdoubrFT/SXANkAJoc/lUtd9ZW10=;
        b=DV9BTpxFUsIlNN4BnWVS8EkkKCJFEXhClWiam8oTJeNOTmw0j/dzZR0UdAWbfC6FZZ
         Ip4vgWp0QjAPcHRIy/xK5BDsk25oVi/T9oycznpia24mOK0cTF/1+NZL30r1T5dJymZ6
         VNYFGwPyxEyVJ9oJpL2av0Pem5Gqd9i2sILXhyb6iS+YpxguGc+Yyisu2V2szmwVRB0Q
         tVbfPDbUCTS+Y+ouK5f+13SJJDxxhTF78rrK/K/VlRxDEG8jOAFEF3TvG9qhyy6U7qkf
         Zqo6mh82Lda30hjr74vV49R7ETlaFVDNxNHJ78k5i4/pLNP54WQP6Y+5dxocbXUNpzOw
         myug==
X-Gm-Message-State: ANoB5pkmka8NACGAXDGGjes9MWPgkYJ5aQHHl3tPaJmNQsiD4mpqmWv6
        djNwmYP8RjA8W2i0xXBo7Hg=
X-Google-Smtp-Source: AA0mqf4J/t4QZ6BLzbajN+wa5uDqJj33v1lQ2C5Hl8cQB2CTaAZVIab41wT63RWTwZ6RPm1AQvFETQ==
X-Received: by 2002:a17:906:a58:b0:7ad:b45c:dbca with SMTP id x24-20020a1709060a5800b007adb45cdbcamr36204325ejf.388.1669711875344;
        Tue, 29 Nov 2022 00:51:15 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id kz1-20020a17090777c100b0078de26f66b9sm5873219ejc.114.2022.11.29.00.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 00:51:14 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/5] dt-bindings: power: Add G12A NNA power domain
Date:   Tue, 29 Nov 2022 09:50:42 +0100
Message-Id: <20221129085047.49813-3-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129085047.49813-1-tomeu.vizoso@collabora.com>
References: <20221129085047.49813-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add define for the NNA power domain for the NPU in the G12A.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/dt-bindings/power/meson-g12a-power.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/power/meson-g12a-power.h b/include/dt-bindings/power/meson-g12a-power.h
index bb5e67a842de..93b03bdd60b7 100644
--- a/include/dt-bindings/power/meson-g12a-power.h
+++ b/include/dt-bindings/power/meson-g12a-power.h
@@ -9,5 +9,6 @@
 
 #define PWRC_G12A_VPU_ID		0
 #define PWRC_G12A_ETH_ID		1
+#define PWRC_G12A_NNA_ID		2
 
 #endif
-- 
2.38.1

