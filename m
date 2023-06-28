Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A32D740EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjF1KeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:34:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28946 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231548AbjF1KbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:31:22 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S8xiLk015163;
        Wed, 28 Jun 2023 10:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=JF4w714HqM8EWURE++K7QIfv+iB2N3VL6NmosO6SISQ=;
 b=jE0JhE5KXncqOcvuUVnCsDfAZWTa9aWsoGyy+cgl2tiArazXbUaLh3x4U6SXyggKBb2X
 pdPGA9euijdyRSD1GcUdBommo9Rw7iy7HyOqo9To92bQyoYA/VfVrKc8LhEXI0vE16mN
 kBJZVxv+MlZa67dGQoKXoZp16xqH/l4usYcrRJhE7ML0GlHYV/8+kwDy0EIBfkWTTcx+
 zCt3tK4Md6kuf0k3zsdLeWEs3b7r5YXhITjcREGn3FEU6f99mUVH20adE2aD/KgAGmji
 49h5R7RnHfeYtEhCG6iFeiTztRLbULuVYq6JEApupRj6KrRaZ/xk3b64frvEopqAJu1S rg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1u73ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35S9EXdY008565;
        Wed, 28 Jun 2023 10:30:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx5trp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arN/E4BlkHAQ1l6IqEFmUN8lic4lWS1SCXbxcmGPoxfWVV06chAjtKbh4JnPwYuIQ9TIBldRivhtBA1xzIwlLn2ZktquHR1kuYo1zeGnYJwxg3gO0jE4VgoijCMJPBIeBKkLhAc8XfkFyEz6sHh1oXkR2N497PMjPlKTuTM7anN3S4qPVMXdYHuDA2JTGQyPtECdeBdA3zj6njGo244xfOUg+3WA3r6ZS1TvRN7zOiwgq62sHmgSS53k2eo3A1+lvcno/EwC9BK4dxVd9/vw7wrh+adVY6lVUVFzWWYRif93nGqiJOx8CJiqf8wTsVrthqTgyzi7zu1QbTdHjeOH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF4w714HqM8EWURE++K7QIfv+iB2N3VL6NmosO6SISQ=;
 b=WSmaDcr8pHL3UhAaECfNsy6+hmgwv8L0ZIQesoffpxpaDFBCGMy63enlII3COglPtPgt0ySoXXD5y6NlVX+ALc3vFZ0vpygh/lQeL3DdrPc64VZtwLCAntxPLcvRlfBBChHx3EZpt2Fcopm9Hi1auPbCaoy2P82wiGWBTVdxQjIOTqohNZPE2osrVzuaRrQEOVNTgrAyT8Sr7pC6M66p2axZg7/6x9olCXu19R2X5QCFGrTaRUweA5qplCN2GLpCaHj4OrETtIZxRt9tVqh8TNKj19wCcdqFgCMMNpD75Di5maCcfoHLx2WEgMEzpQy1uF9BjdOzsdt82J5uO9kpmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF4w714HqM8EWURE++K7QIfv+iB2N3VL6NmosO6SISQ=;
 b=TMMxFlitdbIPZo+i/bxu9Bwb8VSe13rY9ZvUb7+KJRtFcn3c+xQV8MZeK1PyessJK2b5O+83V3x2EypKpsMMfoY/MPMLuYuQ67+Mtj6FaRkIdmyk75q7HMOFJDYdKNPzIL/sMTUsRZ9/odxp9Q6YoULQp7tEcwl01ggIHrD+qXU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 10:30:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 10:30:27 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     acme@kernel.org, irogers@google.com, namhyung@kernel.org,
        jolsa@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 9/9] perf vendor events arm64: Remove unnecessary metric Unit and Compat specifiers
