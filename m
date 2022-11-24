Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D520C6372DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 08:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiKXHRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 02:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXHRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 02:17:23 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AFD263
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 23:27:26 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id g62so905600pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 23:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tW6MvRH3jNggI06kpSrGpMQXghZPn7YvkXKr7sxkm/E=;
        b=jthoqAqsb1On6ynD07XDwO4XNpMQVtTAlvP7hLtSbRKtKjf9HU1h5JDZJJLshzUMX6
         2zmYIP8Tq1XEKWxn1y+FXkmQDbKndFnWniNxlD+5dKpAANdQtacRQjaHOaM34iy+UbqU
         dCSuqSuzHjNKFVTGtJdAlymtplcsx2u785PCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tW6MvRH3jNggI06kpSrGpMQXghZPn7YvkXKr7sxkm/E=;
        b=XA2BwoTSdPnlmmOPnUuGVut8F5XAZDTnWKA902CKn2irIs8JcFewl8p44KeEvLLmoX
         NSxPtN1BnngBZ6yCm/f9T3GbI8Ct0iqU904bea3uenY+mjxK2G4MicFdvtFs6Ue0oJFZ
         Ut8AleWwNrKXwpTbJ5h2WO6UDCJkCAaXiUMsse9BOFL1/sbX2yjK05VnLObEiWhC5eIi
         hh8hvqaRlD63d94hE3Tz6ReppfQIZf7cmcXpeglHl25CvlIgtWG7viyRtZCDsE120Rs5
         K1TjsAISO/ZuNPITm4hMLowPHUgtbJmRAMOoz8Abv0Dugs6mIGEgpo0tpnwJ5o0q34tN
         tAnA==
X-Gm-Message-State: ANoB5pnhjhNkoN8gorEL9rLIu52cM/Tzcqr+wy+0W6+Et103WV+KRFD0
        CHN78YNjQY8U0f6lR0XAw8NPCg==
X-Google-Smtp-Source: AA0mqf7OHaA7DO+aqoNHin2IIal35uAtwUsWiZYlGCP3uW9OiZsRwm7Vxh59WgBGQNupgdfGcpyyuw==
X-Received: by 2002:a05:6a00:10cd:b0:572:5c03:f7ad with SMTP id d13-20020a056a0010cd00b005725c03f7admr33870504pfu.17.1669274846030;
        Wed, 23 Nov 2022 23:27:26 -0800 (PST)
Received: from localhost.localdomain ([183.83.141.79])
        by smtp.gmail.com with ESMTPSA id l64-20020a622543000000b0056ddd2b5e9bsm471630pfl.41.2022.11.23.23.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 23:27:25 -0800 (PST)
From:   Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com, Da Xue <da.xue@libretech.co>,
        dsx724 <da@lessconfused.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Subject: [PATCH v2] arm64: dts: rockchip: increase spi-max-frequency of nor flash for roc-rk3399-pc
Date:   Thu, 24 Nov 2022 12:57:14 +0530
Message-Id: <20221124072714.450223-1-abbaraju.manojsai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123094827.250657-2-abbaraju.manojsai@amarulasolutions.com>
References: <20221123094827.250657-2-abbaraju.manojsai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the spi-max-frequency of nor flash from 10Mhz to 30Mhz,this improves the
flash raw write speed by 0.9 MB/s to 1.6MB/s and the time taken to write is
get reduced from 36 seconds to 20 seconds.

Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
---
Changes for v2:
- removed irrelevant members from the Signed-Off-By section in the commit message.
---
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index 2f4b1b2e3ac7..8fd808a0df85 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -735,7 +735,7 @@ &spi1 {
 	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <10000000>;
+		spi-max-frequency = <30000000>;
 	};
 };
 
-- 
2.25.1

