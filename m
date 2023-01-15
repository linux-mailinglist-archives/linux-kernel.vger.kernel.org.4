Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C313366B062
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 11:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjAOKcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 05:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjAOKc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 05:32:27 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2045.outbound.protection.outlook.com [40.92.98.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAC1CDF4;
        Sun, 15 Jan 2023 02:32:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgBx+uSFDs3IRKmTXkP822He34PEHT84/IOiMSGekMG0kKmjweShw3scks6P8dv6yG4zax0jzIjThC4CBzjm2a9hom9YPTTcWTmVnWP0vI/haTUutme55YVNPeQFy3hM6262FiH5aLD1hq6oIhZxBSdVOxDtkvTGygeUZxw0axmkVsjaAQUxif+QQ89/5OqgNsmk+EZVZLOcuZ7LgOv836+9lJoHV6641t3e992X4vB3Obc3l98RYD+1eDB5wI+vbWBTl+NxoGHhpumhMerg940F8wQi+4krBauMV1tfqYtbMeq2szv0v6BLOZkKqaWE+op7UH6cbDw4HpuaUgzeug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBv7BL9Uf6cXj9khn04VzCBRpFusMoYQVfaaytM5MVY=;
 b=DezYgFGylCN+WWPi8yreaLdjNh3uvO+MV2m7EoOrVfNZ3tBKHQatbO3hLVvG/WFqehbDx4Q1csDoxTz3gzGTzVx8Tyeqnchc7XyYTfB8xvNaWj/oPoYGXowf9utWLf8IRNNpqwZEe+v1rg9bkwGSBw1Rf82yGeYzrPPG/sde8XcqvmpQxORYWWoVCCMs5xMoyT1LLejIICtojP1Cbp4DUmevW50qLvRHA/DJ35jZ2kjkRsVknmVgt1Ch6BosdEfo8gLHnOGoYYabk7cSAuCp720K89M3EHJJUm57PK+L0DpvI/oMmQN7YliK6vXu+aamv5o4HYEClyZfhckhSomMVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBv7BL9Uf6cXj9khn04VzCBRpFusMoYQVfaaytM5MVY=;
 b=HtRWhX87r/IiFjroNNQQTkq7uROq4LkixilqMwVib7Z5hRLSW9+fNVvM9HZIdHo6F5lNr++teX20VOcgPBLoGwsGEc3uPMjLSWky3SWDnMvCTTL2FBuI5sMbGxdw4yPsTSmsVQ9G3BSUTontwmn8+ZYEgMSoaFB88CMrzyXfAowTjGXAaAkR0T5wW0pect+fGe39J815n+/u6NiIKJZYCqEWa4LHNbdu0hx/1IxCw1w9/ryEUSismo0aQ4kkEqvWSwCDDvtTagpPTMAYEcLMm2bg9XthUzTDk1U3oq67kZe+J89iuJhZk4Xxyg3ux7lP2d64SD3SUAeevrTCxmIThA==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OS3P286MB2025.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Sun, 15 Jan
 2023 10:32:24 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605%4]) with mapi id 15.20.6002.012; Sun, 15 Jan 2023
 10:32:24 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     linkinjeon@kernel.org, sfrench@samba.org
