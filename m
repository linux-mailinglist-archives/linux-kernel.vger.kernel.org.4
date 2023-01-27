Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D540667E665
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjA0NRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjA0NRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:17:38 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe12::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8425882429
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:17:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGo45ZgZleA1xRwZWxej4G3wc5a7lau/W6RkHKxlrTHrOGih5TvOuwxEM5vUbycS+Qza1w6AP8u02YemsJbQXXtCzxW2fGz0y15nPGmQKZyE5sULQ205/Rz26l5m93J0xV6A/Ih2u+vz5G3sf3NXYWnD6dPn2HXwSBxEz+mlm/M/OhZgeu8PFzLv2US0iCJD+bfDZKW3RncJrlrHNuB4y801n3Ec3XnOJxWHjAmp7rlcWPgnH8I2x1GHm4K5LjqSAX1theD2ZPNvMoiR1ehI5vuCZF1cfmGo6Qn4QjqUIrw5i7kBczlfk/jb7Dn3Xm6VXOzYnzIqfWLz8TEkt1SsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4LgLzp9jG3/vLZSiKnpfoiS8CWfVOJL17sXyJ+h/Yw=;
 b=evr0baYyudu2DC2XY8pwThE1PhYMIIa1D82JXkTTnKofZChvcn4YxJWcnLHjRihenqy0LuWoYiM8EDG2aP3MTyq+HSvby6ps/S2Iuul3XljmdnUjVf9ED6rPbVkru7VW3KNbHjvlga8kzCPNTExgkcI9JOfbrtSvfepLdvNlVIBr6FP6JeA0tS0XyRiJv75muRfqQ5To/KPh8GpWRmo6UqQXVl55LbbqP1V51LZx/J59QEhdMpUfz68EiUs/+OMlGB6WcgkIKPlYrleBNLQ8sqUsvfHuT8Mx4dyoPq31ZGrptcb6NzZQOKtwZZISVuuK2+g3WJ4OuJ5RmJeMlBpg+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4LgLzp9jG3/vLZSiKnpfoiS8CWfVOJL17sXyJ+h/Yw=;
 b=RVyOerFLR9CnN3BzLdOV5sR/8PX67VpzaKlnGIQL6bZ6Gso12zlZtjFga/RHwB0Py6ivi9ShY+J38nfr4rjdW4YZqv23CdMKbG4buQo5Mm2Pq9no9JZg+WdLhPNiM5DPiKcskc9Bzb6ljI87Rkf/GbmncdGrr9hU6H/DmYquvdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by AS8PR04MB8451.eurprd04.prod.outlook.com (2603:10a6:20b:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 13:16:49 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::88f2:10b3:3980:a051]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::88f2:10b3:3980:a051%7]) with mapi id 15.20.6043.023; Fri, 27 Jan 2023
 13:16:49 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     ioana.ciornei@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH] bus: fsl-mc: don't assume child devices are all fsl-mc devices
