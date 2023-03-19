Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FD16C001C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 09:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCSIm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 04:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjCSImU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 04:42:20 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A9F23D9D;
        Sun, 19 Mar 2023 01:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kgmv5g1w2aPjUvEynpJJqKK5W+m+yspXsOuwu329qJtlGVjOXCnhiZr2j/kbqKVPVvDFnnSemDzjaucmqx6RrHVdBKQqHSLuyrVBIBzVabbnqY984Pb+S56YO4Ws5H9LUawbUfKGz84RPHLmXfuUJO5rmIlbRtrz78mPv/zucVLhK/e4hnYBEWfjF/17ErjD2ZAp9AmdBKmyClJ7P4PrkX3LShVWqI70tdUGb2ZFH5kIv3zx14e7ScPqGLBYeh/jGYxex/FfCoS7VpGG4Y//KetFLSLy0PzoFHDFmhMBe9rfAg7YDhf5inVdjEDgfCM+7oZqcnNlfp8YMD3u0ix++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKaI6/jSmU8pR7rPuvsD7RTe0xNbOkuXQY/ZAgd1KWY=;
 b=MSLq7IYYmJ7qfcPm0G0gKQ4ZbYF8+N6jJIl4IabRppSvSlX5ZfRcaMNIrECehPxYZGPtgR58Z4R2dYa399HOBkU3n14iL85eSZsUJUnp4T4rwtoI3rKTQW946Wbf2BhvwmloRbATUx3kzaFuWJCDir0S6B5TCoqGHAXAxmK4/5qrVx64O7WBFRx/5UGsEbIr/25mxD6o76Z/x1faNOgE9d5rUkYyM9TS7n5SCyDE6rTqy7TndvILdeobeEuDanhtTrWqlamLO+7Poq+kxxP05Ne0EZ0CpaOZvA52Ngricr22/fAPrOfKgN66zVjvaNqQBD7YWo991vIroMhIhRv7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKaI6/jSmU8pR7rPuvsD7RTe0xNbOkuXQY/ZAgd1KWY=;
 b=aMnbvJaqqPovSAZOv383q4jCbMwxg4wLxZ0idbX1pYscZAOhAn1dG145zYoLAthuIZQydZ+P9wHiBh5A/zBYrPOFjsn+VrUkeR6DmH6CLAa/QMaKoAYdk+XRjWkCG/ugAYelfRmWOLAN+yu7OH1M0tvOBwgy0YrAFGhh1yA/9+IsEs7ljUB/BmnMC2iDTgVeaLhovlUnSZRlKmkFv0BzAbRMUMlaGmEPTWhXK7jNLB4fLSQxtyXhJCiQjz4LRMCHBAF/wbpLvftQNtgyGdNnRdHKK8A8+JINvpFIVdVwClC5O+D9xj/x3uFC1FBQU8qR3oZKNhRTuY6AOJTiRCsUBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5350.apcprd06.prod.outlook.com (2603:1096:101:6a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 08:42:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 08:42:04 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/10] xfs: convert to kobject_del_and_put()
