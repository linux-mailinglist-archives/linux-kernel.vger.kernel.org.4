Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A16D666566
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjAKVOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjAKVOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:14:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC283F114;
        Wed, 11 Jan 2023 13:14:17 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w14so6917157edi.5;
        Wed, 11 Jan 2023 13:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISTjL+MLwJomeihw08czSYx5hsUEMJAxuuEa4KDRa1Y=;
        b=ocAZu4xoMxdobhuiCpQoSIr/gD1/HIHfk2rcVdWQM/5QeIeb6CmfF4Rtq2KG5xWaYP
         yKP8Meq1QSBIaSa6R6Z+CnlRE20/+NGVYI92dHaQjTQmmwO8IM2VRhsjl1KDF7b0jZ3F
         jRP8SI56R/ANvnzlp7w8ZSHP6DbII9g4euaM5gdMjXS71OcWL9QpQoUo4rEheYFypvop
         57gY9ot9QmtpS6TPazn2BCYyTP11fLCCuYDma46SvEEdINVZeECaz9vPEuArENmHKs+A
         X0ZCnOb/ujOaS3yhGS1IEqFu91bNlVz9SXgVahbsRFD8AE8iWu1QM88Q3VAvuhefJwPi
         zWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISTjL+MLwJomeihw08czSYx5hsUEMJAxuuEa4KDRa1Y=;
        b=gCIIvTjg8mfWDA6eG5Mnoz+rtG7gzoD6Gzhtb9ZDlxM9JTpV86YwtpsFAV0I0HqGFF
         krssj36sRwdwFORGuJ40yhN52puRIJ5ZmZMpWgh3CSZWjFxotzuRe4SvoV9zdkZfMdiL
         xy7gbs4Sf27Yc3S9MEPfCgq8ygUNFxeyOpdZvuiT0C5m1RlzXbkHP2b0ww3grn9A64pW
         tDWiVILoJXHllMRvN5ANvs4lIVdqFHsBxRRgfYjoMAECrd7HqBH0Lg3bi7qKgQoJL9vf
         qpoXkFBofREnzYN2waJDNH6wRmxgnz0dkmcVEql1TWmpgq6wLFeTkgkbe6+rKQdj6dee
         /LkQ==
X-Gm-Message-State: AFqh2kqNu/M9bdhimnc1ZBv1x4zLCB7gSDbjESdiVToh4/3/Kykzlr7W
        L1KsZWLoMjjpxzbwIF5dNcyuh8EW5mc=
X-Google-Smtp-Source: AMrXdXsk+tY19l2gg4OvLge5PiHulqA8S7U0UUF9w1BRvkKpIBaw4TMP15TXQySHp5Lcq3CEIlrrsQ==
X-Received: by 2002:aa7:c307:0:b0:499:b4ce:b26e with SMTP id l7-20020aa7c307000000b00499b4ceb26emr13590384edq.40.1673471655966;
        Wed, 11 Jan 2023 13:14:15 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7325-0300-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7325:300::e63])
        by smtp.googlemail.com with ESMTPSA id l4-20020a056402344400b004822681a671sm6485079edc.37.2023.01.11.13.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 13:14:15 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, neil.armstrong@linaro.org,
        jbrunet@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 6/6] arm64: dts: meson-gx: Fix the SCPI DVFS node name and unit address
Date:   Wed, 11 Jan 2023 22:13:50 +0100
Message-Id: <20230111211350.1461860-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
References: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
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

Node names should be generic and use hyphens instead of underscores to
not cause warnings. Also nodes without a reg property should not have a
unit-address. Change the scpi_dvfs node to use clock-controller as node
name without a unit address (since it does not have a reg property).

Fixes: 70db166a2baa ("ARM64: dts: meson-gxbb: Add SCPI with cpufreq & sensors Nodes")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
changes from v1 -> v2:
- new patch

 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index f8b115cd6775..a79a35e84281 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -250,7 +250,7 @@ scpi {
 		scpi_clocks: clocks {
 			compatible = "arm,scpi-clocks";
 
-			scpi_dvfs: scpi_clocks@0 {
+			scpi_dvfs: clock-controller {
 				compatible = "arm,scpi-dvfs-clocks";
 				#clock-cells = <1>;
 				clock-indices = <0>;
-- 
2.39.0

