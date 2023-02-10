Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301C2692551
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjBJSZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjBJSZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:25:25 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D32E79B07;
        Fri, 10 Feb 2023 10:25:24 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jg8so18182231ejc.6;
        Fri, 10 Feb 2023 10:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCfu6pa2GszeTfCc5RgYlhyJYQ9sWCYCud+ludrzzVc=;
        b=X1mzrKM6r4a/0Ka+GQ11R1XnzzfmSUJuDFwVEfOo08zbxrh5eGXfBhrUVXrxpmR27K
         ESz9/uL0HnKtFzina5m6Z/BAMKvsH//osXITxksKCao5PYUe81/i4FNUpsNaq0UNc/PC
         sBb0gDowBHGWnBpF7V/c4nkq7j40Nmicx5jHub30Rs2HvL/20ueoWqNGyLxrhzR9gquG
         826SR+3RHVHmHYFSzb7ph64Zb1JTQAt/bY3PvS5UDWsELvxxCFKWAScuC0V7fiaIDGml
         QIIHpo8kH6nJjpVnewHuAtl5NiRziv0Y1G5kSKrw6gsdZHQnBA0HwctVpuziyEOOa0cy
         Isng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCfu6pa2GszeTfCc5RgYlhyJYQ9sWCYCud+ludrzzVc=;
        b=XGB5kRkR/S5p1w/uA0TRSkRCUrK9HsrhktXRvM/ndwZxzkPmhHLg504+gVGJ1GMSz1
         faYp8KwjBqiqBN+IePlKgK8Saswhd4fbI7w7mUHlIYk5n6PXwIDf2N6YApZSQIZhtH/+
         J1cU8q7/Ux+RcjY2oY2slnrniFY0X5IaxEASsCofS22SqdqLoCWDxfnsQPidwDBmWXDo
         G7E5yjnxGepciaxUQIwfdi0DSzucAQubujykJvSrE3WY7291dBF9KmrAur0ho+aIp0Mv
         UtfZva3eJ81R/YQHm6y+qKSxPKce+jlqeP0I8hIW096o6spQyOQSs53JB3hskiFptWZ+
         kJ2A==
X-Gm-Message-State: AO0yUKUymw5cV6jQBYSurzVwri1ZaYKGtX8EPmeU2s2+QUtm8TluPsk8
        F0ekvDco2DLUCGVzvPvP6lQ=
X-Google-Smtp-Source: AK7set8fq7wwpEhi5yAiF/pDQhfmzPRJ9oTHjWGWSPgYj3lO24PrEML/3qWsS/pdXPlcmVkz3lsgfg==
X-Received: by 2002:a17:907:2495:b0:888:787d:2064 with SMTP id zg21-20020a170907249500b00888787d2064mr16908779ejb.75.1676053522615;
        Fri, 10 Feb 2023 10:25:22 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906024400b008aef19f678asm2708966ejl.165.2023.02.10.10.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 10:25:22 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        erkin.bozoglu@xeront.com
Subject: [PATCH v3 4/5] arm: dts: mt7623: enable flow control on port@6
Date:   Fri, 10 Feb 2023 21:25:04 +0300
Message-Id: <20230210182505.24597-5-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230210182505.24597-1-arinc.unal@arinc9.com>
References: <20230210182505.24597-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Flow control needs to be enabled on both sides to work.
It is already enabled on gmac0, enable it on port@6 too.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/mt7623a.dtsi         | 1 +
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623a.dtsi b/arch/arm/boot/dts/mt7623a.dtsi
index dd522e508eb3..2a50b5c0c933 100644
--- a/arch/arm/boot/dts/mt7623a.dtsi
+++ b/arch/arm/boot/dts/mt7623a.dtsi
@@ -88,6 +88,7 @@ port@6 {
 					fixed-link {
 						speed = <1000>;
 						full-duplex;
+						pause;
 					};
 				};
 			};
diff --git a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
index 6b0c3d1006ab..34994f3f5a4b 100644
--- a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
+++ b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
@@ -230,6 +230,7 @@ port@6 {
 					fixed-link {
 						speed = <1000>;
 						full-duplex;
+						pause;
 					};
 				};
 			};
-- 
2.37.2

