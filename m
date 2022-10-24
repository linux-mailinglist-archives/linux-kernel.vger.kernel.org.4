Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420726097C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 03:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJXB1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 21:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJXB1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 21:27:11 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2077.outbound.protection.outlook.com [40.107.255.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B603766862
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 18:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIq9DhiSen0lOe+Z3RBA438sVpiFjzLnoEcrQWGujpY++xL3dqnMLwV1yd7+0YGWPOpYgelCyEFEQFdBf4kU5M/CWN9plpTWXLybq4tsQ8bDjuM9mIZpOO3jD1UY10FlBFeaCdDOGBVmdsNRHULsRMDS9aZzr+82B64aVZN6IkcMazttO/+IhDWL3T2H0jio1deDpU4XSLrrWgDOPmMhMLZmc2mTpgSr+TD66/RuFYg32sa8ikFs7VKu84cx/eVebAAA6FDvEkR/9wffYxmxoWvgiKqEkeZRaQpbpiDBvJvU+ajDXSF7UWJBstBeA/SFNqKOHQo0DInf0K0ekDeGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txDcDKa5OTF3juiKqcupa7B1Jvz9dbqSbG4M/yKGyIM=;
 b=CihckW5aWXqy0pi6X+cejdw5NoGLK0XDppEHZJ9UZPaRay8GAj8P4DKsLbqU5EJGT00+eopHR8CKdPZU6hXYd8d4yXYtGEd3BXRKBNlwY3ly35pO5BbPVZYJ4hwIM12aLTaBl/VeE+s+QGhVvSoNIsg1qJtDxRGDTTDyE1tsYxzynMEo6U3Hho79N1yynhYJyQuHNEQLBjh4U2xrkStoc1QYMF8M6Vj9CDXWXF+8D2m9xmQYaOuttJGLZD4Ezql69bIQLcxXT1Fa3W+4fBfOw08ZIFXqi9JMut2wNMDdfA4F+XbWF91gIKAEx4JAg3HfISRrXxAQK2HNYLkPcMLZgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txDcDKa5OTF3juiKqcupa7B1Jvz9dbqSbG4M/yKGyIM=;
 b=lFQgkEPGbedL/DS8NJvkAh21do8c5k3qeoqH2dzZb6RCom2JKiGc+5GoVnNvl9CvBVi0HCX7IALn23oAWRONyV17+PpBOCZcDSryv0DwjVw6oc4ENl8PJGVT+NQHRWCsSnuvANby9/VsHeCZ54s49CIQDL+RBQrUYRnZ355BawrJxJyA8RDuPJMwhZP35YIHoPbba27tr+Lyj2R7Iqst2qdI1tdSq3rATZpIKvJJJm7lhAyUAXV+MNYCxgenBIrjGGvQtl+/UlkSj9vl48nybnloHpjhXpTN2O/PR6XciBjG/IhTyExrCEY3hGAx0VILGYJUpw4I+IxpGIhHQIEFbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by SI2PR06MB4638.apcprd06.prod.outlook.com (2603:1096:4:146::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.24; Mon, 24 Oct
 2022 01:27:05 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::5d1a:4f09:b125:9670]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::5d1a:4f09:b125:9670%7]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 01:27:05 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, lingshan.zhu@intel.com,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH] vDPA: rename get_vq_num_max to get_vq_size_max
