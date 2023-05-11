Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405D06FEB1D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbjEKFWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbjEKFWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:22:04 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6508C4498;
        Wed, 10 May 2023 22:22:02 -0700 (PDT)
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B1GhEI028406;
        Wed, 10 May 2023 22:21:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=qSeiFqRDyvUfOLTBCCuTT01z/WuLi6I2M7nNRspoGMw=;
 b=dj3J9FvYt4YBA3bi6wyxJD1jOw0z1Mlnz15mSv86nm4x5DnJZDRJGLn2qv5H5zT23QW5
 D62Ry/ML3oUrmhKrg8W/Us/9jtcbGcQ66K+SC1ivMQAmQXxuM/Kiu7+jNF6KJxuHyBqG
 kjDgPXTCkL16xyKuAq+ZpLPjoZ/iKafj+CdXbuYc4PkXkFZcXVkuGi+jOLmAdE/+NUG1
 Dj75WkfwsDErg/1EKD1IcfS0dbeacGS6VIscLjKvkuiNnI1bB/Hi5gL0a2VALZNl0v6w
 2s604DMA8dzA+OWCTJuu1X8niZIpaj96PJHP4sLS9Pd52UVcc5C9E9HWgHF6o4S9QQ8n uw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qf7jvdbvr-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 22:21:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jh8hdmFnev7uDzYMCSKqxTKfDBrkmLqGG/UP+n+ss1xAWQjjw0JD/e2iv+4i/0d5Sc5V19KHh+doRHgOPsC66KJ+8lu4/3DL0K1SEVD8hWBovLnPWb72c5yc4QjHscFk1Y/44JN2S8Ez1gsZj+vDb8f6cH0iG08b9T6eUyvd+9253gyaombMHK+2NZySfEzlm00zcnf7VjkSliU76alT27aWIJFTe1wzH7MTACfTJuWu5s/vU84dhYcdvfFF74reUw750oXpuftaUfYDliao5P1x7r1hUxjLtX6mOYrW8WAs52FqLrn9s+x1xyhxaNrk3u75yDiJ2I1Kys4eb212CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSeiFqRDyvUfOLTBCCuTT01z/WuLi6I2M7nNRspoGMw=;
 b=k8zhcQd32SpC45ZnWF6K3BjMCLoqTyHgQzwUcJxghH03c3m9U9FPO5KAZ1dCfqYkOHgrRtliLbzp/qx2Lrv19pciojJx+FMfdFevEHJF/q94zVakR4nVv2sEejl8o0zBftEXqSC5savQ+JsDBvs4sWGbzriwvNSmRXjOB50AFZcttXkkqiDN6Y6td5iinyvTspXNmvgIGbGQQ3N9YKVg3QKPpz7iQKcbsTJE5iWswKWbKex2w28IFjCjDKM4hHpN0j6/BZIMlmcg1SAVxyh6actniBFBrxF0qWUwkPK7+BDtMRcnlcYTHI9j2PELtGsH4Pi6Oh6dTKenxOMViIIHOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSeiFqRDyvUfOLTBCCuTT01z/WuLi6I2M7nNRspoGMw=;
 b=WNoL8cQhF3aT9aQY9Tg94/DtxamOFlU1hpwaL33ReAfaWQskm7qLuzykk8aEJ2GZulF/GAk8oT3qLfdyI5nrZhvINx6JcPCiJhDlsc6msPYPtGxivmMk4Er40Fcy1tH98wMSQG2jmzzQtk4GMVZD5CDA/sxtyiRLcBV2jURy2jPxMLSQSLKZclKQ/BoeLQtgkjOsys9PIfqtBKfTrzpyi8tbBiOvHmf+MPIfcFV7zxSPclOku+nP4c5RZ6iB1ZCp+eYgfpJN6kypk/005vhPyXUDwcSBjXu/IKqgEGVfLqXMIYQ/VUluI9wlHBTg/w3c78oxlpdV/4vi6Fw2lu/wsw==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by LV3PR02MB10006.namprd02.prod.outlook.com (2603:10b6:408:1a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 05:21:34 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6387.019; Thu, 11 May 2023
 05:21:34 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH v2 5/5] audit: do not use exclusive wait in audit_receive()
