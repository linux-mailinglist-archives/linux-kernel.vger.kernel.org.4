Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E316C41FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjCVFQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCVFQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:16:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C715F5A938;
        Tue, 21 Mar 2023 22:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7CsSF1yZVHuVbLbZRMD2eHmzAEj/19kGn55qks0KWhRnReGdVaYGVo7SgWXZf0kHtuzBlkFcXS6H4xjIlOzjyXiOKjxP22UDPINyrW48g474v3bmdlHMFCOr+B+LWZ7njT/IFtOQTrBwwCPWWsawmS+3JLfJ9UgjFT8YN3tsSqPuiKJhtYk/zi2TpDzNfv3+6e2bKyPa+5ZZW76psC+klTh/jufdysNGGKGlO/7KtJKeN9aTAquMbiyAPpRlHPs72Pcy7f6Ne4BZ1epWYHccwEaQ14i725d0w8YahuWt9nI5t2i2YWdHw0BKuHZbjlZkWjkkKZxj6I7EMTgvHK+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCAL8779U4zEgsqncy9scuUL8gibGXjTY42SAMO9ens=;
 b=WQDQs96ZR4MxheiSTSOapwSzV7Tw6DBu6ZZbA2y/DELAMGHhs7KdPUD4wR1L+neDBT5Mm5cWcVkZs2xGCps9zQ+fHZtZo0YpSD0Uadu7z9AA7AWxBqcOLbKkwbznY59X2jqG2oNieUfVnR92PHxJPWsJVDvTY0eLXdOtt/Ag1JTvlB7aHb++DFreI1UQ56h6CcubdnZRKe8dne/qfAdp9aNEl8eg4tDO0czZvNGwRrbHADmBrO3auSls8uFwX9Gzqm4UUn6dm9mBN4NzAr9WZt2RvFoSiEp6aQdcHomTvVDrMyO1z4to3HWvsGxaTfsfW8RzSB5E8fyniFhVO5B/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCAL8779U4zEgsqncy9scuUL8gibGXjTY42SAMO9ens=;
 b=E/E2qae5T10nHaQZxAky4OeFcyNgVoT1mHyn8x61yg0PY6NqxeMtiuX2GDU8VaO/I/TUhSjYOavPEzG0Q4HZ8yn5/bnJSz87EWwi9cfzGVbUzSE7AQgwwpj/K59U93Y+BUtLJOur45FfNeSJfWlSFoyU3qDQqUcnWmdM/tMZhsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:14:21 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:14:21 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 10/10] media: imx-jpeg: Encoder add support for 12bit jpeg
