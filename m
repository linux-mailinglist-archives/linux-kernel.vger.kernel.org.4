Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574656924AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjBJRi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjBJRiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:38:50 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5380078D69;
        Fri, 10 Feb 2023 09:38:49 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o18so5808576wrj.3;
        Fri, 10 Feb 2023 09:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2xLyJ53huQXvmhIZNGemIcemfb0LptCrFwxhBre8f0=;
        b=QeXug14ZYhPwh1A1nviyUmCNZR+UPZMEuJoTlsG1KDTelZQOtYWRk4jM0MwlyUyccr
         i8y7Sc8uDWxsU4I2grHQAoA7l2UEXUwMS6xa4l8hIHl0wshPvoP9vaZaNwOXQYuoQqFa
         eJAl5PubnAp+T0+lrfSfLRAaWBBjeKR0x2R3h/I+lkVL9SqbHHJex9NhU1z9vICs2ZrQ
         Gi64XUMraReUY5y7j5k92Fln6HNw0eqDFGMSnVOxRL9UJ+J53h7jOVklgrDpFkoeGRDi
         H5rkDljfXIHz9CPxIvxVEkTP50Qx3xUAW+Nl4iKv1AARdEMmLVztqdiK4Hm/1gbg0+jo
         I8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2xLyJ53huQXvmhIZNGemIcemfb0LptCrFwxhBre8f0=;
        b=w3wR2O7mQ6xvJcD+I8vAdntKB0wI75gSvrR4ld4k22BnwKlxIH6oSafSvE2Z23kUEg
         p92lYE/t/x9rSZAnESki9ZUXajbDXDCk68jJSi3dCaYBcQPDiCWW2YRoUNGN85j0XSYt
         /glVpcIVjSQHPI4y1syweXkyVx6olZ0lAvsHiSefaDIyc3Uh4WNqC/fSEcC2QzX+oW+X
         oE2yHz44XGpUq7BD0GPGmhLTtqQEv14V/gIZC1aGKwdsNN4RqgTuumEyW6qM3ptsGgzw
         sWzmznNJIYFTYUeJbQHMW0wX+sz2UhpcC+viViXyllMVvPkO2JJ22ZWUn6riSVOMGeoV
         f4bw==
X-Gm-Message-State: AO0yUKUgvTRbi8r8fWjDwzVcCobSuePqDhM2c8Z38u7AxRoNPookRFCh
        AMcTl4LXkumwio6Q593KzoathbAiAaM=
X-Google-Smtp-Source: AK7set9d8R2n74KRRpb/gH9QTXaWCfqv/EbYCh2oQQsd2asD/crb95F5is94KTSd+CjR6OLYT2QA7Q==
X-Received: by 2002:adf:dc04:0:b0:2c3:ea92:3494 with SMTP id t4-20020adfdc04000000b002c3ea923494mr13961199wri.55.1676050727559;
        Fri, 10 Feb 2023 09:38:47 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id t2-20020a0560001a4200b002c3ef7e74bdsm4024184wry.73.2023.02.10.09.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:38:47 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 2/4] mips: dts: ralink: mt7621: add phandle to system controller node for watchdog
Date:   Fri, 10 Feb 2023 18:38:39 +0100
Message-Id: <20230210173841.705783-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210173841.705783-1-sergio.paracuellos@gmail.com>
References: <20230210173841.705783-1-sergio.paracuellos@gmail.com>
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

To allow to access system controller registers from watchdog driver code
add a phandle in the watchdog 'wdt' node. This avoid using arch dependent
operations in driver code.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 5ca40fd21..764916eaf 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -73,6 +73,7 @@ sysc: syscon@0 {
 		wdt: wdt@100 {
 			compatible = "mediatek,mt7621-wdt";
 			reg = <0x100 0x100>;
+			mediatek,sysctl = <&sysc>;
 		};
 
 		gpio: gpio@600 {
-- 
2.25.1

