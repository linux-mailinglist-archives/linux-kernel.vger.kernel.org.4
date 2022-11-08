Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EA262089A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiKHE6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiKHE5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:57:33 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD6745ED2;
        Mon,  7 Nov 2022 20:53:58 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id q9so35689564ejd.0;
        Mon, 07 Nov 2022 20:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snUtTBHDSnPgKxJzYe5m09ZTxD4YzrDQEzl3/KiB5BQ=;
        b=O5V4m3NpU0iTB/56L9P1aQCm7tnJP89b3QY5x7lJKRq2S/ZqzcDduG3A2OR2mOTFL5
         AdOtXmCvUoviTVH2pIH12JgRPBRM9aWWRjITkiVztkk5vjBMjQrwdClvLsRvdH5MhMQ4
         vejWdS+fxbKMJeMgnDkrm1GtAzRCHfiw5cHJpkvpTt1T0iqeb9XnUmz4PfiPYG8ht9l5
         aSoCnfncwFdqLloHsisagvVANa5Rv2eD6YrVKsArYCILDUQ9dwQ5Uj+l+cp4lAiaQzJw
         KamDdnJinb2bTn9H08F2gOVuWMCk/t0seHgiKO4h/RHdpkdBUHoR7q7XJhlQhkphJGOd
         kZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snUtTBHDSnPgKxJzYe5m09ZTxD4YzrDQEzl3/KiB5BQ=;
        b=eiS0cH4kFtYpFq5SLK5z/bYWnJIy94Om6g822HPw7Gax/fA8DHjejUmclLyz1HXn0p
         qLKlN4MOzvz3Hse10jGLlr0HQhdBfBSIBWUe962I1fGeL4gTyy6qCWtDkiNFhcoE/MT1
         RNATPi1kOItHODB8CKbFRtjxBK5TUhO3fBtLZ6Et6K98UmHi1Pw4/gcbq2CY/BTvCMX4
         cveMMpk2fUZ6bbtnDDUHNX1PV1tmzOPu+cybBQOSacyNzNEF73PgcWuz/K1dh7utJW7w
         wT7rYAeKGTko1fZ7FGWVMJZwl1RD9gpf6j/EzAEllpwIMmslG98JVkfWXC+9rLQ8tC1q
         2ueA==
X-Gm-Message-State: ACrzQf1KXKL3GhmlsVGQcMMNc8a5MldQxCW4fAYjFOCd6QOYbNBDLZ3I
        seCeEMH+jG+RNxDAYHdmrYI=
X-Google-Smtp-Source: AMsMyM4b2UK2nV5j9TolXpFZNf1GGYQE1UnIfvBA6PuqwuNgn8pl/aqkmsrxekAsAjLadTaeYsvX4Q==
X-Received: by 2002:a17:907:320c:b0:77b:6f08:9870 with SMTP id xg12-20020a170907320c00b0077b6f089870mr50227681ejb.249.1667883236826;
        Mon, 07 Nov 2022 20:53:56 -0800 (PST)
Received: from hp-power-15.localdomain (mm-58-12-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.12.58])
        by smtp.gmail.com with ESMTPSA id p11-20020a05640210cb00b004637489cf08sm4994444edu.88.2022.11.07.20.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 20:53:56 -0800 (PST)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH 2/2] MIPS: ingenic: rs90: set MMC_MUX clock
Date:   Tue,  8 Nov 2022 07:53:00 +0300
Message-Id: <20221108045300.2084671-3-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221108045300.2084671-1-lis8215@gmail.com>
References: <20221108045300.2084671-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the MMC driver can't change the common MMC_MUX clock
anymore, the CGU shall configure that clock properly.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 arch/mips/boot/dts/ingenic/rs90.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/rs90.dts b/arch/mips/boot/dts/ingenic/rs90.dts
index e8df70dd4..d874abaa6 100644
--- a/arch/mips/boot/dts/ingenic/rs90.dts
+++ b/arch/mips/boot/dts/ingenic/rs90.dts
@@ -295,8 +295,9 @@ partition@20000 {
 
 &cgu {
 	/* Use 32kHz oscillator as the parent of the RTC clock */
-	assigned-clocks = <&cgu JZ4725B_CLK_RTC>;
-	assigned-clock-parents = <&cgu JZ4725B_CLK_OSC32K>;
+	assigned-clocks = <&cgu JZ4725B_CLK_MMC_MUX>, <&cgu JZ4725B_CLK_RTC>;
+	assigned-clock-parents = <0>, <&cgu JZ4725B_CLK_OSC32K>;
+	assigned-clock-rates = <48000000>;
 };
 
 &tcu {
-- 
2.36.1

