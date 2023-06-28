Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DC0740EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjF1Kdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:33:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15514 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231514AbjF1KbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:31:15 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S8xqNI006634;
        Wed, 28 Jun 2023 10:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=SF2Z1yQ6fGo8UydqYC7791DC6yuhonVUb/gGK8uueS4=;
 b=H0yVBlJmocXu11xJfkTeIX6ZxwiHUBg19hNDMJQeQxymnPpIUqehlqszGxNIYQUV8fcb
 +zyuf78Q+JnLJ4O/qvofzc8AoRGt10R5fQ0V40GAz9OtJ5wBa2HF6NA5UczI4MJEVn2P
 AJ/pY5T4q9TqwO5az5/aQILdMpCc23bj1MPZXj+ujj6torQFOI6h7mOoa67Lwbvsy/Yq
 nqeHB/l+szkL5yqqMEIUQZShvdmvgm9QSlvdp2JQ0Do7tOguL/Sa9Ig5ARkUm5lrObQT
 yqpdkcCVMX4eYuYtHmnN80pjrisSOArqZzUfWYPAm3nsD1oJZBmb6P2Yo4S1JN9Ni5cW Rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq30y9nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35S8vphs013125;
        Wed, 28 Jun 2023 10:30:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx629e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDFQ+h62MTkY2qFVrrSX9M7f8fZS2aCvJ7x/5nV/4PWrowSWg9j5m6KzUWAVXaJi0HOK6WX6tXUrLLuw4+0AGBKFUGiYRFrAvHlvJi6qnjVQSu+WPVZHlk81svGnecNjJfs+ZghwHNrIr2XCzrOhmfKOn9TCZa5ZoQL3wyL58YJRK5wfJbYr0IiEsGj5iTQ3IGSi7TN18yqcrzi90CBGgXddoQCrO9Mseiq0P5aS4FvL3W/MMg9GkagjJwLbexQiJwcBDh7aUoihtaXCz6CJEDnJVS7E9h/Boe5N0hdvXsaAhkcZvHwdN9XCw/ez+l5gT/QVDjMXfSs7Mn2q75p+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SF2Z1yQ6fGo8UydqYC7791DC6yuhonVUb/gGK8uueS4=;
 b=GwKffwmhpaUls6hrK3eRmwD66iMAiQgy+mEuAtUi3xj+PaWtjJiwDAIqRMp2R5gDZm57qgVKm+XVGo/rvz32tYcKXZNVFcm9TpxgkEdIwz/AF1STnwd1gu0KRjfXyMPu6nk8RAGx5le+0iZeP3QzFT3WJRQmlcpQN17yfkbmNi+PulNijleRwBVHiVpvWHL60fQbA3Oyo8lB+l7jpGupf7mjJIfp9mrwpDhk/zmbjoCTBjw+5HJA4qmBOTo9J8XjDk4NTJ0zoV17NAHLp6SGfUZfQsdWHGgk+AA63Fc2Hzaw1uZQZ+7PCP+DP3W+7QZYg6VP+wpIZ2ni9Zuiblrq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF2Z1yQ6fGo8UydqYC7791DC6yuhonVUb/gGK8uueS4=;
 b=p4rk+9sDNi/a2ZaQwP6jxoqTYsIL7DTNq2A9k+X79yL9yGh8GWMRJCiM6qEoK3xsmNTITe1n3ACD0Rf9G8wVQb+7Rir2ZRq4PLb6Gb8pGliDw9WJnOF19Z7+Anqs5ATn8meCC4mtfMm3xiONGLym0CMyYoDrWerNLg9sH4j6N18=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 10:30:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 10:30:11 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     acme@kernel.org, irogers@google.com, namhyung@kernel.org,
        jolsa@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 1/9] perf metrics: Delete metricgroup_add_iter_data.table
