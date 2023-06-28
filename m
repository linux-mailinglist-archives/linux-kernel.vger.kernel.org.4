Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823A5740EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjF1Kdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:33:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15304 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231495AbjF1KbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:31:15 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S8xptI023003;
        Wed, 28 Jun 2023 10:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=hDsL0TaLiobo7uqJNdvWlxbrKXtS9CwEhtroNWANHLA=;
 b=WK+jWImpkAsl47HwUVma9i0dmnCrgTu531e7kQ+U1SJMAvKzg7WPwOk8oqv1mJwUUQVw
 rERwbTlfkV3BiXURI5bRgBEF5l40HTYJt8vII7RS/PKbNPLrepREq182z+8KDjsuRLMF
 FoXh3Myp9GfTpPqUE5I5dnWSqvvwMFXF/b3BPIU27XuMN6kj0uPvvcmkykyrI6pVQd4+
 6qXiaFSVOa/fKIBH7qGHE/YLIOMAD05pwiz7mNjyzwIgrufmgVPyxUtG3eAUIicZTYLJ
 wcog+dP8su1rqf9THUXU6godvFYSK349Dd9lXR5mQPhzruUD5luJrygtqAHNmY+z9rMF Xg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdtq5w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35S99cKq008684;
        Wed, 28 Jun 2023 10:30:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx5trc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPDuBMQkUXyrPJLZRsg4z2LH+0+QkZdMOTp41lJ2zhRSgKq2N5Ecuc7yoIOt/tUtuDHnSeyLh9SQBSa5JSMXsa59JTJB6YlYN3erb1fjdN2B5HVumAyxeSGfHXEpwO0qv1eD6PIHMocWEcRxtRqoKOAGIcEyMj2BPmdBONBazhRr72xpQ4yBTp2kEwCGXhtf6aTmgJukhGA1XIVaCSB7/In6K+PZIzqXNLTLmck4Xhp6UF242nGOFSnR2F++LeAiuAllkZXFPGsopJMzmMoN+oCvTQGLNVPKYrv0soBOFL0AwfzUZvGOGbM8tW57gfAvuTsRQ9XCPoQ+Eody0ChAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDsL0TaLiobo7uqJNdvWlxbrKXtS9CwEhtroNWANHLA=;
 b=jFxQj1AVeFnhkod2eRN9QQRLBHZstCdNkPCta2f0zTHaGcZizUsZLLOpcCCcBMnZl8Xx1DXVg08/dvxRaQekhm04OIqL3ti7fh5Wb20dKQKzBTHVFlvtNoauFPRuSXQ5TBpZ0nO4yJox5cp4ttB6WFl2tJOsnEkK5PT3A6TzsDJ/5zrWZwtMJ2HvRplspWQE8dx1vfM0Ow8ytPfjF/meViFZD9Y1cKIyPBPAA8mZ/4p38m1Vb17qQ4lpLcVMJ6xCZvCxASSeYltb7I1lLT0bp4GFfZIPC14lA8JsBonsHk59browayiAoyiUdzny9TFOleP2/HqaBg6ZFzwY/egB+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDsL0TaLiobo7uqJNdvWlxbrKXtS9CwEhtroNWANHLA=;
 b=l28osTJgMBYziQjWAtoB81z0Einx4R4kc4z+DpvQqYlUFUQ6f5ZCcidxQlmA9GEPr8LfhF/2J+bkZ4guTMixURuRb2/j1nKU12W96fbi949Ti3yhjEA4s3ej63pXpbVgIRUb66vR9fPk303knTL3TAKI2FyBeJblyGql83azGFE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 10:30:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 10:30:18 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     acme@kernel.org, irogers@google.com, namhyung@kernel.org,
        jolsa@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 4/9] perf jevents: Add sys_events_find_events_table()
