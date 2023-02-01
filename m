Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4487686C4D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjBAQ7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjBAQ7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:59:44 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8173E76A3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 08:59:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqCe6V+a9lMxcSTbflInt8S5bpvAjwcNAa+ehm3q5pzYcYrCzdajwAsfDI1IhMwmDunsz/RlpRzP1/NzI1RRC1fv24gPoVJOXhsbNvtxCfck4dugij2bRngUYExtCLNeFYAivxlqytBuT6I2wCfCjkkyNAUoVRd4T0z0nYCFeFCu1ns3ttS1w5Eq4+ANaCshnyKIOwIfIuNWtqUCuUdDsT35SCC49T7fQ3LIt2M7be/VC+2FcMjmMhohCL4zNpBXFNHp29SoRmwysMVOF5p1ufXNBQYZhHqA6j6lnI202gNo3wYC+nTg5mz+SzEu3IUc9cdf0HyKq360UhwX21+jtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UiDIPD4Tc3SUHFPgT6u1E5yWtU/fuZtw3BohiBxrOs=;
 b=BVS1KU7F2y/6U6hxyL5MSvbDRvhr1EEdeWkQnQEB+dTSJDYD6+Ru9o2vo0IXGLjWiTgX0QdbAGJ+Ufy++ExBcx7y43e6/FfwuhLmVdgkpyebuK5Wh33Ovb3wUTt6KGVflS3GvaAAr1Yo+d3vT7LxPUMqEDUTklE4Ys6wGe/+E+p7DXXTN30Wikq6HPRKjU4mCX7MhhYPRZvVqxsXHUF8pNiYGWYtZ/beGvoM8wbg1MUMmwfWuhH4NPv1JvH5L9aDSl4GQMyJy900jWkHGJt1bGN8W6PTCEWbH7OMI355wv2U2Ins6CUz+AfECb7tKfxIQ9zDtY/a1JrYCyUqAnHh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UiDIPD4Tc3SUHFPgT6u1E5yWtU/fuZtw3BohiBxrOs=;
 b=B/Er0ToUA9AIB7n+WIe86Rlmmf5kwpyUq+SjresKiK7qN527u0mIbMilkueipqwLosGOWbrgCZcebD/5ymCV2gCFW23pSngQNFPHdQIxe58IKnmcQ1lVg5J1HfeWSR5SRuCKsbrKkDegfQ85y2k8AF8bbwCRWVZ3VNrkO/bIHeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by DU2PR04MB9051.eurprd04.prod.outlook.com (2603:10a6:10:2e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 16:59:39 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f469:ba5b:88ad:3fa0]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f469:ba5b:88ad:3fa0%3]) with mapi id 15.20.6064.024; Wed, 1 Feb 2023
 16:59:39 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     ioana.ciornei@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v3] bus: fsl-mc: don't assume child devices are all fsl-mc devices
