Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D49C66B063
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 11:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjAOKcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 05:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjAOKc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 05:32:28 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2045.outbound.protection.outlook.com [40.92.98.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C73C16B;
        Sun, 15 Jan 2023 02:32:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNvxOQXFMha0J2Yus+H/566VSrKVCG72eYBEim0ZiLu1CCfjt4A6xWMdgYXcc0oXmZfhr+7Fp359oGqBvo2Ow45JcP2gH6FFCNgC9wX8sf6Bv2dW5sJxaqygNcjutOuZhZSjKVOP6+4H8ALIq5Z3AG09SoMj1k/PJ8Y5nhbSDvdb1Y3e8sgqUyjyDDiPgqfUnPRMYFvfLPWIq819+t1Y0jeTUWJlnibq47ayepqULt2X6/jKNUxNyi6c/2CyyOb/vUB5B7fmehNB8F1gBTLXLH1Ca4ybCq1vwW2joWvtalYAhqk4QCpVX0HYSZHFvcfwqRofYIGC2TAPqHIuCAkqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sskbBFcb3YFm14/Jh/anX8frm80C4yL2TYzqKanaQG4=;
 b=cLp99XLUNr0MIRuuBTnD+iiYyRi6Ga51SiBRrpDjmqXRQwN61U0y6LgIXuOPuI6/kiP23nZzE3KSMNxrK6x0Dv1yJin5KLQv9MNgqAERrS8S2UIHHEUap+teo3QVue+67FV3LkqTh8G511EckY3hCb6kq6ldzwAg0LEgkvtHkeLWvRrkb5oNAOAvH7VIGCl4D0gpfjCkezJ3BdVlkI4yRhXC2slSqrpbQNQKjTqxvacYYxYffq2+AY0ZXGr/bdSgtGpUxJg/jy7rXmSfjzvgNywEi4IzsGXCu2hwO5/ozajZ2l5KeG8f3jTaYrYMwF6CPLTYr8g+OFNB//OTeNaYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sskbBFcb3YFm14/Jh/anX8frm80C4yL2TYzqKanaQG4=;
 b=EvkFWcF8VH+/OtlugYXZcqDyxC3qsGYdKVVn2niQC95KgRlHvEv4qemTZLR/hz1ZRY+YZ2F8jv6KG3HnGhnYCa5oo9IFZMLbFofklCNVHHNgLbgcTFSfp919lUS1x8b8Qc73DFNhIPWO6V7rkz5BnPrgaUKqHUJSc/hkGIg4s2qzCsFODCMxZSe2NGRUbo4nNtmz+qBAUX4mqfcmmh2ohHzyrNzApxxxBLCqKPTPJkfi10GOJRRxYLHfNvsgsiqpV9Es3jmCs3jDnZLGQFavJOh+PrtPX6FdZlacVrYAv2BLUpEyV8Z0eFAK6yTwYWovll+B2qR55UriHnl73NHslQ==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OS3P286MB2025.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Sun, 15 Jan
 2023 10:32:25 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605%4]) with mapi id 15.20.6002.012; Sun, 15 Jan 2023
 10:32:25 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     linkinjeon@kernel.org, sfrench@samba.org
Cc:     senozhatsky@chromium.org, tom@talpey.com, hyc.lee@gmail.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] ksmbd: fix typo, syncronous->synchronous
Date:   Sun, 15 Jan 2023 18:32:09 +0800
Message-ID: <TYCP286MB2323A6AB80B9EFE1CAB86003CAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230115103209.146002-1-set_pte_at@outlook.com>
References: <20230115103209.146002-1-set_pte_at@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [BvRQ8v6enCF2LInju5goHaOM1AOCSujnMOrAgMz9Sqk=]
X-ClientProxiedBy: TYAPR01CA0210.jpnprd01.prod.outlook.com
 (2603:1096:404:29::30) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20230115103209.146002-7-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OS3P286MB2025:EE_
