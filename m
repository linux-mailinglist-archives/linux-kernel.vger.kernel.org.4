Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F3D6E9996
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjDTQcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbjDTQcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:32:17 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD491711;
        Thu, 20 Apr 2023 09:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kih4XmTveQjRZXe3GTqoZ7vJOtrfXKkEFIU1L9fVNfNGRNfwaBVPSztkAKXgKy82sJfH9+IYl3gQjOQfy10jEx+h59ob0b/MoeAputLtggnygsr2dAY6eCTt4ci8Hdr87kfmYkwPYBmDp6vYbTn/Bzi9IWYHaYBfjhX+cOvjPwdSG+aD3PrudBOjDqQQVCRSFA5MaTxySCn2iK12Wryw5U6T+R9vOSH2cHAMQrUg/ZjPr377ISgbXPs0EYzkhyCwZD1aZGYxdlBGMTVkdAxFFm7e9Z3B+aOTKM/Ywod/RlYpaFSoERfcGhDWeT5dxfEloRrp3G55CeWA6ArAe4eJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AxmwsspBY+a02inqk/oy2ghT7n4ZQQaI56gq4KLeQM=;
 b=DGuMH1Ryvto9z9k9IGX91Mpsum433NVt2UDPPALJoCSZUabNodCAfV0HderaA7GlCGlTORhNoyGcbYIGL+NlFWud27L4X4A5oFSoWKsHPD2MmPf2LIJ5sOBvlhH+CCtaXhwjoy6EjbTIRRhYL4OtcOotqCnJ5f5jZeHCwg4E6/rKlpRSPPvyg0GPYnjGhVppC3mZX95wHWzw/7rx9k7+9Fs1JTHS3r6D0lRD6hJ+w5hOgRDf0x2on5WoQwWtaut8Bbz82NhnHsIooHSgIZQz02W+M2LnNyQvaAySM9iSkt47c3MZcLIqfhRffxl3GGEjBM93pphgCdpHUmcjIjMQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AxmwsspBY+a02inqk/oy2ghT7n4ZQQaI56gq4KLeQM=;
 b=h7V9aiF7EF7war79wg0aX8nHQjxj6Hz8WOTEfu/Mc02icp4liSaBDmtTIXSbCJd0WiWHefpy/Pl757qESaFPAm9T3xrN2w+QvhydpL01t9xiHvNg1B9st+oc7XOza5g+nHe+tl3IZIDfm7iFNhN+pkBgkXG64m9MlZkEqkPDBNQ=
Received: from DS7PR05CA0074.namprd05.prod.outlook.com (2603:10b6:8:57::22) by
 MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 16:32:08 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::28) by DS7PR05CA0074.outlook.office365.com
 (2603:10b6:8:57::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11 via Frontend
 Transport; Thu, 20 Apr 2023 16:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.26 via Frontend Transport; Thu, 20 Apr 2023 16:32:06 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 11:32:05 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
CC:     "David S . Miller" <davem@davemloft.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/10] crypto: ccp: Add support for setting user ID for dynamic boost control
Date:   Thu, 20 Apr 2023 11:31:34 -0500
Message-ID: <20230420163140.14940-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230420163140.14940-1-mario.limonciello@amd.com>
References: <20230420163140.14940-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 1985492f-a8e6-4a81-ef99-08db41bcc7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBfuZLkIge9ouGWLWuL1ACXaXFG95EPa5fLdZTZsTaMt2QnyaJVVdE3vPjvPydeZNgCfhFVnefX4fammxrm2oGBKZbAArbht7W18kgCxxetfD4jpMdYOVFhiPHk08pdo5jzOtNJq16ga0FMC5h0JZw6y08KoTODRlPm0QPJK+2l9cHpNKYKw030ennoTZHITHo8apzXYULJe0OTFiHgxf5IAHPKF6FT7nIHlz3GAtC9lNoSQIQwrOrJYLicaA6Ps14IM6zCEvTMHH297TD550IvlsJie+xiHkUIGNEIIEjlBhoWBW3T38bE7aifbvyNJxqjONf7TNoEpgWaNQKdoXFO7zV3XkBratakYfAI4/hwNdBdNbVoUVZFmER3kpuMmCvizwbNnbg/Nayf/lmoNgYo5qKbavBflaUvfsIt6ek4zKfxAw07eihLsXQEidYn9+YI98bHFwRCNVAMQkrszvBvhXRtrm23DqVhPGbPOmPNflTV+4BH+UkwH2zY4+UgR+w8Tr0jFNp746EIhmPLn3U9yY/ZG+x0BMzQIbLeVXbILUh6L87AZ/5SpICW6skDP3dqbekGN2D9V/TektZ+tYbuEBHaJv1D3UPz9eNDJdjxmGM1b6v2uDL8qkVCLr+dBpmBPqpGCyLvGGBhvd5y8zHhvXHWEwmJrZqZ7CiYP/4XXjTa2z4F8H8VkrAvK57G4BqaUvWauMGjLSwm08rYhVj3ysozG8M7IZIh0piDaduk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(2906002)(41300700001)(5660300002)(8676002)(70586007)(70206006)(4326008)(316002)(110136005)(8936002)(44832011)(54906003)(6636002)(478600001)(7696005)(40460700003)(356005)(6666004)(40480700001)(26005)(1076003)(426003)(47076005)(83380400001)(2616005)(336012)(36860700001)(82740400003)(82310400005)(36756003)(16526019)(186003)(86362001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 16:32:06.6847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1985492f-a8e6-4a81-ef99-08db41bcc7f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the authentication flow for Dynamic Boost Control, the calling
software will need to send a uid used in all of it's future
communications.

Add support for another IOCTL call to let userspace software set this up.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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