Date:   Wed,  1 Feb 2023 18:59:23 +0200
Message-Id: <20230201165923.19369-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::14) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3405:EE_|DU2PR04MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 970b820e-7709-4e19-588f-08db0475b4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 42hnDOxz67+iX6e5hGpz/BLyfJ3ocjdYgQJY3D1qCtvI+meXg7xdUefdQauGss955Tt3PW7aLMRxapskO7YskERJnWFI7DBleJIFfFalM9LwmZIDdorz4gpZAuCzA9VmncnEbX2spREvYdIaGdFvn9UPm2HtsbUilGgziCwMIMZz1DFVuFsUDdIEOahgosu7S3YQn6Upj7HnHCj5RXE3M2YoWkp311gWKZrIJXOrGNF12gNNzg2Rq8YAjTY8xaAIgo58B+WEpl1eALFn6W9b6xwdZaZ9H5T/3/iNdnA9YXry6R3NQ+rquuKhuYMxLYCeFZNcb+lmvBlWg7WeYKfEfkH3xF/YgNU8thMfT+EakQsCVI5XErbGg6okGJksyjaFVdvTGuz3MYSAqRU4hL3LVigfi18LsVzWB/R5vh3Ok2R7dqAa/ViHGlqFM3gbYFy/kzNVJ7l71mrjqwJg/HfPsYrbuEfPAmygizoVU6w15hECRPO/w6REXcPn5cgkz+7u3RNNu+fX8Pn/KFYOuEHmgKU15AM7Pik6CuM0BKz1B9UUVUqpnOHCe0uTIWwttMTvxdIyD9N0OaM1rvRXLAgM4aLwNPFitla8TJ+0iJPiJIK3O3nVFMqNUqJqISKE7rV7cumbtIehYB/HAi8069sZEc3s3drEvL+rTAOJCackrHL2LgMAcEXA0ipYHIta6AtIis6qHAcjAjNd8npIL0IOtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199018)(26005)(316002)(66476007)(41300700001)(4326008)(8676002)(66946007)(38100700002)(66556008)(38350700002)(36756003)(86362001)(45080400002)(6506007)(186003)(1076003)(6486002)(9686003)(6512007)(5660300002)(2906002)(52116002)(8936002)(6666004)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zIseN3Gz0dSIYTAodFZCnT+khmjJaBV+6uiaHzfwTJ452zU40njVkK88uzpR?=
 =?us-ascii?Q?gwkx9afZdBuLh+CBdTilOG3/8QX6HrDG0Tc5Vzw7ax+ihxWVWfTN2LHol257?=
 =?us-ascii?Q?Bs5SRaIRRd/BDEHWCnuIMgK+8EBKHBrHHpC1FSGJMJxP8EElUOnWQ5makine?=
 =?us-ascii?Q?KpHc1z6wZwzEoV71qKExhPtFtEtZZSfpjUFP1kQvcPRDyC9XWWZsIb3DrLhN?=
 =?us-ascii?Q?F963/D9yi8e+lbEef1G2NENOVGwsMQPky8Wmc5gV39CfDuT9MfsiSqJUtpYb?=
 =?us-ascii?Q?pbrq+lW1zW2H8QrvZxbokuuo7XiCQB510LJCBhRE99HYqH2WNxj2eRqUfMnB?=
 =?us-ascii?Q?i267k0B2x9JZlCYhRsPU29cLeBADBw8HfKVMlP6ECmYu9zq1Z7ePRm/xK6Fz?=
 =?us-ascii?Q?nTQz+1RXpuwANu85j6LCeQ7CqRFdN4uOyxU3y39uNrsi/wI9vvRp47f7jyRl?=
 =?us-ascii?Q?F7Tc/6OdBHUbOyKgvhApQUmJkIe8d6SHAAebR/XVKc5wpZ3fk+3PKXD0P5iL?=
 =?us-ascii?Q?Jl/k9swTN84Oc1GZi11QQu8W2MkSlH5RJRt5Jn8XJ6dTfikBuaHuyVTntHby?=
 =?us-ascii?Q?lRm4sQfEfXEdrZwXMurcypzb3Lfk7ktaw3Wyw4JlM+W62Qv+Fu1XFGL2VvSi?=
 =?us-ascii?Q?+c1qW06QSoQZc6RM3TXONYkyTUdCWhHfjswxF5jc9sFgQ1d1wLrTgzZXj5UT?=
 =?us-ascii?Q?xETlIy5WVivRNqagh/OpA6TMxztLz3h5CRWNO0YUdzgL12/VgzG1r9+K39As?=
 =?us-ascii?Q?iO+gwEmbk1NtEEZiQ0+nMw+NBlUmfu3EKgr84XSsMbxZLmVFWoCQwOa2ecCK?=
 =?us-ascii?Q?7gy1vupZ+Lm2biDEi4Ll1kTh719B0ZYLTqU9sHWplmGBoffZXBCeiDIHI0R+?=
 =?us-ascii?Q?ML0p/3PsODFzklInpgXMV1krXm0EIJazsuR2NPWCDTWM2ORbCYNyPgPvvsNe?=
 =?us-ascii?Q?QkHL8hRqz6bzufHJuCtn+1NXIptwLin1+IacHRlcQi0pMZcx9M+V2aOCNwor?=
 =?us-ascii?Q?cHkssu/ByQefu2D2sxOHFqdOBPDLH6nIVHQkB1vFPVDUvUGCnzUHVGb7XTYD?=
 =?us-ascii?Q?jnPuauhZdDNWPW8oxIAkzXqm4cr4FyC43z0FjD66S2ZFNIaXZbkCuRX1ZfUO?=
 =?us-ascii?Q?AL7Zu8iQfQI1GwWNFa3eNGeySGRZD5zSWwZkCFAObcOZdIK/U7/C5v+A7vdc?=
 =?us-ascii?Q?2vTeVyrYQwSU5CTRvdrw0vdS+VwQvzxA2VvZ1woJ9gU9RBQOv8NBFKqRsEIw?=
 =?us-ascii?Q?tE6HTpqkmoSbAShcBG9qbSNuyIbm8BRA9AY8zkKVZiv327UACT6TMRfU5ZW/?=
 =?us-ascii?Q?LFqywgi4jrLjzAMUBC18I4S/DyKWXbr5oZsVHjlYIxrdLEdr0VtQm9WcX6w7?=
 =?us-ascii?Q?eRXrLwNh38quDqMediIR7uTHrL6KlAui2WJEelaamM0y2cpeoxt617nr6QTo?=
 =?us-ascii?Q?s6sh2kG2FkUzuB7sXksU47HsgFYUqcvHUfxoWOkal65hQOSD0Qej93Zc7zMj?=
 =?us-ascii?Q?+SXG+D7MBqMcIo/wB+rvLN7CDr8ebbajL8NetcQLeXN+q5Fw0fERxMWh7j7G?=
 =?us-ascii?Q?1xFzQlT89dSiuVYmJWDX1KqHIbL+WPn8fYutHEE/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970b820e-7709-4e19-588f-08db0475b4e4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 16:59:39.7949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lx0TpHtytNsg2L9/syUXCIrtWjW+hcLKsJfMk67CqFSQHQ9+93BjYMDAOhlyP8p7pXgASGeO/cTHJvFU4tHESA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Changes in VFIO caused a pseudo-device to be created as child of
