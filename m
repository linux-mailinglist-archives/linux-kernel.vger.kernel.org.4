Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A6372D758
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbjFMCW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjFMCWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:22:54 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2137.outbound.protection.outlook.com [40.107.215.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E70AA;
        Mon, 12 Jun 2023 19:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUUMo18Q3F2+zLET7lSSUZPC3IZpKtFvewU57vbrErUoTsjMa7e+iEqwkdMfcHuLk2FY8dcEsHUjv+7nPSBCiSOvKce3gklA4VTlAi+bDc698BVCgbPpmQg9DdySW720EUTLC+a5AQenm/p/qG/8zf5C+uYTXi5DJ5BwqRJx12SItwvSUrCN5RUcAg0A6cmQ8jKE9Kg0rsld6r6DxqPfFO28B6EwOOa5KKr3rFn5Dior7VAdIjcxuXj9r0Rmip+c7+bKupAPYYNHuITLfcVkTMvB8YxRA1lqXLVatGMPxExvdyV9RitSj3BQ3l2XTZVGsVO4yK8sdakKLxq73Odogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/sn6++dQJCq6vRVNKIIn3NDrKh5v7CV6wB08E/rxyo=;
 b=nyYkZx0fvT1Y92J1TuL6ywb7imkKJsr0FsSySj9TgLGpi4S5pycUnUZuHThUu5gmaVxB1lbUIP6JmA3L6CL4wPEqP0qiKh+ujGq4cQf3FwmK6xKBl/v3QrrPXVPOfg4vyz3xQ49tv5c3Mwzr1cn2FrS7JN8F7JZo+mpdt3I1Xs/eLrRAG5XC+F05kzK05nbLyv+KdxLPb9Bz50NOAiAT7jVkOqXPuTkn67JBEjkEjznQwbcHjyKff927IoywBBpOcxbGjpwA0GIPYU6fcnrNX0MZ61xxs1tJcjyr5lKJlEccW9uxlvbnjK8bhrlwoDlp1I42SX1XYas96uzssjqC2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/sn6++dQJCq6vRVNKIIn3NDrKh5v7CV6wB08E/rxyo=;
 b=BnQHZ6bcqZUhLTfR5aZsLd7qR0tSVH7zqdue9yrNnvA0cM1hQWFz6+bvNSiSdm6wUIZ3F2pt+zOeAd8G/uc5zV2j+X/8pmV70Ep5m0UCdc2i8uBIFhdw7R7lT93hKsWZzuZGa3vnTsk41/bD6oUeS6NntNJgoPfqK5hsZSRhiV+i8ehINX4oZ5f1+8l346jK41Wby7J8Y2NfgZAXkT9yEWIize6vveTait1BgD1tOvY7d+SMDjH8OcQeK9TCwSEN3ZmVHkS6jCkD1NrKTGdu2IsmuqSpD6uRUATzybVrb0lBITI52FYaODYDVRgDZhmYugNQxLlzlx2Nc/f4c5BiRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SI2PR06MB4426.apcprd06.prod.outlook.com (2603:1096:4:154::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 02:22:49 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 02:22:49 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Daniil Lunev <dlunev@chromium.org>,
        Lu Hongfei <luhongfei@vivo.com>, Bean Huo <beanhuo@micron.com>,
        Peter Wang <peter.wang@mediatek.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-scsi@vger.kernel.org (open list:UNIVERSAL FLASH STORAGE HOST
        CONTROLLER DRIVER)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v5] scsi: ufs: wb: Add explicit flush_threshold sysfs attribute
Date:   Tue, 13 Jun 2023 10:22:34 +0800
Message-Id: <20230613022240.16595-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::15) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SI2PR06MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f24cc7-8087-43e7-bda3-08db6bb514f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k2HEbVgxt6YgNGVGZnjB37+gYoq0H7dDMLW7ODP4JdPQeXIKYy5Q0iBaWEEreF3iwBrqalCKNLwIgKDF7K+GBWVuGof64v59X0d7vbKbbs5LAdAFSttGBa3lZIbCH433n+U/WDU8E18qOGMDsh20zhoMbJgsRYUCrs+q0rIOhIFJn+nAOkRAN2Ky3FgSL7ARTUiXdN2F71hg+8uOy8p79ENgJmGdbsnAuyH3zkZEiWWkxuWPflIpThcIFM60Y8JLx5BLIgoDKnYVfCASDzAJ8Tpzfknr3ZJQecskg9ZOY0+wlFGl0XRj2KhiEk/EVsAVZeXirU/H/cWU4RsL3JiCWvnNZeIM4tCFy4jvamtTBnDGFS0U2gFd9GSU+Sb7tNF1qfmxo9fcINt4DRB2WNUfcl4pA/8zTXeeeRMSi0ux+JMrySTiouffIrCylSr0D2MtXMkruNcoySby3NrW+fIHZ1LfNa+jSMcxT2/6Win0uK4rvsKuMWjlB7X7y/AN9fRfKYNcKIoHLDTc1z4GBFy14DMiTqnNsFFy/j5iU8en7I1DRyUuDm9ihdCI43bpUGejS8A7XFimoKouFSDCANCBcEVMne5GxH9Ir2S+K6pf6AENub+E2nFhP1YpdRtEGfs2b6EVvrCmazUbtWmf+CHKfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199021)(316002)(6486002)(52116002)(41300700001)(2616005)(86362001)(186003)(6512007)(1076003)(26005)(7416002)(107886003)(2906002)(6506007)(921005)(38100700002)(38350700002)(5660300002)(36756003)(8676002)(8936002)(66946007)(66556008)(110136005)(6666004)(478600001)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U3MUCIAoC6FdzKWeAMHt5pENr3P+hTOwV+RPsDA5wAFRJT2JilRwYksjcuhG?=
 =?us-ascii?Q?gPMRYQ+g4Bxl7dOMU5699f2BW01BMIc8rmQ4hT6T7CuTZPyMYSTbkyyekdn8?=
 =?us-ascii?Q?sfssGcznoLO3iJFR3ze5eGd4kPBYo5bN+uoHDddySzj5iC1aD3C0Pwo+Bgs9?=
 =?us-ascii?Q?8g8GvFmzyOXw4qseK56kRvVzY2dXGHVoFLgffXBl3To+97NXrlJM4Iy+N77z?=
 =?us-ascii?Q?ZhMsTVqkLpTd4Nz6BY33SgOB1Hbl8zKwUbRBfvDnVML0w6wyAwT5T6EMwygs?=
 =?us-ascii?Q?LdRevJyHKQ1WJanapPYQWR0K+vog1FqcSpU8LH4NQxZ3Oa4eA+psxtv5wqVx?=
 =?us-ascii?Q?B8wxYz405urLJ927H1lhLZDe4NAE+buAD2I77lbosBHKNK0GZzszy6agg400?=
 =?us-ascii?Q?nW5V1CYlrlMH9ACvijGfLCxmGv6V9ycDvUBCWTZFZS+Hd8ol5VdsF4qUoqcQ?=
 =?us-ascii?Q?FS9xSuZZdiLXmta1c1LeGeeAHrptkaSbDnXAXf16aWqLK8VKafdc3GpTDONm?=
 =?us-ascii?Q?EOrklyx6oQgfEd022ptLuDRxfYa2UM8sIlfNY9R1obEzYQnLaR5aIJTSSWgW?=
 =?us-ascii?Q?RMTZqGfu/9XV6SIdPct7sYtIhGlYnG8lPmI0uviVyQoKh/Ufat30cTuAHCrS?=
 =?us-ascii?Q?6hB4uttoydoaHcna+55g/P8JxWNx8+u3LoxGWt82j4+J4obWeISC51s71c5N?=
 =?us-ascii?Q?eh9ZVJjzBZYr9JRZJpeb3VHMlWjgVWYc7ou7R2zffNbpkHNeG+jh13Xn0fIH?=
 =?us-ascii?Q?utMIn2VBmOHPaRl+ISuzhAOIzDEByQyBoF5zvnAaQWax+fJ6MSc669WKZcf6?=
 =?us-ascii?Q?ONm6WZik4S4AZKJAQN99wrmaD4VD6TDV/zaPAJrzhCUK03QrUG8JQPf7rlzH?=
 =?us-ascii?Q?CYzx2v80FTqFidIKmCcdgWZe9FPwAYAk8ojgrTXj+PBlx5B27V4Elblm1LJe?=
 =?us-ascii?Q?4qSQ6+MZhloI9rVFcbCa0zsAPLioe3i1/LWa3r2mcLehN5GmpG51MT83DfnW?=
 =?us-ascii?Q?i4R6xfmvDmFjMo4b/BTX8Gr4Z49sSpD8ZYsfAwCMtXPiBxwVV95uEsNxGZbv?=
 =?us-ascii?Q?oAYz7SWkEYXTuZJwcvMForUHemeRinAHq1kU7xnOLqwXXRAqiuxVbh7E7oPa?=
 =?us-ascii?Q?S4eiEz91FGDwrL8nRlUigEj9lxWSh2hIJrjC5lzvvwUjIQRVKhbfIO3XQonv?=
 =?us-ascii?Q?EpfZujgkZR9vLpBlTpwVoayQnDvCeZcpX/I7GhxisfdWlrXmYfDL5UAQX6LR?=
 =?us-ascii?Q?krCA7eXBAWZHSOYFKd20U4BjZyJ83h6ygSDsRRxM/kSWT6c5KQ6kFG+jN34e?=
 =?us-ascii?Q?Dzee84iBtOwunOnXfsVdBhbPf8FtYv1n3FB1hLVZzGL1Ocz9aQzqlvPVs+kc?=
 =?us-ascii?Q?zFgHaSMurIY35YRdJSRLmDMtnlRmw4oqGv1UkVwULcZqvrF8NVknGst6HuME?=
 =?us-ascii?Q?n2Q8fBTD6R9V4zzjneOsjMtGsmFWjaDJM9vhH8R0MtcufrP4bHx8y6YCg8Kd?=
 =?us-ascii?Q?DfvAM61YkaxAPPQQli0FcUgLtxCHklKlU5HtxCbbU56XTBG2wV89Jj1QmwnL?=
 =?us-ascii?Q?2g1V8sVE+Xmn3qwMfj8VhlI8ZbzpbuR/cCTnRdoI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f24cc7-8087-43e7-bda3-08db6bb514f5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 02:22:48.9922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGWh3HcUemfo6D+nYRMmA9z6KhE2t1NxZKFwOMwS5axVpQNSnLVt5sCCIF9NehHa/wHGluniUz3U0+hzbBsluw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4426
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