Date:   Wed, 28 Jun 2023 10:29:49 +0000
Message-Id: <20230628102949.2598096-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628102949.2598096-1-john.g.garry@oracle.com>
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:806:23::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: 378ab422-77d3-4590-5678-08db77c2b0af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5AG9czf+bbOXWrU83l4H0gYxoIucCvfQXwqEbfuSHyOqFdet4NOSgx4ejICRKe5lCoT4dtRn3fNRXZHg8TWBFO3bDm0fpuFpPeiBklIX/P2oWfhQa+Te8+AiKv2teY02Oq1Y3kNnlmwsGaFa3/LFmkqJjbO7k7tWup2kze5u5Q42/n10J7Pip6ERvEkSYVMckhXdOHp6OTw9TJOkuDOVHYGfEoyYmH2TQ49zNC4/ukkXAO8c5QbGzgqJkTC2DvPbn3c3JQetXIeRtwAJqXJ7cIFqaifS7WlPkt8xSCj5NEy1ERTsqrQdmmkmbC3cTLd7PWWQwDF0OTZO4zp19sgiPIXOsdCK2MEU9rgiAf7tXYcmSsA8pjF7YX/pozIstPMQGdKx0Ctt10sL4GlUmLI0OQtO6KsK8OLrE/za32pd4TGgL1YVa06vEH0kmJ1PAfgsBR0p3kZrqoNKjO+e5M6EIlwNoYfhCGNz9RhsJD1xaJgm+eWVw5Tk3IsZ3WB4Epu7tC9cpmfmFPA35fOxuCPNhWAB4UyKG8B81kzX5mV/asW0w1j2Z9G1jssElxkY7PWk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(38100700002)(83380400001)(103116003)(36756003)(86362001)(478600001)(6666004)(6486002)(2616005)(8936002)(316002)(66946007)(8676002)(41300700001)(66556008)(4326008)(66476007)(107886003)(1076003)(6512007)(6506007)(26005)(186003)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZPBkt3Wx0ouDwqQnmMpWmN98s9UVSlWTG6rrNOByiC2N7lrxBGYpMgMiGq2x?=
 =?us-ascii?Q?q6jvgfJK8xsbCiFz7DQL514L3xn/fluxoU49UAHOqERJwWuYOCR6f7xF6n6J?=
 =?us-ascii?Q?5lOpsp/3AG6ffxf/Hexyo5LOPtyNz8qsAB8/gWw1WP/PqgcIU67L7RyQrMDT?=
 =?us-ascii?Q?7gWxynRVIrswkywaY/Jzusw7Py/LURBVz/rG6MqRFlFTgfMJOgOkhwzNHMr1?=
 =?us-ascii?Q?jHEYk65GC4Y2sWK5e/samsIP2QjacfdRAO51WQgMFHdUpFO/HPDWLQ8625KA?=
 =?us-ascii?Q?nuZm/zk+i47DjZcQhB6CFkmDdyKirA2gn9G6LNm4Vd7/9Y0CfBZYcK6Vgm8x?=
 =?us-ascii?Q?Tl2ZASO0vMfP0T6K5SBtrYOnlMTUGRI+QuRVQjYMy0JjV1g0bgcqooE8yb8E?=
 =?us-ascii?Q?XwiqNnbFpsH9RRIjMxkmYWsmcJspM29LcXVA2BaofFVC7jE/+znzYSYBz/dA?=
 =?us-ascii?Q?V6pW29/ssFyJzn3goEdVzX3IgHWG3Jw37xJNP8wqqXXtz3AwXfdCoOvBKlGE?=
 =?us-ascii?Q?QS6cES3aHOQGnX6POFn0P8hA69znRU/gPUCxunzwyGywBcG8T31AQAsjMsWv?=
 =?us-ascii?Q?C1Z9W3nZ6UNjlmcvpUsGI1JLEuM+d1MoEdljgPKveUIa/0vY8v1EbWnM2/Ec?=
 =?us-ascii?Q?4oZkxkCb/gxBzfT3HoX1/l4Xl0JM6MeSFXr85mSbIdKp3KLaCRi346PuTp3j?=
 =?us-ascii?Q?2jr52BimLf6jWNHmS8qixWnlwxRPp4SuC7Y5Nd+7uFz5ThDlu3vd0A4bWatk?=
 =?us-ascii?Q?r+GRKc82pyTyXn+MfNKlkQ+dvmL3lMkI+93t8r9t5QLF++OUQxcdtnUdYvzX?=
 =?us-ascii?Q?//MEdRbfpi1zzJPgVA040R9AtHtU+kWrS6k1u380qf1vzBzum4vR4fxmAuld?=
 =?us-ascii?Q?g/wlF0NkoFbNIgtZEfz2ZxBsfwuc1LagZVo90NWm/Z8fM9RehgLDEBFM/XMF?=
 =?us-ascii?Q?PzxN5yY4z9gOFhWMUVOEOQ4iPHJUwI8GiJNFjCsaXnrVotIAwXkM1h/xx7DF?=
 =?us-ascii?Q?RF4Z48KBA/amMjZUxoToXAUbUoq3VKqfkeMcILSQ58hDFk3ZwDnwaeMmmXl9?=
 =?us-ascii?Q?uU9Y38I5TYWhmo0hC1S61plp9vtqRafpDXnGH2YoAq9wp1BGBWV5BJjatvb/?=
 =?us-ascii?Q?Rr20ORIDC5ryt1oqIiedXqqu8DewFeK7ei4x9Nc2Slx1+QzQh6wd04JB03A9?=
 =?us-ascii?Q?Mf2W8NyE6BA9OBgO1waZepkp7KGYJqbe9Tn+jQ+Gn6gnZZ5osbDYC4hJCFCr?=
 =?us-ascii?Q?Im2paurU7NzRyzmlUTNGIMMeXhfpShhun78QUh1iqNskaTYQ/s743c4QQtx8?=
 =?us-ascii?Q?wv8dgtGrFIa7TZIKovpIygwHgoGB/DoyIUpnjRWzgG4H5ItC0V7XTdxnGb4r?=
 =?us-ascii?Q?H4leJF2mNRTLFIEpNAed1W1HUBbGS3aFThBw7tS7eD7CWToQ0sxKnbyyTykl?=
 =?us-ascii?Q?kmfen1eclSBCfjIhJ90V8PJCn17DjiImHmbT5im/U7T7VpQC9OSREtEAbXcg?=
 =?us-ascii?Q?qfxd9hQCO0nYTMHxFlLTwYmR25Pzc6p8txvEM20cqKd8OzzYTGEd+yLfrdjf?=
 =?us-ascii?Q?Qb2H3Z2+MKhjT8L5RqmOznXEvYUTD1wVoSBJnQSlAq9uqmmUmoSo49OjU2Ui?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jVgZ8RqyT8iAYNjKLOZ9ffIfxBTeiFaDJtdQlEVWcXxIozc57BAHBv2hy2Ay?=
 =?us-ascii?Q?wVjKJvrI0tBQPGxCyaB6Gbx7+8TpE80EB5qUxJtiEScRJoquZrp0+vrB28Z0?=
 =?us-ascii?Q?8vFhqmy4lBXffNSrjSXJXhMS4hEZD9UQmnq1ko4l0uiQfFQKtbLInmeVtWRp?=
 =?us-ascii?Q?I3cu1WJBC15GrPR4SD/mXZYogCTxmY5IpdhZXnab+LuQMH5FnEKN4bVBlxd7?=
 =?us-ascii?Q?hCe/jcVATTVJzhd5v+ipyYcDcVKd7KOhRpEcUqC5P2yUUT5mRPPqm5n541F9?=
 =?us-ascii?Q?QeWRsCe4lM9wMKDEdvoSkETWAg+ku7jAlv3YUNNziXkvLsMmUvsmOBghaLS+?=
 =?us-ascii?Q?VDdX4j3SsyOSRBBQXkd+gXCckKkGHMWg/6udF/xPyeHLLRq/XrLNQ18Ir+2e?=
 =?us-ascii?Q?vtVVaKjbVs6eErXD7hTDQBE48KU0hS4fYRbAi//aNTYd33rX6PM4LbPY662b?=
 =?us-ascii?Q?nUYlCj1ilLfVJYpcLcKUcjFmi4r2cUVzm+N9feNFMDUwcAzz9o2TqG+UHffW?=
 =?us-ascii?Q?ztayRlBFhnpxqdKuhq3PlMBOLWpVxr9r34Yt58QHqnvjIidA/oQteuvPO28N?=
 =?us-ascii?Q?V97+0YN7drhU8wA2EMyuVA/sTd3r1JdPfMPTkd873wkJBq43nFLa/GQdilq3?=
 =?us-ascii?Q?qEYTpxrFHyj+PSlDOlTbwRVmOnO9Jl6ecsy9/DLkLoY6WWP/wOUQXfUqbdod?=
 =?us-ascii?Q?fa0mXdwCkFCNLGSRd786nX+7Tx9Y0mvZTO46lzCAYxelHrDVbui2g0oswXID?=
 =?us-ascii?Q?bgXEIL7sYXmoEx284VOPUBIC4t0dRtyjyTASZRlylyTy2eDxopu8RskWMgso?=
 =?us-ascii?Q?cXc24Ripey6ge743GcYDM7MrD92iQyJuFX9doHB9SGASUhR35hzVhelNrD3u?=
 =?us-ascii?Q?AspXSZ/6g1thA7xqK0O1Gmk4pO+A3enzMDbz7DEfO/GAzzBlLjMcTKPknQL5?=
 =?us-ascii?Q?TSjUsEUQB3dZlFCek6eIGB8gZXAY73iSrsAItJfXpYSjAn9Zz9jzG5grNd0u?=
 =?us-ascii?Q?422YtVc5bR2U1oOQaVQO74GGVCxZMJS0nzyunmJOtFU/XrfnVmk5DS1lSIAn?=
 =?us-ascii?Q?W99uquijkgk26X4BLJNKyVamidZkzg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378ab422-77d3-4590-5678-08db77c2b0af
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 10:30:27.5701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrkNyv1iaYY983a1gmXaASB8gA176kDcLciKp4aPyPzeXYL39tUb9AQJga6eUB7lIuFGQFq0IOh6kiKFDYSJLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280092
X-Proofpoint-GUID: TE8CHW-teAqLciJnNRaPf831K1pBNfPw
X-Proofpoint-ORIG-GUID: TE8CHW-teAqLciJnNRaPf831K1pBNfPw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is now not necessary to specify Unit and Compat for metrics which
reference events for the same system, so remove them.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 .../pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json   | 4 ----
 .../pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json   | 4 ----
 .../pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json   | 4 ----
 .../pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json | 4 ----
 4 files changed, 16 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
