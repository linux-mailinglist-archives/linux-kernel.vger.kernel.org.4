Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C9C740EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjF1Ke6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:34:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47546 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231678AbjF1Kbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:31:32 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S902kw031526;
        Wed, 28 Jun 2023 10:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ebfd71yKQLFHnsDikp7a41Tk95DNc4aJaNTDvEr9Yc0=;
 b=WGoIUOjxKozvlf88OLtO1IjMTXfKs75Lt4x9akLdRzPm/SZIOhv5YTZuLy3HiegPH8vt
 EYoTQxLN7ZwLAMiJnS0csee0IJ8+23qAS9i1rfHvkcr6Ev5m9dpqQJ6LTnLwJq7s6ZSx
 O6DgH7xM+gjUGxq9krtKwG3ppKaAD0Ai9mebCLgR9l7M4jMQt21cQ4Z0iZtJdWm83zkc
 val1BbomKy3ur+024HgkWXSBT4HF6OFkbH8XC14POVKv5WZnPqXsuOORklp6tOyrs3LO
 LLBTwW1ewavqOjIuUT0l9D1tUTnOiXCwyAAqtnqxykarZoJbhtb6tyO1tfZQ9sl4q16t hg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrca6xxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35S99Hll008566;
        Wed, 28 Jun 2023 10:30:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx5trjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWYuZKzZwtrFPzjfSddMy2iQW0ksM72z79euXeTy07H8vu/i/LaBpeNnk9RvaBlQsLXlnwp/gOHkcv9/PdF4lPyCjlX41v352CdG8o6e8POSSmwdq3rMA+mHLZ1E99bTeV1paaBPy9gG+fItdhN1BXbwri9HZ4nBkEUnHPZlTYVFFqOBBdVlZX7AaCTOuRovDdLQ3DR5sUxLlftmJLYpHJYP/+hNM07tVycssO0grgxDAu/AZlHcS63TiBAmqTANzhh6AruoARbYTMheTYAaq8UNOZwhiE7E0Zm4v3P1BtlIlSiU1AmdceFQhrccKSlF2VddSI8YjhfY5HSrDCm+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebfd71yKQLFHnsDikp7a41Tk95DNc4aJaNTDvEr9Yc0=;
 b=bbdCprA6DVzYo7BznKGZSdfra11VlpAThalf6zW9S7JZ+52ZYk4eRxlN5u18Ys+NCb7dGFUG6L5ciaqp7fTtUHhc60yHBssg83nMU6WXdiFvzm4yW8m7icsSRcg8Mz2oea8LL1FKBi+sWUxEoH3uPKv07ZSSpppzbpmsfC+WQROWc+lPMuKMOGf8EYpDJrWEGs+xerKtKeQ9+m8WspRtpEogQd35GH6Nldol9IHFwAAGDIjbDvq1mhbYc+cCmqrjgfKKxhy00wf/hHVnk7IiC5fDTw2loocID6GBbgbe3zJINtGL0igaEgeFLvAAx/M+QeMtbpdREOsqyY3PJALVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebfd71yKQLFHnsDikp7a41Tk95DNc4aJaNTDvEr9Yc0=;
 b=wpCoh+JrEiJ8yLdZ/+lnIa6OusXjlxMVdtvUqYiUpmlXKcmvSQC/pGoBqzeIv0e5GZ9UipWVn36okDASCGBI+kmAzp/1XFgvYbAtvkVZOMA3qOr6Il57oVnIVbatLXVWduQTAv7GX9DgW3hiC7MjMW7DNbI/np8BFJngMFwl+WU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 10:30:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 10:30:24 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     acme@kernel.org, irogers@google.com, namhyung@kernel.org,
        jolsa@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 7/9] perf metrics: Test metric match in metricgroup__sys_event_iter()
