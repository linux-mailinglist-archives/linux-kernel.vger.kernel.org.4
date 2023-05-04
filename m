Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB236F625D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 02:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjEDAeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 20:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjEDAeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 20:34:23 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4C68A4D;
        Wed,  3 May 2023 17:34:22 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3440VsXf020146;
        Wed, 3 May 2023 17:33:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=9S27XMu59z5fv7LLulR4/WjBTsm8+dY2rloLlT1O68M=;
 b=kb4BroKeKfRSyW0YoyJzZwsW3qPwiCmyHeO/tGa1ZCOL7Fy9jfKOcz609QYGSXgRkOxY
 kTdKyNSKTrFv1Vh4XOovxr/yIh/yvc/+jFbSIii80dxHpc8Y4+S5M5yHg8kHjxCGPq5J
 VRpofg0SHcmRiEBuLzHFyFA2pVf8hiNj2prAGusDcfarXyu7NQ7ja7k5tNRWEeLPWaw2
 qP/HKOgkVCM2X0aMrwSQTlRTjvOBWi3IWNPoPmwyyRIvAklDD/u3MSaKTi5ypWyJ5k/B
 8cDc/61SQ8Yva2fRU3P8aCBQrEfkgifk/N31mclTvUmFuV1MJUPpFjElrOHHYVJxl1DR DA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3q92rnc169-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 17:33:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9RH+KcdnZ/ZJ53p0VrNF2+oMdMWdeGvVYd6Ye0PaHiZRTiYCM4niDz/11jmxxByJC4OwA/xzWa9piHExbOTdJvJ8Xr1hw2pjOJ1XxdJ8wYjDu5wbw1r50v0XI3+g6NSmvXLT5WbiOLUr6DPFiwTj4IRJ4KOnILznee/C/FbKD5nd/DFlhU3oLL1pLWbCEiSnsznO+MGv+WJ+b0o4blEQnFF9oDYZWrdeP78DtHA0CeSTZPyuJt5FLtOqBjAF+tqOcxuRVeUdt6zmsE/Art1A87ADTAeGE7cEoF3mhF9WYHtfCWC6nHusLFQ9X2r1mMOViKSWxASYThqcyn0WfHd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S27XMu59z5fv7LLulR4/WjBTsm8+dY2rloLlT1O68M=;
 b=bn7Utk1BUIb2sanIF9zcmevSrEmRWIIVdnYjZryoFnzkmpibP4zZDoRz0gS7c1SmxJdVEKNS3UO3vnhZTYNkuEJLUvBLyb/YeEcu50OI0lEGXLNfqidAPNsHVHg7CUBUJqu7+XMacpK7i3otJVrjg4CpMSsjOGC6hpPiIo7AuASaTO53jMVNbkXZfalbIqfq0oB+DKFS5cpCoPw0C/Z4uOSiww/jh90qoWrcOja2D9N6eJCeQ2pE380j7KybtA24gvpVUxLk3YQxxkPXm/E4P4YEeQHGlrnZcj3SXwsqZckK5ORL7/5VtkKo/KhygrVuWfuVacAXGVCoOVzu5U7e+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SA1PR11MB6664.namprd11.prod.outlook.com (2603:10b6:806:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 00:33:55 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6485:357:72c7:e45]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6485:357:72c7:e45%7]) with mapi id 15.20.6340.030; Thu, 4 May 2023
 00:33:55 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        ping.bai@nxp.com, kernel@pengutronix.de, linus.walleij@linaro.org,
        shenwei.wang@nxp.com, peng.fan@nxp.com,
        bartosz.golaszewski@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] pinctrl: freescale: Fix a memory out of bounds when num_configs is 1
