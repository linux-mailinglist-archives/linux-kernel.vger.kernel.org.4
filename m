Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0EF65BB1D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbjACHQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjACHQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:16:28 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E0365A0;
        Mon,  2 Jan 2023 23:16:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GP4OmOn/gsuZW1Wt+Enc0Qb4uLXuG/K5djkEbhtGbyX19XQ0HuyAT8cv13rd5ZuP10rRSOBRrVpwUO7AK4sMQMKawjYv26WK9tGQrCHvpqhvPbaabtYOTU/R9jXHo3bcpbhtTc00snhKdC/+VjMriyrGbjhYcQIDhUewBrAH6wfPLmi7SJHc1hH+Pl4KWjTe7dnyDvWjmdFeT//lStFR+15ml+Ojsjvr8Yi13CZCIFKzSUcoVeMYxwYrVLU1/u3PuEnILV6t/VYHii0CuokezZvo9OhSBf6u71uZtzzi1bUrucYKtQa1Qq4FzFQ3pLfbJIbmIldKZXiz+uL20AG7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+y6iIhrS5JunYvVEruqowZ2fSo4orDjM9N9C7SO2Xk=;
 b=DNP32R6ijWhpFjj8AYqa/2WNMpL5RsVK2pDXCM9Las82T3tVEDnTZXbFtM4v/8LLdz2X6+k/0jrJklBGR3hFbOlbeWncLPcSrjkhJkr9FENRCKRZqH6pXhJcj6E9f2cz1lTJ91Ayl/B7+RNTmqWC4utUdgiOo1KqwgstLxFIIO+isIy5C5lPqbYKVzHpQZNaVFQo9nGJkzN3FKyjFP27zRD3T88UnJbtf51LupEQnLdiJzNF+QHrNzPCZoGgo7VRswvc6/kEIjnR6SG9nNkOp2EIcqYGR0nO4XI8sF9GbHbkyBHJl6ywfl9GSPOQlKgkKwBeWbJ3cH1JMRoLh17wog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+y6iIhrS5JunYvVEruqowZ2fSo4orDjM9N9C7SO2Xk=;
 b=G4yRDlNNI+XxW0LKCV3hOh0KTVe3VbJZlZqgzQCgf0o+bCeEob7zsmpASpTVfNtsUzfcyBGkWAvf/eIW33OvnHnLSfz3knSMyK+Cm/LqiMHRxiJ/56AuGmcZD/aRIbrU0WG/dcALCS7171xWsbe70iy865lpaRNUtA0v90fWL/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 07:16:25 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 07:16:25 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] media: s5p-mfc: adapt headers only flag for V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE
