Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AEB75078B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjGLMHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjGLMHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:07:15 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2105.outbound.protection.outlook.com [40.107.117.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11161173C;
        Wed, 12 Jul 2023 05:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1mefHQf2ze1DYiZQBOsxcYR1z/nBePr2HgVePpiMQbjIGjemk9WEa0HiPBRK2C++3tVR+RJ76mQc3grE3rfBdIM4ORyiluRZqNk5Mu3l4G8P41GNds2k4XjhQWW5cFtDFPyeFqLtyYMOK+BZPoB4rCvGBw0+rpq91xnfDQI8C24AE0SmsVrEzl0JdOinynknluQx1YUY8YC4YBfrX9Y+b3VfxCFH4mGeu3wRpLvFJvhq/oEo777Ss3JLZHhqZ9Va7yKUbHRTthzpfK+1RAFnhXHqIc66lO1eNvJO/oy6xHFGJlPWY0VQJPo+dumW2bdbSiSclNOb7N1jjK/faqw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQ12MmXPB3KdD8MCgOW11tcx022XEmxLtG9ABgJaaAc=;
 b=N9lxx0O3jABtaT5EwlICEbZZ2BO2iseVWCJFmqjOLNb36HiegNdir9puY1NErloknvHhVM58jvKn0xAByHS5XxcKJlFj8gSL/5c9di/LfuuH+li9qK2U9r4dXyYqa3gdsX5F0RhV3wRL1eMBuLxxNwLE7w9qBGg49q0HKlvWg2rEIV5Dtv3KiOXoKsltGg46X+q3xbALeDCn9ppLFJhedYu3JFIhfVIGsnKBatTigiOXYur8pmGJezWBVkn3aqkakQhVrRjDfTf7BbuOIfZCky1b3DQYMx/HhfxknHYOU9Iizje1Uoey0WIPsy9Q0MzV4kkQSSZeBVY4zpZxedIKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ12MmXPB3KdD8MCgOW11tcx022XEmxLtG9ABgJaaAc=;
 b=o423FxQobLmHOJ+YkTa4TJBNZWCB0YBGpEZGcusPETfLcLn7RKbjU0Kg9pB9OhCijpkd8PUhZXHpFgc9Pl3HcZN02lSaDgkuGmrBp43SaAsMF6TUM0hhOWjOwUfqBGraachIsCuChQwMij8HstnNCU2XmGBhznbEA7NjFOdtLIlM1aUvV3xJw4dLWNxpERHmKAqo7SLkPkQog+/tC8Mk3zaZfSe7Jx2E9X8K3MP8jrk2I5dopdsgFrQxH7WVLOYhkLHOziO5SvIWNuZptpPyBfHYttWviaUt5fScGzehVvIHgrjXogDYBX8HpOUJfk2QqoLiqqnGUSgI/s2rB8e79A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYZPR06MB6499.apcprd06.prod.outlook.com (2603:1096:400:462::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.32; Wed, 12 Jul 2023 12:07:11 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 12:07:10 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com (open list:MEGARAID SCSI/SAS DRIVERS),
        linux-scsi@vger.kernel.org (open list:MEGARAID SCSI/SAS DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drivers: scsi : fix parameter check in two func
Date:   Wed, 12 Jul 2023 20:07:02 +0800
Message-Id: <20230712120702.14054-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYZPR06MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: eae128bf-0042-49cb-a7d3-08db82d0857d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+tgjhjE59LUNO72wTJXprohVTXL2FTlrq+mSkyB5WdTFETM++MEK8z1P/357UTczvylEwSC+m38I5lPGJ3U/4exr1IjbCIsuwQMmbEC/X4DJ+MHgdsFYDPYSl0F8l/z5T8nRBEX7OC30di0reuOIqGeMbbPn3TjrAASjBSnFA/ldxn4zsDkNfj4mSIbwvxe7DPeqvD8DH5HFea7bDuZ0SFbkI68tRinGCTyeWx+D5hZUdlRseEHzF8J9BZrsb2BwUW7S1rJaEemMHiYmuUTJ81YIViWA9ecw1DVSR90kGnOxHAxgnhBvM2UkjPFMHGCu9jZhr2R/YeOn9uQkHHYVmFsMHHmV5X6FtyShpmF4CU6Fd39S5u/gWQtpwqajGnDA2DwZEFxtrxkKaF4en4I+pNo488m907C1in7wUwOaO9phC5lgfVafZHvno48AV0TNFra50vygumCpqriN6gCzRN16VrCN1JyahOEG3buQQppSDLrbmlPLlKUX/BcPLIiKzuzwir3o7hRqST2JLIJseTcxdJ6QJFnk//uFt9ocZmpiN9OV4h0bcv2FCMg8MojAkf/LODC4ZjXWIrHI+ABkCd7TJXLXg605D78Xk3CU0V5I5EHWOVNZKet7cSyaneO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(376002)(346002)(366004)(136003)(451199021)(52116002)(6486002)(478600001)(6666004)(110136005)(2616005)(83380400001)(36756003)(86362001)(2906002)(186003)(26005)(6506007)(1076003)(107886003)(6512007)(38350700002)(38100700002)(66946007)(4326008)(66476007)(66556008)(316002)(41300700001)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aeZ/YOnoJpaW0iVmFqsVZjtmUcbU9o03PAtmCtFvKIrp+6h3nO/8CIHdpfKm?=
 =?us-ascii?Q?HmdWbeSPMzFgnIL/AeUwnrEKtTIhGRQZhPrXzS4iLOXBKTG94A5HbLRtctMj?=
 =?us-ascii?Q?si9V7GtHouywtej8RXNfI4ZRx8YJhUJZJYJLB93zWSazREjHuwe4T0kqUG9Y?=
 =?us-ascii?Q?4gCoo9Ze0pahSJnROflA2WwN8+72o9g27JaZ7lKtP3qjRYIrK0UxCyg+XX2F?=
 =?us-ascii?Q?eLA/n5r6DepvyMTDcuQ7FW3FHorSeqsCkbxLy4B4YUcUlGuVFgTrW3MO3N36?=
 =?us-ascii?Q?ujt7+oAU9X3XUzbdKtaToFSXKAX6AtymlesOT+DbF6c7mq1dYYH3eN9373qg?=
 =?us-ascii?Q?892lkzJSaqVQOaz38+u7mirPRzLuB8vVNrCDnprF0ye1NULwY14MonEgm8dp?=
 =?us-ascii?Q?U95e1tRbgKejkiLwi7cF2j2ngjPz/LRKA4f4Wm6YEPnZ3/r7ie0vWy7JmjHV?=
 =?us-ascii?Q?XlDNcWNU8y/NXA4ZBeBfcXvURQaCoO0NVZmiDUY6VCZUwSjhSHpx4DM7oC6r?=
 =?us-ascii?Q?OR9Of6MKFJ0savl1YL0OjKzv0X22za3HVD27D8PuoMTU+B0fnqz4wBRShCGU?=
 =?us-ascii?Q?VYdjooyA4xBi5GK2rg9zvtrF8TS5iP2SDL215L82mjEJ5mWGLQEAiay5Iip1?=
 =?us-ascii?Q?E67qjoBYnGOObuptZVylfE8RqsS+qMKGKpKtl3TZ+0Jz79zpKHLY4906f7dr?=
 =?us-ascii?Q?mmVSniJ8xX5bLmsVpGwTQVdD66HgswagdQh6KPQmTMWuEaqdwNbcBQBQm9ZU?=
 =?us-ascii?Q?p+HRnhRNENYU2ouaVZr06v8CYsT7Y10UsxYGsdzo8F0dm8Hw3IjToFEFDzvn?=
 =?us-ascii?Q?IypVCHQz3L2EMROHuWPkaFWMZvL1r7NoS7A9wum+/x+xsGKgO/jQ2TfyU05e?=
 =?us-ascii?Q?gMrT5a77yhdvsaufFdG1f/URb/8GdDuWz+5+r2B2d2lf8pRG/7etBDriOzqK?=
 =?us-ascii?Q?x/PJ5KR3mghyhB6uSW5fbc81jKSDRpPwOBNljlQyVnyClxH8DEd4GuiM59N3?=
 =?us-ascii?Q?PWLldQVIc+2PI/YRED6zzEhJ95t6QNtD6xk1I6KfQKQq8LPNShIAW7cElKUQ?=
 =?us-ascii?Q?ls99t16V1SOfwOpetJyeiV9uILw4ZOJ8iX2EauY5it9a2p/ZACGjUmadjlMy?=
 =?us-ascii?Q?kelspUapLPNRjVpMLSD8YmFCjZGuCOeiO39hYo5jDn33VMJ/agellCRkdJ/2?=
 =?us-ascii?Q?c5ajVRR8dNt7WrgyEqoNyBTrMyU1y68uibxrWPrGVlOxAflvc4hEV2p/xpWo?=
 =?us-ascii?Q?qETh1vjAQM4Vda4pspD79aan5UntVDAUE7eiIu6zHvOY4FD1K1iUgxfbghUa?=
 =?us-ascii?Q?2Rega9U6UI/JUgJnAcZYxhPq5Ds2vzuCbIovNBvDoB3wQVqJz0lfQFckKaeA?=
 =?us-ascii?Q?ZUaADAjO6TcDliR1ZUAvBkLh1x8NhUHgTXqTfJ5QFUz1ogQwYHBFyDxs1pD/?=
 =?us-ascii?Q?OzM6eqVyOWaKCclTxjDI1jN7GOPZUvgFsGj1orbqoESNn2tdqWoa+3rlYT3k?=
 =?us-ascii?Q?ZZrJ+8dO97rVoIzaFNEv8HZ9eHFpoS9/LXb3Q8LDsrb/1Gq5n7EO4itPsX6V?=
 =?us-ascii?Q?U8um5pL2ECP/R8klcQWFn0XQA8BBjl08KRFRsbUE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae128bf-0042-49cb-a7d3-08db82d0857d
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:07:10.8882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmHLcf+6bZwWriy17PoE8TcFtgmDqq9FLXyVRHML7MsWwfBiBCZZ6srs5CUaar9weQzQZZXEZePvzZH2CKBwig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6499
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
in megasas_init_debugfs() and megasas_setup_debugfs.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/scsi/megaraid/megaraid_sas_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_debugfs.c b/drivers/scsi/megaraid/megaraid_sas_debugfs.c
index c69760775..b8b66d590 100644
--- a/drivers/scsi/megaraid/megaraid_sas_debugfs.c
+++ b/drivers/scsi/megaraid/megaraid_sas_debugfs.c
@@ -102,7 +102,7 @@ static const struct file_operations megasas_debugfs_raidmap_fops = {
 void megasas_init_debugfs(void)
 {
 	megasas_debugfs_root = debugfs_create_dir("megaraid_sas", NULL);
-	if (!megasas_debugfs_root)
+	if (IS_ERR(megasas_debugfs_root))
 		pr_info("Cannot create debugfs root\n");
 }
 
@@ -132,7 +132,7 @@ megasas_setup_debugfs(struct megasas_instance *instance)
 		if (!instance->debugfs_root) {
 			instance->debugfs_root =
 				debugfs_create_dir(name, megasas_debugfs_root);
-			if (!instance->debugfs_root) {
+			if (IS_ERR(instance->debugfs_root)) {
 				dev_err(&instance->pdev->dev,
 					"Cannot create per adapter debugfs directory\n");
 				return;
-- 
2.39.0