Date:   Mon, 24 Oct 2022 09:26:39 +0800
Message-Id: <20221024012639.1881-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|SI2PR06MB4638:EE_
X-MS-Office365-Filtering-Correlation-Id: 09731016-3e2e-4bec-9861-08dab55edc05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+MOT/jsafLn9KXJBwBklGkt8Y5/rvt/4JgpitOBwj1oLJTECNUnobpgo3zQQvd34fwjJttvD0FO4BhltJggKMqDDZLmErNaIg4OUfYHaQyKS4rupmIt+4N+vS0K7IP8EO2X6Ly7hWrCmAQSV8W77lYTMzXn3YVEMd/zpyucA+hjp2u0YcQO0n0zvFclNdaUgtBIWU3UOP1WvGE8waVPAj/tHnG1cpSMWhAT/eioX9cnox7fkJ1dgjT1yP8NGbzU5fYjPYNGsJiI2xu7z0EO3QCNqtvZHRmmjWfbiKeBQGovu/FMwtd0CFz1B1NpQdsV2wBCSXCRjKL9o8cwZCYALRpnuDy8+efFU7Ki1cW1r3vtI08jj9oIwSCDzrzCPqq2X/hsEX5EFOA4GmE3wkq2ygpHZdK8oIAkpxzsB+ptwW1Z79bnkEkADSkX5rqVoj+yO1lsW/AzkcgdUHGWnANNFvrZ0D7P6+KnnLQzX8CVLIGOJsezfby0u1RpbjuXWjRjTqIpk0lw+FPSlLDMPPnzHzxyBt0YoVwPdds4FqEZc7sQzlT6mZgZmkF1pNiZEdR4wGrlUc8ZHiVS8C3zbXQlHdxVcdZGfzwZH9E+a03IyMU3MhvuieFN4MYa74siciIXQhAHjGVUnHeIWkA1o5BRPZhxus5Af8txpQdePyVFA5RoowllusgKqvVNA3MeanygQ7Rn94HLy2X0XEcTuzTN+M6042Pd2rctAwuhfZFLTAu1b661NSTWGDOpX8d7PgWDslGruyn88GJCSHPVkhH9nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(39830400003)(376002)(136003)(451199015)(44832011)(52116002)(4326008)(5660300002)(86362001)(6486002)(8676002)(186003)(83380400001)(6512007)(478600001)(26005)(38100700002)(38350700002)(2906002)(30864003)(36756003)(2616005)(8936002)(316002)(6506007)(41300700001)(6666004)(66556008)(66476007)(107886003)(1076003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hnh0On08dIjmcYXONqSgPu4OJR2sOIXTLsnzCqdgXekr1EiLZ3RngFKGgKEX?=
 =?us-ascii?Q?iugLu/NwDkT5oXHfVveNgbcnX9NU+41nq0rTPfFBJity9D0nVsg9ZcAFJzQs?=
 =?us-ascii?Q?aiJFLaXyOrHCP7Xob5muc7ay7XG4O8ymy9zlVZWUzHD6Ffd6rmoLjM80hKNP?=
 =?us-ascii?Q?mzBlTD5Zn3b4jFHJkzX+svz1UVVD6XqNgwgDIV6u8BuoPKyXYmlYi4VuYII2?=
 =?us-ascii?Q?PlWWTVIRJMIWpWQbacKiq1zLhDkBrlgguAL1ba9aYG7GKCInUhT23Ah1c1gn?=
 =?us-ascii?Q?3K8PJEoUtSR3QNEoaSKRfVsIQ3OsIj36/K5s7IRFNqehFVNrQFBBTBnGlG6m?=
 =?us-ascii?Q?2TsbGikzpq5VNHvO3QqDQ1C+9XfAQpb013ysvsmRiY7yNDJ/z8zN1BitU8eV?=
 =?us-ascii?Q?5o4/uPMPMW3URcETgJDRNXJhxN7+aZBeBNPZLHXzzUcR1aweqb85AmgOB8qa?=
 =?us-ascii?Q?E/9xA8AQGaVmUZYclO8qFWuuYOAWepkWUXLALdcJGFzWqmesj4fqw+fqJomo?=
 =?us-ascii?Q?RT/NYLz0ljfNmmKqGt1tFxsSgAxurtBKhmFerMTOIvRoMo+NdECMH3/MLzXC?=
 =?us-ascii?Q?vwWGNGSkyMqO4zcuRu4ltqu9pKmMQPUL3TV2javhb23xkiXujxcJVqyvo0Kk?=
 =?us-ascii?Q?gthB2W77RUy6+RNgPDM05sN0im1ChsxDQYwp/IwQelNguldVinaJXJLp7ytc?=
 =?us-ascii?Q?TeR+KotNeCrYF0m13kXn7w86qgxSgOoccdZFwM5p7pCeN2EzRmd90bFgr6I8?=
 =?us-ascii?Q?cJ1nZLlNAKUUrAx7avgSKQhChfD0gKyvf++TYYeQES3qLrpXapsNqKbxhsEH?=
 =?us-ascii?Q?kJQ84mXkikxrgZ88b9Exqq/ex18AcdooSX8I/OVUyZPvp8Aqmk8cWOqg9WsK?=
 =?us-ascii?Q?I4TaonOMNYgfrKHmJQxTkY2s1ThSZ3SlWZmhIx+1VZa/dg0zz77c3KPO4Dbu?=
 =?us-ascii?Q?26fF1VvzxZxOWTEzmzyfVuQCXQ+ZFcXRl38ZseP8OJ5zr2G6bfxYTZYNz0L0?=
 =?us-ascii?Q?EMNN7YxCUu4cyu7szE0lNq/o0AJhnk8TseXoydONXlrJaUDOsvRi9adaEIqd?=
 =?us-ascii?Q?LsloI4eyAoiBL6O2uXi9Md3JmbmNa+uJ6kPBt5K+E5qa/4CPv2h35+mJcipz?=
 =?us-ascii?Q?vIF/ZRZGy3WgFOfEp6PVpDFIfn4NZJQK+UNET05+LbDzcUjFmon2IZrru6Tc?=
 =?us-ascii?Q?/Mj7cp4++tUOnl/2ep9bsEy7rngrpQ7vXnwUSRZJ9HgFV4xe4//8XCqBomiE?=
 =?us-ascii?Q?pJYyUyT5mZJNQv1jb/KEKq+uycFyDUuY4eE4xhpBc6L6pAXN4nYBGIVjm46V?=
 =?us-ascii?Q?cZISbKJ/jav4AhZXi32r1TSki9YmTHac0xg+WadZiZcqhX8Clq788exy1Yl3?=
 =?us-ascii?Q?reEoyCQ9u5uDEoANqW6pfKSYWZ9YlyVNghJd4808vBe52RvCyqSyp6PspH5F?=
 =?us-ascii?Q?Va9LRBGN6HiED7Yu6aMQYyTCjvN47//gm2NtEFztXWLQtXth9I3z1eCodBmB?=
 =?us-ascii?Q?60tyuiai4HnPwng+VFk0zGnjCW00czGuqxImfaXakmX/M26BUiRkYoI5Amq/?=
 =?us-ascii?Q?Y/YIBj/c3qad3abUOTLxIMBzEXIKSBfIsciWn1+dJj69Quqii3EyEnkDcEfR?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09731016-3e2e-4bec-9861-08dab55edc05
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 01:27:05.1753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44Zf5rdZQsmcFkmP6ZVc9pyNJ+2d19hezqP4DFSgyMS7b70k+6dKp/5f2gC9RuFPtsqne8pidLEtX7XJow0ACcIlqNvUBB6RjzpCyPXE8uc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4638
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_vq_num_max of vdpa_config_ops is mean  get the size of vq,not
the number of vq,it is kind of confused,rename it.
And get_vq_size_min rename to get_vq_size_min,
set_vq_num rename to set_vq_size,
rename implement of this ops also.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
 drivers/vdpa/alibaba/eni_vdpa.c    | 12 ++++++------
 drivers/vdpa/ifcvf/ifcvf_main.c    |  8 ++++----
 drivers/vdpa/mlx5/net/mlx5_vnet.c  |  8 ++++----
 drivers/vdpa/vdpa.c                | 12 ++++++------
 drivers/vdpa/vdpa_sim/vdpa_sim.c   | 12 ++++++------
 drivers/vdpa/vdpa_user/vduse_dev.c |  8 ++++----
 drivers/vdpa/virtio_pci/vp_vdpa.c  |  8 ++++----
 drivers/vhost/vdpa.c               |  4 ++--
 drivers/virtio/virtio_vdpa.c       |  8 ++++----
 include/linux/vdpa.h               | 12 ++++++------
 10 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
index 5a09a09cca70..453331888cbb 100644
--- a/drivers/vdpa/alibaba/eni_vdpa.c
+++ b/drivers/vdpa/alibaba/eni_vdpa.c
@@ -240,14 +240,14 @@ static int eni_vdpa_reset(struct vdpa_device *vdpa)
 	return 0;
 }
 
