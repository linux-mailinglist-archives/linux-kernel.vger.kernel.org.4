Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AC4728E41
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 05:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbjFIDET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 23:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjFIDEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 23:04:16 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528DF30E6;
        Thu,  8 Jun 2023 20:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksnllbSX03D0VKLx7wjpzIwQpE8bg2uLWmSodvp9g+s8c4tKgKYSuyyKkiU/A7ayjEZpvh8wp0rbZtWKsJpOYGdjNcn5wEFOmuZsHZXEOyYraQOzMEA2UAbVcxVCeiUK14VEJoiCMDEa4dG//PzjqFaJ8M3r7byeMNLvguKx5pTrQWBsK6cNvnr/AohAOBcEcjDzt/sG0XEirJtIFNj0sk5nRxspMmUFl+3GrrbAPzIv3DTx9jzUwS6lLF9lo5KBR7ZKNVygeB7o0UvRb2RSpAgTKtXPsjaxRmNqfGZFFEmW6a2NTcQDCGQ79EqRYTy3QtraBwIWMsx7QwhdoxJxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJSMSdx5JwvRGCBxuStVU0/abTWYaTUHaT8a17vdyT4=;
 b=oapMHGiNLDkDNbd8lnFZMuksU0xtD8oWP1NOG+YaLW3C59U0cIYeDlb0K1y0KgfUDsvmabeZ8kLFDcu+ihrwIuoLOd8zQOXc0uTJF0ioQQzS7haKbRqpILYgP+sPsX2KxNmK3tk24amBPLaCxHafUqs9UOdsrAsyIUaE0oQ/Q2Pi4sSWpDH1udJm7FHPYwFv7PgsOo4fqd0OEgrV/TTBzYvCIc7C3tn1gk1PSRJCXn/dqMZTCnPkSXYmPEnxS4YfS06MXMpKKZsRLKnoNPYJt4kMk0dTAG9kyo07Vp2XVV9U4WaNt0AayoQ6ztSVHQwRE4NP0JUqPW04PwXyi5iOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJSMSdx5JwvRGCBxuStVU0/abTWYaTUHaT8a17vdyT4=;
 b=ZjNAq0m2aXy9HL9ePKw8LVcMqxEeDtqUlVvZL8006SHtSDhptqUbMJ5p6B78ruSWV1lH7gS5254NpYk+RCewH31n58PcD32hEBDpuDtTCJAYPlA91MBhJjUSfjRmSZJLsVKo5eNslBVblfoosWoLIMUiPg+fOUSYNty0zc3HneEDhcLgCmnp2kBdd6eeQvVVlqLPEUCCH80C5xT9J5PWy1DPHOMQOncesRJUF7NwSGLhSwXy96XeNqnUEk1Go8QkwTWQWwMbYfBXII6Mypooz8MlZYg85JCKxgDd+g/FYzaZOopBg7h+N7S3Wm4VfhPe/qFYS8+/p4L5MilpxpPomg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYZPR06MB4318.apcprd06.prod.outlook.com (2603:1096:400:89::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Fri, 9 Jun
 2023 03:04:10 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 03:04:10 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        Daniil Lunev <dlunev@chromium.org>,
        Peter Wang <peter.wang@mediatek.com>,
        linux-scsi@vger.kernel.org (open list:UNIVERSAL FLASH STORAGE HOST
        CONTROLLER DRIVER), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v3] scsi: ufs: wb: Add explicit flush_threshold sysfs attribute
