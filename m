Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5C2740EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjF1KeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:34:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12536 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231443AbjF1KbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:31:14 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S8xh4Q015057;
        Wed, 28 Jun 2023 10:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=UU2sHGlmXXcaiJGNyo96qt+oyclFyaELE//6xrkiAbc=;
 b=XYNgcvMDENO7YQVwtryj+cXu8DcwFcne5IT4rj3CrFCLTvNNQvlDabaM26Q+jleakOTv
 5b4AnzLbct7uXOT95yXud+khYF5s9cNkEufkcUPksRRaoOttEDdY3S4X7Zc556lydZCZ
 vF7sZAzNVXupuaV1Cih26Y9shE+ue26yMMajxVtmjAog1g4JIyDAPlYL/YL0rJS8mnQd
 rL16jhhKG94OHbmK9iXAd5WfJmZntTKgMkKtX9XA/U3Rvhi0hItDoepSgfhc682FZ3sJ
 hbxdw3n4MfICqztdlyqSkGgKRA6/eQhi8IDnTmurUWJ9Lxohoa3Pea+yr5v4bKAVAWtB cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1u73hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35S9H164029644;
        Wed, 28 Jun 2023 10:30:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx5tpwe-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWk1bnFDeVqC2jc9xU3htcTqWE/lZvoBnUbW9jztO1iXIK+y4OEJ1BRvQS4XUM7TUsYVssaGRQPzZijvJOWkUVsuNghpIX/t3czCiBAFMfgb41tjOQEcTVtP5YWSJyHLJrzHc2i4JE6TNwxBLTj5A7PcFfv19Zm0q+NqKC8Q8iRs24mBboxHacVvogq6txKaH/PhMiAg7bJbZ94eTo3Ljxvso6gCUF/6Kim1zJBmS9vTqbRP5xjFXjuqIQNePGzUiZjjFD66+Ugru7R6SqZcw+xzyNxgDdjhQzFw4PB5S/6H7XxgcYq6/4C1dKM+1XXzSmjwaTP4BvZcI8x97Crrqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UU2sHGlmXXcaiJGNyo96qt+oyclFyaELE//6xrkiAbc=;
 b=XYe0wGuVCu8DNlf3dlkXUv+S1Q2oSZGOE4sB9JYuH1Vy5wfAZmJuEJwnXxRPNmGbqtVWPkqT5nrHIdl5g94gIDELekNNh6WXz2scQtSnmXG7oAVeMloPn+t2haEdeQtTD7dFl/CSR8tNwG6dLot79iSm0z/PPbTqhHpyQsDOHCeaEvSzJenu7jj6OBfGARwEpncbnWof6AmiXsRm5BMKRH43YV7WGupW0G1Wjz+Owcf7e5aDFanwalYfhO5vRkyoUUxunfjOeHZNyVurYFdaHcKE2hhbJeLw3oOU78JwygfhresfCsEtQDQofM0bHDlv4NLg8MbSwH9uk9HXdgRzVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UU2sHGlmXXcaiJGNyo96qt+oyclFyaELE//6xrkiAbc=;
 b=GZO/p+3oqE2KzpoQXcBfF0t1j0M/y9AChsovZiyrdr9Lx/0zpaZCgcAuGwm1HyXyrpIWja9MdkiOfBn8DKQzIqIb584jSv9ZgFlxH3MhQRRojTRkpdQXf9GXJmm2HMIrJcqkjllDpdlrHwAqC8RVplrehRl0zZp6ZZUVRrEbkfs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 10:30:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 10:30:22 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     acme@kernel.org, irogers@google.com, namhyung@kernel.org,
        jolsa@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 6/9] perf metrics: Add metricgroup_sys_metric_supported()
