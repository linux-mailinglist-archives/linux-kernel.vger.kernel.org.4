Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FB76C0020
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 09:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjCSIni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 04:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCSInf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 04:43:35 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B002252A6;
        Sun, 19 Mar 2023 01:42:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYqkh6JgdJdfkS1T2Txg0RCOc/YPsA5SfaCviQtKoGRPiLPGJk99PThdmdNQHTloUik8CtCnh/cEqnO5B+PfeOwq7ltMN9vb5OmParfjgw9KErJHfHQjHh+DUOjvdT5DCKzlPkEg0u9Xgk3E7mQ7jNF5W9ODgfVOdO+Tyzv2hMkszn0bzpe4T2jXwDeadtTHUiT0TIj3YF7gKQp94hhBPHx4s/KWkrQZ8cDtoUpDbte0igGKQHdwhuDNJeIT8rpLeKWPFqc2TQa7157V9DX8XGAr8sQdXCS2bsFTRrmRF9PxCzHcu2cdijnl/MNPgAuYDtZfXiMjsMaAkrIeTsP/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cChoitUiIc7ttW7uWFlm2vga0tLO+9+UHdJAAvZFHvM=;
 b=kQhsZsFbZccJ+AzyDHdxJ8n088gHo6xI+6cbyT2TTVGOZmMbTOU4ALs2gQMEE0DaG/DHHUd3Rn/dmC+HqsIbJT9oAgyY3zrhoq112xBvzB8H1ngSZZ+nkdHqTiNfgd6lpUadFsc4fzR1Da0MPQGRcF12f8lP24uMjt4127waVzNc86yvMTyE88KE0qF9A/oDRKljE3nabg0FT/09WlQ23fXHvhU9obNrWS0nedECjJYFvQ04jABy05b1VMgFyl9J365GAO19KeWQcxlDOd1N84Qonwhvp+61Bp3enavnzWSLczzVg6gRCrk5epXXkxltOtQsbniporJUaeiUTk3Brw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cChoitUiIc7ttW7uWFlm2vga0tLO+9+UHdJAAvZFHvM=;
 b=E27KLRg1vYqXBeNlHnnsKgM0JBaVJSmjAfOD0IVf5RHuVkWska+N1SOFrEz3mQdV7lASzjwEZlwSAUWBM5vrs2q+G9Yq/ljWpqaAzqDsJC8+7uD1TXim8UOkcpBOMHITFY8eF51SO53bN0LM0uEjTAZo6HTJL3eu2s/e0cfvf1yUe1p03M/LbPEbDk0C47HVhQaONYx89XjXQHg7Mql3UJ7xnIcx4o7VcYnFMl6lwB2qFRe6sHj+IUhZ94Lu2+Sxf0zzqGt2PlHi+c8ukhG5PVvpug5omqgVEpfI44W8e4rpmHOW/bC2jDrMe2oPLi+30jdryjvU6kcKkETcgwPvHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5350.apcprd06.prod.outlook.com (2603:1096:101:6a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 08:42:11 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 08:42:11 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-nilfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/10] nilfs2: convert to kobject_del_and_put()
