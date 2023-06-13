Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1597D72DB7A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbjFMHtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238440AbjFMHtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:49:13 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68B7E7C;
        Tue, 13 Jun 2023 00:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcATIlpWfP6B/IevjecTIeRA7x6NsnNH2IGwikXU40H1Ncwjl08ze2csd7LVlAN51k0n1owAfoSAI2l1gSQDdogoRjkSFUn3/4mofrQmL2CedxKvzppjV3Iydz3YWmw90XlR78A3EytYMM+HmFVAkFa3uEeCythN7tEQJuqMavfX9ni7T2gkoWOe2tJ2e1Fn3vX2ktqIz6qXcp04+h8XnpEnqEgALhuVwdprZPSX95fcbKUNXoMFos3UacFR39bDcCpDZtjwms1//EwZcg9JJ+baUrsqU/FeqEKGsNw74Wznstp45vyo0+FgSceUez7VBUkfHh9VQ2kC8sX4w1IM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af93fDqXRu5YU8Vnwu8C4ZAYZOBeMNDCy2/lscY4CF4=;
 b=Vsc+MH5EXs7tvz5QAbKtERWEhfdRwzRN1tvEouGAmKqxwEYYhEFKGU4AsGklxZRvoOsPadaDWCbiH91U3yOLkoAcHY+jYn6zMVSfiRiNunjTWO2H/d85z7Tz2LtgugVU+cRNOhX2B86BSdl3GN5D9/VXVqWqeq+S8xXdg+nXgD+FKJjjr/9YIots2Xc0XnjgFqthXJy8Cz+R+FPdNR/NPY/YVFlaF5N8bJbcpVcb4S7CPCByMVH1cMVSa5ZQJ45QYD1hLNx9xhmvqvTJdeH+veZsan/Iii0OHrKfRbZK7/dbLCQY8f4NgvaV/Fg/mlbJFw8zDGPiDOW5z8ujh+71Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Af93fDqXRu5YU8Vnwu8C4ZAYZOBeMNDCy2/lscY4CF4=;
 b=DlRkud95rJdbFtpnM7rl5WZUJOdl7oH6ApmwZoqzaAzEtT6/nJBVgBLI2lJi4rduYAKzvWzmEZI08EipdStnuoHNWgOq+8hbRLrnXWums18E8arIQC56Rd3f9ug6QatN5MIOetoj3okXeHekVy5Qz3iPzHk1kYY17kHHdJtSPUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB8591.eurprd04.prod.outlook.com (2603:10a6:102:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 07:49:08 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::79f2:2888:dbd7:ad6f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::79f2:2888:dbd7:ad6f%7]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 07:49:08 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: reinit vpu if reqbufs output 0
