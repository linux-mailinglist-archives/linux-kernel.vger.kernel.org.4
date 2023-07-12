Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEEE7509BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjGLNjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjGLNjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:39:44 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2113.outbound.protection.outlook.com [40.107.255.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4891BCF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VU9nFdU66PUUqFRCDh3d+dT1M+uAqHVlRw6zaJrgvW/Wk9+kyGNzGUhyvC+KygvqbaRPfodrjhcWXPG4Nut9yjLA7VmITvMuyUu6V9KltL4UBv3kkVtU0o7pMnMsp4v16Anz9y9Yh95pVCDt+3Wuc4JbfhRlk9aiWiHawSSw0kQmqW5Acqe2yhtv7ECXmx3SHu60AbtMim4HFQ8qvfOqlsJj20EcA8HKSMVxvpd32/umDmn84m+TmmSHIxy8hXj4IHhN5B3UuVlOCqntOMlGvSItUSPHCDQmHKkSn3fDWfGRU7qWD7pdQp53aRxuurglpz/E86Xa6PSUTDL0NON8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vvRInxXVYXcxrppPr+7713hF7KHBFEro+pFjMpl8vg=;
 b=jchpLSi2hyQYVr+UR6l+UPviLS5nl435Hgtb3ttAdenKeMNMpxbCVOpyMNBxgg13In6krtieETxXPAq21ZMhiaGlZkmFWS04oO5P3KuHmN7wgFcEisD9yinlomNPK/bmx+Weg6og2AiLUYQTQ0tW0DuuWL43CxLCB6ipUjqDgMQbUY7T3t2Nw96sQEG/uMB2YRtoqb1o4i7xH+NLQL2Jer7Q+pcriZl7CF7u4KIO9MGCbWgegbS3UCQ/946n5GqKwCO9abTD2jLzeKJ5XX6Gzcv1OtvfemcEYpCMzVMDGzIBW3n2mPG5iQ1wjzRm26rwQcrLn2YHsIhoBcasWacbpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vvRInxXVYXcxrppPr+7713hF7KHBFEro+pFjMpl8vg=;
 b=BvFqCzvKqbnVFdm5eDjtxFtZWzSQ1JmSLon15JD26H+NZ+m5HdQw+MrM/qL/yrfIeRgFTaCU/Ixzo+ZVBMXIb9Ahnw7MRq1XLhPjoFv6qVW+PsCQGGqyPy9+LASTrcDnOMoZevG5UM2rm9TmxywAl1pSmCiH/xMc50f55Lgmf568Vvl/t9/TkRHmotbnSdEWwB9rOlDi4uTrh8AC8JYERxveyJ7ionvacn+atCFZHYBkK1Fa0UyKyBulevi1L11HNFf0xKyg4JJO+6IBtIqFu0pkANrOpTkeZWQk0UR915YUpG634KDgx63Ynd13jhJglyRN30yAF+ZCIxsOF4PmxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 KL1PR0601MB5655.apcprd06.prod.outlook.com (2603:1096:820:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 13:39:39 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 13:39:39 +0000
From:   Wang Ming <machel@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] android:Fix error checking for debugfs_create_dir() in binder_init()
Date:   Wed, 12 Jul 2023 21:39:07 +0800
Message-Id: <20230712133920.9509-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|KL1PR0601MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 341ce5a2-c07a-4618-1362-08db82dd7014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GvWVJgE2HbhCdY52IphRR8gA1Pq5Xbd1HssaGhgbGXrVBjMYUnNM9SrEgedWHKXe9scNF32DeAbUEOTQArKoeK4h2KGAK/1wlZ+7WFrGyhAJomqL5Ix1tMFiqbzxI8rivzUJWqk52Bz5VeaPBC11bK22wc25hLNdcLzxd1TQls6WibA0NwgdeKQmjFLXA3CF9QTeQmMsFEA2r3GtE4SgCXDeniOpcXinGcWhzlKLR45JqWukjrnrFPuSLANcC7+1/VD7vTi9N97BhLXmW5QOSXxeXaI9nSyS+3xJdozNqBz0X+fU9PTmGGbs3M842TJLdMO7ltLQ+by7q0uIOCQCgJAd0QGFh46QyQW2Lgiswpkxs0ZH8CZQ/SWjEZ4UeLdO9hn6X5gGqxIQrQCQytsSOlhIqiT/H/d1fzkWKFa5t7eg9JTuua/mkLfMVejVGQZyElqdE2FFWSh5o4inicMMPTgOQrJhVrsYS7UShI51YeyauDldm9UYQeoE5LdrS+2KdbNthrlS2H/cD94+LohNC+ZjtSf1huf/BkFKE6tj8+obiQPT+U7bL0hv8D2lipcMGoGZrEGB9hlNDjCEFRyypvt9UIttSEiRvN+exxRAclWsBc2zMUAtMq2wyHhnr8RF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(86362001)(36756003)(38350700002)(38100700002)(110136005)(478600001)(6666004)(6486002)(52116002)(6512007)(8676002)(5660300002)(8936002)(2906002)(316002)(4326008)(66476007)(66946007)(66556008)(41300700001)(2616005)(26005)(1076003)(6506007)(107886003)(83380400001)(4744005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vF+l4fzBmvCBn7uAQYVKJClIaURg3cTu7tBub2HNhEnpCXkrQRxthnRE7ReZ?=
 =?us-ascii?Q?VBh145pHBsyA2h/xeZJ9lBcCByqmmsCe+kXRDzbmDRS/MpZoEXnsy87cUYPV?=
 =?us-ascii?Q?j0QqGHHNMzqd+IXbVZ2kXvK9ozz/RuOnD03v4gbz2iU+BjEf51R5QEX4e0of?=
 =?us-ascii?Q?d8QSINUL3H47975NNphNf+gItKba2ubCGKzHVoFj39gfi125R2DJwscR/wM/?=
 =?us-ascii?Q?SA2IaPuz+QdyABgveiye3zV15uI2pLCNfnStk3Ww70J4kuotiGgNnRHG6UzK?=
 =?us-ascii?Q?EmD6KwI1qChAMvstGFZTWhURjLWDfiGuwQbnZmtrUiwUX8C3X0rKGu+4c6wd?=
 =?us-ascii?Q?0IhCCgGwX31Daxc+dbfmJyY2VVNGhT7QkIbxh9IArvMc1EN/7r6Dywc1xjxI?=
 =?us-ascii?Q?GSjQelv1ZB6KAiaTDyDiThvLTYK0wV7l84GVWTLh0VvxIiE+26fiLS8k0fq/?=
 =?us-ascii?Q?CUjpCgZj7jEwrCRI2FcgMbEVsBxO71VkWMu9REIVLlY/S8kaI0JwuheNXt8P?=
 =?us-ascii?Q?p4ZCryI3/cOxsPVCizsMeZt0uN2jC6uu12Eeo5DunEOlldOl1J0aIGpqhEQq?=
 =?us-ascii?Q?maHWk9NoS10X852a5i2R4trg+pBMD46E8XCQHywaHZPMdutEp6he6GjYgIhM?=
 =?us-ascii?Q?OIV6s/q4Gguk1ZugTJjgByISOj6hNLZlLFaQWOCaN2nclFJ16ZKnwYt6eqYU?=
 =?us-ascii?Q?bx/rMCilZ6qEwM9tKNsI+1EUqVCvAC9lkMslQ3j6zkDI/UXxf4xsIGYyCWrI?=
 =?us-ascii?Q?rFMtBBRPqDR1GsoH1iObLhv8LABDJ7Mf37xQ9R4GSTZIJFBTgQF+nAU0jnJC?=
 =?us-ascii?Q?Tt6Fg7J6WfpNqWB3/z4NtimYwHO5oKWpg0gt1md8DH8cWvGVwPSNjEloCMiK?=
 =?us-ascii?Q?p9bjsAHvVs/hGSJS3nRJzSpe7qAp7IAlFrshneEIeQTK672mMh0dh52HMgKO?=
 =?us-ascii?Q?v+EZjEcTRPalTJbDYN9b8McEAImUZk8NYBCRvk35lIDAbszJB5Q4nEFGiGAs?=
 =?us-ascii?Q?2lgoo1i5sPRj5tiegpatBGFZCautaIfhyURFF0XUMtRF8X60RPdKjU9FeXEL?=
 =?us-ascii?Q?yEi/iK7xpMDM4QgL/NfsvbkwTqIy/dZqJWlQJeCpIxjobGFmYBja/9rNFtDk?=
 =?us-ascii?Q?+mOW/pbR7u3L3WnDmq4+e12cxA6qxui1Nh2ms++02VafauHbGbWY6pSNd3ty?=
 =?us-ascii?Q?6Ihl6tiy4Ic4HsvSpBv9pCE/e6DnkoLPAerHGghSY/15vYEEeepabXEJpyKe?=
 =?us-ascii?Q?RYOwgbwQZ0f8IIaH5Ol3Z9f7CkhjMVZgcL8xpoWgswrvl0f5MROvaSZ7w1Il?=
 =?us-ascii?Q?17UsEhNpdMErOldFEBlxatRHYE5LGgHLHkC3RCWgSnHZbHwK0ysd+7SeNCyp?=
 =?us-ascii?Q?/hJDmEvnzXjEpE4SqIssvMSSdJ7R0NQ9znmkVUpt4ZIpr/Hbt7XjN4HeGNdZ?=
 =?us-ascii?Q?azzIF1Vf0ncp2cHM28aWgjOG4Ex+BFqEKzk/USSNdDiJUA6iNVBTOPlhEqo8?=
 =?us-ascii?Q?MlIzSdZ9X2+DIMXUQ3b5+aOf8t3HU/jjg4soOBqoRUhol2e6/JbjJt2GUAKX?=
 =?us-ascii?Q?A2+N4e22NckHO+BQtelpPiRvI4u8Cf9WnKOhtiEG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341ce5a2-c07a-4618-1362-08db82dd7014
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 13:39:38.4569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfOI69Soc/KMHx7SNnZ4cfZOIhqf2ixXDoqAI8Ifg73CGbUoIWNrLSRR3uCHe57BUvYtUOhufydRmZQDNHEy0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5655
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_create_dir() does not return NULL,but it is
possible to return error pointer. Most incorrect error checks
were fixed,but the one in binder_init() was forgotten.

Fix the remaining error check.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 486c8271cab7..3b5309484df6 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6566,7 +6566,7 @@ static int __init binder_init(void)
 	atomic_set(&binder_transaction_log_failed.cur, ~0U);
 
 	binder_debugfs_dir_entry_root = debugfs_create_dir("binder", NULL);
-	if (binder_debugfs_dir_entry_root) {
+	if (!IS_ERR(binder_debugfs_dir_entry_root)) {
 		const struct binder_debugfs_entry *db_entry;
 
 		binder_for_each_debugfs_entry(db_entry)
-- 
2.25.1

