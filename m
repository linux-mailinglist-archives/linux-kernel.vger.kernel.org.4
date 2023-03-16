Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCDB6BCE95
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjCPLl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCPLlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:41:23 -0400
Received: from egress-ip33b.ess.de.barracuda.com (egress-ip33b.ess.de.barracuda.com [18.185.115.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E796110
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:41:18 -0700 (PDT)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200]) by mx-outbound19-80.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 16 Mar 2023 11:41:16 +0000
Received: by mail-pl1-f200.google.com with SMTP id bh9-20020a170902a98900b0019e506b80d0so853401plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1678966875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cw0OJIVOqo5ioIagK89/DB9qVdzvhD7/kjEKYWm/ENA=;
        b=gdM52pJiD+OhE2sOot6P45KGiKXuQHtkqYD+xaMQNYZzEtQgU2okLaqmmNagvhhA4t
         BVmTTX9/95dR3O5Y5GBAL18RcxL3WHjxpnnlh/B9X7GBWoiNJisnP3Hnq2gcfPfYD6We
         cVAU/St/+ZJ514WimT7QPlKIJgaz0hmR0AnjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678966875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cw0OJIVOqo5ioIagK89/DB9qVdzvhD7/kjEKYWm/ENA=;
        b=w0JAbGeoossNgmJeVychRuYqBa60MXeREJwxE2SN/3wOp3yJpHW1C9FIs18GEFLqYM
         IIqgZlqGknVJnYFAC8GL6uy5t1UKbSxz/lWK9Bk//T0ZZKlfyo+ClB1qE8yIJpIJYoFm
         O87aj3eMB7fwwVIgh0I9+6EgGW1lQj6oa0b1P4cnak3gnXKauGwXb+w7YP1Z+r29C0U4
         hgnmeLg3cVcPthb6m2B21Uv7B5SOkB4GF+BV6rmiDHitOHIByiBDmuAX9uspLdHw9nMB
         1BAFFRiGm7kRHl2O55qfI6VTX93nbIbPHIPT3bmvnfAF+sEaVCqv6NQaEIcbXLPlaWiC
         Dv+w==
X-Gm-Message-State: AO0yUKVqgVTtABRYGOB0Akvs2qRJhvKQRh6hto5OE/JvI2XSTtIuNDAp
        Qz7eED6991E6rqJwzaxfOF4iMYf/HTvI4BxrmwXSPVCE+uq02MlI+7jKPpgR4vRZp9Ap/N4VdM8
        MCm1hVgmjgP7dXHEkKpQh+LPP04K79nBwsFoibhkViXwBG2fHNZOdgextFcDI
X-Received: by 2002:a62:1dc3:0:b0:622:749a:b9de with SMTP id d186-20020a621dc3000000b00622749ab9demr2725214pfd.27.1678966875578;
        Thu, 16 Mar 2023 04:41:15 -0700 (PDT)
X-Google-Smtp-Source: AK7set+q32ggKQf1VC1MqiNGrMtshBYBo8jvtwgppynyH06wLlJX1mLQ8OSM/B5K6s8VsHS08vt9vw==
X-Received: by 2002:a62:1dc3:0:b0:622:749a:b9de with SMTP id d186-20020a621dc3000000b00622749ab9demr2725196pfd.27.1678966875261;
        Thu, 16 Mar 2023 04:41:15 -0700 (PDT)
Received: from localhost.localdomain ([49.207.217.20])
        by smtp.gmail.com with ESMTPSA id j9-20020aa78dc9000000b00571f66721aesm5284534pfr.42.2023.03.16.04.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 04:41:14 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V3 1/2] arm64: dts: ti: k3-j721s2-mcu-wakeup: Fix IO PADCONFIG size for wakeup domain
Date:   Thu, 16 Mar 2023 17:11:01 +0530
Message-Id: <20230316114102.3602-2-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230316114102.3602-1-sinthu.raja@ti.com>
References: <20230316114102.3602-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1678966876-304944-5516-18129-1
X-BESS-VER: 2019.1_20230310.1716
X-BESS-Apparent-Source-IP: 209.85.214.200
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyNDIyBbIygIImhmZGiUlmKS
        bGKQYmJiZp5hZpKZYmBimGBpbJlskWqUq1sQBevZ/pQQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.246833 [from 
        cloudscan17-19.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

The size of wkup domain I/O PADCONFIG register set is incorrect for J721S2.
Therefore, update the PADCONFIG total offset size to the correct value for
J721S22 SoC.

Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---

Changes in V3:
- Added Fix tag

Changes in V2:
- Update commit description.
- Update the offset value to 0x194 because 0x190 is the last register of the
  IO PADCONFIG register set.

 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 0af242aa9816..b10f1e8b98e6 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -50,7 +50,7 @@ mcu_ram: sram@41c00000 {
 	wkup_pmx0: pinctrl@4301c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
-		reg = <0x00 0x4301c000 0x00 0x178>;
+		reg = <0x00 0x4301c000 0x00 0x194>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
-- 
2.36.1

