Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0305B7190C7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjFADDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjFADCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:02:52 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2115.outbound.protection.outlook.com [40.107.101.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453451AD;
        Wed, 31 May 2023 20:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJ+reJTB+3gtdVk21ZR6Z8Eu1rMZbdcdyAIBmsl5Hdkuf2rGpSHGWu0Vs/OQ5Vs+k9EXnkz3ETpcNm8mHnvEv9sxfuAf3MgNDhq2FMX8gNNdaUkfZbz72G+p1sLtWDCFBhFpQlf2ViF3AKlOcMfzMwPwHlORZuU77CsVqpS/IMisCeSVU7Rg3TWXD8S5Pbg0rkK89HmTjyQvHSyj6GTo0GP8PYmr5GCYaS3Vzo7Q3Yj1tsds2POkqp6CckACEFj4cX0H3BxG8Erh8eKB6206OU0xaMbG9UA6Rg+s50MaPxCLzzIXTvxB7IeNG36vtCrLoTIeEu5jGVKMWDIc4QOGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLhvL625UaqprOKkGQ4xA/u91qvjSkkor2jAZ0bOrjI=;
 b=S3wx7Vl6lQa0HRN17aNNtujSicBdImjPyG51Z6pfT1c1VejbNhh4Ook5Wtx5HkJyaLdCWfGDC+8qx+jxDG8WhHpaaC4sveL0lkV1W3R+M4HFCDfmMM7lQp67ijAxcrfTSYta4ZcJajCuPJ050DQElNA1fYpA4+lR7KkLE6ROJLHFLmNfFctoBHtdQ+z28psqSLewkXmyxoNQLAfcig6zm4NjmVebA/oNm4pfTakZkPjD94WPXprCLhV9Y1Ol0tb/gfywMR5xZzLkJy/qELcP69pNgngapG+qXIxRF2m6GTvq5NYtSXt6LEz+TuBjjV39iS0BUwtM8IYL5ONvuV25oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLhvL625UaqprOKkGQ4xA/u91qvjSkkor2jAZ0bOrjI=;
 b=Xu3jpp4AJz3NmaCILjzJ+zNxyS0y+qcqzW+HQjvH/GM81tYeRfqAyYi+dj0U9yH0M6u0KJQujTw4Jk+yebsL6xL/XI6oHxj6wnYKiUmgQ9+6UYENq8+q0aNZZwGnKV6Y4yO5CiNPDxKMeKRXbVEjpCAFBdRBN7YofegCpkaGlUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CO1PR01MB6709.prod.exchangelabs.com (2603:10b6:303:f9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22; Thu, 1 Jun 2023 03:02:41 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 03:02:41 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v2 3/5] perf: arm_cspmu: Support implementation specific filters
Date:   Wed, 31 May 2023 20:01:42 -0700
Message-Id: <20230601030144.3458136-4-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601030144.3458136-1-ilkka@os.amperecomputing.com>
References: <20230601030144.3458136-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:610:33::20) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|CO1PR01MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: a2fa18a8-e9ed-41b3-7fbe-08db624caa12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pI1vGDzUeVnQK/ZJWsIIzGgXNRCzv9+naJIDiUQAB87VATQ87HqI9yrslkWJqfKk9Dl5byohIMrTVyETXklQrJCHS1t7xjqRt7jm6Vk9xJeQAL4Md1gcyAMkyl20DlIj9kzEauTcPp/4ADfnikaeLgogRBJSsQgxDqKXiZ504dxX1DAdZbRVVGReUlQwzigBuqUgsoLa/4u9wSyrhkB0Qzh2sb2ahLDS5q4wkYuNZ6wQYLX590Ughe3KAtxHR0EZigZijVpMDJVQf8YKy7j4xi5Yr03va61P8pEmq2kK93WSqELZsMY9URXAo2yXsINQFjA8H7h4Up21NI9pT4O/CWDUs+Qgbkeo1b2w3ym7BrR7vRaQxIpJ99phqHX24WaaAZ+zjgrJrxjG/+pMJW6S4lcRR0INirmu6OLzHe1y0Xtzx8K+SFniOX5ruHUtN6El+F+VjvjpPqdV3mMe9xIkbS3mgaFdLtn9Z7/f1rh49MgkCNGeCurc2M6xd7vhvu9xz5gnm4sEjCB0Iqp1pSTlVb/w8Kc6/Vo8+NdeZawmoF5E5EyTK9AKyII5lHwkiexVOhQ+p+cfm0e7q96nc1/xq1A1hSqBf3es5XJ4tJMTe0OFtK3abLWGsc/c/91Wd8M41cyTCi7KivgJfoazakCxBVS09qHdmPhKXkj7/uv6iqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(316002)(83380400001)(2906002)(110136005)(6506007)(1076003)(38100700002)(26005)(6512007)(66556008)(66476007)(4326008)(38350700002)(66946007)(86362001)(2616005)(478600001)(5660300002)(186003)(41300700001)(52116002)(6486002)(8676002)(8936002)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P7VCHjPxzt4Elu162CnqtNFFOPtelN4k+O7GkIUp2ZGtfXAEDzE0YqwEE1nX?=
 =?us-ascii?Q?R3UKBhKdJA/1U1kg/3MMblsY5LT6l3XmOM9XV53vdImS8t+TNdybTJGUQBH3?=
 =?us-ascii?Q?XhKKO97MmwlSuixGb2fp26InskgC7/o/ToiGotOuYyAevSXh9G6hHjxLQ/e8?=
 =?us-ascii?Q?K+X88fhKQ7MvKPX/Gcz9/9E+mUvbTCKDPxZWHwP6pN7vn2i2XauQ/XiNG2TI?=
 =?us-ascii?Q?DpuVC0/BvzvbV4JyYl2OvJy/uR9scuM8o6hznn6rpZJp7ndnKwzU3CvP012T?=
 =?us-ascii?Q?VR5xRnMkgGhCE4jPzTJtbk1cfJvDSFX8WwNwLrDXFU92Hu9v7Bfw3ZxTRJE0?=
 =?us-ascii?Q?Rn13bg7yzSmcMcarKfY8Fw7eVhFoZYnZdjvEIHOPZosvBivVHWIGkwQJX6Dn?=
 =?us-ascii?Q?LOz4Ys1GUR4fE8DLnvTEaqTCZubEdM2niyRgrDYC/RC2DwUYYvB1xp7ec5bv?=
 =?us-ascii?Q?3XbsBzFSM5G4Vtb89P+9pkzDCfpyz/xl1tMY7FX+RcgMssTxpxHpzPiEnRrq?=
 =?us-ascii?Q?BBhrPA/23MElF9BbdfLvtTZcnM03T51G42sc+M61Equ7rgU+9AdDiryrDiiV?=
 =?us-ascii?Q?27N4Oquw8Vv2fO8hAuus/+1dTIrrK3U1HPtdwMFLqQkCmAL7SGtBUUf/aGNS?=
 =?us-ascii?Q?O0b893/JQ/pCD+B7Az8fPDhdB7J1R0DXBQDwY5bb6R6HQeffkW3GjMwk3865?=
 =?us-ascii?Q?BFG07bFtwWe5noSOBQy6Tj4LDDWjBEbXvzcyIh7VY7k95pSu3dHDbhAYh7gv?=
 =?us-ascii?Q?p6Otge+1akAbzn+e/t7+vwOfsoP6c9lSjZuBGVOTYD64mZLCVZUHZ1ES3reO?=
 =?us-ascii?Q?xAj1t+zucmX73pke8ssn/rWWPmuenyzbW6rDhVaDtfCRR0YXaG6br0mT9W+E?=
 =?us-ascii?Q?ql+ZkzY/lQdY5u6Xh/k0QCKCRaVSB7x9UJtZehw2oZJuLuZ6bNUuFKOiEWcd?=
 =?us-ascii?Q?3HRvGR4DTly0xoLUJdgxBGxGTa8121eX2J+lS0QEh550tZwluWRA674N0UMy?=
 =?us-ascii?Q?aOkxv0YdOsGnShuirIsKJ4bphdCbZGNCjAPKnzUO12HAM4oD+uJiRnrE61Sb?=
 =?us-ascii?Q?GUeemC56VqC/AbwJ3i7DtqekP9qXMkDpVnn2gGmSM9U7y+aDucx03Jq8kQiB?=
 =?us-ascii?Q?IGFGuy9+Xu4PUKpqGTRAnxzoJ46/WnvJswNZpoJW6WWLXn7rl315CiHF1iU3?=
 =?us-ascii?Q?Mn/FFBHM8dnv4iAmq9vWKOzRfaBnyMLecaTrKJWcEHCnbVi1HQ5y44ccfUja?=
 =?us-ascii?Q?B8fc1EcHMekjS5XliF+eE5SRr5gq0ozAw25ZNFNvphyascdnpWMXbjQTkvt4?=
 =?us-ascii?Q?MdaJPluTDIUcFQRJ/3EUMNKd7CBCLRTk0sxueOIRYfPKoUyNH5fw+IB5ud+g?=
 =?us-ascii?Q?2y6mc3AfvOTZIB70NxOFnp0SUkjLOZ3V/I6H95p3gBN8TcDmcY6L86xm++EP?=
 =?us-ascii?Q?pv/BNsqZQ4lDKY57JXAH3jIp3hPI6W1fzfF5no3N4E9aZ418aX4QEyRJp1QS?=
 =?us-ascii?Q?JdK1ezsxTLs11hEsuu7vfJI1jUSdcPnrsuZIpsfkUszxkfyVJLrBc1j1MNkn?=
 =?us-ascii?Q?iZCzvxIhPAJTYjL26z/t6EdSL1auBf2hgH6T3I4KmHP4a1VUZaV/DCglX69m?=
 =?us-ascii?Q?9Xr6QJbRDM+Sl3n3ktQIqk0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fa18a8-e9ed-41b3-7fbe-08db624caa12
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 03:02:41.5518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlVoaBElR7l6F7zcveT56qYb3xhhKPgLsrBX5tRVh/W36k9iFHRy0/lRKhIKuJi9JDDVBnYxzdUAeF2LEJ4KK+IcJ08usbupKg5Rsp8RwOjyQV7c4F1X4MFQg3rqMQ7d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6709
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic filters aren't used in all the platforms. Instead, the platforms
may use different means to filter events. Add support for implementation
specific filters.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 8 ++++++--
 drivers/perf/arm_cspmu/arm_cspmu.h | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index cc5204d1b5fb..b4c4ef81c719 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -122,6 +122,9 @@
 
 static unsigned long arm_cspmu_cpuhp_state;
 
