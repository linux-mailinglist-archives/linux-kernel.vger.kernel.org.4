Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E14749990
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGFKhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjGFKhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:37:21 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2117.outbound.protection.outlook.com [40.107.215.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA10124;
        Thu,  6 Jul 2023 03:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDLW6m+bDaXmcAV3gIC7H2EanXTigEAYwMwI6WIhtcYqbMjdcEHyRZaBBV7uIs4tvypQuO2GrLj9Uh3UQ2tf6WFdzPttN+QuCmdd7QTPU+B+k41qN4SgVjq77sTPvRNFTSYiiDcPNwW6wN51rBPqHtOtHCUJqK79n41uFALMuKEuT/DFzd1ysLix+MYRXJRf2elpbvoP1nL+Oe4nrC8et733kknhT9AgNHxxsTOVc9khB/G18gjlXzAR6/qz8pHdHzm4QTQg+q+yhSOo4T8n0utNbmE75lGB77htZv6gzeX/S1ifDN3aQrhBZWPMOV503TSaJ+IlMZAUbJP0el9Znw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejgToEWihrCK7b5HVO8WEpsVu63YLH0wB2CQ8V0E2LU=;
 b=PVZ70E7uP2jTFPb24TmDMTVQVS98doK0C6tPyfJJqw5O870mCMSwA6PicSoR3XYUG9jTqKHnHWMK0GktNNB6I0nHStMzq8c8qY2IZsj2oU7JPV6JR2Rb2q2IoKdFRdpvaxQQL6DTPYIkgalAnP6PQ86K54QXthdXfl50iUeTWU5QG858N5rvMOkQIW2uTIlqx/Xw+AW/KLcoLENCGg7+KjjQ1gmlJZYJGxppsy/YfejZwvmww+KyOXQST+heuD/R/qHVMiCQyakKyDESnv8kPvNbn4DrWuWNADrq3jsBZlLvs5hHoOLoysRlvNZl0z7x3At7+BOuwI4jdXOKEi2KFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejgToEWihrCK7b5HVO8WEpsVu63YLH0wB2CQ8V0E2LU=;
 b=owzkynOUHLFTCTprft6zv3FlxUoTLIhP00BLbB08yj0EY6N6qERCDZL/Q1yVoTBaEPonIwkhjW0DtgRoK0jUWba6utgSoZBWlzhkaML/DIGjvGKs7ndD9jeZ9pxc6KVrlWPXX5IPEyuWMCSlrYLYWAe0aZm6l401VlHZ/rEJH/PUAno9HtxnAfF665RGGpT2+U7VKlYQcAtNDQ+nsZfrLTOQxmhYg/1cjD8Sf+RV5/Nq5/BFLYr1UI086otGHifJmgzMN0gP0U27GpejxuQcPK/JbJLxC5m+ryZTnIyOD9n7GiMSYpdtDpzfCGLp9tcNN5Ufw7zUq9GbPfItqMvvCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5706.apcprd06.prod.outlook.com (2603:1096:400:272::6)
 by SI2PR06MB5068.apcprd06.prod.outlook.com (2603:1096:4:1a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:37:15 +0000
Received: from TY0PR06MB5706.apcprd06.prod.outlook.com
 ([fe80::d6ff:1295:38d7:a019]) by TY0PR06MB5706.apcprd06.prod.outlook.com
 ([fe80::d6ff:1295:38d7:a019%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:37:15 +0000
From:   Zehao Zhang <zhangzehao@vivo.com>
To:     anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zehao Zhang <zhangzehao@vivo.com>
Subject: [PATCH] scsi: bfa: Convert to use time_after macro
Date:   Thu,  6 Jul 2023 18:37:05 +0800
Message-Id: <20230706103705.79755-1-zhangzehao@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To TY0PR06MB5706.apcprd06.prod.outlook.com (2603:1096:400:272::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5706:EE_|SI2PR06MB5068:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8e26c2-4250-429a-b994-08db7e0cf70b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXqGKW+4Fnb6ET4ZYLdDjd8sRMZC7AW/gbn3A1ck1LSm3ackZfrbtCd1plH+XLxj0ah9vNCS3rbWCrIdKWaiY/lw1VRHgQcIEqcA9kRafUtpdkM8BXlY6nUN7Gz3X6n6o8jyU1JtgKAL97oXk2p6saAmqapmIOL7NAHmrCOvfLY+pWrjj3/dWGBehXxsd5wPHGO/JcwsqrwHz/k5+OTul+hDhE0VhEZLmtjnXLxTQ2BoZNZuj9AwI2PcBXoRAe+dHCtB+RadoXJckk7cRAM25b4nTwSy9XZycOmZAOnGzbAor7sk50iFu6kZgRvagVE01zA0YHNZ9eQTctaR7ZbhSqd743ByLTmIiq+6Q+y3j/nNuQNZ3fhQtYV2EK1lm/cMEYoYlpS3rKmsGmnvZQdu5PrLOfwdcetUQNeivPVXLRQmJyrs0BZIs5Xy0jpSc5Kh04tabTvwQFg0L7vTmJCgid7M5cOv5JjeyNmiL3fqNRFZwrUTxXl0+dBFjfcguGi4Gz2aUyLDSEVHdiYTjxM4CtOYuCObyWGhh2qKtslhVeVRaJWP4wgl8urhKoXIWNQWwGfP4+qQcNuwMfaat5XxgLigxdMBgsavLsn0YHjIDkDPHL4fKxH/ScOqsvru4yEA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5706.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(186003)(8676002)(8936002)(6506007)(26005)(2906002)(2616005)(66946007)(1076003)(5660300002)(107886003)(41300700001)(36756003)(6486002)(4326008)(316002)(66476007)(83380400001)(6666004)(66556008)(6512007)(478600001)(52116002)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?itnHJSlOeofPowbnhWOlUab5GAfqZnLQ8wcu1jT+Mlh4R3frwX3oZ1DIrvgh?=
 =?us-ascii?Q?Xo4enAZ52/qRIJCPJosbAGP1s37kDSXtp/4BhHd3zrlOv1L8ZQFGkY9f0Fjb?=
 =?us-ascii?Q?IIwBu2HIKUf6ZKE0PaTozisoF+707TjNQngz7cEJFXjUJULea5iBXjyoCem8?=
 =?us-ascii?Q?h4bZtcjhrxWjyATOfc+I6zYDKBUsEAVNHJzym0NYsbmXtpf78Qz8cxH68ADs?=
 =?us-ascii?Q?CfNx0uyKR+SqCFiJNjH52Qf2zcfjRyZ4Tcbg9y++Q1U1vAMD+Rx4k9a4OAZm?=
 =?us-ascii?Q?BHp5r8hxy8V9oOxTdJIsIMLlJLOsmMUCnj7+9IYb0LJKL7JEVejUd7D4BDDn?=
 =?us-ascii?Q?NpPWYcoIFcQkaiPfbumpH65Hi9atlzHuhN8+9+7Pu4RCz3TU/tAdQGJXpOkk?=
 =?us-ascii?Q?iSX4LPrSJE6qaKFsyuwfHjA+AErdQSkZaz+VEh83SVA5jpXMcm3as3XUWgR5?=
 =?us-ascii?Q?5oNlfckG6yWMDbRcmi9aPiibIJwethVroDaJm9mqq1126ei+0/3zU/ZW8uF6?=
 =?us-ascii?Q?s2EQzkDTFWGmR2gLwRmGiwwliaf/26pbz71yUii57LQF0iZf/SYjqrJiXMLr?=
 =?us-ascii?Q?mZzTdwjWMcYzTl4H+xnIH7+0hW0YDOOsL3rHwt4h4UeEKePVyHClRixImwdP?=
 =?us-ascii?Q?ijs/WpQMtjuIgaAJNySM3AmybivftpurRpiv33xDWKKYJSZt5Ic3BTedC7kw?=
 =?us-ascii?Q?Cn50gxCEu6agmgTA5eTC3QkXNbsSVxMPZIy6l7LOHYpRAfvDvsGpQiqcNwZu?=
 =?us-ascii?Q?JjbzRJn9h/1TN3gbZcyg1XITSd8xTvc5MK15ovS1ThtiHdVuM0FGOLFwBUS+?=
 =?us-ascii?Q?NfMm2LtblXC1gBwdTMabyQ1sA94A8LI/ZA+JTRuMjzqNjh+ZCw/lLHPsHypO?=
 =?us-ascii?Q?9wuyGSbnZxX3Nr87NDYLQ1yNROIapGYtFrDIsH4TbcrdwQgFcUDdRpjjBPkr?=
 =?us-ascii?Q?BybFzdDFQ4NVcX1FgYkYzJoFU2bxuui1tCGWWehfMT857vr26fbmrUqfBq77?=
 =?us-ascii?Q?Bo+mFbUWvagFjhgWcWcvPKljzPOg+hZEdvvn5H0/WlXx9RxtWLLyaP8tAWSP?=
 =?us-ascii?Q?4vU80GL44LrwdoJZJ4OyZYtXiw60BvBb7wF112VhDGqERfrN56Bpcar66S/O?=
 =?us-ascii?Q?GdyqLyWF5l1/bBfkQYjDNblOad+BLysQUu9BYQ/QZe9yYYL9RXuKZGC6E3lX?=
 =?us-ascii?Q?DFFWg14x10LW1AcDaRHBbcGbA1prq/Cxz6CNg4c5XzzrjVrf1VGyYEb/mDjN?=
 =?us-ascii?Q?DDiIjrlyYP0udaw2TEl1HszAnCNQmmtEaQRxcrOWat2pZazdAVhuU9K/fT/+?=
 =?us-ascii?Q?4+TFkwJi6dAKdnPyJFZzZu2Dm8wTh7o8Qc73De1E9a4iknTZ0AfsDdmG87Vd?=
 =?us-ascii?Q?PEWm5C/Rxt5UWuuIUeb12l2zHvHYkaUWaSMPhGeNv2WMdIlYuhQuhpWyT3bP?=
 =?us-ascii?Q?Pgp2yi/TbDrA+2rXYzI8dH6QOZ9Gm/bV9pU/DzeSOS6+f4oYXVQagkeILnPx?=
 =?us-ascii?Q?vKhLi5iOf3fBsgbEsGL5NRX/HPQ+W2Gi/S0BUjF4dyq0u6AWVqet+90ZFC0r?=
 =?us-ascii?Q?aAmUkDGC6eo/ih/ibb+KH5UrnFaIsXKY4aOjbXb0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8e26c2-4250-429a-b994-08db7e0cf70b
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5706.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 10:37:15.4709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oB6LHT6iCTkUBiX0i0yVBFMo0oyFWTqjEeiJeSgcOgdscAnTQx4fftGtkp4MYG/5qrlv77tH6XjmopbwjhXW1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use time_after macro instead of opening it for readability.

Signed-off-by: Zehao Zhang <zhangzehao@vivo.com>
---
 drivers/scsi/bfa/bfad_im.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index a9d3d8562d3c..c1a5f527b04c 100644
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/jiffies.h>
 
 #include "bfad_drv.h"
 #include "bfad_im.h"
@@ -870,10 +871,10 @@ bfad_ramp_up_qdepth(struct bfad_itnim_s *itnim, struct scsi_device *sdev)
 {
 	struct scsi_device *tmp_sdev;
 
-	if (((jiffies - itnim->last_ramp_up_time) >
-		BFA_QUEUE_FULL_RAMP_UP_TIME * HZ) &&
-		((jiffies - itnim->last_queue_full_time) >
-		BFA_QUEUE_FULL_RAMP_UP_TIME * HZ)) {
+	if ((time_after(jiffies, itnim->last_ramp_up_time +
+		 BFA_QUEUE_FULL_RAMP_UP_TIME * HZ)) &&
+		(time_after(jiffies, itnim->last_queue_full_time +
+		 BFA_QUEUE_FULL_RAMP_UP_TIME * HZ))) {
 		shost_for_each_device(tmp_sdev, sdev->host) {
 			if (bfa_lun_queue_depth > tmp_sdev->queue_depth) {
 				if (tmp_sdev->id != sdev->id)
-- 
2.35.3

