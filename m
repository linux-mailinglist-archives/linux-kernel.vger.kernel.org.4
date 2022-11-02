Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21414616075
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiKBKHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiKBKG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:06:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64AF23E91;
        Wed,  2 Nov 2022 03:06:55 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N2MxP6Dghzbc85;
        Wed,  2 Nov 2022 18:06:49 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 18:06:53 +0800
From:   Yihang Li <liyihang9@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <bvanassche@acm.org>, <john.garry@huawei.com>,
        <chenxiang66@hisilicon.com>, <daejun7.park@samsung.com>,
        <damien.lemoal@opensource.wdc.com>, <yanaijie@huawei.com>,
        <duoming@zju.edu.cn>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <yangxingui@huawei.com>, <linuxarm@huawei.com>,
        <liyihang9@huawei.com>
Subject: [PATCH] scsi: libsas: Check and update the link rate during discovery
Date:   Wed, 2 Nov 2022 18:05:55 +0800
Message-ID: <20221102100555.3537275-1-liyihang9@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

   +----------+              +----------+
   |          |              |          |
   |          |--- 12.0 G ---|          |--- 12.0 G --- SAS  disk
   |initiator |              | Expander |
   | device   |--- 12.0 G ---|          |--- 12.0 G --- SAS  disk
   |          |              |          |
   |          |--- 12.0 G ---|          |--- 6.0 G --- SATA disk
   |          |              |          |
   |      phy0|--- 12.0 G ---|          |--- 6.0 G --- SATA disk
   |          |              |          |
   +----------+              +----------+

In the scenario where the expander device is connected to a wide port,
the preceding figure shows the link topology after initialization.
All physical PHYs negotiate connections at the rate of 12 Gbit, and
the expander SATA PHY negotiates connections at the rate of 6 Gbit.

We found that when the FIO was running, if phy0 was link down due to link
instability, and the link connection was reestablished after a period of
time. During the physical link disconnection, the physical PHY gradually
decreases the link rate, attempts to renegotiate the link rate and
establish the connection. This is an HW behavior. When the physical PHY
try to re-establish the link at a link rate of 3 Gbit and the physical
link is successfully established, the negotiated link rate is 3 Gbit.
Like this:

   +----------+              +----------+
   |          |              |          |
   |          |--- 12.0 G ---|          |--- 12.0 G --- SAS  disk
   |initiator |              | Expander |
   | device   |--- 12.0 G ---|          |--- 12.0 G --- SAS  disk
   |          |              |          |
   |          |--- 12.0 G ---|          |--- 6.0 G --- SATA disk
   |          |              |          |
   |      phy0|--- 3.0 G ----|          |--- 6.0 G --- SATA disk
   |          |              |          |
   +----------+              +----------+

SATA disk which connected to expander PHY maybe reject IO request due to
the connection setup error (OPEN_REJECT-CONNECTION RATE NOT SUPPORTED).
The log as follows:

[175712.419423] hisi_sas_v3_hw 0000:74:02.0: erroneous completion iptt=2985 task=00000000268357f1 dev id=10 exp 0x500e004aaaaaaa1f phy9 addr=500e004aaaaaaa09 CQ hdr: 0x102b 0xa0ba9 0x1000 0x20000 Error info: 0x200 0x0 0x0 0x0

After analysis, it is concluded that: when one of the physical links
connected on the wide port is re-established, the link rate of the port
and expander device and the expander SATA PHY are not updated. As a
result, the expander PHY attached to a SATA PHY is using link rate
(6.0 Gbit) greater than the physical PHY link rate (3.0 Gbit).

Therefore, add function sas_check_port_linkrate() to check whether the
link rate of physical PHY which is connected to the wide port changes
after the phy up occur, if the link rate of the newly established
physical phy is lower than the link rate of the port, a smaller link rate
value is transmitted to port->linkrate.

Use the sas_update_linkrate_root_expander() function to update the root
expander link rate. Traverse all expanders connected to the port, check
and update expander PHYs that need to be updated and triggers revalidation.

Signed-off-by: Yihang Li <liyihang9@huawei.com>
---
 drivers/scsi/libsas/sas_discover.c | 19 ++++++-
 drivers/scsi/libsas/sas_expander.c | 79 ++++++++++++++++++++++++++++++
 drivers/scsi/libsas/sas_internal.h |  1 +
 3 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index 110549030bcf..57b5446a3a21 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -164,6 +164,20 @@ static int sas_get_port_device(struct asd_sas_port *port)
 	return 0;
 }
 
+static void sas_check_port_linkrate(struct asd_sas_port *port)
+{
+	u32 link_rate = port->linkrate;
+	struct asd_sas_phy *phy;
+
+	list_for_each_entry(phy, &port->phy_list, port_phy_el)
+		link_rate = min(link_rate, phy->linkrate);
+
+	if (port->linkrate != link_rate) {
+		port->linkrate = link_rate;
+		sas_update_linkrate_root_expander(port->port_dev);
+	}
+}
+
 /* ---------- Discover and Revalidate ---------- */
 
 int sas_notify_lldd_dev_found(struct domain_device *dev)
