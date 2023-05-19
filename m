Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18586709E14
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjESRaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjESR3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:29:51 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF92810E6;
        Fri, 19 May 2023 10:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHZrWaW6PV0xS4OPG/fTj5zujrEuwjEhWrtYfXfiPSeEofgXwetnRbfIagb957oWvxnIvnF3LVFc5syDgkk/7VgyuawnlDd4XmZldijMs+n79DgEN1hU7d4iqdGwDwvTnJWJdwL9JWRIN4PrPkwziX9KY1ACrBzLz/ZTIGi6t34YcI7n5xF1vdRoSa/eG5VjhDH969LwHXNy4MLlZ2xv9BxRvYL9P9rID2mwTOwMYjQZ1nfCFJmY4eUwvNeSpj42DLyvftKMMZEwgF27btyuR6fzncTkJA/JOXDVh8R1aLL3//fFFiD3eJrFDNeucIpmmgtDjcpPZ4oRZgOs5nR50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdJT8NGzTdhfAe7TuVGd6FYb32oOl+oCsBjc9y2oR04=;
 b=gCW1VBippQRyYZibfkjMkv+O+X+MjID0JIMKg4B6I06N2PIj8wZ33I+ZfSMOTROIR9cAZlcqUl5VCh8BjxlEDuH7a9WHd92Y0XNSt+qcYBmVvZNCj36pnj3zOjelUUtnWLFOyWvYOcPybE7HHaG6JO/k7V8eH4830yjaS2wb3DD/kup/OL6/l+A9EXXTWhWksODGNSEjPs45MEuAESyufn1aXzNCCUSYz9f0+Rm5n/E1NgfvXSh5uaPmm/6ozO+LB1iEGEGRoKiQQSys/XcBxONeXC7CAyDN5qG5k87oXHEQ9lY8WI+FFRQ+UazxDrJtx8j6ELwI3usOsKhaYDampA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdJT8NGzTdhfAe7TuVGd6FYb32oOl+oCsBjc9y2oR04=;
 b=TWJHE0TMOk43X5NMJVnjH00ESJ0OlyjAsjZ5UNJQzaEoIPbS96IVL6qZCkeB555oamrH7lTIyEhuuF3873SivaLBzFps+GWupVpyPaK2y8UR+tUMqZGNzga+ew99JbDVLW5++y60/4jiV6ReKde0jP226aLl5AXLUlOK2IV0FDU=
Received: from DS7PR05CA0104.namprd05.prod.outlook.com (2603:10b6:8:56::16) by
 PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 17:29:06 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::1a) by DS7PR05CA0104.outlook.office365.com
 (2603:10b6:8:56::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.7 via Frontend
 Transport; Fri, 19 May 2023 17:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 17:29:06 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 12:29:04 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     John Allen <john.allen@amd.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 06/10] crypto: ccp: Add support for setting user ID for dynamic boost control
Date:   Thu, 18 May 2023 22:24:44 -0500
Message-ID: <20230519032448.94279-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519032448.94279-1-mario.limonciello@amd.com>
References: <20230519032448.94279-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f8b4e9-db03-4f7b-905e-08db588e8c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MWCTCQ0JpnQNv652O/974rpsYHUA77PBzB2tapZ/exex671Dhxw+SQPWvS4FR5725jOJn1RRuGbC8ml3ZQyRJM7GQQ+fNp1bjsb0OknMpPw5uTBqrUGhrad7gXDuO4TlfxBhL57krNMti0NW75Vuib3YvpGr5drQlSmaBMnWbUfRvOaPsQfKElh4c2kXVBe45nPCIfU6HRyOFN7cI/xmuTgF23NgHa5Luu4qRRo13BgCC28HqEyb1HXw5FE044iQWuhRBXiJ1XwA7I7hxRYYKj4qr/6QdUW4J2Xjz7lxUaYlk9atDh5iSOGJu/E8DnOlTpkMeAc/MSIVhnH1NWmOmB0gLWhnDu+Kj/pvjgFzoFVsoHqeDAOyK2iwGYwuG1nzXpNmYSU3RwDDsqEucyIYqY6dFdfktpptFOurK3PC2mT3kfOvRymxU8wPXARiSgv2L487RSlDawQFq0K70sqputVb6Ps7NKvdeqHwBpVfWhKUphYtVwX1SmuOCxpO4gk+Z9XIsi9Iatwi6pe9BO8YCH2iuB+nIQiIYxYFBltK/cA6lyHcRxQ/AMnA2k9w8rhPI1sDJvvcm6M2wB8wdTmXacEJ0ZdifOk/vVZPFYbAo13qlf+XMC5dqKaCxfugXurSZ0MISIre0eYgsZV6L62UXyuzl5AODK+UWBDkN/ncmp7kPpS6k9lcEE5EXuQBgb3P1tH4CIHjhpx2cGYPWDzMjjIFXy5OiKt8GK8OAo9+3lBCaES4ulSre2qYgzEyUuUUmXZO0mz9vY3R9gatviJVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(16526019)(70206006)(70586007)(4326008)(110136005)(54906003)(82740400003)(8676002)(8936002)(40480700001)(478600001)(316002)(6666004)(41300700001)(7696005)(40460700003)(2906002)(86362001)(81166007)(356005)(26005)(44832011)(47076005)(2616005)(83380400001)(1076003)(36860700001)(186003)(426003)(336012)(36756003)(5660300002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 17:29:06.5752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f8b4e9-db03-4f7b-905e-08db588e8c5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
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

