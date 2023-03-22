Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDBD6C4474
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjCVHys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCVHyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:54:45 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4525BC9D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq8OVOuVOhjl+TTzvJGvz7qvbS3QE4e5WRlZ9yvoFnZdYBH+62JiCtbmy8zuM2IeDw86EA9x+rmjWvXlo6AlRDqET/CLMHVZAGLKU8nZyUAvjKbhfE2nb8A1t6dmnBPCJFNRh/7pVVI+k+IHo4ELx6mGbauXgEmbGp5zQoNhuX8XS4aP0rTzcx8p0cwuVcUz/fvRQ1QhoCovVR8EvNXk9PBBTnYtIkYK/M9o3lXP2hHzM8eyTSVHb8Q2XceTHdQFMZEePIztPDT1WRMJTCm7bvYKlT+IlXKdvxB1qVb/inDbDuNKJQVUlWRoOqde5/4EjPSdz6OyXZmiF5VTCdo4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F52oO60OJpupNrKM4yEvkwlc9JHH1AadywSqV6+do4=;
 b=lzX3D7KM6sOpvHQ/NIok68R62NWWlNMevJHizuW715VFzTXog4yTXXzvTBuOmGJSxhveIVgQ6khPEKtlWIzTGmGovVoYO7M/jhRfFFg07CkVEOj9oh33hXtUgVMq8e3504XumSHP44u4eY9Phl5JQG4hSl1OoCShH2BCPo43UYXxJSqKsymTXvxkyqErULQHz2np7ziKoHEm2XYaO7dAhamw1jaT7d9yXzledO4HMaQzxALPVsOwa1tK4vlmTEVwUinixj+2yJrNRBbLvmjw1R9h1EClQUVnK7hgOqOtkHnCnfgaiOfXO0JMGb+NJMCYQ/6oK0FMtEFIXeRHQldVvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F52oO60OJpupNrKM4yEvkwlc9JHH1AadywSqV6+do4=;
 b=Q3v2bn5e8yL655G3mS8WE0jNneTRL3iVni9U3kvlQT4vqwUG09PQJ4ejQdUgtAIwJ16Ut8PdRAX2QMJ/RsI7l5PWKkI/YesDEvVK7aQu1Uy2iCNnhMS7NRrZjUO2GgwNTQgumySzgkhrzZRhbHbZjvoZNky1BNuD9IX65siWmyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by PAXPR04MB8525.eurprd04.prod.outlook.com (2603:10a6:102:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 07:54:41 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 07:54:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     mst@redhat.com, jasowang@redhat.com, mie@igel.co.jp,
        virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] tools/virtio: fix build break for aarch64
