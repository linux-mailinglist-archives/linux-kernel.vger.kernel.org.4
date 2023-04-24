Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE94C6ED119
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDXPPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjDXPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:14:53 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1162F19F;
        Mon, 24 Apr 2023 08:14:53 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33OFEeu9006345;
        Mon, 24 Apr 2023 10:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682349280;
        bh=25Mc7hcaPXG/P1qb+ZMbwWTj3CmYxbl7UyEfe0Iu+1M=;
        h=From:To:CC:Subject:Date;
        b=xSzl1I05+opM2votEz8RDLGMlybwsZ/6Uf8rtzOK4OzOhJPzqucZVh2Z7Ova5vAOm
         AwOOcJ5fLQpct3VQEjyOIjU5IJpq/iIXG8eo0hWZUvmvMYDc4kncJJU2pD8ne1ygbG
         oF62zqvbQ0dZmTKjsIialdrx+hPUDQx8icQRSgZc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33OFEeoK105518
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Apr 2023 10:14:40 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 24
 Apr 2023 10:14:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 24 Apr 2023 10:14:38 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33OFEc86101702;
        Mon, 24 Apr 2023 10:14:38 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@ucw.cz>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] dt-bindings: leds: Drop redundant cpus enum match
Date:   Mon, 24 Apr 2023 10:14:37 -0500
Message-ID: <20230424151437.256073-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e91a4d5deb96 ("dt-bindings: leds: Document commonly used
LED triggers") introduced a enum match for cpu, while a pattern
'^cpu[0-9]*$' already exists.

This causes linux,default-trigger = "cpu" to have more than one match
and generates the following dtbs_check warning:

arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dtb: leds: led-2:linux,default-trigger: More than one condition true in oneOf schema:
	{'$ref': '/schemas/types.yaml#/definitions/string',
	 'oneOf': [{'items': [{'enum': ['backlight',
	                                'default-on',
	                                'heartbeat',
	                                'disk-activity',
	                                'disk-read',
	                                'disk-write',
	                                'timer',
	                                'pattern',
	                                'audio-micmute',
	                                'audio-mute',
	                                'bluetooth-power',
	                                'cpu',
	                                'flash',
	                                'kbd-capslock',
	                                'mtd',
	                                'nand-disk',
	                                'none',
	                                'torch',
	                                'usb-gadget',
	                                'usb-host',
	                                'usbport']}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {'items': [{'pattern': '^cpu[0-9]*$'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {'items': [{'pattern': '^hci[0-9]+-power$'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {'items': [{'pattern': '^mmc[0-9]+$'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'},
	           {'items': [{'pattern': '^phy[0-9]+tx$'}],
	            'maxItems': 1,
	            'minItems': 1,
	            'type': 'array'}]}

Drop the explicit match against cpu since the pattern match already
covers the same.

Fixes: e91a4d5deb96 ("dt-bindings: leds: Document commonly used LED triggers")
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 Documentation/devicetree/bindings/leds/common.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index 11aedf1650a1..58b492d00246 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -105,8 +105,6 @@ properties:
           - audio-mute
             # LED indicates bluetooth power state
           - bluetooth-power
-            # LED indicates activity of all CPUs
-          - cpu
             # LED indicates camera flash state
           - flash
             # LED indicated keyboard capslock
-- 
2.40.0

