Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6D963EDC7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiLAKbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiLAKa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:30:58 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FADB2FA7D;
        Thu,  1 Dec 2022 02:30:56 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id a16so1722146edb.9;
        Thu, 01 Dec 2022 02:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cg4h08ScbCmARXEsFqgc8N6O4NbradYeqRREoszyl4=;
        b=KutmegGQGsv/gMkBbZbzfuVkNuLXhW/EgSYR1qqKN9AXRPCSlAR3JGKhkXpH0fQRpE
         e9AHn4lBp0xWg1i7Slzlzv2gw2KbjpIs9pyviE6SP+4T/wB/OoNDNvqs6fNJEYbg/7pz
         OtOmNTaBBz296GbI6aDaugchKRe5uJv3xPUCx7AlqpKAvy8LcAtmRODec+n8MxIDW3eY
         gvroupxW+sCVmW3fCPBn82s+8oXxB+k+x256wlM2QQ4+ktuGLj6HsYlOqCtuqfbDU2zn
         vnNL/OEUZ3EVcWFhFEV++ATUuZGV/KhgQNGsGeW9Ub3qz6sXwnBiwvi37M85LJAp3s+I
         FnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9cg4h08ScbCmARXEsFqgc8N6O4NbradYeqRREoszyl4=;
        b=eMvMApB/79WnnQBluW8x0SfrAxGbzvSzv/64T1DJHwbPJYhj/MR1xKQlixfpZ44hsm
         rlEQVYvu1mlUd5TZg3dg7grpqQlqklvWRTLvTW0e9+vbeAE2TQ4lACWre1wm4/+RwyR7
         6Qdmdtl7ojIl0sY1nBtjZ62luDW2tHtwiGOTkBxU5KZRrA3VdD4sd326RPD8qZoOrYfd
         CWP1r8hRPcCNHoIQy71l4fcAYcHcJnNcJ5bA3FSfThJ0mv8881yHM8wPTn8HSV6EGHSH
         4/uYimHlIS0/K/8FfunoXozbIkLj8rtpmtYBH5FJWPm4p/pr0bISs7cdeIsQiqXMOEUW
         r+dg==
X-Gm-Message-State: ANoB5pm39VYRp5B7QjFO/GZ534xZiH0Li8g537dsJEQqSLUQpp5DVagI
        6YJQUAXm+/68mD3cOGAwPt0=
X-Google-Smtp-Source: AA0mqf5LqY3BpiA6Y64UXPqHHdECs7MICeKvHQSVrk/7RvPTjow4ThtGOhZPqltPT6o0TlHo4K2LMQ==
X-Received: by 2002:a05:6402:3886:b0:463:ab08:2bc6 with SMTP id fd6-20020a056402388600b00463ab082bc6mr42080057edb.143.1669890654995;
        Thu, 01 Dec 2022 02:30:54 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b007c07b23a79bsm1592400eja.213.2022.12.01.02.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 02:30:54 -0800 (PST)
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
Subject: [PATCH v5 1/7] dt-bindings: reset: meson-g12a: Add missing NNA reset
Date:   Thu,  1 Dec 2022 11:30:17 +0100
Message-Id: <20221201103026.53234-2-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201103026.53234-1-tomeu.vizoso@collabora.com>
References: <20221201103026.53234-1-tomeu.vizoso@collabora.com>
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

