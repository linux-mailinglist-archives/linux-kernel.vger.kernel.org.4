Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBE25F2856
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 08:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJCGC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 02:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJCGC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 02:02:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8632736DF7;
        Sun,  2 Oct 2022 23:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxhoPwev61slsbswKEZHIgc21MFRTPYBLchDI8+ca5B5PT3YOU6hAtttFxDFxUpx3haDbKL/reK3XFx97TubOrq4Pyn8ujmPlKvEEFrT0SJE23YnUBeSijmmtH+Srj1KB2W+F5UwcH1eQvC4/1yCDc3tpRkpZ/LWBbkOGQczzaCcVdTYNnsXProKltMp4cSA3UvwGXVLcxtTYRqTsD/XGge6f+aHtShY927uTHNPNStkoK356RgWNhiEacXCu6vaEUccHCN80nRyafQvtYOYVHm3KzkvTxuvqj12gP0czjHTzF6JT51tu41u3IQyTGPanxo0EmHKq2Dorn/K97BUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7iw9J9rFaZwXxpz+0yqhtBp1kyrGbz/OZOavvLwPUw=;
 b=nKDLqTf/rIIETKy/NpPkxZW3+psxPnZXi1ZA+crCkGddQW7c5syU8x6VFWda0ELiHfX9VdhMG5hRK9/gCn/kE6zb/F1ycMbwOlo2dU2A0LfnOUuYdUdLB308rgXXipyIW8qnZg1HwF6CzNrZ7bsze5ZBgm1VVVdBjMs5doaiQzMO424o2elddUeZNiI8tLXpHOMhe3+mwwhPlgZFmGHBYv8ZhXQJpsgQiyT1ji4/tO3M6kPxPF5z/0lHxfZaaegqETnUYSJAlMFTQ1UX4pWua2OC1eTkw2G53id85emyoBM75GSPK1aSQWzXjQtJt+UKewJdqonZeyaJuHYYAEbP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=samsung.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7iw9J9rFaZwXxpz+0yqhtBp1kyrGbz/OZOavvLwPUw=;
 b=ATcgKec8KM0CYCrV3aE52RyG6WO91F1VkmcquMbMdHckKVIEQ6fFIvk8DEmjgim/QTcmA1Z1f7v0YNOMENQeWJPUzgxPn86DvcYqacyBVpEuMXK6gV/D6+j1IH9C3raXqN/U91jmmfylh/RA9DEw6ogo+Ssos8gZGGpFrTfdhVmSj0DBetFrZ2NZqyZoAlFerRlm9OFg6QV6J0U+JWfzCf5nsBu9wOUSiM15gxIC1Bz37uXscK3JN3BPd0V9bK7CGA5IBorevO6dob7VybWqZVDkYotIBpPeMi9xATM7Mup54k1yECWPcUJ5DSAN3luWxW2Rnhxewyw0lHBmjANBSw==
Received: from DS7PR05CA0022.namprd05.prod.outlook.com (2603:10b6:5:3b9::27)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Mon, 3 Oct
 2022 06:02:53 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::6b) by DS7PR05CA0022.outlook.office365.com
 (2603:10b6:5:3b9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.3 via Frontend
 Transport; Mon, 3 Oct 2022 06:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Mon, 3 Oct 2022 06:02:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 2 Oct 2022
 23:02:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 2 Oct 2022
 23:02:47 -0700
Received: from thinkpad-t480.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sun, 2 Oct 2022 23:02:45 -0700
From:   Johnny Liu <johnliu@nvidia.com>
To:     <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
        <cw00.choi@samsung.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Johnny Liu <johnliu@nvidia.com>
Subject: [PATCH v2] devfreq: Support device update function
Date:   Mon, 3 Oct 2022 14:02:01 +0800
Message-ID: <20221003060201.14833-1-johnliu@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|MW4PR12MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 413e1984-26db-4a46-8a59-08daa504e8e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUbjuQqJ4O51LDnyLmad9DRCZPIwQKv53UXL3ckaU7YRkt3yWHUvPXgYNHAP/nJoDBE8aLLn0mzzF68aQPGk43Fet5hWHSp07ueyicvdsMT0muQp7XU9SERVh49kgZyRR+UsXjZNeD9RvtQALy0tj1XB7W+KuzS7uztj2t3FwwCBPvmLsgi+8ZwyNEif7lYsBjvKqc0lpCYwuuHkeGXWEG0+3oDkokPalUtQz7eVtAJ1Di8LeI6wTKs/6ns2ee3IMvA2NZ0OmrThdO9tOmLuC8gijaDtEH3EROTCeJ5LRZCUShTECtqPAr/mLPgtp4NecBXJzJneb1OZOcqbwRsViHOo+KwS1rcgLBaJ2U3zz6oBJRWbGJXdncY9yamGnlMR4yFieUQVeLp2gTI1e0hFAi1y7yNsqhL2tbHdRazlPCtO297LxhWK7fCH6C7ToU3w5YbgaolnNERIObUieL73UzWe/u1ZTGM+aSxKviwXYyLJ/Bt/3V6SOmdDp23s7my4JMuOJZtXm0d880vqavdBwEiCR5d59Q7XldDflp6W0yJcyjWhedQR+bsZbjiNMl713kc48JUGfRLDifp9+gmMEZF3K1Tz0hYhv3AF8+K/FNNNr564zUvyuYsbKZyJ7/gzbwX+cY4YkbIvb+85YqPGHJgJbSp3FamVeDRFAl7htgKDUUgTinS7wIGZsEmtZ5TqXR0RxwtIIphR283vEtqde6ztU4XMPHYQXJfW+RhUzuAvOMG/ngAhNxhK4rg2S9Td27NrPoL6IfP+37iB8/40+A==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(6666004)(5660300002)(86362001)(107886003)(7696005)(41300700001)(8936002)(26005)(15650500001)(40480700001)(82310400005)(36860700001)(356005)(7636003)(186003)(82740400003)(426003)(336012)(2616005)(1076003)(2906002)(40460700003)(83380400001)(47076005)(54906003)(316002)(110136005)(36756003)(478600001)(8676002)(70586007)(70206006)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 06:02:53.0331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 413e1984-26db-4a46-8a59-08daa504e8e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119
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
the device settings, such as hardware registers for frequency limits,
which are compared against the device frequency to generate interrupts.

Since governors might export several tunable parameters, users can
enforce different policies for the control logics. Under different
policies, governors need to send different information to inform the
devfreq driver to configure the device accordingly.

The introduced update function improves the flexibility of governors
and acts as a communication interface between governors and devfreq
drivers.

Signed-off-by: Johnny Liu <johnliu@nvidia.com>
---
v2: Correct the function signature of devfreq_update_dev

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
index 34aab4dd336c..91648e8f8d76 100644
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
+static inline int devfreq_update_dev(struct devfreq *df, void *data)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_PM_DEVFREQ */
 
 #endif /* __LINUX_DEVFREQ_H__ */
-- 
2.17.1

