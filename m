Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE376B8F68
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjCNKL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCNKLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:11:35 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA3499D54;
        Tue, 14 Mar 2023 03:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1EEcL/9tjr9jZyCQq5TdJaMQ8UDN9jgQvOMhw1cPGQn1eWGdvfVhJA0rYSj0kZBuPQSABJA+ntp3aHSJEgHAI/AERZYATb6/NxXhGGLlJN8zzxuHQAgvDAm5YwJEyN2A+TVa38FoFDezmERsnQeaeoYVm/jerBWiO/2dYGr7NSnclW9evVI90cKMDYbu7fd2mRWGZAL3TCtG4IsJZmpSpdrCeHu95SOOTT7VrDOhFBbOWDu+ZZtjDoXTGblyPeAWDmWO5DzFCMG29GvR3bAB0JUo2ZMy7k3OesjZI0rZMvhoJsRFTWv4I/9E1AXCV1GvFkyavxOJwdvbjJP+g/W8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWE2v7gcmTZgAjF135o2R8bWHo+YHguXRwe76ddTpZg=;
 b=Uk2eDZgYhidkyFFnmvjRDP4YByREJhZuWscP5ZVWqAGKPewFqyRq30XUGNjZQxZU7dFomYE8O68NEluOOmYFzIEy3qn1kq9PX9GfYyUcRE4HcWIVU34dxC0eh0FzzI+vAjpOkEgHjnua9pU1GWYcD5fEHSBIReCqzjBSCkmwo/qoR2vSTnlwLroXrh6u/lSuWgkL3T179k6dTkM6K3r8i8SfRX9D0UoSnCpcaLm+Qnx9IyVyrLXPFgxScvXhvnbRZMvDLV2hCkxM3QSw7QL33KIGcc9+VzMPolHgr7goQNON2O4wtFFDsrcPts5ScNuhIAkZ/FKVgPkwbNPWUgrCWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWE2v7gcmTZgAjF135o2R8bWHo+YHguXRwe76ddTpZg=;
 b=mYT2cu1muHd2/4kPNOnMWb8zg3G852QW/eYJVRutscwnILa9h0dlGUeYvQT1V432GVsTeu4qg0ny8Rikoq6jJq1Ns5gMMOurZAZ2ESJO+ipNaM+8YSRi+IhoMpkh3j9TCAeN95Q2BVDt8rgXszBcfC3mSOvqjGBDt0j7pI1aPZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM8PR04MB7841.eurprd04.prod.outlook.com (2603:10a6:20b:244::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 10:10:30 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 10:10:30 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 08/10] media: imx-jpeg: Clear slot next desc ptr if config error
