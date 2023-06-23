Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253F973BE6B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjFWScJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjFWSbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:31:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A242727;
        Fri, 23 Jun 2023 11:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceBxR+koicDvpRVcf1B+K4PcW24qBvylC8bHoFVV6ZJk3TckXzPDEK1CYARrNmGkbOcJ+p60e3i/55BT+BLiGg1busH/d1+Pe1NkmHYBHXg1WfTPe96o/UGK0jQUbdaybJfzlbcEMgNydV+7z9sTnI1RgqgnVD6S1gltdia7qK6/nIeRrl9IdbZRM7m7/YPGWRxhCbeScsogsb2JNLk5Mp2sxlrjc6OpHpRPRstVN0G7E5eDlZ3/lBa7d1m5ka2h/ebMm7F9J+O7C4UHZ9doFkY0hAVO9JKAl/xLnXyqWc9uqaXdZxNRKPgUksL8HWbBXSB6uR3FEHBaVDFiDAr0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRQ080FMENJAmw6hyBgghw242ayQ8Prt35zVvOq5f7I=;
 b=D5xosZo9QM1B4dRX+/E0BSpmD7Gr62A58vRa29SCioxw8QnCr9l+YyH1002REunSkKUE7mCW0fbuXBhkNR9X11JXDBr3ERNOf3kMQ8rzN8YelXI0EvfUlVTGNkxtRshNwjCP0OcdSUWAMUgfVNqCDHuDu+RIUcALOsZc9o7IMOwcqI3TyGS1I0JEuqLTwAawv8E/Zso8Tmw0iwrg7pgxKk568dicgnqtpskzh9M8+pbAZ6alrYPOeDkdQd1BysFCN9Wx2zrKGER6kh1UsReQvDk3Q2GqXfYzBKVe3hTrTTDhm8fhtuHJwdhpORedzI6I+fj1odfI3EEYtCfdNbb1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRQ080FMENJAmw6hyBgghw242ayQ8Prt35zVvOq5f7I=;
 b=dwyxDCk0eOjf10GG8WC1WAEn9fd/RAHBP41DGG5FMdylDlVdjCh81OKSmP1zcxcAgmipSxiyYLaHmJ9Hc/LQlZ2p/2enYV8Au2ucXbIwSEinePUG/coKEh7i2JNIu0vEtmBVH6cIbK+l7EXxfGA2pcrIoLrywStV14csVPy854g=
Received: from BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::17)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 18:31:38 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::ed) by BL1P221CA0021.outlook.office365.com
 (2603:10b6:208:2c5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 18:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Fri, 23 Jun 2023 18:31:38 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:31:36 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 06/11] crypto: ccp: Add support for setting user ID for dynamic boost control
Date:   Fri, 23 Jun 2023 08:49:56 -0500
Message-ID: <20230623135001.18672-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623135001.18672-1-mario.limonciello@amd.com>
References: <20230623135001.18672-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f385ff-5f08-465d-5d81-08db7418153b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X94UDGjzgTliIpAFI8ts1U9RqlptS3LhzHz+mQh0f7RVFwKlfPoVY360LVGr0KRP2lbgF5oM/NegmCWBHTVRUx5Dk0oO3S+hvOZa32+ZgL1PXGkdOoR+7g/ZYENjPlG+HiDB4LDTLo8ZPy/s+ywDg9ok2m9TeWL0O7/Lon8oZRsjhBbg8s16QdFkCGIMHSQFpJKvnWoTMWiqrz/e8v9MNjivo0GatumqTeIznRN2+GazjUR2/asNomCZlR9meZaxACQ2q/MMjUScJryr0AVkjaXxdvu8i1dUtQo0Z8aMU2WwSJ1ceUJlXy+LPhfh5sWP3D2RPdA51+MFfGC4AK87/an9pFi5uTp35euUsTKr6zgn3P2nPiRvAvbpC7cOXYh/+gjRUXwWIJSwz/qME/LPaFo5WomRGYiWRJceIYFxhFu3xb0QvwM0/lsuJgJkVUWqvJBVI0CyRVaMzoIaBt90yrDG3+T38qK+UuxOyJly1pxAlY/U1xdn+sfleutXq7OnHrkoydJWuShkXxuC5ZDh6ySFByXPhcjFzpH5NFi6YH6aygSTalcWNrHh7iDJ5a7NXW1BNYXPNxr1V+uFPxqfK8bOorHpL0Iv1iYf1zdHFwEAELwBdAZzh9XK2u8TBeA9VyFTGGz/2vZEEbwd92sSGmcV3uoVi2fagvmj4Jzgf7Fm5JxPGO5hGlfjs8+WAJMZ4wEHyTwwJB/rIuA7fHe9Elh+8QFmFgKEE8XTiQpF32/sUVNJAg5pSI7kYUdUybQhWpadsQV3fMlePVwsKo1TtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(82740400003)(356005)(81166007)(86362001)(47076005)(36860700001)(83380400001)(36756003)(40460700003)(110136005)(54906003)(41300700001)(7696005)(426003)(336012)(6666004)(4326008)(316002)(70206006)(70586007)(2616005)(1076003)(8676002)(8936002)(16526019)(26005)(186003)(2906002)(82310400005)(40480700001)(44832011)(478600001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:31:38.6837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f385ff-5f08-465d-5d81-08db7418153b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * Pick up tag
v1->v2:
 * Update commit message
---
 drivers/crypto/ccp/dbc.c            | 18 ++++++++++++++++++
 drivers/crypto/ccp/dbc.h            |  6 ++++++
 include/linux/psp-platform-access.h |  1 +
 include/uapi/linux/psp-dbc.h        | 20 ++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/drivers/crypto/ccp/dbc.c b/drivers/crypto/ccp/dbc.c
index f65e93a81e53f..c6f5fb3658ca3 100644
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
index 1c3a0a078d156..1564351000761 100644
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
index 53b4a1df51806..18b9e0f0cb03b 100644
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
index d032f78934e27..7443c78ede199 100644
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

