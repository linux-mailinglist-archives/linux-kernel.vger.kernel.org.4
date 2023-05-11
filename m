Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A506FEB19
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbjEKFWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbjEKFWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:22:02 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D944214;
        Wed, 10 May 2023 22:22:00 -0700 (PDT)
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B1GhEF028406;
        Wed, 10 May 2023 22:21:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=+5ZIFcAXGaOEr6fcSRGPnoy06NRtoIMGpCCS8rABMCY=;
 b=ejvvIuZhEkdO18E+m6ggy5R9ILH1pMkpOiIAEeRkHQ/8mHCr62lBHr73r2qDX/6WWccV
 O3pp7hHSA9voWc6WeFtxkTzJYJAJuAPu2VzFxdzTnh+FNqrkOR4IouMA71SJKFRw6eRx
 MiNu0yD05xcm81Db8OnSHMHwEif4dQzqW6VZ+kbGQSZqZtDA+YDWIWg7gZuaPmB7E+l+
 CnUKbXBktPgkvSxY5NEtYzCm+7t/rmfQ8ijLkb4vRcTFu90nAbshLvwRr23jx+vZHvWX
 o81yjBRnThfzfzJVZnx/kMLxajqbE9LMhsW96WAW4ChrasrbjCfVWb8Q8kVm1Sf4aSjX qQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qf7jvdbvr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 22:21:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/+UhGhls0WWKUe9Iq2nw24ka5HVfd7fNWIxrwbWYeb0tWIOYtgbq+uXi8VI4GVM3pU7KTMSKx/zK8sL80hixKK5p/mhFM58C8GqHl6HIsmrp7WNFONmfuIpgItfcCLfMDty7nzy6a3DLpqJH8R+m/YpjyhhPCregQJ611cUHve40tyF3C39gqUv5+vHJqlLAXMO1tZB+WQkJ9juGFxgXDNJLy7Rvj/8Yp/JVZgofeXAqfucbu0pjq4F3AhoMyQGWN/CdpUpI0yxSU3SwfnDlU95mc64YEy1P6+Z1skbgQIrxZJMrZXcEG35OVVzssSGgHk3whreW0ZlCZQVGOm9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5ZIFcAXGaOEr6fcSRGPnoy06NRtoIMGpCCS8rABMCY=;
 b=IFUBgvB0uJPrRREB/XzwkFMLXlgBukk7FvIdOIIJz2Hg9+MvmgT22tsRXaxuu2Y7pjZbZ7glGZQtNYL9kUYAW7EyRo1RGAmuqMWzLk+66AbR26118oDhYYzj9K7vYaWvcst3IFdR4SdEVg+/ukr6sCYahEOzbE3rQwRx7yYMDoSbCT25qeGWiX3dP+Y9SaRfmC6mLED4KfNMTtxP1kYB/ESPEeQW5D+hWD0idiCGF8gbTIbitrDjEV0R86Nw5nUr161764ByYyUhnycGEAY4z/34XxaWKFKzJMEldFLqyMIqQdaVwK8LRBwlIN6VU7LaJJOCHcFeRgvBHduRm/KjAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5ZIFcAXGaOEr6fcSRGPnoy06NRtoIMGpCCS8rABMCY=;
 b=sG//+/ajOH2xbwJn34VzRmv9GctNnE3ZleXorCJh9ylNFmX+oHV5f/KXYSzFDfMJ3PgK19alcwV2yptXX7PMvUQipCDDWv2oRlp+SgXvdDSdyjeFk0EHXMQ8JFHfhXKPJ7jWUcQrkucxHnpAF9xt4eWDAflRQXHaeIuwEuH7G7IwzttqcSEbVp91QCV0a2dbPjvRC+MiMwZcGS5ZZA16wEdYf7TS12vzx5pwUGoWC4C/+0fLrcStBfQ5pmRruLbyhOykJQ940DbVqwblhU2VkaXFqrfk/Hc5I8QXOqD2FOWi/EJPwxH5WwgSQnpSJHoex6HtR1aoZe4JWI0JVj42xg==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by LV3PR02MB10006.namprd02.prod.outlook.com (2603:10b6:408:1a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 05:21:30 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6387.019; Thu, 11 May 2023
 05:21:30 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH v2 1/5] audit: refactor queue full checks