-static u16 eni_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
+static u16 eni_vdpa_get_vq_size_max(struct vdpa_device *vdpa)
 {
 	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
 
 	return vp_legacy_get_queue_size(ldev, 0);
 }
 
-static u16 eni_vdpa_get_vq_num_min(struct vdpa_device *vdpa)
+static u16 eni_vdpa_get_vq_size_min(struct vdpa_device *vdpa)
 {
 	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
 
@@ -306,7 +306,7 @@ static bool eni_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 qid)
 	return vp_legacy_get_queue_enable(ldev, qid);
 }
 
-static void eni_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 qid,
+static void eni_vdpa_set_vq_size(struct vdpa_device *vdpa, u16 qid,
 			       u32 num)
 {
 	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
@@ -414,14 +414,14 @@ static const struct vdpa_config_ops eni_vdpa_ops = {
 	.get_status	= eni_vdpa_get_status,
 	.set_status	= eni_vdpa_set_status,
 	.reset		= eni_vdpa_reset,
-	.get_vq_num_max	= eni_vdpa_get_vq_num_max,
-	.get_vq_num_min	= eni_vdpa_get_vq_num_min,
+	.get_vq_size_max	= eni_vdpa_get_vq_size_max,
+	.get_vq_size_min	= eni_vdpa_get_vq_size_min,
 	.get_vq_state	= eni_vdpa_get_vq_state,
 	.set_vq_state	= eni_vdpa_set_vq_state,
 	.set_vq_cb	= eni_vdpa_set_vq_cb,
 	.set_vq_ready	= eni_vdpa_set_vq_ready,
 	.get_vq_ready	= eni_vdpa_get_vq_ready,
-	.set_vq_num	= eni_vdpa_set_vq_num,
+	.set_vq_size	= eni_vdpa_set_vq_size,
 	.set_vq_address	= eni_vdpa_set_vq_address,
 	.kick_vq	= eni_vdpa_kick_vq,
 	.get_device_id	= eni_vdpa_get_device_id,
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index f9c0044c6442..c739e211ba97 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -519,7 +519,7 @@ static int ifcvf_vdpa_reset(struct vdpa_device *vdpa_dev)
 	return 0;
 }
 
-static u16 ifcvf_vdpa_get_vq_num_max(struct vdpa_device *vdpa_dev)
+static u16 ifcvf_vdpa_get_vq_size_max(struct vdpa_device *vdpa_dev)
 {
 	return IFCVF_QUEUE_MAX;
 }
@@ -564,7 +564,7 @@ static bool ifcvf_vdpa_get_vq_ready(struct vdpa_device *vdpa_dev, u16 qid)
 	return vf->vring[qid].ready;
 }
 
