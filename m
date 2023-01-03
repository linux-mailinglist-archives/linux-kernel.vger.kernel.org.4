Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FE965BB1B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjACHQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjACHQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:16:26 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2082.outbound.protection.outlook.com [40.107.13.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F043565A0;
        Mon,  2 Jan 2023 23:16:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmKK6XUvZU6fAF0TKhWzLtlxBvpx7b0wUeoBpHJAlwQykDX07ibWQcTeVZoh9HWOGIHHfh0OM3Rsd4Cqz+a+EDHZfxRufm7tqP0/JxJ2awJC+EWGzUFdT2kY0d6nger3AQMgFW5STbpRMLMo67CLJ6dtT50dX/aUAZNUp/7HCYbHUOlmt5x9oOU8cd8uIeFXDcHH1OtmDaMVuvTYcVHGAl6BkOrOGcjjkVKLU09EO8YeQiUwk2NN874yY8X1hek7z3yhu4RVpJ8xmRAvU2HuxjBuI1jma/R2RfFzhLKhgaAL4i1mScIO0WIJlBjnqDS7etP4FTjxRxXr/5Ncu/OLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4ViUXDu71TtUvRlUjlCbWIl4cwHkkzal6U1X/tvOuY=;
 b=fd5ZwmOZp4W21CKjGL3qTw6hkueFZT+Lx9+/Q+o/lXBomMz735/CdN63HPQ0+JQ1c7yYW8jfcRMpx+m3SMBNvTJ4vbSqdMMgZ7ATlSahSGzQYOlTyUcpZZsjggpQlKfHoXlC4KU8mx0otRTx/fJ4Z2GVfbtVUGTSDVHCJbSP13gQent4bsCBcgDvfQMFwchyo+P8zS7tFi9x6C2Gf0g+dXOOaPi0yXNqaa5T6GlqhYCIELBfPpdrXMApwUM7i9oKWwN6D68zNdsYNMCdj/m/K1KXmnHszAWC9PCnhtMD3D6dymsM6PsMW/Zry/Ut1u0TPVEoX1AoOgXhtxIeG8/BzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4ViUXDu71TtUvRlUjlCbWIl4cwHkkzal6U1X/tvOuY=;
 b=obF3QVPIM32PmXAUsDl3NnM7jV2Ll4yeUPcPTpUykDQTXkfp25htdRN3SHrcyp5B4XcmLa2u+awRFX4uSDDEHYtnd/Q4RBtydz3o3wY1kJbGYc+ZeQezb3qxo+LxcbeIbOr/nx07sKFepkbProW1J+j2btrcEyhd9+SQMYup0Y0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 07:16:21 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 07:16:21 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] media: venus: adapt headers only flag for V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE
