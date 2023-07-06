Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA180749E77
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjGFODc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjGFOD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:03:28 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2118.outbound.protection.outlook.com [40.107.215.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7B419A0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvODhhXKqXLgMFCtIm2O7ZibEdPwRDjeEBAciZ2BBOFzILZmHIFVxHErecIQkCHpTlLw7UZyxP6OwKiOGSQDhP6kd0tVsppD1u8GH79KYA6FKixGopNCZ1BfHBX2zj+2xHiizhJ/SATq/0gZ7NVp4Q7w/6O6ZczE6HW9DPCAoxXJCgE2kXE9J78QwH2jVWQguVaxSMIgqh92VFizs2RJhBADR8ykeLnXhrNU5kilyMq5mnMDodLMCqEA3BiCb+DhyIPyHNfKwsW/sOukpYwHCYwcCxNzr/tcOzgAqRNp5wr0vU0rHHRuUz0Nbd1ylJj+FHhq7MM26AkJmqtjelmWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPMlWVyU7kH0M6HLSeyhEe6t7d+ACyNcNHb3sH95h5c=;
 b=dZRwLfO6vX+q5aLaztv+7dGP5+0e47STBU1lFk2OZovw/w+lH2c3zKIx5KoCsU6m1TR5wH1M2YlnGkkxvWblab0qMJfn8x/xbYHKBeu2WqEjI8TweRHBzgZve/UPJPSAq+o9S94GrDxSaLHgRFrmmOO1aNX6fMqtUP6ZUnyjla5SCEpXsjRrqelYR706mm6Du007EgmG1lFomR5QKHIxx1sF3RpkmuYXgvcNr/+MxOUMvG1qMVcAgkwgIAzb7sOnZtNYBcDYS8XfFZjlhHuQvnjO+QEz8rJt484rRPr9hQm1zc1MLhwOkznL4uXZGyv4QgeGtt40SJN2eTgIfylEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPMlWVyU7kH0M6HLSeyhEe6t7d+ACyNcNHb3sH95h5c=;
 b=ZjV8NbNGO8FspPWKQZGYqY7N2pb2NGtoWUz+XOSP2H0xnGjO5M2+RhntaqTHmfkIb7zT4DCQupkpXDX7FsN56BTgruvQpNb5Kj2LCazdeHPSVh4TwlO+yd6vtN/QS3zFlpuEGpaKjHVweZliTBnshIEL5p9/USQNCo2bwMNKxzAwF72tbtJBe/zCnb640pgkV0yWyIYufaRw5uGT8516IMB9m68SleBT17fNpaz1KQ0TyxsGOddOb1ERpcL0R4eg3AwQNlSDCpaGx6/GCOm3LNo+e8ofSQe/fUyah5eDDGxd0wvjKMJK8CrGe9AhoXBoq2ld3UorlgFpk3YcaPjhWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SEYPR06MB6453.apcprd06.prod.outlook.com (2603:1096:101:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 14:03:23 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 14:03:23 +0000
From:   Wang Ming <machel@vivo.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] lib:Remove repeated initialization
Date:   Thu,  6 Jul 2023 22:03:01 +0800
Message-Id: <20230706140314.9999-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0252.apcprd06.prod.outlook.com
 (2603:1096:4:ac::36) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|SEYPR06MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: e48b4a03-55c6-42f4-00b7-08db7e29c2ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxrzWG5MrsMxT2zT2WIdCgQCMwek03Nf6DKWcRptBJzdh2dwquNQbtKdRZsrQ+284l7OWXxy0mVStSrnYhY6pZ5l/iSGvHcMD268fzY0fyyT4edlJPpI1cmg8cQbAg1t65UqGvjQEYDEHviiDVt//NBd4NjSC1bGhDxIAkdR+axQ72oMNOhnhSY4RiApgWvf5wwucY9Ltmpb/Hl9bC3b5r9KLJFMkhP6AUyn5DbMUWHoH6RSrUvSOHNPcFwAtO04LITI3r37lo6jb6v8SJkX9100z4qv6X7EuQfPGHxCyt1YHyqMYr80Y04Cad+Q/y8V8+H2HQ7TXZhILSFeHhGHcUrJu/xv1t+7eCeGzffZvBPJPcVHMjvOCqD8KA3tsll/2OjRvl1/CXMlNUc/wcEHNFmrJadbdattyneGt5+dXdR+QZ2e8S2k5L0bu9N7MEQ9K8PW748mTiQXRtEZcV0MGd6gpc1aqH/bmHJiAY3Svvg7zpLmIOSU0T29NhND2eWPPke9c0gOE8ejZ3S2W6AhNy/A5pQOEqNtCjJUmaNkJ/TOKAxsvnRKzm8tjwbkwLSAOpMlRHwNm773/k4nSaBWiaFGUWBg7hl/SXrtY9B8tDerTByPp1vPUU8rXPjs6RAr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199021)(52116002)(6666004)(478600001)(6486002)(2616005)(83380400001)(86362001)(36756003)(4744005)(2906002)(186003)(1076003)(26005)(107886003)(6512007)(6506007)(41300700001)(38350700002)(38100700002)(66946007)(66556008)(4326008)(316002)(8936002)(8676002)(5660300002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lg0XXpajDBvQQIQ+5xacODrzu/jaRzp8a786ex6TG3/F5J6OLTVi0yo9KSYP?=
 =?us-ascii?Q?vkJHdusXUq7mXUU9nDjHk26EGc2Cl/ZcTO4dkePKQk8IY47aEjYLJ+cBsbBk?=
 =?us-ascii?Q?3np8JprZX6M8TOSd3CJRUeLD6RHmykE/BwrEb7zf2pAB7S9u2lzhCEItJKzD?=
 =?us-ascii?Q?BzZSP9JaWjojLRHk+qTSmAmU2WilB91r3SYDP2yPukZrTWM64m5Kr0SV5jGy?=
 =?us-ascii?Q?9zmEt3UkPULCW4wSgYsvS7+LAhhfOuo51frfq6W4MWEJSXFQ3x92BvPaqxZM?=
 =?us-ascii?Q?GuwB5EEPntB89RZ3mnCCJnyP0p/4h25gFPtQ4uNJOI1Kel6HWAbRNZ7XxFCW?=
 =?us-ascii?Q?vmcBeT1t0YzTvPpEmRBcd4YIJC3xSXQ5L0OJ6g+YpNwfH+Es9xgKR2KcuXMc?=
 =?us-ascii?Q?SQFMbmRnoPzh8uZjnyiQ0dftXU3T8A7lHacZHFCCeWB3XQUDUNUYj1McWJqP?=
 =?us-ascii?Q?XrjGAg/uaxFNJ/PhM30heYriZU4J64iWSyak+vWbOYHkqqZjHKKx1OoBfPE9?=
 =?us-ascii?Q?XC/526SEr3sqOhb+pqX7OqBMx3k34V6Uh0hjo4ApyeTHb76bbsQPTqXzM2e1?=
 =?us-ascii?Q?SxYltts1uTqd4fckn1JtCbugyM3UuDlmzcj3JFhmHQyHxxSEem4VhJdS7Iux?=
 =?us-ascii?Q?vE1tvy2LcFOK2u++4x6iNZZJ5eVyaEwePmm9W3zi5vxDNbzl+ULjCCrx29vq?=
 =?us-ascii?Q?jqL++ln8ptm86341wIdUTblp2bmDul7CCAbghOYLkakdbwaj+IhC7vZAOJKS?=
 =?us-ascii?Q?k7gZ7/ELPGBCPdTIeVi+bVTeHVf7obww9lMxSElTFB5kZVhEbq7E0xTzEWCw?=
 =?us-ascii?Q?jDx+HNwpQ6q33Ybjftk66GyaHG4GRxP6/77tX6+ep0XYacPH/x6eUgo5hSli?=
 =?us-ascii?Q?KM+mthgvb/5Nj7ZkLqNYcVGWXv7UbXa2cIoRon2mBGSznP3n4b3+bns0Od45?=
 =?us-ascii?Q?ERrVnJ+A67U5L1tUVowdupwRuT5bzOg0ECep1rGiJ3VndFyrG+Vuh2duLYYg?=
 =?us-ascii?Q?TIZY5/6McRDJZWxSaRRnou9jkFTjQUmjGyzavvC1myemQ/3PKGXOBUBiOBWG?=
 =?us-ascii?Q?vVgL+OQaPQlPQ+G0yHt3sKnpKK8PHoAW6ITitYqAh2mV3RHNTd00uuSuXzWL?=
 =?us-ascii?Q?/k4P4T7JbBIFVGfDmrGJIS3OVPGqs4KtQLGqsmS1/6LELr09RvWJ9v8ipUr9?=
 =?us-ascii?Q?VmCIdbTlsgcg9Vy1RWgJ1Vu2ladihR/mY7vUMmL8lWnUGZts7hTW6Xlxh7qt?=
 =?us-ascii?Q?17Vlf2GAzQzDMQL/MQle7q5BdxK+Zl8Ko/8XXevpD/Zm/x/Ead6KuQwmS9Hm?=
 =?us-ascii?Q?uDkXtxiI2wtRlCToKzv8rir56nCeiTjbqRXq9cO3aJJrXvO6zYCaVssuF4Yv?=
 =?us-ascii?Q?3LqUy1XBBHTuqSNS5eTdh/mXJMjrLZsW7RzkTSwKBTABG8UeCwtFndrdpSw+?=
 =?us-ascii?Q?iyir9x2CoNT95J/SWLWWcXHmQTpWrtpYnIMnFLzW07pn9i8V0g8eqV1HP0w8?=
 =?us-ascii?Q?TO5m/6Apoqxs/6YLqBAPrjr89/v2kMxEBso5kTEpTL/dEhLxUkKB99Kevl7z?=
 =?us-ascii?Q?K/qwGG8ytql0Df5cPD+twQHZuBTINUbYP55QgNTB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48b4a03-55c6-42f4-00b7-08db7e29c2ab
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 14:03:22.9527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ha5bJRfK0VU5Wsu/TtGNx9tQAQq9A1uwfBrdfUbDXqSWatGNJFUzLhChmGJXsh/qpeluTYl3RnnWJVtrCvzwIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original code initializes 'entry' 
twice in line 3229 and 3232, which 
causes duplicate initialization issue.
To fix this, we remove the initialization
of 'entry' in line 3229.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 lib/test_maple_tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 9f60e0c4cc8c..2ec14c310dad 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -3226,7 +3226,6 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 
 	/* next: none -> active, skip value at location */
 	mas_set(&mas, 0);
-	entry = mas_next(&mas, ULONG_MAX);
 	mas.node = MAS_NONE;
 	mas.offset = 0;
 	entry = mas_next(&mas, ULONG_MAX);
-- 
2.25.1