Date:   Tue,  3 Jan 2023 15:15:50 +0800
Message-Id: <20230103071551.17775-2-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230103071551.17775-1-ming.qian@nxp.com>
References: <20230103071551.17775-1-ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fa43df-d856-4ae6-659d-08daed5a6cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEIay3vHATT3UQ+HwwD7mrivmpqzfy8Vt7k+ph1yH0kQq6kIRczdZCkEo2r0qPpgr/roXquoskVc/V1OSwWuRoZU+QtylVo8GhmYKWmb0CgoVMnd4n6wslJXhbRc7tyz2Xl3XS0uEA6Mwi+3dMzDyM4nXLg70CihJdeGNdFY5ibbEWeCVLmMdQgfhXF/pXDbZ+eMitdXSqF+34yFwr9/5e1qQeyClKNjgyRrfsR5WmM5ZdfSfBQpXcnrXkwk2Bxyy75odnf/hHQI6pwWgRPgPDvb3WS9KX8C8LKW9qqG9gb9Bd+yhhXJiVvYEigTZvCd6uOst7nF3ka7WU5ZlKwPA3qdSyFnLEzWwKod/qVdFpJ2cQPXKVS2MOcsVbXc0Q0zyTbO+2/DSbis4emaBks0zgw3meBXmrt7X9sPOSGu9nMTJpl3FApSVVUeUUcSYq6RA8B1hotWlTo5X69IP2gCQxAzC9UmeHW8u/MQvWhIWPtAV/fWkyE9x4nxv51WhbV58SHjdrYhPM/z/X0OUzt/urtTCgx9ptn/iz9y6NF+JMmf4t33K9XdBByPYO7raCGz+8dXR0Rl0xPZgF10xtOMhc1cxRt9hilzK3tENyBI1nPhwWlDPUGL2IPT/vm5IQ0+P4jwLLfvXGjBSGXaz7dQb+TDtngdl5MiKPK57BNB54M/dmlbj/JKMZ8ekz5Vq+bQ/nBYnQxuglioVPcFl1F1NVRdgSI59WrxzMzP9pmzA9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199015)(6666004)(6512007)(26005)(52116002)(186003)(1076003)(2616005)(6486002)(6506007)(478600001)(66946007)(8676002)(4326008)(66556008)(8936002)(41300700001)(66476007)(4744005)(7416002)(5660300002)(2906002)(44832011)(38100700002)(38350700002)(86362001)(316002)(36756003)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hcXiqIMcNSnFHZoP5IrgmKYt4mHH34NQAcZIoEZHePZxSIcQ7kKvAXqtVMQP?=
 =?us-ascii?Q?lTRgy3obh3gnBFmct8ta0RFPvzuGxJBmztZXnlFiErBI6ulueqlYRviYn+Du?=
 =?us-ascii?Q?unUlMmqNNT0+BPgx279UCftF9uC8ztr0x3dZ/0eAzmCS7cTG9Zly++VR1qxz?=
 =?us-ascii?Q?r0HtWMpcrvFnSJo0xIVGtZ7AXKQOzpXUzWB3YXskVXn5BflATHxFxqxD0BtX?=
 =?us-ascii?Q?82kCByTG+B/gMbArJHiFYXFHv8avbRmWLM/1v8CW39kvxVDBjJFcqLIyQB8+?=
 =?us-ascii?Q?LtzCEC3jii8ZmzKunnUccqD8+G/CktxJXHUIMQEAY92Jz+pUAdQpFl/mf5zw?=
 =?us-ascii?Q?z7uK1O9l3DCIC2chNMFv4zadIFxZTB1gk021hqgwm3lB73FQOTRBDkGrfyNY?=
 =?us-ascii?Q?kQCzXkbly4RRIRY5WD8TfbUhmjmiWQ7mo1E4KseXX1u8Hq5SK0mv4GByrfCm?=
 =?us-ascii?Q?XUJzdH0Ttg2i/5SFXvMaYtthzmmn5WOdpDk5w/ZnYteh65K8LPGCDZDo+VKo?=
 =?us-ascii?Q?g9BWsK40n4sj5K2lJz5116KvBfhJfyfXR++iG30J9tPb2yDhue4om7J6d7Qo?=
 =?us-ascii?Q?Cys5FJsZX97quLOQgaf8pXjKu6hXagXfABNYwDg/f/fq1eeN5fhcJzaIQIC1?=
 =?us-ascii?Q?r2suqNZmZ1KRRfYCzFa02goMZW507XBLq3bgcJ0rM0Ir1zYFmbx8XDQlocZX?=
 =?us-ascii?Q?33sqwTIqrwjxKzZGcIUZpINm1CWJz9ltqCSRbuprU7WVdfPzMyHJ5gMT8YlD?=
 =?us-ascii?Q?7UrbX2xuUNA7zUyOkz2zN9RngexCNG/bO3gcBfmk9E2XEM2HwZa7FmraBPek?=
 =?us-ascii?Q?z58eEmgMftBqvl+Qe2yDTZVfzzvRFAbwzRiCEcCXxYigdjxh8xPCrVlM6liG?=
 =?us-ascii?Q?vXhZfEXUAjO/2rBRrdQKEx3//FoGigHCEWKP8BcjyPrBgFy/b7SW+BsXasXu?=
 =?us-ascii?Q?L1G2YbLpAUHkEEtiIUDsdXVijldL2B1OV/JiZQPugLDAAu6jsRKWYtMWfPTr?=
 =?us-ascii?Q?miGOnRFtS6+7nYko7GUs8rEIkJqFDfGwLiQ/JjfGRnM5A0+SOYaEA2hoBVsc?=
 =?us-ascii?Q?GNA9C3ftYcg68lDkvDCBH/HYUeDBQ182VHUWb9BUP1yMnki6qMQt8t1tPh3I?=
 =?us-ascii?Q?dwB9zKGMv7m/VGADwvI66oSzhJilbTo6DFjzg2a0FDW0hZOtMfqFpKC2Bh4j?=
 =?us-ascii?Q?ajcntt4j54csogTqXRfEkCc6wvNiRKMWAllp1OZrRrJKAl/GUmh+NanXXWNV?=
 =?us-ascii?Q?JtZxCEFOxcypGaweaUeg1lQDPAq5Ifdjg5AUpa+Njtl9PnGx3HmJ3JBHNzat?=
 =?us-ascii?Q?4ty4Q2ju75O1Nx2KnIDE1zMBHI0aXE8fW2k8enb66BJP1vkLvQriTf/V538g?=
 =?us-ascii?Q?6Mnmb2SlQTAuvcK2IVgOAL2MbObq6UZrZrzNKsTaW0OxieZ0V/fc28a2s06O?=
 =?us-ascii?Q?IWRA3HvLO/4f9goYcWrhl5/Pz+igSTV+ER8F/Ennbu2aOfwVRXKURA755IL/?=
 =?us-ascii?Q?B+NCgWuSCzQBptMLo8LIorTEpCjhpR6nwPgjjU8Sc7ATdTe944pNHI4fFTU3?=
 =?us-ascii?Q?RY/r84CWnME95i3FijajONrdQv8RnQla3Toy8xhc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fa43df-d856-4ae6-659d-08daed5a6cba
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 07:16:25.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnU0vHhtUDXCUId2Ey+BxPj7DN7kOsB+FEIn8cpUWDELzq92bqRz14o4/VK+pxblIjnYDetumGxJ0qlofnN17w==
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
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index f62703cebb77..ca990833753c 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1161,6 +1161,7 @@ static int enc_post_seq_start(struct s5p_mfc_ctx *ctx)
 			vb2_set_plane_payload(&dst_mb->b->vb2_buf, 0,
 				s5p_mfc_hw_call(dev->mfc_ops, get_enc_strm_size,
 						dev));
+			dst_mb->b->flags |= V4L2_BUF_FLAG_HEADERS_ONLY;
 			vb2_buffer_done(&dst_mb->b->vb2_buf,
 					VB2_BUF_STATE_DONE);
 		}
-- 
2.38.1