Date:   Wed, 28 Jun 2023 10:29:46 +0000
Message-Id: <20230628102949.2598096-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628102949.2598096-1-john.g.garry@oracle.com>
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:806:23::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c440c4b-5c93-4459-a0e6-08db77c2ada8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ru++znWGnBDfIE9sIGOrU+lBbF/JHg1rXt1akdqStGjyPiJRLOKECa/fL5dJsk9luLsjSIK8KqZZwx/IWFAK9i3ibz1GZQIYDNBrZ9mfqbkutaBIG1G6Mz9K8NmIsBXDfUagYIV9EO1nLEe7BRE/3TIaA1nYF0yLZAhwKqhtcfyfXBSLznAVlbjvKH+kk5739epPWiVKVAriXuM7zLiNoXlz7il8vwksknoKYhHxkrzBUmYYP4Ww+uZrrhNitMopz2v/fP8MIQNpEOLefD+8pW0rsKJei8rBXQ2aHplGDfETZYZEW8RaR3JaSDplolhljjE4Aa9RrWwdra5b0cGL+Uie/3/wkCrFPIt3mTML5IbkYfOFzX/h5alGudlogFFCaiPd4Zp/1sV0gOZwh8GyxJFAC2ETznHzEcOqWkT8+gzLzzA/3FiWTK0fiIsM45TvtNRuwHIRq2XlkSeNCpE/doBXB4LIbMWs3uTGcUhjxVbzLPZ/fO2wK3Xhkx5EwxsctDiW/lhKax0HYcaiUzP16KZU4bBh8/ZZlQTPzKyF95RkNdwtZwTz1wpEqzvk2Z7V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(38100700002)(83380400001)(103116003)(36756003)(86362001)(478600001)(6666004)(6486002)(2616005)(8936002)(316002)(66946007)(8676002)(41300700001)(66556008)(4326008)(66476007)(107886003)(1076003)(6512007)(6506007)(26005)(186003)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qQsbxo1JQCExF1MfJbz4KfEXnsvW04dgjNvn/Ss5zhg4yMcdbzW2iBNAhgai?=
 =?us-ascii?Q?7xI/pr+F059ZDC2lkvYbxYQsIrGS/VdU3eNOoh4WmInVXRNX/Pm0zAAA8BRv?=
 =?us-ascii?Q?/p08g5qbJovpQfmi2WonlFDBuVHeYd5jG4kYyofEaxAU01aN3JCqw/PYOXlu?=
 =?us-ascii?Q?8dyvzK5kx0MGMKZ8e9DqHJ4Me68tkzROUfkXz12EOfbjsndn9l7ZV9R8g50t?=
 =?us-ascii?Q?M/6B8F2u6EmKMt5+Xg0gwIsdI6BntrVnKUrM+d6r6Rtrnwm/FJ7hSG+Jx2SJ?=
 =?us-ascii?Q?vt+4pT2PRoYW9OMHrrp4GJ5FsadM/jO+zwKHnfnxZ1jNKgaP00HiPmJIfkpI?=
 =?us-ascii?Q?nOyRWlT0IRZ7cdUa2hmv8M2XFxYEgZ1YpFNLX3A7L/l0H9TdPiCwQUkYfBe5?=
 =?us-ascii?Q?WpBaxIAeGNpJLB0u446ARUH9qXUeFiBubV2pTuIWOj1Qe/TEXp5h9Mqx+asu?=
 =?us-ascii?Q?u3o3pjJZGm9mMNHQh0KATmYxSl+zJOqyehlO1n1ERKuzJvAZI+TkQVi63dSo?=
 =?us-ascii?Q?bl04rkktVb7wDzbNBYXFZ1yzq+wnlJJsD3tdl98K6tTJkovmvB96kU/cpDti?=
 =?us-ascii?Q?Um0lFIbS+r+PqNAL1LJENM6+C8NzmboI2/19rxBxfaov/8FxzLsqDcqhQ2/e?=
 =?us-ascii?Q?JDu8Xrx4a2j1aOg5VwkdI0J/f+wS8KDsCuxbrELvVlcKYltg8wAdQlUVgTwj?=
 =?us-ascii?Q?Eftot2LDS6Gxa1vZjtb5aJFtxFG/mW/cmoMuo3mUm58Eo32WuMo1ZmQtikx8?=
 =?us-ascii?Q?/Ercfj8cRfaGk9A/1bBN6zEZrSBbZqy1tW2eTSW4yQD+dRSDCSsY84UvYO53?=
 =?us-ascii?Q?BmE5yk24vNTlXnFZSj2CmiUDQ/bPNs1kUDXk1nWSLF8U3Nq+Q4mrszO21kqI?=
 =?us-ascii?Q?XYJQuj2+O1SFCGKMOYL/cwO3EO/MokQKReQaQZeOzpKNCj5Sp1gpO6RwpmtV?=
 =?us-ascii?Q?xPsQi5XvqNI4PZuXyyHGlyB0fQPDvnzyXTWIB5n17tOr8Y5vdNVNcjDfr7LG?=
 =?us-ascii?Q?LyvNcbHs2xmSRmUPT0MIhz6dJqu/VibbBNdRO4RYUmACZAt62VLOBH/igzMn?=
 =?us-ascii?Q?jaQxXgLcdFciN+GjbZOFVDw9SKZ00g2TJ7J1D35aHMTWBSFDC0+7SDz3su5C?=
 =?us-ascii?Q?WBjfTYd4aCQchx3eU2pf9RYWn2BS0XcJPFB1td0eNrJg4mNyr+8puCmpUTa3?=
 =?us-ascii?Q?Nfvg5Wik+xJeBkzMNTRV4Qp27trwQz1KKSnMndKGtvH8xUkd8L/hVK0UxBJ2?=
 =?us-ascii?Q?Da9DJsQa5lBqyRS8e1e+xAfmrcQHENF0bvbvXbHifTF5YsXySKtBg+2oT1bt?=
 =?us-ascii?Q?SUzMPReU8+iHI2gDfJN1hnHI3l303HnHA4pXOJgjXA83QUN71g015hd3eYqJ?=
 =?us-ascii?Q?89H4Accn8EnddneeaIlTmbiQtIwDPFEQeHQ4qXTAAUuJcznR+mJudWeDj9YJ?=
 =?us-ascii?Q?N2J1inliM47w9yfIG5nC/5qIIt+ookgchbbUxgh22kpR5CQYQsvQbzsjrKUw?=
 =?us-ascii?Q?Qgf21m+Wx0FjoElqX67qj6EmBYfqEjQVt5JaK9/k4kculiRNe1W6nEwQbNYM?=
 =?us-ascii?Q?if/zDRO3Kr1/AR7iTfGB5osDwbhE1R1WNJ+96fN4GU0uDYwyEIQFq4MNdBzS?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?b+dTCftJ3ZuI9O/zJ4pgvPfdsTeYqsMKM8wxk3Dhwmq41l/yQE1qN91s7vVn?=
 =?us-ascii?Q?jl1GAxxV7zRsH1BsA6+++zyOJK82PzH1hxfvN1skXOhOJJ3Xel3GhD/aEDkW?=
 =?us-ascii?Q?KXpYFRB/+oxwAth3tiDIOVN0AszNfs29/QoXgKHfEvkLt+7mNL4jygZuQ5Vq?=
 =?us-ascii?Q?RvIz7OxX1hXXk0ahwP97+gdRKAbisoESLu2NdUGzUAqn3VfGp/QFyVUR2FPL?=
 =?us-ascii?Q?WWoLdS2VFvWvWSr0RZY+IQsgouQs9EKb6Z+eqTVcnI1qNn3DQm9oZ7ZXlxmC?=
 =?us-ascii?Q?zdYf0AP8alCQrmdxkwZ8dKZrWCNh1CNIUCSUziFaCJI9VYBhgtshsl5HFSWN?=
 =?us-ascii?Q?/PU1dZX3zJ0X3Qz+QZT7Oh1FXYP0K0rZa3mxKFR/tzwTv/FP1UNgHGYYU1s5?=
 =?us-ascii?Q?ST0TBJvDRiOqlDqcY3QF3OJv8lUetrH0TTkdFAaz3tfV4H5vp5FwASROgScH?=
 =?us-ascii?Q?OvBWv3hYzYQ7yIvbiyjguVlwtwKG5dA0KpXEMEI2YIwp7xw/KgrwTv0vH1jH?=
 =?us-ascii?Q?WVBBdsMw4DS9t99WHniH8x8K1dEleFd0rJrsxySGwRbg5QMZ8BiGpbAbMwQm?=
 =?us-ascii?Q?qcDCimDs8xh6fYjXAesFQ7AIXg5nzXs0vIRm/rXKvF7hbfBW4N9RqUtg220r?=
 =?us-ascii?Q?2cMA2kUyuSTX0boz4dsw413biOOuBecoFaFb7d5N/To10smbv56KlFZ5Zprm?=
 =?us-ascii?Q?0CqJ58/S4jt3fXijGvwavbutDzUOe0sVRvPrw7ejH3H5ZPSCRIAl26eRkTkK?=
 =?us-ascii?Q?kv8LTyegjKDYgM44PyU/TmNS66Og0FmfgcaktCr3/vDxyThXwf3Pd+DdOOda?=
 =?us-ascii?Q?vPkmkUx3wqwuLWWtjf35IdRuO7xulU8lagcMM6xPGbuzR2XXAlN93xxLNUCq?=
 =?us-ascii?Q?XdbE/Azj/9+G3g6sfJ/CrZ2V5iJsKHHqgqikZfR2UaQLX/nwXAPlSeDyNz6N?=
 =?us-ascii?Q?PjG9dvVYmnFTH9HJVfXmyLFb5JZaK/XWQbSYHOqOLKSCKDkaVdqmuJT/QAih?=
 =?us-ascii?Q?TvXbRsgxSN49CahFhO5ga6DZceSakdQwUkRLylLLb50T39HXwiHKgyvCt+Bt?=
 =?us-ascii?Q?YvRcbyuVFpeehriZk65eaNcyM5Yz1A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c440c4b-5c93-4459-a0e6-08db77c2ada8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 10:30:22.4974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52LVoTVCPGYqnrqKsBjrpX8gY/kh0F6VGDE4PNXVY68Lx6T0wqaqfz0se/JICTeg/XuNdvL8wjAS1qOBFxUnPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280092