Cc:     senozhatsky@chromium.org, tom@talpey.com, hyc.lee@gmail.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] ksmbd: improve exception handling and avoid redundant sanity check in loop
Date:   Sun, 15 Jan 2023 18:32:08 +0800
Message-ID: <TYCP286MB23233D324DE28E57E376228ECAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230115103209.146002-1-set_pte_at@outlook.com>
References: <20230115103209.146002-1-set_pte_at@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [TLUMQ9VmFG2iXlqBs9WdQk1N+GaLwOZxb/cH16lS/eA=]
X-ClientProxiedBy: TYAPR01CA0210.jpnprd01.prod.outlook.com
 (2603:1096:404:29::30) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20230115103209.146002-6-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OS3P286MB2025:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a957baa-ecf4-4f4a-86f3-08daf6e3ca51
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VmSD1IAij1wTEhBFvMyP6VgzZg+Kzd0P5HQpsMkes71SiOF6BOk+cSxen4/T40okNhVcSqBXpyvG/6NK0thvVn/xDCZan7HdKCPoODYPa7qMqEMdB/liFkJRcuAm5x1buYy52ZlCfr8i9ocpkBZXezuUsYiXvst7mUWJG7yYZbK8e40AfRkJjj+BTRXAv0D93QGGpuiPbaetI4ycWsjo2yJR2PvrLMgLOkQQXmKIbomM4xHs1NCful9Z3DchPxgr+KMkoGOfhRFnfCkivLqi/yiuVEnm5jvtSSgGioGjdlgfGq2wFEcyL1XX1PurJ8PToeo5ldMuc10Jotd+winhf7URRPPxvSjjPm6OAYbWvLv7NsWSHCYF9RKDmIdiFet1v5p7PNErpEyLPq7EdeTf4OG205tRKN+gvrtrIXE52Erfg0meIrOHi9fwNbJ8kYcTnRRv1TMP5yZKPTh+IDI6yRngdaqQpj/rVICHzIYOHwn6EDNrrn8VV7PNOwdmKFzCiaEqU7ZNIFVSuS74sXJDP7F1WVAGZOd65B2riGI5UB2n53Rrbv/SgCJ6sYHzhgAwvbnKiNqfI8xtGDzWKcjaYYmfd02Ahe67LURpJqAn0HQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DKlU+EVUHF653wYuNemROsio4rKomrRwmGlW3nLdjJZ9HbL7ZtlE1Rz/VoTC?=
 =?us-ascii?Q?ssjhI8DQTEL9uDsvBGzPHxd6y4Beg+p6Xo6E5tbsKJzjAJmUbo+W7nO6xlwb?=
 =?us-ascii?Q?lzpsJ5gkawkKxxc4BWyw8fmAcXh7Q5vf6mqPsQA5wTaOHqxpmNRZ2K/bIj1T?=
 =?us-ascii?Q?9lFvAjN+Qmr/9170VbwEnKHZqhGsjAJ5JLnzfbarx1hbr5LnN34jzOzdeXiw?=
 =?us-ascii?Q?+PFDWsn6eeky/C8WTGu3VCMEigaXXvP/JfEZRfbz6TSQd5Co28Q4Vopyb/HI?=
 =?us-ascii?Q?/1VVqj5XmH0TBhPqWWcwWjc6jChvrL+N4EoeHOnNoq/zZitI8Bblvra+I9Hf?=
 =?us-ascii?Q?RVb29RggH0dvkN546g5ih/RPrG1mmLSfwq26easq/K3BqzsuUgOkb35QgSiO?=
 =?us-ascii?Q?Dnq6zS7OJizCvc/UWF4Z8/6hTvnz1/SNm/X7WslJEvP6h4S0SQopLHqhnbKZ?=
 =?us-ascii?Q?pErwSoPetWqUG6mLSvmOlKMvSmy9O4bapfISAk7eQb8UdtZmdAwJcCS76sbb?=
 =?us-ascii?Q?LqAN1Qdes4zO5hmJGv2Fyz/TuYQgn4MsDe76Pqx5JSXvvYcRnq/V0YMbio1S?=
 =?us-ascii?Q?t/Q7HLkjCv+Kjoo8t81XGA5MIsEpKloXMWGrJJBNlB/cBEUQ11tjUdgXZw6A?=
 =?us-ascii?Q?F9SsR0ZYt+MeDprjK2u6iOWfrEXyPPyPUJzvq4EDd6A+E9mGQeXZhrO+e09p?=
 =?us-ascii?Q?HhqMwhOjYMs/1BR/Ow2GWouWSXOkPMoCy1L0tjSLvmEP9NxZHD3jY1mY1R4h?=
 =?us-ascii?Q?wQSv417nF+6yeg1N8pHROUxG/okCIepdSuqc9MGrH8yQMX/qPCcOXbbwRTZC?=
 =?us-ascii?Q?8xDKYt1FEtzpbhyy/LChNMjSOQ0G90DjF/Ij6AIBNfbrbpMJUd826kek0Vvo?=
 =?us-ascii?Q?YQtRqPnPuSJrGmOGt/ziT6hYOKyVp5ruJ3vKUgjsP5puPrH6d1tPAYnttXxu?=
 =?us-ascii?Q?ta8PutpxfyT+gocGTtEWVQOwQxwjLT/0rXow5tQYQ+y3kf1DsHbW8lhwcEDC?=
 =?us-ascii?Q?Y6/G6oY7DxhWjbC4KqhHs57u0+MRadtNhBh1UkpwzcpNX+nWSIHccFNyZ/Sm?=
 =?us-ascii?Q?/T4eVCFf8pU0zvQwcg2MCPNfkIn7uDr+fm7eha/6l9JvoHD32nOzW/2loRYF?=
 =?us-ascii?Q?S77FYuM3pzA9vu8/zA5Eu205yMX0yhe/3BOmpWH9vAP5CbztNszhWsnkUNAR?=
 =?us-ascii?Q?mizIhVj2Z+ee7mVnL/6rprdb8TJ5DDahcPo3lmp5PGwhxaBvWg1m35atRCeV?=
 =?us-ascii?Q?as9y17bHAEDvam7XzWGcvp3qIA5KSmZiXOngeHW8AgztfFukE0tAAjHrZeru?=
 =?us-ascii?Q?GEY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a957baa-ecf4-4f4a-86f3-08daf6e3ca51
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 10:32:24.0883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2025
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Sanity check on validity of hook is supposed to be static,
   move it from looping.