Date:   Tue, 14 Mar 2023 18:08:51 +0800
Message-Id: <5541277a3c93fd141e35a7fef0bd87047afdb532.1678788305.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1678788305.git.ming.qian@nxp.com>
References: <cover.1678788305.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM8PR04MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 576f03e4-873a-454b-0ee2-08db2474575b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OZ3gAOjUS7tWO49M7DmYF0CHcQVugL3JPSmhr1oFB2SPjnUSLyBJfH7F0QjQR4lEJqapL+dlx4uf9vekV43bLBzKMOYQXJHptXP74Rxwf0D//x/foN5A8+FFQMqTUU64z3TmDRW1PYmvA2KJ04AA0AlW2buYN2nGcpkmfRLLtHihbWdzYREZAGW//TKbJeEOfKx01pPbVvrNrzFkfYMbvXAF6sY9FR0YaOZAtmvyzVRXDosnZE9XYsI7Jc3ikr0Z2elpyWnFS+4md64v9ffxzQUpVJz7L8CHBkQXA0xGLGQvf9lzmFQoEMfRoH8+V+biIz42fc8LmgWAXJH9lbq5TGOF9q2LRBxAxQTQiSuY/nQYdBBq9oAq71msco3CmozoJp9ah7wizxo7gusIxfw8aBtiOppgbQnDm/PQAC/Iij88v0V3HVt0U/WeMaVenY+5cz7x1lORouKRUY1wvc4ePvwbKlAs9MxzKTmzTgPTeO8j8yCs3PzJqHgBYMxxypKZphDj7pf5qh6WnYmLhKTUOW5hnkOK3mkJINDvnpitL3lCPTDncNIlj+p9+C7vEyq/1+TAHMLloBetP503OcUaPdtfBJ/buPXdICRBGJwzkiJXpFoaDcLSDoEv9hDG8ohr9cbsBpDvQO1FwT6UsfE5EUAg/oVzbfA+rxPwvoRORc2Kd0nAj2BydX3zUU6tc710Tmm4y7zTjx2yXhvzRuAqJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199018)(7416002)(5660300002)(8936002)(2906002)(44832011)(38350700002)(38100700002)(86362001)(36756003)(41300700001)(478600001)(66946007)(66556008)(66476007)(8676002)(6486002)(6666004)(4326008)(52116002)(316002)(186003)(26005)(6506007)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+UaPdT+G2xzAxaWnTBztwORH0iqBvYzU+lJW/BY0HuB1KyHxq5V6rYfX1J+w?=
 =?us-ascii?Q?GWHVO3Zn+4VrXxHW4xQ5u8U0w+GA/+aSe6ZpWeLp/3ROROISbfxo8ODv87vZ?=
 =?us-ascii?Q?TtcDReFa0Fae6VwW6No3G8PfyEvUQ9ee17MDe1Oh/PFSt76ZeKTu5Uc2bDbV?=
 =?us-ascii?Q?hYBRv5EmZZkVUWJiGLKmXeYFTSOmPWVLLQx4mQS4J4+3SAv5bKzJpVq6IqI8?=
 =?us-ascii?Q?zhfn/gVHlFMeUj6Pd2BuV3U/xry/Q7yhleTeFshkkHF+jGVrIlz7ThbTC/iw?=
 =?us-ascii?Q?fQNh/UNtjUM02X+98vQXhP9nAMOCZh3fJ95zp7aIWRE+MAm4sHG/OvWxOZjL?=
 =?us-ascii?Q?Vk4z7ctrxJ43ModZQ6DD/J8SxptsJk8sd4xiPqIrLpbUIUOK/3laK88WpeJO?=
 =?us-ascii?Q?QlukHpC7eypZnHAwTeWZcH5IJEt21aSkXdrHe+sS92JeNjmnMspxDbcGN+/K?=
 =?us-ascii?Q?2d0HZLA5NbIdbvOF0E9eEXfsGri640Tg/Q/U09JU3eOG69IoZIvA15T5CELo?=
 =?us-ascii?Q?5JYHKpVIunrMlnth0gwU3ZOyOfZGcpsRVo9/bW+OmBPsfQ1V3lBs9qlYbvXg?=
 =?us-ascii?Q?JlhY09Zlr8ek8BCl+dd7HL1TiAGIzPFXUZqsZfMUtaMpOJ/X5t8URKNijXGp?=
 =?us-ascii?Q?4UI37WUalwG9UBByAALTF0uT07jdtprc0g85ruax1DpTdbipM2nZoIT4CyFg?=
 =?us-ascii?Q?F2BgOq1BDYBUiHbSVCvgbIflF3AxH2T8FX8A5fZyMXfATY5duMRC7BZx4fZ+?=
 =?us-ascii?Q?hO7VLptimL9xhC+eJM3BVTccl01K9zSKAIyFFezukqZYb/pA1troxuR3U0EL?=
 =?us-ascii?Q?2M2LpJjaL3FewWZW34PrKNtWV2IBdo14Nf2uMvCvV5axNDBqpAG3GtrYStpa?=
 =?us-ascii?Q?1V6cMmyzw874NkdWe8FK3Y2UOX5edsSeEjc5nz8kBexpPmKBrNJjSkz+SnUS?=
 =?us-ascii?Q?d74PYdzA7+BYnpJMnwi3W6psOiYvSim2kLptqCjLBa5yfGSbTaRl3K2136ge?=
 =?us-ascii?Q?8qpjkxW3eyiltS3jQqAjNTRoJLin8HQKd5GACMKHq1Dfx6OOkts+Vz+0uMA8?=
 =?us-ascii?Q?ONxifabN/CNmqKxcBh3KGQF7zNa6sjzg9L3Z7evfGKq7yEM2fTNLSAxVRFXZ?=
 =?us-ascii?Q?z8k3F/1S8RVk5BXUVd1/NY/dQVRSS/g2Vh8nkXnv58II/81QIuK/akL0Nrdb?=
 =?us-ascii?Q?SYybTqBe4s+itFNZMPCHzbhNDKYGPFM2V91pnOeJZrm3VnFZ5UYSZH15/4P0?=
 =?us-ascii?Q?GuihBkPd49xR5OuHw2ehh8JNOuXkxG2QFlGEuha4ws0axyvS9DFGOjVLcg/z?=
 =?us-ascii?Q?LWD7RaFqzjPxafHII2Dk7fdRXPNjgdjILwl/MiypA6FtoplpFq1NLhsoifcK?=
 =?us-ascii?Q?mVOTu58wtoDT/KB1SfJfMiYhhuPxEzo33/KqVPvUBsIa7wnVr0VwqyitTLM9?=
 =?us-ascii?Q?Xs8zd8O9yQ+aVJVLYeuV9QchGYpspnpoZ4bYxBrPTY8C05fRpxSDFlzJBBxm?=
 =?us-ascii?Q?NsBT+zCp21TVpoVJrr/mAmnjAwE+n3Wez0a+zddoQG00JE13bMYJK1GA07eO?=
 =?us-ascii?Q?cyMJG7BSpWyJBUYhMcEghN5Cp8NAKRy36IGtZIom?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576f03e4-873a-454b-0ee2-08db2474575b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 10:10:30.5479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbjgtHp9RIJfbiun0HK5zh7nBTfaeaAmDzaq1m1luj7jIfJAidoRSZ+cExPUAMLG5yna9BApzPJWYMsQfb+lXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7841
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear slot next desc ptr if config error,
otherwise codec will report config error interrupt repeatedly,
it may led to system hang.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c | 5 +++++
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h | 1 +
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
index ef28122a5ed4..bbd5d6a9fc86 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
@@ -178,3 +178,8 @@ void mxc_jpeg_set_desc(u32 desc, void __iomem *reg, int slot)
 	writel(desc | MXC_NXT_DESCPT_EN,
 	       reg + MXC_SLOT_OFFSET(slot, SLOT_NXT_DESCPT_PTR));
 }