-static void ifcvf_vdpa_set_vq_num(struct vdpa_device *vdpa_dev, u16 qid,
+static void ifcvf_vdpa_set_vq_size(struct vdpa_device *vdpa_dev, u16 qid,
 				  u32 num)
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
@@ -695,13 +695,13 @@ static const struct vdpa_config_ops ifc_vdpa_ops = {
 	.get_status	= ifcvf_vdpa_get_status,
 	.set_status	= ifcvf_vdpa_set_status,
 	.reset		= ifcvf_vdpa_reset,
-	.get_vq_num_max	= ifcvf_vdpa_get_vq_num_max,
+	.get_vq_size_max	= ifcvf_vdpa_get_vq_size_max,
 	.get_vq_state	= ifcvf_vdpa_get_vq_state,
 	.set_vq_state	= ifcvf_vdpa_set_vq_state,
 	.set_vq_cb	= ifcvf_vdpa_set_vq_cb,
 	.set_vq_ready	= ifcvf_vdpa_set_vq_ready,
 	.get_vq_ready	= ifcvf_vdpa_get_vq_ready,
-	.set_vq_num	= ifcvf_vdpa_set_vq_num,
+	.set_vq_size	= ifcvf_vdpa_set_vq_size,
 	.set_vq_address	= ifcvf_vdpa_set_vq_address,
 	.get_vq_irq	= ifcvf_vdpa_get_vq_irq,
 	.kick_vq	= ifcvf_vdpa_kick_vq,
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 90913365def4..3ec0b911781e 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1969,7 +1969,7 @@ static int mlx5_vdpa_set_vq_address(struct vdpa_device *vdev, u16 idx, u64 desc_
 	return 0;
 }
 
-static void mlx5_vdpa_set_vq_num(struct vdpa_device *vdev, u16 idx, u32 num)
+static void mlx5_vdpa_set_vq_size(struct vdpa_device *vdev, u16 idx, u32 num)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
@@ -2299,7 +2299,7 @@ static void mlx5_vdpa_set_config_cb(struct vdpa_device *vdev, struct vdpa_callba
 }
 
 #define MLX5_VDPA_MAX_VQ_ENTRIES 256
-static u16 mlx5_vdpa_get_vq_num_max(struct vdpa_device *vdev)
+static u16 mlx5_vdpa_get_vq_size_max(struct vdpa_device *vdev)
 {
 	return MLX5_VDPA_MAX_VQ_ENTRIES;
 }
@@ -2866,7 +2866,7 @@ static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
 
 static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.set_vq_address = mlx5_vdpa_set_vq_address,
-	.set_vq_num = mlx5_vdpa_set_vq_num,
+	.set_vq_size = mlx5_vdpa_set_vq_size,
 	.kick_vq = mlx5_vdpa_kick_vq,
 	.set_vq_cb = mlx5_vdpa_set_vq_cb,
 	.set_vq_ready = mlx5_vdpa_set_vq_ready,
@@ -2882,7 +2882,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.set_driver_features = mlx5_vdpa_set_driver_features,
 	.get_driver_features = mlx5_vdpa_get_driver_features,
 	.set_config_cb = mlx5_vdpa_set_config_cb,
-	.get_vq_num_max = mlx5_vdpa_get_vq_num_max,
+	.get_vq_size_max = mlx5_vdpa_get_vq_size_max,
 	.get_device_id = mlx5_vdpa_get_device_id,
 	.get_vendor_id = mlx5_vdpa_get_vendor_id,
 	.get_status = mlx5_vdpa_get_status,
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index febdc99b51a7..7fa411ba5f89 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -39,9 +39,9 @@ static int vdpa_dev_probe(struct device *d)
 	u32 max_num, min_num = 1;
 	int ret = 0;
 
-	max_num = ops->get_vq_num_max(vdev);
-	if (ops->get_vq_num_min)
-		min_num = ops->get_vq_num_min(vdev);
+	max_num = ops->get_vq_size_max(vdev);
+	if (ops->get_vq_size_min)
+		min_num = ops->get_vq_size_min(vdev);
 	if (max_num < min_num)
 		return -EINVAL;
 
@@ -690,9 +690,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
 
 	device_id = vdev->config->get_device_id(vdev);
 	vendor_id = vdev->config->get_vendor_id(vdev);
-	max_vq_size = vdev->config->get_vq_num_max(vdev);
-	if (vdev->config->get_vq_num_min)
-		min_vq_size = vdev->config->get_vq_num_min(vdev);
+	max_vq_size = vdev->config->get_vq_size_max(vdev);
+	if (vdev->config->get_vq_size_min)
+		min_vq_size = vdev->config->get_vq_size_min(vdev);
 
 	err = -EMSGSIZE;
 	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index b071f0d842fb..59dd24cfe271 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -344,7 +344,7 @@ static int vdpasim_set_vq_address(struct vdpa_device *vdpa, u16 idx,
 	return 0;
 }
 
-static void vdpasim_set_vq_num(struct vdpa_device *vdpa, u16 idx, u32 num)
+static void vdpasim_set_vq_size(struct vdpa_device *vdpa, u16 idx, u32 num)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
@@ -466,7 +466,7 @@ static void vdpasim_set_config_cb(struct vdpa_device *vdpa,
 	/* We don't support config interrupt */
 }
 
-static u16 vdpasim_get_vq_num_max(struct vdpa_device *vdpa)
+static u16 vdpasim_get_vq_size_max(struct vdpa_device *vdpa)
 {
 	return VDPASIM_QUEUE_MAX;
 }
@@ -697,7 +697,7 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 
 static const struct vdpa_config_ops vdpasim_config_ops = {
 	.set_vq_address         = vdpasim_set_vq_address,
-	.set_vq_num             = vdpasim_set_vq_num,
+	.set_vq_size            = vdpasim_set_vq_size,
 	.kick_vq                = vdpasim_kick_vq,
 	.set_vq_cb              = vdpasim_set_vq_cb,
 	.set_vq_ready           = vdpasim_set_vq_ready,
@@ -710,7 +710,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.set_driver_features    = vdpasim_set_driver_features,
 	.get_driver_features    = vdpasim_get_driver_features,
 	.set_config_cb          = vdpasim_set_config_cb,
-	.get_vq_num_max         = vdpasim_get_vq_num_max,
+	.get_vq_size_max        = vdpasim_get_vq_size_max,
 	.get_device_id          = vdpasim_get_device_id,
 	.get_vendor_id          = vdpasim_get_vendor_id,
 	.get_status             = vdpasim_get_status,
@@ -730,7 +730,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 
 static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.set_vq_address         = vdpasim_set_vq_address,
-	.set_vq_num             = vdpasim_set_vq_num,
+	.set_vq_size            = vdpasim_set_vq_size,
 	.kick_vq                = vdpasim_kick_vq,
 	.set_vq_cb              = vdpasim_set_vq_cb,
 	.set_vq_ready           = vdpasim_set_vq_ready,
@@ -743,7 +743,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.set_driver_features    = vdpasim_set_driver_features,
 	.get_driver_features    = vdpasim_get_driver_features,
 	.set_config_cb          = vdpasim_set_config_cb,
-	.get_vq_num_max         = vdpasim_get_vq_num_max,
+	.get_vq_size_max        = vdpasim_get_vq_size_max,
 	.get_device_id          = vdpasim_get_device_id,
 	.get_vendor_id          = vdpasim_get_vendor_id,
 	.get_status             = vdpasim_get_status,
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 35dceee3ed56..dd3e72f79e31 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -521,7 +521,7 @@ static void vduse_vdpa_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
 	spin_unlock(&vq->irq_lock);
 }
 
-static void vduse_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 idx, u32 num)
+static void vduse_vdpa_set_vq_size(struct vdpa_device *vdpa, u16 idx, u32 num)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 	struct vduse_virtqueue *vq = &dev->vqs[idx];
@@ -617,7 +617,7 @@ static void vduse_vdpa_set_config_cb(struct vdpa_device *vdpa,
 	spin_unlock(&dev->irq_lock);
 }
 
-static u16 vduse_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
+static u16 vduse_vdpa_get_vq_size_max(struct vdpa_device *vdpa)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 	u16 num_max = 0;
@@ -739,7 +739,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.set_vq_address		= vduse_vdpa_set_vq_address,
 	.kick_vq		= vduse_vdpa_kick_vq,
 	.set_vq_cb		= vduse_vdpa_set_vq_cb,
-	.set_vq_num             = vduse_vdpa_set_vq_num,
+	.set_vq_size		= vduse_vdpa_set_vq_size,
 	.set_vq_ready		= vduse_vdpa_set_vq_ready,
 	.get_vq_ready		= vduse_vdpa_get_vq_ready,
 	.set_vq_state		= vduse_vdpa_set_vq_state,
@@ -749,7 +749,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.set_driver_features	= vduse_vdpa_set_driver_features,
 	.get_driver_features	= vduse_vdpa_get_driver_features,
 	.set_config_cb		= vduse_vdpa_set_config_cb,
-	.get_vq_num_max		= vduse_vdpa_get_vq_num_max,
+	.get_vq_size_max	= vduse_vdpa_get_vq_size_max,
 	.get_device_id		= vduse_vdpa_get_device_id,
 	.get_vendor_id		= vduse_vdpa_get_vendor_id,
 	.get_status		= vduse_vdpa_get_status,
diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index d448db0c4de3..e224610d3240 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -236,7 +236,7 @@ static int vp_vdpa_reset(struct vdpa_device *vdpa)
 	return 0;
 }
 