2. If exception occurs after kvmalloc(), kvfree() is supposed
   to reclaim memory to avoid mem leak.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 fs/ksmbd/connection.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 36d1da273edd..b302de5db990 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -287,6 +287,12 @@ int ksmbd_conn_handler_loop(void *p)
 	mutex_init(&conn->srv_mutex);
 	__module_get(THIS_MODULE);
 
+	if (unlikely(!default_conn_ops.process_fn)) {
+		pr_err("No connection request callback\n");
+		module_put(THIS_MODULE);
+		return -EINVAL;
+	}
+
 	if (t->ops->prepare && t->ops->prepare(t))
 		goto out;
 
@@ -324,8 +330,10 @@ int ksmbd_conn_handler_loop(void *p)
 			break;
 
 		memcpy(conn->request_buf, hdr_buf, sizeof(hdr_buf));
-		if (!ksmbd_smb_request(conn))
+		if (!ksmbd_smb_request(conn)) {
+			pr_err("Invalid smb request\n");
 			break;
+		}
 
 		/*
 		 * We already read 4 bytes to find out PDU size, now
@@ -343,22 +351,18 @@ int ksmbd_conn_handler_loop(void *p)
 			continue;
 		}
 
-		if (!default_conn_ops.process_fn) {
-			pr_err("No connection request callback\n");
-			break;
-		}
-
 		if (default_conn_ops.process_fn(conn)) {
 			pr_err("Cannot handle request\n");
 			break;
 		}
 	}
 
+	kvfree(conn->request_buf);
+	conn->request_buf = NULL;
 out:
-	/* Wait till all reference dropped to the Server object*/
+	/* Wait till all reference dropped to the Server object */
 	wait_event(conn->r_count_q, atomic_read(&conn->r_count) == 0);
 
-
 	if (IS_ENABLED(CONFIG_UNICODE))
 		utf8_unload(conn->um);
 	unload_nls(conn->local_nls);
-- 
2.25.1