Date:   Thu, 11 May 2023 05:21:12 +0000
Message-Id: <20230511052116.19452-2-eiichi.tsukata@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2c1d83c9-5c6f-4339-00b6-08db51df93c3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3bT0wh7FpAMW/x0PQDB7cDdlQ2XBWe3Y4L9VyIHuQmSBHczP9bTVnNvQqj1Qsyzqcnr6AMj8dZsVWoijC7S7dIpeq5r8k3LsvmorP5yjmfQvYicdmupZjgWsXhfOp823R4zLWxv5u9PNGgNXkKnJENrPRizP3ZvSx/1pZZDu/vKUBV8hrTztTXvPm21R66fSNgBobmIsna195fNHh/8wUCK9EdHNo4LAF80PDi4xyoXvfgYlx+QiP5LkCmoE0RvKRIiXX01Rq2AfgVXd7uQySU/v5n6zOjtZNErg2NzqSo7nv56q5JuPxXX91Bs1ZXzZWWx/32SKYPTgMn2fPyMiLFLYL72zd8Rndvsil3fbIU5RCupxdsSAlEumSpgZcfky6w74VCxUeKdh/ZWcLiOWyBRaMR3wmqYgvMCtoZH2JgwbbnWZATzcBuKRf5MUcw2stet6aGJ2cd/tGpgMevz91GDxHWBzsKpK/y3bZCAoO+XI1c/3aOFsLpH75Hde147awBQkx9wweGd9hiPNwQA5duJOMmKXoBqrdszgrPO1eAgTDMNRjWCDz9yZXRIiT/wyTWMIG54bS5b1yX2mZSL393hnXCgwjQkju/3KRNCJzcjZj7OT32e9Bg9tkGA5Onx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(478600001)(36756003)(86362001)(2906002)(44832011)(5660300002)(2616005)(38100700002)(4326008)(38350700002)(186003)(316002)(6666004)(6486002)(66946007)(66476007)(66556008)(8676002)(83380400001)(107886003)(1076003)(8936002)(26005)(41300700001)(6512007)(6506007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LQ8++nP6GG0cDygodwjIlJM/VM1cxWGViAo/A7J4pUxbGGIcGsXJ0WnUAO8I?=
 =?us-ascii?Q?4fN38pGaPDrlApZhtlxCgPpCG6Comp+Fvj8IdZSWZS/aAD0TfMYJuw1jijEi?=
 =?us-ascii?Q?7PVyirb980OwZujQO0j70yhHQolalF1uWBJzutBkbk01HwkH0EvMYXsHAQY1?=
 =?us-ascii?Q?WQ7dKgG40FRqZbJD7A9UuzLaFYwGfxsVDEm8Iz8ZaPjRPEfSJ8qKJrtshy8b?=
 =?us-ascii?Q?gWo7XVAerWFHDxSGXaW+AkJleW3WE4TeojBsJEgVoYY9+r7HAXIfUEm1Ld7y?=
 =?us-ascii?Q?F79zOrgcnKox5HOFW4LGsQvtNU5Xmy94FoEVVeQBozq2W3uNZJDUBJ8eWX3D?=
 =?us-ascii?Q?DENn2OGAm4yiT7BZ+NTNYTQOKA9c/t3hmaJLvpY5nqFrxCuJnteA80NNw747?=
 =?us-ascii?Q?6Fr74rDWcNapy60RrS/Mi2gbi+uoMi7Kdq2MlXsEgV3MiL/ANeaO4BY06rDi?=
 =?us-ascii?Q?daeYekp0e81jH2paqLDn63w8I0RvS1KEhxDhEG0NtIKX7rcnSSReO3rSx43m?=
 =?us-ascii?Q?9HBoi90Yef+cpx5aXLpt+lAKfmCS9KFmJDCjLW/jWG4+HyWxjcjwDvjntWRI?=
 =?us-ascii?Q?LJP3TzUR6Q2S0D9cYvXjVRFhrFNY0yDtq0ICsE8ajv6u0eIIAyjQaQ5NpxUp?=
 =?us-ascii?Q?9lonX2Ie1My+ysGOmXXS1rb7vSrAJsl7pLGMjyqnmkL2TLBJ+fCwbgQGe9G9?=
 =?us-ascii?Q?h3pyXyYvA54Rx86pOiw5lsQEyhJrxDXlUFqYMS0ApmWVQpJvbusbbyILbCBd?=
 =?us-ascii?Q?Q/jqFFBj+pwCQ2sYeCVNdW0tNgQdnzFsdiQ0S1NeLw9qeb5xFvK3dDwzPBgq?=
 =?us-ascii?Q?LQWhRRDr3medtCysitr4s4286PJWMw1G4VmNWI0wx/Daw7lcqLwQg3jIQPId?=
 =?us-ascii?Q?cXKqoeZ9GfQWfOjfyHVm/mjxjo+z6oT+DtYzOaJOm9EIIjJ5XWx4V6vkJKLJ?=
 =?us-ascii?Q?up6CHL6GQp83wjbTQAIvwzny1u+0K2UMdbVm2JeB1MTr1cZ9MQc27YX1HMn/?=
 =?us-ascii?Q?DBmwb3Gj4Vo2/KhguMmBeTirrfF5uo4BnRuIDfoLBoZ2DzdmhtUQD9hgVnh+?=
 =?us-ascii?Q?RoIAKejcKo52fiR+rzpDNF6qxP1Tkkpk0THcZT6PeD5PndiFGlkw7rdvosXM?=
 =?us-ascii?Q?cacElxF7YyA7ZNOR0Lt40oaGoeZjyrohH//5v3S/p+SIbJtHIAMhZy/j0CC/?=
 =?us-ascii?Q?yrGYBHkY13NANnfQYFvGheDlVSh3ylfehTCLdBSzefJis8w3pUE2yaj0GjdZ?=
 =?us-ascii?Q?pOsCW6RooPZ50Eu1IsK23VECxVZMfl6Wsonq1HtSgfC2KbmqGZ1UM1cLlFRs?=
 =?us-ascii?Q?UjgL2sR3PBqGTzESbLtcWV4DDXxz28X3k+2VCJ6vVOAUfKLjoxIWVjhPwhkA?=
 =?us-ascii?Q?HXP8IDKM8umZWeB8qMvQQx7A8drdbniCzRiwe/Ps7Vjq7S1hag1z7DHpQdPR?=
 =?us-ascii?Q?0IEvYAqpFU+jgeKp+wpkfd/oE4iuuzYfRFweryNLQBbPcFgY08tVjS09Q8d7?=
 =?us-ascii?Q?15D85F3BW8vq1v051+u/yDkNpfTbf2YI92JO18M/5pedhVrQEnwTO2GXEqDL?=
 =?us-ascii?Q?pAN/5c9hy3g9AnK3c8AzX3JKuW6cW9Q5vinoRjEIoWkcMLK9HZLoEIGbnSFt?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1d83c9-5c6f-4339-00b6-08db51df93c3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 05:21:30.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCLPAiblMbSN2uaYjKuynnIwHJydmx0CjDyUazIEC1qXYZb+2WZ+mU7SjOdUB2LdPq1v3+Q+pxh6mMP6q31ZQOH8nUDqSwaorWRsUNw/FxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10006
X-Proofpoint-GUID: EDwqLvLmAYaW5GcQKTFa7kROzcwcwh_e
X-Proofpoint-ORIG-GUID: EDwqLvLmAYaW5GcQKTFa7kROzcwcwh_e
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

Currently audit queue full checks are done in multiple places.
Consolidate them into one audit_queue_full().

Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
---
 kernel/audit.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 9bc0b0301198..c15694e1a76b 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -341,6 +341,12 @@ static inline int audit_rate_check(void)
 	return retval;
 }
 
