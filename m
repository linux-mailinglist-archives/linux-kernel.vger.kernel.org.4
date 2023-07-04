Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D356F746834
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 06:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjGDEBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 00:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGDEBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 00:01:30 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B265BD;
        Mon,  3 Jul 2023 21:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QK5n2JMWmwbPPkycgWiINovtsGIPg+tMsWOZ8jAth/chmjFFbofhhZedGpcMPnOk7K6hSR2RIYmz6LpBItZgprAgCVKkjA0hp/kMlsBPR3dMbD1hVL1mrfhfJlo+9QEnfkRKVCNCtsj+9b4jMRZuzuaZBKe6MC8D0j5Fk3BwCYvhYxPedbh0qzUcfLUtQsqp9b0lHjzigktMhD5HPcHyn8CcNRsBVoENkr0p+tRBLoAsz3R7m67MUAhav22uCrPPaChjP1D1c6u6J3hPibnkRN0jKrx6I+DMwsD4D9JCxCD78BDRRehYl2Ls+bzqhgfOdY2CF+eW6GzypbMkCaVZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ5quQBoOmUGeDe5qMsjGd2YRmqwU8bGbvl+E2PaBBs=;
 b=c0mgukgQy5HPFjkOBsvj6tlrt7mAFWmQRLdvaiZNmoAl4w92NOBo2IcIfJthNQibYE7+3wwMLok+gOmiHtVr0oRAQHmNw6tChOVjT/vDUAtP5zMsl6gGHk9Q9gs4/tAtRV7azmPRSfD5OIsRkysms4rqicqxejY6Z/zOTcrePmvCxkmnKaFBBOORl14+sgiqjsrZqsF06WdCbCJpuLjJrAVcDbFuDRoFC0SU8gSFISG9B1ZLDiSnF+uG+dl6uftLpDFg6V6RJ0Tdcy41fRG6RzJsQ7mu38duNwfGJQVwT8EBZSlx+xZ6MMZFbmT0Is1LEYZ7zVxWfTHpc87KXfdmVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ5quQBoOmUGeDe5qMsjGd2YRmqwU8bGbvl+E2PaBBs=;
 b=jV9YgQDEOmxKa4C5EQu/dslVgb1vqHh97J0BZCiLD0J6+GnRVLTp+/jpv+5u4hqiDyg2VtaiYHVYZ3/Ysx94aLyfJHwWTbkcZ6BXJUt3rg5leo1Oc87zIxQNGJnbZt9d2H0WSUBXcxYTA8VjCYepidDPW6ejiMgCsyJ9P7q73AY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by CH3PR03MB7385.namprd03.prod.outlook.com (2603:10b6:610:19a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 04:01:27 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 04:01:27 +0000
From:   Hsia-Jun Li <randy.li@synaptics.com>
To:     linux-media@vger.kernel.org
Cc:     ayaka@soulik.info, hans.verkuil@cisco.com, tfiga@chromium.org,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        hiroh@chromium.org, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org, nicolas@ndufresne.ca,
        "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
Subject: [PATCH 2/2] media: v4l2-mem2mem: add a list for buf used by hw
Date:   Tue,  4 Jul 2023 12:00:38 +0800
Message-ID: <20230704040044.681850-3-randy.li@synaptics.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704040044.681850-1-randy.li@synaptics.com>
References: <20230704040044.681850-1-randy.li@synaptics.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0041.prod.exchangelabs.com (2603:10b6:a03:94::18)
 To DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|CH3PR03MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0e4f16-8fed-4e12-e637-08db7c435760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbOfHuK0SujUIIMwVrG8YvVen+NkJvAzeNvitveqZGd7UyFoHNjF7dMWRCnGjPmTtat+hZlbU1+8uXnmpItINtI+nEyER+JjlxjvUd4YuA1KvvViFzuwdaaYltCYHPuER5v6ZqB/KIH0897RU3EHVl+20TqJmF3kRix9UdOum33F+wVNIiTjFyZD7/8ghMKvI7U6xF1Yh9ZO9azhhCoFuydhHf++1ekevgGhdppb/8VGTkBzFPoidHzBvD1/sYzmXVmU6Zzv2vTH+vCRpvEIkmllcHU35JcizPkEjum6eAwQJqi8Jq2eA90Eutx31urqFYq86Y+2htApHdkcWHof1ua9q7b9zfT6kmfZLnegxKrP7TEnVZrcAp2yPK8CI1aMOoWR+gskrxuJzjsf9pGJT0nM3HdbWWP/B/ZBu734o5M7EhMiPp8Gpi0jSCq5cmI4zcf1el7ub0JQLEfuxuxKQ4Td7RhfNmy8Ndiz3ejyMGPX+DKijHFZyJpTbmPMG6uSjpmLZ8TZyoTTZ8zZeM8wuNpPLAIfNWbVa39vtJD8bhV0mebALOzVQie+E7Ceo0sowYJ0F+ZdxTZIIKztsEUitEXYtI+Y9hJEpFNlO0VEb0w47anP1D+NGInaqjUQfVmh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199021)(41300700001)(38100700002)(6666004)(38350700002)(52116002)(2616005)(107886003)(83380400001)(6506007)(26005)(186003)(1076003)(6512007)(86362001)(6486002)(478600001)(316002)(2906002)(36756003)(66476007)(4326008)(66556008)(66946007)(8936002)(8676002)(6916009)(7416002)(5660300002)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MmeS6IVp4CBKoqmkE+X3YUhqTmU6sTOiA1AMsyz+QZB5vG9eNu80Klpv9yJ8?=
 =?us-ascii?Q?IqTaKKg7b3e9di6lBHKEj4wijrQ/eSQeBfgzf8C9VMO6UCn8509dKtwXfWDO?=
 =?us-ascii?Q?buf9jCmJCN2hqkc38pSp7jym0Qp8Cz74tiwjK3UFXKQRuwmd6ZxIUiGQ7FyM?=
 =?us-ascii?Q?YKqHBTyGMVgQWHHiRauMm9kk6vj8BXdU3oUM5sSlv7Zg+BQZ2VySxn9UEfvg?=
 =?us-ascii?Q?dAMg2Qm4iNNJ+HrrLMJhg/2EDnXI6MByzCJwM+ezy1P9RfUlIQjzqR2/QtPA?=
 =?us-ascii?Q?bPD4MQC1HwmzQb6wm1/Xokn5c+E9/HpmqBcHsCuUAGMLlyzLoxnmy356SWIi?=
 =?us-ascii?Q?O43PNUe5sOayWEgjhoGJ0A4JBy27P2umcARYX+ivJ2/n9tVdqPBcnGFgzYGa?=
 =?us-ascii?Q?atgBqlabzde5aKGdnwZmQxM9TGHTqJgX+FQlTIB5Hw0iCdIZEhDPWBKn0nQY?=
 =?us-ascii?Q?dhhDR6M48bDK9cDNRuhUgeibK/TPRCNkERRNnayrMwYhtexWvTg7xGh0FHWE?=
 =?us-ascii?Q?kR/raXKRWey7TGtB8kdsCcA2O8n1PMMrjiOqnYHaNtkTKWXVIm/4a95lb6wL?=
 =?us-ascii?Q?HXPZP1/eXWqmN/zHhGyIQ4ZKF3R3E2dAcO+Z6/J1G9hkMq5bk3UV3Lae9jCq?=
 =?us-ascii?Q?9QwMPVam0tukojtelMeqKKKK9nBJuoyUB9LrAgReKAsjuOhJdGkPF/xu0Vzg?=
 =?us-ascii?Q?2Jac69DbbkJpXvgn/iVcHjay3u0udRH+pcgluEnknxXA+vX8DZcqWXxsBV9x?=
 =?us-ascii?Q?VyHB+vTWU53eheXT9iSpf520V4SyFN2/8WFH4S66DOK7ece7MUKXY0sBhdaH?=
 =?us-ascii?Q?OdqsDaHtvrDUMmsvqHFe1KzmhkP7Lsa0DkWcr+UXJT+7HGZ2jAiraagPLFUT?=
 =?us-ascii?Q?/cv+WxbTS7UG845fsDQSmUirbALfGxjPdDkNOxVO08Sd+ORNsC9/0+0gqYya?=
 =?us-ascii?Q?qoR3PpqVn8v1r4RFbcffYZEF48r6ToTHCxZLK5AkmCwfuRhdyxBDouSzUsuE?=
 =?us-ascii?Q?CFwKpLYdMqL3xdK27MLbnANFbcGwPfnMkj3ODpy53lmOHFrcIIKzGcX5BIo5?=
 =?us-ascii?Q?9XJhYY8O67AEZJjkP6KfXTyFwYxizYoVuJFOfC63S5YzcAv8pPJ7smNUMsFH?=
 =?us-ascii?Q?RQgkGno45upFnctTH75CVhnJN8lywmUllpWNTlYLKDuz/ueU8TL3Gj4pwnrG?=
 =?us-ascii?Q?6vsSc9V42VDrf6o21ZggFVGx85eSL4FAFGJ0SbRcOFxP+b2cg99gihDhbWmz?=
 =?us-ascii?Q?hkE8aEMQe9OG2nNRhp9ErT9Ch9MuYNV/C4Hl4LY2K3JuL25K3SCLBzVkPVyZ?=
 =?us-ascii?Q?9TgOhrmCAkGHjWm0dHndsKNjWKQU+mRgFlJpkMr7mPKKyHi6WpbyTMAfMM8N?=
 =?us-ascii?Q?PjppzjMs2mZmCCWPjKcJi5eSpcKKMmCFX7GuNK70GDduYFjhqPf2ivrkf5UZ?=
 =?us-ascii?Q?GGErwHecfV+k08Jtv5vh/zYAgwEfGitWRD0PvfG+60vlo/3C1NDhoiLsmtlq?=
 =?us-ascii?Q?mx1mClmN8o1iDUp9L7StdlzEINvX2vuoh1a/1PvDm1YfHsDoM/4WL5TWbl6h?=
 =?us-ascii?Q?2uvy7Q19QCVpTym0s7coIqaqvyhBlM5bpkCSYypZ?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0e4f16-8fed-4e12-e637-08db7c435760
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 04:01:27.6491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wt0sz6+IVAzTPmXPC/ldagP26DYPTBd+AKO2IIWPMhF/rEphzwGqjxTm2CKGIV7wpoVzQYLEXbEIS4SP+JZuSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7385
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>