X-Proofpoint-GUID: t4hyf-cdVM9pw-cj4MzAaev4aUmDo9u0
X-Proofpoint-ORIG-GUID: t4hyf-cdVM9pw-cj4MzAaev4aUmDo9u0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function to match a sys metric for the host.

Currently we do the following the match a metric:
- iter through all sys metrics for all sys event tables
- for each iter, iter through all PMUs
- if the PMU Unit and id match the metric Unit and compat, then the metric
  matches for the host

We should not be required to match a metric Unit and compat, unless the
metric explicitly specifies target PMU, like:
 "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0xffff\\,axi_id\\=0x0000@",

Rather, we should be match against events aliases present from the events
in the same pmu_sys_events structure. Those events added will be gated on
matching Unit and Compat specifiers.

The steps in metricgroup_match_sys_pm() are as follows:
a. Find event table associated with metric table
b. Call add_metric() for the metric, which resolves referenced metrics and
   generates a list of type struct metric
c. Iter through metric list and parse ids, to find a list of evsel's
d. For each evsel, match event against known events in event table
e. If we can't match an evsel as the metric explicitly specifies target PMU,
   just match evsel PMU against metric Unit and Compat.

Step d. is required as in parse_ids() -> parse_events_add_pmu(), we might
have matched metric for other system which has the same name, i.e. when
we find matching event and PMU, we must ensure it matches compat for event
from metric's associated event table.