Date:   Wed, 22 Mar 2023 13:13:13 +0800
Message-Id: <9cb966e5514e01ae826cb70fe1db9c8794b9c1b9.1679461710.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1679461709.git.ming.qian@nxp.com>
References: <cover.1679461709.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: e94b15f4-0d7d-4d2b-6949-08db2a944b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HWno1SZ+2Tks3DxlrkV6offRY4Ed/FwCQ2ucINIH9e/g5HUrxg+eIXGyIujKcO+2BlNfqE10TuHx+W4QxrdAu/8h/nrz2Po0yRD2F6jwL5tiIJ+W4fMtb1W1ITDZVD/Fnpxn78T/K8XNSdxX4s5S49y9GXPy7lpvT1YsdUzuO6/hSo3pBfOM1AKD8WH2sfv1U+52uch1CY6zBw7foqdV38A3nhrry+Yb/c+KfN+7gyA5w4H4FZ9eCck9IiObi/tEnTOjaeH44liAQxXF22RIa38ohdJJUrfHTByS0pOMMUboGPvgY1edyqcos937Ki2lyOxJ9BglqjpvtNBLkJki8UV66LVpUYDGnTIkFB9o+IeZBfynNQ2Toz+FvOMyiev3F0m5I+3+rqjQmb2Eq9OH6Yd6E7VS6m3knkEOD1hxBY7u0EuJcr+fUWZQi2LIjPVE5iUYWoGR4mmlfPSLxxApxh55XQiVYq/44lJPoDVsQgwnmkMIqfZRPysYR1CEnYn1pXlTqBjt6pYuOAzly7oJQ1g1VQkmoowvWTTswStT62sRKfcAcLlUCiMJeQA2BSTZGqnfCqJmdHSrleo6BJkpgfJ5JgWBorsOwgQ9Qb6n8CSmZEpRyl+2VpaV9TC4zdCb1Vk+MiwcWOYsXbC6F9RcwYUT4Fi5fgVnrSHLjR/1rfhoxthSJeitYxNbdjeVlYEZaLGjQ1OBK241Z4Ec0aWcpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199018)(6486002)(66556008)(41300700001)(52116002)(66476007)(7416002)(478600001)(66946007)(5660300002)(8936002)(8676002)(316002)(44832011)(30864003)(4326008)(36756003)(86362001)(6506007)(6512007)(186003)(26005)(6666004)(2616005)(2906002)(38350700002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s8tTgYW7ACZuB+nMpqRruLNZ8WOI+C06AinzINzTYuHBiWi+kVvQmLFtsntD?=
 =?us-ascii?Q?ez2exT5QJ904x05KRWWOPNBfKVfAGJsRPDCEO1yeFkmhf6UD7bXSs/SdBOyz?=
 =?us-ascii?Q?JfAhhIwXsfnQpP+F7Eh8LBAe/C2w/ZVePORNhhJ+zz8Gp9ZMZMg9olWo3ph2?=
 =?us-ascii?Q?Cck/amKrXd3MBz7FW2sLKeE79v9yh23fiJ7w3U0sHBa6+tM4c1UV3QgsCyfN?=
 =?us-ascii?Q?2fxby43qemp+PdHDD3FJVL55WemVtlolEF0drt9xCqLnMfWrYUwLhv9MZfFg?=
 =?us-ascii?Q?ZU9Pujn3wjp5aVkTB2wfxItjHk5bwGtepIyZIGm3NutaxFWHy28S2KcpR5uU?=
 =?us-ascii?Q?/ELh3Ql8U8zmcYWiJE3d1ubNP5vPEEC6nVVq8K7X8zcukIEV0ojczSqUzKsq?=
 =?us-ascii?Q?TKGJr9pH2IFg1cBInCMdoBS44PpCQTUEBTl8OKYtQIww8XtnnINC0JWN9VIp?=
 =?us-ascii?Q?hGhHFXHptnKFeCYMhVMQgI8E+A6ZQ39jvt0LIj+42zHSMaRFm6eXuNBkP9t9?=
 =?us-ascii?Q?CTqpMj4mgOLkB1NA8szoXNyV/alqqnoXacEBEVwuEuvQnO5glMMxcxRRP8FV?=
 =?us-ascii?Q?M8u+LzvMYqQt/P4uQ+oLbDva6trx4hVA7zNqncoANN1lnK0PzZdVstd7ArWe?=
 =?us-ascii?Q?LvgoVoONPUhKo+dOLeRBUDIAmiEOhlwoeHwx+hSats97zihiZv9GinJ0K8hX?=
 =?us-ascii?Q?YWswSjF+uU8mlJrxSjOQIh7CnSCoufM0MEm1bcux+i7xbctCKFVbWT0dXSHf?=
 =?us-ascii?Q?+AQpOPlYqOjmZ49s1YStSSVqExXCTe4Vy4WCfUy0CbNUfP2P4UJqC6Ri2uVS?=
 =?us-ascii?Q?NbBN+trEQFI4JSZbPnJ7v19NB89B/iBGIGHtLjBv+pPKbbj6Cbuljpgp9BqZ?=
 =?us-ascii?Q?rpoSGt6yg1kbJxPzDpfqltkvykaiDoqPUYfWtw3FcYug/cSc5FBZTC1zQexf?=
 =?us-ascii?Q?bx3wi/EGy7iJy0cmixutDXAsfUVwW9ICjEYxqdcJTb9Gzhx3ND6EO7+/w06J?=
 =?us-ascii?Q?JCdZov8y9+5byEtHbZSLIGnWcq+NbEZsB4vAwhlrWhkRY/BtlztAp7qscPs8?=
 =?us-ascii?Q?VVRfOx8dicP/4FzTwxDb2ZyCfx3p2wHtNdqQvDJSR0D4RYHQF5mqzt/8XZeq?=
 =?us-ascii?Q?KtnoD7HUo8zuezeq4NpcFT2LJyKS1ZCMW7a+nPAd87VUzE1aSfbDv0LUNLTZ?=
 =?us-ascii?Q?w8aOogeoHQxirhQENyN7mOdCny0CiBa4jDbzCf9kFbNA7oYoAk/79N2fZgwA?=
 =?us-ascii?Q?Valt5RtXZMTsFFOu3vGx9HNHZ0hP4wkjuVWFYUxGVrMNk/hvXqib3sICVLF4?=
 =?us-ascii?Q?qf1HluzPXt0qTa/yRl8f+vBpUWg7XxI2GQ+XFwq4ZBu5SqFRMfjagWgRjhNQ?=
 =?us-ascii?Q?CXcwAMib4+zKQN+B7lMZhF+lnt3675T0csXBYN0oRMJc6KsoZ0bwUHsu7KPT?=
 =?us-ascii?Q?/1GVfhaEtdUsFW5lhhFoKOM4xH+LFD7d9shpRar+2I9qrC59CFbiXrPa0hQD?=
 =?us-ascii?Q?xl6uROBdZCn9JxKU9+w+KPykA8C2lbAEUFHUKpNbKbaBFM5M5m+EiXJcEc3r?=
 =?us-ascii?Q?Y7Ca7J28eoBPLxhpDf5C8INWC+yiFu2VJqawdsdI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94b15f4-0d7d-4d2b-6949-08db2a944b83
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:14:21.6143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDKQZ1hH227bIPdakYl8/wjYHHRdYzxh/JXZ2TIkKBLhKLyblbdDPxVPHPNPpQA9tD0lQFjq6xK0U1EXRDxCEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable encoding 12-bit extended jpeg

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c |  14 +-
 .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |   4 +-
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 172 +++++++++++++++++-
 3 files changed, 175 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
index bbd5d6a9fc86..9a6e8b332e12 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
@@ -97,25 +97,31 @@ void mxc_jpeg_sw_reset(void __iomem *reg)
 	writel(GLB_CTRL_SFT_RST, reg + GLB_CTRL);
 }
 
