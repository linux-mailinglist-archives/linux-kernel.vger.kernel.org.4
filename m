Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B242747BE8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 05:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjGEDul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 23:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGEDui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 23:50:38 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D51E59;
        Tue,  4 Jul 2023 20:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfuqiZBhfZhDT8toOYbx+RKyHddX714bo5ACmEl3eBdodGV7KYyiJuMYisc1C2mfvqg+9Hxyzncyo0/+BZoBqUpvbv/vyZ45KwftiFXVUYxK40Zi5hvVtveRMU4xwTL0cUd525G/af5pHyF9E6y89+ooazSm8GP9cjoaCFP/ScsUh5VAXzBg7xnmJehlMSyGW3A5YbYsUEbyGGv460r5WZSuv4WpKkitpDrYWQ/EVSVckB9XkMitktFklJsyJAAsIOoXc3938avt8g/9FkLVz7OspthIZQyyjp3PRtD2f3+U9LgLZnX8joJVvGEKo+yzklFNN/iEO+aX7Jph3Kofnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjReas9bKiUP11qi0YeyruDsr1ooX6zGtb1k2nvWT0I=;
 b=Zv+tDkTjCAqMSw96ject4YqnYMyv0HGb4fcG/GqyTSEWQHP02PywQVVZbyHR7Z53hXNKa7GMKn0JktYP+HPRBgx+TE2OEQ3dORjIxmARBb/LkT8o33tZwhYBnAw9FJgDLw3mAPr/8EfJtCfpbF/WIe6MhIktmOdsSUc/aQefghwQqru9iJQCLIKl/s/mGt8KQMO3P1ByjTDBawWa+EYRCpbQqLwf7ypU6QGGYwY086mpZz7Z0G1sPQKT2EKkjNPdp4qny+EbCq0Mew3j0e/oKEfuSApm+mDUMJQ3PAsGwUxjLoOy3t92B0f9SzsEhGFiz1+2InMm5Mrw1HuZ5a3y/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjReas9bKiUP11qi0YeyruDsr1ooX6zGtb1k2nvWT0I=;
 b=VGjuWSr/2ujGGxJIwxHmg/ZhOaz5Mce7L1EJkx4Cw1DKFUKQ2ptI93KkEdkzGxxSRxjxe591b580tAIn3/IyUxgJoiQ+WnPUxjNfqw7a8YbgaFt+2FmENyeKypr6iiWBYTvozoyQmfa2+ElbZ+QritZT07DVr4LPEwAXjXN6VPpndx2m7/B7zfE7HQ6HaH0RtCzH9x52S0/0h6vjXOB2fprx40qzdTSNJmrQb/NjuxncSgoPtbo64lTKidlNatU3JPlAPIQTbpXUzFKoODI5MLN4I3r30RatTGfup8SvuEuU2hPjpIeEjW92E4LWbSGMiA6+c29CqzrNfysJK3jcZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6272.apcprd06.prod.outlook.com (2603:1096:400:35c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 03:50:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 03:50:29 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com (supporter:BROADCOM BNX2FC 10
        GIGABIT FCOE DRIVER), "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org (open list:BROADCOM BNX2FC 10 GIGABIT FCOE
        DRIVER), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] deivers: scsi: Remove duplicate assignments
