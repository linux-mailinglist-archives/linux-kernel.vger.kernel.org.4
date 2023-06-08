Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FB17287D8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbjFHTN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbjFHTMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:12:52 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC0030DB;
        Thu,  8 Jun 2023 12:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Azdp+2f7y539KYi5rxy59RBwed1t+2wG+ADNjcjUudrfnZKfXJSgvRY1KS4v9QzvbyRhkf3KlKvePw2bGk4OYpYKZqVBx3WxF5B0QBphMqnJNr14x1EceW/4uDl8SLcpGDB6CHgb0W7UiEr/5rDXvPWPAG661JSspkMhyrKWm9HknVXaiUdnwFe7NF43jfLcpNFjl/x6R9RIy8v+AzvNenDjFUvFom2+/X7pTbrKNg+Pc5Aqx0HLnNnYrmUQ/bQsOp8Y7vHqHeLdzbjlOm0fpgE63w65IsVeHy5Pchb3rxPnRy5DfmWCHKhrsBjtzR6WOUDP7j5lS6oFTdZq98lMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdJT8NGzTdhfAe7TuVGd6FYb32oOl+oCsBjc9y2oR04=;
 b=dEIlhtJch0efwQuX1+uYTUgV+dlEe1+k8vevqoOuf2beDJK3AsWl22A3wx3NvC4vN3ixIrJobGtyA2j+setpU67mIhCqq9nGZCyXMHtwblyAjneHBWfimQ3sqzhyaC5JQO+JV/L/L8FbNdFFbsem5Onlcj6qdwm9AZ9LVDRHYa6I18CAOf9S1l4PpksnT0+l7M5rOmSljPJdipc43m3ODVhhHWhr3M3qIvshXGGbg5Kveu/KxbqFO1EvXQQYSad+4Y+HOGYSzLWQb+HEZL6G+rK8nwEXLMhH7iyNcWB7EaWy8r9aWPxZcC1/OSPdHQdvX/79cHm8+hEfk605ZUbiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdJT8NGzTdhfAe7TuVGd6FYb32oOl+oCsBjc9y2oR04=;
 b=FOPprEihnxUBA7Dtz34f03aW3g1e2lmdM6X8iyK/i6/OJL/YmV8EdMwmnhKSMEHIptW1LbjRD7TSD1Ha1wNPgB6W3vK0xDgZnJ/mOQMz7TVd9gjUdb4ZoBWAIF6HG5S1Fsw5pZ4fZ71xkbpPcyiIQ0aWnA0AbLVTFYbXiSfBqcs=
Received: from MW4PR04CA0259.namprd04.prod.outlook.com (2603:10b6:303:88::24)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 19:12:32 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::ca) by MW4PR04CA0259.outlook.office365.com
 (2603:10b6:303:88::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Thu, 8 Jun 2023 19:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.0 via Frontend Transport; Thu, 8 Jun 2023 19:12:31 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 14:12:27 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 06/11] crypto: ccp: Add support for setting user ID for dynamic boost control
Date:   Thu, 8 Jun 2023 06:17:52 -0500
Message-ID: <20230608111757.32054-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608111757.32054-1-mario.limonciello@amd.com>
References: <20230608111757.32054-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 874229a5-7bc5-40c0-1d77-08db68544f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1cAVvh1Q5BpQLe3FHkmr9U4GuYW2JfHot4EftW3nqqfb6l5Gfz/+2b14dg2Ajq/8y3u8sOFUPUK8l7mLV7UekJ+q4McWtCWrnCJT6qAZanG+00BGBk+8skdTyU6sm6ZJHefEx/ZmbCAC0CbJdRoVbmjuMCkE7a1fI0+Vfqdgvo4PPdngxi3s8Et0ZpRz2itLgpQpwKY3rryTZjhoabvaV0SdXOO1r1CtHKiPQIackdGX+L/+PAeNJ0YUmnOjWSyNz7FobKAPrprVeHHkDIS5yFR0STml9Zg5ndZ974ydSwPVq99jCAe6rBEmeFPwAq8f+fD5FNAd64DTUkK2J8KaGOCZSyt6GVCqNYCbpQp6BF1FJ6h59X4JXnKvm8AE2CI5YzaOElHWLbEJxqsz5cB+QrEV36b7ChGcD+beQrgX/fu2nif2ExZKSTUQVYYX8jCb1focEW/IxYha+CtSBuBR/F765xcq9CFiiiDzruwkeTEDFd02uxHgvYhn03T8OqBrnufBK4jbsSmZJt5CIxi3PdFFWBFGDWuYs5YL88jimBKRhqzPSmyaciZIwuvJ44IJxYp9PFEsq7iOHv9Y+Ixp8008dd9uVPkoF2QMu/Y2zx+I2qQidAH9nKAHhAL9b0utf62L57Z0BuSF6thLvODxlQnzYqqg4DjxxHWoZJP4kLvwgaD/i3THgPhN6Rh+h/6sYkB2kFDBgZ6o57MUl+u0ssx3hJ7SEik++K+92qMRVrgepiyrBbIMyRBUrAC9yrO91s+PLVdTCsolRW4lhxi2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(54906003)(110136005)(40460700003)(40480700001)(478600001)(44832011)(8936002)(8676002)(36756003)(5660300002)(2906002)(86362001)(4326008)(356005)(81166007)(70206006)(70586007)(82740400003)(316002)(82310400005)(2616005)(1076003)(41300700001)(16526019)(47076005)(26005)(36860700001)(83380400001)(186003)(336012)(7696005)(6666004)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 19:12:31.9039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 874229a5-7bc5-40c0-1d77-08db68544f53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the authentication flow for Dynamic Boost Control, the calling
software will need to send a uid used in all of its future
communications.