-void mxc_jpeg_enc_mode_conf(struct device *dev, void __iomem *reg)
+void mxc_jpeg_enc_mode_conf(struct device *dev, void __iomem *reg, u8 extseq)
 {
 	dev_dbg(dev, "CAST Encoder CONFIG...\n");
 	/*
 	 * "Config_Mode" enabled, "Config_Mode auto clear enabled",
 	 */
-	writel(0xa0, reg + CAST_MODE);
+	if (extseq)
+		writel(0xb0, reg + CAST_MODE);
+	else
+		writel(0xa0, reg + CAST_MODE);
 
 	/* all markers and segments */
 	writel(0x3ff, reg + CAST_CFG_MODE);
 }
 
-void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg)
+void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg, u8 extseq)
 {
 	dev_dbg(dev, "CAST Encoder GO...\n");
 	/*
 	 * "GO" enabled, "GO bit auto clear" enabled
 	 */
-	writel(0x140, reg + CAST_MODE);
+	if (extseq)
+		writel(0x150, reg + CAST_MODE);
+	else
+		writel(0x140, reg + CAST_MODE);
 }
 
 void mxc_jpeg_enc_set_quality(struct device *dev, void __iomem *reg, u8 quality)
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
index 8b7cd6526efd..ed15ea348f97 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
@@ -117,8 +117,8 @@ void print_wrapper_info(struct device *dev, void __iomem *reg);
 void mxc_jpeg_sw_reset(void __iomem *reg);
 int mxc_jpeg_enable(void __iomem *reg);
 void wait_frmdone(struct device *dev, void __iomem *reg);