+static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
+				    struct hw_perf_event *hwc, u32 filter);
+
 /*
  * In CoreSight PMU architecture, all of the MMIO registers are 32-bit except
  * counter register. The counter register can be implemented as 32-bit or 64-bit
@@ -432,6 +435,7 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_type);
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_filter);
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_attr_is_visible);
+	CHECK_DEFAULT_IMPL_OPS(impl_ops, set_ev_filter);
 
 	return 0;
 }
@@ -799,7 +803,7 @@ static inline void arm_cspmu_set_event(struct arm_cspmu *cspmu,
 	writel(hwc->config, cspmu->base0 + offset);
 }
 
-static inline void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
+static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
 					   struct hw_perf_event *hwc,
 					   u32 filter)
 {
@@ -833,7 +837,7 @@ static void arm_cspmu_start(struct perf_event *event, int pmu_flags)
 		arm_cspmu_set_cc_filter(cspmu, filter);
 	} else {
 		arm_cspmu_set_event(cspmu, hwc);
-		arm_cspmu_set_ev_filter(cspmu, hwc, filter);
+		cspmu->impl.ops.set_ev_filter(cspmu, hwc, filter);
 	}
 
 	hwc->state = 0;
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index c0412cf2bd97..4a29b921f7e8 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -102,6 +102,10 @@ struct arm_cspmu_impl_ops {
 	u32 (*event_type)(const struct perf_event *event);
 	/* Decode filter value from configs */
 	u32 (*event_filter)(const struct perf_event *event);
+	/* Set event filter */
+	void (*set_ev_filter)(struct arm_cspmu *cspmu,
+			      struct hw_perf_event *hwc,
+			      u32 filter);
 	/* Hide/show unsupported events */
 	umode_t (*event_attr_is_visible)(struct kobject *kobj,
 					 struct attribute *attr, int unused);
-- 
2.40.1

