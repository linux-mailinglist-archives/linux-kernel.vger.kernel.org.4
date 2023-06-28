Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AF0740A82
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjF1IGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:06:43 -0400
Received: from mail-sgaapc01on2090.outbound.protection.outlook.com ([40.107.215.90]:52481
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232395AbjF1ICM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:02:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQmUHr5+pIOFD9XItmaHCn7kQ0cekgGsm/wKcI126ieRLIt2i4smjEW44aF5BW8v0qfY89KAvjaZM8JE3spFDx3swpCbSlIUyTkQ52MyBm4nMXoBlNoH3ICYPNf/28CgArUWIDact0iRXLc/iyTCp5UbWgqtmTtDq+CiZKl4VMQUE9LHOLViVusjcIu6iWRsOBXcGYneu0sxVrLFXZwZWeXWoAEDwwV4DeI/uxyDc44af0MLvDSPCZUwgU08olCcMidViN62IzZ/4x/Uqk8EuFYfYgTyI5/26sWBSwvwM7hmS0jIPXjbl3F9snlQsVZv3cDGWhrSi9DpkgcLvg5TPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq8rD+ulC0Si0Fh4BNlbuY1k52oJkdZPdCLk3lJrugs=;
 b=UjvcFjISpWgRUxqYC+k1EUmYisi3TsaDNBd57nmNS8jED3m63h395hcKbUi4oLBGXdzHy+aivBdxOBBkeSvJDMWKLOCQB8Cc2+niJOPpd8E4vAW/4l6yKRtFRYlMgsGxYHG/aq9N/ymmSBSYe3yQ4iNpUs7JtkK8a7ffGQfdsbey+TnDTenPybtoLE9rCqFj2KcKMOUFAHGetcDENb3j9mWRmkLFFNbzivOrTNKOSUZNzQdjW+fO/Px1mHr01n1C6LVtB6pDf7A8dfBg/JYE8aB4gpMy3Qg3owu1nT8qNM/lws9+25ClEV8MW4kwyDcLn8grlhEp8bTUI4Eo15VRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq8rD+ulC0Si0Fh4BNlbuY1k52oJkdZPdCLk3lJrugs=;
 b=YKy0M2j4yMbdBbXicu5Wr02sOJXgWqosiL5B8W+OsCxsgTzWSZ/Tj9uvX5Pj8Rsw2IutFVkGEXW6FhFygDBQPCaibB3v35hZWiIGSveRVHrCPv2CMiCrZUVHHhA6QdlXkUVJSEAy/o5G8uFIBy1gnIm0MoR8WpDni3xCyKWqrMNC4dTeo/G7UC7Y2ah1JdHg/WOgArCM0RL4bK5Bdf8rZNn9xGaz13BLN9zSxYT87u4F4Df+LKmoWtRIX8u6rY6ARqAazzS6R5GUEBiWJ2xUsbDY8VaV0EWUiOQcPM4Xhe41ldx/ZNmdSG9XzKq5VeNCAC4euq14yiQTWCtqEmEcTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SI2PR06MB3979.apcprd06.prod.outlook.com (2603:1096:4:f4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Wed, 28 Jun 2023 07:02:40 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%6]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 07:02:39 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Keoseong Park <keosung.park@samsung.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com,
        Tang Huan <tanghuan@vivo.com>
Subject: [PATCH] scsi: ufs: Optimize the WB flush process to save device power consumption
Date:   Wed, 28 Jun 2023 15:02:27 +0800
Message-Id: <20230628070229.61855-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::23) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SI2PR06MB3979:EE_
X-MS-Office365-Filtering-Correlation-Id: b63aee31-f676-44f3-e629-08db77a5a953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fuIzxtD/TSEowq9SKGU40wxYTFpfl139/lnU/nmlhHIeuf0RBFNmcb41Bci2+rc2HnnvgMNa+tQD3AKLseOPIX0ZSZ4QcVXTTFP0BNPu8Gg3HxcI6NgvMOmfC4NCZgRl9CC/ee0jYIoGOta6jdw3ZSLDvevoqiWwmrf5taeMLfyR0lUfYyz3csavxjI8oHx7xEzs3lgd7nDLPnzBcfa52aE+fWWr7bqOHkZrjKZShU7wzuX9+yc+4UrU1DYuOwVWHy/ytp/DaylHtJLhx/6FZvT1P427CC15ViTWkbN/FUOYdUCZfNibc5x9xqjJyLMyBDoB9UfFCBPYzwVZ7E1mttdRCajLcQCjVaOCFbAhlfSHhDkonBr5j9fs2IvR31aAulvX8PTRt/ijBa7BCFxBzxqfPL7M+2sqv3NUnv3om7xab+8eWVHwaSbtSVqgV1dTXP4OVIeKgHomM2GbSSQ7CqnQrJAw6w7GmoevKBGQWS2PBBcy1AjJuvBdx2izeMqAA8V3kaAT9NvJlmwTku0e8V+OO282UyUPk4ePN5rIdoCyo7SQjbRmbiMC3BZscLdv/OkFtu2RECXE4vqGCa7oCE8eJfxZfNjpkTuUsw42E6wdYRwHUb2REBrV6WHTbdHeD8S0M9ddu5c61uEh0emT8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(1076003)(107886003)(52116002)(6486002)(83380400001)(6666004)(110136005)(26005)(2906002)(2616005)(6512007)(186003)(478600001)(6506007)(5660300002)(36756003)(921005)(7416002)(38350700002)(38100700002)(316002)(4326008)(66946007)(66556008)(8676002)(8936002)(86362001)(41300700001)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jtjBNreCzE06QofNTOUT8d4azKLhGt6ahSh7v3LEdSNfafoh+e2kQhetkIcs?=
 =?us-ascii?Q?dPHt83jnl6Fq+gaX13s9Ve1F8iY8GhuuqGkQjizo5IsbHcX5G1O8uq0XPaNz?=
 =?us-ascii?Q?OMvLPAJLKxej0mMgx4Uxt+OhZz73RfQiR63n+OsGj+a7WfmrGGmIW9VWDn7h?=
 =?us-ascii?Q?ZKE+lMvAkri93TS5CLafjBRw1T9ac2cYQLHPBIoYEUsV2nWKfQ3EU1UoNcSU?=
 =?us-ascii?Q?NRj35jUJZLDBUGcoPgfdXC6FSnjYL+0//gwZwgdyoHQ698/NHzgrbvtNKRis?=
 =?us-ascii?Q?faX5dvmMe0DGgN/b0tnxR0CP+zzDhY0GBb4yX9B2nyl5nPQUoO3ASvTIwk0D?=
 =?us-ascii?Q?2LKQfzagJFK+QTUWGBduIqDYsn3avjhR0JhR4y9gz7X1zAqa1DPtmYWgtQ2I?=
 =?us-ascii?Q?r1oYR9JYmx5LfwUeHJzovTU+pAiGyUE6v4V3NZ5alRURsZSZml+TY6buRzRr?=
 =?us-ascii?Q?rynUTc30syU3cG+GxSHz5qXy4vQQIH4d0H8OWfXeu+VyTYA2TEWBwghhnnJ/?=
 =?us-ascii?Q?W8JnAfj58JJIDRMlboW6qkZM4e1FLn8o57CFB8TXTEZn93cbImLBcpMO8wll?=
 =?us-ascii?Q?ql9xAipH1KGfaA1oeOe3Hxx3Qfr27NgvTUsZwNjOfdTZw92Khj9ugGWrhIoL?=
 =?us-ascii?Q?cEF1ZcVDQTnzOj+wct80lm0a5e1fA8Vn64nQoEbUSY8eR3f1C2D8TSJ94jmm?=
 =?us-ascii?Q?eRKKbuPPxBSfbNy+RGBXsJbaMm7bAw7iBigfltSGaJX+T4VAJHevA/dHZ8pP?=
 =?us-ascii?Q?d55u0brCl+1JNDmUj8hlJBGhRLbR0F884NyQ0UABJMPaJRAF/Aplo1sujCUc?=
 =?us-ascii?Q?G7MAOtqOoFule+dkUmvog+qUziZnoC4m/94OSfRk3zx1DmgoCOZkd6P26oK6?=
 =?us-ascii?Q?GSVOGbl1N/yMposlP+scoNFM/wuEJekZVB4oTIycVJsDBJ0Vz+6sAbBIW0AU?=
 =?us-ascii?Q?qzNaTP/oPfoyUWoob1gurAjolXfCqEdneZXGUXuVbqlh2rspb2aD4ZOC4Jum?=
 =?us-ascii?Q?mfBZ6V4oKHAAklBiaYVfz+kEi/RuV++cJSWs1fuKsn7Ny0i3RAkW9nED8LwE?=
 =?us-ascii?Q?KfAMSsba+eGwQ32+lIRPm4o8oyKNGUTpk7MaQc2U0zpX0g90n6wDCaliEHPv?=
 =?us-ascii?Q?La7NAusRI7OQNb+rWUvSkSlGlowpwmnVMgzg6tUhXdiQ1+7HPmdIXzrjpUDm?=
 =?us-ascii?Q?hUCT7dH+uvXKTIpAN9yNJI2H273CUkM8t2X5GZxjnACPV6kbE5gFYoBV5q9n?=
 =?us-ascii?Q?bSlMltA89K56poGdLRXHrLGyo5nVmVvh4u1v2ZM5gwfr0bFtbwHoLQsoQBap?=
 =?us-ascii?Q?Mj78jkacB6oNzP9tNqN8zBaN8pJFG05rwG7qtRwdG5BRBmzh1J8dsA+0ltHY?=
 =?us-ascii?Q?/Hu2DHiyVZ2CN5GsNN5zBjFFGeJyUYmJgSFetATpbYY+Vb0yI07ejDJSrPZK?=
 =?us-ascii?Q?8xk3qZjM3bjaA6wkajtZXOg2P9VoDUtbDwY1VoHuZg3W6CzduasvjdOKKf36?=
 =?us-ascii?Q?M2TDiWQPV+QCv9OsWudz3MaStfH+rlYwqxhCu0fovsu355ADAuqPJ5gFV0bM?=
 =?us-ascii?Q?elDknrwLJs8+wLTtziLWpJm90/zxSQxuNxFfn8K1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63aee31-f676-44f3-e629-08db77a5a953
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 07:02:39.8920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+G/+XnTzZHT0G8iVKcdZnmexnTVFEj8oSHLZr9zCReccvAOvf1MYAR8hlyj7DUuhevQnUryp5kmy7fg9jZmLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3979
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the original logic, WB Hibern Flush was always on.
During suspend flow, the host will determine whether the device needs
BKOP or WB flush, and if so, it will keep VCC supply.
WB flush is only a part of BKOP, and device that needs BKOP do not
necessarily need WB flush if the conditions are not met. Therefore,
if WB flush is not needed, it will be better to disable WB Hibern
Flush, which could save device power consumption. When WB Hibern
Flush is needed, enable it again.