Date:   Thu,  4 May 2023 08:33:29 +0800
Message-Id: <20230504003330.1075531-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:404:15::24) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SA1PR11MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: fe28980b-e5d1-4682-d637-08db4c373e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QYI92MABkHQOWduMUDlUSlVIDAVFvNP0aat1cLEGH+76ua+rdFbRyT4iu5g8w9tuCGK8wfCdjjJJb6Ms9qSp+pFcTjyxNwkXu8Un2bDf+YUSl4Dg0sm2Ox+yPUOSrbPcWcPoxQYtRZc2NiBfDUa9ttET4RA4M2JR7Baei/ywf3byjhV6SBJCWyI1UqmttLTzT5hyeC+qfB+yy0wpywaJiaADLGXmBstiLbaGREE8mDp/z5iaLZoTi/02xfsEDU2iFd0IOX82s2pBwT1GLNkPRMTmhC6UTxGrhYiC77cABZOV048AyuKaktnCTWtIrdf7rfcvBScrq8mjSFRG3iAKqht8QDXGCzD7DzSZKepnkhifDw/lLDheuQE/tG357KO2An96PqmQX2x9WtvtNTpnBmQwHd8Ty59UtEOIo8Ncs/DpxQy29rddequ/S391RLRISw1PfzT2hicJPdeJgPpSESuVkMjklnc++4HSWfnZCwkRA+qsUs67o/jWmMV/EWqabSCL5jrWjq5AkDO2OJ0UbOgcab6UA9fMlDmo4xz/e9Sj/4O2I/8BVtzRZ52X3S0OKYcYJ/NpDmfPt0FTfW/a3XpgenQn2XC/H62kBOS7cWGAqWRMuKXZUITWa9aJ1ezB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39850400004)(396003)(136003)(346002)(451199021)(6506007)(26005)(1076003)(186003)(6512007)(2616005)(44832011)(2906002)(5660300002)(7416002)(83380400001)(8676002)(8936002)(52116002)(6486002)(6666004)(36756003)(38100700002)(38350700002)(478600001)(558084003)(316002)(66476007)(66556008)(66946007)(86362001)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W8gb0qtSqtksHL52szwj8GLzQpH75sXlIJfb6jLGnXKVrG+/C4/Loik50Vur?=
 =?us-ascii?Q?+MkN8z3sLe9U1iVDyrqA7Jb/lNeC/VeODRjzRDK8K3/RnnZ47JVLNgGggoK6?=
 =?us-ascii?Q?L7/qQtHORRw1VrwqCrYUy2liyou1xidDPnU3qIwVSJkujR4Ld/MPapLEq77f?=
 =?us-ascii?Q?YNV+F0c81m5CcD87w+jFlcL9ScM5hIseceSRb/pb8XlVxyHc4e2N9mQVJa9n?=
 =?us-ascii?Q?xg89F7Cy3XDx1RfYxNIT6IfKL9nhVsIWIdseQADrLmdBeS3PdtXw7RGrgUyJ?=
 =?us-ascii?Q?8/zyFNEBBjTBQxzsDK00aV/OQAcLZuNwIJ/wkQGdRezogZcJf5YqSoEv0Ckp?=
 =?us-ascii?Q?zliN4tc6QqWJAGiqWhJG/IwBKzyDBbYTgXuQ725OPw1OaxJwVPIuwvHmt70P?=
 =?us-ascii?Q?8kr6RA5IgT8M/lJ1nRxJyB5CsGI8qKhCfw6ixDOGK7YKK6eN3TKUfkISDkZF?=
 =?us-ascii?Q?+Kekrm7Iv8CU0Toj81+76RbChEuJ0AtV4zZrylI3JuCvz9/kecCloSSZOAF7?=
 =?us-ascii?Q?+1gdOzIyGrEMymnQ1KTx0h+8AZVXOG31fIZgMXg8zlFvL6wm4dbyaq4TOQRp?=
 =?us-ascii?Q?oYMRfvwveHbM48DBSSTMFnSUxvEisL0PdvtJblZxeKReHLxDoy7y4QqyN3Wy?=
 =?us-ascii?Q?bH4kaJOIFYYsdkIFBaoBX+tKOoJ8c+YGcRoZg/w17coGnwfUb3/TKr7iZ1Yf?=
 =?us-ascii?Q?df7FZWFsPhxZJxqXsxkIQgTJMb7A/C6b3e+fHstMG2qBFTcHmiz3UWIK+u6m?=
 =?us-ascii?Q?JQ/4n8AUC4KvaQWmRQlHUnfhphcj6E3VTxWlUKZUPdGtJaTRE6GFOWIXdIhk?=
 =?us-ascii?Q?tIy6XGDBoNyCtUEOec+g6wzyaaoiafJGnEhHx51spp2OuGhIQOMBfdvVonxq?=
 =?us-ascii?Q?IxEQhyE5qxebXFliQxSUJNLIyGpSSr7uaeDEUdme2a6fBOFUEdX7F0pam8g5?=
 =?us-ascii?Q?34LQOFRxFpLUbjVIIs9dayh1C4+C6CV/rGeIwCcOYRX2U7rdpioPl+gGr66b?=
 =?us-ascii?Q?6jjo2w6RvkW0YQM6USgn546zCyaZLoWDFkihQ65pUOLEVrQDljRTvgV9NEDt?=
 =?us-ascii?Q?Ke7RocOHYjphprEtey3Km/toTccZpCPM0i3GxNOXm84hJQtUeXQa2UuGVDDj?=
 =?us-ascii?Q?YPzbeEimRFKpUYw/VG/9LfZk4yKQeakaoeKTCLuMfE3u67UgyJaZ+uptEpKy?=
 =?us-ascii?Q?27Db81pS0+GYxpUUI5r0a+5KnILOOoKq59O/y0E34klm+GyXz/dtSMQLLYXp?=
 =?us-ascii?Q?17N79i2orW/kn0x0WVveeZLlZg3GxDV4AJJCjBR8TL5vs2VAfRDAFFkS7P4E?=
 =?us-ascii?Q?K1zYIBO+WS6+uA9VhjRjLkIDVyqLM8gFvYUpQAS+vdzCV+5+MAsQL07lhijJ?=
 =?us-ascii?Q?GdxaJ+o5cR1/h2xbF+IerMUko4EGGrgrvzSgu2GJqjstFH13tgHbTeVL2FtP?=
 =?us-ascii?Q?08E8onJ/VfdT3aMUnda/FFpNIEp4yE3RoXZhp9nHFteSBY3tCKyW27HWwm4j?=
 =?us-ascii?Q?h19t+r/mjTiuMyTbz+brUFEpCKtCDEffuYGX4EOxnYYs0kRs0zLrYU1HwTpK?=
 =?us-ascii?Q?8UJiKqb9nk3xDjlhcHZAsM5oTf+DE9mi9OqAc6BVmiWTyc0XlLOoavcMJhBT?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe28980b-e5d1-4682-d637-08db4c373e00
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 00:33:55.3374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/ZhCXINNuZ553ZaoYvgnG2qqarvZIhsU4+ygSW/enVutwc0xLemMFiJuG10RcAQU1Ke9WTao5gFp9UbakhLjPugHucnUb5nx9j6GvMoyFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6664
X-Proofpoint-ORIG-GUID: T_k-v_4EMoOL-ix32N2zy23H9iA4ZfQ5
X-Proofpoint-GUID: T_k-v_4EMoOL-ix32N2zy23H9iA4ZfQ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_16,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxlogscore=508 adultscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040002
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compared with v2, v3 simplifies the call trace log and only keeps the real
problem part.

Xiaolei Wang (1):
  pinctrl: freescale: Fix a memory out of bounds when num_configs is 1

 drivers/pinctrl/freescale/pinctrl-scu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.25.1