Many drivers have to create its own buf_struct for a
vb2_queue to track such a state. Also driver has to
iterate over rdy_queue every times to find out a buffer
which is not sent to hardware(or firmware), this new
list just offers the driver a place to store the buffer
that hardware(firmware) has acknowledged.

One important advance about this list, it doesn't like
rdy_queue which both bottom half of the user calling
could operate it, while the v4l2 worker would as well.
The v4l2 core could only operate this queue when its
v4l2_context is not running, the driver would only
access this new hw_queue in its own worker.

Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 25 +++++++++++++++++--------
 include/media/v4l2-mem2mem.h           | 10 +++++++++-
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index c771aba42015..b4151147d5bd 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -321,15 +321,21 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
 		goto job_unlock;
 	}
 
-	src = v4l2_m2m_next_src_buf(m2m_ctx);
-	dst = v4l2_m2m_next_dst_buf(m2m_ctx);
-	if (!src && !m2m_ctx->out_q_ctx.buffered) {
-		dprintk("No input buffers available\n");
-		goto job_unlock;
+	if (list_empty(&m2m_ctx->out_q_ctx.hw_queue)) {
+		src = v4l2_m2m_next_src_buf(m2m_ctx);
+
+		if (!src && !m2m_ctx->out_q_ctx.buffered) {
+			dprintk("No input buffers available\n");
+			goto job_unlock;
+		}
 	}
-	if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
-		dprintk("No output buffers available\n");
-		goto job_unlock;
+
+	if (list_empty(&m2m_ctx->cap_q_ctx.hw_queue)) {
+		dst = v4l2_m2m_next_dst_buf(m2m_ctx);
+		if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
+			dprintk("No output buffers available\n");
+			goto job_unlock;
+		}
 	}
 
 	m2m_ctx->new_frame = true;
