Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE3973294B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbjFPHw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjFPHwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:52:53 -0400
Received: from mail-m11879.qiye.163.com (mail-m11879.qiye.163.com [115.236.118.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E47272A;
        Fri, 16 Jun 2023 00:52:51 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11879.qiye.163.com (Hmail) with ESMTPA id 850126804B5;
        Fri, 16 Jun 2023 15:52:44 +0800 (CST)
From:   Frank Wang <frank.wang@rock-chips.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, sebastian.reichel@collabora.com,
        heiko@sntech.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com,
        Frank Wang <frank.wang@rock-chips.com>
Subject: [v4,2/2] usb: typec: tcpm: add get max power support
Date:   Fri, 16 Jun 2023 15:52:41 +0800
Message-Id: <20230616075241.27690-2-frank.wang@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616075241.27690-1-frank.wang@rock-chips.com>
References: <20230616075241.27690-1-frank.wang@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0wdTlYYHUodHklKQxlDGUJVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkpLT0tDVUpLS1VLWQ
        Y+
X-HM-Tid: 0a88c33140312eb5kusn850126804b5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBg6LQw6ET1DIhceSy4tCwJJ
        LRpPCk9VSlVKTUNNQktKQk1OTklPVTMWGhIXVR0JGhUQVQwaFRw7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISExDNwY+
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
Changelog:
v4:
 - No change

v3:
 - Use Microwatts instead of Milliwatts to follow the ABI, commented by Sebastian Reichel.

v2:
 - No change

v1:
 - https://patchwork.kernel.org/project/linux-usb/patch/20230313025843.17162-4-frank.wang@rock-chips.com/

 drivers/usb/typec/tcpm/tcpm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 9f6aaa3e70ca8..829d75ebab422 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6340,6 +6340,27 @@ static int tcpm_psy_get_current_now(struct tcpm_port *port,
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
@@ -6369,6 +6390,9 @@ static int tcpm_psy_get_prop(struct power_supply *psy,
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