+static inline int audit_queue_full(const struct sk_buff_head *queue)
+{
+	return audit_backlog_limit &&
+	       (skb_queue_len(queue) > audit_backlog_limit);
+}
+
 /**
  * audit_log_lost - conditionally log lost audit message event
  * @message: the message stating reason for lost audit message
@@ -579,8 +585,7 @@ static void kauditd_hold_skb(struct sk_buff *skb, int error)
 	 * record on the retry queue unless it's full, in which case drop it
 	 */
 	if (error == -EAGAIN) {
-		if (!audit_backlog_limit ||
-		    skb_queue_len(&audit_retry_queue) < audit_backlog_limit) {
+		if (!audit_queue_full(&audit_retry_queue)) {
 			skb_queue_tail(&audit_retry_queue, skb);
 			return;
 		}
@@ -589,8 +594,7 @@ static void kauditd_hold_skb(struct sk_buff *skb, int error)
 	}
 
 	/* if we have room in the hold queue, queue the message */
-	if (!audit_backlog_limit ||
-	    skb_queue_len(&audit_hold_queue) < audit_backlog_limit) {
+	if (!audit_queue_full(&audit_hold_queue)) {
 		skb_queue_tail(&audit_hold_queue, skb);
 		return;
 	}
@@ -613,8 +617,7 @@ static void kauditd_hold_skb(struct sk_buff *skb, int error)
  */
 static void kauditd_retry_skb(struct sk_buff *skb, __always_unused int error)
 {
-	if (!audit_backlog_limit ||
-	    skb_queue_len(&audit_retry_queue) < audit_backlog_limit) {
+	if (!audit_queue_full(&audit_retry_queue)) {
 		skb_queue_tail(&audit_retry_queue, skb);
 		return;
 	}
@@ -1564,8 +1567,7 @@ static void audit_receive(struct sk_buff  *skb)
 	audit_ctl_unlock();
 
 	/* can't block with the ctrl lock, so penalize the sender now */
-	if (audit_backlog_limit &&
-	    (skb_queue_len(&audit_queue) > audit_backlog_limit)) {
+	if (audit_queue_full(&audit_queue)) {
 		DECLARE_WAITQUEUE(wait, current);
 
 		/* wake kauditd to try and flush the queue */
@@ -1866,8 +1868,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 	if (!(auditd_test_task(current) || audit_ctl_owner_current())) {
 		long stime = audit_backlog_wait_time;
 
-		while (audit_backlog_limit &&
-		       (skb_queue_len(&audit_queue) > audit_backlog_limit)) {
+		while (audit_queue_full(&audit_queue)) {
 			/* wake kauditd to try and flush the queue */
 			wake_up_interruptible(&kauditd_wait);
 
-- 
2.40.0

