Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8695661456F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 09:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiKAIGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 04:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAIGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 04:06:09 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80042.outbound.protection.outlook.com [40.107.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991F31836D;
        Tue,  1 Nov 2022 01:06:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=St/SXLbl3+R38KLT98trfX8Bp09RKu+j/JakTF8VTL722h2bHZGg1CRdCSDErBpQGMB3oM/kKU6iqR9PqFBxLxsqoHBxhOGZr3AHWsR34t4mP6p5h7AIMg2Anv9CxqeFRTpGGYLQu4ONVVi9OYZdpHJ2NEHUkwXKEEzCHxLkMnPSsTSfn4lMzk+EQIEj0IkQKTmVX47Yz3j42qpTbCFxzYZzCox68cPLe1pb7hTRniZ3xXcYRNeqN+lZ3q7+3IfFUVLxSFRDSdd+tmZi4GCTNaX5zGpAGfamSNplmd3T3B4FDXJxHhjuPt/koFbXWsYUV7j3Lb5qNLOw+4y/Zst/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm2Ge+k64ec+HQsSPlZIYhvBd+Ji/aU8WeSMcOgpWFg=;
 b=A1RvblYaZ5XWGEHT2HTZh+g5YRXZz/NefFASBGggwwG4K7NFaBnvTOe1+i7+25ce5I1ZRPlQ9qgxUXeATpXU6OkQ1mK9YyUrBp+jJYMchVzOu0dkPMHSbc7wprPhCzylBd9SmgLSkFD201UD+eP5D4nsfcqNWTXSmIFgUNMAnXMblsqdXieGNumlak2x/aVddjX+8vVoB7G2+HOBKAzOSB9X+ZUTNWdEIQIOk+5QSmjWbzZ4MAKJkPQXGYHMQZvbTjD6IoGKvpHTDIUlQ1tMo0f4DeC4aSDV3jtcDqkDfCJBDS5m/4iM7scRH+yjSGxA9+P2n1WCXCFGSz6Ui7GX4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm2Ge+k64ec+HQsSPlZIYhvBd+Ji/aU8WeSMcOgpWFg=;
 b=KktXkYu3IA7Fv6EUpJZF/s8O5Hy9npbD3aS9Go5VKuDgyJahhpF0B/V/r3B6nm7N0KAqb0FGs6tNU/U06HjJjlp9PnjMCembwSrRCwvKjGVEmWnK1R1Oa4/GqiKn8yqdEPbdxPeRcbz/RmPBFMKE2iT0SJeZqFHFUFUCC/Bwf+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8729.eurprd04.prod.outlook.com (2603:10a6:20b:43c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Tue, 1 Nov
 2022 08:06:06 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::976e:7d79:975e:8d23]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::976e:7d79:975e:8d23%3]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 08:06:06 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: check and cancel vpu before release