Date:   Wed, 28 Jun 2023 10:29:47 +0000
Message-Id: <20230628102949.2598096-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628102949.2598096-1-john.g.garry@oracle.com>
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:806:f2::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: 615a051a-bfc7-4e2f-100d-08db77c2aeaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gP+d1f3O/iCqeNl3tGnKD2FgBctinCcJjYmxC9Q1G3VZF8k31latnUUsFXjK1hdIbtOkjw2wr4YMJDQLKnYlQDC6Azra721xbSLfa9Nq1xJ4cvHmFPt57ytK50h+JGurOMa1kZKE43bUGk7G2a5CsDX2dlvBGMt0Y5O9s1vpVyr/7/+5MSmjNYBp3yI3DnJwnQni6+RLrMcx1znPjIKVkmVgehrPjuCURfN1ybHlUPbkCnIdW31aYngpWULLO108W5U0l5ESHeQ8Zdwa4N2LBfxNuD/uEYusHeXeOXRlsk7l1BsdAwLCjQYjo89FCFI/zpRXv6innXaPTonABO/h1/gxtkylU1XOJn0qK5RngPTg6CjTOuh9r5egb5eXf0QY72ttA5XJAF9CkxgRK/y+hisxc7X9n+jgNs/aijUV3YSsJ8zYqFAAJ4P1sBg+eJAqk0eCBVxLo1JOLjsReg2sk3AtjhUz9SbCCnlyHtHWkYBtx4+sRVZzPANT/DrvYJsS6T2Ks1mTbbtiHloK/d8QtVTbpWWlRpK9FB0Bh6FEVkXViPkdtBXqlvpu6VNABbaQAabMJHDLfwKXmeXCX7+QzvWXH3wugJ2YQ6QcxyCgMKX2swLUNIU3C9Sevktcra18
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(38100700002)(103116003)(36756003)(86362001)(478600001)(6666004)(6486002)(2616005)(8936002)(316002)(66946007)(8676002)(41300700001)(66556008)(4326008)(66476007)(107886003)(1076003)(6512007)(6506007)(26005)(186003)(7416002)(5660300002)(2906002)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wIkbc5TyMd3vbHVTJNH17gamLsFt6oR78jR9Mv28VVW7IPVMXQNDgM6S9/+x?=
 =?us-ascii?Q?G/dES1yAND7Qz+BgGxxlFbpqO4+sD62aaS5PUZbTTxCDNIE2aF7+GF/r0Ntj?=
 =?us-ascii?Q?sxmVDzgCQ1GwVH7/lwo+1E3asoRFOZR50lrXoon6XcZTc1LkzKXyG/JMxzMX?=
 =?us-ascii?Q?1jDHtlDjwRgC+kSZ9P8tJtyup1OB/nGDJ2S8KhFUBJnggv1/OXXJll8nLjWn?=
 =?us-ascii?Q?CySiFpkxBL0A87LQGnO5AV7iDDp6q0u1B+FbTxi0DGabsD6BGZlcxEMn1Q8I?=
 =?us-ascii?Q?XqMFaZ9jm8uuoYYrWjVkzJ8WESs/IJGJoASw+CTm8O8cY7Kb/oHOOjeNcNW7?=
 =?us-ascii?Q?30PkHRc6p0jYEa9QD94O9Vw7Q2/9FMWSpimk29ZuzlpBDthPlzB4bU9xR1h/?=
 =?us-ascii?Q?iTfI3KUttJxQjx2jRB95GMJ/gDea2V1mY/sPf3GWHiLnICtmRLjrf6kIhINw?=
 =?us-ascii?Q?BIqtmRTXVmWlzNi/jbdaoZizOyHA3CQI0FSf7Ri5TbcWMF0xpJkiXlFWwAyc?=
 =?us-ascii?Q?Na3jS3fnbpalSkRxtnGPoQsUTk3+WNQvNritzT/XTRxCWHmpi66IhY3FmmXG?=
 =?us-ascii?Q?EtRhNmYMFxknY5pUUqFKBX8WbEubGtI274LAT/oXg61nuh9/fOob6LuGTB24?=
 =?us-ascii?Q?8D1rRtp6HxEqjVu2yA/9XhKD3lcVxX+jX7jqCinXmMmcPw4PcAV7NN8ftegn?=
 =?us-ascii?Q?nyyW1ruYK/d1vBN6Ik4ij1OKvrnIgmZNqXkV3P0AecWqK7WNsEfPqsgMQJ9Y?=
 =?us-ascii?Q?hYvyWLny7QmaEzCLtNNdE9dsY4r8PIADTQLlVB01TFPjsrsN87n+FvsEf4ky?=
 =?us-ascii?Q?kmT4zKi/gp0Io6qoofo/VvYiaQ0bVkcDOsOLI9z4NN057h3uCrEGJGMT7Kvu?=
 =?us-ascii?Q?Gr/0/XfRFiwQqf873cEH8x3emF/0+Yo+MF44SIyaOuO9cf+5wAeHvucFx+tP?=
 =?us-ascii?Q?ZnJP+p/nABfz/54atBhh5WkP17kdiFZnXQPI/3c4/I6RpEJYEFJR+vaSRVCL?=
 =?us-ascii?Q?2ZruhsvrJ6s7eLwKxaNBdySIw+yuTfc4Vae2Hxo0+F9HOUscvq6uX2OCnuha?=
 =?us-ascii?Q?gSsgQy4MFVe+TJ2sgZ/w1i1ARMRDytMbuajWYYMLjsSvvC9CYj8sqAuuQJBu?=
 =?us-ascii?Q?cWIRkw6UCzNJcUvXrkCuqICmmyh5BguiXzur4GBlFLdsgdT0VyMkXjahXWJN?=
 =?us-ascii?Q?N5ydADyvv5kVavvOmTRENOiPxaKLstjaVxj2hs2Vpk6H6O17Ra5DdSXJ9Qz4?=
 =?us-ascii?Q?h57NsdT54HU2Lw/vDmmWYqqse9TFt0EvKbU4MDJ/GSNazQZiAPxuIX1TdZ66?=
 =?us-ascii?Q?z6nH29/iqUvgpILRUi4nyaQLb+Asy/tufsYWCGCWJtN4O38qEGvwqaPShzuK?=
 =?us-ascii?Q?l28lVBWTQub9EQrRNNAWlOut6n6tFiiU2/6ZdPMegvKxcTkea3jW5O0d7CF4?=
 =?us-ascii?Q?I9OvW0iPDVQHD8pjotWl7AU5Zml6/+IJ5zxDjkkNZ4IEQjm6HLipecYfrd2K?=
 =?us-ascii?Q?Mvm5ONUkS50KPn1fBnR1xpkdI5SnwiObn6lUEjby8pknMsQMeEqO2+kKbwfp?=
 =?us-ascii?Q?C1AJ1rbmOl1hHsJ/Lb9eT39RCBM0UcIBKBanEFBNTFYwQFcnFiOUOucRwnct?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?63BJMIpXH0AHH3DwQIV83FQ/Jj5JATUNqcoHMt6ES38ZsNjmV9wvwq7QQeyn?=
 =?us-ascii?Q?INEbFry4lhQSxVPGbI61OKDxu9grOSSh8sqin8rytPO5LoRQlzNrHtHBcch/?=
 =?us-ascii?Q?e4sXmgafY2hD6d+uQWZJwfAaIwJzhzs/hMDSGcjPUK0VrLshS+Df7enBodlo?=
 =?us-ascii?Q?EEfAXQQtOtW0wFJgaTwERcwr3JxJxoY/wWZSBfEK3T8cTsKD017V39W48bZd?=
 =?us-ascii?Q?pwYJFgCg9IDKPy7RXJMj3CaHISvzC+rt1FyxJtGIOCmjS0MVCBOs7WqL/qo9?=
 =?us-ascii?Q?M9ktmOrD3Jqb7hgQYDXEuRtRBztCwmCNBQo2YEK/zy2IEpkie9EgJVQI/cbP?=
 =?us-ascii?Q?zZMH+w7ENfoO8nCdhTZ6WXwyoicxtaSrWBriTZ03iRqA97vxQLhPa3c6KUpH?=
 =?us-ascii?Q?uIQGVVHh9DJIhvncWA8SXnE50ylOCUfHN8kZbeG0YUKmzT0QdwtymnqznZ16?=
 =?us-ascii?Q?LedJsZM5YstubTMMPaPr6Vqd3KlJxZrt+QDd+2HfmLfHzjV3MZ5/LjlVjsv0?=
 =?us-ascii?Q?y1D1OsZoqpv8F4rJpbh5s93owEMeW7qg7MuCKry4tm7yN3JNrwFM9SDrnJyL?=
 =?us-ascii?Q?jmgWiqLWnrZrxyVk5k+ZAH3mVApf1DiTwW1QIsX7crQ0J8gQS8BWhByE99l6?=
 =?us-ascii?Q?n6o/zidPwtj5T6cyc9QM25mXniBJkJHpja5G2UvwOdxm4zYcKTp3htEVUoWx?=
 =?us-ascii?Q?fAaMbSKHWtw7JqGzAsYpe0/SABbzkrZ1jSI9XXAy+0LBnVMyzLxj2vPEGb7j?=
 =?us-ascii?Q?rvPKTz929ZOm7//LfwPgWig6tPRTqqx/70MmpIcqy+WRFv+d9+01up+qVOwH?=
 =?us-ascii?Q?+4UU2gJuf2IndHcBV7IkE2Beyxtm9V87mUl/FV15uFu1HFuMB0ZZeenKgt6d?=
 =?us-ascii?Q?mWjmRvQYpF5pZwvuPc+XRC4JxgskYXeQMVO8CZK6UMxZGE9m5sU5QoUz2IYO?=
 =?us-ascii?Q?ZBvU2VY4QBsQSKmwxQUStPFvrUYD2RFAu9/KPVUv/SpKTiK6rNEwpew3B9nN?=
 =?us-ascii?Q?ATqNruRxR+yYmhq5hchQsEmr+JstUxDlpuqNUrIXbaO24aFIk966VO/a6hLH?=
 =?us-ascii?Q?qIInr76wFe4KFdq/w3G6H4gOI2bmZA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615a051a-bfc7-4e2f-100d-08db77c2aeaa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 10:30:24.1952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3RkOsZAMf6Qovo0PdOwahXVl4M/+lCRzknjaWF0fedEYAubV+5UVTwvRxx2rdpfPbH+eAzeZz2Tch7Ek3tjPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280092
