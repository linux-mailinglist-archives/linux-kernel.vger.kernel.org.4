Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E162750A09
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjGLNw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGLNwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:52:54 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80D6EA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWrrufyAApJIFqWxphfdxwuyua1/k006BBgHs7Qfj9L/fC9N6iY2TrmlP8SdP1pCIAI/m9cvjAsfI1/Jww4Eq7ds/gN0Y1iZC3999g+vjIr+OPmhpP3+kYVlIadFhXXuqsEPFuvkByRy3rdndVYNYbjiRMfrT+LnGYym/laQU0quFxjHXpEZH500UM8mjgSYBCm4Aik48NDbjKaLB6rplEy1pkQN+nXsbQS6YSqzys5LWOHyyZxLsWNbR9R2bIJeS93SKQEGxRl7Xf8jZzhbDUJsvoNT2thDoMrdkit0S0Jv5pqOyiJH25i2DSeJt8WX/CknxHhYj+IifQNhdGHZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8L7QHZ1RvGOtmqWj1WAmDaJm12+PcAVs8XIF3G34EE=;
 b=IluxIOnlHfk8/LX3+0UuFhR/hKFH07zMDIlQwEJ62V4WgFx3hai7jtUg4iHN9Nq6US3+2OwJyF+WS+Fmsfj3fJqDLtzPNxLe8VMgPyQQawc5iMqWcOQAXO9REjo0oHCg9E52gGND+HzOncEnEy/6T7tLAYelR9GxgaNMh8bEvICpFqdJUOnLaT7kcizKYXxn2FL0RgMF5JzG/35/yXxDDtMO6rLByWvpSdpR7Y34HzOv9VWW8jEX6sstbhVFwGGunB4N37eXneD3SQq9VuWA2h3ovtOMYmO+QDRqNs1fFMEG8LLzSjdUAXd2orVlh5u0yuZElllZMJ62bGtSK+q6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8L7QHZ1RvGOtmqWj1WAmDaJm12+PcAVs8XIF3G34EE=;
 b=dHT/gOyqbtseiiABe+ruanA+Qx8J2y8BiJMbyIZebpnwXG5Wli8Ih29r2efe6RBaZtK5BsnHeerEsEuDjMAK0HYA5mZeIBMs2dJjdewUY7uAbhQunAPZR+43HyxJ5c8P2OIVbOeH8rpA/VR54WkNyzsRBDPgDtuswXNzQcbwVVGsHnf4/VxbZ7kP1GXRZZOUL8A03NcfFxvoPHG2qDSjKnCGmAhm7g74vE83mxeTTVLkkVRi9H2p4/wvnCP1mcCJzdtSVJqZqpkG2z8lWOMAxPh+op0v90JDgYRsmgD8pYz4JYOTJOU3s/K9fG0nHXgXUU2aiiiBHinRXea2UxsXKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SEZPR06MB6762.apcprd06.prod.outlook.com (2603:1096:101:17a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 13:52:47 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 13:52:47 +0000
From:   Wang Ming <machel@vivo.com>
To:     David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Wang Ming <machel@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v1] lib:Fix an NULL vs IS_ERR() bug for debugfs_create_dir() in err_inject_init()
Date:   Wed, 12 Jul 2023 21:52:11 +0800
Message-Id: <20230712135226.10041-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::19) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|SEZPR06MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3f1553-08f6-41e5-6bad-08db82df463b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NmPoxAlkyzaD9qVQa8s+8hWVSXpktI3krjsrMUNiG2RBJXi7iLN7ueH6zzWUw5+d4YNxj+vByinh0ur4KNWaH+ANNek2OuQmJVTjNdKe/uuOS3lI7XqoDQGF2NxE21V6hbiHzzwZEl2deIRiDd40OCxV2TfROCT/UqtGEIDiCN+ozg6450ad5qMK1bJfX4+NGnpoOC0Oh2WHu+obIELb9NDoBidgfBOw9e9xTb5rhp+A/x4V22HN7DWJdIWNoLt1qqCzLjb9vZPUZnGb0hRvZtzfXWphmQL4vvj0j544TUjP9uDiS8E+3p176N9QjrTPdgFxmKk/Lv0ZaqGhl7hgeimxGDBbHN79E7CTmS4mG12jSIZ16MUKyLjQ6VppL/4LsPQjEwRhjDHMgVNerrL9f9KMrwLJMQa4V9+AbPPOy/DHZmV9WVP81F0wFu83D6O4tG0g3J0uC/WBIK5BtRUQexDqFHTMv8ExLcLwLpAQZyqC7hfiC/Imsft/B2bE8BOW0j2yzcy129mWv0uehP4E5qsKLMlBUeDGrSqxWAm1Zd9pFsQ/Rc2bc+5K3f69L1PdEdj6xhI6mIYlr2ETGTbCZcAcPItgxzaieyC2hzmNkWU0k3CaGivBydGKF12sM8Ap
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(41300700001)(4326008)(4744005)(2906002)(66946007)(66476007)(66556008)(38350700002)(5660300002)(478600001)(316002)(86362001)(8676002)(52116002)(38100700002)(8936002)(6666004)(6486002)(6512007)(107886003)(36756003)(26005)(83380400001)(6506007)(1076003)(186003)(110136005)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k255KQ0pd0jLD29zK7nPN6dz9BPKBNt4vWusEL5lsNoI3nfkhyi+AfD9yaL5?=
 =?us-ascii?Q?kxc0SxKDStXpHeKVmby415mZaItx4iEYs3iIbcl+gG5mIU3ybQ/s1BcdKHsW?=
 =?us-ascii?Q?sITMgrSxI+vuN31HfvL0U7mPC/tySTXM2n7rLmjSPeWOV72MRZJY08DxT2Yl?=
 =?us-ascii?Q?xLc4+V6ocN+wwPA+PdkLsL3f72CR+OsnNgDcjXolyCGZ6jX7T0ga20HYjFbk?=
 =?us-ascii?Q?2pS7VYJ7b2i/zGEeG85SvkbDzuC1aULMcRNlFUYQ+kRGG9lslyiFpobwyslG?=
 =?us-ascii?Q?vC/95pI7nY2Z4+DHkIWTu37SabApR7wfhoA35eTN0UmkOFdcgecn9g+GqTbj?=
 =?us-ascii?Q?zcaC9H67DkRYRc5oTf7p+7zm4P571SP4zDk+pbSTjcmMp0pdY7m7yytfik1f?=
 =?us-ascii?Q?A77R3fkn3UVApsQyTKfKuVgADrNERPveRGS2S8AmobgBzwnfgWprlnoRw3fc?=
 =?us-ascii?Q?X4/rc6XhsVEQfUaLvQAmiIBQdX5Rtf8ugTVj39civUds/2QyAAg8DzTo4oKE?=
 =?us-ascii?Q?jIotfqNTui9o+2oXxaq2avhbYtoTRs7fQbehvWC7iWcFuG7CUnAI6gk/41vH?=
 =?us-ascii?Q?vEzIIPA8Sz0rC//iP872892uJqZSzxGZ6kMFZh2V1BxNTfKyhwDf6HaQt0OI?=
 =?us-ascii?Q?4Uc7JNAOXenCDyexCBpGEhfHgQsf/Xl+NxTTXYVjcmpSUBgq1fXPc1sOmFi+?=
 =?us-ascii?Q?6jAF6fXFCYQ6jED9zCm/dGrOZCWwOVanp2oyPyP/i3oU5Hfr/emNHEfSmxQk?=
 =?us-ascii?Q?4X046xH94uGfTMr3rA4ILj2AKQeMn80FqvEFBFV+XipcZTXkwiGvqoy2Nyr/?=
 =?us-ascii?Q?lvQQHGnx6pbXcywRNEJgSGyoXgvU4bMKzBcXBrfJvE932KmfkeL3Im7j15ex?=
 =?us-ascii?Q?oWHWPZtQFOyYfCL5tDxeMaWOTJrmiJ/adzkH+v1SsFE/NTCw1EhFvrBbdfFm?=
 =?us-ascii?Q?lpK7N1AFvB/mNUplQ8dI00mkUbNmoqBRFJHW3mCgqg4iIJSxdGpmH7DdoKfq?=
 =?us-ascii?Q?NOe4AyxVL4ydT2e3Q0b2HLUp4r+qnOtWchCHQPCsyk376fgsVL8k4g4cwdf3?=
 =?us-ascii?Q?Vy9xBIWPSE3j0tYbvtiWNcxZFToao+c0fdDDTshhMf0epxiyn/LYiZ1Z7oZh?=
 =?us-ascii?Q?qGGVXS4QNa9OaDuqfUUPv+hWV6z4yqsKL61eM0OYvbCytvxIBI4Z8Gm5m9XZ?=
 =?us-ascii?Q?8TM/ril1LfckKVCSM2W2BY0HP0uGKY9Rnhl6KigYiDmrKoVO0fJIdP0iUBx1?=
 =?us-ascii?Q?sCJ8cKlL9M1xhRRiGmjTmrtqUJPF5i469Ik5Db7Z7NLVcIF6vvLyeT5jITJl?=
 =?us-ascii?Q?X43DUeC3GNa8gUMVm1p2XhxTivJGN20XFR4QH7/rO1nq+v3qgrI/eCJeLpj3?=
 =?us-ascii?Q?1MKIG/SPHCi3/KH9VWX3jQ913CDA6nzvVEwH3X/YbdQ8exSwFgBGsJ18Y0O1?=
 =?us-ascii?Q?NuHlokEpe1z1ENlnGHbB5URP3Ou/FcQwtDidGQlWf78wKusR6e9vSsiTBkyR?=
 =?us-ascii?Q?Y+ZmhYLeX2Be2ciew+mZHmZYNomaTNiBF3NaXUhNrot3gbmJvRoFWKm6ej7T?=
 =?us-ascii?Q?V6LTxGaNJixKQiLtCBAZlOlOpfp6wQ1UgJwtNDgy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3f1553-08f6-41e5-6bad-08db82df463b
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 13:52:47.2476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oa1I58f40Fd4dSHpTPYV4HRrKkHAM2Q8p/eEkkfZkvLXYCtuVNm+HSjw9E4vFTPO5CYtUF9nvfHMy0breu6dDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6762
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_create_dir() function returns error pointers.
It never returns NULL. Most incorrect error checks were fixed,
but the one in err_inject_init() was forgotten.

Fix the remaining error check.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 lib/notifier-error-inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/notifier-error-inject.c b/lib/notifier-error-inject.c
index 2b24ea6c9497..c49354c23802 100644
--- a/lib/notifier-error-inject.c
+++ b/lib/notifier-error-inject.c
@@ -83,7 +83,7 @@ static int __init err_inject_init(void)
 	notifier_err_inject_dir =
 		debugfs_create_dir("notifier-error-inject", NULL);
 
-	if (!notifier_err_inject_dir)
+	if (IS_ERR(notifier_err_inject_dir))
 		return -ENOMEM;
 
 	return 0;
-- 
2.25.1