wb_flush_threshold represents the threshold for flushing WB buffer,
whose value expressed in unit of 10% granularity, such as '1'
representing 10%, '2' representing 20%, and so on.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
The modifications made compared to the previous version are as follows:
1. Optimize the description of wb_flush_threshold in sysfs documentation
   to make the meaning clearer and more accurate

 Documentation/ABI/testing/sysfs-driver-ufs | 11 ++++++++
 drivers/ufs/core/ufs-sysfs.c               | 33 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 228aa43e14ed..d5f44fc5b9dc
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1426,6 +1426,17 @@ Description:	This entry shows the status of WriteBooster buffer flushing
 		If flushing is enabled, the device executes the flush
 		operation when the command queue is empty.
 
+What:		/sys/bus/platform/drivers/ufshcd/*/wb_flush_threshold
+What:		/sys/bus/platform/devices/*.ufs/wb_flush_threshold
+Date:		June 2023
+Contact:	Lu Hongfei <luhongfei@vivo.com>
+Description:
+		wb_flush_threshold represents the threshold for flushing WriteBooster buffer,
+		whose value expressed in unit of 10% granularity, such as '1' representing 10%,
+		'2' representing 20%, and so on.
+		If avail_wb_buff < wb_flush_threshold, it indicates that WriteBooster buffer needs to
+		be flushed, otherwise it is not necessary.
+
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/hpb_version
 What:		/sys/bus/platform/devices/*.ufs/device_descriptor/hpb_version
 Date:		June 2021
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index cdf3d5f2b77b..347207f4e8ee 100644
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

