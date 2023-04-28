Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABD06F1E50
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346607AbjD1S4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346567AbjD1S4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:56:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342DF59DC;
        Fri, 28 Apr 2023 11:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhtMFMcJedMUdgyy3Vj4cf5y1XldXr7E7Lo3oTJAXCbFm1XjmffkLIez3Y7RPbaAxhsGWkxskH4wHfsilLyWrHdl/tv02uZFwatdgQyemTXplAglgPJYWOtoGOyI80f1ys9/9s/S763PD5HXWm6gxVK6+Sdtp7P7tLwndD+zGGfGpX5CUhptgnYFULoSHoJmMbrx9m17Nje2PZNh3ekU23ODgbrgOu56iAmhyTMtBFPBcAAiJnfhFYtXGZe6QImky4F6yDqqN+3MZHGLQLTbIT79aRts/uCI2jZnh8WQzAg8UEWxiFpgkz9WVYmcucbFDLCYxS/p7Ew2aaTBSByx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdJT8NGzTdhfAe7TuVGd6FYb32oOl+oCsBjc9y2oR04=;
 b=Uy3LoPQQsmBUT9+F4MTe4rfcGT+R4Md72qoc04kqUjUrs8HTauhwTnq5owgbhG8FP/+o5yBLtf3Ji04PEFL/2yem5YTvIu9ZTngE8z2b3EWryrkpBmKNAAyy3ACDExHOhel3/Fu1cCZnQVbRTDi/SkJLmRqYC4lATUL9U98tTLBtiFLjNenjk76hLrISUVWFGvfntY5j1aUKVhP1GblpfD3RD8pj6Ep8DUW/f0340EXqJvtjcMOh6/U00DhKAyqB8DgU384scfFulOtxmJiICPeH1WMRxt+wdH+mJ17DHDYT6zAwUwe0PGsoiwxHUI/4AWK+JJd15d/mRI/MdSAnQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdJT8NGzTdhfAe7TuVGd6FYb32oOl+oCsBjc9y2oR04=;
 b=Qfqzfn04U7AkBTu3rjApxoYIXkxJ4hHwc6cjqVaBB+dI5WexyklBhfkW9e0rW2huHNRTQi7dTEPoAQXIpBJucf7KbyJv4qTAN4gE8Oe5dn8F3sM1A+5weIrGnaF+IDQLbBh0e0ShycVSbB+hvS48wPGP8Jv5WKoZe3pKIgo23tQ=
Received: from DM6PR11CA0069.namprd11.prod.outlook.com (2603:10b6:5:14c::46)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22; Fri, 28 Apr 2023 18:56:11 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::db) by DM6PR11CA0069.outlook.office365.com
 (2603:10b6:5:14c::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 18:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.23 via Frontend Transport; Fri, 28 Apr 2023 18:56:09 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 28 Apr
 2023 13:56:06 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
CC:     David S Miller <davem@davemloft.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/10] crypto: ccp: Add support for setting user ID for dynamic boost control
Date:   Fri, 28 Apr 2023 13:55:36 -0500
Message-ID: <20230428185543.8381-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230428185543.8381-1-mario.limonciello@amd.com>
References: <20230428185543.8381-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT045:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1fbfb5-a809-4426-fdbe-08db481a3b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kdodYmJeeL9bvxKhJBt35CibAV2aqG3obWxG5mPMiZLGz8ZW6FFZHahJ2rb9gHIGSCIOIwZZ4wkVcdS+taa/hCLS/PFt6U7jgHlDGjNmiMZpX+U3yrwXv0Pyb5g0aK9p2Gt8OUwbURZe9lm3nrIw+xX5o/03ZF39LIZpaE+KtkgP692Kco/fp2Od3uoFC9/VqqIEXiMjdNsQTkTJFoSqMDrbAFjLPyxWUyS+ofiJhrmF0n3B8l0XM7YKx93WRNB+wflnq/5GHVwkcDCqtLn6+JdCoIuGJEJwySRgk3gNYpVY6pangsl6ljq85eFDIBgIUC5h7rm2OwAolWkzOEm9f3NLuPxSZUTT+bayxwi4s/H8s8taYIxIJyY6nNJocswsMNbaXLk5/gN2zIgvGdEV82GOidDHDezTBGlnbLYVBLQBBrKXLPx2S4xOhf4OTAMyA756EcpftL4cXDbHvQbp1ZLWeUQfYP+MjBoa//s5CkbTDhXzVrJRtvjGgazlCG+cYxOtK3vRLfUU84ESRm3JqJrwq1qN4wlvx5P0nFdqnmf/RStVmY3NNlkHekyMjtrRdGZktD8KuBvdtKoCXM2BRgJ8YGtgdN0As0mDKQWBV/mL23ZEw5Yh1PUSZTBhgDmGSALqOdRtXZhwzoHllLuefw7sAPsHbKFqcoBVfrJyAWHC+8lvWfoOqaZh1PuWRNwLTBIY/R8RZNqL92PNl1zgJgpEnp2REIBHkTWv0zt7O2M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(336012)(426003)(83380400001)(36860700001)(41300700001)(1076003)(40460700003)(26005)(82740400003)(36756003)(186003)(16526019)(2906002)(2616005)(7696005)(6666004)(40480700001)(86362001)(5660300002)(8936002)(8676002)(47076005)(4326008)(316002)(44832011)(6636002)(70206006)(81166007)(478600001)(356005)(110136005)(70586007)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 18:56:09.9529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1fbfb5-a809-4426-fdbe-08db481a3b0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

