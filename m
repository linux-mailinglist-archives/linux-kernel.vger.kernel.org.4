Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5074C6C69FE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjCWNw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjCWNwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:52:53 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6471A2685E;
        Thu, 23 Mar 2023 06:52:52 -0700 (PDT)
Received: from koko.localdomain ([89.1.213.94]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N4yyQ-1qdwlO2fga-010wFN; Thu, 23 Mar 2023 14:52:46 +0100
From:   Maximilian Weigand <mweigand@mweigand.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Maximilian Weigand <mweigand@mweigand.net>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 3/6] devicetree: input: cypress,tt21000: fix interrupt type in dts example
Date:   Thu, 23 Mar 2023 14:52:02 +0100
Message-Id: <20230323135205.1160879-4-mweigand@mweigand.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323135205.1160879-1-mweigand@mweigand.net>
References: <20230323135205.1160879-1-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qIRHCx+hkbhXBze+r4iUxTBMWw945kE6YSiCOBHDhHvt3/3CrxR
 94DoiYVCqgaI1UQyVpXt7mKk5kk23HsjbzE3DNgRtzqVamvxUamEONEYYGBI3shj6vXf5ZL
 xrcT+7+wzmE5UOBmOxpv0oThCR3ZN+8Z3c5q+Hphx05nuqbbHqn3QrA+KTofNo8QB0piNbQ
 Us2BGmt6tB4W14heshZ+w==
UI-OutboundReport: notjunk:1;M01:P0:xiNu1U2d/3I=;porqCJZTOTHXiR9QWnkuS8fhmv3
 X9I7SkTDuxJyVJ5wB2bZLuyXvRaOFrU6kSs5rdh/J2D8b4Ajqm0X8ox5b+LJ9hQK/4RcV2koG
 TWIInIt2ZKvnv4WPQgaqMpC4ulyxXKbI954AQMBAnXJzQqvdpF5xHTtOeGPREdoyluUw2bASA
 uK8SyWmc1FqdBega7XSoxer9xy3raN6wnzecR8dhtbkClyTmUJZ000kXHobAb3zfwQwurdSdT
 lGry9Arr3W4RCSyCx85D5UxjVj1PG0uGgb34tLYiKY8WV2oL4CN6hqGYjAZNqxwJ79C5NwPPX
 DskvydkJCo76tB4/IsMDA7x6LNgw2JrFp64nERRIJ4IePTz9x/Y9T7ASL4cX4TXUhAoC2LuKn
 x4ZriUSzGa4ag8dy7N3Ys5oBs3EuktIctaekd3Jnp0ECiso815HzcrA2SW2DcabOmitY/f4nA
 +gqt+XyZiU88dc1PoMTSRwhPjsj84V689XhMBlmaUl42U/RuinXcGpyNpmHHp+elodV71/mSB
 PPCxauBlwr6m3wkEM55vY3mhctThudx6AwAduxM8qiRsJqiZyIr8QRHgioxpl8qx/Ad4nAobZ
 Sy803tfbDEM6pWtvCUkoljwP2aCQwMn0eAqpZLZGflI5+aB7XyI6AidO61VEoL3W0dAE/3iqn
 DJjMQFZzC3VWHN4YqFZSNKltaEshSBQvSSI3SNj8ug==
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Triggering the interrupt of the IRQ_TYPE_LEVEL_LOW type can lead to
probing issues with the device for the current driver (encountered on
the Pine64 PineNote). Basically the interrupt would be triggered before
certain commands were sent to the device, leading to a race between the
device responding fast enough and the irq handler fetching a data frame
from it. Actually all devices currently using the driver already use a
falling edge trigger.

Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
Reviewed-by: Alistair Francis <alistair@alistair23.me>
---
 .../devicetree/bindings/input/touchscreen/cypress,tt21000.yaml  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
index 1959ec394768..a77203c78d6e 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
@@ -83,7 +83,7 @@ examples:
             pinctrl-names = "default";
             pinctrl-0 = <&tp_reset_ds203>;
             interrupt-parent = <&pio>;
-            interrupts = <1 5 IRQ_TYPE_LEVEL_LOW>;
+            interrupts = <1 5 IRQ_TYPE_EDGE_FALLING>;
             reset-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>;
             vdd-supply = <&reg_touch>;
 
-- 
2.39.2