+
+void mxc_jpeg_clr_desc(void __iomem *reg, int slot)
+{
+	writel(0, reg + MXC_SLOT_OFFSET(slot, SLOT_NXT_DESCPT_PTR));
+}
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
index ecf3b6562ba2..8b7cd6526efd 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
@@ -137,6 +137,7 @@ void mxc_jpeg_set_bufsize(struct mxc_jpeg_desc *desc,  u32 bufsize);
 void mxc_jpeg_set_res(struct mxc_jpeg_desc *desc, u16 w, u16 h);
 void mxc_jpeg_set_line_pitch(struct mxc_jpeg_desc *desc, u32 line_pitch);
 void mxc_jpeg_set_desc(u32 desc, void __iomem *reg, int slot);
+void mxc_jpeg_clr_desc(void __iomem *reg, int slot);
 void mxc_jpeg_set_regs_from_desc(struct mxc_jpeg_desc *desc,
 				 void __iomem *reg);
 #endif
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 70b6eea733e7..3f1c9bc4b144 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -692,6 +692,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 		u32 ret = readl(reg + CAST_STATUS12);
 
 		dev_err(dev, "Encoder/decoder error, status=0x%08x", ret);
+		mxc_jpeg_clr_desc(reg, slot);
 		mxc_jpeg_sw_reset(reg);
 		buf_state = VB2_BUF_STATE_ERROR;
 		goto buffers_done;
-- 
2.38.1

