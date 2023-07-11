Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0CC74EC7E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjGKLSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGKLSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:18:01 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2110.outbound.protection.outlook.com [40.107.215.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550B711D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGya3ZBFT2LTKAfaeSA0OdrNITkPwU8yznK1fr75o17jhkpffFOWlceAcjt6VzI1bPafjh+kq6bUK6egGq0DPalMrSjLLVHG6JVsA93M8X9N/b0lwW2AcGKo2STt2nrbz6nho25UEPzj/XFy0hKuGKEd2Jdj/FJOuv+AhAxSQ1hQQSMpfSLI5ckuPoDG3RK/+SvTMKEGZ6Wq70VFr9jvlPqO/TICKM5iJAzu+OTFw/pd6TwupOU80F6jA/BiOqZhuKiDGTUQWESJfEDsa/LBS/eUggzWlTh2noqJ+izN783/DAoqoyYN3CUaGZhnxJlWSlSQI5IkQt0Yk/jpU9wapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDM/7bJlMopFoV9sX6jh1M1+3XsHby3BleVlYeMwrm0=;
 b=HxIbPcWmYz9qspmTwlWxxsNzgRjbIwMA6W0GjfOPWL+jmK01k8Zgkx0eedODOvDIHl8pWYcXqeYWsgUDOuaifrNU2p1bnYgK26lox4PAvLSI0Bdet1ihJJT++DEWL9uVEvhAO2UE4/a+2JCAxgHGQMmoPY6xae6bxY+DX5xjM9M2RFzullwTPX03FautxaO/b1KH/h5OeDD35Pb8e7R3hF7HquRFlSah7Aham7QS/53N6j7Nf83rgDDcuMLKIq+m2Kuxil7gzczTjYHOm+zf8PRQN7qMxRqLlyTXH/Z0s1Ig6Ri9Z4HGMMoxXIEfIUpmCoJCR7DFPGxUH1iEciDBbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDM/7bJlMopFoV9sX6jh1M1+3XsHby3BleVlYeMwrm0=;
 b=nv5/aM5cMvuuUrYEoDiKZdJ0oJfL+gSESEIwc0pnFntSvKOkjxYA4dXknot10YdusJeBYpS4G+BwgMxVi9YN6m/Bw+TjaGjmhH7civc0TkRALXVNPz1YT5IlQQ3Pa/yOszGfFe5v/QzXggBN31Y5WlpADDO1CYfwtr6Z/b/IvoIBFE2AKyyFyEsEpXGfcJVb8bjwKSt9bsgxqSHiC9AltPkx6w0VTrX+Tx9HwDTJefk/zJiq4QLBhZpXesepqgbQg2mk81UvN/Rs347RNvUlkpqDNs9mT9DSrpcs8HeaT0q8Bb5OvJZQa37IFEHvPOqo+Gw02y8UOx1eiaGR7QOh4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.31; Tue, 11 Jul 2023 11:17:53 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 11:17:53 +0000
From:   Wang Ming <machel@vivo.com>
To:     Wang Ming <machel@vivo.com>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2] lib:Fix more error checking for debugfs_create_dir()
Date:   Tue, 11 Jul 2023 19:16:58 +0800
Message-Id: <20230711111727.2672-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0029.jpnprd01.prod.outlook.com
 (2603:1096:405:1::17) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|PUZPR06MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 69100043-87f2-4c31-e664-08db8200786a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VEI069cE6xIyel+8hk5SH7U0gVZ0m0SSYmuZxi3/qwQfbYnAP5EEKdG/CBtrztUhtdY00ZEa/5BvSjX72vzockidVBFakPRcykLzrlQedfnAbmQFAI1T5iDX5D+ZdPCG45XX1sFcJqM0rEy513S95IJTeS7aIaQU+1oUu6HjB3wK6C0JR5cabwmXYl/lDy2qP66IiBhdNSlv3H3E8KQOUHgNgBwswWpAAQeiV819TpTh9lOqqX4bx/BVfjwaNCjjl+/Wz7jtX4aKLfDOCrfhdu19A6e3d9WaH7g8Bt1srsWhskbrx3G8rmX9sldQi8nMhwSqK5C5wWl8uOztXLEhp0yrN9LfBIMBXH/kkV09tCguBDWibSGEEKeC4ZXjvFBXI4Mmd6paCQk2JhjLmq+BpM2MXBIODYopNT3sTXeF/i/B154/7W1ccYSGy4jxEnqsyrX2bzuSpt0Qf/IBXOFcyOkq3rF5ZdtNI0oVDcnT8dEwkWxS4xED4Ivxv87Xb0bEDT/qMdHkRt5W0dwSj39uDYxmCSwgEbpfVB9MRSgITdMnFQWh9SfBXmmjpp+mQcFCBJuaL/qnnBSRm9FHDb/mT1dTwzufJSA7Q5rlbvEmU9BfCYINGtKLMdxDVLUfWFzJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199021)(5660300002)(2906002)(52116002)(478600001)(6486002)(4744005)(36756003)(8936002)(41300700001)(66946007)(316002)(66556008)(4326008)(66476007)(6512007)(83380400001)(38350700002)(38100700002)(1076003)(86362001)(6506007)(8676002)(107886003)(26005)(186003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o6Ra4tm2dDwYEu6qJzB1K9E/GF1tD9XGNpyU7Nj5GmebGQLS745O+XJJoqyU?=
 =?us-ascii?Q?Q0umEXM17ZMB335loddyrM+3skmX2CbgXqfTb6FBl9+dbCEO8uQ1tB4zrtSk?=
 =?us-ascii?Q?C/Z4i8+XKwSB7HbuiN0e0OQOjULS9FXbKWhuRtBv9lnLwfRzWbckNTjPX59r?=
 =?us-ascii?Q?1mNCIiGC3JJMYjOTpVa+SOOdACRyW28/gQEh0u5zSOAX+tETmMw+O2khGx/e?=
 =?us-ascii?Q?OkpLrFOc9TuAjxyF1+HG9zwjXTHpW+hKWg7flDfS0TOexxfs6ONZLsWz7s6x?=
 =?us-ascii?Q?UX8gktm2clEX3FTH0LInzfExqpG6EqyxMG/i2nupMFxg4JQ9Y0ixDd55l9JY?=
 =?us-ascii?Q?P+U6QFGgO0tMoDt5/5mWK9NXjRE+MgZKa9dcC7bu5BdRPhq/ZryT9oza6t4d?=
 =?us-ascii?Q?rz1g7yfDbo0/8D8Ze43jRZHpjm8juB21jP2+3BmCENng3GKypztf/cKTAdkM?=
 =?us-ascii?Q?N31cR0pnQRZj+t8gSxHhZvi8oxJfFVRH99cTqSJ332096fHrz/tcZj+MAXnD?=
 =?us-ascii?Q?Bs0HIzLx21lxePrR1bcHh87/WZOJZ/nHVPIITB+xau8ygRibbvLWfqpO/1iu?=
 =?us-ascii?Q?fM4ZkqA+xq1z3YupF2uKWKRvex1eJWiEBq1sCpiM81sUs4MHZmMFfvFBUGpp?=
 =?us-ascii?Q?HDXeQ7x00p3LU4mypr3xPsbTtHIFMQZ+b1KhPEJ0bb1txYwPvOaAFNDpzYA6?=
 =?us-ascii?Q?JgpE9d5x0g/UJ31b2XUr9K6wY6apmDsQ+CcFMII1fDUZPrcAd1hN95BG1qN6?=
 =?us-ascii?Q?MYfKZ7f3JDexq/dO6jluV+x3mady3OPEkgTim2+h4XG9ZaVrLeqTOBgErucG?=
 =?us-ascii?Q?BbI60qRcZ5anTnWoioXr7yJ/WEefTBa2espUGWfvpS1A6pxpH6Qe8aPH22Hr?=
 =?us-ascii?Q?pngzWAayQp3z/1wOh4/SSpMv9sJG/0DgtiX9BAiQxhLkBpFZ5nUfE8qLsS+Q?=
 =?us-ascii?Q?JW8B59MTWDgJbPrqbntcwW9EGpS+NtUXUOD7wxvhu9Wx6uRm1mucoN1XPxmq?=
 =?us-ascii?Q?g6/z9zP+4B5xDRmI9pHLd1rWsaqZxtWVnlUbORNwlJWi1QjmizQP70YAZ6Do?=
 =?us-ascii?Q?03gmv/zM9RUu+Eu1blo3NmuJkrEoV2VuQ740KkSl38ys43E42N76eqpGToiK?=
 =?us-ascii?Q?YbrLaF2H/asjERx7/IJSUDCVsUBuW8x9jpC58fqNzMatuykLoY0KGJxoXXvE?=
 =?us-ascii?Q?WQ5be00lFjTrkEzKEw1Kghvlbogi9GSpkd8Mkv/FOuJKscBqABhxMGUFzjRz?=
 =?us-ascii?Q?IoNswzeUFrYiRtoLhPKIQifB2IfgTah2dgOV5QoCZyb9r8RBTXlISY/E6xpQ?=
 =?us-ascii?Q?0hScZPBopclEUZCE7hqC8sc25o1lGXN30ZnRLXLgZu6sNfTaUEBLLpvm5BwT?=
 =?us-ascii?Q?t/JyZLgSJdSr+rbP3kKLJ1Rk0vSMzmOSRiVisuM8i5AXB7rTU3U4NwbnpIfK?=
 =?us-ascii?Q?BzPaCp4CZ4M4KSvpVj7xzjHGFJcRw/bsaFGAYna81OzV8TNU4vugcePswAXy?=
 =?us-ascii?Q?y5QuIquTuAxt87+Tl1YGAZCi+QHTA7PbSo+V7WoHYpOkeFZNPanlCbyf31iM?=
 =?us-ascii?Q?P6LcYwgRB6DfVNkOrKHRzNTWwnow2s6CjMl6VUq3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69100043-87f2-4c31-e664-08db8200786a
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 11:17:53.6756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8GAF7v/1vED+XwSvRxBltSSTzx75WI8DnpmPHYeEdYjtIZ1TmgAF8NDcxHfNaKAddHPUBD6y/2gQ7ZE+kSnvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5676
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of failure, debugfs_create_dir() does not return NULL,
but an error pointer.  Most incorrect error checks were fixed,
but the one in test_fpu_init() was forgotten.

Fix the remaining error check.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 lib/test_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_fpu.c b/lib/test_fpu.c
index e82db19fed84..5d6aa4691b4a 100644
--- a/lib/test_fpu.c
+++ b/lib/test_fpu.c
@@ -69,7 +69,7 @@ static struct dentry *selftest_dir;
 static int __init test_fpu_init(void)
 {
 	selftest_dir = debugfs_create_dir("selftest_helpers", NULL);
-	if (!selftest_dir)
+	if (IS_ERR(selftest_dir))
 		return -ENOMEM;
 
 	debugfs_create_file_unsafe("test_fpu", 0444, selftest_dir, NULL,
-- 
2.25.1

