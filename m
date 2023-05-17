Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD322705E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjEQDaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjEQDaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:30:20 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2076.outbound.protection.outlook.com [40.107.241.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE73EC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYoFJwoSY20sHbruYd3cI3ZFH5k230+gN0Cai9laYTkyLgQ4hdxhjFOTG8Jo+gvFVLSpALiBVtPq+QRTp3I09W/1e1PwQVR3vdI3V3WFDvOSCcUuBKPZL+JdSVPEnctMXrkQubBJJZAcEogvsfWNyHSP2asdD3Oa1wlJzgrxN/spjdx2CA4uYWgApq9+x1Fd5ORgfUp6jG4rGVkapW+BolPoTHOsGt3iV3B6yqhhq8uQLiihunkVm+2zy46QnTLi0WKgXZk6VLtMldtkn48CQEftWurdF4kOKSl+TFDUbXNdNZaTY8jeD3KhDMhpYUfFtsx8LtyLRje8GzMfTsjIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37FEDp+ZdffDUu75HV5A27MIbEr2tLhEyY5QDXA+Ze0=;
 b=NWOeRiFJO91wwCeVeimj3zVhUD9ufCWOV3PKEH8iy3C3Ac3NWjGqczr1h8jSUaW1sR40JdBwDH+wtbPCRT2kNZvMLUzvi5grCjNMxmeULuWrGIyfzkJaztTYQtnWN79q247uSd76608UbeJEaB/4jDez0egdd+p0yuzC3eLeqxOC5TP+I8cN+v9fRmE0DUGIxCQ1b2hKbJhYeQclYpf9VVIGF4bgeXbmjnbjayQtLinAVDwQiMpm56QrVpw5cFao/5vEegjoBCcBmSO71US/oJS5gmUc4DGVbAcmsQK7NZP10SQtEjtVPPAfOphATC1kR3zI71N1dhZbs3iYBeqbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37FEDp+ZdffDUu75HV5A27MIbEr2tLhEyY5QDXA+Ze0=;
 b=NEBryEIO/tIkdrXd4q0xnvqgMWtjEl0GPHY4jT7w76zSWtGd/X5LtoRWVSmfzcXdfkpnHxdUwJKFJC2mXKx1pxsSC70cKjwOJoveijavyUHOy/UfhJQJUeIrFX1jjOCJHytsbZNNPXKTpQri36ZkJSgFYDi/KR9j3vhVoUeXi2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB5089.eurprd04.prod.outlook.com (2603:10a6:208:c6::21)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 03:30:16 +0000
Received: from AM0PR04MB5089.eurprd04.prod.outlook.com
 ([fe80::da0c:329a:5bbf:71dd]) by AM0PR04MB5089.eurprd04.prod.outlook.com
 ([fe80::da0c:329a:5bbf:71dd%4]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 03:30:16 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i3c: master: svc: fix i3c suspend/resume issue
Date:   Wed, 17 May 2023 11:30:28 +0800
Message-Id: <20230517033030.3068085-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To AM0PR04MB5089.eurprd04.prod.outlook.com
 (2603:10a6:208:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5089:EE_|AS4PR04MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 844951c7-a189-4722-baff-08db56870801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MborFru0Zt3XshgW1KeHkPA80BeTmWxxRzbjTq+WtREH5PP5XKB5NVRpGtNqudNHPp4tVCy5Ta4uEdnDHDkvjZhHEElc+3dlxgusEPPY2s9UlMybCW3FwjopjEbc0XuB7RmCjECUztXoxLkJVUifSO8hzbuPyj5jqgiMpLIacPSV48oGjdByw98sEXi8jzK0A4PlDtsfrwsOfW9ww6tJ7jfbq3WxNghXJZgJWQ0j0u/40Om9ntwnwwyRNIlKYatdrIbxKUlsT96E1yiEtCpzIxdAg3raZ0ijQU1RIPbO3uqqJoBL83dXpIwf3Bg6pnGpg/lv0/cCSpAgQhu+EtSrUqoysTqz98l4VW4BB7QiS5r0+1ME5SaYaIXZ8hqCS8MoonrOi8c+3PrrPElK1K5EeV9QGMgqLNWfj05/LyRm7bO6xg8LtQLnVg/AYTMn3xkkEDtmpfhosf83gglI7ehipmoPj97T4YSHDIJR2ULnc9dyNoNEhnNzO5bJbfYWKmCajAg7el2JzxuVRCwo3dsPVIspPEWA1IDiEC+ef8e0/rBlZcGJH3pAfI9l+0iTtZHejbxciJAMzswieDIgEq1D2T+zYPO9zxh+Ir47rPiwit7LDbrd3D8l1ZbXfbwsB1mck1lKDSQCEknVQyjXlyyX2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(6512007)(66476007)(66556008)(4326008)(66946007)(478600001)(316002)(52116002)(6486002)(2906002)(6666004)(8936002)(8676002)(5660300002)(26005)(1076003)(41300700001)(86362001)(36756003)(38100700002)(38350700002)(83380400001)(2616005)(186003)(6506007)(15650500001)(42413004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8yiBhMVtvixSAjKx2HkAXsK9CSudJJ0WtX9WZqmy0Kn1NHKPPV5UvYEEa15H?=
 =?us-ascii?Q?GtJlzqheOGR71UkdpIpu3jwhbh1O3OHACW4nByryKGtpjFvilObEoKt6Zktf?=
 =?us-ascii?Q?qZn3PD5DnlWiTeW4lU3sUtgufl2x/qDUfdZHCI03xaHJBvIMqXfXBps1sfKG?=
 =?us-ascii?Q?Dqogxhveq9vfkSxglyPXgVrcAUOoA1Nh/g5QU1ogSO8PntOgg3BDxaDxJ5fv?=
 =?us-ascii?Q?lJIEHmxztjssYylsuuPhMlCVf1iogEeGZwNraIcEdcYVPGvibdjtpmGDfXPm?=
 =?us-ascii?Q?91qcR8g+WnrGm55MQLDBIO2uMH4m4JVaSkupc/O5rWcZSqoxirxRLqjU3BAh?=
 =?us-ascii?Q?4L5+eBlVj7FMsxzoim/OMQ3XXci4qB8tqC3yPtCe9yOSREryH/2DhBFDMWxI?=
 =?us-ascii?Q?E6Da9bpGGQV5sdWcC77t2PMPpIDubF1n8QuAxPNeqfev/6lxLoqMOv120SmJ?=
 =?us-ascii?Q?8dmFToUaMKzvyaHKCJU5OeOlz0netNK8fibusFqHCN2/Lp/cnSZ0ScpLyPNX?=
 =?us-ascii?Q?74920chpbSgIywHpOJv8r72mlIM4GtP6CAu3pMsfUqCrl6T1k1pZYoP0CzOh?=
 =?us-ascii?Q?XhaLcKPXy0QG/f1OaKq4IsSSG9kSaFhz/Yq3GZKEPUlZ1XdUTOYhsTosx1BZ?=
 =?us-ascii?Q?nXk6VA/cIdzz/G1OGPptEXH/NpvRlsDdsdu/i/saj9WOlgprjm7bnmP7hYiJ?=
 =?us-ascii?Q?a1J4aE2aY3nwbqC79b5K9V1QuUBY/1qSYp8JPKPp/i6Dy8IY7b2yocm8pG05?=
 =?us-ascii?Q?0V57kDo8lKOwr3SnjjfhymEmXjPKw8F3h29HR1SCHzVYur2Zq4T1D4WESyzv?=
 =?us-ascii?Q?2QikzKiHwxk25qctNj74Ki1Bd/p1TWoOQ+mILK9ZM6WXVDva5MKa7Rebrk9Q?=
 =?us-ascii?Q?zNioSoPojx8aWZgjM1jvbmIxzGVgu+KMj7FK5HiCSX5jaujibICkXxS84fK6?=
 =?us-ascii?Q?MluGyr3fc9VS0Hb5Dyd/Jftwa1KxMtJQCLkGzaRyDcu/5bcuoC+mTg8oI+gM?=
 =?us-ascii?Q?a5H8HD7c+o8muOl9uDO5TzJQFUimmRR2PYJcK52z4m5aPCXAzsFvHZVCXYjO?=
 =?us-ascii?Q?V8bkKSn/vHU7xUAw/3eJ438NLfR4mrh/a3cQqWkTDCvIM7aP6+WXit/KE78V?=
 =?us-ascii?Q?5364COeoWKdOeBtNJVX/DUOo2IQ6yPJUZ2J4OAFdg3IB7jT35VuLecdi/ERY?=
 =?us-ascii?Q?eWsUoUsAbFQV6yT65SgqyfYJmGXAR9hh/1LS1Zw9avbD39Rwj0WjLj3Ny1e4?=
 =?us-ascii?Q?Xonm0uiQaZGhAgHFEDt9VpcQodL+4LALWuTBgTkzfkNsAQ7I5UmM1ZdCSi0y?=
 =?us-ascii?Q?F/k4VB9pCNuhzKwhxk4sleUZy9jCC5xDhopStOXgAimNxEJjZwftn9OKl0zY?=
 =?us-ascii?Q?3NQVheLlkQjcRwWoP8Xbdz5AyppY7SdU8nXEesk3lDHrSS9YMy2mtgbE8nhS?=
 =?us-ascii?Q?w2zJzgBSCCv1HLsLUte/0r56tv9VEY8RpazGIQXbvaOVn7YjVqt0s7ewfoXO?=
 =?us-ascii?Q?KdD+XS/aOrMhIPdUu86cPTssoY2w+tCpm93VoVOHizrN4Yeud4x5OZiTus9o?=
 =?us-ascii?Q?ue3ITGhlsQfU6yx/Z0TkkkHvmu5F6iN0d9Uvg9cO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844951c7-a189-4722-baff-08db56870801
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 03:30:16.5117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lyg7MLIXEqowefYHXDV8yOA/HQyv/Ht5ldRYrJ0DA7uLPSq27usEQjYVRb8QAn+lFEYIT+F+qwUncvVO74EdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When system suspends, if i3c module is powered down, register
value will lose.
Need to save the key registers before system suspend.
So save these registers value in runtime pm suspend, and restore them
if these register's value is different with the saved values
when runtime pm resume.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index e3f454123805..bca3a4352ad1 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -145,6 +145,11 @@ struct svc_i3c_xfer {
 	struct svc_i3c_cmd cmds[];
 };
 
+struct svc_i3c_regs_save {
+	u32 mconfig;
+	u32 mdynaddr;
+};
+
 /**
  * struct svc_i3c_master - Silvaco I3C Master structure
  * @base: I3C master controller
@@ -173,6 +178,7 @@ struct svc_i3c_master {
 	struct i3c_master_controller base;
 	struct device *dev;
 	void __iomem *regs;
+	struct svc_i3c_regs_save saved_regs;
 	u32 free_slots;
 	u8 addrs[SVC_I3C_MAX_DEVS];
 	struct i3c_dev_desc *descs[SVC_I3C_MAX_DEVS];
@@ -1579,10 +1585,28 @@ static void svc_i3c_master_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
+static void svc_i3c_save_regs(struct svc_i3c_master *master)
+{
+	master->saved_regs.mconfig = readl(master->regs + SVC_I3C_MCONFIG);
+	master->saved_regs.mdynaddr = readl(master->regs + SVC_I3C_MDYNADDR);
+}
+
+static void svc_i3c_restore_regs(struct svc_i3c_master *master)
+{
+	if (readl(master->regs + SVC_I3C_MDYNADDR) !=
+	    master->saved_regs.mdynaddr) {
+		writel(master->saved_regs.mconfig,
+		       master->regs + SVC_I3C_MCONFIG);
+		writel(master->saved_regs.mdynaddr,
+		       master->regs + SVC_I3C_MDYNADDR);
+	}
+}
+
 static int __maybe_unused svc_i3c_runtime_suspend(struct device *dev)
 {
 	struct svc_i3c_master *master = dev_get_drvdata(dev);
 
+	svc_i3c_save_regs(master);
 	svc_i3c_master_unprepare_clks(master);
 	pinctrl_pm_select_sleep_state(dev);
 
@@ -1596,6 +1620,8 @@ static int __maybe_unused svc_i3c_runtime_resume(struct device *dev)
 	pinctrl_pm_select_default_state(dev);
 	svc_i3c_master_prepare_clks(master);
 
+	svc_i3c_restore_regs(master);
+
 	return 0;
 }
 
-- 
2.34.1

