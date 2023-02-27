Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6416A4157
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 13:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjB0MCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 07:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjB0MCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 07:02:33 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2121.outbound.protection.outlook.com [40.107.255.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA3C1633D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 04:02:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7BYsZBIhSPOTgvY7lqW2RlMWu7KmDRZgL1O4TP/VunvtEgi1tqojIs9zjKZyTdTPrBFWz9OeanzCbzFCVwJQinZKBNQ9xLbsrNx40Hyqw0151pSnXOYocuI5dAHk8X18CSNDklpvoljOI2dXZZcDvc0tm/adghpXhPlBER2ha2VqyW8oX53esZgzsu31XzGHld3SM4YaRqxu5u8W5NS9dRVxhXSiR/5OgELB4ltV7/MyIirqmvAt4vsKUE+UtUi3oVKpVW2ZXNAguiMVls41S5M6GUe9XCiqSmRjiWckX4jPss5uZQ5Pm3NmA1S+VjJt0FXqFj2GDr0KagESyE35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQtaz4aQV69kpUr/6zrDopdjPrmWDadZ7rpWz2CL5KI=;
 b=h+DJr6kxXvqHV1Mxeo5DT313REW9VKJ0FuD+OwXQ6Q3ofOvYr72fmRa0l2e1wKIPtBUFrggMyrvZvGq27pzJIjjSeIPifchIBaQfVHV/Ztbz+AEhkw4D/yIbuMQhv9wvoUW08SmNUuMtWs+YgOR1FrWcR5hN1l2I5YB/6HGlnyJ03kQnm9Mr0ZMCDyG37k7JSxI/8ucbmHSDXwu/GOYbyGFrQ8OMuCj2+T+RO7ygc/MRIufvyVQcyG3CeZIJTl+xbTPNA5dDdegwmrfhaPSPmz9JaAjwNmft7zhMGWvXfZ/SHeK40Sim5UfZXa9ZONnFxfnv22mQKlc5iaUoSPiEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQtaz4aQV69kpUr/6zrDopdjPrmWDadZ7rpWz2CL5KI=;
 b=oWzIgscNySXSqhxAMJZdkGrzk6dLyiHUkAR0VaTFt88RXhtFSPWwDL9YxYGgdiZzUKGbzEcUspt6bbXbZJcX+muXTwvg2Lmp8JCZOLH8X2GzHyf8v9PCZ4syOyCwSDNsjoAeIMidi9lEld8AgizogtW4/VPpxAmkwymp+ZaeB1moRYqNSViuZQeYyLW1KfI3DPFUOGvAiCsJ9OL+q4FlX5uVdvdOv3F9djzPvpSChdUQS0/Yct/DQKG9AF5iv1HFfIp3NAWXrYo+3M2/e2xb+GMnUB3Ndxk1be4pDAq7E3vzg5qVyCCZZLeNh/2oZVyKIzRKDA2Z/sjGAIx3SAOynA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by KL1PR0601MB5728.apcprd06.prod.outlook.com (2603:1096:820:b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.12; Mon, 27 Feb
 2023 12:02:29 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190%4]) with mapi id 15.20.6134.019; Mon, 27 Feb 2023
 12:02:29 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 2/2] quota: make dquot_set_dqinfo return errors from ->write_info
