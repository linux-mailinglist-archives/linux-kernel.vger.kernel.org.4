Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D21750A71
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjGLOIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjGLOHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:07:55 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2119.outbound.protection.outlook.com [40.107.215.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA6B12E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9D98cW+j6EIYDcuUGdNSXcfePhrH91UN5cj+3CS6AKQhmlJ7E0WwLmjDCo9gkGLP0frj8aYO12MkXshJqXRKHYi5HJgtEKayIcY8FChnE6YcNscN5ZCjjJhtpZWbTb3evrtKS0nFcvDvhYZGZynXoEm1Rt+qc+pOnWrJpLiPpx+c9t34AIVXHhO5kDq4XvxHhzvG1Q4XTGfZccn7/HgVxFaE7tDGPaEwbiSr5XnHZ4wKNCtSNFZYJDDVvRjTu6cjQe5Jlfw28/qp1Zy6jGJyUJTA7NyQNflP5E6d0pfrSxT6TPPd5L7R0yCVn1GVEFyWaqNPYPhuFI6Lz/JbqdOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDQm+gGlXnxmzYmOfnah/nFP1dlqEnk/QqERskkU6q4=;
 b=jeVTDxNGsTOwTNybYTv+MqcPYlpLOFS3PFK1GZZ2JvW2vmPYwz6cc83zN/y5LBG2Gd6/h89qfhW+kT7sN5gtGAJ62vLJKqQLeMN02lKeMb0ZsAKmeGfbb2dOIIXPGHYHG/Cl7C9bX2G8FDnwTZ8f3yk8chQicasdHE5HP4CkoevMVQoMRU6hZsx7TMShnxkIDYZNlhpiQoMhB5+gwgZvvVr5ZocHTo8PDdAkjF+ThwQCJUZsETPGwskuPIGYfW7yy1Tun0bCxEIuhCef5u1FXMN/YU2m5lc5l4Ci/8shdtIDOLYwsASLp+x7hqPJ6VdU+iH6nD5AiAXEtgTKQkPieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDQm+gGlXnxmzYmOfnah/nFP1dlqEnk/QqERskkU6q4=;
 b=p+Dz+6DKOEwo0ZSspKNgpjW36xUR5eDjoJ3PXBiR2Iv2QCDA0qbg2Ridz2INfd+ewreK07FVEhoSSMKGSriI3FhCwHiwzcZBp+D1N1uVKqfNrAYuHcFifiuOcqyetNog1ZLIkQgz/Bh+9rl5DP+yVI8+5j6YYu2/jK/iCA1tm7oELfp6QnS3ok6MQAxxFoMTqansNmGG02fDyyZK3ux7y9YyFXM7WdFodRqZ9dwQQrj/NJVNaBTv1sSWsOzm+fXcxygOyqbeGkhLQC8SKZGtugZ7cUOqRMKMvLvKkNOMN1R3RtEvnCiOC/kS8t/P0YIHR6eJv9OPot+EtuWBLp5ryg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYZPR06MB6165.apcprd06.prod.outlook.com (2603:1096:400:336::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 14:07:49 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 14:07:49 +0000
From:   Wang Ming <machel@vivo.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Wang Ming <machel@vivo.com>, Arnd Bergmann <arnd@arndb.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Yuan Can <yuancan@huawei.com>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v1] hsi:controllers:Fix an NULL vs IS_ERR() bug for debugfs_create_dir() in ssi_debug_add_ctrl()
Date:   Wed, 12 Jul 2023 22:07:24 +0800
Message-Id: <20230712140739.10606-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0238.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::34) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYZPR06MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee4b7f4-3f47-4619-9c6b-08db82e15fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YteuRxxgNs9IeA6YRW0XUCwuQXxWbsZA6OvL3LeK7JCG6jKrVifNrwydBXgmsyeGOf/mI/b3KrUE4gU9adj2MkF/Kms4fx2HB74aj+2eNeu9Z2tELUBIR02f48r+OacaPxQ93Ku2peZMQoLUyOc3xGQDnXnLHtv7hsWPf2coLxu2EC+YIOE6FQa8qHhdAUw7xROUA8z/HYb3jNPBz73Dwe3LupMREeF7iPKiaBrGJx6fGiJIAoj4+0SaccpUCiy7KBpL6DtDwtbP+mOoMIV0+oggIIJo9XInCTWCKzWxeQUWMPimb08GlKMW7csv9bqsvDC3mrfAqt/Foen7JTMej78uW1YUP2YjIV0SGdiev6+ycX1JsBHBtKzybw8plIl+pVsVL2mMClHj+bRl4kwHtTc0Iu5wAtUEXrICvND4CVKcfmN8Xa22ksDVGJLqNjHYLRiZ+VOgBR38bNCWni/qCeg6xCeE5H8bznk0JKUswBzHsdoksuLsBxiyaIZDAWOcDnbgxX+HKDiys7f7M8U9xuDZJw+UUUYvi6UqV6MLqkwkbIIWAjy5al+/S4SBsCvTB9+IthlAFq2f1wZd080iwBw8IAduIU4k5x4l0yluWoXYT4izHHyrcjBn+yibsHSJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39850400004)(451199021)(6666004)(52116002)(6486002)(478600001)(110136005)(186003)(26005)(6506007)(1076003)(6512007)(107886003)(2906002)(4744005)(41300700001)(316002)(4326008)(66476007)(66556008)(5660300002)(8936002)(8676002)(66946007)(38350700002)(38100700002)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y02R4NKsFmwdk+kUhVYvqHflOXrEtUijsXk5ZEysOm2zeOLaV33GSXamsuxF?=
 =?us-ascii?Q?hzTZEy22u0nHL3feC/N+7uzyz3DIkjzsVIRaLnr6m5hRkdtVZJx+NDC8DSoJ?=
 =?us-ascii?Q?0HdvEJ5zDlhLuaB8lVACL56HF4jMYdYXXIar+H9mQjtZjFhnkO37AL8cho5P?=
 =?us-ascii?Q?oiNSmiuU7cTaGudPrxkuASpXHWXjc65HmqSAjWOezCISLFX1T86SfDUdCpII?=
 =?us-ascii?Q?bcCoLEKDBrhr5CcQkt5+Tbd+7T3NwhEEz9/7JS7wbwyi+H+lCGdXF9m3bjC8?=
 =?us-ascii?Q?A9BDQWQgaPHucng6cHKkimqaCu04DH0VA7MPgwZUV/r/pxJiK/4xkTn9UcqD?=
 =?us-ascii?Q?TIWX0MDdRifgy79MUwfEFPXRJ3QYfH1XUQMKMYPF7+Cuc5pLJb9kc0evsABp?=
 =?us-ascii?Q?AM+1U8eKnT1OxPx+V8ZXmNmEuOq+CnbdxGx52i0C+Qu+/HZe7iPgwL1TAmC4?=
 =?us-ascii?Q?X0b8/5OJn98cWs/mT/xw0dTb7YtznubXgXQZmhldrGcy6U272sMan3UBwGPZ?=
 =?us-ascii?Q?CXm1zhMe6rj/GQd3iXhMG0YSMcXZSPr8tsp5EJ3F+voLvu7+BH8Aaok4et79?=
 =?us-ascii?Q?JC6yHwID5qgUuOPWqMNVRH5fochXBFyVdNX78jt3vGZVfWJPdjMJJ6U3rrHq?=
 =?us-ascii?Q?xVYNhIBOODmaQlIdRZmc2fnUEmiD9Va7iniwc5ICUbY72E/HdQ66JJZtP3u+?=
 =?us-ascii?Q?4HDE68MZ4h0HbotZpIHMtzGvwilZtFdEqrpERMXzbs3mjp053GQYzjDrccEd?=
 =?us-ascii?Q?WqPl4hczidFib5+v2u5flDr4t3Pwv29hHu+dCHuT+JIvNnQD3IxpdsxGAlyv?=
 =?us-ascii?Q?HCzbGNVkH30pmc6tXnHUVkicbxzTJMzj2+Eiebi6fe54N2KtPzKm92KhbDbD?=
 =?us-ascii?Q?DMndrdjEMV1NAMb0SEC+UsWfpCaeHJ5SvzLRqawyVuD4HiPXr2zgUvl0ithe?=
 =?us-ascii?Q?J53TbSoC1C9u4f1JibPrXfd+tL6inWda7q6X6YQlM5Zr2VpKo1bjWJP3wrJe?=
 =?us-ascii?Q?rrjVldQw6dQctrwlzj1InyRbwCoI1OK4umdjQzB5NakePQdGSbQFYugF+ufa?=
 =?us-ascii?Q?Hh1V5sZ1xxJCi9iukrPA+gQRAs+LM4vu+H5OiWZJbJw2NwoQDa5J5K4X4VoK?=
 =?us-ascii?Q?1Nh/aYdU8NpE2BK3nSuf/lFPnB7r2YTA37ODajhSzprvsIU/FzxLiB9iBb1q?=
 =?us-ascii?Q?/3Eq+LT/pmt5ZxP7yrYGH/T/Sf2V+E3R+U59X4+cG2HeYGji3xlOzOZZq3Mu?=
 =?us-ascii?Q?0gE6C/HSoSG3654wRZHQxn91AYPF7nHpUhMdPhXzATx9zfRrHRSTXI1DKZZ5?=
 =?us-ascii?Q?HdWUvYUFi64fBfV5rREr6zhkHFM/4O+oM9VepNgU5CiBHfvORraJVMPq7+qN?=
 =?us-ascii?Q?VBCzPzDSNGM1CuXm5a/PmtJ+JW7v2b44mqbXsb2YSBawVJ9PSmjvHziuhYHC?=
 =?us-ascii?Q?GHcRNypKwfQfjfZX9LGPagVzIeqM9xMTeqMrQ/oCIA2TMES4fbYV+7PYYZqk?=
 =?us-ascii?Q?O7NqIZlr0HSgZy0ShC29CXAgUZ9jdpL53q71Crb7PolNZmqjMFurOwCQbtOK?=
 =?us-ascii?Q?P3FT0JGq0p/+vjx8nnDVTxcqulu8K9tuRXNpg8Rq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee4b7f4-3f47-4619-9c6b-08db82e15fc0
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:07:49.6945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyZCbP2cMOifUA6OC1gRfrAAYb/utPVDemkaupVaKXc9sM4Whke/6j1xZsNMRtWRbn4redKhCoAs/87OKiN+mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6165
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
but the one in ssi_debug_add_ctrl() was forgotten.

Fix the remaining error check.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/hsi/controllers/omap_ssi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 84ba8b875199..a39bf323fb1a 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -115,7 +115,7 @@ static int ssi_debug_add_ctrl(struct hsi_controller *ssi)
 
 	/* SSI controller */
 	omap_ssi->dir = debugfs_create_dir(dev_name(&ssi->device), NULL);
-	if (!omap_ssi->dir)
+	if (IS_ERR(omap_ssi->dir))
 		return -ENOMEM;
 
 	debugfs_create_file("regs", S_IRUGO, omap_ssi->dir, ssi,
-- 
2.25.1

