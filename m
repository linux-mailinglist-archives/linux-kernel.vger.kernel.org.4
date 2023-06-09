Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734F9728D36
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbjFIBmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbjFIBmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:42:05 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634021A2;
        Thu,  8 Jun 2023 18:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNZcybybGUAMZNXrl9EQn6d7ezksExK2xD3d1EGGxcC0PbuRH9dKn3Vd/950wIv7lKGSD7w7K1tlGMV3ZcwfR8oq1FUh7saSW6nU387B7q/4rHU4oZr87GJ6LV3RTBAoUtyYaHbQkTviTVxrKzjWcVzegyURN+eDsb1G8tTzqgKp0QxfxXg4HfLVwe7UpAyeAvYDBUABzzxN7LGB0D9WEnV3fAwmz/wS371VjUZ2ZuEBpm5Dl42LKPMzmZXDltLU22zyOdf9BgK+b8bsNGQWShvadVPCjs14VXCCXIkS+Fth8HLDGUi0EuxY1t66tqsCMe4K4oDZ3M0pQ2U9G9bq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGkJK8pXHzITxcegeswTvIGTSbVyWlzSXnQ0ryrzCqA=;
 b=SIT0CsbdKsblRFgrYqqsn9v7YNaMtS5vDHeUsoOSFOcCZU9nfXM60eMDoVYkAtIgLCvF5gssEBVLxprSZKMKcbsKQk8+ghNUyRad2KClsJNQTfiCaj33K2jsZNQ+h7Qr70tlzVI6H+d9YVs285K1Z14IL8xxPHm6BJ9++7xS1sBnVRZf4bKgLF3jeyQtucA4nQAI3bS4iSMBJS2szt36hgYvJAWwfzObX/USJqH7/TvJ+a+c4qxBH4+5qvowwWr0fRO6gPG4LHV9GfNf4Rx5FBP4kHcRfdHnEYjOFj69ddGnqkl7kgPT5bg4/TgsVmYjYOslkyPt8gEFNsI53c8FSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGkJK8pXHzITxcegeswTvIGTSbVyWlzSXnQ0ryrzCqA=;
 b=o/n6u1Sv38AZ4yIs+4IK2IgrQF7P0n2duPZlS09sWt8Np/2Rts7DxRBYmpEFmEdNB7JnPuUjW3yd62b/kSiXLcWgGvrn2/RYTVfCFZQfL+f4QXAH4e446PvCa5bKJsgn7SWh5omm+eezE79M7LxzX0a1gqVVLX9tDPARcGKUWOaeQZNvXRxR4Y+zIULgBom5kSLsc0XLKb1xn/1wtNe5kFvB2Fqx384RxPTiCxeenKu3an+VfUvPnBT4UcX62YsDk4EPgncVmYjWkEQ9Yq1aIFtt+8RzqTCFfMLnHQtQjSZGh68b5vqFUv+VFNETqEaqszR9Pd63mzL+dXbshWbvZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SEYPR06MB6277.apcprd06.prod.outlook.com (2603:1096:101:13f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Fri, 9 Jun
 2023 01:41:59 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 01:41:59 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Daniil Lunev <dlunev@chromium.org>,
        Lu Hongfei <luhongfei@vivo.com>,
        Peter Wang <peter.wang@mediatek.com>,
        linux-scsi@vger.kernel.org (open list:UNIVERSAL FLASH STORAGE HOST
        CONTROLLER DRIVER), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2] scsi: ufs: wb: Add explicit flush_threshold sysfs attribute