Date:   Tue,  1 Nov 2022 16:05:51 +0800
Message-Id: <afd6674a68c02d25cdd57a70db8135217c70a358.1667289237.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: 0492b578-46f0-473d-0f9b-08dabbdfed2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: onLrMSDx2ejuNZghy7HNq5yTtkSsPIYSko5O12PkFWMDChgAiw02Uh7J5Ks3MqNzKuVYIJGyOQuOwRunqqNNff5Oa7KQ7bInqDQu2bAUUHpgWAosatoZcbMCwook96o0sJA8E0VamufkonLfgmjWkCWGTjqjc+W+BLJYnOCvG0IzmX23bfpIDQb0NVo7gD3S7qdH1c69GW/WzlfTAeI3jxhrnnL/W64w8PZ0xSZ4lMK1tCTtiwfmbqEGwd9kIIvW5Wqtkl/OaCRt1B6k+/Gcl+NHE3AzXKrS7YG8Matz5+Fxc4JcWAyHz8oM9H71kzKD+kT7CvbgPcV2F7IR6Xci4xfFlACYR50GgkSiw7V33SXlfzBe9olh9rYms1iOrR+YQIJLE5S6LVERIGx1dyYWIZhB7m0gU9vFkiJLt/aEG0WYFgw0oXDjnz9/BZrWblO2z5yIJN1ccRd7TDBZQRYBj5p+UpdEiUa0Gg93PjyCIwnnNGlGp4c26AQ0IP0ar1UVry60QAUrm5XEk1+R+IKv3u0JogOLLgiavK2PZ9UUeXVJcLq/9mhZczs4W4DDnL58XqAeZwKsKloUCsRaDaCBueYngLwCU5CK+hT2F35+Klwpou2p3i6Dsl738nBMumXqvRBNuq91tX2xYqN5pwLFzGUVw8U5sWbAOaLh8PyxherG0EfeQVIY0RrYfJxdSRUOBfZENqt1ODzPzJCxt/3KlrAtsu06T212lvW2+sR25xlVXd/z5ShoVJiDrm95fMm9eSiv3MWZ1c3uklYu6cJTEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199015)(36756003)(86362001)(44832011)(2906002)(83380400001)(6486002)(5660300002)(66476007)(7416002)(41300700001)(66556008)(4326008)(8936002)(8676002)(38350700002)(316002)(2616005)(6666004)(478600001)(6506007)(52116002)(66946007)(38100700002)(26005)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DFWzkOIdVryqUhOxDaIaFvcpIh8wYQdqFIfx2vCFJQz5BJlafGC7MZBDA8Wb?=
 =?us-ascii?Q?enyY90+x1HqfS7Hp4pDKhwzgIGPDZ5FHWLP+G0HjNN5OXVoHkyt1biDMDqz+?=
 =?us-ascii?Q?jAqqH8orII3Hj4hUpK5y/q93l5GaA6VLOzkLB63rfcLMJXYrnzKobX448jBA?=
 =?us-ascii?Q?+3d/V6ob8+6GZLAIizDai70UT1bDKKt8wZUMb4Q3hNBEOtwZwmO2ZFhiAug9?=
 =?us-ascii?Q?hXtQJkeiQjCcJIlJevl7I6exscDfzbxseeVM5zfff+nS53f7gqHVaBfbZJOM?=
 =?us-ascii?Q?1yrvoNrAxPxK+j02XEEXSk9UkJ19sClsgH+yI87MUIHZAlMSPrSrhhhBHpct?=
 =?us-ascii?Q?1jWORn87Vp6NCEAOeiuov6Q9hI++yTBrDOUw88n0VT0w3b2UbEYfaTx15Lxt?=
 =?us-ascii?Q?Auq/r/ufDyCDMQ1mJ3uxV/0pgELxtgp+rTDLgG5izOiY5UUGXt4nv1HnxCax?=
 =?us-ascii?Q?Z0JBy736oGrqukQn95Rhr8EiqOYFIsVhGu/wvlEXVVt2/ROrWSKP04rfmzJ8?=
 =?us-ascii?Q?254F3jNbiQbSPtfpJD23iA7laVbRWNLJFNRGcF1pNg2lVDpv2FT5npLPEo3d?=
 =?us-ascii?Q?cYsToDIvJF6qGnnLxLIhkq5KYVTMkTUERRr/BoPZ3aCqqlktx3Hx+Kdk5+xz?=
 =?us-ascii?Q?iSe2eUHO5vDQW4sDheM8KG3jtgNu10ruVzguZZHQHZTZFP91sNUdqblnp3He?=
 =?us-ascii?Q?oiO03rHeXTxKKIhebx3FFaUZRXChEy2CmHkLrVn1d0bKVrjX9Aer+cbsrpcP?=
 =?us-ascii?Q?IWjJcTpG5hef/4CPdYQXFlRJQFzfMah3o8U2qBHtjM6wim1NYc/OGNAdmWdr?=
 =?us-ascii?Q?Yc1uSJkdaD+Sf3snj+qftGf4OHixklwhKn/hyxwFxdYuoApPaMj8JXT8kVIB?=
 =?us-ascii?Q?/VBtWluLsEC/fN7n1IcRNK0Jlx5JHCwoQMA3eK+WeqXiCZ2dobq2drPpwCDo?=
 =?us-ascii?Q?WT/eNv9Dr0AcZmBLlu1ZstBR5iuao5nhLbKp83CTuPEetcnHfthx1VI/KTGT?=
 =?us-ascii?Q?HPdzpbBeNRpm1h2iJMVDX5sYU/vGZySWgoQXXTv7at+CAzFt2z18SJ77JISY?=
 =?us-ascii?Q?LvXmXZmK5Klitq2ZCtDfCLTqNiMDrrDzpgR+SkcfsYik5oHnN2dnJYXnPUHn?=
 =?us-ascii?Q?pzgmXmLMphGx1I9yTSz4KsaCQt0MA5zVOP1JyB+bU+zLmvLiYVQ8kkvXsSzF?=
 =?us-ascii?Q?r9PGfO2X6Qyt8EtRMo5tet9ZlM5JmRXEojJRzNTdSKBI/Ho8biGloLhlL8zq?=
 =?us-ascii?Q?07z2QWK62fN2lrrHIcrVxK4t04BQTgBJSiWI9kiqOjnt9sKeylF+H+bZPurG?=
 =?us-ascii?Q?gm/G65Nxtr9mhNzCqXUnY4w8KoD5nEj0pGdpN1LC8BeQF0b0PXbHZbGg7slK?=
 =?us-ascii?Q?qxqK+G3MVqZAYzuNT/rAC416ZkxXB7np02u8hWMIXroVwyjr+6XONTsfx5sE?=
 =?us-ascii?Q?hBfR8+mR24XLxRFvyv3lqBImQxeERtvnQ9xXyFnyz3lggbzqV4OISOf28RxC?=
 =?us-ascii?Q?TtcN0/ErDQxdkZY5xxhRYJT8FWJ1C61cbfIrb9cQ8rSVOlkBJBh570OfZK03?=
 =?us-ascii?Q?RUCrEPyHz3Z6GxBFYGlt21aSvlohJ9EN6BgF+5M2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0492b578-46f0-473d-0f9b-08dabbdfed2e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 08:06:05.9697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZHo9mALCKrMk2aaMxBMeGjgR0TA0xAnlZMyLM7bXNBTvHVxfU64wQEj8YX4AJl0k8izqp7IvFkghIPz8yNWSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8729
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

