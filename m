Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A29740EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjF1KdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:33:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12656 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231447AbjF1KbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:31:14 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S8xqMM006641;
        Wed, 28 Jun 2023 10:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=r4qM/ngLrfPnqWi0Fb1fg1fq9WWVMk1a99HUIWr0bPA=;
 b=efZYaYsPICHwJk8oq0Fvu+EWh82/OPUo4CsIAx0A+WvgZUojtWOWCBv7szHcDUDP/uJt
 Db0kai/z2HnoaZdTTuRcy5bwpadVJFfnc1cojXnaeN6wLTJ/NTv+z1d0LovWBGQ2ldUU
 sIMwjOWFmZDSjtPBW3J8gJGneBFiTiMFGWDbOIEj/bRrm8RewSQNv3G0262oimfyMi2V
 iyqK/ZzAgrdKTn8vRl5vMXE9a/rUY0ff4Iqt1cDqX7fMABPDIaSPorMEdW7coBmbHQ7D
 C6gg/0GnJbKvR8suQEFODJsy19NFLwRd3xL0IjC3dBF+o5AAxaOTA44GWLO6k7No8DBL 4g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq30y9nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35S9EXdP008565;
        Wed, 28 Jun 2023 10:30:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx5tra2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCHSCU0yMl4HeUK8boLvqCVa5PVV22fXcj0GmYAew4W7OsP96/e1ayM0o7RgqgnqVWvQU17EpwYVQ8wgf587dTBULfZFtFPUiwyDI26zUFTzJtvY4J2VQHwRTY7mEt5qOb0bgy2IYsCnPJiNhUdVffrJCbJUwSw3n/7lJJIzDX78HO9iwU3h/e0wcmaQznar8dl+t9im7JG65NLXgaz0UhJ01KiiRE/2HraBvm8uX4AAHeTeXp4SKWUjA+ZgpcU3TDzWajZO6M3PIuxgQF/dyGwVKWLXyaRfRfmFkquMa+ZVfyXVlXya/fCdA++OTivqRjggjw8+34Io0DjcChkuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4qM/ngLrfPnqWi0Fb1fg1fq9WWVMk1a99HUIWr0bPA=;
 b=aQVdUcNtL+gzozKzoIGsf6QG7aeKWenLUNuNIxzsq/oT1wm4+37+f2JOa10/4GTvd4jst5p26e86yn2rlJcZgp9alQ6kxFsfCg9NYNL8NieIY3NPHAO4pFWg9FCcx7Gi+PhitdhBndp35/Eywev5kI1ph5LN48vca260ZVZTIRlfziM33rx/VU41OlkSu68ZkUDtiq+gCN4KqojVM/DUt5TNfAyZebssnPy2eREEByjzDdp+nK8xtWkybxCJPX4gyMu6h0eYu7QkFLNcF564cVHViL6RQcc54Zeoz2QsT8oe0DxgBZ+QMHFpcl9pcFbL/y+XjsjcXZuvMRGRrhbApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4qM/ngLrfPnqWi0Fb1fg1fq9WWVMk1a99HUIWr0bPA=;
 b=EHFh6jKluoG0b5qu0usDHKtSbLJXfS3LDfM+d+qDZdtCCAPrL6NfNKxU5ykEwshgsPEgQlYrDKu77qNLUzVzEDVjS3GXdbZd1OEb65+5Rga34PmoV0j0brRiD5Ej7Oe9EdWLQvlcsxGyGi/2rmwnCjM/j3zK1qcx2QXLQz2AMW4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 10:30:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 10:30:16 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     acme@kernel.org, irogers@google.com, namhyung@kernel.org,
        jolsa@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 3/9] perf metrics: Pass cpu and sys tables to metricgroup__add_metric()