-static u16 vp_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
+static u16 vp_vdpa_get_vq_size_max(struct vdpa_device *vdpa)
 {
 	return VP_VDPA_QUEUE_MAX;
 }
@@ -320,7 +320,7 @@ static bool vp_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 qid)
 	return vp_modern_get_queue_enable(mdev, qid);
 }
 
-static void vp_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 qid,
+static void vp_vdpa_set_vq_size(struct vdpa_device *vdpa, u16 qid,
 			       u32 num)
 {
 	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
@@ -441,14 +441,14 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
 	.get_status	= vp_vdpa_get_status,
 	.set_status	= vp_vdpa_set_status,
 	.reset		= vp_vdpa_reset,
-	.get_vq_num_max	= vp_vdpa_get_vq_num_max,
+	.get_vq_size_max	= vp_vdpa_get_vq_size_max,
 	.get_vq_state	= vp_vdpa_get_vq_state,
 	.get_vq_notification = vp_vdpa_get_vq_notification,
 	.set_vq_state	= vp_vdpa_set_vq_state,
 	.set_vq_cb	= vp_vdpa_set_vq_cb,
 	.set_vq_ready	= vp_vdpa_set_vq_ready,
 	.get_vq_ready	= vp_vdpa_get_vq_ready,
-	.set_vq_num	= vp_vdpa_set_vq_num,
+	.set_vq_size	= vp_vdpa_set_vq_size,
 	.set_vq_address	= vp_vdpa_set_vq_address,
 	.kick_vq	= vp_vdpa_kick_vq,
 	.get_generation	= vp_vdpa_get_generation,
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 166044642fd5..47a68e878a2b 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -397,7 +397,7 @@ static long vhost_vdpa_get_vring_num(struct vhost_vdpa *v, u16 __user *argp)
 	const struct vdpa_config_ops *ops = vdpa->config;
 	u16 num;
 
-	num = ops->get_vq_num_max(vdpa);
+	num = ops->get_vq_size_max(vdpa);
 
 	if (copy_to_user(argp, &num, sizeof(num)))
 		return -EFAULT;
@@ -581,7 +581,7 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		break;
 
 	case VHOST_SET_VRING_NUM:
-		ops->set_vq_num(vdpa, idx, vq->num);
+		ops->set_vq_size(vdpa, idx, vq->num);
 		break;
 	}
 
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 9670cc79371d..78aee39fd47a 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -162,14 +162,14 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	if (!info)
 		return ERR_PTR(-ENOMEM);
 