Date:   Wed, 28 Jun 2023 10:29:41 +0000
Message-Id: <20230628102949.2598096-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628102949.2598096-1-john.g.garry@oracle.com>
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0032.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::45) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aed91fd-f1f0-402a-2146-08db77c2a74a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2IXrvDdYCpF4YF3Ttsbecpc+S3LJOgBayXDIIt1x7ePBDASRsW+ZY3y/2EovQq3j/VP90DzkK/M2LfLsY9XuvHm7xKzIMzDT1Z6LwwVyitgafhDykKTonuOlLS+ckVGbtBnd6mVF1cSZx8E22hp3KpCLIcY4ss5UyYYIX2gXL7Q/KAlq+aQqB4LJ/v/EjLWHCU174FS2zt8LeI7VOD0qk6+Am1mgBy/s6bQ0YK/euG8nNrL2Kt2K3/xVtuUINRgd8bqLmjHmtBECf5aW00Z0UUlBjus/QCjXCsxus8jqqoarAz8iz3UAwjKAkWRvUGSKnJF5II0sdKoZ/T3/pVo1CBXEJik+Asr6vf8UXQ/wXfjCPGUgoYwnRINBS8n2MZC0HcPf2/uC5EkZ5b2Sm0lqEvSsSpAvffFLxr0UmxfOTUwlvLoh7SE6zUazehv5Kmtl5jeTGRh/zheI+BjtJ0DrfQY5jOXBFx9SNAlayOUlbdCDqs9yIeecEFl2eR/KITfF1uou28hGnXiKotlIpc200jYgXRlw4+j8VTVjSgZ+PlevDHpVtGYtDgP5QulHPZqG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(38100700002)(83380400001)(103116003)(36756003)(86362001)(478600001)(6666004)(6486002)(2616005)(8936002)(316002)(66946007)(8676002)(41300700001)(66556008)(4326008)(66476007)(107886003)(1076003)(6512007)(6506007)(26005)(186003)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HY0PuDNePb08X/ZOufmc5Pt8tnN64xytqQN1DyUqZIbPIw91XS8AudEm7LZv?=
 =?us-ascii?Q?oVUjPpGty0s7Wc2hb7b49bhtN4eoCQK5i2dqX2sGvroj96ZtOViEX1BwVCB1?=
 =?us-ascii?Q?rcnVA0m/SPQ57i6Big1hQkmSvLsYHpE5gCn3zhhv8PLMFSi/VBj+AP79NVrZ?=
 =?us-ascii?Q?leEYcP+8Vq1G9rGwdaXDKi0agQO78wFoqgJNStkHrVl15RuhvSjSXvW3mCZi?=
 =?us-ascii?Q?U1Xyv62rPVs7vhR/FuPcLlONE8t8gstj6NiV5mxA99PDNzl1pV2f+A8E073J?=
 =?us-ascii?Q?GjBc61g4oAYVeHFfV1Aebvghjx0/DVYmYz0Kuklq+NRGwb5+uX0rtV6bbPkW?=
 =?us-ascii?Q?+6wtcYLVcY/jkbyk3l29QT3GAtuT/A4qaXTQxn1IiDP/slOmkRN9GWRMNLNY?=
 =?us-ascii?Q?rzF84mM92zrh0wBNndWLKYt7SjjFd/hUtVg52fan0qX9mz2CF2/RvUqHaLfu?=
 =?us-ascii?Q?6BI8FJYxom1qPueD8KVAL8U7eMM1NIyE31GOGToOkLTElFhQ9rPjykYZwWCF?=
 =?us-ascii?Q?fStFX7Bj2z/ayk1vChVqcbzaxlsJiiOFVhxMGAlawFnV2G6E5VSuuR7sHT5T?=
 =?us-ascii?Q?tXiqizgfnT1Tjtf03Upkd7EMX5E9P2jOY1XolWcKmqaPjU2UkFuwcJQD2oRV?=
 =?us-ascii?Q?idLl046FX5XVNZpKgKiQg6OrqmI4PFfZymHlqZkHPxwoAPKHYCectUIapS/D?=
 =?us-ascii?Q?jdAErBlNtasGl886XCRDc/fVOOC6Fdv3efOTFvo6JbFRBC5USJ82lXbAjB4O?=
 =?us-ascii?Q?twOCmxxQyghCv6AHP4DX3sSzxhnwuI6XHtW7P2CFNh//zbI9qEUXRJFYZQyB?=
 =?us-ascii?Q?k2OlxRLZVVgwLxiGTmg60CwQJC33ivVP8CjKyvEJJAf1kZyJJvx+noC3+xaq?=
 =?us-ascii?Q?pw9hLxsr69kqg9gl/DkGqxsutTOduvoE7RvCQ8AV6+IZGNDw9swgC8ALb5eY?=
 =?us-ascii?Q?JTDNF+FZksfz4PCsCdGbYWeUy5wxzBwsEujBy+GlkTcx4jkupj3kEgYgPv3C?=
 =?us-ascii?Q?1g1Rcm9P9JXFTUn0IsH+XvuYh1XpHuVkG9hTuio1OVdqTX1aumJ6WquOLlna?=
 =?us-ascii?Q?Aqre7rkDnr4LEKBMv7z4mX+K4hp/scdLfFo/mzfGYI+hf7Wtm6+Ff42KKb8N?=
 =?us-ascii?Q?UixIXs7d/fZf9zq1pueMoRrOySmF+qUM5/0gv/9pMKn09ZbVKckIW9xL6Knj?=
 =?us-ascii?Q?j0g6sySlnjWZhDJlUtKufSUosTA+1Hxl4nNxiktbE6+SaguloqeLrrmR8tHC?=
 =?us-ascii?Q?dop8DU6kyV8rj7roqYY/47Q9d+F5KQay2KKKwUwAqC/3nry7z/GFWIYs9CBy?=
 =?us-ascii?Q?hFYlCbIegf0LHDev8nYH273CNtKbfdbaq+jgp4fi8GL0kM5po14+4O24narG?=
 =?us-ascii?Q?HNlFs7Dy5pv+YmjaL36Pe1DmYOcVLZqToj5khg/BkeiwmXYPyGkJDDNXqSge?=
 =?us-ascii?Q?18NsF9c++ia6pXRmX7+T4BQIVCtGAggGg1/JF8vAZhtVL/SdNgnr+SbV0PSO?=
 =?us-ascii?Q?2UmUBFTi3PjmykngZ7jb3fRgkvVqwWEiZOnfEhc924Hi9E6gzVdwpmK60c8p?=
 =?us-ascii?Q?AbNutuGxNRzj2m3oAtvYNNTQmfmDj+p8pqG3WZltoM+sC6KnR8pBCGYewUiR?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?K4gq6sGswh7mtwLc+wLsro0lB51gr+g3AmA7Hlu9t3XmTaHqcd/addEyA5Hr?=
 =?us-ascii?Q?mW+0fhFqgNnB9CrHQAQVFXBEKRoeb6/4o9zLyRIZTns2hNUKYFfLZpWhTvJY?=
 =?us-ascii?Q?PIKQ55pMzWYxHmk60aTqh3GDSKdhzwtW0Sfx8oeBoSjoLy96bFWM7ZGO8b7/?=
 =?us-ascii?Q?2L7JZb0HKShsX+rW3EyGYFs0t1Ctg50b9rhbg16gq81VHvoSHRXEVS8c1RtR?=
 =?us-ascii?Q?xzEI5pag6PEmGNkaFeQgJqJXcNip17JdRgNRYeRdUKsi26jefCHRsvpizQTW?=
 =?us-ascii?Q?RLhh5503mvClTwz7ggEN1HiDeCgBMpZllgXEsmFxrhTCigapVseUhWL6FSqE?=
 =?us-ascii?Q?bWXOtHqrDsNFUZC7X63C8jfs42wBKjK4/N3nhTUpAdcouk7AOszn/7wQjBJU?=
 =?us-ascii?Q?3sCM/uPVkbFbz6Fnnxa+b75oGMevcS0PIkdkclacNlXnuZUpzzxhOqIxStS1?=
 =?us-ascii?Q?x4HCN0Sh6r8g1Z+V6R6Bv9368IBlFyDUXgHmXtU2gLPJpolkziVzDJWsUEcK?=
 =?us-ascii?Q?tSw1VnoRP+oLP8rT1OjxJozKCgfRH5xrnffhNV3GxMdILIAsfowi0BwD9bXE?=
 =?us-ascii?Q?nZ0aQ0anZqlQF6VhbNUqw6jOZf+urpnqqOx2mZ+bSQWHeczGTZWAs5Y6vZAR?=
 =?us-ascii?Q?77NXtXKMp7oS6o+STZyqgqYe4ecgjkPn8FBJublmtDTUrElL+bCQH6ShGJxV?=
 =?us-ascii?Q?FKlNLX/WfsuPnjWIdfy0T4RXEqSsOCDCKJEWzj6qakemTmhXCLqw2U5YjWom?=
 =?us-ascii?Q?b6Kh5nOop8iB8ceMFRkgetvkiHa6aUSSK5cZAjv38d6svEbtnv9prC1k4/ip?=
 =?us-ascii?Q?qwNfhV8Hz/AdrV6MgUH1qUs41UwjwMhIKRD0FX9SOrjNWxXOYkujV7FTnVqc?=
 =?us-ascii?Q?WCKsgSeTkmBtGjpATzJFDcbwdWyh2jkCMmS3xyyEnb0Acd5xkzltLXsTNqxa?=
 =?us-ascii?Q?fgpO7vX9qF5DuTg21CbFlWgKWBNZObNL32l7+JnWRC4NxI+aOW1w5c24eEYF?=
 =?us-ascii?Q?e3Isjw6r6Nsl/kmFAKOC13OvtxWXyO3yvHydP2ZA4O/wfr+1QbB8Iw4OIgYV?=
 =?us-ascii?Q?/vjSNpIPa5yAtNH3VCbj+ITua81ibQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aed91fd-f1f0-402a-2146-08db77c2a74a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 10:30:11.8257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxp/8UHY8/BbWKhJj6Pjxkt/1wWH0NN3EcDEBsONomj2CDaPQh+DU+tDyoZ2eAIDvdWa5Sla+jKXsfh1VY5F9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280092