index f416fa052337..574aeb964efd 100644
--- a/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
@@ -4,15 +4,11 @@
 	    "MetricName": "imx8mm_ddr_read.all",
 	    "MetricExpr": "imx8mm_ddr.read_cycles * 4 * 4",
 	    "ScaleUnit": "9.765625e-4KB",
-	    "Unit": "imx8_ddr",
-	    "Compat": "i.MX8MM"
    },
    {
 	    "BriefDescription": "bytes all masters write to ddr based on write-cycles event",
 	    "MetricName": "imx8mm_ddr_write.all",
 	    "MetricExpr": "imx8mm_ddr.write_cycles * 4 * 4",
 	    "ScaleUnit": "9.765625e-4KB",
-	    "Unit": "imx8_ddr",
-	    "Compat": "i.MX8MM"
    }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json
index 2bbba4d8ea5b..d81e7d562b65 100644
--- a/tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json
@@ -4,15 +4,11 @@
 	    "MetricName": "imx8mn_ddr_read.all",
 	    "MetricExpr": "imx8mn_ddr.read_cycles * 4 * 2",
 	    "ScaleUnit": "9.765625e-4KB",
-	    "Unit": "imx8_ddr",
-	    "Compat": "i.MX8MN"
    },
    {
 	    "BriefDescription": "bytes all masters write to ddr based on write-cycles event",
 	    "MetricName": "imx8mn_ddr_write.all",
 	    "MetricExpr": "imx8mn_ddr.write_cycles * 4 * 2",
 	    "ScaleUnit": "9.765625e-4KB",
-	    "Unit": "imx8_ddr",
-	    "Compat": "i.MX8MN"
    }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json
