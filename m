Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DC5727531
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjFHCrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjFHCrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:47:45 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087B92700
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 19:47:38 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3582CcTa010221;
        Thu, 8 Jun 2023 02:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=8YbBV7YhyyjOsQK+wiKKJWWu/q2DWspC6HjIjZhN90E=;
 b=PFR0OXRkWzrYoT/NB9Q3zGMcmFA0PHuk5Wg89v0qeWzAZTL4KGNwmrHt6YvOs327KZHo
 9WVedWY3pCJ2cjvihvbmjVizc/s9phsHfATELjQE5VRjiZiIc1nUYvbUkT+SoJH2/q0X
 fi7JamDTeyVK21KoEPTJJ7n5SbowwPXZfZHrXa1PdCg7LX3qD1XvT1MpixwwgHoqV/Qa
 b+kV/g4r48CPQgZ/J+sVTR99l9N6TgNc3CSxeKZWDt4aqNOW65wIdw3CubA6145K8y2T
 pFh/whayf1s3hCTrh2L9DMkppkE2K7Qs+HAJD+lPC1ENjIsPI+49nb9CrCzfgLOLtQz2 dQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r2avq1adm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 02:47:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq+/t5jY/FREw8+WVeaEl0e2AA7k5znXGGt4vwbjcyDvnDru0YXqGLfAIwJ9LCJtOcS7gb58vhIvMNoNevzBeUAr42wYX9baazzBdf3SeApzs5+Usjq4zpRyh8eczDlJapO2LvV7M/GEOsbWnSx/pdxsVDWo329gxcOqWGYWllEwRClX0yZR27ZO7nVrBjQhvM3Bftb84vkh+/XnIrmTnn1xycK9tloFKDIvFqOlSN3XR5MPgUiY4VdTxBnivxPTHny2BMMeVjNms5ZhuaSgORakPvFe+Z4Ol5ixORMg+9JLV8MqmWdYUngwSTMngMdQ52a8jfTr/S0lVIzxQpgBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YbBV7YhyyjOsQK+wiKKJWWu/q2DWspC6HjIjZhN90E=;
 b=lld2Mmta7gDS2zIdPQ2k6mf53UeZw/eP+WQWIvlK5VWTyaWhrLps35Q/b+nPvPraEz6m9qHhxkeiJcv7LPi10XTM6FyouSSFYCDX4zhwEz9rdPabB0kVriQDs+WljslrBWf3EYJWf6fq1TKLd3IaK2Si7cizS/UUDEraTeeMowVW5p4IwCjIQQg6vG9PhB0AsmMtLqzj3xQ2AsdM+7Zeb9jBec5BFl+zqlaLfa1TSpLgqCVl0+azzz9P6N1zzuZUKtE4Mc9o3hnIbmCi+XKhHsaW6o2SJE3RiApYiq25DyuNJ5KuRztWEojBVxh8ZWi9p0VORV6bTBwGrzmeQ6Lb6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4609.namprd11.prod.outlook.com (2603:10b6:5:28f::15)
 by DS7PR11MB6270.namprd11.prod.outlook.com (2603:10b6:8:96::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 02:47:32 +0000
Received: from DM6PR11MB4609.namprd11.prod.outlook.com
 ([fe80::c51e:7d63:e3a2:4926]) by DM6PR11MB4609.namprd11.prod.outlook.com
 ([fe80::c51e:7d63:e3a2:4926%4]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 02:47:32 +0000
From:   Yongxin Liu <yongxin.liu@windriver.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
Subject: [Intel-gfx] [PATCH] drm/i915/dp: fix a memory leak in struct intel_vbt_panel_data
Date:   Thu,  8 Jun 2023 10:45:27 +0800
Message-Id: <20230608024527.1280985-1-yongxin.liu@windriver.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0108.jpnprd01.prod.outlook.com
 (2603:1096:405:4::24) To DM6PR11MB4609.namprd11.prod.outlook.com
 (2603:10b6:5:28f::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB4609:EE_|DS7PR11MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4178b9-de10-4803-8cb0-08db67cab507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5iI4Biuo7FHiSwmogLy5LB46cl8Q2TALF8xmg7657p/bCOqNMQJ+vs/98WXmEEbZW4BWv548rJhRHOQuafcDnaQJvuzVXmHk5eHL2s3O6wp8XVvGuqHDEYzRdv0eMCvc17/MzVdpIamB7QSsVxEyFXYR4MQazGHlbGniDNufzFZ8cYr4nYvVzdsNpQM7wsPWDNa6k12jEPp7rqOgPPIlBa4HZyajMH5aTGNswBGC0atd6+mlx73LLvdg6pYC1BqKZpvIwENXgXkMb5w7VI1a1YvB0Abe4u+EC9paGtH2fILKw55s3mQyV2RzUJ7PDxf4tnLsmXj1vZ/s1H+8BDfGJVRhjKpNWXPpro6Q/AupxyTFHteSXaMWKcuW86wwZ8xf1ETID+AiY4CGVz3qDu4kX+Ry392uZcUJBzxSHL/sMnAkJ5DxrdjQ7v34rFppZh/hFkf+VtHBfCgZl7Jm9+cjYG7LbPReZfOgkIQOnFvg9CXnYds6u/dlOURRBKYGib1xN8wSZHwQfluruXsGOGoIHHqjyerujNl6XYjxzHQkWO3PwKR2m3zzCh9t0lrw7iTgtN4koLNxD4I2H94P96XWx3MqiQWn0j6yxI//402djzIrYjfNtmR5Px+5kb9f/tmv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4609.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39850400004)(451199021)(2906002)(2616005)(36756003)(86362001)(38350700002)(38100700002)(316002)(6486002)(41300700001)(52116002)(6666004)(5660300002)(8936002)(8676002)(478600001)(66556008)(66476007)(4326008)(6512007)(6506007)(66946007)(26005)(6916009)(1076003)(186003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aHbcBvYMaD65rL2kjDsfBrj62aYYTnM5SR9zVO4GdB9QL89juxZrFJK60pla?=
 =?us-ascii?Q?PB9HezcmFL2Rykq88GcXjxLw+dEobALCFUui3zega2UssmIGK/J4jP2LfKar?=
 =?us-ascii?Q?2uVe7ENYW+yKu7kHAMuG3L0sTslY9y7MrycyMASjJZAU4mmjkXLs2g1r+Xbq?=
 =?us-ascii?Q?5zSY4Cc+mZI6kEbpx8F59eTOCvDSC6v/I9ApxS1W+SU39AZLrMIwhlDKQgY1?=
 =?us-ascii?Q?RQDmvsoy7zAZGP5vTkZdkQZ3gsaTmlzc/ZOKoKFvgYvpkYbhj4NwUv+wDH9c?=
 =?us-ascii?Q?TsyE89zIhSlpXCFeVViX3Q34T0XUXJ/A7GeHjOu24T2i3BwcdKYJmqzwJeY7?=
 =?us-ascii?Q?Pg6YQV6IZJsGDMpdclGjUdZtlZzWeTPSeMX/iuewk8+VyF+GSwXtWCinP6/b?=
 =?us-ascii?Q?gdbMv983nJL2XaIyGKaShjjW4a1LL89tDimS+uJbmGnY9n2VrBn+a4ixO6L0?=
 =?us-ascii?Q?tPpFjiVck17XI44MZsBkszro1Te9ueMKAz2nKw+mqkB4XKMvFAGujVvv3M/T?=
 =?us-ascii?Q?o5qoLU+CqmlRee1AijOb50d27vBcY3dPZIsWMWIvziGsEEgRq/nk3yGJByTZ?=
 =?us-ascii?Q?e8bxjbY9p/lkHdfWUQOi4hoEOHDSArH08ce7YKGctHJzGCVc7csaqcnkwVEc?=
 =?us-ascii?Q?PS0dbWauSvI2xrPfiZIWxMxn+CpFPdoeqwLMpydBxNwbUjnZ1tP3ytFiELv2?=
 =?us-ascii?Q?5U9VnE6UB0Rc3DsiLcz7CwIbxEdxQWY4HVFqn1s9vNYGKaJV5lZ1xHAqN31A?=
 =?us-ascii?Q?i+5W+tM7L1BpGg2XB3q+mA6XFhBnBpnNhqhGS3yRH+6EKH4tQHr3aM4m9Zz0?=
 =?us-ascii?Q?m+bAts0QfbgtQU3fhMhAfEI7A4f57suzTJLL3cmpLJnj9E+JEx55VrnGfRGJ?=
 =?us-ascii?Q?KSkki1LBOjHWwbVfBslcDkQ2/LT05mLVCQdJKMGDI07CxpVKlw1fvJyrFTFd?=
 =?us-ascii?Q?oRot60wN59WOQqa6A2yX9JuMwTptm2QW7t9TrSBAAl16OyGryqWHf6sJTYLQ?=
 =?us-ascii?Q?oEwiBHGacZ5RdqxjI/HXBlBw+T5XjYwIoR7bzItXZycQ6AqhNlB/bdrgKOIP?=
 =?us-ascii?Q?NFdNd8+EKXkUq5D19Qa3fgH+HMANHyQOjZLeJ52+5thL55IiwxrCx76Tiagr?=
 =?us-ascii?Q?C4JbOyhDvhCn+YyKHvSjnMBo3F2nf9IhB8jIRYFo4gkEr/xqDErmaKlrEH5U?=
 =?us-ascii?Q?buI7IvuKYTjUwL0GOPkGd+1SAFd2LOFFU/CqggNfiV4vrY1Yf3W2JlJeReJy?=
 =?us-ascii?Q?KJMGNcnRt5jQIVgXeF3fngAhI3phBSSpfFopDM8p+c0mtz3jjTJWSG/+faiM?=
 =?us-ascii?Q?qHNiPdH/ZOWS2tONzw02LZ9r7yrMBxaW74RKsTmiCEUkAzywxIR0KlP3z+xT?=
 =?us-ascii?Q?7EL/S/lQEIZ6OnI/u0wJ73yffOgBDx8LhEooTTu68EpJnrMcvQjPoJWaNkHr?=
 =?us-ascii?Q?5TQ3NtLUF1wkZ/AUbvfomm31kRuHV32dLeEllhZcXzLNNHOvjNhS1Q0RnZ6u?=
 =?us-ascii?Q?oHmsG/RalXiATLRXGA19z3ufBk3A1sTOJNlMHgP41SvsV1GnMzIoDaT2gH6r?=
 =?us-ascii?Q?330foKXlNouyxLAfAiqubIpA48qfrgR3JxwaBE8WRZqGcYiux6KX6IW3Utdc?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4178b9-de10-4803-8cb0-08db67cab507
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4609.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 02:47:32.3270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcCLlRctwFmtYT2UHELRbfOARe8yBLqQ6fH/aID8nhGorZahjkf7N26z7GB7JkW426pYyP/z1/kcvPF68DbhasyiarsmG+IwDSO+9g/4ZvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6270
X-Proofpoint-GUID: IQjNZuFXvI31hc7KnvVKg7g0m4kwMPkp
X-Proofpoint-ORIG-GUID: IQjNZuFXvI31hc7KnvVKg7g0m4kwMPkp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080022
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 3f9ffce5765d ("drm/i915: Do panel VBT init early if the VBT
declares an explicit panel type"), intel_bios_init_panel_early() was
added to intel_edp_init_connector(), and it may call parse_lfp_panel_dtd()
to alloc memory for panel->vbt.lfp_lvds_vbt_mode.

If intel_edp_init_connector() returns false from lable out_vdd_off, the
memory pointed by panel->vbt.lfp_lvds_vbt_mode will be eventually lost by
kfree(connector) in intel_ddi_init_dp_connector().

Fix the following memory leak.

  unreferenced object 0xffff9e076562f100 (size 128):
    comm "modprobe", pid 365, jiffies 4294749388 (age 73.473s)
    hex dump (first 32 bytes):
      14 44 02 00 80 07 d8 07 05 08 98 08 00 00 38 04  .D............8.
      3b 04 41 04 65 04 00 00 0a 00 00 00 00 00 00 00  ;.A.e...........
    backtrace:
      __kmem_cache_alloc_node+0x1e6/0x3d0
      kmalloc_trace+0x2a/0xf0
      parse_lfp_data+0x1a9/0x300 [i915]
      intel_bios_init_panel+0x131/0x3d0 [i915]
      intel_bios_init_panel_early+0x13/0x20 [i915]
      intel_edp_init_connector+0xb2/0x620 [i915]
      intel_dp_init_connector+0x277/0x490 [i915]
      intel_ddi_init+0x877/0xd70 [i915]
      intel_setup_outputs+0x79d/0xbc0 [i915]
      intel_modeset_init_nogem+0x1a1/0x300 [i915]
      i915_driver_probe+0x2cd/0x580 [i915]
      i915_pci_probe+0xcd/0x150 [i915]
      local_pci_probe+0x44/0xa0
      pci_call_probe+0x54/0x160
      pci_device_probe+0x7e/0x100
      really_probe+0x197/0x3c0

Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index f4192fda1a76..9ae003b41b4a 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5575,6 +5575,7 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
 
 out_vdd_off:
 	intel_pps_vdd_off_sync(intel_dp);
+	intel_bios_fini_panel(&intel_connector->panel);
 
 	return false;
 }
-- 
2.39.2

