Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C13740EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjF1KeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:34:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12538 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231444AbjF1KbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:31:14 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S8xh4R015057;
        Wed, 28 Jun 2023 10:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=PEVT2ccVAFCMYWm0TDtQk9WFjV/CqEY2pr7Ru3lw+PQ=;
 b=35GP3eVVztIBnkSU63DGnSSjC2TWZ+B+67L/VzpGjbCLnt5v9ADWvyAJ2obU2C7dcK5u
 tswvF+kQ3MdOGrhH97RyclIHheFH/IUtUw7xTY6sVp/02UVyj9Euek8rrvpkkRBiKfQM
 FTIJssE806itUtZgZMNCPrZl7ORtPtpHB7rW0dWsPJjIvicBDzD9XG3Omfc6qr8hMW+/
 hfu9Fx8/Y5I5YEuOO1ESN+oT13bZldYgMiKjSi0c5a8jUnR6y1KPqt20oUsCq7N5P3tw
 IQGCGMe9q/kORHFBfLCskdtC1tk5gVWUKPtghoQYFNIzSJBeaO95otCgw3/OuXVswfwc 9g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1u73hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35S99Hlm008566;
        Wed, 28 Jun 2023 10:30:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx5trjr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:30:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/xvAVuXu+V53JcZOmNln42gyKBziev+KikGaFRthd/owqArn2smcfYeVNMolazBB42wEFSDDhsRsf9ONWpjm2/lgVbOhYx5CyfpE4ruMh1aQAWwiZtU48n2KVQO3ONkNtxK98HpcWvF5AZLBcJMp2NScXevXe9vplUVIbKimrda1Sxk1AOQ1zPCok3dAo8pg0XU7Oym+JZVO4e6Qewa12N2nT2uE6AK7eSYQi1nh5uMsj6wnxO0l9/YAN4uE81iJdfYgYhyHCc9iASwHHUjKOf1NPkYCZvcy6Eo+AooMG4vGAzgn+d6iGlpw4U72IyUaj9GNGqaYhSLuyHvTGW+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEVT2ccVAFCMYWm0TDtQk9WFjV/CqEY2pr7Ru3lw+PQ=;
 b=PHUQIWJO6IrCNQt4/1dh0PacPVb9Hb1kZdI9jcMBzU+UrvmQYoCkKj4vR69Wqu6bJVftYan/wGfJWFMsTxIB01ru+PtkqNtA+Ywy8zk1WzQVHjYb2hwlrSJh+CMcrhJFbc+ocz3qK3hx05DNyj2s69e2mI7+KnX1ty7jY4UCS3mHTc0qOq3lUp0y7NBpaJlInVaPk82dgEukrmtcNDI6m7Q6vhLx9s1o5M9/c3tZq1SCZI/710JPCcpzU+3yqOKieSomAcP2LQ/v6zlNjt+5CwZeUe8sgvnuDwakoqn5+ilEXbOb2OxmBEzSfAXsqwTxSNQtTqhmx5M9/wDxWiqhkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEVT2ccVAFCMYWm0TDtQk9WFjV/CqEY2pr7Ru3lw+PQ=;
 b=OGajmE5oE0CtfKOxdlcH3KTd3mQxOGStLDn3eEBqx3qCJssOM0PrZRLHIG5aK9MyXODeL1B+yyB/ehV4hNfZ2R71iYCZLbwXKyZYIouWrqDxxePz+f96HrgPpej153fG32nwZfBlHaJIRFGvDG6BYTHtDiDpnmyJ1gV+N9unXA4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 10:30:25 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 10:30:25 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     acme@kernel.org, irogers@google.com, namhyung@kernel.org,
        jolsa@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 8/9] perf metrics: Stop metricgroup__add_metric_sys_event_iter if already matched
