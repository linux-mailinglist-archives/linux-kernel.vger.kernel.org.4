Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227BA73CB03
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 15:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjFXNRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 09:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjFXNRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 09:17:19 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE771FF0;
        Sat, 24 Jun 2023 06:17:17 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fa71e253f2so25207285e9.0;
        Sat, 24 Jun 2023 06:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687612636; x=1690204636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAYPGxSTFPjM3RqhwW9I/u0fjI7Fx45EUbdLcf3Fbbk=;
        b=RTqZRv+kicZW7QzVJK3ZagJlTPPID3erCQjK8DbAaVPTMWw3b0mjuGV5SQVg3A7Hfp
         kTP3MO1AV9lx1/fyLW3WpWXj4HmKkLq3zsShiKr+AZkRpIUvDHPemFoM8d6lYuJBkhVf
         VwXLSS0PvzKxnzoIXhwxmKBAloifepGmC78ZDgEmk5MbVTY+UmUcnQs8jnP7jUKTgQ1t
         ovA2xPB5nkCELrRww6By/LY2lIhiGufo89h+gKofzrfcx/6CnBLsCo++cVmYMzLAiVW3
         P2v56HjmRyol/JePLMkvownV0cd+4jPAN3a3PkXbpyjqgTMgtriUwWMRfhDtyahMiisK
         i7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687612636; x=1690204636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAYPGxSTFPjM3RqhwW9I/u0fjI7Fx45EUbdLcf3Fbbk=;
        b=QRKD+Pcjcox3UgNNFPsHHsErRw05pwQlA5aFgg2lrkjnHOaiW8jNI3epDvb+hbZIvR
         mzn0HJVDjNnoEQ3M2wV/5ANgsp+BrDSzui9LnUvWkBH3vDqg4TKOS6/W/IUUjnLQjbpi
         XWuApkkTQbTPnwqfbej4iQ+pcGZlc9fuC/Xc2VxVUEFNQ3UL6MhUpBnHsc3NQa4vvNUh
         8QGjED63Ox8cspJ9uHgGNy5FUH77edXVPz2Lz2HJ5PyF+Uyh6aNM/8airSMBYk4tNXZp
         rK7VrQ6hdFaW5eKALm0Eh6KdPR0cihUYX71IKepAYW3tiAIKJXupeou6cn0b0Vs7phhF
         txAw==
X-Gm-Message-State: AC+VfDwxtLs+KRi5Yb1csUX86kdX12gINmYMrA74eZvh1JE8poJSwM7d
        gOwxfhwLovEEZ1BBArP74osk/Ucw+0tJDWW3
X-Google-Smtp-Source: ACHHUZ6AxRD4qR+dRoN7S7SE01tpvdTdIi7AeyJugnitjFY045wLn75ojjvOMv78elsfe85Qmldkag==
X-Received: by 2002:a05:600c:245:b0:3fa:838d:adbd with SMTP id 5-20020a05600c024500b003fa838dadbdmr1749644wmj.1.1687612635438;
        Sat, 24 Jun 2023 06:17:15 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194])
        by smtp.gmail.com with ESMTPSA id l1-20020a1ced01000000b003f9b0830107sm5107428wmh.41.2023.06.24.06.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 06:17:15 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] riscv: dts: allwinner: d1: Add QSPI pins node for pinmux PC port
Date:   Sat, 24 Jun 2023 16:16:24 +0300
Message-Id: <20230624131632.2972546-4-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230624131632.2972546-1-bigunclemax@gmail.com>
References: <20230624131632.2972546-1-bigunclemax@gmail.com>
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

Add pinmux node that describes pins on PC port which required for
QSPI mode.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 1bb1e5cae602..9f754dd03d85 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -131,6 +131,13 @@ uart3_pb_pins: uart3-pb-pins {
 				pins = "PB6", "PB7";
 				function = "uart3";
 			};
+
+			/omit-if-no-ref/
+			qspi0_pc_pins: qspi0-pc-pins {
+				pins = "PC2", "PC3", "PC4", "PC5", "PC6",
+				       "PC7";
+				function = "spi0";
+			};
 		};
 
 		ccu: clock-controller@2001000 {
-- 
2.39.2

