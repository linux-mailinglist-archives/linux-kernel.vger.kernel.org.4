Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01736686E80
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjBAS5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjBAS5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:57:15 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B22880FB1;
        Wed,  1 Feb 2023 10:57:13 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id m2so53815173ejb.8;
        Wed, 01 Feb 2023 10:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCfu6pa2GszeTfCc5RgYlhyJYQ9sWCYCud+ludrzzVc=;
        b=ZWH6Ar7ilBCAgENdaD2nDd5SFGMw9TpK1MYhGrmFx0FRswNziyBZezdAFW4G+XihTV
         DZTFZoQ6F6amvc+844+dV4hDBAQVK0rJpnLY6Zfd8w7t8Xpekbc4vRS5Cif/pnAOn12A
         9VMA2AxbsvzsP70NjJv+QHn2ullhmx3dZpQOyClVYEC80pWyE7jJjrYRV72G7q337qZ7
         hkqBviIq9wpmQfmH96wxi2bcAA0WU5gvEbosZ57vmUPm5pJN8/xOO67pb079zr2L3oHI
         TLBt1VCUNGGw/SzhWc3cVaj3c6dE8mKNRi6N9IliDhvbXzlYmAS5MT9iTDdNNaJYZhpQ
         vuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCfu6pa2GszeTfCc5RgYlhyJYQ9sWCYCud+ludrzzVc=;
        b=wOu7DcPORsgKEJjcxrjD4fC4e/d1j0GnzOkpvStU6f5H/Z55nhtjPfgcwrAZKgqFbf
         eYtyNGnY8jSC5ddEvBLsHsJllkIDPBNxW7EUmwXWZUml3ERRmyk8YQSRNQR9Lfh2ZXVJ
         1GmzquwbcaeweLb8VWMXyjA75DMohYz2xTSPpMSaHjjJpBBVBEShf5Dtujsxy/k//HnO
         thhgu0t4QQQQFjiBtEMiCr9tnfKZhE71s1RhdjQ8KyU4eZeFcMSAFVKsOo4czfkE7i2i
         nQgf1G2BsVodP79VZ8gVER+V4kCl4nf+DFLsa9OBTWeql/Kkqt69xJVHiVkBLAy8/7ok
         VgSw==
X-Gm-Message-State: AO0yUKVm6nb7lO0evsZoCVWvPWTW6THc1H0uXicwCqX5ovtZi7cc1aCj
        mJZbC1XHZmRhPwfCVum3RSg=
X-Google-Smtp-Source: AK7set/SM3JG6I2M8EAecQOB0PUjU28U25qsAi1G9D05Ilp8bswF5flMqVIH6qRv0DQ3Sxo2vUYFlw==
X-Received: by 2002:a17:907:2d28:b0:88d:f759:15ae with SMTP id gs40-20020a1709072d2800b0088df75915aemr4150126ejc.42.1675277831685;
        Wed, 01 Feb 2023 10:57:11 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id dy25-20020a05640231f900b0049e210884dasm10100883edb.15.2023.02.01.10.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:57:11 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
Subject: [PATCH v2 5/5] arm: dts: mt7623: enable flow control on port@6
Date:   Wed,  1 Feb 2023 21:56:56 +0300
Message-Id: <20230201185656.17164-6-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230201185656.17164-1-arinc.unal@arinc9.com>
References: <20230201185656.17164-1-arinc.unal@arinc9.com>
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

