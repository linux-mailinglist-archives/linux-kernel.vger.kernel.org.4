Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4E972E7DF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbjFMQHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239828AbjFMQHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:07:36 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DFC1981
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbVELav4dUqYUgD+h9O1C6bIWdgzXHSVMoS0nIJ3OrN8knv0GEYPo+C6tAmGwgTv6ESDKI61LrUDQMvZyzTFUdjSSmTHfCGTeb8XF6f2CQ0tNQFfzIkFXe3tQQnEAUaB/5kjsTyETlE9kA4dVnIAB1mwY6TF5sIVeiSjE4x89k/f7fioRKmmrEuZHQ1gkhzuh2GXjpHwh5HeswwP08uHkjYrmlkjg5/6xTV1isTwC48bgCjk5b4F8J1gGD4SQkSafTyd4TrnYc1xKS9QiAhG4EcAG8qgXtOpntcfaHHh5Roez7SVgUIuKDI6ePqrjWKxQTbo1/ARNVFbgrBJmYaU8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/9sm+N+1x24ZHmrGVaD3cuCfQaN8j+IPUcRFkIela4=;
 b=AU0e8LpKRu6EMaZO7yjJ9mnAjZX6I3qW+lCaw5qcI6uhj9csEBjFui8YB2DCAZaiJIeBV+RZa1nmzIMmssBUYlc2BARr63H6xaM/LX3NrOv8iIUa10y2I8meaepuC853x12zsw3lXWkVGnspybujMswxOig6TRMSdnTNtT6QPDG3deHUgCo30udpTISxR/+V/PCXjncNyPQAlsYqrJllfXrbLJbldMcD4KkE6Cxgb1D9hMYz++5DZXPO6gt7bbHIZkPqGxHS25Lz+68BZw6d+AXMSOKQtNQ3fEZd8xJoXt7hl+hiLHpY4ivEl25/JA+fDmKUrIxLWz+mKV02F8p0uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/9sm+N+1x24ZHmrGVaD3cuCfQaN8j+IPUcRFkIela4=;
 b=sBgLvEUdVuXjDzGVaySWFgWDVHDPWu6uISAL2yVnXqUCvTNE4m5pVf20K2vRZkcG1tEt7qVsYlcb12ORINOZuTRL4dz4FsQhSpsZFEqLIYzlimjVVyA1zNGz50P7FKFAvg3k1fSh1PS1BBJoyBgEWMgMejM7NMC4cchFhVx1i48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by GVXPR04MB9996.eurprd04.prod.outlook.com (2603:10a6:150:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 16:07:31 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::1f2:6f48:8741:cc32]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::1f2:6f48:8741:cc32%4]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 16:07:31 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     ioana.ciornei@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [RESEND v3] bus: fsl-mc: don't assume child devices are all fsl-mc devices