X-MS-Office365-Filtering-Correlation-Id: 10bc98bc-f777-4ae2-9c63-08daf6e3cb12
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +shUgAg6YJVrKILYKvkc6agH7zvfdZdGL99LEBjpSXsj+CiATf4UbEsezuXKQ1Xsu0PIfJoTePqQRZAc/WbcO339L0tKjqo1JpHhTvep9K2YwgjlnBr04AIlcvj+2LUo+jF6+cmPTkPOaMGpsM52MUdFdscfzCVWPBq/HeW7JbUrs97LPWBiRIBqWrl35BpUxFyq+asr1DutrdZFfXwvJKHlWUq5Mr4JL5lqnyDnGXs0tYgIabx3TtY4dQErqI7yj+0D2qZTo25xp+BaaPhjxDEGxUKG8uO3RH0XWnqf1ICDPAZVDoawfpwcEEH9Nwhxv/3RmYOVOL0zinV1qXKVDx/ep6RIIHtE6/kx4S9jCokAdwSb00zB1mWZUYVU+BxFXaq/Bw3CZS4d3FoDce8gOLwdfJXZGbGUel1I+59UkN/owe2gx7bkSyyXtm94uxj0vuukGfuIV6NpwQYtQhgkXiHwy+qDyp0UwVgJp635nfMxQLq9/YVs1f2RVi23zzBmL9ssvLUrZZ9DG2h1U1eibjKjq+XHkldIWx/hGWV6JedpCxjNX/aLjw13fGfJeOHgmWVtqZOipgxVqIVMfkBEaVM+my6mRsJyLjoRLq5QYpc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eqcFZ16X3EvDI19BqBn0XGyozwdhAI0XpmajfoA+AdBpL2wp/ThJNG5othf5?=
 =?us-ascii?Q?u+lsrWjsuP0c4Qt785nAwDVrJWGYsgq6y0ZwFKhCtEZNNAHI2vlkbj/EFG3/?=
 =?us-ascii?Q?ZGo0BXhgiPt5igBIm1YrbfeylXYxIZwBjZRtoZmhigViHu+Ufo7YRooLzzEi?=
 =?us-ascii?Q?AACMWPQ+0mTYFLJrLFfeoS2pwNV1uuaVyPy8GtV7fuz8JAYGchQwcZIEvBnd?=
 =?us-ascii?Q?EZAGWijL1OOQmx0EsnkPIZqgTVb69Yjf07Jo8rnnuwPIpYYOUopIjgYFL7bb?=
 =?us-ascii?Q?L7NVfmgGqq+mmrTVD7t2XuXy1DzveWUmYCNm6Z1nPvEfujBEWU2msFIm2ril?=
 =?us-ascii?Q?rtOwr0rWdoKzzr3Ed2HQScqeeEjB9HQ28INfSzV21rqVXhjzOYrde6p1l9Iv?=
 =?us-ascii?Q?wQqhTwGBeoHwNfvJ6IevpYCiOUXBuxlKH7P2iS+0CQBm5jdVHetklLR+So/H?=
 =?us-ascii?Q?cDxbauPfb2CWqsAOFYnLuCOCP0FV36FgBEpiC0lZo2a7cdWi99aWv0A6v11d?=
 =?us-ascii?Q?fbZ5qkVOy6DAELV5zlbbJZaMNhfhN3YK5CcDMXbMjJbyYfIjm73s9JAvBasA?=
 =?us-ascii?Q?z/XBk8XOBAIc414M46fABzSZQkt71XJYUeyo3sP5ETf+RtvVVHI1UndzAONe?=
 =?us-ascii?Q?fFtMo6kwEB1cv6gAq1rs57acO7JCWNyWc3yzLvUQJEmy3n70lDnEucdVlIem?=
 =?us-ascii?Q?CNol7DqPGSzHg9UohUOmcIsK3BDsN1AWoF/AUxjrAgBGsP+wC1lUqlycdZhp?=
 =?us-ascii?Q?0rmzARbALHLOhbqBpdP++I/LrSfkRNOfxT4qzcXid9fOmkrPwcPEyhmRsyc8?=
 =?us-ascii?Q?+7UOPApxX5jJlcWAvFgePGOTgZ2vd3WMZ+RFIMY4MfnTYaNyYkN87OmMrcwv?=
 =?us-ascii?Q?R+R1KWOHZJul+GzoXDFjq/kT1asiXUCHe7BnMD0g1C/CaxKEGuy4dkQUX5Kr?=
 =?us-ascii?Q?Cbz+vMNTSjggyyPk5KsshRV4Zx7Li9PnSPaj4eAFi2amkd5IbyNdaMOudTQ9?=
 =?us-ascii?Q?yMWm0+SY7dpOXsAZse3Kq3JkCXW7Jqtjg4XRRKZDldvikoGqfT2EcTz6WasW?=
 =?us-ascii?Q?cY/C+kf6Tr8tino49n7h1uI9m7x3h3fn8x2DIviOHqSaeV4+6t9H3QMjeGfT?=
 =?us-ascii?Q?Xv66he3YV8he+WUmBqxVPJkyExB9Zc2p6yADX30arfgC+EGa5fQ1wBjdHgp4?=
 =?us-ascii?Q?Lp1P2G1Te9KLwBd80iCE7ijiXan6u3J53elVXAA221URmyZBpZHxzdADWKJO?=
 =?us-ascii?Q?OeJxw9nXKbjXRpT3ipDGRUN6wY6ZT6yPDGCtHQHPLX1fUWD2vU7JtJvP955/?=
 =?us-ascii?Q?KD0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10bc98bc-f777-4ae2-9c63-08daf6e3cb12
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 10:32:25.4018
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