X-Proofpoint-ORIG-GUID: nWAHPee0XKvOZcxCXFabLcwtA3-pIKBj
X-Proofpoint-GUID: nWAHPee0XKvOZcxCXFabLcwtA3-pIKBj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Member metricgroup_add_iter_data.table is only used in
metricgroup__add_metric_sys_event_iter() as the @table arg to the
add_metric() call there.

However we only use the @table arg in add_metric() for resolving metrics,
which is currently not relevant to sys event metrics. As such, don't
bother passing this @table arg and use iter table instead, which is more
sane.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tools/perf/util/metricgroup.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a6a5ed44a679..4389ccd29fe7 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -798,7 +798,6 @@ struct metricgroup_add_iter_data {
 	bool system_wide;
 	struct metric *root_metric;
 	const struct visited_metric *visited;
-	const struct pmu_metrics_table *table;
 };
 
 static bool metricgroup__find_metric(const char *pmu,
@@ -1112,7 +1111,7 @@ static int add_metric(struct list_head *metric_list,
 }
 
 static int metricgroup__add_metric_sys_event_iter(const struct pmu_metric *pm,
-					const struct pmu_metrics_table *table __maybe_unused,
+					const struct pmu_metrics_table *table,
 					void *data)
 {
 	struct metricgroup_add_iter_data *d = data;
@@ -1123,7 +1122,7 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_metric *pm,
 
 	ret = add_metric(d->metric_list, pm, d->modifier, d->metric_no_group,
 			 d->metric_no_threshold, d->user_requested_cpu_list,
-			 d->system_wide, d->root_metric, d->visited, d->table);
+			 d->system_wide, d->root_metric, d->visited, table);
 	if (ret)
 		goto out;
 
@@ -1275,7 +1274,6 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
 				.system_wide = system_wide,
 				.has_match = &has_match,
 				.ret = &ret,
-				.table = table,
 			},
 		};
 
-- 
2.35.3

