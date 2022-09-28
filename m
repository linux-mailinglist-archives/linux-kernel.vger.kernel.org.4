Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1596C5ED557
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiI1GtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbiI1GsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:48:03 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140078.outbound.protection.outlook.com [40.107.14.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85188F2;
        Tue, 27 Sep 2022 23:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBBuOsZ9Jbvn8lZXezGH29RJdK220zTMw9qlFDpLGeufZblpsGTv/R8QLY+IZHc29Kw20k1oYHaTZAH9OzfuSDmqMrejjEJ5EDat8i20Cxe2qeIk5egAm5g/9eqXeWhEu9JKiVftDLV3hS/wyaNSvxVfgCAiq3xXOCBvHq0U/PDQu0exRVkwaRm8og9rwfgjjLcsEqlnd22qG3//UhgcF4/I4qvSD9wBtrPeA+8DDsaJ61diLrBnlnpqsZFpMO4sQ4ubCy4VTrLBgo9+/TIs2HG+Ubyev/Bzq2S+GWxa2REzQ+Lhu/o/fO+r6UYP7Nh9N4DsNbOiQrkVKFgEuY9+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TODl8pmpwznszaO7ezcx6SqE0AUCH4Lc3NDy8t1Xu1o=;
 b=iwdID0t71ujFc6i6bl6NUHMksiykfrrjeLj2bIE6UqVRc61a9YqXNmWtdoINviOFvrVPfSNF17gzmmAp70rCXxH4KFq7+vcnPjFxICeK+Or7PiPBsFOw9JFJB8rOPnRymMKWVjczzkg9HhCFvzzyr8+nScg7is45Uv+9rBLr3CNgGQ6FPiuF+r+0+x4xGpOBUxYiVCj8o1z3FI4pzY13dE9z85p+/igJ5nHb4Rptbr8UYS+/Mpb0Fb14WbnDAr33gPdhRm8TCokwtzRceZl2b3ArFlY2hYNXGmIvLxzrE704aE2QjdMukdf1hBAb50ucxj00yc+VgW/rUH7gbbPzUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TODl8pmpwznszaO7ezcx6SqE0AUCH4Lc3NDy8t1Xu1o=;
 b=bahMjdhScJHlCvT/+/VukVslZIzbQculwIa3ONyYmsEJAHxreaaWspEJoOaAF2bLNjos04dOzU7EfY4bXVkFk/NeOsLyZMqyh9I9jvJ9B2zCawTsnH7YxLZps8gmcB0dW+VRPC/I/uxukrO/eN2o3wJVTzCyGcErBEhyne9mSJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8451.eurprd04.prod.outlook.com (2603:10a6:20b:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 06:46:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 06:46:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V8 1/2] remoteproc: introduce rproc features
Date:   Wed, 28 Sep 2022 14:47:55 +0800
Message-Id: <20220928064756.4059662-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220928064756.4059662-1-peng.fan@oss.nxp.com>
References: <20220928064756.4059662-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 777ba5ee-1296-4e1e-f818-08daa11d29c2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bfts+rv1fk+/OScMmcd6iV4gVdukn/d7EFzfIHcbTFgXkfZ64J2NOh6p8vo/G9PM//6kjV2X/AcuAtcWTPh7b4duxLKs4/262ApeEFYNrqrqn7/UhqQ5khQAyxN7xBygkIls3FBXZ+95Xm+/PQ2Jo+8Kt2sa/jrLj5s25yYf1qLqNS4TvaxTOamJJt1V8kDWYVbhvCHVyJyC6D2tNLtlo8X5JLywBwfBqLyNOI/lqwwosj3FweSfWgR6cv9L6YEsboXileX8XqhMZakutO/053LxyyilrDchcHSlva7osRX/kZ1tKJ+J7MGz4OguqarxP9wbLYImpOfQk/ixSqz6gLa7TmWFXi0cmqLhVWI03+OQMSqR7JPttfLmvLTk70ROA+X/m1rg8MkldPw6lWWYhvXIIN72m/ut+KZuZ9uv1OKWlo0f2yTLCox5zKV7YQ7DU4ZqNV1v5IwUT5n/1O/cp0xfkKJlQK/nNR9R0ZlP3qR2RCKJulggbK4bop/IYt0SLCkW92ocnYBJjL7ESStMGYK3Pl0nkNX3tpqhGxx8l/Rt0bOV7OXsDT/VLxBtAnmhE6F2YWdFRnXsCBxJjix1REdewOAy8lrY3f6+EEWYFGgXc6exQlgZOz8QtBdcQ7HrsXnXvMNboUI1d46/dneAldMoWivmvK+4ASKFu+KtSRry2X52dcuIb/Iiuv1Yy/I8UBBbJIOdfQJ4nnGNggZ2Goi9yuRrMxR2e+4TzYnP5cQHh4CDzJfZgSCNp2mG/dmRpFSiH83KLuH2Bjj/TcD7+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199015)(2906002)(5660300002)(4326008)(38350700002)(38100700002)(8936002)(66556008)(66476007)(41300700001)(66946007)(316002)(8676002)(6486002)(478600001)(2616005)(86362001)(6506007)(52116002)(186003)(1076003)(6512007)(26005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i3PV5lEFUhXAkybkOhWoKCWEkCPFf6/AtiSBAhuNPfS/onNsLQhNJXnGABmT?=
 =?us-ascii?Q?lTv8E+KmIi8MyTNnJS/Cw/ITD2rVap0GHq0bR4kQr+hWimP4fY5GvLBSw7rG?=
 =?us-ascii?Q?rWUdUY9vGdAgB3i6eOR36rcrRQi3AvvwSS5qMu3IWHs8gkt/2kW+1Ns77Aq/?=
 =?us-ascii?Q?Ve+KW+wOvZ4+OQpwbtg9m6eqHyixwXE+87gBD+7XQVIohdf3KAuDpZCicn8n?=
 =?us-ascii?Q?tDztmFm9aH0tlS1uKyTJJ7DT7gfa5KiJuD5+CaxvN43Gx79oKudnjGTeMeWe?=
 =?us-ascii?Q?M6CYm1Lk9y38LyLuUSpQE18UFHtiMZtN1U9zJtJOq7+zSciG76mMzZELVdCC?=
 =?us-ascii?Q?vV0FxRev7DqnNHjvc8BndPhu3L2YkFE4waUEnryoNzBjwwfd0XyO/NdIYZY0?=
 =?us-ascii?Q?fyAG7gTY8hRVFrpQZcy0LKJjwzlI4Cbd+06xfbaoNnM1c1Iet412W3c6G0zO?=
 =?us-ascii?Q?+183B0xg1NHrsrQmPzJL+zK0RbfZM50+ugnqTJhO10HYglaQkuQ1CEjYJETm?=
 =?us-ascii?Q?gl308fZnwkH7TmvkZpKLEGsnt+dFrk6J2b7JNG+wFfGQTTyP2SxiJXMhMlkB?=
 =?us-ascii?Q?tzrO2XEChcPobLFJyBIg9zwcZ3vI1qq5n6lJZ9+F5daIC7HJOhzdJLDdfrJ/?=
 =?us-ascii?Q?k/xAZS0Kat/8mcZJVnDkf1W5vUvY/mBIUEr8Xr6at3rbUqxZ1igsd6VXQlUQ?=
 =?us-ascii?Q?SWpf1R3QnQAFSinTRL4OT+ZPqrxD8NvM29QJUTYrZEnong4tQ+p0MpG47+LS?=
 =?us-ascii?Q?rzkaFli7E1FL9zz/d418Q+bzNR38k5ZprUU87g8mO/JbXiDLDmC4Z1r2oIQ0?=
 =?us-ascii?Q?hjX59/qndmaQiegUOEkmVjh2dETEkHGh6jo7RdjdkI0tNwpapbnJSZyMbFi3?=
 =?us-ascii?Q?aQx8x7MhMmfqjoVtGUsA9c2OCkMzZs6vwyCY2Xf0vEapEWBqNRNG5o8OLNNk?=
 =?us-ascii?Q?19s9JYcV9GiWvgau2IcTZVHV2HhWqX7khWgAT0+mE5Bw68WyVS56/C5repeN?=
 =?us-ascii?Q?mYHQbgtwHWYOQgCBPohU6R/5uXxgwny5Cr6o5gBLcPk/pYc+DKbMiKjZVQvp?=
 =?us-ascii?Q?7yb+cvgfbIL3KrpRX4+A904xJZ45UBI6rA1FVV2w0skjUJoZwz5jXa3YvUWo?=
 =?us-ascii?Q?ha59FIEkx8Mb+MJqQjwS0Y4BIophxJjsPXgS1jHFFFm1cz0TGdu83dnTyzFC?=
 =?us-ascii?Q?1bwWzsWUsZy1ewLyWTYWMH7TlhBZft4aSq7Vc1n+/VoD7CRaksb2XqkkgQXI?=
 =?us-ascii?Q?YtZa1pSKB3kO1Y6elxkbKxY+uqts9qoDZaL6TUYrLscY0aWt0ouRMqmBaBpe?=
 =?us-ascii?Q?RwipIRKoAnj1xJkUlIPXQp+4Bgxlmw9cFKoh1wY69I5Jh1TQc7a36N/2arxj?=
 =?us-ascii?Q?/vFCFWpDyT7uL1k1FvLqzg07CfsameFqsvp7/p4hwSabDCC+M4EIzndqGk3X?=
 =?us-ascii?Q?MSqUvIEQw7OeIMb9/i3vQD2R9JYI/o4DwBjZBxg7V1hW0TorAnauxunvPnar?=
 =?us-ascii?Q?w3JmqtywybP15Mh/Oig+k8mjRCAjTELu2+V8E/EKMphAJ/JKMHRzehsy90TB?=
 =?us-ascii?Q?1YWnYQEGB1vy9PIXExlGj115WHou0cSMRdQp4lAW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777ba5ee-1296-4e1e-f818-08daa11d29c2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 06:46:25.5925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hJrGcvdMURpE9SIu5HyTuSF+a2wzPZau87/AUVXnQLwEz+SoQ1+QeDZgwuy45FH6BTZuwrPakHNbtEza7tSag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8451
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

remote processor may support:
 - boot recovery with help from main processor
 - self recovery without help from main processor
 - iommu
 - etc

Introduce rproc features could simplify code to avoid adding more bool
flags

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_internal.h | 15 +++++++++++++++
 include/linux/remoteproc.h               | 16 ++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index bf1fb7bba1a3..d4dbb8d1d80c 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -39,6 +39,21 @@ struct rproc_vdev_data {
 	struct fw_rsc_vdev *rsc;
 };
 
+static inline bool rproc_has_feature(struct rproc *rproc, unsigned int feature)
+{
+	return test_bit(feature, rproc->features);
+}
+
+static inline int rproc_set_feature(struct rproc *rproc, unsigned int feature)
+{
+	if (feature >= RPROC_MAX_FEATURES)
+		return -EINVAL;
+
+	set_bit(feature, rproc->features);
+
+	return 0;
+}
+
 /* from remoteproc_core.c */
 void rproc_release(struct kref *kref);
 int rproc_of_parse_firmware(struct device *dev, int index,
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 1abf56ad02da..fe8978eb69f1 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -489,6 +489,20 @@ struct rproc_dump_segment {
 	loff_t offset;
 };
 
+/**
+ * enum rproc_features - features supported
+ *
+ * @RPROC_FEAT_ATTACH_ON_RECOVERY: The remote processor does not need help
+ *				   from Linux to recover, such as firmware
+ *				   loading. Linux just needs to attach after
+ *				   recovery.
+ */
+
+enum rproc_features {
+	RPROC_FEAT_ATTACH_ON_RECOVERY,
+	RPROC_MAX_FEATURES,
+};
+
 /**
  * struct rproc - represents a physical remote processor device
  * @node: list node of this rproc object
@@ -530,6 +544,7 @@ struct rproc_dump_segment {
  * @elf_machine: firmware ELF machine
  * @cdev: character device of the rproc
  * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown on @char_dev release
+ * @features: indicate remoteproc features
  */
 struct rproc {
 	struct list_head node;
@@ -570,6 +585,7 @@ struct rproc {
 	u16 elf_machine;
 	struct cdev cdev;
 	bool cdev_put_on_release;
+	DECLARE_BITMAP(features, RPROC_MAX_FEATURES);
 };
 
 /**
-- 
2.37.1

