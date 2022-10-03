Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F365F2769
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 02:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiJCApR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 20:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJCApP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 20:45:15 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2055.outbound.protection.outlook.com [40.107.96.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C4D2AC66;
        Sun,  2 Oct 2022 17:45:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuXVwVs4sm7nUXwebXJ9atTqKFU0w6ImvKGWCJzUjcnW82smgx3lzm13dKQw/YsGui1ynECuIvqdImHb1xE1x2OBygGt9KUC9SGuXpAXUmZkjQwfBIxmReLS2kVNHXyn/qi5I0x3UyytDhrrT74xb+vaVt9aJDyyM7Etgc+6We1oW8i9IVyXsarOXtyYBhqmF11/O+gj2aHVZXWVG251leDpfqcA5liFb2gYXyU7ek5Oku7hfau0g8bA2HQ6sk2yvkTflUX6Cu2Rg2XIhQJ6t9VDjf+aPXeoawAV2eAxucw54a1Ea+f0judb5BWl2mzDyxkhzpd/4NPPKM78hKBi2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJZ+avtP29sOH9sxuKDVmg9vq4zpHZAEqHhlawS3fs0=;
 b=oRY77iVVb2BDQyQiB6/soLdtTvrze7aHTtL+MoP7Ws1mbc4ugN1+xKRxTmyrUK5Ptc9wB5HMzPkbSDWT5Y+V9/MBL+r626xcB//L+EnM4iJlDAapACIcnAb4M2/Q3Uy8l0wX6lM2/0tyRl61LMh21XKYq7i7Vv4r5v75QzZns6aQPG+tXGeizwCRKtIb+/NwNOoS4hzj3hYNmQivD7s+0LSyanhoM4sweD7m0hJ4wCuM4j7yW7DCH4tXRTbKr6dzE4AUqpGIPmJ27xYjrgx4EkR2lpPqrB/idXQGAIVqi6mH3IIh7CoBcDOOgcyzdZ+xGZejeB7VPRofhurws6njTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=samsung.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJZ+avtP29sOH9sxuKDVmg9vq4zpHZAEqHhlawS3fs0=;
 b=k/ZoG6SGjiwgGZkM8VvEYXCMeN1+Zdt8svi6SRoRAjddG2sE7OlgxGMNPeLMiBu0COGZ0foodWGRT4GE+wvCRv5du7MFowIBGyyB+3I7r10Qa+F6m2R0B3BwAqMvu+ZN+kFm0GJzKxaazjSmkV24sBVZS3SrmGMU7RfhPlPfLnUZYrTvha+uGW+OrtYObJWX5bV0dFWZT6KPG5GuRThafMqyjmzRv7SY+G/w4S+ff8V5TuQ2IPbdCzuGphnnJ5d8gjBSDa1cwxllLuHgAEr7pj8ADto9xSYvNiBwu19jVCQtqnTVG4C21ima1EEDEDszYNjS3hcovE/v1mIJRfXuOQ==
Received: from BN9PR03CA0392.namprd03.prod.outlook.com (2603:10b6:408:111::7)
 by MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 00:45:10 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::80) by BN9PR03CA0392.outlook.office365.com
 (2603:10b6:408:111::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Mon, 3 Oct 2022 00:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Mon, 3 Oct 2022 00:45:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 2 Oct 2022
 17:45:01 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 2 Oct 2022
 17:45:01 -0700
Received: from pc.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Sun, 2 Oct
 2022 17:44:59 -0700
From:   Johnny Liu <johnliu@nvidia.com>
To:     <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
        <cw00.choi@samsung.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Johnny Liu <johnliu@nvidia.com>
Subject: [PATCH] devfreq: Support device update function
Date:   Mon, 3 Oct 2022 08:44:01 +0800
Message-ID: <20221003004401.21165-1-johnliu@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|MW4PR12MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 8588fa58-4a8a-44ac-481f-08daa4d885e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wffirprby069XfprGjoTrWRgdv0Rvx1Veu8aD8XQU2H+LOLtWr1F15BDpor7jpXuTsMz/j7oYLZ/Cp840LBdyLdx5HjMfx4cWNCJiIBlJyTfKWSzAiB0RiuMUKXvItAKXqRlv9aHnjxbqK8wOX77Mbp78psbs0Xt8UGfeUgVeK5prI9Ct6J+jHXONMisKp4+jT4psv9HinSq7/FSfrMD7+cxmxLWW8x9IyctPAeHSVOhj7KSwkS5MXgVV4s4VTo6ibVqVU1Ur8WxAQ5k1VkdIj6/9ESamXCJS4vc6MwN2/1VfX4T8q7ErK53XeVLC9W8nvDNKOtL5Qb7A8Sui1b2Bv+KBfmpVs+sSPuwM3ssC5oHf61uOuBfzKU2e6HB+ECcpICvHXEA3++BNu2olOlUOpnyyS6sRQOYIlsrM+DbeQKJtfqgAsnylrKOPJ2VCXsF5lKzArm+NBCLq64AFk+TlJTZXbH4poSECQ5Sca2SxxOn1/JoKN4n+eEv/Ryssw19e7uqeuXZXZBlHD426umtAso0cn2FsbwJTZ6aeaKP37dflGlJSmIOUYPgFaB5OBVGpIRULIxC7fwVsxCESCGz9CpWJ9c23SqevWWQgWFdfttd+HHamjO5VQSJPoAVRZUIpR8+y6g8WQFQA+GUNyUWrIhUvbFXcA630VkrqNEy588dMg5n54SsiF9K13ga+V7D5oc1y2hdXZUAOgJmvIRZfOiNoNlm5TFjm95kw0uT6mFTYUIah/Ola0wQr7/pyB6nlOMxGujGumxPW61EClS5Xg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(15650500001)(5660300002)(8936002)(41300700001)(70586007)(70206006)(36756003)(478600001)(40480700001)(86362001)(82740400003)(26005)(8676002)(4326008)(316002)(7696005)(107886003)(6666004)(54906003)(82310400005)(110136005)(2616005)(7636003)(36860700001)(40460700003)(356005)(186003)(1076003)(336012)(47076005)(426003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 00:45:09.0602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8588fa58-4a8a-44ac-481f-08daa4d885e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7286
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To realize interrupt-driven closed-loop governors, governors need to be
able to send data to the underlying devfreq driver to ask for updating
the device settings, such as hardware registers for frequency limits.

Since governors might export several tunable parameters, users can
enforce different policies for the control logics. Under different
policies, governors need to send different information to inform the
devfreq driver to configure the device accordingly.

The introduced update function improves the flexibility of governors
and acts as a communication interface between governors and devfreq
drivers.

Signed-off-by: Johnny Liu <johnliu@nvidia.com>
---
 drivers/devfreq/governor.h | 8 ++++++++
 include/linux/devfreq.h    | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 0adfebc0467a..b5781fa549c7 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -124,4 +124,12 @@ static inline int devfreq_update_stats(struct devfreq *df)

 	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
 }
+
+static inline int devfreq_update_dev(struct devfreq *df, void *data)
+{
+	if (!df->profile->update)
+		return -EINVAL;
+
+	return df->profile->update(df->dev.parent, data);
+}
 #endif /* _GOVERNOR_H */
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 34aab4dd336c..82d0f9596935 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -92,6 +92,8 @@ struct devfreq_dev_status {
  *			devfreq.last_status.
  * @get_cur_freq:	The device should provide the current frequency
  *			at which it is operating.
+ * @update:		An optional function to allow governors send data back
+ *			to the devfreq driver to update the device settings.
  * @exit:		An optional callback that is called when devfreq
  *			is removing the devfreq object due to error or
  *			from devfreq_remove_device() call. If the user
@@ -114,6 +116,7 @@ struct devfreq_dev_profile {
 	int (*get_dev_status)(struct device *dev,
 			      struct devfreq_dev_status *stat);
 	int (*get_cur_freq)(struct device *dev, unsigned long *freq);
+	int (*update)(struct device *dev, void *data);
 	void (*exit)(struct device *dev);

 	unsigned long *freq_table;
@@ -451,6 +454,11 @@ static inline int devfreq_update_stats(struct devfreq *df)
 {
 	return -EINVAL;
 }
+
+static inline int devfreq_update_dev(struct devfreq *df)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_PM_DEVFREQ */

 #endif /* __LINUX_DEVFREQ_H__ */
--
2.17.1

