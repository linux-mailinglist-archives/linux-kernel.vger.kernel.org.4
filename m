Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D80E65196F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiLTDOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiLTDN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:13:56 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2078.outbound.protection.outlook.com [40.107.15.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57839140FA;
        Mon, 19 Dec 2022 19:13:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dje3pO7Ux749KirwSq03wfZLA+DO0xyTjm222+CicYINSmvkGnQuNZE/eI4cF7Xocs7sarcg7ukY4KViQi/vs9XLeEv/88LoGngY7TRNrxPCTayWRQH/v7+Z5bzi4a5bastwChu8nyhty5ogDP+8MFW4CtJaxwOmcvE65AIVFi7xiaZEaNnBjFZnt+HB/U/pb/r2r3gYQ3IpRZ9v8J7FHXfDcL5KR0u0CuIQ7NvtQZZwaeaG+88McJtamKih4t7amUG6aXtCfvoRPn3yKfG49mfwu8J6awbC7kjz7hPA0V02N6hek2gZiXT7/SSK9mFecKpgJDo82S6K06WUFyFZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9h8uKZQTfzm8jvmCuYuAAtG0YH8HMxtyA0Tm6yFmwWk=;
 b=ZqL9bI5GlD760PiPuzBHxTkN+5TieOKLaqkZkacIFO1s2eT6EOpyUCTsn6mjv02wiVeOLoOv7IzcYwh0vVC4DeMQ4qdSzKPgUyfINYXZeo3Ym7yhuexO+WWZ6mD5fzt+p5wNtv0sJxVw2C3jPmnBkZCR+Wwm8Y27btobFbnQwL5x1oRC0QCAjUb0j65u2TfPtH75i2wla8krYg2Z30OB8ZLC4bR4cY3W3lljig5H8/fi1IX++yfKOUijvlkSmy/ZZgWx+3zwHoOK/i8/XzmjxKAHcS37+UBBB85hLH+R9tWMeUal4GYCnmGN4iJBRbClW/Ww+jYIp7WOW45iFz/zUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9h8uKZQTfzm8jvmCuYuAAtG0YH8HMxtyA0Tm6yFmwWk=;
 b=XPwA9VPLi8A+4HxQV871BMcZw5t50HFDPQ9Xpl6SmBdMNRpWYkJqBFYsi5J4gukqi6f+DgB+8BUIonUtTfdj/44FE0Qzacds89s5AivyUOyeBlzwKrz05sm+DCEOANDz0WrIxqsaATulZNCxdqqZZ86hI1A2cJpewoCfxgHrEJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 03:12:48 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 03:12:48 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/10] media: imx-jpeg: Clear slot next desc ptr if config error