Date:   Sun, 19 Mar 2023 16:41:33 +0800
Message-Id: <20230319084134.11804-10-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319084134.11804-1-frank.li@vivo.com>
References: <20230319084134.11804-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: 0883deff-80a3-4d5a-21b1-08db2855d4aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9tQJ6TyvK3AiKHSk3Dzc2aQ8Rg+LVOvteoyn2hKAMQt/Nt5G28c6njLYbnJJccrw7hkBZvnk8A6JkL+SdeT1dPhdaTjsh299mBUABN8T9p1aBmlX2kDaGgKLpJsnGRifvwMWz859BzZDiG03chQTI1Rn4sX4gvllUJzDaHXqpjBN/kfZ5Lf3zCFb+QUILNTzLMg9dD04s3b7wThEiDmTLNxmJVhNBSmgRAmg1mforF0/uo/mGG74B8t4bybustsJT9UB3S0vCu8MHVf3iKXWntnqF3v6F9yov14f9TPka+PDZKMigzyVhU8mvzcxCbTCka+jL5+G3jZldJE8FAqh9aEz/ubowamc9tf8vRGISzy1RJID5Aa1cWVdLzLL9nuGKPGo/pGD9QM1hfhu4GOCCWFnR2RDiwzegOCc/B5LqIxRMrF1LDHtyBZD+C6NoydxK9ATLpLIi1KNoT7uFjGNy9XIyMVhIudzqRtfj+KFhvrJBej/RE1M4Zsgi+MSlZboA4H9/VoiT1OpRcNEltzQuXrorRGmbhYXRLb6Jg8f0G1gGZXUHipMcbTJgi8HCl7UKqJuHgzRDEWggzT9BhXZjOHpJ1zwzDmy7Mtejm/MxclfknlQKQqzm5/oXnHtxxiWqr3Mg7ccjKqNPzhNe+Uy8uGGhcaUQa74EB+w97vBnuWxqk2ozFKpOYFHun9eCXpWSJh9vHWTPPd53tIDnq5GMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(86362001)(36756003)(52116002)(83380400001)(316002)(8676002)(6916009)(4326008)(66476007)(66946007)(66556008)(478600001)(186003)(26005)(1076003)(6512007)(6506007)(2616005)(6486002)(6666004)(38100700002)(38350700002)(8936002)(4744005)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H45Y/t6ZQbRdqBZmmfZcK80JUPFT+Kg9FwJ1HkPKwSD9YVgeLj2VA9cfgjYm?=
 =?us-ascii?Q?61gkodR42qy9gzbUbulWWGRCaM1HoUaR45x3k2cFVL0WRVtX69JrFz+zlDTl?=
 =?us-ascii?Q?cqWTEOMP/5cqGluZraK+UuRkP2j7Azo3Zi46IP3a04XtPARx+cTbcRtdu6iM?=
 =?us-ascii?Q?r1nmKUYXWo9DZ8A0+XZOmpUDkcZOsfGB3H0ZXEddWBhRzUmV/3AIt5uVWBoh?=
 =?us-ascii?Q?jBfLIqql/HJmESw5/U5TYZl7dx7eGe+yHY2i8NZJrmb+oNLgfwTRTZiHhaZq?=
 =?us-ascii?Q?a+dr2D43ubhkZJWJuDuxqQPryiOzrecclBG96jF93h3Ef0VBcEkPzwuLQ4HA?=
 =?us-ascii?Q?upxjgidgFjMnse9rj4Ll+QT5OMdefD7wPD6SrXNGCAosYLFuX/dN+HV00/b8?=
 =?us-ascii?Q?fkxx0JBZvCZoPi5pepRG1AW0gFoKOZwRVK8I9wFNOdZWXADZ2CiwjEzli1JN?=
 =?us-ascii?Q?Q7AExpaivuknyNNJlfO4oiamOJ9PbUS02g9s+EonrtTNqlhKpBtGgydkbYoc?=
 =?us-ascii?Q?+SvazuonEQwmwqpGe/K4MjMzYX9pYZl1Fe5iDxyRLcWMMTwS0JBJOR0luKXB?=
 =?us-ascii?Q?eAjrhkgmKi2NGg64UZP8B7p/3ZPZUxKJTOFrSxoOuJAYfaS0wPnUB6t2ywuO?=
 =?us-ascii?Q?WrMF1lcRTus8f9I9lGMZG+v4G0e6pONrcri/cM+c5lWwwkSpZuWUDUeqvUbH?=
 =?us-ascii?Q?VXutNCozOzr8sBQXClLDMG0GVlT+Fk0kcj8Pg55wr/9JB7VThVCjg575fq5i?=
 =?us-ascii?Q?88eyQAKp02mZ75wph+LiLSnFWmnLL5jpWQiwmA1YajKnLLS7Nthv5OsEWuCQ?=
 =?us-ascii?Q?nIiENGmrfeMQpR3sbDLU2yD0U4SbeWwu0FH8IaeSTQeuz/y09bMCljkU7kIV?=
 =?us-ascii?Q?IDA8bm5+poWFSPlf/dA3NxX7AA93fCNmUmhjLjND0OSeli59Ex+bC4kagJNM?=
 =?us-ascii?Q?9/adLSlkODLva16nm1A3oXOMbxnF2woi3Vacr4fShCO+IBYQCljJgq+O7KOH?=
 =?us-ascii?Q?XZtaJ2lUKfSJsYZp/dLkcak9vibbIyXKHFdBA3k04V0TvmUd0HTS23JH79nN?=
 =?us-ascii?Q?FCTqwMHaYJjWyiisgRo3AuKxuVUQ2sjE40bKvivSj3OskPFOgrpNkUKJcMdV?=
 =?us-ascii?Q?NUSj5o456G7NczCCY7zpi5ycSCK7S2pPMcBLC0lOgMzAw39VmLdeL4DQg63r?=
 =?us-ascii?Q?VPhNhFQ4aLtbigIYnm8VtWzojW0dfApfSx6e9P+LieFntLrj834L+rxs2OjQ?=
 =?us-ascii?Q?HrjqiyzGLmGD/XZIpv4x5pyg5etA1qhz5rPKMnY39NfN/HWGH0hnsNepAHy2?=
 =?us-ascii?Q?Rm2OCfFjPTtZwKq0klkUxz17DOdZRLQgJ25mf2hT1McjOsXC+SYTWMXKvg+i?=
 =?us-ascii?Q?KPnPMTaezv97db6IMAd2+yW94ltFu572jlGEreS8awrcIjL+nWdch2X3aRvz?=
 =?us-ascii?Q?Fj42YYJ191jLr8U1ZxfcDfnMNy3J/emGzGK7JW2MSn65L7ybzpOcsrVN2aE3?=
 =?us-ascii?Q?+XxhAnUf4bIrMJ1HwNV9XDhgYe7bMgw5deshaJNeFNiBA+6VI6hZfafT+atK?=
 =?us-ascii?Q?VMQpd+rlZtO/ZQfYlMvr1A2/qYaHIOzrlBKUm7J+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0883deff-80a3-4d5a-21b1-08db2855d4aa
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 08:42:10.9869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHCBz4j9iikHHooq1EjijmaCVEFoMrJJVjVTCjO/TR4ZUxNYmmUTHsjRxZ3VN12gsVgrRZvQNIspolLC+fKAjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/nilfs2/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 379d22e28ed6..150965d58ca5 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -1042,8 +1042,7 @@ void nilfs_sysfs_delete_device_group(struct the_nilfs *nilfs)
 	nilfs_sysfs_delete_segments_group(nilfs);
 	nilfs_sysfs_delete_superblock_group(nilfs);
 	nilfs_sysfs_delete_segctor_group(nilfs);
-	kobject_del(&nilfs->ns_dev_kobj);
-	kobject_put(&nilfs->ns_dev_kobj);
+	kobject_del_and_put(&nilfs->ns_dev_kobj);
 	kfree(nilfs->ns_dev_subgroups);
 }
 
-- 
2.35.1

