Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DF063A6FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiK1LSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiK1LSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:18:03 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4889B1AF32;
        Mon, 28 Nov 2022 03:18:01 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b12so16259441wrn.2;
        Mon, 28 Nov 2022 03:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UPpIU6lTdK7INRlRgvRZ2pUB9CB4XOUu+P4PTYKdZI=;
        b=ipUjo8xR+7idcDTsImEjZah0QvWL0uQk2xlkUjMYuynXjZ0QvObzZOiVoCYlojnlSS
         XbBb3P2jIfFbLscrZHUQ5i9dvgF1Pt8hi1sIdHeOsVUVn43UsQDntPld5dYgu7uKjNMY
         D3PopNhhi6U9MWYE48WVHHTmEUfVD/4mugGEQccnpRTA56O3m/LPyg8esFmeggk7NIa9
         T4PKRmEg1ftNX1D920C+4r9xOWNpZyJsBb9FhELekVN45K3uSSradstyupQT3ncH8lCa
         8q6oIG41cJiW2EprBP7vO3gopJJ43YB0Q1HJqt2U4kfI0ChF2WUzsK2DhGs5C5ixnl6N
         FzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6UPpIU6lTdK7INRlRgvRZ2pUB9CB4XOUu+P4PTYKdZI=;
        b=n00h+dztAEbkvYgPDr/ytb9HK1lQk/0fe7K5CGyzuPobrZ87IOpK13iQ0/7Q1qWCvm
         Idq+Sz1d9Xf1ka3Jgy4cyfimlpXFKtTeK6Y1QBBouc/Ibc8JStJTsJDnqXilimVVPyqP
         DjWoXq2AtkrXiZZsfTLtDI/qDqM+iIEKlCR+voJM6eR0UdFwvS6hKAAUzvHoZEbP9GTH
         kmTKQHeKKRPZ6GV3xrJAWUCGjhjkV77WvEmf8ycvzQx0lBeOBF3/tSRT9eDLurOJoJKY
         VhytyQPVYwXb7MipKGJbxCriEDLl93vhAFW5T+uWJm+NOVbBRWDDJZWndiSejTLhLZsR
         9hHw==
X-Gm-Message-State: ANoB5pkTzrJJ2mKGodIcOh0lR9iVR47VsbfL4XqHkN1l2ZYITOzZvn++
        3rKQWeB6rh120IvtelHV/bo=
X-Google-Smtp-Source: AA0mqf5whm/4QpVrKDo6y/72I01fykgiBFGzZqcNUSNcXLDufdCn5sruz5OJk0RXKqeNqz5JXViIlw==
X-Received: by 2002:adf:ed8e:0:b0:241:d7ce:4395 with SMTP id c14-20020adfed8e000000b00241d7ce4395mr22369951wro.553.1669634280306;
        Mon, 28 Nov 2022 03:18:00 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id g3-20020adffc83000000b0024207ed4ce0sm7711817wrr.58.2022.11.28.03.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:17:59 -0800 (PST)
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
Subject: [PATCH v2 2/5] dt-bindings: power: Add NNA power domain
Date:   Mon, 28 Nov 2022 12:17:35 +0100
Message-Id: <20221128111740.39003-3-tomeu.vizoso@collabora.com>
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

