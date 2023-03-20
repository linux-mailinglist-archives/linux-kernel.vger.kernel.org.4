Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEBA6C208A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjCTS5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCTS4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:56:47 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA6D366B3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw6NAuMazjgG+pnIUPhBJZaXKI53zbIc8coOpaeUSrUVhSa5GnWzAFUbiVNsv4dntS+PFR1JhefIqvEU6pYI0QGQ93dp3Rwga2jsdBJ7ukKaojMmxMs+oGbkJOeB4XUC8UIa+bOWKHizpGum/hGzWVD2Gh6vao2PmKs//VmE+DjdTctngIcQYciIn4GWZA2w7/2V+ORZYHhRKCrch4agbd/SlO8XzLWHswO0duN1P8fcifuw30olW8HkOxvxM8+vXe9Z4RvT4dMkIjX2NJHZitqpdkbwWZZpI/32F+mfZg4GhBoAhQ2U/ogSX0F3EQO8Bshfn+yRrMI1ufn0LcYp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNtRww3+WurnR/ssb+TOIf0NNF1vkQf8qeCiNRBrFJo=;
 b=gstabiD1ePKHrMRSO17DM1ZuhX6Sl76pgepb/2RyZZqklYl4PP8/UlfjN9hrhub1w7jJE03M2fRlLeQ8UK/k+/yaBWUf2kHDPxZBIYgFxWYIqZ1HvwC6y0nfO77EphAgmgjHmuYhVZ6bqf2UeN3f+G8m4fhw8LLkbcmEjCTtFrJH/I+55rF/9XB3s+0z0tLTyUotcIZ+Wj+9IjTAx0YVffRj5RWuHgVsF4d3lNj5e88MLRyN8eCA3l/pxJWeZLaTXOYb7DP6HFsSCs6SQh25nQx7N9tBPyB9yc9H+Q5Kky5Wlb+vgQFNTXwg20RTGkSyNgm4lUoZoIfHO+iPtyv3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNtRww3+WurnR/ssb+TOIf0NNF1vkQf8qeCiNRBrFJo=;
 b=aBATDY5Vo3vpDuXkqimotq9ggiIvP1OGInZNLcfyPUBAsRdU0W+gMB8WCl51ZlLssRFDfOkAfkIoQIzYX0blXKcH+wJXG0lkx3HJJHRDcToOFO1UAKR5FudUNnFfpTy/vHodnh6aTSO5rICWrWQmk9rs+vJBi4MVSVuq2dK6ieGc3Gojfm4BQhPzw0iDJ0JldtkKHZGQ9zr8oUdRyrCgSJPYoOPCS60zyGAAnV+94w8Frhl2+oZD2CnGoznQ7LhHTwouhNDTWp54lPlrebDi/pBO2NrSyGJwN1Gn7nSB7TIkA6pzbicgwCCvTj1B03tQe0IORiX3bwCGvuyCQ9Pgmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4121.apcprd06.prod.outlook.com (2603:1096:4:fe::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Mon, 20 Mar 2023 18:48:00 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 18:48:00 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [RESEND,PATCH v2 08/10] ocfs2: convert to kobject_del_and_put()
Date:   Tue, 21 Mar 2023 02:47:27 +0800
Message-Id: <20230320184730.56475-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230320184730.56475-1-frank.li@vivo.com>
References: <20230320184730.56475-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 63eceeff-0fc2-410b-745b-08db2973a0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fybil4OFEqy3zdSH/6jQHXx9vBcTAX7fZTM3qTpdn+GiNnsJ3W6NRcyk+xFawmnFv4M3eiTAY9V/LyAa9lpmAaiDvvTvGBXAzvrg1BO5TZP5dw75ZpZKwI+CUDNsePVpkAXzimqHp2KqnRdLHem3vG5h4EWWU8ESN2AENA/t1vYTFq/pL0m9NWVSQ8lmkPO4c3kPt0Bq0XR1zf6Dc4hUsY86qFlq9ZDilCTtDaD9s4Jq/VovgT1P/dflc/bRr5ChztybqgmVqp+Gett2+tIQRaPbASsGERVjGQn58s0yLlPMUFA7gBi/WF51GBNiVFaB26sC7Ha6vjuYO7d0IUb89lDKGgzHjF8E7TX6jd2JOjI5ow9l/DjM7b3Hzj69KClrLXzWPkW3TRTNS8UQB6/cpKdmzisD1IlLE1Z0MHa9RWVlrGz3MsuzuaOAu7sR1PKIcmTwfU3kYKuaHrjKrS4azyKdPnEpjIO9QaYj4P/j9EQETm9MMCV1nUrJb5AJVkEtVBGrGR3XfnArcPQPElk8jxJbF//6cOB0SCjtQXxLOotU66hjELsK4HxtqzRPp4QN97QJfNYc5jLbEolP6rForyxxQMCLBJuQrtf/4dpIpdILgQlR4saJCS9GmlZCMGvUL203fdLQWEgVlsFNLLVd4raBYaHPIu1GQTESX8cU/afG5u7ksPzzxbVUYXJiJXccsayyz8eTSl/DQpNZK0KZbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(86362001)(36756003)(52116002)(316002)(4326008)(83380400001)(66946007)(478600001)(66556008)(110136005)(54906003)(8676002)(186003)(66476007)(6486002)(26005)(6506007)(6512007)(2616005)(6666004)(1076003)(38350700002)(38100700002)(5660300002)(4744005)(8936002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ABatkFZpoQ8IdTUB4eOk5L1vYjpCBHQ5Fly6zDZX55+0KjR8exjk5LP+nnmH?=
 =?us-ascii?Q?YIOw4RCu4kFOkB2LMsJXvcbHKyL1DwSSewp3sEieaQkSIoezgsecNN9MFXek?=
 =?us-ascii?Q?/zvj99rzovFXF39O7QIgvR3EyLRE6sQZjUUZ6cwFtqbWI5eAJuJ37vq2mtTO?=
 =?us-ascii?Q?jmNjVTBq7yTIC/SQ5LYStxnpubLAhees+HKPyO+svDaoL0PHqgJj5kKhZ9Ic?=
 =?us-ascii?Q?QstJJ/3jSeo3dXK0p1GxZJwkToCVd2tBDqGmS67tWYeGl46QqYTczKX7fUMe?=
 =?us-ascii?Q?Y9oYYyLzdglkYo6MliWfVWmKrQHLjPJzMUy/f3k+eSfCofxPoEUZh/FpMxMH?=
 =?us-ascii?Q?l2kmPUWww5kvVRxveN5S89viJEBtn4Afg+y8VGKKDr+zILnnOXVvS6l8iyrk?=
 =?us-ascii?Q?npHreH4C6PNTtYwWiti/gmUM0lMyeT6btAJiyL4V4XMxN9ZSYPCjMDMpa6hV?=
 =?us-ascii?Q?uU1+TVSiqJTC5R97EH6ZcBrR8uE2FK05/F5Cj4ChQn797Ymv5FgpYGgjs4MH?=
 =?us-ascii?Q?Hm+GbqDwfwy37GZ+hDvmP911MCiuRkWOnjAZsplXih7CyRfh+ycm78ZziV5M?=
 =?us-ascii?Q?3EhT8oNjPv4sINVhStmoN7BN5o/LyqLFUsa+/MfVKf1yRtCwfispXry0TVMP?=
 =?us-ascii?Q?QvfYOpoFjoChKHv1FiDfyyNeLqaoVxmwMc8vSMF/CADl7W9qAQcQvI/Za4ZC?=
 =?us-ascii?Q?AWsXrqp6lkdzD27yVct5bP6MwxmJ+Egp2uf7pT6D3LpMfvJYmf4gJnXUGlGx?=
 =?us-ascii?Q?BqfEdV2pMYVS9i9N7B3ZEdZAywI7u32pDMCZf8Iyt3mAY1IZ/ZiiEG593C9W?=
 =?us-ascii?Q?qtiI7IwwFunkR7tGxKnYBHFTN6ffPUavTl5JiVJswFDnLHuYNT94dErLfCzd?=
 =?us-ascii?Q?7d+SdwTGda6L9uhj+SU4BUTKcV0/xUPeTdp1V1ez3pyor2TVU7+sDEcHwzKn?=
 =?us-ascii?Q?Kv/mpL+8g1iqbZd+yg5GeaZiU7G9VFuvHK3SisS3CNchSY1jAP8T7mCX+Qt4?=
 =?us-ascii?Q?v9o/bvmId9aDBK8MYBpntcgxzSfowd6zc/uDa/aWR7259mojIUBJPEoHIJ/n?=
 =?us-ascii?Q?kxLssDHUgc/tNin0cQAI4fn+5pQC7+van9XCdTxwao2dVd1PUQPWTRtHcHxO?=
 =?us-ascii?Q?7SwH8crEFZPmiZeCksc85ontkZpSN+Qf3xX5wwIMKDqpdQo5gdl+r+LE28KT?=
 =?us-ascii?Q?4loGfSxAKRzRpErsCxPA1kt3Ivjm+3SlTBd8+CaTlih+osKMgbfVI7ykSQpE?=
 =?us-ascii?Q?btt/cfKHUYTeR7fZfhMOF6rFdexDuJi5rxBT1Wf6X7JeN+Rn87rV4FJzSFgx?=
 =?us-ascii?Q?APXWKAVr9uIOcJb0owGaMRryFR5ZiIDGAOc4aP5x51o9pLJmK35MIMyGGmDV?=
 =?us-ascii?Q?BTWcgnnX9g8urRMVUtsS7AshaYkQly2SOYBMEiqsIg9QaC1fvPkfmzEP5MMZ?=
 =?us-ascii?Q?wpNFAyf08jpksNimWYOx/fQg4jH/6V3N79wf4mY/R66jcSu01JgM16ckwKK1?=
 =?us-ascii?Q?UmSm8E5RazleI/Mwdvu4LLXMV+RSyClvf8JgfpnQD5Ih8v708lQwN8ZKItWw?=
 =?us-ascii?Q?2iHJgO1Oi9sUJ87bBsdeL/fc5Gq4dZaCoNEA8ajt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63eceeff-0fc2-410b-745b-08db2973a0ec
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:48:00.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahDJeqPPStJH+6UOapanRMUCIqPoirXWDkKmXi5kbzwvOgOzZtcw9ns34UE9qAq0umexX9XXuupALxfY3UncZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4121
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/ocfs2/filecheck.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/filecheck.c b/fs/ocfs2/filecheck.c
index 1ad7106741f8..fb9cf601245b 100644
--- a/fs/ocfs2/filecheck.c
+++ b/fs/ocfs2/filecheck.c
@@ -198,8 +198,7 @@ void ocfs2_filecheck_remove_sysfs(struct ocfs2_super *osb)
 	if (!osb->osb_fc_ent.fs_fcheck)
 		return;
 
-	kobject_del(&osb->osb_fc_ent.fs_kobj);
-	kobject_put(&osb->osb_fc_ent.fs_kobj);
+	kobject_del_and_put(&osb->osb_fc_ent.fs_kobj);
 	wait_for_completion(&osb->osb_fc_ent.fs_kobj_unregister);
 	ocfs2_filecheck_sysfs_free(&osb->osb_fc_ent);
 }
-- 
2.35.1

