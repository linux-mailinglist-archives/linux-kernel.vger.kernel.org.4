Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC2E68678F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjBANw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjBANwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:52:18 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB4F66ED5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:52:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4paCFIVUgmwXI9ik7WTL/KwI0HuJz1LpEGGyw+nwlF9zgkrMo4oh8PeiO+VuA9StQT0uggb+ypYY2JQ7/3m2kKPHTRM4mSrrw7/owSh3omdX6W9HmXywLQgEEoL5siZep40czICgJiLc63iAmgTcSK6cVaKlgZiWai0CdKK1eMoN9t06tC+QDc2a9/UMi3snSMUb3D5y5Nej1doyZFSY1dD3/R6yK775/+wFVslGPPPT4O0qYd/FiK/b0nrqpZ0nn9yonQwaQIQETrYzdFjdZPTu+IN8anERyeE9cTi7fTL1he1oW8RgcvkzAn5ujrW70tY+IMMDgM+XxFiYy8HdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1z3Ou5eK7M0nRcyhu6MARM+scrpa6tijveZLWSLtW4=;
 b=c3+vdagU66MHl0YLChf1vCgEDFbKrCQVnrVWDxnlpj3TvKCWtgHYEhVw+/cvA5mOOpnxYH+r1lqNjjYXzqlnhHGsr5MM34k6dNFJapqay/c/dmSBwn0Qb4LsZUnEATXAd1xuqtxB28AnAwZdpOe9ddKObdXLfCbTRdIf532YQ1cdb+1hNncgr+S+f9wUklQtDNTah7QQHNk32z9I7Ixxd2JP45hEtVv7Wh8WjJ4Ink+B28X/qWEmul11OZadOlh6NPbnmVwt3iYEJmW7h0eBcpQNlace6POQ3Kw2FNP0H+CIYroP9qqhqWVpDNPMt1BmOvd6nxDvnMzh7Ry2gPVfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1z3Ou5eK7M0nRcyhu6MARM+scrpa6tijveZLWSLtW4=;
 b=BjchVt+n9m87s4cwMV3mTfq+zIMNKABy2aCbImTYZjE/3SB919fESf8kaV1NcDIkELcLByEPk51xPzKDf9sQp0/ADZKs5VcY/+9igOaiRmEHcD1GlSp/OQeI6ePpXl0Dhxfq/uDmzQ7WOOzdcWyUlTRrPXcbjm8AiJLqgtJ35Js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by AS8PR04MB7925.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Wed, 1 Feb
 2023 13:52:01 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f469:ba5b:88ad:3fa0]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f469:ba5b:88ad:3fa0%3]) with mapi id 15.20.6064.024; Wed, 1 Feb 2023
 13:52:01 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     ioana.ciornei@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2] bus: fsl-mc: don't assume child devices are all fsl-mc devices