Date:   Wed, 28 Jun 2023 10:29:44 +0000
Message-Id: <20230628102949.2598096-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628102949.2598096-1-john.g.garry@oracle.com>
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f35fef0-a16f-4e08-3721-08db77c2ab5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /XOtBxFB+3AgAvp7kfT03Qv3eZNeYUIfx0tI/ifABnKN+qbR8FA/DbLjeWPG1fsUx6vnAD0abfQRe5rpyQDn7PlXDM1ZkqzYJ0FkSDBLzB0ph3R2nb0rNjffyE7Z6GPB6QkyF27I8qV8uYCTztuQSynYOM6XO5dpavyjQO88E5Qz2jNxYmhgoXSeOpqsIZTPdsPUqFipaoJjHuThR0fkGaVDbXshwuv5h6z0btc6ewFfp14Fy5++GGkw9i4kpfyGnjYWxR0YbFqjcpiy1/UPhBc+xv81bcpVUU+UAKcBhCImYimjfAICvd6m9YCaBrStZdpUz62j6u8ViuI7rxjXZqMjSwpRJcq5s1Qa2hh9ODeUFjoG7gMCDzOco/vhSKSwZfYAorwlpAFnugg9n7MR+NzFCTbBEdl6OV8xGWauYWxtT2scQMyNBKySIQ42Upe28LbJ/o0O04d5zzmPV3o3ijmKksIQI7gSbpLJj5PpsuFI39h+kOn7OBonEmWbEc8nol30JYxccFY5YZZtmszBvMrHNUkp/A5zqc7Jx/fqLIRQi4q0G69sfAPB1pGbUaW6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(38100700002)(103116003)(36756003)(86362001)(478600001)(6666004)(6486002)(2616005)(8936002)(316002)(66946007)(8676002)(41300700001)(66556008)(4326008)(66476007)(107886003)(1076003)(6512007)(6506007)(26005)(186003)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vagiZz3DI91c3sosbeLNrhT6Uhk4exa/wDA9PBwxg9iDuHKlC3YGEahlMxuo?=
 =?us-ascii?Q?Pzw+bDOJe6MZVhM7p/t8aZvKG46obo86UtcCJWW0J6FYtSwcP+2F9s/1JriN?=
 =?us-ascii?Q?ujsXChgw442YMIlGZsHzyVJvPralHXSY272gzoJndQb3lHLOMutkAikbvHR+?=
 =?us-ascii?Q?sk9g7zw6ZJxItQc4Mwk2gk5pslGjBc+Hb2Vg7JQ1buW8uxMZidem40slYpDK?=
 =?us-ascii?Q?tMHAxB5qKm+kWG6lB20QmlXyW+OZXtaqtDvuCWybRdhnFkay7FXg8hO72+Ld?=
 =?us-ascii?Q?zVpWDooweyG9iz4uAGsiCo813NMBGLwk9IISMdMAcSWtnmVwVKiztK/6H37x?=
 =?us-ascii?Q?uX6DGs0VH946mRRLM8pORlHrMKStagWsUPik2zpEfdAqTt6/jerfT0TUYxJp?=
 =?us-ascii?Q?Gv4+Y7ERRH4R7kX2wN9ncWpTT76uzAESS67zLkbneYW+2DRlIM8Dgv7OgZMe?=
 =?us-ascii?Q?HQ/k4Yt5DuFjO2jm/vuMRwse8VucUlhLclUI6RASxf9RUtpdck3a9JJ/gYDX?=
 =?us-ascii?Q?2ynkmbrQgYcgcUuQUrjBepirl308Sybo4yUFMkF5Ynu7Sbi1OHGXHyIM+Hv5?=
 =?us-ascii?Q?/TWEsiFgU8kS6oUKGWtBS8pHBw+6pDvF+RbaZ1S+nAHL4289t9peXH6VGaLD?=
 =?us-ascii?Q?PBC0C6L5wVKd/0oCR0WLdjJR0dKdnVCr5eeUpFYzjvQfKEL99LMFqiVylvMC?=
 =?us-ascii?Q?+qiarxUJTAphf0wbIYmTZaj6LzRVOkUZA0fmu+nmwgX4lgNnSb5G7Uo1dh1m?=
 =?us-ascii?Q?d5XbOVc1UuZK9IsULvCW8Ff0+olmVOACeiGkoDMZbk2NgiHk0XH9MoeeRQjQ?=
 =?us-ascii?Q?3LdH/iBeed6HtnTQuuMmcfQfTaaqMhajJoJDjhPcd75KH2hnNrL8RtrFZg55?=
 =?us-ascii?Q?HlOIcdtkU3M5kg8YrINmKXy9K95FNf+If6cwRYBMgaZkE91PNNk8GanbpY1e?=
 =?us-ascii?Q?xkE9NLoZJfQPWVQy48A1atv1sLJ2YHYXEX2GRv4wcAYKHGOakr08UdQUgYNM?=
 =?us-ascii?Q?fSUGX1fBhIMHh5Vw41TL1G+bwdH8iOGis1jF2qmZHfSGmow9BBxs3ZklpJW0?=
 =?us-ascii?Q?Qe20J5Kb5gDE97nMlZ93NadKKjjbKAQpLFrpRdTB14nWY2SSvssTQ98ZZz2p?=
 =?us-ascii?Q?Rwme5N7LEf17Jj28CLmgTxgNiHPF/19zfzPVq3pCIo3ECZ+Mig28eoKi8VgZ?=
 =?us-ascii?Q?LHqV8WUgvJEHVvzPt4IWlj51jCKRtRlsnKFQsU+7ud8uluCK1w+KSDkDW+IR?=
 =?us-ascii?Q?xnulu2fMcTERdsnkIdbqHE7csfiXeSazP4ce/lMUPJnLWC4t6Q7u6L8cl5Q8?=
 =?us-ascii?Q?X9EsMpdqruJjO230lvyQnxSqaaLiKuwr21UyOyzHvnEmMXvCya2bezanuQwL?=
 =?us-ascii?Q?9dTP2Btz31SyyJqxamFopBncMqE3E/wHTCfyhPk1YJaEepGTQpTYLK9tIRxr?=
 =?us-ascii?Q?uHAUyEEPrr2aruFEkZkLhhsSaYdLD/PY0HdK6QOfdmyDXQoQc7eYwblLMLYK?=
 =?us-ascii?Q?5eBC2cT2MJL4FHZDW0r0dPp7KWmVbG0HUy1U7/I53NYCBh1mxid4F+QTo5nt?=
 =?us-ascii?Q?+KMeei/67EhgrV7+6a61SAB8tRsn5/gtX1tHaqNdDa4yckvQ25ELq0fZtXnG?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ftvuzwMsXS3PLhb2/zXAqo7l2Ubb1jPvZnAiuHxV3sHgg41esSYRMT8PCd96?=
 =?us-ascii?Q?rIIupFV0UTeK5zxp9NSzjZh/dbFavYTYW/P0DZolheQNT+Uzz9h+RyRvHGrn?=
 =?us-ascii?Q?ygK6LRJXPunJjA6nX6nSgy1mMufrC+UdFRyWpGhrwVCInREIsh/bU+NLzRb6?=
 =?us-ascii?Q?Eoef/UHn/zB7Bp6Rl+OkW+7VrlleGResW6ZSa8j3D3d+pCSXntrEBZ9cudyk?=
 =?us-ascii?Q?gkBngb66b4LwYVqckW9NeX25WQdS1DfmFEhV89G7miFP/mumAkGwSKg+NchZ?=
 =?us-ascii?Q?l3GpnSJO0F4mNZ7zXPGCosRbsW0JoEXeMPNGS2oeqLuyPEyYq+4FZTv4t1wS?=
 =?us-ascii?Q?ECAtg5+VHK1k6mLqVG+JWVwm2XCXLa41SYQDE+lGhK3HY8eiQYj0yAy/2fi/?=
 =?us-ascii?Q?r6IMTHEUxLc+xN/et92LXKQLy5gKPZkmYKDkNQ0MOB6megCGM1lTXsLHIlq3?=
 =?us-ascii?Q?lDR8S4yqpSgDzWjYnIWgZ5H86vYi4I6M+akIosADj9T86I3FIKMzIDXfdRoq?=
 =?us-ascii?Q?V34PwTOIXOeYAqSpQn86gBDg5A5VRqIT7tWpoCnNaNeVG/COOHFnXEoB9iBU?=
 =?us-ascii?Q?v98mIaeiEwGTuVYYLK3O4fqfUp+jafFo+LE97EGGPhl/oq2Z0VCBkfIudnKg?=
 =?us-ascii?Q?XDfNuzkkQTrEj2J9j5r355ahMdJuzV4efbrvOIurmb+8rYQLRgARcmptoOB/?=
 =?us-ascii?Q?hWLNz3G4Y5OlF23fBbBG6nWFrEORdamCPeFmBnaMhz40AKl6WkN0To40wYL4?=
 =?us-ascii?Q?s/L/W1IbZx5wKfmQhHJgKSM+qc0GQMlAxNls9FHPGlaSmP75eGSfOuUCJTlK?=
 =?us-ascii?Q?m+4sqpx0xQ5iDhIJAeXsJ33kC8DeFgRjahiRVIQpLFamoc5g/TrfyJKRHhS9?=
 =?us-ascii?Q?CrAepsNC98d7bgav/UXE/62W2YgjVRxBbvXqyr2CLAhOcgQHvDPXaAhS19RX?=
 =?us-ascii?Q?ICmQx6QkjNJ4+WFCZdKYlsc3+UFbJVYiRVGlPQzC8nnTDmLshX1NepifX+Fq?=
 =?us-ascii?Q?RXupVDEMETHiuQuuOhM6FSNxorZr+i3iWviT6hH7B3I/ZgjRd8py3lvFx5Y3?=
 =?us-ascii?Q?GfserPA5dBdoLwxl5SCzJkYIgk126w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f35fef0-a16f-4e08-3721-08db77c2ab5e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 10:30:18.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9XnbolKZtmHx4M3H42DwmSAhUUiqtoS5wnJowYFu2g4Xp0+LhRfOu6pR+nsVQUWmLgWm9MdYjRtYxJdRN4XQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280092