syncronous->synchronous

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 fs/ksmbd/connection.c | 4 ++--
 fs/ksmbd/ksmbd_work.h | 2 +-
 fs/ksmbd/smb2pdu.c    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index b302de5db990..0fcc20ce0852 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -114,7 +114,7 @@ void ksmbd_conn_enqueue_request(struct ksmbd_work *work)
 
 	if (conn->ops->get_cmd_val(work) != SMB2_CANCEL_HE) {
 		requests_queue = &conn->requests;
-		work->syncronous = true;
+		work->synchronous = true;
 	}
 
 	if (requests_queue) {
@@ -139,7 +139,7 @@ int ksmbd_conn_try_dequeue_request(struct ksmbd_work *work)
 	spin_lock(&conn->request_lock);
 	if (!work->multiRsp) {
 		list_del_init(&work->request_entry);
-		if (work->syncronous == false)
+		if (!work->synchronous)
 			list_del_init(&work->async_request_entry);
 		ret = 0;
 	}
diff --git a/fs/ksmbd/ksmbd_work.h b/fs/ksmbd/ksmbd_work.h
index 5ece58e40c97..3234f2cf6327 100644
--- a/fs/ksmbd/ksmbd_work.h
+++ b/fs/ksmbd/ksmbd_work.h
@@ -68,7 +68,7 @@ struct ksmbd_work {
 	/* Request is encrypted */
 	bool                            encrypted:1;
 	/* Is this SYNC or ASYNC ksmbd_work */
-	bool                            syncronous:1;
+	bool                            synchronous:1;
 	bool                            need_invalidate_rkey:1;
 
 	unsigned int                    remote_key;
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index c60cfb360f42..2ae153de4a9c 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -498,7 +498,7 @@ int init_smb2_rsp_hdr(struct ksmbd_work *work)
 	rsp_hdr->SessionId = rcv_hdr->SessionId;
 	memcpy(rsp_hdr->Signature, rcv_hdr->Signature, 16);
 
-	work->syncronous = true;
+	work->synchronous = true;
 	if (work->async_id) {
 		ksmbd_release_id(&conn->async_ida, work->async_id);
 		work->async_id = 0;
@@ -644,7 +644,7 @@ int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
 		pr_err("Failed to alloc async message id\n");
 		return id;
 	}
-	work->syncronous = false;
+	work->synchronous = false;
 	work->async_id = id;
 	rsp_hdr->Id.AsyncId = cpu_to_le64(id);
 
-- 
2.25.1

