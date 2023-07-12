Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F52750953
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjGLNO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGLNOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:14:24 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D521992;
        Wed, 12 Jul 2023 06:14:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGXPobzQMB8qIP4iwL19xMoL7/2BPWQz+ugwSsGxj3x8VAaocSIRQtK8YmTWUpD9jaNSIBwJjFnkjlWzgeNR5SM3x8u6Si8BF4SP4iasb5aCOAdvTzO4YijY1w8BOvHwN4j2zRcPI1ruvgzjVbhwQk7HKSSsoR++rfxWUN4rCsXH70OHpzVbaF3IoIldL7AiFgHuMJUaZalLj4XVD45W89+Z1gDJZ+Ve++brOX/faSCL+tDUVI+QBKDhBTiouoFRjgx7rmbyjoxIp0IuMok67+23FZm2Ts29RR2DcycgXhMWCk5irH+/z9ViOgL/A9d3ToEqckzWktO36D92w50JJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0uog/jBvQTQb8yxWf9/BaEvicm1mMzbaP+zrOtnLIE=;
 b=EHQhUNruoxPulOrGeXZ6HxS9uzqjt2pG3+Ow6Xx6i0umupRVcmvMuraorFf6TH/ZHHFx36E7hbQoSak/SmkWQOv0WDbfyOono/VfyWsReX8EPy712qIViqT8ZO7LkU3kZhDkGJkI9fb8099/radVl3oOucrobHWm6WSiaa+K1bHxHzwwGwY31Y0R+6v5LJCnLLDjd8lWFXf2JrfJ0MdIIEB3dDbSSVpSwKuLFMWYiUpP8pAsriMMZXUX+tpcglRjqnsRVc95ocOUuKyBjdiRwgpqwJDadIghhGZr3EVXn70L7NBr8kcKhEIdBIC8F3Yx0pXA5Le2BJO1Y1BpM9lDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0uog/jBvQTQb8yxWf9/BaEvicm1mMzbaP+zrOtnLIE=;
 b=fwoGWJbVjQ8GIpk/gU56qrygWIrmxYjzTRLinZuf62rEAMKHc+WptH2QukRXotce7cPKC823UmvpbxCejZvUCfuLQV8ZpEYM7szrceW99kKY+uvUSoUYOljU7k9nRoouH+UjyS0GVJlz9GV+l3nzoa0XX55FzEr97sOTettdy/ASI4fJH0u+tHo/Hp7ynqsBWFNkK01DInCgBg+s+tJIyOTp26SMxkpC3Q1u7gdrQ0806yCgbqG5nvGL0UWzWcv9k7nHHA4/yGHolzM1tv3GYcx0sY8ZeoclrEZ5tUTCX22tfxnv2BR88B+U+fqHxynx6cyjnm7sPexTEamfzDDDLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYUPR06MB6052.apcprd06.prod.outlook.com (2603:1096:400:354::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Wed, 12 Jul 2023 13:14:17 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 13:14:16 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>, Minjie Du <duminjie@vivo.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-wireless@vger.kernel.org (open list:INTEL WIRELESS WIFI LINK
        (iwlwifi)), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v1] drivers/net: intel: iwlwifi: fix two parameters check in iwl_mei_dbgfs_register()