X-Proofpoint-ORIG-GUID: YhVXq7N5nomKoj0gmvWcbcft69A6U4nM
X-Proofpoint-GUID: YhVXq7N5nomKoj0gmvWcbcft69A6U4nM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we add a metric in metricgroup__add_metric(), we first iter through
all metrics in each table from pmu_sys_event_tables tables and call
metricgroup_sys_metric_supported() to test whether we support that metric.
The second step is to call metricgroup__add_metric_sys_event_iter() ->
match_pm_metric() to check if this is actually the metric we're looking
for. It would be better before calling metricgroup_sys_metric_supported()
at all to first test whether we're interested in that metric.

Add metricgroup_iter_data.metric_name, which will be set when we're
looking for a specific metric in the iter, and check for that in
metricgroup__sys_event_iter(). In a way this duplicates the
metricgroup__add_metric_sys_event_iter() -> match_pm_metric() check, but
that is needed for other cases.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tools/perf/util/metricgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 6be410363099..111ad4e3eb6b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -483,6 +483,7 @@ static int metricgroup__add_to_mep_groups(const struct pmu_metric *pm,
 
 struct metricgroup_iter_data {
 	pmu_metric_iter_fn fn;
+	const char *metric_name;
 	void *data;
 };
 
@@ -495,6 +496,10 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
 {
 	struct metricgroup_iter_data *d = data;
 
+	/* We may be only interested in a specific metric */
+	if (d->metric_name && strcasecmp(d->metric_name, pm->metric_name))
+		return 0;
+
 	if (metricgroup_sys_metric_supported(pm, table))
 		return d->fn(pm, table, d->data);
 
@@ -1291,6 +1296,7 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
 				.has_match = &has_match,
 				.ret = &ret,
 			},
+			.metric_name = metric_name,
 		};
 
 		pmu_for_each_sys_metric(metricgroup__sys_event_iter, &data);
-- 
2.35.3