Date:   Sun, 19 Mar 2023 16:41:30 +0800
Message-Id: <20230319084134.11804-7-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 252f679e-ccf3-4d30-3153-08db2855d0e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUgwg3Sm4tuPayojyDdCNhUpdeEs0basQ0yWOaMWO5Hy8IuDOENv1L9NEdsmJ3KZV+OZqrqcwhGsPLZbfd3XfUrBAfklqG9VPvwbbKcH75/N23hhpAr/YGI/MOsw/t73A+6SFIGEPYRPexFGpPC35Kzeu8UQ0BHULykbISlYpQJE1goaR0LM1IlFOxSZx7ZHO3P7/4HJAqxkr46esUJMahtlsnknsfzyw5GP4U+7QGxQ6AI8ax5u9EBX06uWdAa4etG/Nwn2Xtmdd9dXb+FBXg782id5qkXDZ7tBzc16q+xn5fssjQHYsduFT0/BSKf6hJqbrYL7IX1U0am0+wF0xiaRyI3fZGnbrTRHOFkJsCEC9oUgVIz1liLM+rPvX+gh/LhfG0AEdmNcau8DM5B1gQqF76FIROpdqcmpZk91WB9QmhF3ElPQABuHLENwjyLH2k/s7bX9nT2X8OkhDcwzGKCQ6Twqub3KWX+H1B0JtWIvWgKh7X5vXu74/H7ytbld/f7LOh2qSUiQ98U9uqlx/HmyicOeVogu1rEksBje1Jlfyc83PjqWwORpR8ensYyD4KAgIrmsWwi63+7yf/0XgYqBDbSbCQ9x9RyjZNx31qQJ4LpuKDvuwhk71D3mKeVZWPi/lBVH2AK36vgR0GtWteLrEBF4ma2p2FTOzPiBAkRxgWGLn4ywfOMty4cdzsgZctFEN2VAbEdMev6n/aqdAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(86362001)(36756003)(52116002)(83380400001)(316002)(8676002)(6916009)(4326008)(66476007)(66946007)(66556008)(478600001)(186003)(26005)(1076003)(6512007)(6506007)(2616005)(6486002)(6666004)(38100700002)(38350700002)(8936002)(4744005)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+dIJUrGJt02MKge/82PKlYM+heyKjDK6ltlucEmUlhKl5nIT/kZKHZcRKY81?=
 =?us-ascii?Q?E6pdGIuAry/SnK8cje0CpCEu8IlWn2DQ6w/tio/PVg5yn5HejhEwh5cJwpse?=
 =?us-ascii?Q?RY1GTQpEueyRzIGO/DosKJxZepLCM747cox76xqg6xNPG0HYQSEKsW7YDFAU?=
 =?us-ascii?Q?0/2yXmkoq+sQI8o9SGecql2jgt6OLK4LI7V++w1w53GzTD9zg1U71qepWFxb?=
 =?us-ascii?Q?ravsQ8mgxvklk2n70O70I+pytAnGtd3O7/vS6u0CkzvmRPU9RAyix+Mc78mr?=
 =?us-ascii?Q?T/3ULXYYeoa7rmFByDW8RlvlNqjL9tmQ3121BuNFHPKirGPX00bCE3GL8Nlx?=
 =?us-ascii?Q?4nZDmjywJZV+HT+7CpNp+WyWXSQVAKojDR6UeZvDm4MC6g0mC5o6C0xoeWBW?=
 =?us-ascii?Q?NyhCI8kxDZntw0r2ULLl9rIAoLscpRKcWje70+7SJHUuJkYtC68wcoRYj/wD?=
 =?us-ascii?Q?2zasAJd+2vJ1R0ds0eWA3hPPePvPLYtuOiB6xEyaCNwTZmc0qZXAuvrNs/o7?=
 =?us-ascii?Q?o7XF+rXL8QZ1l7MJqWuB3rZgb2Ww4an9Ih488U+mN+PqbFyyoS/rmL8Zhanx?=
 =?us-ascii?Q?jxzbK8CrbB9MnuQtOaU7H8F0vnoM5d4hWbAOUdzIznEzQeW0ZmVdLKdTTDu5?=
 =?us-ascii?Q?K/Tngvj3S1/i6a14cVX1anTS6ID+5OlmxVJAicjqQlNZcsuUV9/z1FH1bdMW?=
 =?us-ascii?Q?64G8+2TS94oQdOZeeAnp5kvL4wFitEMvFX/JzEOBzGI9QDRgzEdfhq8UplUa?=
 =?us-ascii?Q?BqpvkII/2oi4ghave+4VrXwoJidJksU6I7j4FRGAqjC4PCKLmTD1ghO0FcRV?=
 =?us-ascii?Q?XGpryjUcmUGORFfgH63AZdvxSU+78iuyTXaM+xggGXtAagZoNlfoPiQ4nLzM?=
 =?us-ascii?Q?li5QR06taiE6x/IDLj8cR7YE6Ea2trKwj/QOQ4yfdRGbVrUvYIhipB2431Zl?=
 =?us-ascii?Q?oPvQsNRgLJwo4E0C6qb2nAUfYL+TpohIZ99DBtRjYPZEFD3CwF4xeBJfmLOh?=
 =?us-ascii?Q?gCcJI5cZNF37koq75eWTOI3oHkiToyNFOcNn4hklKsgcWA0ASvy16N2iIShC?=
 =?us-ascii?Q?tJ9lAbnIDe4XgbY302vBBk8XUFXDP5PO6XzRSe9wgsmyD4nfm7VfBK/ZhM5h?=
 =?us-ascii?Q?jf6Zur/BwLbQKBwkUU+8nQHOgwkFHieSHsE7iSyCFPu0yDpM+B3yGauT3oeL?=
 =?us-ascii?Q?/YJ4e2OoQ3+FNkg2Z84xCgzendUIa8DHoAhXNw7tSMHN5k6f4a9qkNsiCmSz?=
 =?us-ascii?Q?/dla/FBJs/XIxVIm/bcb1lkKfEGy4FZFX4WQ2d+Om3Ak2ZwTwbtGZPNGcc9l?=
 =?us-ascii?Q?XSwRTAirZrbk+n9RJdI0Il3Q/tx/wmvqsvYdbR5WKaiSXdx9m2f6b2Y6L4Iw?=
 =?us-ascii?Q?/8LmYyZ4Jt6UiHNUcjE0gtOSsWqV3IdA5wgnnNvQeY00nxOc+x2VNry/6HAh?=
 =?us-ascii?Q?96jgR8fZM0McOiylTq//8pbI/ZZsH/aDi6sli3VdPi04axmkIyKt1U7eMuXn?=
 =?us-ascii?Q?SNOuGtlpxe4MIh1rfTqcYiOnH4lewpD/NlvGc6DLnxPBalQfH/CE0um21ybu?=
 =?us-ascii?Q?RBBl3j2t4heA6ZM5eMwVDBNMxOzZNfWpxb+joUc2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252f679e-ccf3-4d30-3153-08db2855d0e9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 08:42:04.7050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSusfaTuZ87auyhgNnapq+irXKXHWCZMNpADoKcS7PnqvoeMAi+iwKgIEgp6g00oF95Yrb9ujOZyhRGbyzlwQA==
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
 fs/xfs/xfs_sysfs.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_sysfs.h b/fs/xfs/xfs_sysfs.h
index 148893ebfdef..e2ff063e2c29 100644
--- a/fs/xfs/xfs_sysfs.h
+++ b/fs/xfs/xfs_sysfs.h
@@ -48,8 +48,7 @@ static inline void
 xfs_sysfs_del(
 	struct xfs_kobj	*kobj)
 {
-	kobject_del(&kobj->kobject);
-	kobject_put(&kobj->kobject);
+	kobject_del_and_put(&kobj->kobject);
 	wait_for_completion(&kobj->complete);
 }
 
-- 
2.35.1

