Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A49E63A6FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiK1LST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiK1LSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:18:02 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE71A28C;
        Mon, 28 Nov 2022 03:17:58 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b12so16259248wrn.2;
        Mon, 28 Nov 2022 03:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cg4h08ScbCmARXEsFqgc8N6O4NbradYeqRREoszyl4=;
        b=QXR5F2bJ8Eij2/5WO+e0aTm0WPGRA2YwX4pj8OMlGSj1xkxltGn2jsplziGfPxjogU
         D3cACs1p3GlJvns3uMBvZVN5x+JhUhd4b7pEFWzUlivL9Q6qvt4+G212dn0Bne2zrLiB
         awdE2i32jCmPKobSrFTtq0qtiRCIbS6gTPD9P1M5+9pWnkB94LFfUdKlZ+chMfebUFZ2
         /gMQR5p2VYliZEAGt69NxjN3MbwUMmprVRwiVXPXQrP1b6ds01DOCt5p/dGWw9rgJV20
         O/gdns2/4UjKlmGyj+K6uIt/szHAlmFfZtvjfAq/oqWEqJJ8vQYzJLrQYifb69jIUkRu
         HhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9cg4h08ScbCmARXEsFqgc8N6O4NbradYeqRREoszyl4=;
        b=wognYLShwBHip/am81LtGOzoR8fzVW6LoVwq7FmfIUFIDGcJXz5y4F2WN1eMkrw7Nf
         kjWFrYP19lAHT1rKqLNQxgclBV88yPX6iBNBvn5P/xDHBMRtCRCpKclyMNPJ6wHTAvFT
         mBtd5RIfrjlMEhaKSaclDYulRnNYErh3t+iAH7d5SYaJmV7QM2zP7AioVul4dqJ3PykX
         M1WfH0uHZGrfkXHINTXSQ+nJuHDbzanwuz9RyxrVWaAsfLvjytTSuguqNVSeS2i/p9PS
         MKIYI8oQyZV1yMKR5LY2KQOM4/fZeRVYOMXrkTdZhUFMkZtA9CwpZ8XBseMx/YS4Kvt8
         5iRg==
X-Gm-Message-State: ANoB5plOZCHh/y/Uza3pqjhsf2BvBh8nd6H8YCgKH1uXGzXPh+ua9iC5
        31N7w3vBChHSXI0d9QlV0M4=
X-Google-Smtp-Source: AA0mqf4DvNm+mFTnoF3Ww3qLbB0khH/Om/MssTeWDr1wrlRac9GiI4sPTsNPfa9NwQFIzeBjPpF4zQ==
X-Received: by 2002:a05:6000:1a41:b0:236:f365:b778 with SMTP id t1-20020a0560001a4100b00236f365b778mr31551672wry.515.1669634277506;
        Mon, 28 Nov 2022 03:17:57 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id g3-20020adffc83000000b0024207ed4ce0sm7711817wrr.58.2022.11.28.03.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:17:57 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
Subject: [PATCH v2 1/5] dt-bindings: reset: meson-g12a: Add missing NNA reset
Date:   Mon, 28 Nov 2022 12:17:34 +0100
Message-Id: <20221128111740.39003-2-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128111740.39003-1-tomeu.vizoso@collabora.com>
References: <20221128111740.39003-1-tomeu.vizoso@collabora.com>
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

Doesn't appear in the TRM I have, but it is used by the downstream
galcore driver.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/dt-bindings/reset/amlogic,meson-g12a-reset.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
index 6d487c5eba2c..45f6b8a951d0 100644
--- a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
+++ b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
@@ -69,7 +69,9 @@
 #define RESET_PARSER_FETCH		72
 #define RESET_CTL			73
 #define RESET_PARSER_TOP		74
-/*					75-77	*/
+/*					75	*/
+#define RESET_NNA			76
+/*					77	*/
 #define RESET_DVALIN			78
 #define RESET_HDMITX			79
 /*					80-95	*/
-- 
2.38.1