Date:   Wed, 22 Mar 2023 15:59:45 +0800
Message-Id: <20230322075945.3039857-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|PAXPR04MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 99568957-63b5-4006-6706-08db2aaab009
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: otxP17bhcZt+BfAgEc1MdoMc6tS4Y3yf8VH+H1fgu46PsDMfCszxItzDkZUYQaOz5QPmldcOgaEl/aqI5scpCaUeR8U+mLXMLkV1V7wL58brl3xFz7eoM8X1pJV4taUmB+Mo9TFpNaR/pXMVKxpdf6Iy0O1yyBUVDfcsgIkDYKAMZpI0zLfgM6kbFycAXy2452rwlEngEcoi0FDcAp2YWdeYvAUjXEBvZSyEjfRCGp2uk9XvoNcs0HMMu+uHUiTol3/knIWw1nzIcY7FrzgeipMmr1FvK3fKQwuh4O2A8Np1kWxsH41UsdbmGsBojnfT0rqxlvKb3VJbp9iGr2AvVSgy4u0oQXe2FtUJoQ0uj3K2rOj7ogzq0UzMOP3io+h37usIqitCZkI6llPWuah1AA89AzDO1kb5KGTuRbD6Hy6qLbBM0QpQJUgeV0NoTn1JKATmUU8zLux2l9RA+NsifrT7RhmEKPNyK0hOAP/OnN3NYtnM0PdctmAbTlopyvmYE3fYLYjgBNSIUoGCvdsJwweHWdxZyf8v+SJ/Tos4dleAtD9Izgl/J+5j8WbFfQdNKAuOmlTs8ABtldYi7mXaDcC6TWIVQdrXNhmlZg0BqiKsvTK7n8+e67ITLkn/9bD8tGKz/g4iorTOMWgxoKPVhLuibl2olbP2PMPXpakRUxX/yGzPf3lCCB/gJvdJZ8pvQNVap4gw5RHrwKqdNOnBaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199018)(2616005)(186003)(1076003)(6512007)(26005)(6486002)(4326008)(6506007)(8676002)(52116002)(66946007)(83380400001)(316002)(478600001)(66476007)(66556008)(5660300002)(41300700001)(8936002)(2906002)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RWz//H2exwWgjZ2UtW4TePbYmPUwVSdLiT+dugdBGf9yC8X+0kA2yuh03uTE?=
 =?us-ascii?Q?2rKELEI1fvMF0uuXIxYEJm0aCa3lbIMbLmYttFNTnLlD8TDcm1yHa8UZRwOm?=
 =?us-ascii?Q?iGqHVjrCRx0niKLExnHb1/RWrwMB8Baqb+qX1kHYqDMGv7tv0TmOw3hFTNnU?=
 =?us-ascii?Q?KON0zy02KvuF6xmYDJo+cj+flA3GViqN32+Fe1rZsaCZ1tMhyDaOIeP/i1w6?=
 =?us-ascii?Q?EaOkfSRQPthdxM+MB3RKtmxDuAVTKBalMZGdJ6r8kSGIskuTma9ZcmOothmm?=
 =?us-ascii?Q?vpwLpQN6oBLPC4emzD86AefVDlqFuX+jF5iBELOSHPIK2V+bknVFhbWLOpzv?=
 =?us-ascii?Q?TpYG1BuMoFcmPF1swjuvae5pxuWYKTfPedQaFv5VKuhY4CKe8jAux5YB3aop?=
 =?us-ascii?Q?fpMFbhFdSaL0dYG88m4Tdgnar9+X24QN694T2Hwb7Qhl+aY0+qq1JJE7CVMV?=
 =?us-ascii?Q?LlsRblOr2JsXpENoTSr2fvMxZbB0tRqqc5EQxTKWprms1U6TVqMpHjkFZ7RV?=
 =?us-ascii?Q?aNdG/mAGbAkitdzKny2kxTo+cgpa98EMXy+8noLCs4TYn7P1nDVvcO/z+lpg?=
 =?us-ascii?Q?Xi8IE3RoZPfnMqP9CWJiMnM7KH7va6NnEaM+79WHcgPECXeLs0QnxsHkbGtZ?=
 =?us-ascii?Q?XqF9XdhOXovG13cHfkEw1yIQuDqwFCVjtT6/OtnH8kzQ6eAx/X1n5+XxXRSb?=
 =?us-ascii?Q?CDkqihNA0uFz9ZlFbkcjo9+qs3Q+Pr7EZa/EPftBjLy8US5Pa3JAgV7cJzds?=
 =?us-ascii?Q?0TR1ZhksmE7kZ23YG8CmXsYOh+KJoLkZcHirbYZkByAxUyoLDG9svHkQF3oh?=
 =?us-ascii?Q?DL2jUVzV7lSIhQMWQ6xEZ/UFN6r08tm9tv33zWYIHMe0qyLUPYrn0ABg7R3R?=
 =?us-ascii?Q?c4wYTVdOBnAtEjSNCXo34+jNYXfqHbth96+09aUqO2obpCuAHYaXx0Udhjhl?=
 =?us-ascii?Q?SCL7z3X1ARZenBF6Wou5BXaEp0Qe1p5vnsBxDI0Bs8G506eG3Ip/7s15YRd4?=
 =?us-ascii?Q?QzJKgQBQXQjYbNN3cCpSOl3/6Q0Nlg8cQaq9dABO3EE2FRGIoV2doHt7mKYF?=
 =?us-ascii?Q?foR8czV4ugs1TYPiNI1pJlPm1eFvf6P2oVleywm55TFlxeqglrMptZsaHjIi?=
 =?us-ascii?Q?XWBze+VqnlXbP3Wndb0C7IilB4knRKzcreCAkF2dT+Hfs/8v8gB+WG+roF43?=
 =?us-ascii?Q?qHedmd8CdAln8CFBlICi60xHZCHTLTBuPtwyBhLRnEheBN0xcPGpSi6cLS0Y?=
 =?us-ascii?Q?B5bghCnuXPs6ggEJNDgWfNiza7xhIn8uI28JwSLgtI2QeM8afiT5Ut+IEaJR?=
 =?us-ascii?Q?B+fMY24v4LdxeO8RyTT2zXXfPD3L0tXmpUDMqOIPdEJCKnVpBCuSWaGL7GgX?=
 =?us-ascii?Q?Y5JrJau1QCoRkBLwEgAvQ8iSkB39Y2unCxSEBSb1Wl6mHuG/FLXQ672kUdEa?=
 =?us-ascii?Q?jx9AjLN0X12+YDvbqWyXOw2YTcjHJLG3OQhXIUuQ1yuJSJsKBsLI0XYIYKAz?=
 =?us-ascii?Q?40+Uqf83BU1k1QZ4t1vCzplsMdRqQcmziKReARbZ2CQpCpsZXg9etz52LovH?=
 =?us-ascii?Q?cQUROvV/OPKpc7yFzbUr40FoN8B9nbKqsOkgVRru?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99568957-63b5-4006-6706-08db2aaab009
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 07:54:40.2136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTnl5YXfXumwMFM3WiYs+B/6NS7/t0A69DtkMQqoYx7hPyxcgz8SMft+sfilwk2aX6uEWvEmZ0yTC8mesICUUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8525
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

"-mfunction-return=thunk -mindirect-branch-register" are only valid
for x86. So introduce compiler operation check to avoid such issues

Fixes: 0d0ed4006127 ("tools/virtio: enable to build with retpoline")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 tools/virtio/Makefile | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 7b7139d97d74..1a9e1be52e4f 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -4,7 +4,26 @@ test: virtio_test vringh_test
 virtio_test: virtio_ring.o virtio_test.o
 vringh_test: vringh_test.o vringh.o virtio_ring.o
 
-CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-protection=none -mindirect-branch-register
+TMPOUT = .tmp_$$$$
+try-run = $(shell set -e;		\
+	TMP=$(TMPOUT)/tmp;		\
+	trap "rm -rf $(TMPOUT)" EXIT;	\
+	mkdir -p $(TMPOUT);		\
+	if ($(1)) >/dev/null 2>&1;	\
+	then echo "$(2)";		\
+	else echo "$(3)";		\
+	fi)
+
+__cc-option = $(call try-run,\
+	$(1) -Werror $(2) -c -x c /dev/null -o "$$TMP",$(2),)
+cc-option = $(call __cc-option, $(CC),$(1))
+
+CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
+
+CFLAGS += $(call cc-option,-mfunction-return=thunk)
+CFLAGS += $(call cc-option,-fcf-protection=none)
+CFLAGS += $(call cc-option,-mindirect-branch-register)
+
 CFLAGS += -pthread
 LDFLAGS += -pthread
 vpath %.c ../../drivers/virtio ../../drivers/vhost
-- 
2.37.1

