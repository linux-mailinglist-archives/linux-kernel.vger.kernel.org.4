Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7910A729497
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbjFIJRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbjFIJRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:17:25 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2106.outbound.protection.outlook.com [40.107.215.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356A849DB;
        Fri,  9 Jun 2023 02:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DX8Twq2DeW6/OSL9C6lrOruZaRCSMzpd9F6Th+Z+u+J75VzA5yNClwLxvNW/3iXoLLuNx1HOAThKh5Z1KNzSkACTn6xlzDuUILDQFqOvnMCyHKe7suvNAfyTrC7+EJ2mTzBXE5DhyepZh3okmpXy/rtK5WikbHiaS5z+BqGfu/ISP49+dCdv6ABWv8guu3yqLCxZ3rhIWYTJPED1HRMoBAk8f8tkb14Ab1ZqWosUhTRM2izwwfQG+AcfHUi96CRfL9C8M36FDV5mKIEgfNHWF0yPQioL8NgQeLP6Bogx6kag7m97REewjxQ8j1pLkkwE+/IqiqFrdYab5ExofQFWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcnZEPCGxWM6iZJAxlBiGI+kmaOHAJrMS8LzmmCTIyY=;
 b=Of6uJsKJ/XuLwNEONco1CynXsB+xbC7CftNnlhChbt8PSF4D7hDsoefmhxMDqWWsCqFVkInkUCyjjHKcloRqVXlvzg4MR8tCZ4wkk5F4rGrjH03z0sgEKPs7gb67cZWeI+tZRCeZDM+FCZUUHcQgLIXjJEvLZVy3KTJDojaH1khhqV1F7lQtAisnpX9P++YL6DbaeLPJz4az/MYm9zbY9SBysarUP2X85yRQb5ftX2CPyt+0i6ZY1kkPbSfk6HKvCGDvcxOuPpjO8h+6QJ0uce+GmOpRGUsm4qWzDtgPgFpslrh8vxbK9o1aBzDPhKfL52ElDiBK/BNEz65272rK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcnZEPCGxWM6iZJAxlBiGI+kmaOHAJrMS8LzmmCTIyY=;
 b=j0AgQtSyBMrILpMwxd2uDiWKVujOxDBDTOcntQXbOnvmNEewoBXGsjjFZolP3ugmV6m8RlZLhz1siYbh4Son/c6HnEnmcnvHBuDVhFazAY4iKdz0yeN7cZIU6+DXESxN+mKlmkj4wrdvHFlmJAuq46YZF4DEbdQi/6DCGU6EcIZTwcrNMX1OhkJjVUxVVyZ++xOZ/wyIiBpIp8+F1rBxzG99/IbbeKvRDt5ONhpUbaC7vgwV00rRFb/vUkJ8mMT2XzptmaRbJxDczmCLDNyNHnTIkXYuUtVFoT+7J16DIJhm9wOnyoow64wGqbCJdtRfly+bDLDR9QIaBuCafeQMJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYZPR06MB6786.apcprd06.prod.outlook.com (2603:1096:400:45e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Fri, 9 Jun
 2023 09:11:23 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 09:11:23 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daniil Lunev <dlunev@chromium.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Lu Hongfei <luhongfei@vivo.com>, Bean Huo <beanhuo@micron.com>,
        Peter Wang <peter.wang@mediatek.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-scsi@vger.kernel.org (open list:UNIVERSAL FLASH STORAGE HOST
        CONTROLLER DRIVER)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v4] scsi: ufs: wb: Add explicit flush_threshold sysfs attribute
Date:   Fri,  9 Jun 2023 17:11:10 +0800
Message-Id: <20230609091113.22531-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0280.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::8) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYZPR06MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ed1f55-46ce-4ed7-30e7-08db68c97efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0WKU2XfQKznObL88o+glrxTrQiXHkzOVhvrba2NqOq04fORq8SnTJBvDcUhPyfPeuDUU80I0vIge0eiotHbCLzlwXplMR50DEIP+RHGZzhoOpvOjkBV93EKMzT+6xhpjBV2kAbvhPoIZTSpY3GWoB8OSrF2TVzZU97KKV/WE2BoegzrcIux5WlGcAQ8HjdME1/Hw0HBLPed23g9hOxJ5LDc7mZHh52b6gCOEY2YCyo0a0ZYaqGMhE6HQ8NaNEQiFvgkpWHUxVtBX//6l3RxNuWNQDWYqPGLSeSIP4QOy807C3Llx+fCMlGWIhoAOtV0ITWk+hCbGqHTRMiTgz1ykZnthAlP+gNnJqAihSy52jtjMMs2h0I/0Efee5CIj/ne2or7LNLYDrQ2Li7+VcoXKZoqGLNwHlWstrA3fNN/tFvwiexgZZ8J+fXPrJlTVNDf+RT1IU8s5GEzU3DtDIqfjenA2c1xBypAM2b25j21AMn3pbdomcBicW589LH1udawMw8gVH1BWcnbh+AcPV0yQLrbpFc7iUuctsMruFl0XRHAODWaKc7QgHjsMglwPPiN9yRpSK212OZrhOsKKcJ4SO9a3q9ztt429rneCgLrmrrV/ByoX9I4YUSZbF2h/DtZ0BIgNbWLxxI+fCQ9b2NOGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(136003)(396003)(376002)(366004)(451199021)(52116002)(6486002)(2906002)(2616005)(86362001)(107886003)(6666004)(26005)(66476007)(38350700002)(66946007)(921005)(1076003)(4326008)(5660300002)(6506007)(38100700002)(8676002)(478600001)(8936002)(66556008)(316002)(6512007)(41300700001)(36756003)(7416002)(186003)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b1JboQzd8i12JUUQXmiGVPK7/4CFhYZJMFAomEurtP5+WLGgpbvHpobREFHi?=
 =?us-ascii?Q?vAZS0trA0u06riPfQarhSMZ1QQhVfJNEr9PsXHVVXO+INSHMxtt6oUUzpEKP?=
 =?us-ascii?Q?nrkwqx9kvEWntF6e1TRTXgoFDPpOnS+fAoV5eH2FM4VcKY9Hgyey04iz1RK9?=
 =?us-ascii?Q?U4+gGFsgbgdaPcTDh2tfmn65+F8LoCoZZ/sK3aEjgjl/H3vNMkAsu1X56qB9?=
 =?us-ascii?Q?7qUwfwSiJNk/531HTz0PjxfBgCsv9jrOO8GoeWyu1/Be7be6Tqhpdm/VoJeH?=
 =?us-ascii?Q?7yhjIykOpBPA+ppjEKsVO1nYLHsk80NM+IL3dCHpPkf5AD0dyysY+mmQbjUQ?=
 =?us-ascii?Q?eUrXtQVN6lI0bZciiQn5c8A2beLpgB300q5iveQZ85V2Ba3ePpA9Rx8Vh7fy?=
 =?us-ascii?Q?jN2FkJg68hgPstVI1gzOHSlqRtJOLN/yxu1YzpOofeYzM8RzqcB13NGZjwWO?=
 =?us-ascii?Q?vu584ganGcaQ+UtV4zu+naEsrMIz9MIh86LmCNh5Bx9c7Cl6xWHHsXNXq/gj?=
 =?us-ascii?Q?l7jbnlDbGDJcViOZAq3nXLVcSz73SIMCXkXetXMABE2x8Uhk8/46h0ag2Aiy?=
 =?us-ascii?Q?bThPp8R0IH2qMuyrD2UEPeLX6uCyg4ib7y/YpTkrQYh9Y5Bb0B6QDd7evt70?=
 =?us-ascii?Q?bjrGMNczTy6xxDWPgDBBppD3mkNgcH2vMJGyydgP63CKL/k7JgTQAyDx2Y3O?=
 =?us-ascii?Q?6jYghzlelIOEI4UbH/0FMtXcnR16n/j41/dot23ewSBx6NY6sV+JWPhu3Fxg?=
 =?us-ascii?Q?DNzETnASm9hBwZs04MF5qQmcxKg3+DTaEeIrfLmxrsPNPJUeOyPemkcNVB14?=
 =?us-ascii?Q?42BBt8NeqNwY7K9i9/QoqguB17NdmMcvAoUGCHLY6bUt59e3vu039oyTuoLC?=
 =?us-ascii?Q?5zeTBg7dIAu7r2+kwlbxO9l34ed/O6Nhv6VcxjND64R05vM+97it6gJaQ6Xt?=
 =?us-ascii?Q?HupuRp7TiHwLmV6VN1RahLIUFpQkAWaoJ916I0gobBgSCN4ObASG/EQK3LEu?=
 =?us-ascii?Q?fxn6kW/5BMxSqbzkFg/ibk5V46Wg0W/nFSzNreKs73g/SdaXG4twuIWLRFzh?=
 =?us-ascii?Q?RNdRptQWeItPCJaVg+OuOUzkgTsuRTSCbuGPyCKBNuAyhU6PGv+gaE1pHzO4?=
 =?us-ascii?Q?kdtNuzqrHFl1tBS+6G7r/287bYy+MViQzJJdfA7WbAmKpyn8V8F02mFUu44B?=
 =?us-ascii?Q?ifZ/Sbe+/mE3eqBVaXXQJz4RLIa2J9FwKfR776kBVWZ6e1z7921tci4Nf7HI?=
 =?us-ascii?Q?Gxnh4F+tdIuzAX9MJr52Des0yrIW6zFFqf+wn3RahOwJOn6toCaUeLd4/XMl?=
 =?us-ascii?Q?1SvxwiGab2xgnz26BWqxmP4WqboMBXj+1OfhpQtERDvG+TZpGF8s8ITqwQk7?=
 =?us-ascii?Q?we8msuz7f9r9d62ssgtUdtsVOSeAqBPVbTQZh84pswKZs8xGZGgtnE3Bf/Tn?=
 =?us-ascii?Q?MNjkQma8PFB2wZ7gWXPReR7VILLNllg+zNr0kGAcgts+AhshvJgXrSGvRRN2?=
 =?us-ascii?Q?Pn20H7i9wK2X5+KQpQb4EaGtumFLYrd41MngoF8f+b3tK5GgFCZtUV5/GIv0?=
 =?us-ascii?Q?0JpCNd6PVBfxME5le6Kbt29qNYV/4oqwb891I4z9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ed1f55-46ce-4ed7-30e7-08db68c97efc
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 09:11:23.3753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GtEqduFzLiklMzyuuNQLTFRTAK2goy460IVTqHnpgY9AEgScWv5bUhlUx9wjBmsFaL7Gk9E5CJnkDaR4JuJPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6786
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
1. Add wb_flush_threshold related information to sysfs documentation.

 Documentation/ABI/testing/sysfs-driver-ufs |  8 ++++++
 drivers/ufs/core/ufs-sysfs.c               | 33 ++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 228aa43e14ed..25bc2db78ff5
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1426,6 +1426,14 @@ Description:	This entry shows the status of WriteBooster buffer flushing
 		If flushing is enabled, the device executes the flush
 		operation when the command queue is empty.
 
+What:		/sys/bus/platform/drivers/ufshcd/*/wb_flush_threshold
+What:		/sys/bus/platform/devices/*.ufs/wb_flush_threshold
+Date:		June 2023
+Contact:	Lu Hongfei <luhongfei@vivo.com>
+Description:	wb_flush_threshold is a percentage that represents the threshold for flush WB.
+		When avail_wb_buff < wb_flush_threshold, the dev will flush WB when entered H8.
+		When avail_wb_buff >= wb_flush_threshold, it is not necessary.
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

