Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E3364062B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbiLBLww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiLBLwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:52:40 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38838B4A4;
        Fri,  2 Dec 2022 03:52:37 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n21so10975555ejb.9;
        Fri, 02 Dec 2022 03:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PtgXAGJmcmMEV5+MQtqk497ZJ57rtsXRI8tIjkSb9M=;
        b=iDb0lkEMzmazESd5awPzg6ZyS1abQbKXpfLtGCsD8QafTrPd9VY/H4r1xegNz7As+J
         rQvTR++06iApH+ybBpDCVdB2nEtLoZXKwxNx26exg2lGz4plEChJwe6/3N3Ws3kxGxeB
         Wmr5iLSr931xsGgQiuSDwsluZeN+OkaoT8A3KJF04LHjJNJ3/fs3MhBrFLZXMmejh0Sz
         V8EGz5XledxGK1gUgI4FzCGMPThvV2JOvek/IUvnWw+7NkY37RrYzGTusSrqQGQz1PWG
         yR4ZIbXJ6n1Pnqti2PFV0RyYqLMdTNRE2PV7jYA05JrC4QO0+9ccdIS1YrEyNYwklQm3
         47mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1PtgXAGJmcmMEV5+MQtqk497ZJ57rtsXRI8tIjkSb9M=;
        b=YbGlZO82iC0dSLCptcZwTzhxkE5R6lxBImgCt44hdzi5UNqQ0Nb2N8dhe2Ncvqnr3q
         sO4QVJn3mt9l967zuuGoJ6gTH+iYW23ULrvoUJGz6kID+Vi0GmsrmZHEeqR4LtMlM6un
         fJSsl6OXfK1oNnZeXOKLrlRFRpB03JaIb7OE6t6RGJj6HhKat8RZGUvQe84o+tNsFNyo
         DvQeUFRb1lvS4U3ofd+wu9KdcVf4lQj3Dwm8g9mi7qcFM4qIknnbf+INlgOQWc/tbbX+
         r7VgmBdQJRJWpE2TiNL8hsqjgClfhPebJQXKAvPZfXO0gYUhn4gerhyNfV+6sqqXYbSB
         eCRw==
X-Gm-Message-State: ANoB5ploVXDnJER9Bux8Q7yZc25aWLF8wUq8r92ibfoOGFzQ5Fv9AnzU
        yWxulGCZd+NZhy3AyoJGDnQ+LI5hKywV+g==
X-Google-Smtp-Source: AA0mqf7jj01A8oMhYJoBckXaekMhZdpOj5mhNi9QsJ1oBNazwr9oRc1BsyV5aCFi7NW8gl2Dy7/6MA==
X-Received: by 2002:a17:906:6c7:b0:78d:4061:5e1b with SMTP id v7-20020a17090606c700b0078d40615e1bmr51092779ejb.47.1669981955805;
        Fri, 02 Dec 2022 03:52:35 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b007c0bb571da5sm1206762ejb.41.2022.12.02.03.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:52:35 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 1/8] dt-bindings: reset: meson-g12a: Add missing NNA reset
Date:   Fri,  2 Dec 2022 12:52:13 +0100
Message-Id: <20221202115223.39051-2-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
References: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
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
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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