@@ -434,8 +448,11 @@ static void sas_discover_domain(struct work_struct *work)
 
 	clear_bit(DISCE_DISCOVER_DOMAIN, &port->disc.pending);
 
-	if (port->port_dev)
+	if (port->port_dev) {
+		if (dev_is_expander(port->port_dev->dev_type))
+			sas_check_port_linkrate(port);
 		return;
+	}
 
 	error = sas_get_port_device(port);
 	if (error)
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 5ce251830104..6f067cc6f2e2 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1951,6 +1951,75 @@ static int sas_discover_new(struct domain_device *dev, int phy_id)
 	return res;
 }
 
+static void sas_ex_update_linkrate(struct domain_device *parent)
+{
+	struct expander_device *ex = &parent->ex_dev;
+	int i = 0, end = ex->num_phys;
+
+	for ( ; i < end; i++) {
+		struct ex_phy *ex_phy = &ex->ex_phy[i];
+		struct domain_device *child;
+
+		list_for_each_entry(child, &parent->ex_dev.children, siblings)
+			if (SAS_ADDR(child->sas_addr) ==
+			    SAS_ADDR(ex_phy->attached_sas_addr))
+				break;
+
+		if (dev_is_sata(child)) {
+			if (child->linkrate > parent->min_linkrate) {
+				struct sas_phy_linkrates rates = {
+					.maximum_linkrate = parent->min_linkrate,
+					.minimum_linkrate = parent->min_linkrate,
+				};
+
+				sas_smp_phy_control(parent, i,
+						    PHY_FUNC_LINK_RESET, &rates);
+				ex_phy->phy_change_count = -1;
+			}
+		}
+
+		if (dev_is_expander(child->dev_type)) {
+			child->min_linkrate = min(parent->min_linkrate,
+						  ex_phy->linkrate);
+			child->max_linkrate = max(parent->max_linkrate,
+						  ex_phy->linkrate);
+			child->linkrate = min(ex_phy->linkrate,
+					      child->max_linkrate);
+			ex_phy->phy_change_count = -1;
+		}
+	}
+}
+
+static void sas_ex_level_update(struct asd_sas_port *port, const int level)
+{
+	struct domain_device *dev;
+
+	list_for_each_entry(dev, &port->dev_list, dev_list_node) {
+		if (dev_is_expander(dev->dev_type)) {
+			struct sas_expander_device *ex =
+				rphy_to_expander_device(dev->rphy);
+
+			if (level == ex->level)
+				sas_ex_update_linkrate(dev);
+		}
+	}
+}
+
+void sas_update_linkrate_root_expander(struct domain_device *dev)
+{
+	struct asd_sas_port *port = dev->port;
+	struct sas_expander_device *ex = rphy_to_expander_device(dev->rphy);
+	int level;
+
+	dev->linkrate = port->linkrate;
+	dev->min_linkrate = port->linkrate;
+	dev->max_linkrate = port->linkrate;
+	dev->ex_dev.ex_change_count = -1;
+
+	for (level = ex->level; level <= port->disc.max_level; level++)
+		sas_ex_level_update(port, level);
+}
+
 static bool dev_type_flutter(enum sas_device_type new, enum sas_device_type old)
 {
 	if (old == new)
@@ -2013,6 +2082,7 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 	} else if (SAS_ADDR(sas_addr) == SAS_ADDR(phy->attached_sas_addr) &&
 		   dev_type_flutter(type, phy->attached_dev_type)) {
 		struct domain_device *ata_dev = sas_ex_to_ata(dev, phy_id);
+		enum sas_linkrate linkrate = phy->linkrate;
 		char *action = "";
 
 		sas_ex_phy_discover(dev, phy_id);
@@ -2021,6 +2091,15 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
 			action = ", needs recovery";
 		pr_debug("ex %016llx phy%02d broadcast flutter%s\n",
 			 SAS_ADDR(dev->sas_addr), phy_id, action);
+
+		if (linkrate != phy->linkrate) {
+			pr_debug("ex %016llx phy%d linkrate changed from %d to %d\n",
+				 SAS_ADDR(dev->sas_addr), phy_id,
+				 linkrate, phy->linkrate);
+			sas_unregister_devs_sas_addr(dev, phy_id, last);
+			phy->phy_change_count = -1;
+			ex->ex_change_count = -1;
+		}
 		return res;
 	}
 
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index b54bcf3c9a9d..d26ef24370f6 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -48,6 +48,7 @@ int sas_show_oob_mode(enum sas_oob_mode oob_mode, char *buf);
 
 int  sas_register_phys(struct sas_ha_struct *sas_ha);
 void sas_unregister_phys(struct sas_ha_struct *sas_ha);
+void sas_update_linkrate_root_expander(struct domain_device *dev);
 
 struct asd_sas_event *sas_alloc_event(struct asd_sas_phy *phy, gfp_t gfp_flags);
 void sas_free_event(struct asd_sas_event *event);
-- 
2.30.0

