Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52A56D27C9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjCaS1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjCaS1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:27:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732641E728
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 11:27:32 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o11so22097833ple.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 11:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680287252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p4FGWSIPST9m6YTXbscC7ErUtHPtpC6n3urFFBCXSuI=;
        b=74oWXDIlBPU68uwXVejlOmomkabmhkdTDR+caL1MADEQSdjPjVuZ1dMDPKYm3jiBJz
         f89c39he3eNwXJGk9iAPuh7PGV5QlqHep+5CsA9D0jjjZt/ijv8kbwl4tOExrz03/UFv
         TJucNRYuNMDcIDYmsQUJs/CFGXH3IbzJL6nsSD3YASqmB3b8uJDdwCFHneyfAiEfKd//
         k2DilaXoubfPSHiuqOLWcY+cLX1kMibk9FbQY45f4ttJJBOyxxPLTMSX06VX6i1X1rO9
         ZP/zJsdxyDYzQG+uqof4J08lbr0lWdOdvCUFGCrR6LtqcbjSN60FwFniWzA2bSx8zsUx
         00jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680287252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4FGWSIPST9m6YTXbscC7ErUtHPtpC6n3urFFBCXSuI=;
        b=eRU7gEuC8GhQuuUu8wSa5o2fn7JnhL3TX7DRpSA40JFNs81qr7PdV56/fvsh0r/Rsw
         EPndoD/T0hcw6Q2wvOxt/yPruKRmcbElHcSI5yChT3HzE3TlO3ufXvJiKjr2o/7XgXm/
         gklcDSm0WYWfGfud7Nbwy/x58LKWIankuWOuuAmtZcV6JqOhJFJ/WoRoKk9SctKy6IB0
         OTU9dYAifr8rxRkxPqLJ2UW7ugRW516IvMilZkzJ7vFtbWnhXRoyI8u7FuJueJDUd1Gi
         algZ90L7rg2csfpPHLJZ/pq/l1A75KSyZbQTOOUj6pltNKzu9cPb/xIMbAgl7hp2UavN
         qRPA==
X-Gm-Message-State: AAQBX9e7+2onFNLgFOrg3Fl9lX6vOoPodU0nWm0bNeOy8StCHCZS8hud
        jZN+vValm1pb/2wBlJib9b1J/A==
X-Google-Smtp-Source: AKy350a/MDZEdFquMNruFsfiIdHNSmiDjW5khv2c+3EheVH0PNILA4FW8AGtniTzvagvyHWYVpCHPg==
X-Received: by 2002:a17:903:3093:b0:19d:1bc1:ce22 with SMTP id u19-20020a170903309300b0019d1bc1ce22mr23992076plc.5.1680287251852;
        Fri, 31 Mar 2023 11:27:31 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902b69400b0019f1027f88bsm1826795pls.307.2023.03.31.11.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 11:27:31 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     linux-sunxi@lists.linux.dev
Cc:     conor.dooley@microchip.com, Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>, Conor Dooley <conor@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Trevor Woerner <twoerner@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [RFC PATCH] riscv: dts: nezha-d1: Add memory
Date:   Fri, 31 Mar 2023 11:27:27 -0700
Message-Id: <20230331182727.4062790-1-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add memory info for the D1 Nezha, which seems to be required for it to
boot with the stock firmware. Note that this hardcodes 1GB, which is
not technically correct as they also make models with different amounts
of RAM. Is the firmware supposed to populate this?

Signed-off-by: Evan Green <evan@rivosinc.com>

---

 arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
index 4ed33c1e7c9c..6aba68cf5541 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
@@ -32,6 +32,12 @@ / {
 	model = "Allwinner D1 Nezha";
 	compatible = "allwinner,d1-nezha", "allwinner,sun20i-d1";
 
+	// FIXME: this is temporary.
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0x40000000>; /* 1 GB */
+	};
+
 	aliases {
 		ethernet0 = &emac;
 		ethernet1 = &xr829;
-- 
2.25.1

