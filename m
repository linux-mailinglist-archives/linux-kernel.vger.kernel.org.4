Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFA4722E5E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjFESKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjFESJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:09:50 -0400
X-Greylist: delayed 1651 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 11:09:49 PDT
Received: from egress-ip4b.ess.de.barracuda.com (egress-ip4b.ess.de.barracuda.com [18.185.115.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE57BE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 11:09:48 -0700 (PDT)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198]) by mx-outbound16-136.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 05 Jun 2023 18:09:46 +0000
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-53f84f75bf4so1841011a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 11:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1685988585; x=1688580585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka0dLgOU3SOSpHh8q74Sw3feQDmjVZ2vWBXiiwU0uuo=;
        b=e9FDF+t6FH/WKaDKzwT/sm4Amq1ktP9XYOtHu3gybOJgQ4MZmNFfHo7PF/DXeh/Qj4
         8VCvJoqvWNXKgeeRjg6OSWCxQJphkANTWfukDtLJCPqJloh4iY/rys6scNV9WsArqhZH
         58ThoUudgsk4PTvmYFxec2Ra8sULDC89jDZRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685988585; x=1688580585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ka0dLgOU3SOSpHh8q74Sw3feQDmjVZ2vWBXiiwU0uuo=;
        b=GUoe3izXX9mXQmdfyIe9VlDnZ/EK8CNRIGqa6xUBcgDDMyKvK46aPB1pIa8xbOQyig
         zL0fCsQCthloTEdxMeRQBpZZStmfcFz4em3W347LRzV4jiJoE+pfR9/FKLHKMJ/QB921
         z3SbV2U/ByPz7zt51RJv6nKftnQjJXZxDDSCYH65hi0udDrrqh3V9d2+y98P6QrxBplF
         YB4zPYbsHrk5IRS/IbyrfWo9Xu49m7/rueS8xy0a3wt1Bl3zWPM1yHNM45p5eK3wtFud
         h2xuQTpSH9/0D4LCzHnyODMONPALh4valXSgshLJ79NXVCyRtsNUkBWXrre9YC9KNQF5
         918Q==
X-Gm-Message-State: AC+VfDyKwpI1RBmK9ZEMsea7Aj82aJ9GAKZrQOLP+01QIA1FHnlp7pAk
        24IwMOpa7dz0nZ9WvdU4CiGZzbpe6YM3qdePtAh2MKZNpZqYNa1Uxcq4fut4UNzAylAdX35Rmoy
        GbWGcut/HD1UO1yPbG3CQ763R4yYuTiO3KvP0ACW+gTrguF6RoWsc/6sbT27w
X-Received: by 2002:a17:903:2305:b0:1b0:61dd:e523 with SMTP id d5-20020a170903230500b001b061dde523mr5054987plh.41.1685987159013;
        Mon, 05 Jun 2023 10:45:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5dFGH5RUHSCIKrPt8pUW9EBcAJtw6hTNlCcT2vaMXJ2vPnVhOOyVumgmm7oF8ujFweztfoAw==
X-Received: by 2002:a17:903:2305:b0:1b0:61dd:e523 with SMTP id d5-20020a170903230500b001b061dde523mr5054968plh.41.1685987158744;
        Mon, 05 Jun 2023 10:45:58 -0700 (PDT)
Received: from LAP789U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902860a00b001aaecc0b6ffsm6816616plo.160.2023.06.05.10.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 10:45:58 -0700 (PDT)
From:   sabiya.d@mistralsolutions.com
X-Google-Original-From: sabiya.d@ti.com
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, afd@ti.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sabiya.d@mistralsolutions.com,
        Dasnavis Sabiya <sabiya.d@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am69-sk: Add eMMC mmc0 support
Date:   Mon,  5 Jun 2023 23:15:51 +0530
Message-Id: <20230605174551.160262-1-sabiya.d@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1685988585-304232-5457-29635-1
X-BESS-VER: 2019.1_20230525.1947
X-BESS-Apparent-Source-IP: 209.85.215.198
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrKyMDYGMjKAYoapKZZpRmmmyR
        ZGqQZmZmkG5sbmSSaGJomW5uaGaYbmSrWxABee2KFAAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.248613 [from 
        cloudscan18-126.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 NO_REAL_NAME           HEADER: From: does not include a real name 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, NO_REAL_NAME, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dasnavis Sabiya <sabiya.d@ti.com>

Add support for eMMC card connected to main sdhci0 instance.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 4b7d9280d76f..ab8ec2cb396e 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -22,6 +22,7 @@ chosen {
 
 	aliases {
 		serial2 = &main_uart8;
+		mmc0 = &main_sdhci0;
 		mmc1 = &main_sdhci1;
 		i2c0 = &main_i2c0;
 	};
@@ -191,6 +192,14 @@ exp1: gpio@21 {
 	};
 };
 
+&main_sdhci0 {
+	/* eMMC */
+	status = "okay";
+	non-removable;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+};
+
 &main_sdhci1 {
 	/* SD card */
 	status = "okay";
-- 
2.25.1

