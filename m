Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C091E675844
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjATPP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjATPP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:15:56 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F678693
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:15:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOQorTe0rch3rUM7BpThHQb+EhP8xmeSFJDJvE/LYpmcKczMb40OSi9c/aopWsuuT3O16lQGAouRRCu6uQOMp+Eco/rlMFdQ9PJGEoTPtgaSUK57Jktwl1JRtYvJy/1EQOfHDY0Vndj0RzVHAF4eCYs9JDM+P2HIAyFWGVuari5Cc4G0JWvcjCMLrTPAg/UsYsZAPRyA9mQSOnk7iZHR52pVwmE1Ln6xrsmcuZSQitGopapUUuAEPFyuRL8OjrVmepleXY5ddd7R4RoYxj+1cadOAh+YrnTGjhJ8daMTNy/q7F2z6ofyNHWPrCShwByyg5HeZNjH8YcMHmVhgRL+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuS94aiACUHfVfpKF4YS3emr89QozIYmgtO/ThGAcG4=;
 b=kONWpj7PqyTMqahvg6sWtCP3D3xW9RFHvkYXWSAZBlsOdIxcxz+MGD5RVX/WFQqWnn5iBtUuu0cDEmeIGdc1vJeeIO/67TnhPObpKVDBKzTviYT7gmPVjDSAcrI9jmR67j0Kyay/z1m7NqwR0OGFM+hpDsg2IQUPROLk9CaGKudM2PyfnZ84dNM9wQfwjKDgixIR4LD2TveDL9DzV/9RSC5dxM+/7Qlml/1lZu5i6lcyfQ9j+5ydItHrtV0QnI0Y6RSJF/iBWdhVFIgYvnoJre65esHoPQ8YleJgK4Qg/OVdT9dStMD6VsC+mEwhNNvgFB4Juejh+eANt1ixWo0Qsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuS94aiACUHfVfpKF4YS3emr89QozIYmgtO/ThGAcG4=;
 b=PD+fsd/VV9dyCOzZbwSdmHYQrjtk2gANSAB/6u4T1x4HJElBFXnOLTKv1a5vc1L3vRAtUAFs0WxreQtpwjrm0zZTno8sm+Rr/nQI5o1te/0xpQ/9sMrReX9tu+m8lvba6l5jpvIQTrwHZmjd3hA8ozzJ45wUr3sFO4MV5Ea0a/59XVhn4IWobAu5J+4IJM1tWHTIXp08rDWtfm3SNDQ+YmqLRWSIc7ZNybPJL+L8JpPtIgRNdfcO1rm8s41j0kG0aZOBM/qXal+5mDvbRWWEKidmi4CMlE+N4iBQ4Zxu532xR4jXAwUedar7ycR00nOhEBUFMyf2NuT46ii+mh0KlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5201.apcprd06.prod.outlook.com (2603:1096:400:1f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 20 Jan
 2023 15:15:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6002.012; Fri, 20 Jan 2023
 15:15:49 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2] f2fs: export compress_percent and compress_watermark entries