Date:   Thu, 11 May 2023 05:21:16 +0000
Message-Id: <20230511052116.19452-6-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230511052116.19452-1-eiichi.tsukata@nutanix.com>
References: <20230511052116.19452-1-eiichi.tsukata@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR02MB8041:EE_|LV3PR02MB10006:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eaa4a92-191d-43f1-6961-08db51df960d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYI9r3aFf63K/gfkzlECBGXbOu4gjaopyBtEXbxRZFqjELKrm0dzt1EyfKC4C0NQTDnr+fKO5CAXV3uAncGbksRFDMEOCOoCmAYdhqBWX7Cj76yY8KozrwGh2k8R2gwyVgSM7x2pZXxxtq95hR9sw35LDIgv4JTHkI95VTHFQOrY1jCW/SQGFGtNYAyz09XyD8JOatO0EDOzgcRxztJFBFTceLgma603cGnVfKW2rrxPF8Qu1reb0oq8D8num24jorSE8VKV3wq9CZRFtUKiEwDx/nfv5I54TubZ9T7yKMJ3Qo/UwwwMpLwpt8BTSSfgDM+hVb9ZSra+VyBnrF9Uowx8rgThqqaIOtcYWOX7aAuxCfQu1Rya7Erisqx9XKo+Os8h/CwtHmWmFBgQp+JNTRCIsrnVCcR1LtxPDFSaWoNfs+aBGkjr2ojwIrngcX87rghLAWAYGGcPz1v25O8SoKzha87YuBvmZ2AcvbkdahTqwGYJGegg6PJ1j6vu/ubcm7ANU8a3u7PPY7/HxJkwo7i/W5ptIrniDglghglPg6XMMb48cyVF3MMIJ6NyWHr56OiqW4jgiw1tWNSBRaQoqb6EmiKEX+slvCaJTyO64mDdzdl6Rs+w5vvy+tG6JDic
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(478600001)(36756003)(86362001)(2906002)(44832011)(5660300002)(2616005)(38100700002)(4326008)(38350700002)(186003)(316002)(6666004)(6486002)(66946007)(66476007)(66556008)(8676002)(83380400001)(107886003)(1076003)(8936002)(26005)(41300700001)(6512007)(6506007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cpW0K41iPOvc28Pl8sj9uJb7m/uPqZQj+e1blfUnQU/q1dfXsFDn8WiNYaSp?=
 =?us-ascii?Q?1uvm7KQ4xCGNGvpjW9qytJ9Q831b27pMcH2Fw4HxTWiwjGf+xNbjoiHxWrhr?=
 =?us-ascii?Q?B/YiVGi86loeY32fR2YHeoLw/ywTkYE4KAAJB/md8JlfeVBHx+rzvz9exE9o?=
 =?us-ascii?Q?LtEVsjCcyhOYIFjUNomfHLyrYpZIqHlc7XjdMjuZXQCgcFoaCrJ69VR4+Tcn?=
 =?us-ascii?Q?VGt9fiPSm3Vz/ICKek+9ZeQCLOJ+oPKrZSWugmFbCB0JCo1jpPG/bZ71mwtv?=
 =?us-ascii?Q?B5kb5a7nL7PXaKxAtqoID0hFjm3i6jz9GAXqyHbPMHrBqLoSyHGOr4m4y2+E?=
 =?us-ascii?Q?/YmolFsig+WzRPeTCRvm4TFok4U9GFo4lZ+BskJZyGSQlNwzm5FNb4wZL3A0?=
 =?us-ascii?Q?TOP06lixEb2+QVYET2eSBihcTtWVU3xNCynwgR2au27mnugZW53W1A7D0pht?=
 =?us-ascii?Q?xzXsAmFcnfAD34wWCeEoA94qDPwzjSbco0tdb9ugdlr+csBw+G3jpKLaCO6c?=
 =?us-ascii?Q?yitEwxqiQrUKW0Vr9soZ64VESyE6YBEdyHcBtVBKvexB5aM0aLXeJB1bwlEN?=
 =?us-ascii?Q?nopoVUDkXTxt0GMUCNfJtWzrDSmni+QSWh3f3r3g56ygI2mWu4Bc+mtLAP1j?=
 =?us-ascii?Q?6nHsikMTDkgHQ8iDaMnZAVLDM/MKyTyXAj53o7r3sU5GtTbXBoowP6JtpHxp?=
 =?us-ascii?Q?PDV03ws4ZYhR1uySxqmMSgLgcd8ilIccKUCZyXz/xaahroVhFmLhZGY22g2a?=
 =?us-ascii?Q?4ThyzgMKEOw9+QMmtdLOAZ+fMPid7DGUYP/vhD2ob1blrrSQKjQapv6ojIc7?=
 =?us-ascii?Q?XQpEFBjhBhOOESgIPQCxbeT27VFmj4S0ZvINmnBlNPLFCERjZQrwjO6NSkcy?=
 =?us-ascii?Q?rrUttUDBHVhl5zLOurX2T52G+DZaXh4sNAzbOBgGD62TDM+rBxiDc9PMNle4?=
 =?us-ascii?Q?6NHx4tvVfpaUmB4ExTJgKWF3ubWHO3F/c23UM4W9AZg8W3FWYekJ5aj561ib?=
 =?us-ascii?Q?dbvGJ/Q3pg1V0VJKUyu+kAtts4aa2ZAw+eJuw6NGBEzrfwr8bf2uR1rAmzsE?=
 =?us-ascii?Q?hEfuPSEKVCp3kmUqzYToIEJHG/oNIcSn1Im8snkFg79kaW9dxXm3fEkXN1f1?=
 =?us-ascii?Q?TCiEP683KmTYIzvrYBZnubjA0KKEEZB4iiM3PCZp41X6q0rigEFZA7b4wpzd?=
 =?us-ascii?Q?aigxvs5rFzly7zQVJKOHEhyJReTNQbHrkXSCZCm/1Rd3/iq0cd5MHUCAxZhx?=
 =?us-ascii?Q?U90ugLqkJIJJEzMBKeuQvy/Eh0LAMYXi7wcFOv6dmyZjfupw5wCUm+4F6W4h?=
 =?us-ascii?Q?T42Cyc3OyiSDqekYkgiPz3nYCtWCYdUfYdvyDg3phAqor4LX/5gcU+cj1tBf?=
 =?us-ascii?Q?sGp4LY1UzhMVhb4l+wpuRq875psbFY7QuqA2367EeZVAsR/55jReTjmdBz7O?=
 =?us-ascii?Q?AShLRcGmkSJwgX9OHf8stlH89IuIa1n99pGkwmkRmAM7mGrt3tUhke5UXrGL?=
 =?us-ascii?Q?RvLBdwKcbgIh/tystqz4t+Rudi5FuSTFt50zZDdpziySVL8XMuVF43HPnAXu?=
 =?us-ascii?Q?t2xAVMTW3dd9BYOQmmDQ/wUrHQpyacMcwYOjYWaEQvhcie4ddspeCWFvPSMe?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eaa4a92-191d-43f1-6961-08db51df960d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 05:21:34.1358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCTZ4iegDJiTDqSnX0M65gybjYL2OmfkDlouUPKsOv6RJbibq2iNJDFcR4ayIbWCVqEbmtR9R0OUV5l2XI3k2+8tcQBuHnhp4u7zZDauWR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10006
X-Proofpoint-GUID: rQaDxQovDCV8cydJxqN48Bjz3J_66dou
X-Proofpoint-ORIG-GUID: rQaDxQovDCV8cydJxqN48Bjz3J_66dou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kauditd thread issues wake_up() before it goes to sleep. The wake_up()
call wakes up only one process as waiter side uses exclusive wait.
This can be problematic when there are multiple processes (one is in
audit_receive() and others are in audit_log_start()) waiting on
audit_backlog_wait queue.

For example, if there are two processes waiting:

  Process (A): in audit_receive()
  Process (B): in audit_log_start()

And (A) is at the head of the wait queue. Then kauditd's wake_up() only
wakes up (A) leaving (B) as it is even if @audit_queue is drained. As a
result, (B) can be blocked for up to backlog_wait_time.

To prevent the issue, use non-exclusive wait in audit_receive() so that
kauditd can wake up all waiters in audit_receive().

Fixes: 8f110f530635 ("audit: ensure userspace is penalized the same as the kernel when under pressure")
Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
---
 kernel/audit.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 6b0cc0459984..ef48210343ae 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -631,22 +631,27 @@ static void kauditd_retry_skb(struct sk_buff *skb, __always_unused int error)
 /**
  * wait_for_kauditd - Wait for kauditd to drain the queue
  * @stime: time to sleep
+ * @exclusive: use exclusive wait if true
  *
  * Description:
  * Waits for kauditd to drain the queue then adds duration of sleep time to
  * audit_backlog_wait_time_actual as cumulative sum.
  * Returns remaining time to sleep.
  */
-static long wait_for_kauditd(long stime)
+static long wait_for_kauditd(long stime, bool exclusive)
 {
 	long rtime;
 	DEFINE_WAIT(wait);
 
-	prepare_to_wait_exclusive(&audit_backlog_wait, &wait,
-				  TASK_UNINTERRUPTIBLE);
+	if (exclusive)
+		prepare_to_wait_exclusive(&audit_backlog_wait, &wait,
+					  TASK_UNINTERRUPTIBLE);
+	else
+		prepare_to_wait(&audit_backlog_wait, &wait,
+				TASK_UNINTERRUPTIBLE);
 
 	/* need to check if the queue is full again because kauditd might have
-	 * flushed the queue and went to sleep after prepare_to_wait_exclusive()
+	 * flushed the queue and went to sleep after prepare_to_wait_*()
 	 */
 	if (audit_queue_full(&audit_queue)) {
 		rtime = schedule_timeout(stime);
@@ -1601,7 +1606,7 @@ static void audit_receive(struct sk_buff  *skb)
 	if (audit_queue_full(&audit_queue)) {
 		/* wake kauditd to try and flush the queue */
 		wake_up_interruptible(&kauditd_wait);
-		wait_for_kauditd(audit_backlog_wait_time);
+		wait_for_kauditd(audit_backlog_wait_time, false);
 	}
 }
 
@@ -1900,7 +1905,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 			/* sleep if we are allowed and we haven't exhausted our
 			 * backlog wait limit */
 			if (gfpflags_allow_blocking(gfp_mask) && stime > 0) {
-				stime = wait_for_kauditd(stime);
+				stime = wait_for_kauditd(stime, true);
 			} else {
 				if (audit_rate_check() && printk_ratelimit())
 					pr_warn("audit_backlog=%d > audit_backlog_limit=%d\n",
-- 
2.40.0