Date:   Tue, 13 Jun 2023 19:07:18 +0300
Message-Id: <20230613160718.29500-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0021.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::11) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3405:EE_|GVXPR04MB9996:EE_
X-MS-Office365-Filtering-Correlation-Id: 0118ac31-bcc8-438f-0818-08db6c284ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sSUvkTnN3WAvG+eL2SRFGbFVbIehjBw99OjCFDcQ7v6yuOyhyer6Hjbo+YA8NG1GeEHkvqhtDnPz21FTH90E9KlmqodKeKLrspsJnugHQ4G4bDHyY5N9yk/HQsvUxDoPGayR8bnlDI6vJMT/Gr+Yp943tjE7NyzWvPpB6gDOVfQVCH3aH+49uoaK2yjMyubna0ooeEwY4mzu+fMbP9MRe2vXaFYiTuH7Fh/Nw/lLr/AnOl4iebphr03sGBdPvsVsC9queKzg018JzH3W0xfztlja1qvzYgeEoXP16Tgttwh+4Vjy8vRqnuTCIR03y3eLOjEHDPVL8zzyarmVqF73GiheUhkWWxOli7lDeDh32kwI1QE281H/lOQROvuYB/1wq1za9GwEDlTakfpHXwEmMLr2Z7AcENax05Jjqoy+P094nJvrRnD2Pu+rR6VXatIhPjTT9y9mTxI7qGvrDF5BnQf4u+0IDWiMadk96auSFHgoZyZ2zzQTH2Pbcl6ZOBoVEIm2YtOwJUYB65E8KouwErGFrgttLHd6yQ7f7q9qzvYE5J3mhJuXTO56DM0aJrxyzazAy01syft9pIZ0hDhRsWwIL7ksptLoydLAMJAwgFkR7kAITvq4ssVCJVbP7qrfsGjXkjKhJGrZu9l/rxOW7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(6486002)(86362001)(36756003)(38350700002)(38100700002)(478600001)(45080400002)(6666004)(966005)(8936002)(52116002)(8676002)(66556008)(5660300002)(4326008)(66946007)(66476007)(41300700001)(316002)(2906002)(2616005)(26005)(6512007)(6506007)(1076003)(9686003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gr6zukH1LTHAU5TbT+foYeSDNZfi/wKhonpTCAOApEMZkBqD1/7SI/7SFI9b?=
 =?us-ascii?Q?mK3RKGPUJylONIfNOjcsJwEUTHQsumCDVtywxzrj5AlncJQ3PaEKExaNM1+Q?=
 =?us-ascii?Q?3qROeuwyZLr7y3somqB6XWMS7bI93rPKHVJRJyvuLdVbbYOGJpqJy9Or8KTi?=
 =?us-ascii?Q?c8IHrwYu5uho3oDR6OWcJXVEUkCQniz40Oa6GlL+E+v5Uxy5Hfaa1YLJsCVz?=
 =?us-ascii?Q?bxKqfcT0AwdR73Mqw/GuluElt0GGSQwLLagf3EhoRKbiZ302mdsBu9X0tK8m?=
 =?us-ascii?Q?cfhyRxKiST9ViNta4YH9Sx2POCs4i2/xgHbAq0Asf8sidc4tW5zkFM9O6WuF?=
 =?us-ascii?Q?hgTv8Xju3FRys+rBmk5LsS99AGIYuPoXQajRgLz5hXsjtyll7604YhhLU7Jz?=
 =?us-ascii?Q?ECKle2a1XussUBhMbqOWClMMibKnUq78q8NsAfsNTz4wQhSXefleb4qHp09n?=
 =?us-ascii?Q?sf0qhGoFcbfacqhxoVX8YqadeCd3Q8iDkkhtM2idp1u+2Fra3GrTOTCu7QOD?=
 =?us-ascii?Q?cth93oD5TV7z6GyLebpdOLBpCydOx32JqQqBTB5PZF3YuuDryTP5QUvmy3Gt?=
 =?us-ascii?Q?MHjlR1/cTjK+9rwn9BbO6YC93NkIp703C9yER8QC1olWl5zc0Ajvl65PgVNK?=
 =?us-ascii?Q?PUOI9BU0vBfp6wMNs93CIEGKXUJ0zjSqzFJuDLtcN28yvgrKXtf1ahlyAOL7?=
 =?us-ascii?Q?WM5BgqMhgNLQHbKrtHw1bHWJiyR4bueEMH7BpHeKQXMxfnLDaFOA2D6MoA2o?=
 =?us-ascii?Q?LQqbzKOX7ejksPR397FIIqPW92ocGwDjFp8IotljT9o4NGg0n542uHHGlBLT?=
 =?us-ascii?Q?vjH4WE5l22kDuE/tyqdPZVt7UlcRpyt+qvsT+g8ocu72VsukU/68kKjH93q5?=
 =?us-ascii?Q?0lTxbsG406P9L/V2hXbWUG9MUApXKi0baq0KPdPzH5nB09FTaGR932VOl9T2?=
 =?us-ascii?Q?jHHI+xWSb48FTmLyIbdnsaFuPWfYJeUqPakfkZC/nYEDX/xZugpoafAtkNgc?=
 =?us-ascii?Q?G3ASKsHo5yQNsfeuSinuVQoF67HOrWVqUjBaIrQn7zBpCglPDPyK40brwDpX?=
 =?us-ascii?Q?kBkdiArsT89XVMe3IKpeKJkc9UROsnwEMgnAmdMzFiCVzVnZ9isUvjSgSmir?=
 =?us-ascii?Q?AOzO9xIEFRD2/2xbSQyDv7fymx9shxzz74ro/U9x8EfzKyNAKYlDnji29jqY?=
 =?us-ascii?Q?NRRv8o3OGgE+9N+KS3iHXUL33olvoJtRAixzynJCKbCKYPwOmLY1bYicYdVU?=
 =?us-ascii?Q?sRq8JZ/Acbt60tmIqmXSmEfJg5DDVO+TGywIrT9Q5dr5VXbC4YwqN0mjHeFW?=
 =?us-ascii?Q?3h8IvCs6LZQmrgjcmhoHjM9PxoR5GpKTeiu5rAI7dQnRNb2AinzWZgbmU/F1?=
 =?us-ascii?Q?9QUN5eAQstH8+O8KvbiAC49mZ5ez31f266ktW7XmbFkvxKjOdQEHGkIQqqzC?=
 =?us-ascii?Q?r1t1tnk6p6Un8jz/ZIZDh5LaoBOvH0J2ldZVhiGWl8DKT964Ks2E9t0iHQvN?=
 =?us-ascii?Q?l8+IIWOfqPkHXdeq3wOPDVau7CsVwQcjYcl1OdnlRe8Kq4zdOc1LCz5XGplj?=
 =?us-ascii?Q?bbB14vJ1aBpifq7nPuxGPdkmydkAZTKP8+Rbx6DX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0118ac31-bcc8-438f-0818-08db6c284ac0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 16:07:31.3980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 712DK4+du5WcAzpWSLfn98hmLx2Ltth+YoYM0734/O+ujMiCti4Vlzw0H4jVs54Bj5edXVhukfv7psG/bzCSmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9996
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Hi Greg,

Somehow, this patch was not picked up, so resending. Last seen here:
https://lore.kernel.org/linux-arm-kernel/20230201165923.19369-1-laurentiu.tudor@nxp.com/

For context, small chat we had on it:
https://lore.kernel.org/linux-arm-kernel/20230127131636.20889-1-laurentiu.tudor@nxp.com/

Thanks!

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