fsl-mc devices causing a crash [1] when trying to bind a fsl-mc
device to VFIO. Fix this by checking the device type when enumerating
fsl-mc child devices.

[1]
Modules linked in:
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
CPU: 6 PID: 1289 Comm: sh Not tainted 6.2.0-rc5-00047-g7c46948a6e9c #2
Hardware name: NXP Layerscape LX2160ARDB (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : mc_send_command+0x24/0x1f0
lr : dprc_get_obj_region+0xfc/0x1c0
sp : ffff80000a88b900
x29: ffff80000a88b900 x28: ffff48a9429e1400 x27: 00000000000002b2
x26: ffff48a9429e1718 x25: 0000000000000000 x24: 0000000000000000
x23: ffffd59331ba3918 x22: ffffd59331ba3000 x21: 0000000000000000
x20: ffff80000a88b9b8 x19: 0000000000000000 x18: 0000000000000001
x17: 7270642f636d2d6c x16: 73662e3030303030 x15: ffffffffffffffff
x14: ffffd59330f1d668 x13: ffff48a8727dc389 x12: ffff48a8727dc386
x11: 0000000000000002 x10: 00008ceaf02f35d4 x9 : 0000000000000012
x8 : 0000000000000000 x7 : 0000000000000006 x6 : ffff80000a88bab0
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80000a88b9e8
x2 : ffff80000a88b9e8 x1 : 0000000000000000 x0 : ffff48a945142b80
Call trace:
 mc_send_command+0x24/0x1f0
 dprc_get_obj_region+0xfc/0x1c0
 fsl_mc_device_add+0x340/0x590
 fsl_mc_obj_device_add+0xd0/0xf8
 dprc_scan_objects+0x1c4/0x340
 dprc_scan_container+0x38/0x60
 vfio_fsl_mc_probe+0x9c/0xf8
 fsl_mc_driver_probe+0x24/0x70
 really_probe+0xbc/0x2a8
 __driver_probe_device+0x78/0xe0
 device_driver_attach+0x30/0x68
 bind_store+0xa8/0x130
 drv_attr_store+0x24/0x38
 sysfs_kf_write+0x44/0x60
 kernfs_fop_write_iter+0x128/0x1b8
 vfs_write+0x334/0x448
 ksys_write+0x68/0xf0
 __arm64_sys_write+0x1c/0x28
 invoke_syscall+0x44/0x108
 el0_svc_common.constprop.1+0x94/0xf8
 do_el0_svc+0x38/0xb0
 el0_svc+0x20/0x50
 el0t_64_sync_handler+0x98/0xc0
 el0t_64_sync+0x174/0x178
Code: aa0103f4 a9025bf5 d5384100 b9400801 (79401260)
---[ end trace 0000000000000000 ]---

Fixes: 3c28a76124b2 ("vfio: Add struct device to vfio_device")
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
Changes in v3:
 - added changelog

Changes in v2:
 - added "Fixes:" tag


 drivers/bus/fsl-mc/dprc-driver.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 4c84be378bf2..ec5f26a45641 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -45,6 +45,9 @@ static int __fsl_mc_device_remove_if_not_in_mc(struct device *dev, void *data)
 	struct fsl_mc_child_objs *objs;
 	struct fsl_mc_device *mc_dev;
 
+	if (!dev_is_fsl_mc(dev))
+		return 0;
+
 	mc_dev = to_fsl_mc_device(dev);
 	objs = data;
 
@@ -64,6 +67,9 @@ static int __fsl_mc_device_remove_if_not_in_mc(struct device *dev, void *data)
 
 static int __fsl_mc_device_remove(struct device *dev, void *data)
 {
+	if (!dev_is_fsl_mc(dev))
+		return 0;
+
 	fsl_mc_device_remove(to_fsl_mc_device(dev));
 	return 0;
 }
-- 
2.17.1