Date:   Fri,  9 Jun 2023 11:03:55 +0800
Message-Id: <20230609030357.64360-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYZPR06MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: 084d4f03-0cdf-41ad-ae05-08db68963267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4WPK0vRbxzuxH7uDr3CsVh7gE2TRWnUPyMlcfy5+Jfaa/q9BAyUvRGktKb/SrmgbG9zNsyvEgys+7oOJUSbTBxkOX6Ky/BOVFoLqPlkeTMiF/QUtPXDZEAjdjhD+7afN1+mFtKgUYzIbRLehgPKhM4k+E+7aRXXFbm47WRBF+LucDNruObItc+6oG6yax5FVognAAA4+UrmoZ2TBhEA1hX4U3Yqb2XH8/FMvYavoHQQk/WK2sYJH1n2IiY3DRtad7x1QkkIYIx4xPx5IEQQL4LqLptEGZEmmZ6QsvuGpJyHUvFiuTMmyy0pUkorrPlr+rNY8T+XtuQpTujzRk0mYrr/p/WnnrOqQ0fUT0LP1booaAOnyN3Iq6Z+1Hbe6yDmf+q7qhTEe378UhXXt98llDakdk7Ea8hLWLSwUZ70dfQSnwKYL8ptZxuisV6uFCcF7NqdVQy4uhvOlMQRpd7mpC8f5fHbtgsl3V/i/e27EaUKPS+U/X9s7A4N4xSnAC3PyvK2zUMFSetwzG+fBP43yln6H4KJQh/9me1oMqBuKYlv4gjkMxc26OycdcXl1s4ldoMC1P1XIbXdGJ1uJfOWE79S+X+R/9E7OscvCbK5PyU48U6Gh/VU2BgOvFwtbRTXjY/EDcIIgcwvlTc6/e2S+dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(376002)(136003)(346002)(396003)(451199021)(478600001)(2616005)(41300700001)(86362001)(26005)(2906002)(6506007)(1076003)(6512007)(186003)(5660300002)(110136005)(6666004)(107886003)(8936002)(7416002)(8676002)(38350700002)(36756003)(38100700002)(66946007)(316002)(52116002)(6486002)(4326008)(66476007)(66556008)(921005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j7b9s3w1x2/17R9XNakWb/H3R3xC+T6XG9kY0gTww9A0SSvf+5iIIhF/nbKd?=
 =?us-ascii?Q?JpgqyEdKDbGVrytKAmjWSPwIz3kvY3ouVbHJx0TW7BghMcgyTzfR8UiXC6Wc?=
 =?us-ascii?Q?RZJvmZW/NmxUUPnOeksA45QlKtQDdJP9BOL9TraXrMEHvzDOB9XSijy0FeOc?=
 =?us-ascii?Q?kLeQnaBah3N1wx1+ehgpgUI7cv7kJQeinEjNBIO41jCoXbbZa4s1V2iV19Vr?=
 =?us-ascii?Q?VtBum7trL4o1oqXlDmbQ+/CmMIy5wnLwNYDtM7HFtaMRoS3BDiJRLYOdQB6l?=
 =?us-ascii?Q?dvDP71b8XmlO+LJU6OxtoRf6aMkzih3NKat0GZz9EnuzeLi399ba1mhIcFEX?=
 =?us-ascii?Q?nwbRhRapzhijwdxaK4I0Dj4W28COgyScW1KzJHcVi2nAFWdxgk6WbpQhhcMY?=
 =?us-ascii?Q?SDvfuX1WtH7xV7q4r8hvvrhxx7/gyNWZDUlups2Bd8yUbiTSuXOJeGoDcDC4?=
 =?us-ascii?Q?W1JBypKHtbFtDGr2I3K7ZqEJFh24SoNBtvOS4WlMtfDvxp4LUEa8WpIiApg/?=
 =?us-ascii?Q?4Ui60LS4+ZGRB4WPZqg38NUbDLiVckQ3CcqVqMXr2JzmOXjFVtHtABQDz1er?=
 =?us-ascii?Q?ZqDZi4l3UJ0+t05FLCCzeiHVRtjGNSEPoCIb2xlvrWgUGfJudQqn/jRCFW1B?=
 =?us-ascii?Q?N1Zqq/lHzUKW6U/iLfRZ5DN0UBvizv3Uds8Py42LtJraPdCrb8Gu7poWRqls?=
 =?us-ascii?Q?PAf5WsoiYDZM6kFCGbFJBN0N4BEqMfO+c4Y8jRJmI1WQ/1OuIx+CBbYpys7E?=
 =?us-ascii?Q?eZc7S34mVcvZM5+rM/4r2gAIZCOHsGjMQXJxW4y0EoyEqIl9DwFVdKLhGflN?=
 =?us-ascii?Q?geaS/pvnnMLprc1BvOurGxbUf4Qy+982RhVfxbNXrSOGr+4TIjdzKTBr0uMl?=
 =?us-ascii?Q?FcG7hPXDmL0OrUJ3cF7cCfVnrakh7fFO6KcF34Hc3vdh17RM9SWS6RgTOIz4?=
 =?us-ascii?Q?o35Adp566P1+uNCWUtdQdHjrpMlUo1Vmk1X57lbxzc80WxEMSfolzxn7alfN?=
 =?us-ascii?Q?c7ytg82HTvb1lpLiZeDUP05vgrjMTAqCPw2/z5hBhgPXWELsilQkwqay3t93?=
 =?us-ascii?Q?k/8uvCk2zAvveyShAIAfyLOR00VLfu9Lp64k3ol9u7Vn0GSCH1xe+8xJzivq?=
 =?us-ascii?Q?OLmtRddIUI+YElsSUcqbOv5IVUuTXREsq//L8m04cML+T+/igsyK6tQNUGOm?=
 =?us-ascii?Q?4BC7Uvcnxegdcbet3i9GsKe4MHZOCC0n5L/G09bAYqkSpkqnN5uLlON5Wnsm?=
 =?us-ascii?Q?HBij+xugg2MbudUDblCyvGfpZCFzAuGhfAAyTfpG1DCeOYfga6O0pYiZljIU?=
 =?us-ascii?Q?yxXKX9pUiNXWKF4Ul+yS70BghmoUQZ+7Fcv8ysBvqzDoOYjkTQm1TCW79Poi?=
 =?us-ascii?Q?stE9L7qBQ6TbbHwtL5wf+J1WsHyXNDcIFCbUBHN5L9D3kTWDic8Im7OAAAnY?=
 =?us-ascii?Q?Nbp3K53pVIDxO+Y8vKCrP6sSl4OqV2daaHgwsOqb6BWS4mK2zWGgjWPuJqei?=
 =?us-ascii?Q?gUlTRlgaASntzF5JmzRoyMYpwV4B5OxaiZuwSXihqTeVE2afDdsf8a+h5XoJ?=
 =?us-ascii?Q?PGQdVmbOcUBcg7x1jlxfaYogyXvCQ5G/e0sjxLMY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084d4f03-0cdf-41ad-ae05-08db68963267
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 03:04:10.5121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wq/4qerwqlZOoDhmKrUXeDEVscByPudhmdviUz7n6xQHr8140hGa/fF6bMsNBh+wALvSi8ASgUc2bBhmB8i2Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4318
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three flags that control Write Booster Feature:

    1. WB ON/OFF
    2. WB Hibern Flush ON/OFF (implicitly)
    3. WB Flush ON/OFF (explicit)

In the case of "Hibern Flush", one of the conditions for flush WB buffer is
that avail_wb_buff < wb_flush_threshold.

As we know, different users have different requirements for power
consumption and performance. Therefore, we need the ability to manually
set wb_flush_threshold, so that users can easily and flexibly adjust
the wb_flush_threshold value, thereby achieving a balance between power
consumption and performance.

So the sysfs attribute that controls this is necessary.

The meaning of wb_flush_threshold is the percentage of WB's total size,
such as 1 representing 10%, 2 representing 20%, and so on.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
The modifications made compared to the previous version are as follows:
1. Using 'wb_flush_threshold == 0' insted of 'wb_flush_threshold <= 0'.

 drivers/ufs/core/ufs-sysfs.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index cdf3d5f2b77b..347207f4e8ee
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -298,6 +298,37 @@ static ssize_t enable_wb_buf_flush_store(struct device *dev,
 	return res < 0 ? res : count;
 }
 
+static ssize_t wb_flush_threshold_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", hba->vps->wb_flush_threshold);
+}
+
+static ssize_t wb_flush_threshold_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	unsigned int wb_flush_threshold;
+
+	if (kstrtouint(buf, 0, &wb_flush_threshold))
+		return -EINVAL;
+
+	/* The range of values for wb_flush_threshold is (0,10] */
+	if (wb_flush_threshold > UFS_WB_BUF_REMAIN_PERCENT(100) ||
+		wb_flush_threshold == 0) {
+		dev_err(dev, "The value of wb_flush_threshold is invalid!\n");
+		return -EINVAL;
+	}
+
+	hba->vps->wb_flush_threshold = wb_flush_threshold;
+
+	return count;
+}
+
 static DEVICE_ATTR_RW(rpm_lvl);
 static DEVICE_ATTR_RO(rpm_target_dev_state);
 static DEVICE_ATTR_RO(rpm_target_link_state);
@@ -307,6 +338,7 @@ static DEVICE_ATTR_RO(spm_target_link_state);
 static DEVICE_ATTR_RW(auto_hibern8);
 static DEVICE_ATTR_RW(wb_on);
 static DEVICE_ATTR_RW(enable_wb_buf_flush);
+static DEVICE_ATTR_RW(wb_flush_threshold);
 
 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_rpm_lvl.attr,
@@ -318,6 +350,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_auto_hibern8.attr,
 	&dev_attr_wb_on.attr,
 	&dev_attr_enable_wb_buf_flush.attr,
+	&dev_attr_wb_flush_threshold.attr,
 	NULL
 };
 
-- 
2.39.0