Function metricgroup__sys_event_iter() will now call
metricgroup_sys_metric_supported() to match the metric.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tools/perf/util/metricgroup.c | 115 +++++++++++++++++++++++++++++++---
 1 file changed, 105 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 520436fbe99d..6be410363099 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -486,23 +486,18 @@ struct metricgroup_iter_data {
 	void *data;
 };
 
+static bool metricgroup_sys_metric_supported(const struct pmu_metric *pm,
+			const struct pmu_metrics_table *table);
+
 static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
 				       const struct pmu_metrics_table *table,
 				       void *data)
 {
 	struct metricgroup_iter_data *d = data;
-	struct perf_pmu *pmu = NULL;
-
-	if (!pm->metric_expr || !pm->compat)
-		return 0;
-
-	while ((pmu = perf_pmus__scan(pmu))) {
-
-		if (!pmu->id || strcmp(pmu->id, pm->compat))
-			continue;
 
+	if (metricgroup_sys_metric_supported(pm, table))
 		return d->fn(pm, table, d->data);
-	}
+
 	return 0;
 }
 
@@ -1705,6 +1700,106 @@ static int parse_groups(struct evlist *perf_evlist,
 	return ret;
 }
 
+struct metricgroup__test_event {
+	struct pmu_event *found_event;
+	struct perf_pmu *pmu;
+	char *evsel_name;
+};
+
+static int metricgroup__test_event_iter(const struct pmu_event *pe,
+		const struct pmu_events_table *table __maybe_unused,
+		void *vdata)
+{
+	struct metricgroup__test_event *data = vdata;
+	struct pmu_event *found_event = data->found_event;
+	char *evsel_name = data->evsel_name;
+	struct perf_pmu *pmu = data->pmu;
+
+	if (strcasecmp(pe->name, evsel_name))
+		return 0;
+
+	if (!strcmp(pmu->id, pe->compat)) {
+		/* Copy, as pe is only valid in the iter */
+		memcpy(found_event, pe, sizeof(*pe));
+		/* Stop iter'ing */
+		return 1;
+	}
+
+	return 0;
+}
+
+static bool metricgroup_sys_metric_supported(const struct pmu_metric *pm,
+				const struct pmu_metrics_table *table)
+{
+	const struct pmu_events_table *events_table;
+	bool tool_events[PERF_TOOL_MAX] = {false};
+	struct metric *m = NULL;
+	bool ret = false;
+	int err;
+	LIST_HEAD(list);
+
+	events_table = sys_events_find_events_table(table);
+	if (!events_table)
+		return false;
+
+	err = add_metric(&list /* d->metric_list */, pm,
+			 NULL /* modifier */, false /* metric_no_group */,
+			 false /* metric_no_threshold */, false /* user_requested_cpu_list */,
+			 false /*system wide */, NULL /* root metric */,
+			 NULL /* visited */, table);
+	if (ret)
+		return false;
+
+	/*
+	 * We have a list of metrics. Now generate an evlist per metric, and
+	 * match each evsel. We match evsel by findings its corresponding PMU
+	 * and then ensuring the we can find it in either a. the event list
+	 * associated with the metric or b. if it is a metric referencing an
+	 * explicit PMU. In both cases we match the pmu->id against the event
+	 * compat.
+	 */
+	list_for_each_entry(m, &list, nd) {
+		struct evsel *evsel;
+
+		err = parse_ids(false, NULL, m->pctx, m->modifier,
+				m->group_events, tool_events, &m->evlist);
+		if (err)
+			return false;
+
+		evlist__for_each_entry(m->evlist, evsel) {
+			struct perf_pmu *pmu = perf_pmus__find(evsel->pmu_name);
+			struct pmu_event found_event = {};
+			struct metricgroup__test_event data = {
+				.evsel_name = evsel->name,
+				.found_event = &found_event,
+				.pmu = pmu,
+			};
+
+			if (!pmu)
+				return false;
+
+			pmu_events_table_for_each_event(events_table,
+					metricgroup__test_event_iter,
+					&data);
+			if (found_event.name)
+				continue;
+
+			/*
+			 * We dould not find alias event, so maybe our evsel
+			 * is for a specific PMU.
+			 */
+			if (strchr(evsel->name, '/')) {
+				if (pmu_event_match_pmu(pm->pmu, pm->compat, pmu))
+					continue;
+			}
+
+			return false;
+		}
+	}
+
+	return true;
+}
+
 int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      const char *pmu,
 			      const char *str,
-- 
2.35.3