X-Proofpoint-GUID: Iapxjc13p_ydgA7t2gpxNYsOAP6xBEzI
X-Proofpoint-ORIG-GUID: Iapxjc13p_ydgA7t2gpxNYsOAP6xBEzI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function to get the events table associated with a metric table for
struct pmu_sys_events.

We could also use something like:
struct pmu_sys_events *sys = container_of(metrics, struct pmu_sys_events,
						metric_table);

to lookup struct pmu_sys_events, but that relies on the user always passing
a sys events metric struct pointer, so this way is safer, but slower.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tools/perf/pmu-events/empty-pmu-events.c |  6 ++++++
 tools/perf/pmu-events/jevents.py         | 11 +++++++++++
 tools/perf/pmu-events/pmu-events.h       |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index a630c617e879..ae431b6bdf91 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -290,6 +290,12 @@ int pmu_metrics_table_for_each_metric(const struct pmu_metrics_table *table, pmu
 	return 0;
 }
 
+const struct pmu_events_table *
+sys_events_find_events_table(__maybe_unused const struct pmu_metrics_table *metrics)
+{
+	return NULL;
+}
+
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
 {
 	const struct pmu_events_table *table = NULL;
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 80b569b8634b..947e8b1efa26 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -786,6 +786,17 @@ int pmu_metrics_table_for_each_metric(const struct pmu_metrics_table *table,
         return 0;
 }
 
+const struct pmu_events_table *
+sys_events_find_events_table(const struct pmu_metrics_table *metrics)
+{
+	for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
+             tables->name; tables++) {
+		if (&tables->metric_table == metrics)
+			return &tables->event_table;
+	}
+	return NULL;
+}
+
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
 {
         const struct pmu_events_table *table = NULL;
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index caf59f23cd64..a3642c08e39d 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -77,6 +77,9 @@ typedef int (*pmu_metric_iter_fn)(const struct pmu_metric *pm,
 				  const struct pmu_metrics_table *table,
 				  void *data);
 
+const struct pmu_events_table *
+sys_events_find_events_table(const struct pmu_metrics_table *metrics);
+
 int pmu_events_table_for_each_event(const struct pmu_events_table *table, pmu_event_iter_fn fn,
 				    void *data);
 int pmu_metrics_table_for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
-- 
2.35.3