Date:   Wed, 12 Jul 2023 21:14:06 +0800
Message-Id: <20230712131407.16462-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0086.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::26) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYUPR06MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d5bb0d-2fc6-4b1e-2379-08db82d9e4c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sw3b+RLlahqbX+oXpHcrDzXixpN/z5Hh4wuRVuUCjbai2+OONRK9KyW/jEZssYjVItnIVPpIdMjccRht8xYQTtAqK6iSv51tgaBvB5b4yA43yNNCB+6qGha9C9dUYjBIHCWUrYzNK2iI1vD4Ol3WfWPYvPRv9KgnlYSF/AvwguT8WKhgY8BF4AKwnsLf/ImUd+ZlcBDZzxN3+Yql3/WavnEIAK9yPscL6IbDimUHkGTlJ0bzS+0YEgwhx91+vjSgE80lc6XeN1vO00EO/R9qi82C57Cwx07cvaijQMYbUiaQaTEKgSgP7P35bFrW+A41gyvx8fVvzG4U10mu3h7URllBy6Isw1uf0+70qE0mxoOpRl50WqcuCme/bH0bfvF3CXrzOzoRHf2A7bKLhSNs7smlFX1PGx9kMWxbmQ7RIFzBTqHSdXI6VSTSXmI5XJTnUf2OrlGR60ytBsJyTeWnHxxhyFUTQAxzLYBwenXKtgnX49QfraC5dvqG5j3Ynu9WUTFC4kQxWhW3vPuRYURt09nA/acs/2x3VRmWbdHW1YKPMno8DPcZRWBYYDofoTHArn9DsGKg5N1EAuG8N0RDbYjM/OlBsi+qD/jMtwQHOGW/joykVKLm1nMlPzm2CZUP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(36756003)(4744005)(186003)(2906002)(5660300002)(2616005)(1076003)(26005)(6506007)(107886003)(83380400001)(6666004)(478600001)(110136005)(66476007)(41300700001)(8676002)(6512007)(316002)(8936002)(66556008)(66946007)(6486002)(4326008)(52116002)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jn/AGYEpeFiTor04ER5+wr76t66XkrY1kAQq70f1vu/86TdeAg07XmkdVOCd?=
 =?us-ascii?Q?Q7fQhPHy6HOwgCWWzeb1dAcPb4TNfk0+2XHdt+Xddejr0zRWfZoMf1PNsVza?=
 =?us-ascii?Q?vw0GI9Hbbky42AnAF4t7dKB5ZFa1RF+tyHp5f7VKVHhRZf08spf17Hf6fwTB?=
 =?us-ascii?Q?qPGVRvM7kefaL/QTNCPIrY9gsJckqihQJLIWYCfmUxq9LgVncA9R0gkY44xB?=
 =?us-ascii?Q?5AUYlIz95VIG00WJyYNelpeel29aKMNUZpFoVUd71MEe6UlhUHFPPsiFvDqV?=
 =?us-ascii?Q?kMpNTOXr8vpOzog8zjo6QZVl62i6cmwlYRezD15vm/VwzsmA3eP6dHYisiiX?=
 =?us-ascii?Q?DxrZn6S6MF4djPFg3rkbPcm79mVsAujvOTHQ52PFTm51073WKclcySvlZXlN?=
 =?us-ascii?Q?ASr4LvGp4EjfLTnKCsAsdMrHT/rJFpqXYnU1KbhwyfIWQ549TEI/8JOm6ppY?=
 =?us-ascii?Q?A9/AcB5R1vawyH7VCY0/jzWUQDYsHiKVsqrGBD+dGmysFlBc7ARSpS9O6uRi?=
 =?us-ascii?Q?vQFdV9uehukLPsXkris/WZ58zXIKJ8UcWp8XjFo+BPw+5QvJAATn7C8u/yue?=
 =?us-ascii?Q?lulba5DgpXkWT3Y4XqJ+zrL7BVYa0kk17lWRcFw75Eq4b+nnmtMKs77GLPlQ?=
 =?us-ascii?Q?n38gx1UE8t33M6MQFu1Z3O/LVvLcsQ0PuFpBb5bVarjGgWhBvjJXh17QLM39?=
 =?us-ascii?Q?u4cs7r/6ueLKJqbLUBmMO4H+vwgPMTvzHTqSv+CjoOE7C7wO2wtV9EMri2HC?=
 =?us-ascii?Q?DtwXMfl6R9vcUI3LmfulEA9T8LSOgmRb31a0mUyrmyOBXMgZ5UTO/+3k+Knr?=
 =?us-ascii?Q?H/x7xIBFxkb4UVD9Fjgvf36jLb/Ak/Y4JbYsKm1QDxlcRzMfxH8ggVYDUzJL?=
 =?us-ascii?Q?49QMLRo/IRxSolE6EGsVh4mt8iX6iYXgW6SF/nld932tl8jvgySyV39tWuJ/?=
 =?us-ascii?Q?4v9zLhZFzVh03KsJ/LKS0R36KB/yKpB1LuC9lumZXQCltbKf9bWwMns6Ibgo?=
 =?us-ascii?Q?HfKaHWn6H/cKqyax6w+HvxMVZtyWgLVpvJhxtwvgkb/Fz4IwD+/4MfCr+AiQ?=
 =?us-ascii?Q?Ie9NuZJiSqX+1JGm1GBG6nCfhTrtQTDpVJy8SVToYgGYdiJ2UaY8xdBxgoMk?=
 =?us-ascii?Q?ual8rtDL8sg5Gr6ya9/WDSQ07vlhf021dxoL2XbGd3Shb/lig2LOUlbzfxJb?=
 =?us-ascii?Q?LCFmIngHG2A///tcqezEXHb4CRrzORA4BQrwAxMlT1GkcIkLmuvd/M7tmrsk?=
 =?us-ascii?Q?KzY5gX9Hi5VgKirey6hTG/M7gkxQNgB/siIN6NHTFuYduoIhQ/kf2WH26dTF?=
 =?us-ascii?Q?3YUcvXFCVsxEHe4/zIsuzrktgDyIjziYqgYfS01k64KISG5y1P9OHzfUY+Py?=
 =?us-ascii?Q?b9CYDhYHxrQ20SP6Eejwsq84iB/wWP8fYIzelipcjRvCAZ2RglQs2i+dWkxJ?=
 =?us-ascii?Q?zFtaeAzYtvohDvBNHGPyAzHM4ESlMFTa7n/53CXquFHhYIelR8jMiEIDag2J?=
 =?us-ascii?Q?Kxe9GAvevTdto19kFWGSk10Mb9YRefPhaWrfz/pGqxULOJaaDOASc6AAXzA7?=
 =?us-ascii?Q?rL67gEvMDy71/ocSpnkQf9tNfd70BLm+qja1MGP4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d5bb0d-2fc6-4b1e-2379-08db82d9e4c1
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 13:14:16.2277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lPOV9dhbkb6P19svP0bcQbcu+xP6aKhYWOaurJzqeLCn2U8+hSPct8jtrq03L1/XtTZNm4X4gRHKPR8Vx6dHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR() judge the debugfs_create_dir() function return
in iwl_mei_dbgfs_register().

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 54445f39f..e5d203a62 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1888,7 +1888,7 @@ static void iwl_mei_dbgfs_register(struct iwl_mei *mei)
 {
 	mei->dbgfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
-	if (!mei->dbgfs_dir)
+	if (IS_ERR(mei->dbgfs_dir))
 		return;
 
 	debugfs_create_ulong("status", S_IRUSR,
-- 
2.39.0