Date:   Tue,  3 Jan 2023 15:15:49 +0800
Message-Id: <20230103071551.17775-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: b39867a0-c389-4439-29fd-08daed5a6a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOLw4xZwLmQIeYkc/uQfkfqVah7H6SCWJ3B5ss21Am5u05Pvi6kxYuUfbkC9Azd5whZQqja3DzqCqwl3A9A+wHWGzAGuuaViz4nv2YmZEkjjFPt0sKFzycJhRGsirbnsbe6Y+ycQ8FagnYcoFksd7sVypEj9KVo5XGxRfge+XaJMHaTJIWtHTDGydt1dM3WQUkgKnpsRDqFcw5WrP5uZ7s+5hAOTKdLvi7juXn9sqIWcLz2NTx8JrNKk545K86ehm9i+G4RJ5jRhYtkSVBcqswRwLuVL3pXzkHPvGsnoliQI1SAASBncWBAEmiJIfSfqX48j1UK3YKM1B5zEeqpf6ZlDvRN3PLhTPEHOtt0P3uBKmtaGDTjdTAJkXAsToKLhh2EKzR/5/aQBFK1JnoZ+yIBY9t5xxhFJBpGUidu2Q/GiC0JXMF2bUXHjKqZJPnA35vWyFw6WC3jwBT4lX6FStp2beCqbIyijeFUfpFDSaFS13expgC952CPOT388hHEFOdHK2nE6kMHFlR70blUCfLzSKUAYn075gNkDSDxlAG+HupamKto6XmkBr2Ibqb5mJh2ebhseQgMPUoqru1Nqk0g6ZHpiuTZVCzDRDeP5XMH6Me+HklDzBYL6/lNWQhuBxvLZUx9HzJlStkmQAa7rq16duQt2XB5HlEEBREnlPxPzChZPM7rAHamN9cxX70sngotVFk1pzM/B89uoCFr6OHdEWSWo5aCjXEMFujK/7z4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199015)(6666004)(6512007)(26005)(52116002)(186003)(1076003)(2616005)(6486002)(6506007)(478600001)(66946007)(8676002)(4326008)(66556008)(8936002)(41300700001)(66476007)(4744005)(7416002)(5660300002)(2906002)(44832011)(38100700002)(38350700002)(86362001)(316002)(36756003)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WtfARzkzQpu/i/rsKUGEEKgTvgLq/kJ6RHHIx8minHrGbZMbWxtvpi/SR2gp?=
 =?us-ascii?Q?wsiv6Ou8a4spvYlH87OeU9oQivB9hkhBwTantM+beH1xb0M0zo8svIN6RMfh?=
 =?us-ascii?Q?OrUBCUCmO5QooeLq0uANPLNP4uym6D9I7+O7xU0rOxpX90973KazFm9xBU6C?=
 =?us-ascii?Q?aHPkK0jQPikJ/JDLdk0R3STYKJ9/DqODn2mkbJAfLJxS/zLQhAkpZepr1e0t?=
 =?us-ascii?Q?8XxmLf3stO/FTcjqvdnP7Mn3Bc6gxjqC6zt5DxVqAoRDEt1Cio5G6B5YkNi1?=
 =?us-ascii?Q?TrdKUgAzVyIWy/DpKPYbLn20KFT+y59BgHDnw2BiyHCOpJtab1Ybb7uEmUNt?=
 =?us-ascii?Q?6GbylEkOH+uh9kbGZGMgf3egrweoRIPPha9GAoLM5+eBiOlvhewUXWE9fbHQ?=
 =?us-ascii?Q?MMPdsGxf8ya8Z1HQYAAPuAuvhT7u4VZH7tgA8Kczwu9giXw75yp9jJIpoFWs?=
 =?us-ascii?Q?B50aP7q9AJ8r+yLfMDaCTql0pt0r3MLGEb1vDpbcKoAgbW7xjIDfNADZFnZq?=
 =?us-ascii?Q?zcbzGSe9rzH4qTv+q/evgrL5wTnmefmU9IfAL5eU19lM2LWsVb9cIKpjcNJ8?=
 =?us-ascii?Q?9ydtaJWA+l34unMfVRB5p8QzitgMaZ3W9iMgfeu3YwOfUTA5jB5BJlmoV5RR?=
 =?us-ascii?Q?cHKeBpOjH84wh+qougQkvQ5yZXcs8j0zJN7Rh6BzFOSiXZQI5SILFYrIdbfF?=
 =?us-ascii?Q?Xkf1T37pYlCrfg5ZR5dVIBzDdTA9Yy4m1jJLwAEs1lvE5eNkCw+12d7z63CA?=
 =?us-ascii?Q?pmhrMXZ9Yks8XlxWSwoOWzwUQOv9/3098xncAA1KKSmxcU1mCujc2ADQRGAt?=
 =?us-ascii?Q?C3rObUgs21GvjgashznhEsam2rk6xwpBgMaLb+TIq9V6p8IeFETrdlJ4SCrb?=
 =?us-ascii?Q?84C4YKXBINIkpSEej9fw5PTvTS8T9ygsYRXTRM/dnemq14x+KgQs8px2fwR2?=
 =?us-ascii?Q?pSfJtpmYVCmF0VHlAycsYn5vGNPa+Dwo+p8CCqfbnp4ap3GzqU9QQQzWTrXY?=
 =?us-ascii?Q?HtE2Qly3ZytjeOkScWM7Cow2YjIHAZDIvtC46yui6y6X8zN3hGYUg7rv9H4T?=
 =?us-ascii?Q?++BNAAGuYCJGEYIz1KsrUTGdK2GIbgpzGi5Y/zSwNJKBqTahPmosF2ftBqWW?=
 =?us-ascii?Q?OqQlZAE5MMzlseroC60hqz9iiMBZCRT8gLsSyktjqNOzZPLy66aC/3/LGCMa?=
 =?us-ascii?Q?qL2vAiUOcv94ic/2fbF6u0ZQtHzN0GML7kMKF1SC/Sgf/Vr8PdQCkMKhxFKk?=
 =?us-ascii?Q?ACMSDugbOx3BdXvuij22ShOU74qbzzNnZST67zQeu5iVsyfQoQHDuKkVZ+4+?=
 =?us-ascii?Q?uZgx75BTsSQ8B1sqFdHHVqx9ubEHAsPwzp1RgibmWQPItJt5NQYPTXa+Erha?=
 =?us-ascii?Q?nf458pyo42KjN6dsQccvaG/mZ3Kze9dQ7TxOjpUyoHfDuNv0VHKsEd+Sti6A?=
 =?us-ascii?Q?Er8DgaS6kxmBI/V5euvhuZQ97WauIzs5hl/nz7zh1lYYeWUDRiCp1XL3GA5R?=
 =?us-ascii?Q?jFTAohhKNR2xM2qF8q2H7mJX0LutPJlf3DAdJjKBtIqSWfJalC4RRFF+c3pO?=
 =?us-ascii?Q?uoEpnXgpDt35LdpuCRHTsxGovKWseu7vwWo5UUls?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39867a0-c389-4439-29fd-08daed5a6a2d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 07:16:21.3655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fy92XVw8WjS9fbz4CpZmDcJ8RzRJcFjyJIcuSLwFQJmxPHZ3e69XsizOq+FgxfvpkOOUmpuJuIsEcqS/RLGgzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE is chosen,
the first buffer only contains stream header,
so apply the flag V4L2_BUF_FLAG_HEADERS_ONLY

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/qcom/venus/venc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index cdb12546c4fa..33c8e4329f6e 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -1260,6 +1260,9 @@ static void venc_buf_done(struct venus_inst *inst, unsigned int buf_type,
 		vb->planes[0].data_offset = data_offset;
 		vb->timestamp = timestamp_us * NSEC_PER_USEC;
 		vbuf->sequence = inst->sequence_cap++;
+		if (inst->controls.enc.header_mode == V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE &&
+		    !vbuf->sequence)
+			vbuf->flags |= V4L2_BUF_FLAG_HEADERS_ONLY;
 	} else {
 		vbuf->sequence = inst->sequence_out++;
 	}
-- 
2.38.1