Date:   Fri, 27 Jan 2023 15:16:36 +0200
Message-Id: <20230127131636.20889-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0113.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::18) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3405:EE_|AS8PR04MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 4863a673-13ce-4f61-544c-08db0068bf73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6j4K7bmZpaJtiyiJQh7yPD4w4q+ptWOKnMwGf94IO1LnHOQSWGMfZTx13+NhnRvXsW6+DLZ2r04zKtV8WOH+B8DX04nzO/ga1mb8ABO6priTpuk/CUc3p5Y5oinFihEH19/fq5wRzkbEvv0zEkEWfRbDShAF1q9Re60SUpoXxHMz/TAzFVxn0MKVtXZanL4Xqc3a73CA8J4b7y1ATCvA9WS87Vn8PsDDuTs9SLEu7yhwwowiqy4xpcE83JXYFVOFjnFT90DLHIBh+cS1cvHR92n1m3R/PXKhieKoqqcx+CHgX1gj5VBzBwOio2yxhdumE2vU4mXmIMVxNc7HczS6z80s3fJp3V0I206lt67eTDgM0gGm2do6e9PkU8xRg7OkLCOyrXGKsGd8cXL1AsX+ElBSDSgheKUfrR7Ot4eV4W1u3UOqToXWJNd9VR6w7DmA3emQFfHiyLZUxNslgmmturiN9zZKxQF/JS6ggXRKEZDjR4GDVYhbsie5LwrLwdDOceaZENnZ8687rc2wYd9rEMS6USkS9jxEFTpkBpVTSch82Xics91N2ZglGZuIXI4lkT3MI+Ms1EW1793uXoXHRdPpWeRnoG4/V1kkYkeSiZSBHFNMhMKoJvNPmJOCLvD0iTVuyOKJ36nol5wP3wmz/ZWcjr6j5TvEzUkFtldZjImEmb5i7UAjNPZG8ZxI5dU1ZYcAMVcsHqkevAsSc2Tew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199018)(2906002)(41300700001)(8936002)(5660300002)(6486002)(478600001)(1076003)(2616005)(26005)(186003)(9686003)(6512007)(6506007)(8676002)(6666004)(4326008)(86362001)(38350700002)(38100700002)(66556008)(66946007)(52116002)(66476007)(45080400002)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eCZtJtWllWKLMyAbx1xv3FeiCrZ2P6h7mNAIGp/JRLUcMPDrcOOFhbbRhOmu?=
 =?us-ascii?Q?UIMi/X/xOFHEGXs52/Bju/XnjMSW6hhzJWXUbARXhO3Iq8PwYh+M1i1BFO8o?=
 =?us-ascii?Q?V4IBof5DOQTnkxD88e8LaVErBmHPCCdoeAwn1m2Y+79b1a0LxL69jkPgW6qC?=
 =?us-ascii?Q?3/zgW5bPJH2htD6F4oSykry3XbdulMtoCoat7BLoL2nn/R4lWbvPM3L+QMEk?=
 =?us-ascii?Q?24MIna9kN6MhCXcdY0fu5ZugVXLM7D7jBPy9oZMxlOIShhVEnR6bcYRIkNWK?=
 =?us-ascii?Q?oZ7QFmgt5KP24Ez9bIIuZwZ7JBGQsliMMiLsRyt5HSNnUv6xvguk/jNmtEl7?=
 =?us-ascii?Q?23I42Ls8mMPjqK2poI3WhyWALicfapTakieM+bLTFghQAsfv5Dxe7vjRyp4a?=
 =?us-ascii?Q?ZaWWgnQSEvDy8+uCEt/XHuDL+Je/rY+myfhqct4k7n9I4sxL7f5NStOi8gzT?=
 =?us-ascii?Q?AI+RRoTGXdIzN4z8lddXIY+rh3Q/aIlBXoOIHsnXqS/AY/eo6qRSm07gNxBZ?=
 =?us-ascii?Q?GRZh8deSaZ3tEi5RwDoLovmr6WR3YvhFc+3gFj2LXC+hirw3HrnCi0T/FumV?=
 =?us-ascii?Q?Jblu6N66/PmkBbDAFSpK9HB2bsqLPgUpu2Lk/MPEcIunaXSZpVKOWST0fPQ3?=
 =?us-ascii?Q?PkpAAiCImiZWmEuNfi23woV1vAXxew9hnxa2nAqd+onTk+h6Ie8ef5ITHwPT?=
 =?us-ascii?Q?15CkUbJiXiqQe2xvbxRHrITnfMTBq0OTkCcKXXPL1V4owak3ogEoF7WqVo+x?=
 =?us-ascii?Q?DsBeGMoHhRX+rm9Tmfr+YeJlQEuIubs5w/v8D1yicne1AYHQxoE3Q6WLyCcj?=
 =?us-ascii?Q?nPnnYK0jPMjL7iUDSPNh3IlzQzP7qxQJh87RCdJNctawq7Gocr6lvgDRwI8W?=
 =?us-ascii?Q?RkvMU7T6n1p5/zr6fZfSA7nUFUUi2uPezK4rNXxwLUytDnrsZiwqFFMaulqm?=
 =?us-ascii?Q?VTzjpjJABIozOHfsn7M0RRtUkJ19PzzkVlhxYAEFBiY2LEtD+94RKf65b7li?=
 =?us-ascii?Q?guoS6sET5vYqrgExpekFbABObVxFXLkCxVHUDComGo/7nMO7Mv3H2zaaoWOy?=
 =?us-ascii?Q?LN/Ir/RJAS59sMtdzV4ikjGj/StNbXojVDNcblW4rW0hHzgvDh1MJVgG75VN?=
 =?us-ascii?Q?xV3Dcnpz7DrW5jnoGdV6MTHzALPSvl2d51Fy4EPyPALl5OIemlzimOFrUJFj?=
 =?us-ascii?Q?exFKPcpgl9DsAv6c9HfGkp5NdcJcYV0tFH9KzcchQGCJFMAtGIKVaEN1Jicc?=
 =?us-ascii?Q?q4eURjwvysLqG0RsZvWqBvE2pBfWmoUBTqWzxR3rySlcyguznFq0DttA8H8s?=
 =?us-ascii?Q?Yk8l/I9xPpy+4vrtumNFzmXx8GSiTzglfbI4HeXU40F6mZvR+RuXu+cWLjtd?=
 =?us-ascii?Q?WRJ/asf4y4V0W0P1YfyL1LIkGf58zU6RvIyq+Xgw624q1pK+UbG7JdhPSSWn?=
 =?us-ascii?Q?oD+PP1Af643jOPXByX9uE7cXpr9Ei1lQVygZBnHLsisSpXeLBNdbWjOnzjA/?=
 =?us-ascii?Q?8pw7CTDdLM6LTrphaONsSIa0tzpTL7zRG4AC1VSvMWDtYNd1/7VuEFC3oc3p?=
 =?us-ascii?Q?IWjjx+l/re9r9S/xpjqYIq+3EkX/wIfEmovK23OT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4863a673-13ce-4f61-544c-08db0068bf73
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 13:16:49.5412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFeHIvaYdqbq/hN9AP7FpJLI9WISVxN5bRRdvawXYicm/8dVUlMfGRtnUwwKqNlOOPx2Selna0n+txoGhKB7TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8451
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
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