Date:   Wed,  5 Jul 2023 11:50:17 +0800
Message-Id: <20230705035017.3262-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8eba92-646e-4fa5-7180-08db7d0af960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RuBeq7FN090FynBFBImElFC0wD7W3HC8Nzg3dfzO+4z+Rdig68Q1aYDdP4P/sXEjf4Ef6O8bxFEnq2jGJmdIA8kGrpKcaxJgaSbAH0xF2OvJChY7x0aZHFp8kbakodokOrWy5Mm8gXUFbPGBfCe6rfpIq3xxzy2hhUN/UdG1fYbprdFQYe6+pHWtvHY3UGfcRq6E9FRqmkq0XFkYWzTh/ZX4zNkk05zWmPaElhjlOuWwEVxqMQgdzAkCTj/YwBlEKCq95nFTW1qe9J8silCalpKGIpQp5wKuQCHMRraKEvN07822hhTxTSVNTQQttRMfQSVhJ7m5Jla+FjaiHmo76msyWxgWov8Fd7FkNX8rFH3+OBzP903hd8FqqcosR/1yNxtvvZWAu1/xnZQXDjbwecr0eL+z31IxUVHpX5dF/ZyxVuHzA6ukEzsmv7pe9Gz+XOR3qDeU2AYSVT82UCOFjKL2P7t2WiCwtMpOkqCbCO+04KKPQnxzTWfKmKEpxO3EeT6HxKDPXgDzM1oz7x0woUN06na5awT5YeHlYUNzMmRQSVr0C4WY88mhi79qe2qgn+nCs+oIFcvpGHzMtvrkK2ahIjd7u+LRkObfvsSPHJtrfYnu5iAiIXsO5YBrK3/g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(66946007)(4326008)(66476007)(2906002)(478600001)(66556008)(316002)(36756003)(8676002)(8936002)(5660300002)(41300700001)(6512007)(86362001)(110136005)(6666004)(38350700002)(38100700002)(6486002)(52116002)(26005)(6506007)(1076003)(186003)(83380400001)(107886003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jiK+aPK/zX3RqCT9Ctu8PNBhhEn4i/wz6GBYqjpiDAG3Y9SYIeB+oq9lB3nU?=
 =?us-ascii?Q?weI8bmJqSje5ns7/oPf8J6aMMyebSHQUv8wZ6h4drg1NQuO3VxQzhUyIBm/x?=
 =?us-ascii?Q?1r9YC2uOaC1oKuuV9WuQ83Ugz6wHb2EN6MU+14u8Z0HXHkMr6kftWPZRK3P5?=
 =?us-ascii?Q?ay5uHpDZcZiTtIVdoBzfbCDCFlwLEDDKu+ovIM1qNMUDLRSO83uZRb3Z/dG/?=
 =?us-ascii?Q?NVG+sfjgSTUIYSGuCudF5HXYOV3MbNBi410M3KX2lScXfOM/Ao6kWGqI7QIG?=
 =?us-ascii?Q?RP/Je9Gpu3OyF+tZSN3tQbdEYBofOShhRoGX9kkwJGpl/2Q+LXs15t+xPG9U?=
 =?us-ascii?Q?7Y0fVtY5xDGtDlU2RY5WjGxcRG4YuTq7LIkG+c7zPtttIvlLsoftrNOryX/E?=
 =?us-ascii?Q?Dq30xY+j76CyFDg/dR6Da1AT0jrFgDXjD10whhGsgXF0K/LZJG/EMS5lvg/L?=
 =?us-ascii?Q?FhreXWOhqOs3PYrAJKrEJGjp9EOoVxbO8GyuTHRA65jt6wCOEO27tQwOoqZa?=
 =?us-ascii?Q?bwpYdbtOjDZcJvSjowDA8wf3e47DqEsaLRpWX6t2KrxKfvdNpY0D5IwoRAWa?=
 =?us-ascii?Q?sGY7uv0iRe757bsAYsXkhGU4qj842wkZ9Ph521h/sWTuyRDBS4hQCwY1EPfd?=
 =?us-ascii?Q?IpMcn3VxXmP19uJzhNP1N3z03G5TqcJ80+FpB3U6ub5Hprn3oG2be2tddsqk?=
 =?us-ascii?Q?14I7kjt4x5jax7cSgmABtz5sM056lc5oinZ3o+ANJfHrIXeHbJWq7Ty1cNwo?=
 =?us-ascii?Q?4+dGK4Mpi+L+/E5dY7M2eWM8EBVhW8P4+F5bcWf8t5xlbC50SldTvxczEvxT?=
 =?us-ascii?Q?viBp0rtFpivmeKmZZIsa8fhE0UQcZ0et/0fbiOemqm8HXICRVXwacR7ag7FY?=
 =?us-ascii?Q?/qY6uEIGgYOKBn0YdHtae7vxG4qrSDlvaRaLSofIh8ys2XfJ+dJldBNH8fml?=
 =?us-ascii?Q?9Z2B5PBcz31lsC5yD10j/NxSUO8hHgqJeahGwXuscX6XNnHAN1NhBXHcMrbm?=
 =?us-ascii?Q?Hj/n6JQXx+0npxtMuaSHiLcuChUU/ebFf8j7wInSzUX++uQysfRHq4dXEMCm?=
 =?us-ascii?Q?p3fM4/Z0wBgychwnORTpc4SRRewrCTwyViwCkPBptSCvf3P7aAoghavabsAv?=
 =?us-ascii?Q?7D57qofIj5V65nF5Y3vWVVifErCgm1FsiQBB5aWfqxesKwGapVOdNRryBsxe?=
 =?us-ascii?Q?ywAJdbtGJgJeVYEXflgC/FG7/TwPiBb2zh8aL9kPnNo+HJKpFn82xxW8I0bf?=
 =?us-ascii?Q?gDc3B5MVEio61jhxDwB8IqrEVy1TDFMN4Pa4A3kWPdqQt/ZKlAZiO1jjROie?=
 =?us-ascii?Q?ENYsY5gUwhk6U3yVKM+puvP6OMLWc8hFSw01YS6AdkYehMpiWiQ0M/haWGAG?=
 =?us-ascii?Q?WuBWYfpor7Zk/Utj5+wvOWBDC76aOmaXx6ifQTDYcCDSYXDFWLLysruzweOO?=
 =?us-ascii?Q?krKNMaG2bT0AmQjhZHXacXM8GckppoL5CZ2vQ7ySdWi8D7JDJpZzSYmQVW/a?=
 =?us-ascii?Q?8fI1j3fH06jnJsMBuAN0b4ENW5Ay2OSAtvoJwrSlTHNT4XQwKD1out0fCVc9?=
 =?us-ascii?Q?GVNIkLXfqFaMzHyIfdIJ12qMCoOa9d2+cJwL0qZ/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8eba92-646e-4fa5-7180-08db7d0af960
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 03:50:29.2802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xkz6BvLSWsoiqGfVLY2pCR51p4YuDZLrHMwwv4xCF69cLulLybokWwZvRvUWnHzRRlRTjaJBTjJyy88LEXN53A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6272
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make task->rxwr_txrd.const_ctx.init_flags avoid double assignment.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/scsi/bnx2fc/bnx2fc_hwi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_hwi.c b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
index 776544385..0474fe88a 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_hwi.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
@@ -1521,8 +1521,6 @@ void bnx2fc_init_seq_cleanup_task(struct bnx2fc_cmd *seq_clnp_req,
 				FCOE_TCE_TX_WR_RX_RD_CONST_CLASS_TYPE_SHIFT;
 	task->rxwr_txrd.const_ctx.init_flags = context_id <<
 				FCOE_TCE_RX_WR_TX_RD_CONST_CID_SHIFT;
-	task->rxwr_txrd.const_ctx.init_flags = context_id <<
-				FCOE_TCE_RX_WR_TX_RD_CONST_CID_SHIFT;
 
 	task->txwr_rxrd.union_ctx.cleanup.ctx.cleaned_task_id = orig_xid;
 
@@ -1763,7 +1761,6 @@ void bnx2fc_init_task(struct bnx2fc_cmd *io_req,
 				FCOE_TASK_DEV_TYPE_TAPE <<
 				FCOE_TCE_TX_WR_RX_RD_CONST_DEV_TYPE_SHIFT;
 		io_req->rec_retry = 0;
-		io_req->rec_retry = 0;
 	} else
 		task->txwr_rxrd.const_ctx.init_flags |=
 				FCOE_TASK_DEV_TYPE_DISK <<
-- 
2.39.0

