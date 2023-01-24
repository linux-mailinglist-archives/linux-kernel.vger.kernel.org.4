Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFDA679732
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjAXMDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjAXMDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:03:33 -0500
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400CC29E14
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:03:32 -0800 (PST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71]) by mx-outbound14-52.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 24 Jan 2023 12:03:29 +0000
Received: by mail-pj1-f71.google.com with SMTP id om10-20020a17090b3a8a00b002299e350deaso11049206pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQ693edVcrcIyz2x2JQZUAk9H10CE/9UA6BBrlOFNfQ=;
        b=e8iksw4pCTpUz1j6BDQMQVtJhn+lLNhuJLBJZkIoqkxVlgvyQloJr6Mchq86nJqChG
         N686KtqEDiW7k9g9arPfPNvtxsmH2U5smj2gKEkZkYbPa35yawnuXzdegr1y1Bem6WK3
         Mq02/exDGadVB2AmgDgcZrmOC9Hfac3PjUqq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ693edVcrcIyz2x2JQZUAk9H10CE/9UA6BBrlOFNfQ=;
        b=reol3N1QEy6denL/X7hj/s97jI4w5yDbnlLMB78+jBKfpTuR7Q5zck/BsOUmjSQmeh
         Bbxi9xwHj8UYQh5jcFdG4pZ2wHi3YD69IbgsrobL2P7wqxIJV5w+YshOiTOs7oAJlO4G
         cbm0Kfkuwr9AMvw0NlKb6FjsWOuX7DGtx1Olw/CObn9xbJQDbHQh91UQsZ36DiXiWz6w
         kwrR6cLu8ZC9ve2C409cTEfqklUnhZNg8/VzDwLoylntH4VxzSth6qBASO4mCJOoNbIc
         bpyyxATYpIc4v1+ZXka3cAWujW13jQgA9lEJvND2HVbEKOwpKSp40fIFn826DLZdh44g
         /Y9A==
X-Gm-Message-State: AFqh2krBcB9B4HZtD8bS3wyF/1y+Yniy75YRSIPgu3foc+fGuPpcgk+B
        L2JR6q9I81IjxDpp9PR8LIMhvjeRxt2NadrYbvfKWp5iwwsTyiISMziVfnANY8RU7Cr7Tp1FY2i
        Fys1uZX8AQbS7boR/zUeF8XlvLkAfPkccxxYOwXP8ejjJcLqKxMEwpFAIZNiN
X-Received: by 2002:a62:388a:0:b0:581:140:f3b6 with SMTP id f132-20020a62388a000000b005810140f3b6mr27044385pfa.34.1674561808317;
        Tue, 24 Jan 2023 04:03:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuAetFMB/8KTSOS5CNwQdlV8dXVjfa0mFlh/b7rIgVXGQvDOqf9lkG9ptLhBdCZGpRnpsUY9Q==
X-Received: by 2002:a62:388a:0:b0:581:140:f3b6 with SMTP id f132-20020a62388a000000b005810140f3b6mr27044364pfa.34.1674561808019;
        Tue, 24 Jan 2023 04:03:28 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id j10-20020aa783ca000000b00581ad007a9fsm1414539pfn.153.2023.01.24.04.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 04:03:27 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V2 1/2] arm64: dts: ti: k3-j721s2-mcu-wakeup: Fix IO PADCONFIG size for wakeup domain
Date:   Tue, 24 Jan 2023 17:33:10 +0530
Message-Id: <20230124120311.7323-2-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230124120311.7323-1-sinthu.raja@ti.com>
References: <20230124120311.7323-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1674561808-303636-5377-761-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.216.71
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245676 [from 
        cloudscan15-117.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

The size of wkup domain I/O PADCONFIG register set is incorrect for J721S2.
Therefore, update the PADCONFIG total offset size to the correct value for
J721S2 SoC.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---

Changes in V2:
- Update commit description.
- Update the offset value to 0x194 as 0x190 is the last register of the
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

