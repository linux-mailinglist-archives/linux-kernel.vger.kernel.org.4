Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1D46A8B4B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 22:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCBVTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 16:19:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12438 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229590AbjCBVT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 16:19:29 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K6cEX009081;
        Thu, 2 Mar 2023 21:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=sI7DYIdC+I/K4ZAJPT55pIqfCnLSNIYT03eqCeN6yHE=;
 b=w8xu1y2cPKGWcWwQN2Y95hhtVAhBPVXcGn0MPCIx7q0g94uWv6UaJbXm8r48XY7TS9+m
 c7hPxeFUCa6Oj1MskWrd+3f3HdH24LponAXmamihtRmfHkfe3fExvXbfHcXQLNYNFE35
 zSNh1JMfiatg165E37TjXHRfqQ/K+G/v9iKT2K28vezNcSkHrsA2FkzrehjW66eHO3BM
 M6APUplE5gsS7EKz/P6mR0S38RRlj90gjl5DdFS1J3PV+jaC+v7WnVgiRFnim8zJWRy7
 1TF/CYbgfqhd8hLgbYGnNySMPgVSnrwuVSzxdMik+/RBcJDlAVDpuXlZB25zCrZf4BOa Pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9an087-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:19:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322KgJ7l034891;
        Thu, 2 Mar 2023 21:19:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sgqpa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:19:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6wpel1oBFvlKEV5VxXK8spu/tORGlslZM6p1pKWWfAsP5M5jWeZWMjXW3tvn9AJiv869d9CwvxwRGGKJ+nOUiO7MTrAZ/NQH/pj1YsxHy1MM0rDjWKdNVcY2bz7N8cL/i6KGaPYUbWnIzmBF8PR87dWlwfqQa3hHuYEQsbn2OE5iojDp2pZbrjQbZGeGywQ7kCiyLkALnGFBG9dZMdT7/PwDrs8vPbPKCOMKkNokG+rKYNOluTR8rIIerKwLl2TBBIMa8Q/9jV6V4MhWBy0LdFipmfxNoeSW8nP194Ng2hcQw0LW76KMa6uYVaer7aVdbnbdbhS7wbD99n37Hystg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sI7DYIdC+I/K4ZAJPT55pIqfCnLSNIYT03eqCeN6yHE=;
 b=NuGC3dYjDoqVWDQDVP32PReVCpSLOe4l06tL0sBQ+CATduSsdErO6AITKfYx1/Q3PCT5NNi5UtI7Kjwvl0E35KDR5kUUr60Rheypx7AitXCLfxOaCJP2BtoHwvwBVo5KXKp+YHOReo9GW4jFHG01k6MBCpE+ZEGR1kp/ZMylx2+3fdwYvRSJ/PHqY9F6BHoXEsPb6xJMRlZhVt+E/ghKWQvmbqlS0Lr0FhI3Msn9ndhlls7yZarELanmnhuQMyQdL8OvvCS2K/AcegqJVayP6F0MLZ+3ewwBFx5huYRTKLoAg6B59cCHLqFcFZ2BdYkd3eq86UFpJY4BTnSw29wt/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI7DYIdC+I/K4ZAJPT55pIqfCnLSNIYT03eqCeN6yHE=;
 b=a7A+8G4C6sysqOpgGm4qZFvUbaOY4EobMRnLQVf6c/HVpdw8F8pHo+Ef14W9MDERw6VrSRx93plK+oGZPiJS9/+ewbNk0l3RKIHyT61uIl97mXGSVg2Zh/+96879Itrx9Kybc/7SeM9y85A/lIogCkGn7knZ8gM2Ko21e2MiQpQ=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 21:19:12 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 21:19:12 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 13/17] regulator: stm32-pwr: remove MODULE_LICENSE in non-modules