Date:   Wed, 28 Jun 2023 10:29:48 +0000
Message-Id: <20230628102949.2598096-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628102949.2598096-1-john.g.garry@oracle.com>
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:806:f2::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5bf042-b36b-4087-71e8-08db77c2af98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsOgcAAZZ5EiAc+AuA5IDCO2GGx4UTWs455sQqFgAVh4ojBfHdA3qYIkO+4p8Git05Z8a9Ldcw5qoWRG7FZ+eQ/YfCcUfK6bj1wK4BjaJ1jsKTLoj89Do+Ix1AORGMzOA+Eut1m5U/H4R7I2laZP4coIg4NLYiZa3IdpBhBVbPGje+1P8v6MxW9JhfTZbSi7oRCSXiiAGI4QHXnzECtfe7PB45fr8ITGoXXOClBqsOR0JtXV0UWxYhqqD0hUAtyuxWzyeUvsyLguDGeSSSMp6v/uoqHZgoSCiYxEbPQkG8RDVZiMQBE2FNyH+tjoKhqjKyTTPGKLwT4I5hUf24B/TQ1hf2pLST0AEJ1uDDqDV3bFNGe49A5Ajt72h3ir7uqrex7wAql8EL9vUsVcaUGm5D9UDKI7AQqs/6j7xp4SkMp4CO3Jk5dGtu0upiZPe5F36bZrniYRoO2303jroHZ9qQRr7/qkZFh0vAPmtEogHi0g8LT0OJNdcbiU5H/j4qbHPCzswLE2yOpdei379fU+B0e0LzEMt8AMXXbVyJE0zRBz1vKI3QWurWXo7yLfv1lXGCOOnO7vn7Sm43zmd9p3XfO9cRjpYkhuPsH8binnfHgygQfv1Uhe6OaoAp1N2IFe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(38100700002)(83380400001)(103116003)(36756003)(86362001)(478600001)(6666004)(6486002)(2616005)(8936002)(316002)(66946007)(8676002)(41300700001)(66556008)(4326008)(66476007)(107886003)(1076003)(6512007)(6506007)(26005)(186003)(7416002)(5660300002)(2906002)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KDjkATjDLnngiCZNhsunJJKxDzkcA2zdtEf3aCaQs0k/yN4Z+V0xoY/eac8t?=
 =?us-ascii?Q?2848kg32UCvLscteazkJrkH2o7NUztKFP1C1Av/cN+UiiFlE8GgBBLh77ydh?=
 =?us-ascii?Q?60UlTf2PoGB9Lp+lrZTr8OSEsboZx6S/1CpZi+5PYyio5jrP4RUlnWHUGeEo?=
 =?us-ascii?Q?gkzbG1nYkmQSc4zUZ2NSfocn22+1qXzw9mFA34yH15BiYi7uzZojhHeaO5da?=
 =?us-ascii?Q?mKQ15mpUgL9+ksQIsyWlDdtrXUdYQPxPdnX74+6miS6go3S3y7m+6nL8DvyA?=
 =?us-ascii?Q?Ro6ChZJn43BE6llB9rO4tQGVTF2/BkUWvLSfmDq9Y7DhwefddsYgNx9tyI9c?=
 =?us-ascii?Q?U/6TdNfRh2G1fe/xAh+g9G/2wz8hV5Vp40jC1NWov919ybgw+FuDXL75+AUj?=
 =?us-ascii?Q?LdLarI5MysADjP8Jn/l3B2dw6X5ZMmYaaCxEm/6pfDW+LGbgOnlEtg1ZXtgb?=
 =?us-ascii?Q?GRwvRablWfQkYjVCflRqek66UzPhAHdW0xVH4cEIo5WnCglePgxEVtTraDj8?=
 =?us-ascii?Q?46/0vRyJXx9eKprI8mj1Yn6OfKRnvXiBn/oHuyTfVE9lAhH3Thb90ySjfuDK?=
 =?us-ascii?Q?otVZYHMGuoPxPcAiGtDsIFXm3w0N/kv/da3hOYvtdfoS+g3sdvKV9KQPR9VI?=
 =?us-ascii?Q?26M3aTMvnfL5v2qONzKKDZcP7FbhjNzgInWJsz/yqeFzopwWXsgHxLOn5OUt?=
 =?us-ascii?Q?kpEuks64h9MkifJkP/QqI6aL6iUAF4Q7LXy1eCuJg5ARg8X7N10eD0kYbmcX?=
 =?us-ascii?Q?DvNoi91wV3bqNGjZT1z4qnPIiCrAS1KUFLcNaMhUMOovdP9WkO3i3pQGtxAM?=
 =?us-ascii?Q?fCj5H3JfoMkeX9D0jn3ZgJ6ANa99RHhLV7UdoC/dEHz604TdW5x7ZfL81yoS?=
 =?us-ascii?Q?OTRuW1L0F+tPqBWqhZhv+nQPDhntWoASIHwq6eXmOXqEjqWSSs2krgSfCBQy?=
 =?us-ascii?Q?k+/InqPG0bLB438uoSAmm+ZD9T7Iv08AZaeuvwUGj9+WeKwN278/Gfi3j52O?=
 =?us-ascii?Q?rv4A/2KLYLbuzf/4/G7pGhnEOy85x7JSTRk9vM6h2nogZtPLSIycbScglu4e?=
 =?us-ascii?Q?XrugW7VVuP1BMPv8YypKRlPARv1WNpY+yaQ1hZ6JtQ44Ss80JjXYrq88IJ4H?=
 =?us-ascii?Q?tHdBXvPfjVuC9WxL+ocMFLmeZLqEWVmLYJL3o2Ocvq25L3IhG4yCn59h0Ym+?=
 =?us-ascii?Q?ExvRKLQDXil4XLHQWeMVvaj0fHIQj3ygb/5wys78lhB1dEwh+T52PRV+TX7Q?=
 =?us-ascii?Q?810dLoew7J28NFbTDVOBCZ0k5fJ5/LcWopHt1ZfxDpzp2Axn59repuvmA0+Q?=
 =?us-ascii?Q?eh9I/hnu7OcRBRY5ZZyt7S34EIsEm7GL/mxMAvZCppQ1C2nMj7MAJMNZ6qYR?=
 =?us-ascii?Q?/a/7bXX1OKqcefs7vC46VIcVJ1JWiLvStdoeMWN8PE2PArYzy+HQSd/0Q5Ad?=
 =?us-ascii?Q?fExRKYS/LAVET2YJut0ovK73SJ79fS81dFGAqntc8umiu7zWVfRO7L5Agw8d?=
 =?us-ascii?Q?JMNiYeRTlFEONRBP1YB+mIWRXsWMdqoy0yKuBToPEGe2giduNM1wdJ/l3Arr?=
 =?us-ascii?Q?8ljg2bjvzIJA9sdawMCs3AHuf7eqS/cI1bBS8TlxheCRsXRodjVH4SmKBt7D?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Mv3lIBUROr02u7Q9q/9nf1pfPa1KJhYoVe46WZ/vv8wpw8LpvKUecYUKV+Hu?=
 =?us-ascii?Q?zeM5PJF48Dag2bW7obMVDitEGd0EuTJ+W25Mc8VbYEuCK26U+Ex/JRcHxyI5?=
 =?us-ascii?Q?gJ8LiIpw6Kh9YXmm9FCqRJQvZ1o20KqFTSrRsx7doxyZ9y+D4i5lSbkXayJF?=
 =?us-ascii?Q?cZB/noXKkHwaWhv+PMLiNBl3dPc6CN/CCfmfQ2AjQda7d1sp7PjZQtCGN/zv?=
 =?us-ascii?Q?oSdRNXw6GoYSo2QiDfDqgZzEYI3lSRgp05BVN0y/C3pLakhPk8TL00F6awDE?=
 =?us-ascii?Q?LX23L4d+DBBqtQspZe9BrZyOKIhw+oRwdUsFz2cJZtfb43lhmWk1hp015sb9?=
 =?us-ascii?Q?tT5p5II2fku7dMKQOwJwFUw44rSLNW2MpZboKGTxy5O02iR5hlYe9ZqEiVf8?=
 =?us-ascii?Q?YjIKh59DqN1I4w2H36q0/3/SxIxSacvkr7Puv2tV2v4jjxzsJsLV+pAD7JhD?=
 =?us-ascii?Q?K0smKL7/9CXdRr6p1mzzcbdmdPHnoohzsayi7rsq55AdG4jasdYJvIg6Y/bV?=
 =?us-ascii?Q?vwLzWwAj3XUWvkNuYgENbOMlKO+YfFGeX7t7zkV819nNcD4Go/36CGMfobYM?=
 =?us-ascii?Q?iXq/b88OUdkAm4lBNz0VIy1jKvIy9pAE8PEnP4d9uwsIVAekSSS1p+NfhARF?=
 =?us-ascii?Q?mSznjwvjDyU8ReDPYxWModh8iav0W0ctf+5jLxKBTiaGtQu9uYWAZyjDC4rx?=
 =?us-ascii?Q?FJFv5b8XjgwaxZ5Txfokc6nDhRbhww0eZb0XvBDsstxc3NcJprELawe8QC0Y?=
 =?us-ascii?Q?S8tBXSfMC3WhxB2OEdI7TUFEYFRW3kwD3SPhfyxRUOnHGpQzqPMJV9h6pQlh?=
 =?us-ascii?Q?hkjp0i9P0qRLqT/Z1+5mYE1szOrqHE+lXxrm8tD48vJDJuOlEZ3OkaA6qZKp?=
 =?us-ascii?Q?tz6SIcQMTQb33cK8N620BvDZVrb1bO3o5xH11eL5vHMd4n/rM8f1FFRwL/Mm?=
 =?us-ascii?Q?2h7IylD5Emlfke2pTikjGtihri2UF5ytHkG5bjTcFB/KWr9hIc8GXicWyOP1?=
 =?us-ascii?Q?nuyCYw06S9D/bwcZcdsyrEy/6q+b+Z0k/FhCgzadubPw6zXgsHDcCtInC5Qe?=
 =?us-ascii?Q?p/S5jf4Fp1lwkqQlwuDLTVr1ZP59Zw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5bf042-b36b-4087-71e8-08db77c2af98
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 10:30:25.7416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KF94Hx0OlX+V8qkGSqnZXoxh0kt/zHusGTnSCWtsiy5MYa3sutFvtp4Xf3YoG9d+aGW2nZevc6LxbYZ0jbsADw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280092
X-Proofpoint-GUID: sV_MZ5DQjufshANt_ayECoJEMxGxIdbL
X-Proofpoint-ORIG-GUID: sV_MZ5DQjufshANt_ayECoJEMxGxIdbL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions like pmu_for_each_sys_event() may be inefficient, as we only
stop itering for an error. Often when itering, we may want to stop early
as we already found what we're looking for.

Return 1 in metricgroup__add_metric_sys_event_iter() when we want to stop.
Nobody checks the error code from callers anyway - those are
pmu_metrics_table_for_each_metric() ->
metricgroup__add_metric_sys_event_iter() and pmu_for_each_sys_metric() ->
metricgroup__sys_event_iter() -> metricgroup__add_metric_sys_event_iter().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tools/perf/util/metricgroup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 111ad4e3eb6b..c045b111db84 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1130,7 +1130,12 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_metric *pm,
 
 out:
 	*(d->ret) = ret;
-	return ret;
+	/*
+	 * Return 1 as we don't want to iter any more, as either:
+	 * a. We found a match
+	 * b. We tried to add a metric, which errored
+	 */
+	return 1;
 }
 
 /**
-- 
2.35.3