Date:   Tue, 20 Dec 2022 11:11:38 +0800
Message-Id: <da224b543b5b28f6cdc0e44837977a116058db2a.1671071730.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1671071730.git.ming.qian@nxp.com>
References: <cover.1671071730.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AS1PR04MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: f237a628-5683-481e-ab50-08dae2381228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rh9P4ULE6snb25bnfwZgB3GoIMADpG+1KJceAnr8GI1gLsGEE3f7VCcc3CcSUlvT7bfdhboFr/XEgRmiU23L1XdgafHDEXLpLHUw1TEutAfUWQAWmjYSOnZHzuA0HTc4TUWVeQMo869V+VWK4GKRnxMOED7b9+xNTt5AUX4KzqN+K2sD6aBtE8BAn+JfWYJX/OoWUO98hQOHVd3nta+tL3+tYWyZ+JbyqLXXpkvfWikdsO2720owEOlkili2bKava8tGrS6ZUoOl4wnkJ/29sd9Vbhm3u8ODieeQUWiwmetT9xyaGn35XfkATDWZF5ImDfhL/zjHqwysBNfkrR+rwnOgJ+H2SnxMxRuF835LzfBpVfVWula0/lCBbaaaM9mx+ZMg0wIeA99d/n6PbodriXlxNkyzZn6UR1PISKyHmq37dueDvv0QTBxm4dhp1YwKfSiVFEJUG8KEqv5wkfP0qtsz3R7/09DuuKOZQcgRh/1oymFcB4NsGpirPlGexQ3gbdOTiP4HBxkDI62Nkwnod7IAmyig0f+ETtULl0S/tSX+N6bCjGnpw1yxZGnX+uiZMWT2ou6Y5vN5Dr6ukwE9fkBQw8K3uYAw8ijTDlI1WAF/lxUvZzYP9+Ra54WWDNZFX6KD0YFqnOEp8CBqp6daYUTlIRYYFMxuP3gD9RcK7cD/hdhiXHWdoypZnKkJkunA6ZgUyPyCloRh5+FQjiT7qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199015)(36756003)(86362001)(478600001)(316002)(6486002)(66476007)(8676002)(52116002)(7416002)(2906002)(6666004)(5660300002)(44832011)(66946007)(41300700001)(8936002)(66556008)(4326008)(6506007)(38100700002)(26005)(38350700002)(6512007)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2TuSKkFiqMULsHju4dekT8KZydnTkSPsp7H4ZNVI5BL52MHu/6z9SCjn5ksN?=
 =?us-ascii?Q?x0M28oj7poKi4kg9hb66Kyn+f10SuJsoltc5+OotDC59nT3+8SnSrnTRTuYr?=
 =?us-ascii?Q?eHS1v4NbgHOY8FgSc+dR1EHfbWjNYIRE6hQbi5WWU7FdYcXxSCIPNejk8XYZ?=
 =?us-ascii?Q?1sO5AKO7bPUGKPU0xzpfW1vP1urEe4IYSFcGICzHpxAdSgbR8uiHJJWQYky3?=
 =?us-ascii?Q?hwbgEVn8mEFIhPNQWM/rPupWK9XwhZDrCtnmDv91/iojH8T3++i29dsg8oTk?=
 =?us-ascii?Q?HzzHVy2x6o/SKl3yqeXOuafY5bGbepuRmKhVVzxiufp5tU8gnXkpgUn+lcMG?=
 =?us-ascii?Q?ekU4EIumiw90v+nZx0kdP9u4AXzV8ZHMYtu+M69bDZP1t8qRxG9M+jJhaMH3?=
 =?us-ascii?Q?ETtMyZXRlEA2I1Nx+yy44oz1RXFjlManBjVaf1W9hJANMGp9rUrpiV/5OqGi?=
 =?us-ascii?Q?a5HGPxFCO8sDzB5rESE70WNh8ugvLQzUA7FUB63lzxQ6IsQfTQgUwdKDPTPP?=
 =?us-ascii?Q?C1sJKPbjNz2JM9OZlLk3wHESAimQqDSKE0k6KDA04n63rHpmQJBKKApoTyU7?=
 =?us-ascii?Q?YgVkgA5zrnn7+0D99//3ycC8hbQ0m6NbzMcl8GF+3hMY8ooWFu7M6mcjZ+wO?=
 =?us-ascii?Q?vX/rRP+oOVaidbVEgS+tng7Tcx/KNbSZOPDJPYFtZIU72oTq3yELt5IDeZ55?=
 =?us-ascii?Q?h8y1Sxxks8jQz0Vd0zTesmJTEcMGhNzqIDdsM/x23iAK6FBuY5s6y01AXbut?=
 =?us-ascii?Q?vQeqEB0vsg1q3z2nk5+IxwWhXzsGHBwhOkekgNgLhl5gcnAarfoZcQePcAal?=
 =?us-ascii?Q?zsbEQVvKyICS76EfAKMVbE8+mYi9MVd4bh54YKwXRAvVuvwoRVuhvgmZDist?=
 =?us-ascii?Q?zqu51GCBSXTEliLBtjac97YVMLb8OO6fXf1zcUCuEg+4+QWLMdHh0KWmwns2?=
 =?us-ascii?Q?Ash4ZsaOIMQwW75gsd2vkbzlqYJG32SRpS9YC/UAc/0P+uCnHDaweylG7Eay?=
 =?us-ascii?Q?UhZd4kaPEB7d/q8HoiJRn15/BDaBhd59vJVeIqNIqdOeaALa2gwkUQt34VSc?=
 =?us-ascii?Q?kzS5KltSRhus40eNf23B+Cvdrdmt/mY27hPAHjsiiyWLdHsYnfbozB9G+pAD?=
 =?us-ascii?Q?28NhxW4QHNlQiNBG57Wf3RwVDW0EEI/Wen2TyLuuBTmsfs5UHddWq7ibv6ig?=
 =?us-ascii?Q?MjBFQIOtzPY5ZHNYWDBww1zYTDAMFQBw/3HZ/teWAcRfLVAZGUXFGP4zFHSQ?=
 =?us-ascii?Q?TPyUaUVKK6FM//tqAX8A0XMOySA9UT2VV0EjsVFpdzmEEBCBNQOBHZ93B78u?=
 =?us-ascii?Q?4YgKy5EX9oxmp1ClPB1zH+XB5aKDgor2Z+UM2jk3U717XuN5I2IILWqtuI2j?=
 =?us-ascii?Q?e72OkMGIk6akqklALAABtb/P16aBIf04Ng+Lp8YqYyMuvawgi7ud+CyMJ6mC?=
 =?us-ascii?Q?KO15mw5ZnzPwWfb27+/VH1qwPWj1O1YOZz4GJvvSGa4T3IisQlsRc9Fd+H9e?=
 =?us-ascii?Q?n0fS/1NdeHANzGiiTg88+6uIrafv5qbNgzQSvEZ9qRVq7FIzApwg+26faKfX?=
 =?us-ascii?Q?d1RyQ2BCe+h8Uto3BKPY20EMeihlTaJA2TC9lNW7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f237a628-5683-481e-ab50-08dae2381228
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 03:12:48.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnmjyCfisowG5MJY9HMrjqHWmuSLBEDRDhMsseGd8rW06p2XMd9GzO/O6tCiRNrawzpO2amNGMoa8bsDJhxjzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9405
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
index 97e61e28c649..7c3ad1ee4769 100644
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