-void mxc_jpeg_enc_mode_conf(struct device *dev, void __iomem *reg);
-void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg);
+void mxc_jpeg_enc_mode_conf(struct device *dev, void __iomem *reg, u8 extseq);
+void mxc_jpeg_enc_mode_go(struct device *dev, void __iomem *reg, u8 extseq);
 void mxc_jpeg_enc_set_quality(struct device *dev, void __iomem *reg, u8 quality);
 void mxc_jpeg_dec_mode_go(struct device *dev, void __iomem *reg);
 int mxc_jpeg_get_slot(void __iomem *reg);
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 74ecc5415aa6..1bf24bf3257d 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -322,6 +322,45 @@ static const unsigned char jpeg_dqt[] = {
 	0x63, 0x63, 0x63, 0x63, 0x63, 0x63
 };
 
+static const unsigned char jpeg_dqt_extseq[] = {
+	0xFF, 0xDB,
+	0x01, 0x04,
+	0x10,
+	0x00, 0x80, 0x00, 0x58, 0x00, 0x60, 0x00, 0x70,
+	0x00, 0x60, 0x00, 0x50, 0x00, 0x80, 0x00, 0x70,
+	0x00, 0x68, 0x00, 0x70, 0x00, 0x90, 0x00, 0x88,
+	0x00, 0x80, 0x00, 0x98, 0x00, 0xC0, 0x01, 0x40,
+	0x00, 0xD0, 0x00, 0xC0, 0x00, 0xB0, 0x00, 0xB0,
+	0x00, 0xC0, 0x01, 0x88, 0x01, 0x18, 0x01, 0x28,
+	0x00, 0xE8, 0x01, 0x40, 0x01, 0xD0, 0x01, 0x98,
+	0x01, 0xE8, 0x01, 0xE0, 0x01, 0xC8, 0x01, 0x98,
+	0x01, 0xC0, 0x01, 0xB8, 0x02, 0x00, 0x02, 0x40,
+	0x02, 0xE0, 0x02, 0x70, 0x02, 0x00, 0x02, 0x20,
+	0x02, 0xB8, 0x02, 0x28, 0x01, 0xB8, 0x01, 0xC0,
+	0x02, 0x80, 0x03, 0x68, 0x02, 0x88, 0x02, 0xB8,
+	0x02, 0xF8, 0x03, 0x10, 0x03, 0x38, 0x03, 0x40,
+	0x03, 0x38, 0x01, 0xF0, 0x02, 0x68, 0x03, 0x88,
+	0x03, 0xC8, 0x03, 0x80, 0x03, 0x20, 0x03, 0xC0,
+	0x02, 0xE0, 0x03, 0x28, 0x03, 0x38, 0x03, 0x18,
+	0x11,
+	0x00, 0x88, 0x00, 0x90, 0x00, 0x90, 0x00, 0xC0,
+	0x00, 0xA8, 0x00, 0xC0, 0x01, 0x78, 0x00, 0xD0,
+	0x00, 0xD0, 0x01, 0x78, 0x03, 0x18, 0x02, 0x10,
+	0x01, 0xC0, 0x02, 0x10, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+	0x03, 0x18, 0x03, 0x18, 0x03, 0x18, 0x03, 0x18,
+};
+
 static const unsigned char jpeg_sof_maximal[] = {
 	0xFF, 0xC0,
 	0x00, 0x14, 0x08, 0x00, 0x40, 0x00, 0x40,
@@ -329,6 +368,13 @@ static const unsigned char jpeg_sof_maximal[] = {
 	0x03, 0x11, 0x01, 0x04, 0x11, 0x01
 };
 
+static const unsigned char jpeg_sof_extseq[] = {
+	0xFF, 0xC1,
+	0x00, 0x14, 0x08, 0x00, 0x40, 0x00, 0x40,
+	0x04, 0x01, 0x11, 0x00, 0x02, 0x11, 0x01,
+	0x03, 0x11, 0x01, 0x04, 0x11, 0x01
+};
+
 static const unsigned char jpeg_dht[] = {
 	0xFF, 0xC4,
 	0x01, 0xA2, 0x00, 0x00, 0x01, 0x05, 0x01,
@@ -393,6 +439,90 @@ static const unsigned char jpeg_dht[] = {
 	0xF6, 0xF7, 0xF8, 0xF9, 0xFA
 };
 
+static const unsigned char jpeg_dht_extseq[] = {
+	0xFF, 0xC4,
+	0x02, 0x2a, 0x00, 0x00, 0x01, 0x05, 0x01,
+	0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
+	0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01,
+	0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+	0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x00, 0x02, 0x01, 0x03, 0x03, 0x02,
+	0x04, 0x03, 0x05, 0x05, 0x02, 0x03, 0x02,
+	0x00, 0x00, 0xbf, 0x01, 0x02, 0x03, 0x00,
+	0x04, 0x11, 0x05, 0x12, 0x21, 0x31, 0x41,
+	0x06, 0x13, 0x51, 0x61, 0x07, 0x22, 0x71,
+	0x14, 0x32, 0x81, 0x91, 0xa1, 0x08, 0x23,
+	0x42, 0xb1, 0xc1, 0x15, 0x52, 0xd1, 0xf0,
+	0x24, 0x33, 0x62, 0x72, 0x82, 0x09, 0x0a,
+	0x16, 0x17, 0x18, 0x19, 0x1a, 0x25, 0x26,
+	0x27, 0x28, 0x29, 0x2a, 0x34, 0x35, 0x36,
+	0x37, 0x38, 0x39, 0x3a, 0x43, 0x44, 0x45,
+	0x46, 0x47, 0x48, 0x49, 0x4a, 0x53, 0x54,
+	0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0x63,
+	0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a,
+	0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79,
+	0x7a, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88,
+	0x89, 0x8a, 0x92, 0x93, 0x94, 0x95, 0x96,
+	0x97, 0x98, 0x99, 0x9a, 0xa2, 0xa3, 0xa4,
+	0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xb2,
+	0xb3, 0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9,
+	0xba, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
+	0xc8, 0xc9, 0xca, 0xd2, 0xd3, 0xd4, 0xd5,
+	0xd6, 0xd7, 0xd8, 0xd9, 0xda, 0xe1, 0xe2,
+	0xe3, 0xe4, 0xe5, 0xe6, 0xe7, 0xe8, 0xe9,
+	0xea, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6,
+	0xf7, 0xf8, 0xf9, 0xfa, 0x0b, 0x0c, 0x0d,
+	0x0e, 0x1b, 0x1c, 0x1d, 0x1e, 0x2b, 0x2c,
+	0x2d, 0x2e, 0x3b, 0x3c, 0x3d, 0x3e, 0x4b,
+	0x4c, 0x4d, 0x4e, 0x5b, 0x5c, 0x5d, 0x5e,
+	0x6b, 0x6c, 0x6d, 0x6e, 0x7b, 0x7c, 0x7d,
+	0x7e, 0x8b, 0x8c, 0x8d, 0x8e, 0x9b, 0x9c,
+	0x9d, 0x9e, 0xab, 0xac, 0xad, 0xae, 0xbb,
+	0xbc, 0xbd, 0xbe, 0xcb, 0xcc, 0xcd, 0xce,
+	0xdb, 0xdc, 0xdd, 0xde, 0xeb, 0xec, 0xed,
+	0xee, 0xfb, 0xfc, 0xfd, 0xfe, 0x01, 0x00,
+	0x01, 0x05, 0x01, 0x01, 0x01, 0x01, 0x01,
+	0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00,
+	0x00, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05,
+	0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c,
+	0x0d, 0x0e, 0x0f, 0x11, 0x00, 0x02, 0x01,
+	0x03, 0x03, 0x02, 0x04, 0x03, 0x05, 0x05,
+	0x02, 0x03, 0x02, 0x00, 0x00, 0xbf, 0x01,
+	0x02, 0x03, 0x00, 0x04, 0x11, 0x05, 0x12,
+	0x21, 0x31, 0x41, 0x06, 0x13, 0x51, 0x61,
+	0x07, 0x22, 0x71, 0x14, 0x32, 0x81, 0x91,
+	0xa1, 0x08, 0x23, 0x42, 0xb1, 0xc1, 0x15,
+	0x52, 0xd1, 0xf0, 0x24, 0x33, 0x62, 0x72,
+	0x82, 0x09, 0x0a, 0x16, 0x17, 0x18, 0x19,
+	0x1a, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a,
+	0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a,
+	0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49,
+	0x4a, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
+	0x59, 0x5a, 0x63, 0x64, 0x65, 0x66, 0x67,
+	0x68, 0x69, 0x6a, 0x73, 0x74, 0x75, 0x76,
+	0x77, 0x78, 0x79, 0x7a, 0x83, 0x84, 0x85,
+	0x86, 0x87, 0x88, 0x89, 0x8a, 0x92, 0x93,
+	0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a,
+	0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8,
+	0xa9, 0xaa, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6,
+	0xb7, 0xb8, 0xb9, 0xba, 0xc2, 0xc3, 0xc4,
+	0xc5, 0xc6, 0xc7, 0xc8, 0xc9, 0xca, 0xd2,
+	0xd3, 0xd4, 0xd5, 0xd6, 0xd7, 0xd8, 0xd9,
+	0xda, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6,
+	0xe7, 0xe8, 0xe9, 0xea, 0xf1, 0xf2, 0xf3,
+	0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9, 0xfa,
+	0x0b, 0x0c, 0x0d, 0x0e, 0x1b, 0x1c, 0x1d,
+	0x1e, 0x2b, 0x2c, 0x2d, 0x2e, 0x3b, 0x3c,
+	0x3d, 0x3e, 0x4b, 0x4c, 0x4d, 0x4e, 0x5b,
+	0x5c, 0x5d, 0x5e, 0x6b, 0x6c, 0x6d, 0x6e,
+	0x7b, 0x7c, 0x7d, 0x7e, 0x8b, 0x8c, 0x8d,
+	0x8e, 0x9b, 0x9c, 0x9d, 0x9e, 0xab, 0xac,
+	0xad, 0xae, 0xbb, 0xbc, 0xbd, 0xbe, 0xcb,
+	0xcc, 0xcd, 0xce, 0xdb, 0xdc, 0xdd, 0xde,
+	0xeb, 0xec, 0xed, 0xee, 0xfb, 0xfc, 0xfd,
+	0xfe,
+};
+
 static const unsigned char jpeg_dri[] = {
 	0xFF, 0xDD,
 	0x00, 0x04, 0x00, 0x20
@@ -802,7 +932,8 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 	if (dec_ret & SLOT_STATUS_ENC_CONFIG_ERR) {
 		u32 ret = readl(reg + CAST_STATUS12);
 
-		dev_err(dev, "Encoder/decoder error, status=0x%08x", ret);
+		dev_err(dev, "Encoder/decoder error, dec_ret = 0x%08x, status=0x%08x",
+			dec_ret, ret);
 		mxc_jpeg_clr_desc(reg, slot);
 		mxc_jpeg_sw_reset(reg);
 		buf_state = VB2_BUF_STATE_ERROR;
@@ -814,10 +945,11 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 
 	if (jpeg->mode == MXC_JPEG_ENCODE &&
 	    ctx->enc_state == MXC_JPEG_ENC_CONF) {
+		q_data = mxc_jpeg_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
 		ctx->enc_state = MXC_JPEG_ENCODING;
 		dev_dbg(dev, "Encoder config finished. Start encoding...\n");
 		mxc_jpeg_enc_set_quality(dev, reg, ctx->jpeg_quality);
-		mxc_jpeg_enc_mode_go(dev, reg);
+		mxc_jpeg_enc_mode_go(dev, reg, mxc_jpeg_is_extended_sequential(q_data->fmt));
 		goto job_unlock;
 	}
 	if (jpeg->mode == MXC_JPEG_DECODE && jpeg_src_buf->dht_needed) {
@@ -868,8 +1000,12 @@ static int mxc_jpeg_fixup_sof(struct mxc_jpeg_sof *sof,
 			      u16 w, u16 h)
 {
 	int sof_length;
+	const struct mxc_jpeg_fmt *fmt = mxc_jpeg_find_format(fourcc);
 
-	sof->precision = 8; /* TODO allow 8/12 bit precision*/
+	if (fmt)
+		sof->precision = fmt->precision;
+	else
+		sof->precision = 8; /* TODO allow 8/12 bit precision*/
 	sof->height = h;
 	_bswap16(&sof->height);
 	sof->width = w;
@@ -988,16 +1124,28 @@ static unsigned int mxc_jpeg_setup_cfg_stream(void *cfg_stream_vaddr,
 		offset += sizeof(jpeg_app0);
 	}
 
-	memcpy(cfg + offset, jpeg_dqt, sizeof(jpeg_dqt));
-	offset += sizeof(jpeg_dqt);
+	if (mxc_jpeg_is_extended_sequential(fmt)) {
+		memcpy(cfg + offset, jpeg_dqt_extseq, sizeof(jpeg_dqt_extseq));
+		offset += sizeof(jpeg_dqt_extseq);
+
+		memcpy(cfg + offset, jpeg_sof_extseq, sizeof(jpeg_sof_extseq));
+	} else {
+		memcpy(cfg + offset, jpeg_dqt, sizeof(jpeg_dqt));
+		offset += sizeof(jpeg_dqt);
 
-	memcpy(cfg + offset, jpeg_sof_maximal, sizeof(jpeg_sof_maximal));
+		memcpy(cfg + offset, jpeg_sof_maximal, sizeof(jpeg_sof_maximal));
+	}
 	offset += 2; /* skip marker ID */
 	sof = (struct mxc_jpeg_sof *)(cfg + offset);
 	offset += mxc_jpeg_fixup_sof(sof, fourcc, w, h);
 
-	memcpy(cfg + offset, jpeg_dht, sizeof(jpeg_dht));
-	offset += sizeof(jpeg_dht);
+	if (mxc_jpeg_is_extended_sequential(fmt)) {
+		memcpy(cfg + offset, jpeg_dht_extseq, sizeof(jpeg_dht_extseq));
+		offset += sizeof(jpeg_dht_extseq);
+	} else {
+		memcpy(cfg + offset, jpeg_dht, sizeof(jpeg_dht));
+		offset += sizeof(jpeg_dht);
+	}
 
 	memcpy(cfg + offset, jpeg_dri, sizeof(jpeg_dri));
 	offset += sizeof(jpeg_dri);
@@ -1138,6 +1286,10 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
 	desc->stm_ctrl = STM_CTRL_CONFIG_MOD(0) |
 			 STM_CTRL_IMAGE_FORMAT(img_fmt);
 	desc->stm_ctrl |= STM_CTRL_BITBUF_PTR_CLR(1);
+	if (mxc_jpeg_is_extended_sequential(q_data->fmt))
+		desc->stm_ctrl |= STM_CTRL_PIXEL_PRECISION;
+	else
+		desc->stm_ctrl &= ~STM_CTRL_PIXEL_PRECISION;
 	mxc_jpeg_addrs(desc, src_buf, dst_buf, 0);
 	dev_dbg(jpeg->dev, "cfg_desc:\n");
 	print_descriptor_info(jpeg->dev, cfg_desc);
@@ -1338,7 +1490,9 @@ static void mxc_jpeg_device_run(void *priv)
 		ctx->enc_state = MXC_JPEG_ENC_CONF;
 		mxc_jpeg_config_enc_desc(&dst_buf->vb2_buf, ctx,
 					 &src_buf->vb2_buf, &dst_buf->vb2_buf);
-		mxc_jpeg_enc_mode_conf(dev, reg); /* start config phase */
+		/* start config phase */
+		mxc_jpeg_enc_mode_conf(dev, reg,
+				       mxc_jpeg_is_extended_sequential(q_data_out->fmt));
 	} else {
 		dev_dbg(dev, "Decoding on slot %d\n", ctx->slot);
 		print_mxc_buf(jpeg, &src_buf->vb2_buf, 0);
-- 
2.38.1