@@ -896,6 +902,7 @@ int v4l2_m2m_streamoff(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 	INIT_LIST_HEAD(&q_ctx->rdy_queue);
 	q_ctx->num_rdy = 0;
 	spin_unlock_irqrestore(&q_ctx->rdy_spinlock, flags);
+	INIT_LIST_HEAD(&q_ctx->hw_queue);
 
 	if (m2m_dev->curr_ctx == m2m_ctx) {
 		m2m_dev->curr_ctx = NULL;
@@ -1234,6 +1241,8 @@ struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v4l2_m2m_dev *m2m_dev,
 
 	INIT_LIST_HEAD(&out_q_ctx->rdy_queue);
 	INIT_LIST_HEAD(&cap_q_ctx->rdy_queue);
+	INIT_LIST_HEAD(&out_q_ctx->hw_queue);
+	INIT_LIST_HEAD(&cap_q_ctx->hw_queue);
 	spin_lock_init(&out_q_ctx->rdy_spinlock);
 	spin_lock_init(&cap_q_ctx->rdy_spinlock);
 
diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
index d6c8eb2b5201..2342656e582d 100644
--- a/include/media/v4l2-mem2mem.h
+++ b/include/media/v4l2-mem2mem.h
@@ -53,9 +53,16 @@ struct v4l2_m2m_dev;
  *	processed
  *
  * @q:		pointer to struct &vb2_queue
- * @rdy_queue:	List of V4L2 mem-to-mem queues
+ * @rdy_queue:	List of V4L2 mem-to-mem queues. If v4l2_m2m_buf_queue() is
+ *		called in struct vb2_ops->buf_queue(), the buffer enqueued
+ *		by user would be added to this list.
  * @rdy_spinlock: spin lock to protect the struct usage
  * @num_rdy:	number of buffers ready to be processed
+ * @hw_queue:	A list for tracking the buffer is occupied by the hardware
+ * 		(or device's firmware). A buffer could only be in either
+ * 		this list or @rdy_queue.
+ * 		Driver may choose not to use this list while uses its own
+ * 		private data to do this work.
  * @buffered:	is the queue buffered?
  *
  * Queue for buffers ready to be processed as soon as this
@@ -68,6 +75,7 @@ struct v4l2_m2m_queue_ctx {
 	struct list_head	rdy_queue;
 	spinlock_t		rdy_spinlock;
 	u8			num_rdy;
+	struct list_head	hw_queue;
 	bool			buffered;
 };
 
-- 
2.17.1