Date:   Mon, 27 Feb 2023 20:02:16 +0800
Message-Id: <20230227120216.31306-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230227120216.31306-1-frank.li@vivo.com>
References: <20230227120216.31306-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0120.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::24) To TYZPR06MB5275.apcprd06.prod.outlook.com
 (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|KL1PR0601MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf57ca3-5ef8-44d0-1080-08db18ba7ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lj6/8Ir2pryspFNuulSneGNk8vtBUIIsCfFkqGsJSmzn4Wh3iUKV/lTYemGNq6AULEukG3jRqGsICwUWjTu81lIoAON9SuGYpcp3c9dS5vZfz3l32OXEpMtYohRGukgci6OOWROSfh7cgAfsZyzDFntldXCYy3nKdRb+Qe4w+Vl7lBIrPoF06L+O82uQtEViScmX8VYt9h/4C2Bfrq+3Vy91DVOK361ucLCguC7HrcY7LdUBDU+kSxCx+kTBMMcngBU7hprut1nAnqnFzqJIMfeQmfWrPrlMnJvJGqzNKmamLx28f8tRIFW/qEg6m2aUFA0CXnEWSfvjG+QL/uZvc9MwIXYYN1xSYPx/dJLwqJ1FS8SnOXTh3B57AIforbRlo0XEzNFISY4KRoiDHbx5jV5Mk2+7rfOIkTQzDjNn/KZ1y5MCoa8yzt0i8NWl6VpEqJlAdZpp0jotshG6QoU6CJDTZp3J/JM43oGzZYGCm5bD8k6M7bn75QqCZ4oZ9L8WdYeORxNin2g4bRhSs/c+p6o+oRAFeEPfq8NbJJK4XjO1RXvsW+LHAiwuMLTlxeWHNecMWBfNCL59KBaSpp2o5xGHF6/+a1OHYq0kdcbtZvAcRH+dnYPPM+flfCAfzjahoLdP5vMVI6pjkbhPOWRkiPOdEdWHgnKEwmLjSCYDrxMYOcF+pAIYOIOfHCE2RP7H3PQbfDnirC+Fn6iBxLvcAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199018)(6486002)(36756003)(86362001)(186003)(4744005)(8676002)(2906002)(5660300002)(4326008)(66476007)(6916009)(8936002)(15650500001)(41300700001)(66946007)(66556008)(26005)(6512007)(1076003)(478600001)(2616005)(107886003)(6666004)(52116002)(6506007)(38100700002)(83380400001)(38350700002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?03wAuRRTAKn3YyPM+yo6Gq9LtDAWON4VQOm3dBWxGX3Uqff4bCrkVBszSQkr?=
 =?us-ascii?Q?gF7DcNXblqJFeYKhliP7unpQydbAWjuDG3np05KxIDAUxAA8ibx1o9IBCvLW?=
 =?us-ascii?Q?5DB72JwO+cgzj+cN0yhuXDpbOU7l+Tg3YIuxqQXEcL7oDjbEvR4RUujBa9P2?=
 =?us-ascii?Q?x4sufnDl++LOwanrqaSJx/9grjvnv/VyjjnE0vuRkWYA8hlFuULxKAFnfU8U?=
 =?us-ascii?Q?qp6Cpf48/UI6UzkJEF2WUXrMczMWuL8kXIdbf/JPRLmGFc2vOamkce7gLHIp?=
 =?us-ascii?Q?OTq169ay7ximl8MwoEW2fCvDxCmcZ1Si1Z50UI+E/mMwY5mGcswbJLOjPQI+?=
 =?us-ascii?Q?ABIm1qKCznSjZf9w8nEBhsbDw371iBx/puVhpwPSB5wpLpZZcvKDmb5spkPK?=
 =?us-ascii?Q?9DmUqGMEqPmG9fo9VPrmWoJxzrixWxwz77Jr+2evYqfTF4o3XoXh/G0MLlyU?=
 =?us-ascii?Q?FXh9YwvEQxoye1ZLdER18P+PhadAymnpklioKsBkhtBwFGVWTHu4D20IIOCI?=
 =?us-ascii?Q?yw8gaWotx50tBarAdulD57lbGFK0YDrnSBqs33p+8zj+euQ99gJGb2yHTGBC?=
 =?us-ascii?Q?bcHr9X3bkQWClEP8636KEo/T6YCn0Oa/VBhCv4YI4uuYZqonP9vFv/acA4cG?=
 =?us-ascii?Q?4YUQdjLjPkSROuvSksszquoQayGeE1qb/wusnWWYjOz7YQPcUHR2ycasSLXI?=
 =?us-ascii?Q?uMozEeKmSGWfJVV605ttL9nzYL/4PrXfDPm2BZegZoX8nZC5+KzQvq12NYx4?=
 =?us-ascii?Q?uIQasN8SWZahvjMTkm2qNNAMtX72Xu8JBH64sTYZAKILxoGlBeGauAWjsVaV?=
 =?us-ascii?Q?RpVAcv3KzSOxooaSkO0UPZ5w8fUmTICvoFJ2D+J4exIHFCMuELwxHdf2QGdD?=
 =?us-ascii?Q?cpbzGuMSQXvJDJbni5U2PyFFTArPxuZc+3A8wiULaRMjpJtAZnuUuml4V9Ht?=
 =?us-ascii?Q?7EK3qnkik+XI6FdCNn/+9qXHbH2xuEHfLUS58fYPUfXCtqX7GoE8fGdLvl01?=
 =?us-ascii?Q?yEBsekITW0wwosmobZ2qYpe5dORxrOkBk8cwGdx24Ukr9RMjcSaX55Srl/d4?=
 =?us-ascii?Q?DgroUxXOEUYhd4h4v9ywnVu6KCUdkDpggHyxvHa60tgKLDknimXgxVi3f/PQ?=
 =?us-ascii?Q?mIrs2kBghSDu+anbm0ta67s7DwV+/kmSSpFIU47MlbK408fSkSevSaoMlSrK?=
 =?us-ascii?Q?DMI8lvlRzvSvlyozm47cd6yrTB83tDLGNFA8aKnw3MrI0tiHpiCcC72HlOzH?=
 =?us-ascii?Q?ZLuJGOrfFsIdGCIM4T2lw52QDRnIQUZ6fdRfBGhV6KLYr8J9ABDoA5Dbi+3D?=
 =?us-ascii?Q?OyFIBmqcVg1SrllmfgLQm5qbj6vZXmCjB4k0hL/4/LrK/ae6Wc1o6iKTudcz?=
 =?us-ascii?Q?Wj3bEInOWBLSzeNddgKQfUPXiUAEH0eiE+n+d2XPiLQPWEBv9XozVQaopdHj?=
 =?us-ascii?Q?sAaqve8NQ0FgwHxfES6pO0ORpxcKeT5BrjkDmf/KOZQhvr4NCBJvQqBNFHlu?=
 =?us-ascii?Q?4TugHKxgbmzlt7Vg3VGWf7w+nlsOjkbXbrgp1SYOzZKHgeaKtnoq9P5pBb3U?=
 =?us-ascii?Q?oNKRRyAYpSDUlMGfD5913MsBLZiYSUONMYBSuCjX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf57ca3-5ef8-44d0-1080-08db18ba7ff6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 12:02:29.4759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0xic1RM0xYaltKkpZRDX7Dwje+Kl0Pdv4I19esQGp0ZgworYERAj5s5W5S/rwgpEuRakHk7b6VXZ0TTxvoJCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5728
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dquot_set_dqinfo() ignores the return code from the ->write_info
call, which means that quotacalls like Q_SETINFO never see the error.
This doesn't seem right, so fix that.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/quota/dquot.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index f27faf5db554..be702905c74f 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2819,7 +2819,6 @@ EXPORT_SYMBOL(dquot_get_state);
 int dquot_set_dqinfo(struct super_block *sb, int type, struct qc_info *ii)
 {
 	struct mem_dqinfo *mi;
-	int err = 0;
 
 	if ((ii->i_fieldmask & QC_WARNS_MASK) ||
 	    (ii->i_fieldmask & QC_RT_SPC_TIMER))
@@ -2846,8 +2845,7 @@ int dquot_set_dqinfo(struct super_block *sb, int type, struct qc_info *ii)
 	spin_unlock(&dq_data_lock);
 	mark_info_dirty(sb, type);
 	/* Force write to disk */
-	sb->dq_op->write_info(sb, type);
-	return err;
+	return sb->dq_op->write_info(sb, type);
 }
 EXPORT_SYMBOL(dquot_set_dqinfo);
 
-- 
2.25.1