Date:   Fri, 20 Jan 2023 23:15:39 +0800
Message-Id: <20230120151539.62660-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: 03481250-4c68-484e-74cb-08dafaf936a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+At93UZq61KiAUflZlGcctYzpK16slnP+lZ83jnp/OZIUiGWHkwuTsIIvidBqD5ts2NIKy3np41IUU1OX7ejC3MCuP4XkG/9mqQMIymcHnxnx8d1VSsQO+pTjg/DjvaINA8tOoqamkED4cNrs0mTtmBxcQbo+H8G38NQjr97tgBwp02oqqEjmrM8XuHZlhAMPDqU2qn1becPogbgOZsJpFBoxEJxCrefLBaFVvUv1VfQaefT7184zAKsXhDo/2b/Z3rBOz/zpRNy83+oKMmDP2ZDbpIy5FhWdHPF9L2Uqlk6Ny8ghxddDVecdcz/EBPLplY37wfbjwIF8khEfUo5tMYVUX/DWtFmzjHJesnJygCTAG3L+yRKtVRE7qmKGL5Aj72ZpqSAe1bvLFhJBn9LJzaXl9q0QIofdU2eZ8y9L4rlpx4hzcsinTpYyd3FuF/SeZTK+xJVFOcNhYb/TmYviFUpcNPVcFsPXeKJejdSAZMsPBUb1kxYyE64EI+ag6svTFahqyW76E3JKQ6T/a9ptK3rh3oqwXMM3SSNfF+0f/5h+kVEesjkTL1WPJZS07elIatXhu7GVCgTVAi67Ozf77amx/UX9jaU6QkfgGdTFjYw0kQUFLQ8s/dbk5JgFk2iGFkDHLuhmi1QaeTzXpd2iJ8iIN/GmI3HtCuxFI3F6MTmGvpQZzqdDUjDqjrcILh8DFDc+Tck1R18EFxGARwvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39850400004)(376002)(366004)(346002)(396003)(451199015)(2906002)(5660300002)(41300700001)(186003)(6512007)(36756003)(8676002)(66946007)(38100700002)(66556008)(4326008)(86362001)(107886003)(66476007)(38350700002)(6486002)(8936002)(26005)(52116002)(83380400001)(6666004)(1076003)(6506007)(316002)(2616005)(478600001)(19627235002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ql/VnksP4WSj2+KgEqxYmXhE/8bJ9ML9If2Gcw0NNk7h/AC9B71rg/e3cPvU?=
 =?us-ascii?Q?+ECAfqhw1P5NeomTQUQ6ycRPUfheALcFrMBb08ejh4T1cqqSNn3YxSXSpSiD?=
 =?us-ascii?Q?960L+Ci5iZfo+nG0HhnDr89mc9PKJiDALTEp2wc/ObF3OI+5tL3eQPy2Mwey?=
 =?us-ascii?Q?jzO+58pxlkUWWM7iomxIZHHiIOuMOw2Qf0QShSrDtTZDBtfcQHZ9tzB9MzMi?=
 =?us-ascii?Q?A9EkA3eP3KDgViEh3tSXyPf1Cle9aXd/qNlGySSwWzkyYG6pBcws52cdqWRt?=
 =?us-ascii?Q?mLAPxLtPcHZ1AUl3YuaJu7O6H2P3/iQdvFKDLkLJYP3VAdv8+Cbd2A3Hv5Ai?=
 =?us-ascii?Q?FZ1MrzpT04xFneqsTKYbhqDyrJjAof91KEjTd9ycXI1aj7k5JwpVbL1vFiqG?=
 =?us-ascii?Q?9IMmudachV4Tk/bqg4hR6i3yAkPLYwmT2Fuk4eJM+Tx/Q75ZATawke69CoYH?=
 =?us-ascii?Q?RIFfMLGy18MOIjN+qU4/WyZgj5wd0DW+Pr7TRC1WwiUFA6qwTZaqkIjWwywM?=
 =?us-ascii?Q?NZWwRC7skkg9BL6qc4kJjtuRgqpVdrzR/Y9xNJDqxB/LflQ15WNvdqVKvqlF?=
 =?us-ascii?Q?O49HmtTZ70bvT+P/hZhZJbQ3sjIU+LJq6CI5AOlUtSybo7EGeh67oObMRILs?=
 =?us-ascii?Q?54rq+a0DYlb7Ms9n9d8Lbd9K/Ebcx4GyWY8sfunXUWhsBU/+XHwgBcJ9K1v7?=
 =?us-ascii?Q?xV/7KWBOnlO6CbugiPXr+kHTvkYSsm4O5V2ki5piHz6w8NrL15bvsWY6JBBq?=
 =?us-ascii?Q?nKvOvFUNcO1/80B35yLjHmKvX5ZtZWMaUYYqOJImEnQzidyzEahic9SO1a4a?=
 =?us-ascii?Q?K/T6qhou9B1yheQ/nun6i+IXTXVoP2QgBxA22Goi6tGMZR2jDWPghW2IBSw/?=
 =?us-ascii?Q?+THiHcLeLijP3F5n+67uf3/+q1eL5feRS9vlWWBqndfN/JLXL05P1ex2+6/i?=
 =?us-ascii?Q?6/UsuzozBXAH8hwHUK9qBIaIvStnkwAW91Mi9Y8JFQlwWJr9A2bZd15DaXxc?=
 =?us-ascii?Q?S9BBgyOF/KAsdgei/sAsecoFMpobs2TYVBzpYtcHxblheG+KxYiQHZUmbMgN?=
 =?us-ascii?Q?h+c5nl6q1oZg9JIXda+RU85kUF632hpwW9ZmtKPZJ/V6LiDnAs6BDmAjcf5y?=
 =?us-ascii?Q?YZJwQZAy3Gw6LqUW6YWUIJztLxGY6I+oqToTNJSr1IEX+Sj69/mYURf4HGDm?=
 =?us-ascii?Q?4FCMFd/m4vrRxuERPDi1ATrSXxVIbbA3xPvcmlKAXE9JVOveJJr25ttIF13T?=
 =?us-ascii?Q?XUm1s40f4ruZbgJ8qlGv4Lf7toHBNnmzPfHDPv4Iw+5LOGJZnmftJw0ReR24?=
 =?us-ascii?Q?/i4uPASjXEalSE6ljelocMHjpDw/qsdtXhL720+iYsF04mKt+y5S0zcDl5+8?=
 =?us-ascii?Q?WxgEhfmt17DQbepAyOdBT+F7X20+fy2XWCFeqhqiObg2LDckfKZC4kbK1Mhr?=
 =?us-ascii?Q?zBaz3bjAVCOJ0CvTlnVYeJAeCn0HYBE3KBK5Yer+HIapPumDUXSqtbvz5PBe?=
 =?us-ascii?Q?sxkE+JMgvkffxOIkCNulvGZXCkEbvMHb2TIoCL4xSPotLUeg2OkAJt28AHHz?=
 =?us-ascii?Q?sa6zHXkvp4XTFjeo9DJZ4bmfroLpJk3rLmYYwCXc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03481250-4c68-484e-74cb-08dafaf936a4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 15:15:49.8457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkLuJWBML1mhNqJHD2UBgI9qdw9SZ1hw2ohY5Hx08so/YR2wg+pUdIRI+Su8yY1j/cWudN2wwXSQ5/POKNT0Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch export below sysfs entries for better control cached
compress page count.

/sys/fs/f2fs/<disk>/compress_watermark
/sys/fs/f2fs/<disk>/compress_percent

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2: disallow to set 0
 Documentation/ABI/testing/sysfs-fs-f2fs | 17 +++++++++++++++++
 fs/f2fs/sysfs.c                         | 18 ++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 0f17adc80488..e8b1c5b8c370 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -722,3 +722,20 @@ What:		/sys/fs/f2fs/<disk>/last_age_weight
 Date:		January 2023
 Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
 Description:	When DATA SEPARATION is on, it controls the weight of last data block age.
+
+what:		/sys/fs/f2fs/<disk>/compress_watermark
+Date:		January 2023
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+description:	when compress_cache is on, it controls free memory watermark
+		in order to limit caching compress page. If free memory is lower
+		than watermark, then deny caching compress page. The value should be in
+		range of (0, 100], by default it was initialized as 20(%).
+
+what:		/sys/fs/f2fs/<disk>/compress_percent
+Date:		January 2023
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+description:	when compress_cache is on, it controls cached page
+		percent(compress pages / free_ram) in order to limit caching compress page.
+		If cached page percent exceed threshold, then deny caching compress page.
+		The value should be in range of (0, 100], by default it was initialized
+		as 20(%).
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index bdc761f36310..69330a9709c9 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -598,6 +598,20 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		sbi->compr_new_inode = 0;
 		return count;
 	}
+
+	if (!strcmp(a->attr.name, "compress_percent")) {
+		if (t == 0 || t > 100)
+			return -EINVAL;
+		*ui = t;
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "compress_watermark")) {
+		if (t == 0 || t > 100)
+			return -EINVAL;
+		*ui = t;
+		return count;
+	}
 #endif
 
 	if (!strcmp(a->attr.name, "atgc_candidate_ratio")) {
@@ -941,6 +955,8 @@ F2FS_FEATURE_RO_ATTR(compression);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_written_block, compr_written_block);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_saved_block, compr_saved_block);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_new_inode, compr_new_inode);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compress_percent, compress_percent);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compress_watermark, compress_watermark);
 #endif
 F2FS_FEATURE_RO_ATTR(pin_file);
 
@@ -1048,6 +1064,8 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(compr_written_block),
 	ATTR_LIST(compr_saved_block),
 	ATTR_LIST(compr_new_inode),
+	ATTR_LIST(compress_percent),
+	ATTR_LIST(compress_watermark),
 #endif
 	/* For ATGC */
 	ATTR_LIST(atgc_candidate_ratio),
-- 
2.25.1