Date:   Wed, 28 Jun 2023 10:29:43 +0000
Message-Id: <20230628102949.2598096-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628102949.2598096-1-john.g.garry@oracle.com>
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd79a60-3229-4fe6-0601-08db77c2aa1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80lcX4R12gaweELdcsNAFJ0V2BwUqPBm57HZ2AHY2lAabgxmFx0znFPdyGE00RpS986TvjiThU6rs7ShUo+uSXecxnyE5R+GuDzcom2Uj3VF83PThBy9lxuK5P86UFJjaig/KiGBhi9jMDAyOKx8RriV/XLIA8EMugkN/v5/LE0/vEnhUDQigdVB3bi+OnLQisDNnkphAxYFlqRqrXk01QTznJC96uxSoT+/6USJGu7Ad40g31tuKKmpN3bDFnp/M29eMej6JgRUFKf9M+GV9E1PjANFoco0OeyPmrDiS63VQ+eTjzBoad56K9IQlZCZ4brNu7l4XXO7zRh7ZomCOwluhKaOYG+1i5A9zjjYvNZoLqbG8nvZSdbMr80pwpwQSkOHQGfIicgNcfAU3tHcWxAhugXWZzUv4BR8sPD9MkE0/4pGr5+KyzgKGb5+Sg7Qu9xUuXXvTmYA2YceDJyeRJV00S7DF8KouThcUCHv/0vkpGEEFKqcOXlt7/N+D+gQ/xDJ8yCz1T2Cwt1x7E2YuocPeFVNwb75+pX7H/95fwUi/8k4rDUBZKQMGQe1Lov48EkiDiiquguU6eHYNp89iibFplB+5kVIxB5iFVenjBBxT6B0uDlnU+riYwukzUdv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(38100700002)(83380400001)(103116003)(36756003)(86362001)(478600001)(6666004)(6486002)(2616005)(8936002)(316002)(66946007)(8676002)(41300700001)(66556008)(4326008)(66476007)(107886003)(1076003)(6512007)(6506007)(26005)(186003)(7416002)(5660300002)(2906002)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MZUFrd359r1ckDq76oy+/DuK+rnV+UVDEnxFbpRBaPjwLT47Fn7ZDSfGRc8x?=
 =?us-ascii?Q?2q4XeJF3HHxSKWOHVxWrcTi3xXTdTsqQU26aC3Y+ltySnQX/DqWdcplq1XN/?=
 =?us-ascii?Q?ydhXJJUlJYloRoPpzTtlRCBDLifpuAUAILakvvpEsXje9LV7X96+GOr0Jpy8?=
 =?us-ascii?Q?cgr4KvgqwHytc0xLY2tLS3mz9RDwKIjW1uwclvvRA4XBRW4oM36ppAtltrsB?=
 =?us-ascii?Q?MDtQ7Oe4pel7wT0WLFT3e6/6gnHegFvEI7YCuWxjpe590a0ZGyHsFm6Dv+Sl?=
 =?us-ascii?Q?47A7A8D9zslI0Z4oJoccjdxv3lgngBTFjuRESj8aKkbxAOS6bYn5PdTgy7fB?=
 =?us-ascii?Q?vKZ13fhWUY5E7CUe+eqUuRN+kTww/YbvZZGSgEEH0aXiZe9kI6oPCL4jytUc?=
 =?us-ascii?Q?dZ/jeHRxmMX5Mn7Wh3sM1i+2kWM//VWRcQqY0E+1+JrdEqKZcWK7wj/NorWJ?=
 =?us-ascii?Q?fDdrFNxXZoYgaN/Rp7y69O8XnfLv7AaC4hxwYnpe+sr4ezqUIUUYL3r0qKnD?=
 =?us-ascii?Q?kHb7LR+xe6aX5NDMGjP49HExZzs3wqEcRp9Eq8qkfZ3sAX6mP/R3lxYEmZ5b?=
 =?us-ascii?Q?eKmAdH0LTE8YR+1a9qpW77QKTU7xn3SOWnZD+iG5Z810R3VSOEbvW/27uqqx?=
 =?us-ascii?Q?Dhfu6rPnpZlD0OdwDIUzZju7za3yOpxYya66YV43t5Dqogy/fy2A8zjaS3jj?=
 =?us-ascii?Q?D2aQQiKbNYmZ3RF4nFx6lWwZmSirbSKZD9k9OqJBFtoohkhRjmEXy+sA4ztR?=
 =?us-ascii?Q?05VsgIHqkExH6bVFVDzmcTCoOAqWbT/W+qKlnwLzuNuwwWnegilpgMuvLex8?=
 =?us-ascii?Q?wUZC93RhU03YoHcnjSsI6YZToOM646SjB2sivs56vNfu/5MQ0PeL3n4tzZ3Z?=
 =?us-ascii?Q?oGvQesEmFObIXv4t8/eJQfMWD52YhOMnJUGLcnFd2b1xAWRrTh60GHt1wN9t?=
 =?us-ascii?Q?8l4j/8nIjS5mdYTrfCO+UGVURdyt64eMFjaDiOY1+uRGV3hWvyDkb7UWd3au?=
 =?us-ascii?Q?ZSb/xYmJIvoS1SAS8ksDYBvS9uIMOkkAk9X6GmPHR/4afHL4Vb6CTNzdXeUs?=
 =?us-ascii?Q?xXd6iTTyALpk8aeFVOSTL9DcN5CKQaHTsH4yGbmzpnTQcXrMzsghbj+2cZiI?=
 =?us-ascii?Q?6wh6zVDgyAXFnJTdRGC0tIV8AOHWWcl0YtZ25dPHUNfGRpsyjHl+jd1L5t8v?=
 =?us-ascii?Q?BAKKyFmf8W1M8pb2PaOqkYeNgnHFft9u0x62XFPxLv6g+CRs8kJebAR3lOB4?=
 =?us-ascii?Q?XodZBufSFaoY+aoAxW/PL/Q2X0/iFuuM5dxO9HmWjpAR/D3H2tTHENLK17UV?=
 =?us-ascii?Q?EScuLjaPbETAhfZo4SQxOltxHFwupbdq4YH4vjEFdQHewaD4gP9q2oTxUOiv?=
 =?us-ascii?Q?ePKCxRihBO6ykR1kCcuBOUt5TaGkagmSSZrnWWAk7iw2axLXKI8l9qtmchCi?=
 =?us-ascii?Q?1hp8yF+ebJaLZSmpdEN+6ocAkoUkY2SXRKympYZjKNsgvKQ4kIz1jhf4xmPL?=
 =?us-ascii?Q?qfvNiQXMOeBLdTF+cB5uEu47gOz63/qI2erXtTOI++Pi/sb/dbHUKs9phfJk?=
 =?us-ascii?Q?ziIC+T0mGRRR56RGhpPf/apQUP/Ul5X01jNXMTKY8Z0RLu+zP8e4JTTcy/Vo?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?hb84sbXCOkFsGWFHgxRnjbxsjEu7xdDTaIj5VFxV018Ghu4UMTkMCpdBY9ky?=
 =?us-ascii?Q?YuIptYQIV05DoaqBbVo8xx2QCnFPbAalu7ye1oKGNfU4eOV2tj8DdXpF/wKK?=
 =?us-ascii?Q?gw/go1is5gr82/fktRH+TVZ84OPDX8f7onR9xmqudr8QWaaEKzuYOzgd3Ss5?=
 =?us-ascii?Q?cWCFXNRIQXyf1UWBC/UB++cBmdSPKuVbv1ZbuWwffcDRLMoOpVU59YlkMiUb?=
 =?us-ascii?Q?wzXhnW0fvc09Xq4EuMHUSKtRGo0sRIBejcCzkANI2t9iO2w0Pmofxus2Sczi?=
 =?us-ascii?Q?qPxLf/+fFG6sB6N8PhWrr1FuV1qxzAKkrbYG/EIqfrSESN6cjDR3Z76nYUzh?=
 =?us-ascii?Q?hR6ywgI23IiqfRNMHO8+gD/vCdSi3K+DAxtrhOkoXn9HkNCpdeLGJy9NiIkW?=
 =?us-ascii?Q?Br3FuFZsJthhqgC8e2mz4JhOa4acNgKRMTWBiQl0SJpjpLbB9FvftmpOOl3W?=
 =?us-ascii?Q?joZWlHLLw1OxuZi6inWJ8fym8XkUaRz8YkhmWkKwqo8w/9rRCmEwkx5ErNkk?=
 =?us-ascii?Q?cRdwfNVPttNsyq0yyaAhjrHwnEapTsFdTy+tgiwoVk5QtYRKdNjT6G/+HRxK?=
 =?us-ascii?Q?vir97BqAJCQOE4c82EqQeuyzMFxSJKvncGcVpnykdTOeamzKQ5RWjvi5BPuf?=
 =?us-ascii?Q?BE4T8reeNbyCq4DO7PRSOZzLKBkjHJ/E3w4o9OAe2fuQxK9utZyxGGb4kW3q?=
 =?us-ascii?Q?/ExX7jkJTVZB0RWhqj5p6blT0Ox0SYVG0yBouqTi+yrWZKEuSx4ius1iCzs5?=
 =?us-ascii?Q?dmVJGkQqfa+OVvaf6WUJqsZhMq1Zd5UOYQ45eStRddMBCRD1MXxgEiTWkiZJ?=
 =?us-ascii?Q?00z0vc6qe3xf8mWtgCLR7iuT45ex3PD8kn4aUT2Woob8SR7DcIzcKBui0C2H?=
 =?us-ascii?Q?lgHiEtZLDZlRwC/DynNQEk0uzvTLk0aRW4c7fkSvGPK8JC5Jfo72+19RakUg?=
 =?us-ascii?Q?7MzXzjyYmka//JkKZXKpcbEIsBOb+Djzaa7qK1RT4gwgHOT4NIWiq205VUiH?=
 =?us-ascii?Q?lEoOnRraCVlYxBtn9YmZmwaONRxZjtUGEr08FntRC23lxD5gCNPnHZ7z++lZ?=
 =?us-ascii?Q?qro4bwo5vflaHnmf+Bayk+Xz+Qu9wQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd79a60-3229-4fe6-0601-08db77c2aa1a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 10:30:16.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZ5qs0KYNVmPWWsBomVW5MGgZTFGDaV/Fx2fjg6JZZBp7VjfEv7aAOQEt5EzDDGVN0uf3bjvK2tFq4rbgLVcwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280092