-	max_num = ops->get_vq_num_max(vdpa);
+	max_num = ops->get_vq_size_max(vdpa);
 	if (max_num == 0) {
 		err = -ENOENT;
 		goto error_new_virtqueue;
 	}
 
-	if (ops->get_vq_num_min)
-		min_num = ops->get_vq_num_min(vdpa);
+	if (ops->get_vq_size_min)
+		min_num = ops->get_vq_size_min(vdpa);
 
 	may_reduce_num = (max_num == min_num) ? false : true;
 
@@ -189,7 +189,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	cb.callback = callback ? virtio_vdpa_virtqueue_cb : NULL;
 	cb.private = info;
 	ops->set_vq_cb(vdpa, index, &cb);
-	ops->set_vq_num(vdpa, index, virtqueue_get_vring_size(vq));
+	ops->set_vq_size(vdpa, index, virtqueue_get_vring_size(vq));
 
 	desc_addr = virtqueue_get_desc_addr(vq);
 	driver_addr = virtqueue_get_avail_addr(vq);
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 6d0f5e4e82c2..759ae1c255ee 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -136,7 +136,7 @@ struct vdpa_map_file {
  *				@driver_area: address of driver area
  *				@device_area: address of device area
  *				Returns integer: success (0) or error (< 0)
- * @set_vq_num:			Set the size of virtqueue
+ * @set_vq_size:		Set the size of virtqueue
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				@num: the size of virtqueue
@@ -198,10 +198,10 @@ struct vdpa_map_file {
  * @set_config_cb:		Set the config interrupt callback
  *				@vdev: vdpa device
  *				@cb: virtio-vdev interrupt callback structure
- * @get_vq_num_max:		Get the max size of virtqueue
+ * @get_vq_size_max:		Get the max size of virtqueue
  *				@vdev: vdpa device
  *				Returns u16: max size of virtqueue
- * @get_vq_num_min:		Get the min size of virtqueue (optional)
+ * @get_vq_size_min:		Get the min size of virtqueue (optional)
  *				@vdev: vdpa device
  *				Returns u16: min size of virtqueue
  * @get_device_id:		Get virtio device id
@@ -290,7 +290,7 @@ struct vdpa_config_ops {
 	int (*set_vq_address)(struct vdpa_device *vdev,
 			      u16 idx, u64 desc_area, u64 driver_area,
 			      u64 device_area);
-	void (*set_vq_num)(struct vdpa_device *vdev, u16 idx, u32 num);
+	void (*set_vq_size)(struct vdpa_device *vdev, u16 idx, u32 num);
 	void (*kick_vq)(struct vdpa_device *vdev, u16 idx);
 	void (*set_vq_cb)(struct vdpa_device *vdev, u16 idx,
 			  struct vdpa_callback *cb);
@@ -316,8 +316,8 @@ struct vdpa_config_ops {
 	u64 (*get_driver_features)(struct vdpa_device *vdev);
 	void (*set_config_cb)(struct vdpa_device *vdev,
 			      struct vdpa_callback *cb);
-	u16 (*get_vq_num_max)(struct vdpa_device *vdev);
-	u16 (*get_vq_num_min)(struct vdpa_device *vdev);
+	u16 (*get_vq_size_max)(struct vdpa_device *vdev);
+	u16 (*get_vq_size_min)(struct vdpa_device *vdev);
 	u32 (*get_device_id)(struct vdpa_device *vdev);
 	u32 (*get_vendor_id)(struct vdpa_device *vdev);
 	u8 (*get_status)(struct vdpa_device *vdev);
-- 
2.25.1