Add support for another IOCTL call to let userspace software set this up.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Update commit message
---
 drivers/crypto/ccp/dbc.c            | 18 ++++++++++++++++++
 drivers/crypto/ccp/dbc.h            |  6 ++++++
 include/linux/psp-platform-access.h |  1 +
 include/uapi/linux/psp-dbc.h        | 20 ++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/drivers/crypto/ccp/dbc.c b/drivers/crypto/ccp/dbc.c
index 7afeca903136..ca7ec528536b 100644
--- a/drivers/crypto/ccp/dbc.c
+++ b/drivers/crypto/ccp/dbc.c
@@ -117,6 +117,24 @@ static long dbc_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			goto unlock;
 		}
 		break;
+	case DBCIOCUID:
+		dbc_dev->mbox->req.header.payload_size = sizeof(dbc_dev->mbox->dbc_set_uid);
+		if (copy_from_user(&dbc_dev->mbox->dbc_set_uid.user, argp,
+				   sizeof(struct dbc_user_setuid))) {
+			ret = -EFAULT;
+			goto unlock;
+		}
+
+		ret = send_dbc_cmd(dbc_dev, PSP_DYNAMIC_BOOST_SET_UID);
+		if (ret)
+			goto unlock;
+
+		if (copy_to_user(argp, &dbc_dev->mbox->dbc_set_uid.user,
+				 sizeof(struct dbc_user_setuid))) {
+			ret = -EFAULT;
+			goto unlock;
+		}
+		break;
 	default:
 		ret = -EINVAL;
 
diff --git a/drivers/crypto/ccp/dbc.h b/drivers/crypto/ccp/dbc.h
index 1c3a0a078d15..156435100076 100644
--- a/drivers/crypto/ccp/dbc.h
+++ b/drivers/crypto/ccp/dbc.h
@@ -33,9 +33,15 @@ struct dbc_nonce {
 	struct dbc_user_nonce		user;
 } __packed;
 
+struct dbc_set_uid {
+	struct psp_req_buffer_hdr	header;
+	struct dbc_user_setuid		user;
+} __packed;
+
 union dbc_buffer {
 	struct psp_request		req;
 	struct dbc_nonce		dbc_nonce;
+	struct dbc_set_uid		dbc_set_uid;
 };
 
 void dbc_dev_destroy(struct psp_device *psp);
diff --git a/include/linux/psp-platform-access.h b/include/linux/psp-platform-access.h
index 53b4a1df5180..18b9e0f0cb03 100644
--- a/include/linux/psp-platform-access.h
+++ b/include/linux/psp-platform-access.h
@@ -9,6 +9,7 @@ enum psp_platform_access_msg {
 	PSP_CMD_NONE = 0x0,
 	PSP_I2C_REQ_BUS_CMD = 0x64,
 	PSP_DYNAMIC_BOOST_GET_NONCE,
+	PSP_DYNAMIC_BOOST_SET_UID,
 };
 
 struct psp_req_buffer_hdr {
diff --git a/include/uapi/linux/psp-dbc.h b/include/uapi/linux/psp-dbc.h
index d032f78934e2..7443c78ede19 100644
--- a/include/uapi/linux/psp-dbc.h
+++ b/include/uapi/linux/psp-dbc.h
@@ -18,6 +18,7 @@
 
 #define DBC_NONCE_SIZE		16
 #define DBC_SIG_SIZE		32
+#define DBC_UID_SIZE		16
 
 /**
  * struct dbc_user_nonce - Nonce exchange structure (input/output).
@@ -34,6 +35,16 @@ struct dbc_user_nonce {
 	__u8	signature[DBC_SIG_SIZE];
 } __packed;
 
+/**
+ * struct dbc_user_setuid - UID exchange structure (input).
+ * @uid:       16 byte value representing software identity
+ * @signature: 32 byte signature created by software using a previous nonce
+ */
+struct dbc_user_setuid {
+	__u8	uid[DBC_UID_SIZE];
+	__u8	signature[DBC_SIG_SIZE];
+} __packed;
+
 /**
  * Dynamic Boost Control (DBC) IOC
  *
@@ -64,4 +75,13 @@ struct dbc_user_nonce {
  */
 #define DBCIOCNONCE	_IOWR(DBC_IOC_TYPE, 0x1, struct dbc_user_nonce)
 
+/**
+ * DBCIOCUID - Set the user ID (UID) of a calling process.
+ *             The user ID is 8 bytes long. It must be programmed using a
+ *             32 byte signature built using the nonce fetched from
+ *             DBCIOCNONCE.
+ *             The UID can only be set once until the system is rebooted.
+ */
+#define DBCIOCUID	_IOW(DBC_IOC_TYPE, 0x2, struct dbc_user_setuid)
+
 #endif /* __PSP_DBC_USER_H__ */
-- 
2.34.1

