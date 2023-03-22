Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE686C4676
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCVJbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCVJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:31:41 -0400
Received: from mail-m11879.qiye.163.com (mail-m11879.qiye.163.com [115.236.118.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901FFDE;
        Wed, 22 Mar 2023 02:31:29 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11879.qiye.163.com (Hmail) with ESMTPA id 75C95680250;
        Wed, 22 Mar 2023 17:31:22 +0800 (CST)
From:   Frank Wang <frank.wang@rock-chips.com>
To:     sebastian.reichel@collabora.com, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        heiko@sntech.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com,
        Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v3] usb: typec: tcpm: add get max power support
Date:   Wed, 22 Mar 2023 17:31:20 +0800
Message-Id: <20230322093120.8686-1-frank.wang@rock-chips.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxhKQ1ZIQ0lLT0oYGE1CHU5VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpMVUpLS1VLWQ
        Y+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oi46DBw6Lj0JNRQBMzQWOSsL
        AR0wCylVSlVKTUxCT0xMT0NISE5IVTMWGhIXVR0JGhUQVQwaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0NPNwY+
X-HM-Tid: 0a8708a8a5532eb5kusn75c95680250
X-HM-MType: 1
X-Spam-Status: No, score=1.5 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Traverse fixed pdos to calculate the maximum power that the charger
can provide, and it can be get by POWER_SUPPLY_PROP_INPUT_POWER_LIMIT
property.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 13830b5e2d09f..db2636ef511bc 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6320,6 +6320,27 @@ static int tcpm_psy_get_current_now(struct tcpm_port *port,
 	return 0;
 }
 
+static int tcpm_psy_get_input_power_limit(struct tcpm_port *port,
+					  union power_supply_propval *val)
+{
+	unsigned int src_mv, src_ma, max_src_uw = 0;
+	unsigned int i, tmp;
+
+	for (i = 0; i < port->nr_source_caps; i++) {
+		u32 pdo = port->source_caps[i];
+
+		if (pdo_type(pdo) == PDO_TYPE_FIXED) {
+			src_mv = pdo_fixed_voltage(pdo);
+			src_ma = pdo_max_current(pdo);
+			tmp = src_mv * src_ma;
+			max_src_uw = tmp > max_src_uw ? tmp : max_src_uw;
+		}
+	}
+
+	val->intval = max_src_uw;
+	return 0;
+}
+
 static int tcpm_psy_get_prop(struct power_supply *psy,
 			     enum power_supply_property psp,
 			     union power_supply_propval *val)
@@ -6349,6 +6370,9 @@ static int tcpm_psy_get_prop(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		ret = tcpm_psy_get_current_now(port, val);
 		break;
+	case POWER_SUPPLY_PROP_INPUT_POWER_LIMIT:
+		tcpm_psy_get_input_power_limit(port, val);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
-- 
2.17.1