In this way, the WB Hibern Flush always on strategy is changed to a dynamic
on/off strategy.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
Signed-off-by: Tang Huan <tanghuan@vivo.com>
---
 drivers/ufs/core/ufshcd.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 983fae84d9e8..484d7fa96407 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9592,13 +9592,20 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		 * If device needs to do BKOP or WB buffer flush during
 		 * Hibern8, keep device power mode as "active power mode"
 		 * and VCC supply.
+		 * If device does not need WB buffer flush now, it's better
+		 * to disable WB flush during H8 to save power consumption.
 		 */
-		hba->dev_info.b_rpm_dev_flush_capable =
-			hba->auto_bkops_enabled ||
-			(((req_link_state == UIC_LINK_HIBERN8_STATE) ||
-			((req_link_state == UIC_LINK_ACTIVE_STATE) &&
-			ufshcd_is_auto_hibern8_enabled(hba))) &&
-			ufshcd_wb_need_flush(hba));
+		hba->dev_info.b_rpm_dev_flush_capable = hba->auto_bkops_enabled;
+		if (((req_link_state == UIC_LINK_HIBERN8_STATE) ||
+		    ((req_link_state == UIC_LINK_ACTIVE_STATE) &&
+		    ufshcd_is_auto_hibern8_enabled(hba))) &&
+		    ufshcd_wb_need_flush(hba)) {
+			ufshcd_wb_toggle_buf_flush_during_h8(hba, true);
+			hba->dev_info.b_rpm_dev_flush_capable = true;
+		} else {
+			ufshcd_wb_toggle_buf_flush_during_h8(hba, false);
+		}
+
 	}
 
 	flush_work(&hba->eeh_work);
-- 
2.39.0