X-Proofpoint-ORIG-GUID: Zh1faJHjqPMjsUabR94QPohG6tcK1dPI
X-Proofpoint-GUID: Zh1faJHjqPMjsUabR94QPohG6tcK1dPI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current @table arg may be a CPU metric table or a sys metric table.
There is no point in searching the CPU metric table for a sys metric, and
vice versa, so pass separate pointers

When sys metric table is passed, this would mean that we are in self-test
mode. In this mode, the host system cannot match events in the metric
expression as the associated PMUs may not be present. As such, just try
add the metric, see metricgroup__add_metric_sys_event_iter().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tools/perf/tests/expand-cgroup.c |  2 +-
 tools/perf/tests/parse-metric.c  |  2 +-
 tools/perf/tests/pmu-events.c    | 29 +++++++++++++++-----
 tools/perf/util/metricgroup.c    | 45 +++++++++++++++++++++++---------
 tools/perf/util/metricgroup.h    |  3 ++-
 5 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index 9c1a1f18db75..50e128ddb474 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -187,7 +187,7 @@ static int expand_metric_events(void)
 
 	rblist__init(&metric_events);
 	pme_test = find_core_metrics_table("testarch", "testcpu");
-	ret = metricgroup__parse_groups_test(evlist, pme_test, metric_str, &metric_events);
+	ret = metricgroup__parse_groups_test(evlist, pme_test, NULL, metric_str, &metric_events);
 	if (ret < 0) {
 		pr_debug("failed to parse '%s' metric\n", metric_str);
 		goto out;
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 2c28fb50dc24..e146f1193294 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -95,7 +95,7 @@ static int __compute_metric(const char *name, struct value *vals,
 
 	/* Parse the metric into metric_events list. */
 	pme_test = find_core_metrics_table("testarch", "testcpu");
-	err = metricgroup__parse_groups_test(evlist, pme_test, name,
+	err = metricgroup__parse_groups_test(evlist, pme_test, NULL, name,
 					     &metric_events);
 	if (err)
 		goto out;
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 64383fc34ef1..de571fd11cd7 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -798,9 +798,9 @@ struct metric {
 	struct metric_ref metric_ref;
 };
 
-static int test__parsing_callback(const struct pmu_metric *pm,
+static int _test__parsing_callback(const struct pmu_metric *pm,
 				  const struct pmu_metrics_table *table,
-				  void *data)
+				  void *data, bool is_cpu_table)
 {
 	int *failures = data;
 	int k;
@@ -811,6 +811,8 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 		.nr_entries = 0,
 	};
 	int err = 0;
+	const struct pmu_metrics_table *cpu_table = is_cpu_table ? table : NULL;
+	const struct pmu_metrics_table *sys_table = is_cpu_table ? NULL : table;
 
 	if (!pm->metric_expr)
 		return 0;
@@ -834,7 +836,8 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 
 	perf_evlist__set_maps(&evlist->core, cpus, NULL);
 
-	err = metricgroup__parse_groups_test(evlist, table, pm->metric_name, &metric_events);
+	err = metricgroup__parse_groups_test(evlist, cpu_table, sys_table,
+					     pm->metric_name, &metric_events);
 	if (err) {
 		if (!strcmp(pm->metric_name, "M1") || !strcmp(pm->metric_name, "M2") ||
 		    !strcmp(pm->metric_name, "M3")) {
@@ -890,13 +893,27 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 	return err;
 }
 
-static int test__parsing(struct test_suite *test __maybe_unused,
+static int test__parsing_callback_cpu(const struct pmu_metric *pm,
+				  const struct pmu_metrics_table *table,
+				  void *data)
+{
+	return _test__parsing_callback(pm, table, data, true);
+}
+
+static int test__parsing_callback_sys(const struct pmu_metric *pm,
+				  const struct pmu_metrics_table *table,
+				  void *data)
+{
+	return _test__parsing_callback(pm, table, data, false);
+}
+
+static __maybe_unused int test__parsing(struct test_suite *test __maybe_unused,
 			 int subtest __maybe_unused)
 {
 	int failures = 0;
 
-	pmu_for_each_core_metric(test__parsing_callback, &failures);
-	pmu_for_each_sys_metric(test__parsing_callback, &failures);
+	pmu_for_each_core_metric(test__parsing_callback_cpu, &failures);
+	pmu_for_each_sys_metric(test__parsing_callback_sys, &failures);
 
 	return failures == 0 ? TEST_OK : TEST_FAIL;
 }
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8d2ac2513530..520436fbe99d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1232,13 +1232,14 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
 				   const char *user_requested_cpu_list,
 				   bool system_wide,
 				   struct list_head *metric_list,
-				   const struct pmu_metrics_table *table)
+				   const struct pmu_metrics_table *cpu_table,
+				   const struct pmu_metrics_table *sys_table)
 {
 	LIST_HEAD(list);
 	int ret;
 	bool has_match = false;
 
-	{
+	if (cpu_table) {
 		struct metricgroup__add_metric_data data = {
 			.list = &list,
 			.pmu = pmu,
@@ -1254,7 +1255,7 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
 		 * Iterate over all metrics seeing if metric matches either the
 		 * name or group. When it does add the metric to the list.
 		 */
-		ret = pmu_metrics_table_for_each_metric(table, metricgroup__add_metric_callback,
+		ret = pmu_metrics_table_for_each_metric(cpu_table, metricgroup__add_metric_callback,
 						       &data);
 		if (ret)
 			goto out;
@@ -1267,7 +1268,21 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
 		goto out;
 	}
 
-	{
+	if (sys_table) {
+		struct metricgroup_add_iter_data data = {
+			.metric_list = &list,
+			.pmu = pmu,
+			.metric_name = metric_name,
+			.modifier = modifier,
+			.metric_no_group = metric_no_group,
+			.user_requested_cpu_list = user_requested_cpu_list,
+			.system_wide = system_wide,
+			.has_match = &has_match,
+			.ret = &ret,
+		};
+		pmu_metrics_table_for_each_metric(sys_table,
+			metricgroup__add_metric_sys_event_iter, &data);
+	} else {
 		struct metricgroup_iter_data data = {
 			.fn = metricgroup__add_metric_sys_event_iter,
 			.data = (void *) &(struct metricgroup_add_iter_data) {
@@ -1320,7 +1335,8 @@ static int metricgroup__add_metric_list(const char *pmu, const char *list,
 					bool metric_no_threshold,
 					const char *user_requested_cpu_list,
 					bool system_wide, struct list_head *metric_list,
-					const struct pmu_metrics_table *table)
+					const struct pmu_metrics_table *cpu_table,
+					const struct pmu_metrics_table *sys_table)
 {
 	char *list_itr, *list_copy, *metric_name, *modifier;
 	int ret, count = 0;
@@ -1338,7 +1354,8 @@ static int metricgroup__add_metric_list(const char *pmu, const char *list,
 		ret = metricgroup__add_metric(pmu, metric_name, modifier,
 					      metric_no_group, metric_no_threshold,
 					      user_requested_cpu_list,
-					      system_wide, metric_list, table);
+					      system_wide, metric_list, cpu_table,
+					      sys_table);
 		if (ret == -EINVAL)
 			pr_err("Cannot find metric or group `%s'\n", metric_name);
 
@@ -1534,7 +1551,8 @@ static int parse_groups(struct evlist *perf_evlist,
 			bool system_wide,
 			struct perf_pmu *fake_pmu,
 			struct rblist *metric_events_list,
-			const struct pmu_metrics_table *table)
+			const struct pmu_metrics_table *cpu_table,
+			const struct pmu_metrics_table *sys_table)
 {
 	struct evlist *combined_evlist = NULL;
 	LIST_HEAD(metric_list);
@@ -1547,7 +1565,7 @@ static int parse_groups(struct evlist *perf_evlist,
 		metricgroup__rblist_init(metric_events_list);
 	ret = metricgroup__add_metric_list(pmu, str, metric_no_group, metric_no_threshold,
 					   user_requested_cpu_list,
-					   system_wide, &metric_list, table);
+					   system_wide, &metric_list, cpu_table, sys_table);
 	if (ret)
 		goto out;
 
@@ -1697,18 +1715,19 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      bool system_wide,
 			      struct rblist *metric_events)
 {
-	const struct pmu_metrics_table *table = pmu_metrics_table__find();
+	const struct pmu_metrics_table *cpu_table = pmu_metrics_table__find();
 
-	if (!table)
+	if (!cpu_table)
 		return -EINVAL;
 
 	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
-			    /*fake_pmu=*/NULL, metric_events, table);
+			    /*fake_pmu=*/NULL, metric_events, cpu_table, NULL);
 }
 
 int metricgroup__parse_groups_test(struct evlist *evlist,
-				   const struct pmu_metrics_table *table,
+				   const struct pmu_metrics_table *cpu_table,
+				   const struct pmu_metrics_table *sys_table,
 				   const char *str,
 				   struct rblist *metric_events)
 {
@@ -1718,7 +1737,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 			    /*metric_no_threshold=*/false,
 			    /*user_requested_cpu_list=*/NULL,
 			    /*system_wide=*/false,
-			    &perf_pmu__fake, metric_events, table);
+			    &perf_pmu__fake, metric_events, cpu_table, sys_table);
 }
 
 struct metricgroup__has_metric_data {
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index d5325c6ec8e1..b5f0d598eaec 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -79,7 +79,8 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      bool system_wide,
 			      struct rblist *metric_events);
 int metricgroup__parse_groups_test(struct evlist *evlist,
-				   const struct pmu_metrics_table *table,
+				   const struct pmu_metrics_table *cpu_table,
+				   const struct pmu_metrics_table *sys_table,
 				   const char *str,
 				   struct rblist *metric_events);
 
-- 
2.35.3