index 862c98171e0d..d2a71b02ab59 100644
--- a/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json
@@ -4,15 +4,11 @@
 	    "MetricName": "imx8mq_ddr_read.all",
 	    "MetricExpr": "imx8mq_ddr.read_cycles * 4 * 4",
 	    "ScaleUnit": "9.765625e-4KB",
-	    "Unit": "imx8_ddr",
-	    "Compat": "i.MX8MQ"
    },
    {
 	    "BriefDescription": "bytes all masters write to ddr based on write-cycles event",
 	    "MetricName": "imx8mq_ddr_write.all",
 	    "MetricExpr": "imx8mq_ddr.write_cycles * 4 * 4",
 	    "ScaleUnit": "9.765625e-4KB",
-	    "Unit": "imx8_ddr",
-	    "Compat": "i.MX8MQ"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json
index 7bcddec8a84f..c2ff0d85c354 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json
@@ -67,15 +67,11 @@
 		"BriefDescription": "Average bandwidth of CPA Port 1",
 		"MetricGroup": "CPA",
 		"MetricName": "cpa_p1_avg_bw",
-		"Compat": "0x00000030",
-		"Unit": "hisi_sicl,cpa"
 	},
 	{
 		"MetricExpr": "(cpa_p0_wr_dat * 64 + cpa_p0_rd_dat_64b * 64 + cpa_p0_rd_dat_32b * 32) / cpa_cycles",
 		"BriefDescription": "Average bandwidth of CPA Port 0",
 		"MetricGroup": "CPA",
 		"MetricName": "cpa_p0_avg_bw",
-		"Compat": "0x00000030",
-		"Unit": "hisi_sicl,cpa"
 	}
 ]
-- 
2.35.3

