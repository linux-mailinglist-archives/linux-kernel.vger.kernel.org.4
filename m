Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80139740EEA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjF1Ker (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:34:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47298 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231680AbjF1Kbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:31:33 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S8xoRh021934;
        Wed, 28 Jun 2023 10:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=I8X0xtui01ztzPFpCBdcLmFRSBjJ2ZtxODRIixykgeY=;
 b=D+mJCgRaO1OsHD7Orh0LIwY+EA8wZwxfgyDNfXn5iP/fracIzr9qDqnBAcAJHLdSjlTd
 Sv2k8oODW2nRvD3poIiwb1YLKe2PuHjTDJirvokAfqIxwFgUTT/9dzk7YVN0LT/DmfrC
 vP81h6BLSQ0XwqLKlZvfWv8tu2M14oOAoPu8ePSsA6e/mc42NoeSQJJ/aJeTxpVjeY5A
 r+acVUTaI74JN3ciHto9wbTn2FoZCXNY9lORoiuAQm2a1ow4OgPK7efgdW5wEYraVEIK
 b8sBx4oJ820EjsyDusqzoSkqGr3l0NdjtnwXTw8KaJJg4G0xrbe4ishMpwzQFnW/aiSl oQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq9376f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35S94uSQ038175;
        Wed, 28 Jun 2023 10:30:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxcaxmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsL7q4BdzieD9vee7kwtF2QGlcj8n3qL1KzmdLbwm8I0RBPWVd6ouN7DcHAkl0PY13fQjrdJdf4IPobXE1vNmYsfgyAFO+E+m4WjdWXwvrVPTvcnsgm8prUUxNExSgtLFOz1j6MoUNrxC59v3aMM8s4QOk4aDdjdQFf3JjRv2p+KnifKGbcpOpd8P5P/Bnyuaccyz+R13x1S86VuaK5SN9KjeIo/62J0XXTGJPZt1AaaDW90RPhvrZ4wlbkS5xVlmVZcPK6C3RhK+Of0krWPCWsxjvvom7aMDvpow5Shin5ZGh8jePZ4SviVFOwASkS4WRFuVCT/nMF5qVCiJ+ceww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8X0xtui01ztzPFpCBdcLmFRSBjJ2ZtxODRIixykgeY=;
 b=HxfBoMBMgk5gIrtR3gMNHRksSg3hMvoO6iXZnIs0sX0bK+1ol1nOxHgvxNVrTyNXvzAl2u8Nx4kTp4Q1REDwY3u4mpplun6juoXuqAVk8FtrCv3avEv69IJf4+K8dRq3v0sG7eBZ7Rv1p7bZ9sIPgjbqK3bmmkTjLAale5vmauiN6ZO8+Du9ZcjDadiryaQEEW/cWiiZA9NgJbLGsrXFJTPOsskmHUdBudahw0nm6o95WGiqM/OYaawpnvKblDu9FMMcScozPjzK0wwTgZKLQYrzspa6Q81VWiPY8FmjbrB0NI3wTVaMlvK9gY+f+3Jr/jc4/RWPJVOG9EB+ECt52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8X0xtui01ztzPFpCBdcLmFRSBjJ2ZtxODRIixykgeY=;
 b=zwgIv0B4gj35ayTmbyD4OlEUXmimqk7jnlMyc9A2naTNs9STRbVEtLg7zz92Ds73VH4Yon2uUjpjAXZOE1dGG4WR1h8+QNtDHEwgkvgo9xgjXlqDMrmqQfACIOv/vxEjBwD9ecWufPppQK7x57UGBfm05bpkEOkQdCNBKF3GjFo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 10:30:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 10:30:13 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     acme@kernel.org, irogers@google.com, namhyung@kernel.org,
        jolsa@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 2/9] perf metrics: Don't iter sys metrics if we already found a CPU match