Date:   Wed,  1 Feb 2023 15:51:45 +0200
Message-Id: <20230201135145.18226-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0045.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::17) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3405:EE_|AS8PR04MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: c838c147-c015-4c5d-14aa-08db045b7e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BMUZmzoAFilZtM438GZZsm1TuNs0JJuhSWClhjRvnl+xWQyf7sm+Pfol+lm6sqSYNjRhifz/GbtDnYd4cIKqbr0HGZpuW58i5c9IsNPDZKN99Xlr35YQZoCzWX0f2lLa1nolwyIy2+A0sO3bcK5yfnq9R1PQ2BN1jb1o0q0bT46a/1PmCGbIMtTcrrG2RIpgc71FGvdcLoTxXIXbs3rwoiNrePbcK9Dwa/pjH6Cjo2460GSiiU2pd/LhlhCMTMFEdBMuV6fmAwXjwUYbfvjZD1wM4tcAym/p5HPG3kqCWSu08YWG7hoPzLoJraiMO7rQ9Q6wBHUhcP44///HxBcNHNz/m6ycjJRKBBnrk5wU1BPe7K+InzRlVSLVyQQDQ/4sGxFHNnh0qqDepf5qSRG391BpiQoTuItg9HEQsBWv6Fy0ft0z2mwZ3Xkl8XMED1phSjqID/DYblEyphlBPjXjiG05brS4G1kkmpKbT73iv91ODWiwiFhFraxRr0uwbdi1vfuqs4PjE5r7S2LzPioZrE0zIDF1lt1kJ3FzFmWZuWCBuWx0tIungwniiFM7WC+vhtRLKlXnwzBODgB27zHgYgaiWZXgXzs2oHtCFzQh659lYILhext+aXj/EJuMvh0nTycT7apfSpK+mCWLBljph7RSE5qp/8PYLZYV/q5vJhAnXPlJuAtLf5w0weDRCnjF8IXlLGJRVxHX0r9QZUDs7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199018)(478600001)(5660300002)(36756003)(6506007)(2906002)(1076003)(6512007)(9686003)(26005)(186003)(2616005)(86362001)(38350700002)(316002)(38100700002)(52116002)(66946007)(4326008)(66556008)(66476007)(45080400002)(6666004)(6486002)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cRjcRKAEZzwrGQ6DSvWmWSjScPcvmgTts9CUs24eGihiurfGdSIvswvMtkJi?=
 =?us-ascii?Q?nOBZjk0X+xz0iRBeefL1r1qw1+TQsoXwUABcFR/Y8Izr+WwhZLKg7hawXcb5?=
 =?us-ascii?Q?ap/ap4KO92mXAVKaGKlFKzXN721NvHpbbzaoH3CPc1lMWzhN/XP2WzDNHSzu?=
 =?us-ascii?Q?vTs68iJpkg0TaYG+4P6KlebW52TmDjdDyfk25XJr2/k46f1KjFjJWsXdAM+l?=
 =?us-ascii?Q?SpkOSR2UQA4qXOyPW23WIMC2D8DK8IUiCAox6aNhPyCVZ5xq8i+GunFutn9Q?=
 =?us-ascii?Q?bf3nlK4PbxuKm+8SkBImIouqj6IHSWV5beMGs47Mylxk7v6MBh+gdbE68fb5?=
 =?us-ascii?Q?mwik6NLus8/1UAj9CHbzyF3Z9k/pz4j2GTUkPfRnTvpBNXI8u9C4vzw3pQgQ?=
 =?us-ascii?Q?tacJGRgkyJAqO6+ywiqCQ72r9gXu9KYWXWYpckao/zCrTXdM7FEM/IUhQr8W?=
 =?us-ascii?Q?MjFCwBSbNyYER2Ms2+FzQPiVYnHPMmWmJmUaStAc9LZenFa7TzRIPvS63pm+?=
 =?us-ascii?Q?NLAQ9zhuHc9116e84nTLKP22kaCd1JhJOfACbX39QyUSI7sT1p0+DST+DfjO?=
 =?us-ascii?Q?kI/AsmGDMZJrPFtr/XSNtFzW3pBEP5eGbPSSbzA2SyUBPu+4A4oNKJzgZ00u?=
 =?us-ascii?Q?4keJX3xz3jk1WBQYmSfEj7HcYUe67d8qqMUUR0um+8JxXJ4x23OY2MD2j+rs?=
 =?us-ascii?Q?9psvo0RGYz8QIe3VXbQxf1kZA2Aejbacz1zWPftsrYYritTOewRVOX4ZJE0c?=
 =?us-ascii?Q?HvgQdQY1Y64StPZd5TKlHq2lBtArDOTEbfalbgT3faWcKjVDZUzmelT3RXuz?=
 =?us-ascii?Q?wrAaI6A3EeMy0x3embnsBT/rJrOxcU++7aYRizVFqtHEnHo4VQbje17tkju2?=
 =?us-ascii?Q?KdRiT9BSCm7kBaqEDSsnnlAQtEDkig/HpRhq6/2xdGx0CyWrN6T5jKaFAN/J?=
 =?us-ascii?Q?vxfqHPmYezytPQIL79HS7iL3lCGhxbGm7Prext0WkzEayukqnK86/gULsqJ3?=
 =?us-ascii?Q?5PZMJaAUx1NCOZQWZ1BBxAK2jGIwNiFrpYq7Zgpp5fk/yoSaOClAR4rFPDwx?=
 =?us-ascii?Q?35yq+vStQ6h94or7AUNDtWqioN4TCWakbxO9+Gy5RoSiLkliEx0QaZo5341M?=
 =?us-ascii?Q?R7bAFce44ggQw+AEJw1caglGQChmv4sZOn75qxYwqCVdoZNYAF7Nv5m3cVIw?=
 =?us-ascii?Q?k1uhQVzHXOQ5SAcTuB8a0ZX7L7qvcOeDXOjQgi/Xe3NLRC1MWxlYxk+mjtjP?=
 =?us-ascii?Q?1WnUWeDi/Z8f0UmEgE3SqqMxvMcVARmzYiljiyUxK2kV8ihfybTOdz+1A5JM?=
 =?us-ascii?Q?NwQVHlQ0qGKtSW+/ccj7h6cLUl7dkVIVvZ3aZnnHhKc3Fz+z5XG+joZTTpPs?=
 =?us-ascii?Q?3NaOsuFRRcmnBXtHG0fJcl23PSY9VAkuiN31cESKBjYI2gosLcpmRfWqbCCx?=
 =?us-ascii?Q?k/SWErF13uPJrWGVDS8BBS+6zQ/1gavqzlg83+cB7V9OKpvxi9gs51F9xI1i?=
 =?us-ascii?Q?denO76u4CdRT8xbn2z++MROQRXAgenFkXICeQ8n86ScjrvX/YB+nmja5Wokw?=
 =?us-ascii?Q?42eBuk6Vjzbaou6SHPEPCxNQtQo3R1I78Y6OQJoa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c838c147-c015-4c5d-14aa-08db045b7e39
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 13:52:01.1293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAJW1KqLQ1rFpRZlFnYLfRqlwMYp/Le/S0cGwuPMKLzxiH9Oowys+FUfXc+KcJXhXBM2M1kbm6OvxfHQgGPYfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7925
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