Date:   Thu,  2 Mar 2023 21:17:55 +0000
Message-Id: <20230302211759.30135-14-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230302211759.30135-1-nick.alcock@oracle.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0037.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::25) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f92367-daab-4ea3-155f-08db1b63c4fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpyE3k11D3g9+zJhactB0DX86/Qqf4eWlE3gmDX2Ny6S2yjgPzvBrvgnV78M+c0QUQxUDyRTnJn/xlQ1vHSqf8tosM6HqcVnApOGStJZrGh1yv1+vJ1fORaVExT3v7LX0b0z99u5WDRo//GH+3b7F5uRnq8d4SFZDOI5oCuRyIwbg5yiZdn9HkU/w9Pa1eOUdZaZyQ2S+XRswbVS8Fgmra3h52AsGxyD6+FGiEr06o18rXZlhgEelb4nP/nycRA1Ya283jGjpDnWol7q6UJPDcj6KYOJOM+URYyqJwmCzHcu84XcPamiw3KxdM4JudtXEvDOmY7T0tx5uqS1vJrMZmBVhrnxANwXj0HLT6r87LVgDlAJKyfbtq28Nl237V1hUG3E5+RvwGBuC/3UI2ojOWpXph4SSUYsQR3rW0QZXAV7pfj6JPFz+QDQBnbqHVKPDGd9jMUKW5sIpxH1/dQ5OL0uLhrz4y5Ekhp8w7RdNy+VednKZConcyAnmv6FlaANHwdKkZr22vGtj5S/FJRKBinkY1oszyZfXTroxezJHdqIsyL283kasXvqqm56Q2YR3IdwIre2M46tGYaI3UsfMrcCePcCxamnzWeo8Vb/bJCmXfgK+hSM0uph7KKd1Oi3ZemUW6ZlW5u14VsPmB0K8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199018)(5660300002)(44832011)(83380400001)(41300700001)(6916009)(4326008)(8676002)(7416002)(8936002)(66476007)(66556008)(66946007)(54906003)(316002)(38100700002)(36756003)(2906002)(6486002)(478600001)(86362001)(6506007)(186003)(6512007)(6666004)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yvEATz8MA6LrsF7KgNQIZPRoEOAfRVuGY7BexEXnghn3zEOFdHs8VdgOQRte?=
 =?us-ascii?Q?v7+QFLyTdvzKwS3GDclE3dRN+x44abvXE80WxaltWgg7d01s2sd5rXywMNeE?=
 =?us-ascii?Q?eVq70EeD1orpe4+81XDZngfnYX8sKwbmq+SsflQbc2Exj4Mgms/6faQ4Z7gJ?=
 =?us-ascii?Q?QjskDlZUllLIky0tW/oF/7DHYxnlsxKBMNKnGkrHDaILJiVBLvZDeWRtZIvM?=
 =?us-ascii?Q?mgkrP6KwX+E+Eu6ucSl8sRbpC8A2Nw4KIaD6iYZPI4SiD03nhpqVUbE5nIxA?=
 =?us-ascii?Q?7jQl2OlwmV+SLH5FulCGORsmTn/U9Jvk6jq6T0hFQ1XzvvXN5tjMvmITSIB1?=
 =?us-ascii?Q?KIgeVszRG5f5m3DAgWnGH5VC61/i8v4l0w/WZXuLanA84jn58ubVdTQ9Ll47?=
 =?us-ascii?Q?m7M3v/khymfwZO2+wDJJXBJ4u9s2m5/D/5pzNp3nWK/woGxN/sKXfJERnwuq?=
 =?us-ascii?Q?KNxHBeEKRyCdaAAUOi4603gaE5LCn+EdHa+7eNS7q+ftS/iah5hI/8WJKZ0Y?=
 =?us-ascii?Q?uqe0sUlY260a4ft8vUgPUwgeUqVVcYx4sCCUGOX3Dk+sBIFnTU58DuE9iBNY?=
 =?us-ascii?Q?OFG0NuSjPxrviIeuRBRtW1X/i3bmZEheEeOjhZvJfFEuxQ0hZ0LCp8H8YnAM?=
 =?us-ascii?Q?H/gXYF+P0FqJZC0rVOSa66DwibszywpwbF/chfwe2dh3o6HryyrcbvU39Gg5?=
 =?us-ascii?Q?NI1ix1+/qOr+TZ8QS8BMsE71P9o5e+T9bqweMQ8aN+m6KGDCXU1e1yah6gt5?=
 =?us-ascii?Q?6wJjdnMQXqQfRsbUnXNiIJ/Hkforu6A2ovZ0XznJ6dh0bVIsTGKNnpgGL9b6?=
 =?us-ascii?Q?ElVMJXlLNN3mXUaMKr14SK/EJRbmtnfnXhamgxaIlXynT44cGuT9xUjoV/rY?=
 =?us-ascii?Q?J53R1RVLBjyFLpvFIaYRLuNF4MxmjTvWra5z8I1SaAdRLf3fypzVN0tG92Uy?=
 =?us-ascii?Q?/br1RlE+EObLx0qdZWf3YNmTvIKMUwFISqWKZv4X14aCSe61L4CDC13/Gwc1?=
 =?us-ascii?Q?P9E+N0X+mA3lYaq3CTgmZ83BIorZeymoodjG1/7fsLRUA1ymstEyeJaLika5?=
 =?us-ascii?Q?VTt6KLRbu4pEUbMvvPUSQlMQGFi9is6ufr1IqQjME+Z4vJLVew1ZU3hHVh1C?=
 =?us-ascii?Q?n/A4P17+Wvp+u8Np8uodBqtpB+vCtr6EBQx6HaNrTwdYog+wDXq61aTcTl6z?=
 =?us-ascii?Q?9o4mSrb0wcDk4PHtY4NZcuhkHrNsq3dnjl/OsWHzJ+cpjsJ7HlYmidb7V7fB?=
 =?us-ascii?Q?l+i3MRAMYLBuP9qemFxIhIuJl3p7Mx9QyepccREGijlLY8UnargR90G9jXw+?=
 =?us-ascii?Q?eK3ceKQBkmRiGXfpWVlGPqugXsKpsLZH8X8OPZeEPzsTBW32m1ukNxL8DrrZ?=
 =?us-ascii?Q?cQtK6d2gDD+wv9YlF4RbUrFFf+cMVHq5DovDmt8pJ5XWuY2/n/5/awiorNeP?=
 =?us-ascii?Q?fq0EeWDsz29hwz0r/Bz/HKcauhg98ngaAjCws4i4+nJe8jByV/SnwCmOm9Bn?=
 =?us-ascii?Q?fpxFCTiqL75xRBnvatog5g0HPrTGNNkC7nyZXVJwgh9/xO4JFedzuPwdIFbX?=
 =?us-ascii?Q?+32sYS3huM1nYGJw8J9evQf/COENw5hj2uzhXsj+wmMb+usyUDvwkXaWVns9?=
 =?us-ascii?Q?7wItLi8sODvKxh/fiZHCz2k=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DkZdcvfB+lXD5OlAioEb8a/1WAJxln37ZqUYlyifX3EtA2zHZKV1hj9cgX0z?=
 =?us-ascii?Q?1i5e2ebj3GkaDIEq8TUFRPXB4e1ujYp7jaxHRsnY6jB8UZUE7pWJQ4OpUGpA?=
 =?us-ascii?Q?JrKEnAZkMkv9wIF57lY9gjgM/XLc+vTT606muwnDjkm7/idqhbM2LJsChaXY?=
 =?us-ascii?Q?J6L2N7bL9GXHtI98FQN1oLfmympzKj3WnJqiiipCWWPDiuh/DkIoWDRkinnF?=
 =?us-ascii?Q?fzqlncokoHxEhjdFgyXNW4zRJwTYKfHsDNOmufaTQGNZlMto2mBRhsktAbak?=
 =?us-ascii?Q?2pEHUsp31Eg9eL6HIYHv7iEy298wBBkzy+tAudXRS0xQPeNfoAriFJ6iqeBt?=
 =?us-ascii?Q?+l+wqp6eO+7OuLghDq3kWILDxAcqHDsyNIBErgVsMShrNM2TyDOaxtiQM8W0?=
 =?us-ascii?Q?WQOUHZmdo15ttZNXifVsqwSx44WTyOOqy23AXwhgt/w8k7oPA1gHjZmxbK3q?=
 =?us-ascii?Q?5LjePcEmTUI/GeRKO9e3WS7uFhNav/E1KYyAIMZwVQDNpYFUyFAR3xKrUrNF?=
 =?us-ascii?Q?PyiTJFCypB4qJmkqjO2OgXLQL/xc8ODPONzzwpoYG4d2/4cgk8ayAKqTJjt0?=
 =?us-ascii?Q?oOoD9oyK5iLZYD/rWu/DEZgvpdCgwyFWZmKZYWk86RvolLXcbOmPDBvcbZbv?=
 =?us-ascii?Q?09sCNh3w2cjj08vaOuNGxrTMguC1cYv5v8FLKUc7G8yHTt4LswKOqLk+gAh8?=
 =?us-ascii?Q?Hsu92TqoxJFVY7wF0Uq24lsX0BL2prdBrw1EF52TAsIYCgjKURO38W/cRy5V?=
 =?us-ascii?Q?/eGQV62lu9sry8W27LDugmnc0l/MYzSO5JPoKEOvhkHua9p5SNng7RtOHoUe?=
 =?us-ascii?Q?gEu56zxA42660THhKatLqgGtAYWIDOPbc8COPHJljcPvQ5JDivwq6WZAW+fm?=
 =?us-ascii?Q?67gLS658cleYPKE3PXyCvgzX3RtJpLK+V/YQ4vJ5jq+nSQmzcTYfZg+J9Wa6?=
 =?us-ascii?Q?m0cm6++3DBCMs+ElBul9C0HdOuAbt+xuJkZLusPyD4ZFNBrLndyI+pn0fUf4?=
 =?us-ascii?Q?huQD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f92367-daab-4ea3-155f-08db1b63c4fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:19:12.4652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOrSBGlAdaGTeVyhQew62lGRUAo09EcY01fJaiu6Y38w3ipHZUoQOd1u88R5Q2ck9TjUTR3W7JR5tETuMjmOSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020183
X-Proofpoint-GUID: ayyJVAfDYZuAsWO4ij7iCSWAenmD7Ddq
X-Proofpoint-ORIG-GUID: ayyJVAfDYZuAsWO4ij7iCSWAenmD7Ddq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/regulator/stm32-pwr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index 2a42acb7c24e9..8711afd60ade6 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -183,4 +183,3 @@ module_platform_driver(stm32_pwr_driver);
 
 MODULE_DESCRIPTION("STM32MP1 PWR voltage regulator driver");
 MODULE_AUTHOR("Pascal Paillet <p.paillet@st.com>");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

