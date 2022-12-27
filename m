Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA7B65691C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiL0Jv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiL0Jvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:51:55 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69472673;
        Tue, 27 Dec 2022 01:51:53 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso16788091pjp.4;
        Tue, 27 Dec 2022 01:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuPzabFK+ItSAS4Njr3Xe+weyJyvM5VjKuGON2TO41E=;
        b=F8J7oA8Lbv5Z2/cnu9xN69NUs+tjMghmpHUg/HEH+z3nW1b92eQxsf6wyxipVyfbew
         mgquQUvtjdNkUS9xw146qyzkFCdFHmihwEY0Mmlzm4EH/Rfs6QeIJiAy2ieyUhHKqMgk
         WzHLQBSNyfP3qKqunXY7ibSCYg1VpudEyBXqZp5TZgQ+eEeJpt0Pv66a4HmgkfixbHb6
         rpMBLhzIS4fpu28Jl005zYlPatbB2BDaeBwy2owSG/9ZK0cBRqV42jwTfNuoI2g4QJE8
         CXANHt0k6smMBur0Jl3nYMgz51IVxej5E3OlM+Byohf0OB7oa+lE7qHCnMFpT/ZJ6A+B
         z0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuPzabFK+ItSAS4Njr3Xe+weyJyvM5VjKuGON2TO41E=;
        b=d0TQNuYpTM8/OMrYsgNm+jvk0NZnXZAZ4Dc1J5WCjGW1K7N1eDMYskA4E6NFWdNdR7
         vsuB20hf3ShsIYcJY9j07PQ7psdFSe36RbTrYWHnAQaGUQcxwJxqDwsco+mPDoOD3AiW
         L89AUPsz5OOAMGeDSOHoNSy6EYDHs0kNh/M+uL839i0pgnFtVHzXI6Mety24/+C2+wyH
         vHwc0Zfys6O8EhR+xsb3xmc/6JtLhhpbb/oEA6wBteLvPEoYIxbfQxihxsLppFNe7V0P
         ojMr33rz/Y7CkpFKIn+3lOpNqkqc+9d0EuzrXLC5PeiNoKLi3V+pRQT2JkrW0nC8kSba
         B3Wg==
X-Gm-Message-State: AFqh2krB6dmT+VeSNW7Z1NpthZD3yhbQrc/8965Nq0VYi+x71GlGZJDQ
        pxZJ1k/2RiuZ1TcLhKnzotM=
X-Google-Smtp-Source: AMrXdXvZ0ihW3bCVl+gyhDG2Rk3F3CtAk8qiU/DoyxlhQnQFi7n7aLrrNdPAK8CNj9hTnNQK+B47sw==
X-Received: by 2002:a05:6a20:3c93:b0:b0:30d8:d53 with SMTP id b19-20020a056a203c9300b000b030d80d53mr32892588pzj.19.1672134713154;
        Tue, 27 Dec 2022 01:51:53 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 21-20020a621515000000b005813aec74bdsm2619052pfv.139.2022.12.27.01.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 01:51:52 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v10 1/7] ARM: dts: nuvoton: Add node for NPCM VCD and ECE engine
Date:   Tue, 27 Dec 2022 17:51:17 +0800
Message-Id: <20221227095123.2447948-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221227095123.2447948-1-milkfafa@gmail.com>
References: <20221227095123.2447948-1-milkfafa@gmail.com>
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

Add node for Video Capture/Differentiation Engine (VCD) and Encoding
Compression Engine (ECE) present on Nuvoton NPCM SoCs. Tested with
Nuvoton NPCM750 evaluation board.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index c7b5ef15b716..13a76689e14a 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -179,6 +179,24 @@ fiux: spi@fb001000 {
 			status = "disabled";
 		};
 
+		vcd: vcd@f0810000 {
+			compatible = "nuvoton,npcm750-vcd";
+			reg = <0xf0810000 0x10000>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_VCD>;
+			nuvoton,sysgcr = <&gcr>;
+			nuvoton,sysgfxi = <&gfxi>;
+			nuvoton,ece = <&ece>;
+			status = "disabled";
+		};
+
+		ece: video-codec@f0820000 {
+			compatible = "nuvoton,npcm750-ece";
+			reg = <0xf0820000 0x2000>;
+			resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_ECE>;
+			status = "disabled";
+		};
+
 		apb {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -554,6 +572,11 @@ i2c15: i2c@8f000 {
 				pinctrl-0 = <&smb15_pins>;
 				status = "disabled";
 			};
+
+			gfxi: gfxi@e000 {
+				compatible = "nuvoton,npcm750-gfxi", "syscon";
+				reg = <0xe000 0x100>;
+			};
 		};
 	};
 
-- 
2.34.1