driver need to cancel vpu before releasing the vpu instance,
but it doesn't want to release the m2m_ctx before
the release callback of instance is called,
as driver may access the m2m_ctx in handling some event
which may be received in releasing instance.

check and cancel the unstopped instance before release.

Fixes: d91d7bc85062 ("media: amphion: release m2m ctx when releasing vpu instance")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_v4l2.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 99ad2f1c5a53..845fc53d8937 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -767,6 +767,23 @@ int vpu_v4l2_open(struct file *file, struct vpu_inst *inst)
 	return ret;
 }
 
+static void vpu_v4l2_check_and_cancel(struct file *file, struct vpu_inst *inst)
+{
+	struct vb2_queue *vq;
+
+	vpu_inst_lock(inst);
+
+	vq = v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
+	if (vb2_is_streaming(vq))
+		v4l2_m2m_streamoff(file, inst->fh.m2m_ctx, vq->type);
+
+	vq = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
+	if (vb2_is_streaming(vq))
+		v4l2_m2m_streamoff(file, inst->fh.m2m_ctx, vq->type);
+
+	vpu_inst_unlock(inst);
+}
+
 int vpu_v4l2_close(struct file *file)
 {
 	struct vpu_dev *vpu = video_drvdata(file);
@@ -774,6 +791,7 @@ int vpu_v4l2_close(struct file *file)
 
 	vpu_trace(vpu->dev, "tgid = %d, pid = %d, inst = %p\n", inst->tgid, inst->pid, inst);
 
+	vpu_v4l2_check_and_cancel(file, inst);
 	call_void_vop(inst, release);
 	vpu_inst_unregister(inst);
 	vpu_inst_put(inst);
-- 
2.38.1

