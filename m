Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AA462D0DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiKQBxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiKQBxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:53:40 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40162D7D;
        Wed, 16 Nov 2022 17:53:38 -0800 (PST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NCNHP0HlQz4xVnR;
        Thu, 17 Nov 2022 09:53:37 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NCNHM2811z501Qn;
        Thu, 17 Nov 2022 09:53:35 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AH1rUJd095330;
        Thu, 17 Nov 2022 09:53:30 +0800 (+08)
        (envelope-from guo.ziliang@zte.com.cn)
Received: from mapi (xaxapp03[null])
        by mapi (Zmail) with MAPI id mid32;
        Thu, 17 Nov 2022 09:53:31 +0800 (CST)
Date:   Thu, 17 Nov 2022 09:53:31 +0800 (CST)
X-Zmail-TransId: 2afb6375941bffffffffe743b8a8
X-Mailer: Zmail v1.0
Message-ID: <202211170953310238773@zte.com.cn>
Mime-Version: 1.0
From:   <guo.ziliang@zte.com.cn>
To:     <thinh.nguyen@synopsys.com>
Cc:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guo.ziliang@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHVzYjogZHdjMzogZ2FkZ2V0OiByZW1vdmUgcmVkdW5kYW50IHJldCB2YXJpYWJsZSBpbiBkd2MzX2dhZGdldF92YnVzX2RyYXc=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AH1rUJd095330
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63759421.000 by FangMail milter!
X-FangMail-Envelope: 1668650017/4NCNHP0HlQz4xVnR/63759421.000/192.168.251.13/[192.168.251.13]/mxct.zte.com.cn/<guo.ziliang@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63759421.000/4NCNHP0HlQz4xVnR
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: guo ziliang <guo.ziliang@zte.com.cn>
Return value from dwc3_gadget_vbus_draw() directly instead of taking
this in another redundant variable.

Signed-off-by: guo ziliang <guo.ziliang@zte.com.cn>
---
 drivers/usb/dwc3/gadget.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index faf37c6..d984d68 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2904,7 +2904,6 @@ static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 {
        struct dwc3             *dwc = gadget_to_dwc(g);
        union power_supply_propval      val = {0};
-       int                             ret;

        if (dwc->usb2_phy)
                return usb_phy_set_power(dwc->usb2_phy, mA);
@@ -2913,9 +2912,7 @@ static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
                return -EOPNOTSUPP;

        val.intval = 1000 * mA;
-       ret = power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
-
-       return ret;
+       return power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
 }

 /**
--
1.8.3.1