Date:   Wed, 28 Jun 2023 10:29:42 +0000
Message-Id: <20230628102949.2598096-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628102949.2598096-1-john.g.garry@oracle.com>
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0029.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::42) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: 6048d41f-99e0-40f3-ddd9-08db77c2a878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NN1HADR2VeVXUZQaDLFJ6ajN6mSPNa9wuEP0EO4ncyjPiCC4iXHMVauNOIwZ029tRifI1kSdjISnXvXzqZlk1zDDwbpA/StoaQE32RWi5WNk5d9wUCaHeUCOgRIy+l/ZTnEuLn6VTz1fhUfNiD46Tiz/FmX57pIOa8OJi2HZVLCxQhJvjvm/AGXcEXBw5wLWmfCqn+SWKcM5w08gGXi32qlGunu5SIyB3FptVQr7ehiJbo3QfvRQBCqR6tC3ny3JEaSOP4JJ/RSS7oPSh//ZTSeUD6cMzVlKpiDU1BOehkGxEeiqLHXD/ClJE8wV1tbbGU6xwDarFa2a6nS60JWsOIpGSzmdc/ORoLErpgG0K/hknMgSxprxgWPHmbcXDMAFJKSoYGJhrhFDk5xdXb2wNtmaJo0e0mtMUAEPxAuvjGefaP5tyUKzRlK3kHk1CcdzBBOLL1AhN2yyg+XlXW1/WFXZLVymxjxrwdo2g3sOwTyH4LW1KDRqvWQCPgYPJICWOmv3ltfryGI92OI5zcHhAI3Wx+jOKVHZOITEF1T2hCPao2MvUEbWlZhHfODXLNfF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(38100700002)(103116003)(36756003)(86362001)(478600001)(4744005)(6666004)(6486002)(2616005)(8936002)(316002)(66946007)(8676002)(41300700001)(66556008)(4326008)(66476007)(107886003)(1076003)(6512007)(6506007)(26005)(186003)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iBwpMwPirNZHYX21wuZGMhUFcpHDjbiaUro6qlwgD8DZFK6DnRFbbPefaYlH?=
 =?us-ascii?Q?6LjfOQz8tbJNzV1PYgPGbd1ylarZzO4NKfZimooYx4kgjU4mEAt4Lpkei/ig?=
 =?us-ascii?Q?OxcBL7od36+EhgQiWWPN15Vxud0ygaeyxSGINocQoTpj0VxDQCrTdjs7khUQ?=
 =?us-ascii?Q?2fFLEEEs3rs7K7aHriEgunD9NK18Z6/PciDrAKBLP8t6JxiwyDwXMPXEejRp?=
 =?us-ascii?Q?KjHpvNjpVpk1ZyMeA2HH0wCgC7nyNjzQ/7KdIPCPiAFmeKFwbHv2FkjCCTzK?=
 =?us-ascii?Q?UWO/jT2Dq87bzZBRYss908sctuGz/AfNXy+zsxTSxV9kA29SOz8VEiBfeLYc?=
 =?us-ascii?Q?CX+5Rjj9qQtW6rBJcKJMF+xZKMcCccz8mW1UZWm9Grn8kFE2oXdiBjrJLBhN?=
 =?us-ascii?Q?kldu8f9qPnAlI6h+FEiqhczgyLZH4SMoSMdz29/QItGgGKtWKqPJ3tq2b2cj?=
 =?us-ascii?Q?rEQhPeSeblIhkSSFNUM4+ZEmAxDh16+YK6HwE/CCmzRsgm/aN7EvmDDDThGd?=
 =?us-ascii?Q?RtZbmCo9X8KJFzPRemAds32UUM/W0NovLHpTR256ZX1vni1O2x3l+EyPH5jg?=
 =?us-ascii?Q?3MhrlqMKbQO0sCQoOompIwx//pQSzZMHJS0EAhr19BgA3zmz9BstYqq8OSCN?=
 =?us-ascii?Q?ObXkyK4gWdEVmWM0Vml+p6kFQmDXhUcn1XH+z32ZurzX1L1dY68VaTFzkv2O?=
 =?us-ascii?Q?F5JcR3E9PyqKyjvOyTlpKpTxt185jGlTAtD0MFiF3MlWKmO6bBiJNMxKxeY/?=
 =?us-ascii?Q?OchE48lQxDH8p2NobsEYX6ZnthsI/lhAxJywrxD604jivVRk6OelLsIsB3BK?=
 =?us-ascii?Q?L/+QiOA9WF/b3wBycCdVd1ijikqBN6rguzZpgWugIV29AMkev/KYWYA6HUzV?=
 =?us-ascii?Q?i878BaGDdjRrF8wyINyisLGaDgkXwfaClO1HYn4E/XNpz8jU9gINt4nq0SFW?=
 =?us-ascii?Q?CykHjrlxZKoHE011/VWLXfzBTvfsemwweybGf5dr/oT3N74rMsUGbDaaXZ80?=
 =?us-ascii?Q?KLmNmWXv0V+znhe7GNE36WDK/CLT0rMO8YF2m0DD/is8c1ixBJdQGpHpF412?=
 =?us-ascii?Q?ediA94N2rQd1X4EVRQh5YyhpQ1VPoK6qoeDRLYdaF63csdvn9YrFIxghJXVh?=
 =?us-ascii?Q?UX/nNaKfHZb5BgytB/lNJZzlbDcKezojKCHrfyswso2egz35tEO59bgcbIzJ?=
 =?us-ascii?Q?ddpLhJtwLv5ST16OBZ67fGSJQlcMTuQ91P8CvLlfo8ElzDRvYoyQ/ekh+6nM?=
 =?us-ascii?Q?EB185Le/o1Q6UEveVQzmscvBOyZop8fTRcRFlXK02Z7b7IDve/4UGD0JpcdN?=
 =?us-ascii?Q?HZuYBiJj5tNn8HHy2At2sxsss44f5fWoAZK3c011z2TgHSMR7QOph0lg1LO+?=
 =?us-ascii?Q?oRqqFDViQA/E+GHFgO33UVb3OAEY1evialqv4V5boo/O1XNYlTWg9aicS4u9?=
 =?us-ascii?Q?goPb8LtuA1xg9lI6bBVLiDtM/mEJb+E/DlusoWyxIMfNgJc9wH/HmZq7o6pW?=
 =?us-ascii?Q?SDaCC8wPWRwqzXlo3+42qO/NmahZ8JEq2nPRZQ0+TRMSk5n/HMJs8XcrPj7J?=
 =?us-ascii?Q?wHehoYiK0KaugIat74VAXlaRQS2y0ejCJlF11SxB7SJq4TB+yZm/phlH4uoj?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JZjIas21fSTfSgi3HVCx/FPR6eMihTx7gDO6TamU9MtmcYr3VBUPWDNhGZlu?=
 =?us-ascii?Q?z4MZrZbcZCA9XcxJJcRqB4IF5nc/KRJB98L6GXXGGXZLSNw58Jhbxn8D3hK/?=
 =?us-ascii?Q?SRd/sIEPKd5E29aRFncC7ps15zCEjrAUlNu/fkiUxSa3CDeXeQHjfG9thifn?=
 =?us-ascii?Q?AEFKhwGp/Kj2EAuFOxh0iKph+NrNK8LCyBAfkZNk7JXQrwGn4aKYMSyJ/CJr?=
 =?us-ascii?Q?MIB/pJsPXqUFY6u+W3Gl+Mjhvh5VeVqS0fRLtmBJ8rxi0Dc8n3mk40lcpJfF?=
 =?us-ascii?Q?YBAEMYLDF6jcsGXO3LhjTziE35ZHpPtrlZ//RX5eVGTM0miaD+HtZWbO9c/K?=
 =?us-ascii?Q?y4oNzv0sBnNn9a19BrGZ46jHaxnutWkkGKF9oEor9YaGqr3rQe++KnUcutj9?=
 =?us-ascii?Q?n1zYYPbw+DSVkVd7uDESH/H3KSd/fx4UbRydrKxcT/wfjH5PM6ZNWP3QZn96?=
 =?us-ascii?Q?NTlYwlsE1mA/p7lGrwPFZbxi7ofUDsShekVFCJZHjC3sI+gtNlBljX7MfVLx?=
 =?us-ascii?Q?jBabblxP+8XSlo6xIcsbxgBnwrCmfx/tDJh4aWnhZCcedZchrjBeCxFV3qeP?=
 =?us-ascii?Q?+oHhYLGJSScIwL2uHYLfx3HQCYkNxCDk9Aq1Yrcz9xOjJlml8kW6+FIjEVqH?=
 =?us-ascii?Q?7lAKKNJqrxJMRyQ6UlLK62MxB4+vR+fS2F7yOIidMXV4N50KXdiJE8+m+Ek9?=
 =?us-ascii?Q?sMwsZCvHpHgf0/MqZyOZbQzd/3ecbQmA9rSaeTvP1O5rHkHG3gLhVTE9EuK2?=
 =?us-ascii?Q?/FXNHnKd6x6BxlObg3U2MPBpNOFKgYj+BDOauA8Z6fjNUUpkbitYzeq1WZ5N?=
 =?us-ascii?Q?9nvyho1Y/uGNrryuvCubjoKKyQtnCQuYPbz5qtMMFV4YwXQCWo1TzrQPgbAC?=
 =?us-ascii?Q?5ajMZ7CZyLq/wMafs4DtBYHf4f1kFVpsGrhiLo6cvBsJI7FKqW0s9u8dnnai?=
 =?us-ascii?Q?QXb12Dx6lr1b73c/vdxHjZnWxyA7mUNBTREDasoT7kL/h7ofRi4ppeh96SBr?=
 =?us-ascii?Q?KI8AEfOucNQGImeumgFP11B3jW4lT2UN3TthHLlTyPR3FospoR8nqHFv2CG+?=
 =?us-ascii?Q?pxpPagqgsJfkBRV6+EoDOPvsMcz0LQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6048d41f-99e0-40f3-ddd9-08db77c2a878
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 10:30:13.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYSPcY0AcSWNLwmlKg9F5lKScU8zKa1h+ol5yLmBxZuoMzn1HF335/wpucJw+tx/DPivzHUoRQnOdCvjKx9bbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280092
X-Proofpoint-ORIG-GUID: Ei7PYWfq2AY0PM-jEmehI1gadyAzAQia
X-Proofpoint-GUID: Ei7PYWfq2AY0PM-jEmehI1gadyAzAQia
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In metricgroup__add_metric() we still iter the sys metrics if we already
found a match from the CPU table, which is pretty pointless, so don't
bother.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tools/perf/util/metricgroup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4389ccd29fe7..8d2ac2513530 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1261,6 +1261,12 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
 
 		has_match = data.has_match;
 	}
+
+	if (has_match) {
+		ret = 0;
+		goto out;
+	}
+
 	{
 		struct metricgroup_iter_data data = {
 			.fn = metricgroup__add_metric_sys_event_iter,
@@ -1279,6 +1285,7 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
 
 		pmu_for_each_sys_metric(metricgroup__sys_event_iter, &data);
 	}
+
 	/* End of pmu events. */
 	if (!has_match)
 		ret = -EINVAL;
-- 
2.35.3