Date:   Fri,  9 Jun 2023 09:41:44 +0800
Message-Id: <20230609014146.45934-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0195.apcprd04.prod.outlook.com
 (2603:1096:4:14::33) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SEYPR06MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e2c2681-91e0-4016-7195-08db688ab70d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gb3Ag8X4takXDwfPfRIxyvj2umloYC/OjW3lcSrHKHOfADzsAVgwgtpKvprwvwn72uKNDf7zxP5ua7h0fU9Aut/JheXSnw8M5dk8zD4qbttZ1STtqGxchp8FmXR/d/MknR6yFycvgLNfkeDQwENo4bzWkmIRLosegisoIGQltQWLDPdfk0GbGsJyZiiUaBUcu/f2mQvbsQW8zQuWWQ9t/XjfuKWVnFmubxPvKCpZMWbZ5ShFAmXoLZp6xw2bOF3LRMyKDa0xWCvzYqv4gPoAdROzr9M2rLjy9EQphwo3lY75nzyz4Lk2oOQ/3KwBBJbUnZoMSlubxZnAoUy4v3W1HEO9qHEn7eYqlJuVPFv5yFOGjWyeZbQpj4ZE4tQn64fsKf6nR/BkpDYKCe9eyTaDhYfuj8M+sIgurlvxidYM5OdHn9UHPlMsTrg7XKpuAdOnJFxEBScOUeoKCRARKHHwuyZEhRwWiq+9/0rMrbTNz/TIVLdWZjgRbhsqwPMVkjEPs0ySAf/qg76LFPP9TigV/F1/O0jdsH6b7A55GqH3a0VcgMGs9yFQrUrfKadjgpI/LXBhcerrL1k74e65QgHCIA4vGMk3/JUP2t6/tKTwgjzCl0PSbF9g5PQbxBiBx7TDbimqRScjRN/cEEBT3pF6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(8936002)(41300700001)(8676002)(66946007)(66476007)(66556008)(2616005)(316002)(4326008)(5660300002)(921005)(6666004)(7416002)(186003)(478600001)(38350700002)(38100700002)(110136005)(107886003)(86362001)(2906002)(6486002)(1076003)(6512007)(52116002)(26005)(6506007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8gaAalSkeAA0vnHhkCZh5F0lcxhx6Wvc5RsaKmhATUeSxvhAfngm3ZNVUce9?=
 =?us-ascii?Q?g1WPp4b69kVnPa/iqsIC1FEou4tTYF3/B20v6q3Xww2nyWlZFwXHShZSnA8l?=
 =?us-ascii?Q?5NMKJgP6v7Pod6Z5qGCNOtyT9TGZaaJM1iFErBAki9tFM2Qs9EQqvCuOOkXR?=
 =?us-ascii?Q?k5DZpan5uI3FarxgBRyakZMYRMOK4lieUJSjRPXOt6BSOyzHrjVcGgCrGAyI?=
 =?us-ascii?Q?cSU2KpB3Sx5bdVe4JBbb4e8K7Xbw+GpSewKA5LXly8XrZUWfWmP+OdDtI9dm?=
 =?us-ascii?Q?0pFkpe/jQeyB0kqek5Yh8KmjnLIR2D9EXYckXGpwK0gW0k4eg00B6KDvCBKK?=
 =?us-ascii?Q?vx31Ze15a4bjewOO9rfnQOdPCoBSMTSUUBSzB1Ic4sW6/xwVAvc3LXKqMN7x?=
 =?us-ascii?Q?fOWbxe0G7VjO9vUQOo1wwQpAnssQ9IdR/ScPgKrf1uq8x1PWKLv7FUQSgwIy?=
 =?us-ascii?Q?Z/Q6E7zM0DTWDPHTujaybTS8S0oHDpEykC9HRnJtZsBs++5kzwbHHpgBTZAm?=
 =?us-ascii?Q?ACqFoQasMyWowJHowPa+WXespN6SizWBLEIn4+vIn9DIERFr4PrrMD9wKsZd?=
 =?us-ascii?Q?tQqdEdbVABJB0fwP5GAHLUje3fEq7FVQFEYGscq5xfNcOVS/3yUb/1700Jv2?=
 =?us-ascii?Q?A9SkMtfcGarynyQaJtshoSShbMmPuF5VymUGx2VgipNAHSkPmZfmEEshi54G?=
 =?us-ascii?Q?0DgllR3OshYqhtKmMThPGIvtsF38o6g2UoKCY712Ya63AIGvmBR8sxGtpyny?=
 =?us-ascii?Q?pBHOG2rvou+wJNQT4opwX2pDvK6oTuw7DE2D2E2MgK2cmmHzyWCQMDIMYzrL?=
 =?us-ascii?Q?1GqFJZcvICutSRWLi7kh+mqWfza64wE4Lf7Y0MuVvH+tHIgiBA5L5WHctV82?=
 =?us-ascii?Q?quTVWA7jCljMF2EKOqObxhFnSV6w8+YnkH0g7IfsdvqqZmOO6w1sh8jVv17V?=
 =?us-ascii?Q?b7Wcsdvzox9ilMbAznSB0u9NwzB/EZnFYGtfqZUr5aFUO5EWC5qNRmaZItUW?=
 =?us-ascii?Q?NO6+6fsadH9BQDvnDjB199bjjJ+Ua55VhRSfZTnCHIn+LQjanTx2vSUw24Go?=
 =?us-ascii?Q?LVNf3pqKN6nhJXzyPkGi1jnQD6c+POwcvlgp6/xLdJdl1n61v1zcBGSe0Op8?=
 =?us-ascii?Q?QwcVJjOv7pVDCaSzLE6xizjY+mf3YgxdM5wgB/51ZVBc5I7SPaTKDytGeBX0?=
 =?us-ascii?Q?qt5Ju5LUnGF8MgwgF69q99/gXHh3hFwGWJEKXOi80bOO46CY5wZAb3cUlwJP?=
 =?us-ascii?Q?sfyJJ2KxjXuR96HWCjwfAfrVGM44imyTlSJEeqgwAUjunVQZcpkBlfuwZhP1?=
 =?us-ascii?Q?fOjc/+NJGhUzmpBhmWUTvvVdcFFLJqhmNREJTCSO3cCGYCbXLtGwLYFkbfvs?=
 =?us-ascii?Q?5tCiZpXydb80+GYkMLIQ1Ws+xrpP76o1bZGGz1XasWNsPMKOca8vLQh4bD73?=
 =?us-ascii?Q?V6xFXMd/YIyNTUjOcl/nB4IVi0UqKDPNQjyFA6M6wxh4S7fJ23qTgn1W1uEI?=
 =?us-ascii?Q?0JK3azEvKhnwGh7U1CL1mo6vIbUxO5lA1VQBx8eMShpGcsuiSQjlioscBAxW?=
 =?us-ascii?Q?w2UXw50LxgI2YihDqTQYDbgCT35d7lxoPDnUS6YV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2c2681-91e0-4016-7195-08db688ab70d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 01:41:59.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: no5OqXQxCdn4SD0R0FMUzgJSmLPq4eQeQCzY8Nh16Nosz9dWVhOGAsRbP3yIFff+QMCN8liIztrZPX36wdRLfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6277
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
1. Changed %d into %u since the wb_flush_threshold is unsigned.
2. Removed the check for enabling WB in wb_flush_threshold_store.
3. Using UFS_WB_BUF_REMAIN_PERCENT(100) instead of '10', which made it easier to read.

 drivers/ufs/core/ufs-sysfs.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index cdf3d5f2b77b..258afee2f958
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
+		wb_flush_threshold <= 0) {
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