Date:   Tue, 13 Jun 2023 15:48:46 +0800
Message-Id: <20230613074846.25964-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0193.apcprd06.prod.outlook.com (2603:1096:4:1::25)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1f6871-cc36-4175-69be-08db6be2ab3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCBpNE3efftURHO2hgjl9imdD5fWU6de7zcHzdLkNdPgJ0rDgmTMU9y4+2J5/wiBL/NW+pJhmsA7JegkAjginLaUWUMroLG9lVi9KCndeh1zWtmT9u84FtlqtI77EnqF7QzxcYlA9YbLpy8T5DLhHQDcsHCXHvMwlpEe9ivIzm9THZlhLx3TkSLGwg+ngpHOZazjCsNovRsZM/JoPeClFPX/DFSkrT2Xaw3KPTi84SDbcMh9A5021vlrXSHmLPjlCnRsoyIJAKJBDCyBoJ/zRi89t04/Wgs/jOdB51C0GwqIBNW649ngPzY2Vpe5Uf9Deu6pxKsCIiOGrsbzWaWaOS+NeUsKaHSqddLe/ULRc3N3zPfjYLMO/3V025riLgAFAtGmJHC9xYSb1uzOENZoGv43PCojhu9nqZGIiBUGTOVza9HvjEXnqWElnISCq+73J9GH6DUBIIEOtC0cxB5oehQ/QTC8K1vKvKfIIVXz78nYd6qCIwbEOxu5xvtQgKeM1feFbLL/JzSig7DnkxELnYKPGNZxlZSt57+0ybXxlTnrS4saDDSjydUbELP0voNgGieVzpzYm5YbbvlYrM2aKv1G/DnwT3v6VE38BpPEj7f6DLDb1C2B3yWGj+ix2v8Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(6486002)(52116002)(6666004)(83380400001)(36756003)(2616005)(38100700002)(38350700002)(86362001)(6512007)(1076003)(6506007)(26005)(186003)(2906002)(66476007)(4326008)(44832011)(316002)(7416002)(66556008)(66946007)(41300700001)(5660300002)(478600001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9YkpMoFW/nXiuCHiEz6p5OqkOggvPw3B0GGqfPN1OEIvJ3JJCMepZ5lFkj8J?=
 =?us-ascii?Q?JWyVtRPd/m0/W7tuh27pSqtmERZoCTvXU9EWUyXZToJLpTRzHaJgBBd6lL3D?=
 =?us-ascii?Q?YoYDRbWIGES+4M9p1ibqpYEaPwkUpVJyEXDZSNs5O4i1SflhL/ddAaz8+Yw0?=
 =?us-ascii?Q?zV94cM8jZVKCUl06P8b1k8cJ8WAqRSSD6TQ1seFSZyFMOOyRIv5BCLoISJXd?=
 =?us-ascii?Q?VQq90aADdJEwsQmezjZwzRbIjAhEc9wnJDtsiR9os61v/i9NtANs8N2KmWdp?=
 =?us-ascii?Q?jjzJBPIlNFJyJ1cJdDlnccygS2Ks7EEBa3icuEXHgGd0mMr7cmKVxv45BvBi?=
 =?us-ascii?Q?3xHBGQX9V1FmvgubloPoYjB2r/z70q+HtqyTdVCGgGp+rHQu2l/FgvpUP4a4?=
 =?us-ascii?Q?+GkSwKxyF3jx0fDY05iDHPZFIQheBJWralusG87o5eekwU0dfolKdBhbbMxJ?=
 =?us-ascii?Q?ynO9zdyPD8+D0Ia9TB0iakxpjBrTCEoDEnoEo+3eJy8GHCtCpTi5rvaVPYnA?=
 =?us-ascii?Q?hbIFQqeGZKbN+C+ILJGW2Tk8mUdoHT1rmrHiFraOh1YNDLY5B+TtN0kxOVN2?=
 =?us-ascii?Q?1+Qdk20M+L6ZEzY965GR/JzHDjdsqW/eEUVPe2gJtxDW0ETTP7gU8KsMY0Lt?=
 =?us-ascii?Q?oU5Z+T1vsWHec9iYuTGFyP02v0YqxgN4AQRjh+77xcJShbc4TCwkHprjLkOO?=
 =?us-ascii?Q?wJyrCj9R5dZO7eigNyIDFvWbj0GiVZGLpyyL0HdD1sMEJBR17ivZ9ADEfwPG?=
 =?us-ascii?Q?f3Yg7qDrr1cQGuhisdEUeb6vKR7BoZZ0dOoCP4g74hy0JiwHC2gkUFd31+x9?=
 =?us-ascii?Q?tmKMoVaFHicHPkvBvODN/kCFPPUcUoXEkwYGsiIRtQfimDxGihENU77aJaIr?=
 =?us-ascii?Q?9YjqPzSzz310PVUrs3t20QC47dYCcGMRd7U9m/JjM86DHzaBUev7BImPP/kE?=
 =?us-ascii?Q?CMByzFmD4PCGeRw3jwMJjkHbY8F2boF0+BusmtQVKQaSBQhYHUHi3KYPgQ1a?=
 =?us-ascii?Q?6Cn7NY9p49PXpiUvYVFHSxbhVy2MvIrGtPvGMhloC+alwufo2suAjylisaYD?=
 =?us-ascii?Q?0nzcxpLCAjj+qOoMUyXtlhRE9vyCsIPbiszDABvl9jyC3i3K/wdivft4deVd?=
 =?us-ascii?Q?9o2nI1TkkdxbsTVExyPN50ldkRUMv2G+wskaCZVrwh0cohlDscE8zyY0fqg4?=
 =?us-ascii?Q?dqUiygVh82RYVODbLDApJhoWgsmO6SmWvC2ysNqk90EaBV6xYMaw0DZweltv?=
 =?us-ascii?Q?jcIx09oobizHgLrG8gNH7s200hsOzhbAJ6dhyhtRhQvY6TImX4bK+kC73k7m?=
 =?us-ascii?Q?NXi01S5+tcaVzt7CWOA8SNyMpGmD6AfJDXTFDdwZjT1k+yww2sue+FjzpES+?=
 =?us-ascii?Q?wICdA0tlnzjRtvuVKTtb4cBXvXOsNvQ9n8MvjbhOruVCdppIc0qf9aWt7+5x?=
 =?us-ascii?Q?klvH/Q9HHM8zIqefj9GsE3QRXa3HcxOncV9j+o224Hfo+6HovINm6mdO5vdc?=
 =?us-ascii?Q?x6BpBaD0/uEY3+i0GGx6tMRM9FyN8ghC9TFoY88yDaE/Z7XaJMyU/AZHh4p4?=
 =?us-ascii?Q?tiTva456dAGblm+kJgXGT19ySVotGaDPPhbWe/81?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1f6871-cc36-4175-69be-08db6be2ab3e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 07:49:08.5127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LdMsaAc9bABs1sbkq1qyYNTVP/F8E2psDsb4RqB2cXH2EZRe8QPpRmSWH3QVf01mAGKkNx6P6/8kmId5NZdAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8591
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

according to v4l2 stateful decoder document 4.5.1.3. State Machine,
the state should change from seek to initialization
if call VIDIOC_REQBUFS(OUTPUT, 0).

so reinit the vpu decoder if reqbufs output 0

Fixes: 6de8d628df6e ("media: amphion: add v4l2 m2m vpu decoder stateful driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c     | 2 --
 drivers/media/platform/amphion/vpu_v4l2.c | 7 ++++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 6515f3cdb7a7..56c4deea4494 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -1453,9 +1453,7 @@ static void vdec_release(struct vpu_inst *inst)
 {
 	if (inst->id != VPU_INST_NULL_ID)
 		vpu_trace(inst->dev, "[%d]\n", inst->id);
-	vpu_inst_lock(inst);
 	vdec_stop(inst, true);
-	vpu_inst_unlock(inst);
 }
 
 static void vdec_cleanup(struct vpu_inst *inst)
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 810e93d2c954..8c9028df3bf4 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -489,6 +489,11 @@ static int vpu_vb2_queue_setup(struct vb2_queue *vq,
 	for (i = 0; i < cur_fmt->mem_planes; i++)
 		psize[i] = vpu_get_fmt_plane_size(cur_fmt, i);
 
+	if (V4L2_TYPE_IS_OUTPUT(vq->type) && inst->state == VPU_CODEC_STATE_SEEK) {
+		vpu_trace(inst->dev, "reinit when VIDIOC_REQBUFS(OUTPUT, 0)\n");
+		call_void_vop(inst, release);
+	}
+
 	return 0;
 }
 
@@ -773,9 +778,9 @@ int vpu_v4l2_close(struct file *file)
 		v4l2_m2m_ctx_release(inst->fh.m2m_ctx);
 		inst->fh.m2m_ctx = NULL;
 	}
+	call_void_vop(inst, release);
 	vpu_inst_unlock(inst);
 
-	call_void_vop(inst, release);
 	vpu_inst_unregister(inst);
 	vpu_inst_put(inst);
 
-- 
2.38.1

