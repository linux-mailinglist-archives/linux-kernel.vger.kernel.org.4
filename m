Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CED741861
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjF1SyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:54:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59562 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232083AbjF1Sxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:53:32 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SGwmNu015120;
        Wed, 28 Jun 2023 18:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=1AI310AMhd0IdM3xiZge4qIo9m4z1ICMWvSYkaZrUsY=;
 b=DGdC7TMUPrhmEgebC/LTxItizVrqdkLRTkMcUljIdJE77ZOLX7DuRhWDWlk9DNMVZLax
 DelN8EgswOsegTIjtqFsXI3Q3+pAWK8+G+p4xU8peJ4MyNbSolttWdgGcLA8pNXohhE0
 RDmJ+3fbrpRlSTsNNqr0E4/rg/Cef4+/0DHMTW3NJOL2Yr8QjhKHsuavmvPESIUetMM1
 LrV2hxrT78EcFyzsrgEEwrvuSQCnADpwUIESNbKh0xJmbBOZcM+0a+3pPsq9aUON4ZKy
 Pox2XUA/rxQGiR1HwLbeHuh1dkDJNw/KeezJ1Ir/J5eWy755sV9J/lBRhFj1em/BahzA hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdtrjm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SHe4Kc004035;
        Wed, 28 Jun 2023 18:52:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxce4mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkjRJ8JjxJ533L7JIEO9cQia8RlK8JhAQHJE5Uf5EmAGUXMej8TS3E3IlyrU6zKkg14zPO6tT5wHnob3xLJo5o1JsJZr0lS6PpF/pQ5wHepDSmotC7uaeOfknouC1dxJc+PumtxufxcQdautdyuK/vs0I9FWazsvsyigjHOA+B/rZaE7fAQVDZz6J8IQLGdoVfJMjWjqr453FngCXY9j2n5S0kavT3yZaMYqm0zHVTSh+Rcn/jnUOFcfEgVcfBRDWYRqud67/4PwQUoZGx1J/XCldt9gN/A1ZP9aswZ9hNyF7qkxxPvbmrmShQLXnzpXcu6TLQyTfRaKtf3GoTszwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AI310AMhd0IdM3xiZge4qIo9m4z1ICMWvSYkaZrUsY=;
 b=c/P4W9sYN0Dvpx44hOwAn5JdCFa/H77RFelxk4d+6u3mSZcL3m548op9a5n/ZiAvrS0IgX8/65WlEmROZIO1Um8fhtkNOmcV/NS7giMtG0h45YAsqGnN3zbWE1ogxG7OGfUpHA15UWRQp1iZnevndEiyxt1aAerXuwyXmWzymsaZinqEdZDlo2807n6Xo2SOdZWmZcf2YjYJuIO4aeKdWc+sdaOHJKQYatpVXDTB3ZyVf4UlPaHk+nhWDVpOFBlbi/zPApgZaI/foL4kO+l2++v5GpN4N7Wtf9Oxw1lsjbA6fSAPlHO63bPiHZcAyO60ldUdy6bB0oxoiT7h4lrKuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AI310AMhd0IdM3xiZge4qIo9m4z1ICMWvSYkaZrUsY=;
 b=invF1UdIvfNx9tMeJsTpIUX1iPTUwJXUuefdY6g9RROYSVjqtd+5Yr5ZFtmBR4jvR/6txLJuu3hx4rI/CsFAqgpSv88AdwtA0G+daOgs4fbgkMJ48Kif6BybOLG5Ezk9/QNUMF3IhecT4VmBaU6/sYMcpfCfX4jFlW8nIWf5KWU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by LV3PR10MB7820.namprd10.prod.outlook.com (2603:10b6:408:1b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 18:52:25 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 18:52:25 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v24 00/10] crash: Kernel handling of CPU and memory hot un/plug
Date:   Wed, 28 Jun 2023 14:52:05 -0400
Message-Id: <20230628185215.40707-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0068.namprd16.prod.outlook.com
 (2603:10b6:805:ca::45) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|LV3PR10MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd3f07f-f986-418b-6314-08db7808d035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vL+Xk52VTAi5es4g1JXNwgJkBXyxUcc9MmeydBqesIG5FX+YzAhT/Echjyie/Uiv9oUZc+BMSNvaR/Kk/G9n3Ayn40pvNUMj2uRIbAev/3f6z5EjaJhcmyteSgZABoq2ehWhjUVz23KitjHc98tSwy84LLPCefczOpfGVRwN3czfaC9M8uFJzvuKeStQQ0NwuElndq9q1JIrdXnZqKyvDAtBFWTD6T5oQK6lMtN8VtO45+dWYW556cJnVPdGvotb7G8PgYxPdenxXXbcJPowhbuhjFpR4xZ2TlK3q456e61iyavX9dQy4FS3SB6w8rU3GvDfUowOveK4XFBkKhEjsi4ncyBZWIs+olhtJF480xf0F+2R5DPzBGkwHvvKKNHv+mLrGx+Y15LrdWo//5e+ZyigjIENp0+9+9qvRkZgtOiaKIch8wzbLnpGrJMsZDEhRTB7s2/dUIX/wg3u8M6XFh/l33uAFem/mhN939pWYVuNnjN8HcSR42zMFiS9EpDR3fvHobqJzQrAlQwt3+BGKWm2v8ChIDp+IDXwG6bXvyUj5fgzE3QSxtVRtI15IRd1yMrM175ZuLniqmXXEjHIjZmk9iZ8+xulm4htBH3Fbgbbfjos4w1W1Oc7SH0m7SiU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199021)(66899021)(2906002)(83380400001)(316002)(30864003)(26005)(6506007)(6512007)(1076003)(6666004)(6486002)(966005)(186003)(478600001)(86362001)(107886003)(921005)(2616005)(66476007)(41300700001)(8936002)(7406005)(7416002)(4326008)(66556008)(66946007)(8676002)(36756003)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tn4cNxuMKUucLjXaSPklZVzrqg/vpANBU1QMLzwhtUHc/E31XQtqPxRl/qoz?=
 =?us-ascii?Q?j2FCkPfloKMd5xqRULxCjMJJu8t5ivgPZkSGCWTCfUS9YvMZHMxcb6jwMJ+L?=
 =?us-ascii?Q?5m0gx6Ot4Ck9j4XiFz/Ea+APzfkO9uaWxIVoxrOB7H5LZQBkZ9PoETTRo45H?=
 =?us-ascii?Q?/Ugg5GhEqlwpLzd33ZNM94QvVB39A/uXy1p/4OtA9yFdHP/n6ThbcO3qJLZH?=
 =?us-ascii?Q?siv+H/uYbIcPdQNBssheeUBWPfyMZYHHm/SwBNwAWWnGP40nvS8mOXAm6SUO?=
 =?us-ascii?Q?YRIpd0eXHs1LSjdTV5liD4aqDMXUclOIIGKJThAKRJl5x/idd15bZlmvhbk2?=
 =?us-ascii?Q?+Y07MbxAZ01gVGUf/dzj337JlGLZH+ZpO31eglRZnwDUfwkkwsmJTOHxYPMt?=
 =?us-ascii?Q?GlAEJZ98Ux0eyFcYCVceujqSenpgr6aWWP3M8e62VpLlYB+uOqhyB5Ct9QZ4?=
 =?us-ascii?Q?ZKkZksWuupkj3YY47eWlWOD3OAaji24/i7WknsOoe7MocD57PD2VNZZB5CWI?=
 =?us-ascii?Q?VOxQ8c7+fQw54po7ubPElyzl+D8V5e/gCysnYgbOKhmVMaIpOCSHRLFkFFMT?=
 =?us-ascii?Q?IUvDqkBumnz5oh+j9F2zW/8sw/JoqK8rgD1S2rDcjMHqvSjNhljuWVn8zc2D?=
 =?us-ascii?Q?CcXM121ODMJ6YRBuZ8WqbMr0FcAVwA2gcOmD+ER6QvciCkivZA/UKsTKE3sb?=
 =?us-ascii?Q?CA0rpWl/c1cLHZz8imOEWbBMB0oI+Q1cH3dT1z2ak1EwHmCzXBP9JCsb9h+o?=
 =?us-ascii?Q?JeqOGnmgQNJZ00Sx2DIvJVcRYEWXzMiDcBoB5KZWXug67B61vtxVslQZpY8q?=
 =?us-ascii?Q?x9NIwEKRVzBMZ5hZgh5AJo9ADivew3HVlobtDtlt8zFW3iHe8we8V3CwLsNF?=
 =?us-ascii?Q?dHM7sOXWy7xYZzYfpX9sWy3HRyR2BGBDmftQQlTLBFlKDpTJVwGAuQFGTRjC?=
 =?us-ascii?Q?vRV1jH31a2ZboJ4x/9psQWzqqnBD4txpSWJ4lVTz67xuP9Y2yEuW/pfhfB6n?=
 =?us-ascii?Q?Lh+v/QbvO48TyhK33JFk8ojymZ581rPL+kMbaJ70fSFDLFXTtSYlpbso+WXb?=
 =?us-ascii?Q?nn0RtuwVg/Swr50VdQ4x0PT/UDSTV6/py2f37arZhcsPZO9nNWwphK1CAWtA?=
 =?us-ascii?Q?2INmqb1xXR00oQJEXG1zq73z+7sIiikHBwup8ycKeIQJz+JyzW3n3c5+WXGI?=
 =?us-ascii?Q?WD/VAldSRAJkvzt2MXwGi7lX9bQcxvh8rOAvwMjE6ma22g3qgNx9msCmndZV?=
 =?us-ascii?Q?sR/GMUcxzha9npRHd8m2iAx5MLUviK/AKDPcX3XNUwQexgsiTX37wVvjZeMR?=
 =?us-ascii?Q?abrVGqTTOfTbIJr2vlH5Cj2kZmxWTGw1cEyDbAZL4f1CFac1cj2uzLT+pPgr?=
 =?us-ascii?Q?nz+y9yrhpphpXx3bpY3QM07YoTA6CjEjm84jXGtxfDzFSG1o+DvNFt4RLFDE?=
 =?us-ascii?Q?EQr/sB4WwKG+O8U+B5yuWLN12vjNQEuXuAMfXYZ6dQ0lqa3fxFH2dvLMbIqi?=
 =?us-ascii?Q?Q6vQEKFoV6U99kKiJRM5h7eZ8scCt4Cmh3jeQQ47nkgfuOuR3B6icreAGY8Q?=
 =?us-ascii?Q?8pI2cF9GO5ybn/kVg++ODZoaunKmIpY1aMDFp4+PmJ34uG8DiUM+C7sWnMP+?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9A8vrNLQnloYjNp7/bxpfvqks/H32hSgZqLihLXE+Mh3dga62wQcLnkeBQmV?=
 =?us-ascii?Q?oloRwq7LSRxv/ZY9052H1hH0mrE4k8e9o6Dj5GnoQyWAvSbh8Yp7Dma+JNLL?=
 =?us-ascii?Q?dcB1C3XvrHsLOyf3+p2eSASoO8LM6Rm6w/bauZGr7jJqzJ+vbOCdOVO4Q1Dg?=
 =?us-ascii?Q?TNZjlSFbPItJQw65MgBDv3azbePmixB18CbkOizHJwCPUFf7GoV6acANn50u?=
 =?us-ascii?Q?/sgiYJZfbihU1fRqV/NPI0D128Eh2qSB0yDx9ooY3KIMYivnc9P6O6dmqcuV?=
 =?us-ascii?Q?2v1XSBETMcta3uZrciaK5hOncXmHBVkfjiDoandNswefMp7Fg8J3v2aexJqj?=
 =?us-ascii?Q?o3qjDeBKkPmeWdD9NGWt9yoYBiP17iW05Ub3xTeLF0+QYUxEQBguceX70er7?=
 =?us-ascii?Q?szxmOw5I7pVlBh2NWCUdC0IQDpc1LuMZ85JCJp491f34IJlw2idKsDwUOrhu?=
 =?us-ascii?Q?hX5snH8MvXIqLyK0gHVZLOcSKOxqpHgc9SLGuBb9k2UozUMZkKQZJDVSCQ/5?=
 =?us-ascii?Q?kt/BmAGrUGYklyMokr8G1Ie6eBDz63gci5LYpJijcLzWdQOU8Kx4D3sbCgrs?=
 =?us-ascii?Q?qfuRT8pqiC/oXG65VxydLfRgHL8QNd/dERx1V4VA0sJsTawZ/K3jlJ0Qq7SK?=
 =?us-ascii?Q?Jcm15ZpAFt+8x9Z8aZX2tLB+Y5ocO3Wy2tHn0htL6gC4wEZ8pfgZMWCZnR+8?=
 =?us-ascii?Q?NeascBafoqoROUA1zfYA9peY8Gob9nHTiFRFBStaGxRbec94xZLoWdZhyzzW?=
 =?us-ascii?Q?M1ZAAI0OI0bl/AQmvK08y8urHmS0S5D41z2aPOhQEjpsg8glVqfVCEdURLuH?=
 =?us-ascii?Q?2rGSnmyZsVyfDMmul+8L6GDzd/IOTy/t+3aKI4knGd7dlx+iXp7uiLjJ0UnB?=
 =?us-ascii?Q?Y0ydoY4F+DVinK4Z9SkUweBO4q+NJjiIp6gdCVwgj21rBlYxuWV23WWZX85D?=
 =?us-ascii?Q?HrBZm8I8g4PdvSsFU8upvUhCS6n/ksfSb/Cy+x6Fy6ycTlo2a6riZU8rAIoF?=
 =?us-ascii?Q?S/BaYyZhoIRtqHKtaC0DSBSYJbTBsx2saNCWT0GCuLnTxxJLMJY23QFqklN4?=
 =?us-ascii?Q?ah/mtFNZ+7jqyt79E3iWWeBGwGmCtduMlUeMOWHJ9xh+jJ/gseXWjlabnONq?=
 =?us-ascii?Q?1MwrhBgwC7XcqRGZ4BGHLsMHv7uIADE+TqLrwrv6NxLrKMDmm363M7nT4fxb?=
 =?us-ascii?Q?VdMeRJL2Rznt5NaPpqXdJjOeeoH6ZaJRpoSUc9KbRYnt5Y5ar4fcqG5TaYH2?=
 =?us-ascii?Q?uFNNQz3S+1tC+AEZuKwY7Le/RXDcPJMkg0+BuW3C9qDtLjwoSfQOwC0OJBpP?=
 =?us-ascii?Q?CrmhoBpv07y3ReAVhu6HBTiZTWjVchstYTZQ3zRrAOLVU9x0k9kSKiDeYpQt?=
 =?us-ascii?Q?BBOvAhULmIOceE2AdKms7/HJJGp1QZHybMsTCYGzLJsTokNjsPqndH0k68ZK?=
 =?us-ascii?Q?dZDdEEBv388=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd3f07f-f986-418b-6314-08db7808d035
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:52:25.2457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPfipUAkj4w/wGTX3C/Pf41ZR+dDUNjDoKp8xNxI2kmxReTFEEbuuWT4/p6YyEMnyBOhuX26f4U3mFVArPzKGTV4IdNNY3kZFGlcGRdP2jY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_13,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280168
X-Proofpoint-GUID: cLEAzqRkeUP3--ypZ6QCUHALZhJ6ev-K
X-Proofpoint-ORIG-GUID: cLEAzqRkeUP3--ypZ6QCUHALZhJ6ev-K
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is dependent upon "refactor Kconfig to consolidate
KEXEC and CRASH options".
 https://lore.kernel.org/lkml/20230626161332.183214-1-eric.devolder@oracle.com/

Once the kdump service is loaded, if changes to CPUs or memory occur,
either by hot un/plug or off/onlining, the crash elfcorehdr must also
be updated.

The elfcorehdr describes to kdump the CPUs and memory in the system,
and any inaccuracies can result in a vmcore with missing CPU context
or memory regions.

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (eg. kernel, initrd, boot_params, purgatory and
elfcorehdr) by the userspace kexec utility. In the original post I
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash handler that registers with
the CPU and memory notifiers. Upon CPU or memory changes, from either
hot un/plug or off/onlining, this generic handler is invoked and
performs important housekeeping, for example obtaining the appropriate
lock, and then invokes an architecture specific handler to do the
appropriate elfcorehdr update.

Note the description in patch 'crash: change crash_prepare_elf64_headers()
to for_each_possible_cpu()' and 'x86/crash: optimize CPU changes' that
enables further optimizations related to CPU plug/unplug/online/offline
performance of elfcorehdr updates.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory; thus no involvement
with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the RHEL udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel updates the crash elfcorehdr for CPU and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   With this changeset applied, the two rules evaluate to false for
   CPU and memory change events and thus skip the userspace
   unload-then-reload of kdump.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load() syscall.

This kernel patchset also supports kexec_load() with a modified kexec
userspace utility. A working changeset to the kexec userspace utility
is posted to the kexec-tools mailing list here:

 http://lists.infradead.org/pipermail/kexec/2023-May/027049.html

To use the kexec-tools patch, apply, build and install kexec-tools,
then change the kdumpctl's standard_kexec_args to replace the -s with
--hotplug. The removal of -s reverts to the kexec_load syscall and
the addition of --hotplug invokes the changes put forth in the
kexec-tools patch.

Regards,
eric
---
v24: 28jun2023
 - Rebased onto 6.4.0
 - Included Documentation/ABI/testing entries for the new sysfs
   crash_hotplug attributes, per Greg Kroah-Hartman.
 - Refactored drivers/base/cpu|memory.c to use the .is_visible()
   method for attributes, per Greg Kroah-Hartman.
 - Retained all existing Acks and RBs as the few changes as a result
   of Greg's requests were trivial.

v23: 12jun2023
 https://lore.kernel.org/lkml/20230612210712.683175-1-eric.devolder@oracle.com/
 - Rebased onto 6.4.0-rc6
 - Refactored Kconfig, per Thomas. See series:
   https://lore.kernel.org/lkml/20230612172805.681179-1-eric.devolder@oracle.com/
 - Reworked commit messages to conform to style, per Thomas.
 - Applied Baoquan He Acked-by to kexec_load() patch.
 - Applied Hari Bathini Acked-by for the series.
 - No code changes.

v22: 3may2023
 https://lore.kernel.org/lkml/20230503224145.7405-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0
 - Improved support for kexec_load(), per Hari Bathini. See
   "crash: hotplug support for kexec_load()" which is the only
   change to this series.
 - Applied Baoquan He's Acked-by for all other patches.

v21: 4apr2023
 https://lkml.org/lkml/2023/4/4/1136
 https://lore.kernel.org/lkml/20230404180326.6890-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0-rc5
 - Additional simplification of indentation in crash_handle_hotplug_event(),
   per Baoquan.

v20: 17mar2023
 https://lkml.org/lkml/2023/3/17/1169
 https://lore.kernel.org/lkml/20230317212128.21424-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0-rc2
 - Defaulting CRASH_HOTPLUG for x86 to Y, per Sourabh.
 - Explicitly initializing image->hp_action, per Baoquan.
 - Simplified kexec_trylock() in crash_handle_hotplug_event(),
   per Baoquan.
 - Applied Sourabh's Reviewed-by to the series.

v19: 6mar2023
 https://lkml.org/lkml/2023/3/6/1358
 https://lore.kernel.org/lkml/20230306162228.8277-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0
 - Did away with offlinecpu, per Thomas Gleixner.
 - Changed to CPUHP_BP_PREPARE_DYN instead of CPUHP_AP_ONLINE_DYN.
 - Did away with elfcorehdr_index_valid, per Sourabh.
 - Convert to for_each_possible_cpu() in crash_prepare_elf64_headers()
   per Sourabh.
 - Small optimization for x86 cpu changes.

v18: 31jan2023
 https://lkml.org/lkml/2023/1/31/1356
 https://lore.kernel.org/lkml/20230131224236.122805-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc6
 - Renamed struct kimage member hotplug_event to hp_action, and
   re-enumerated the KEXEC_CRASH_HP_x items, adding _NONE at 0.
 - Moved to cpuhp state CPUHP_BP_PREPARE_DYN instead of
   CPUHP_AP_ONLINE_DYN in order to minimize window of time CPU
   is not reflected in elfcorehdr.
 - Reworked some of the comments and commit messages to offer
   more of the why, than what, per Thomas Gleixner.

v17: 18jan2023
 https://lkml.org/lkml/2023/1/18/1420
 https://lore.kernel.org/lkml/20230118213544.2128-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc4
 - Moved a bit of code around so that kexec_load()-only builds
   work, per Sourabh.
 - Corrected computation of number of memory region Phdrs needed
   when x86 memory hotplug is not enabled, per Baoquan.

v16: 5jan2023
 https://lkml.org/lkml/2023/1/5/673
 https://lore.kernel.org/lkml/20230105151709.1845-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc2
 - Corrected error identified by Baoquan.

v15: 9dec2022
 https://lkml.org/lkml/2022/12/9/520
 https://lore.kernel.org/lkml/20221209153656.3284-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc8
 - Replaced arch_un/map_crash_pages() with direct use of
   kun/map_local_pages(), per Boris.
 - Some x86 changes, per Boris.

v14: 16nov2022
 https://lkml.org/lkml/2022/11/16/1645
 https://lore.kernel.org/lkml/20221116214643.6384-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc5
 - Introduced CRASH_HOTPLUG Kconfig item to better fine tune
   compilation of feature components, per Boris.
 - Removed hp_action parameter to arch_crash_handle_hotplug_event()
   as it is unused.

v13: 31oct2022
 https://lkml.org/lkml/2022/10/31/854
 https://lore.kernel.org/lkml/20221031193604.28779-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc3, which means converting to use the new
   kexec_trylock() away from mutex_lock(kexec_mutex).
 - Moved arch_un/map_crash_pages() into kexec.h and default
   implementation using k/unmap_local_pages().
 - Changed more #ifdef's into IS_ENABLED()
 - Changed CRASH_MAX_MEMORY_RANGES to 8192 from 32768, and it moved
   into x86 crash.c as #define rather Kconfig item, per Boris.
 - Check number of Phdrs against PN_XNUM, max possible.

v12: 9sep2022
 https://lkml.org/lkml/2022/9/9/1358
 https://lore.kernel.org/lkml/20220909210509.6286-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc4
 - Addressed some minor formatting items, per Baoquan

v11: 26aug2022
 https://lkml.org/lkml/2022/8/26/963
 https://lore.kernel.org/lkml/20220826173704.1895-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc2
 - Redid the rework of __weak to use asm/kexec.h, per Baoquan
 - Reworked some comments and minor items, per Baoquan

v10: 21jul2022
 https://lkml.org/lkml/2022/7/21/1007
 https://lore.kernel.org/lkml/20220721181747.1640-1-eric.devolder@oracle.com/
 - Rebased to 5.19.0-rc7
 - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
   for architectures not supporting this feature.
 - Per David Hildebrand, removed the WARN_ONCE() altogether.
 - Per David Hansen, converted to use of kmap_local_page().
 - Per Baoquan He, replaced use of __weak with the kexec technique.

v9: 13jun2022
 https://lkml.org/lkml/2022/6/13/3382
 https://lore.kernel.org/lkml/20220613224240.79400-1-eric.devolder@oracle.com/
 - Rebased to 5.18.0
 - Per Sourabh, moved crash_prepare_elf64_headers() into common
   crash_core.c to avoid compile issues with kexec_load only path.
 - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
 - Changed the __weak arch_crash_handle_hotplug_event() to utilize
   WARN_ONCE() instead of WARN(). Fix some formatting issues.
 - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
   and CPUs; for use by userspace (udev) to determine if the kernel
   performs crash hot un/plug support.
 - Per Sourabh, moved the code detecting the elfcorehdr segment from
   arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
   and kexec_file_load can benefit.
 - Updated userspace kexec-tools kexec utility to reflect change to
   using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
 - Updated the new proposed udev rules to reflect using the sysfs
   attributes crash_hotplug.

v8: 5may2022
 https://lkml.org/lkml/2022/5/5/1133
 https://lore.kernel.org/lkml/20220505184603.1548-1-eric.devolder@oracle.com/
 - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
   of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
   is not needed. Also use of IS_ENABLED() rather than #ifdef's.
   Renamed crash_hotplug_handler() to handle_hotplug_event().
   And other corrections.
 - Per Baoquan, minimized the parameters to the arch_crash_
   handle_hotplug_event() to hp_action and cpu.
 - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
 - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
   to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
   by David Hildebrand. Folded this patch into the x86
   kexec_file_load support patch.

v7: 13apr2022
 https://lkml.org/lkml/2022/4/13/850
 https://lore.kernel.org/lkml/20220413164237.20845-1-eric.devolder@oracle.com/
 - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.

v6: 1apr2022
 https://lkml.org/lkml/2022/4/1/1203
 https://lore.kernel.org/lkml/20220401183040.1624-1-eric.devolder@oracle.com/
 - Reword commit messages and some comment cleanup per Baoquan.
 - Changed elf_index to elfcorehdr_index for clarity.
 - Minor code changes per Baoquan.

v5: 3mar2022
 https://lkml.org/lkml/2022/3/3/674
 https://lore.kernel.org/lkml/20220303162725.49640-1-eric.devolder@oracle.com/
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 https://lore.kernel.org/lkml/20220209195706.51522-1-eric.devolder@oracle.com/
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 https://lore.kernel.org/lkml/20220110195727.1682-1-eric.devolder@oracle.com/
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
 https://lore.kernel.org/lkml/20211207195204.1582-1-eric.devolder@oracle.com/
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 https://lore.kernel.org/lkml/20211118174948.37435-1-eric.devolder@oracle.com/
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 https://lore.kernel.org/lkml/b04ed259-dc5f-7f30-6661-c26f92d9096a@oracle.com/
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---

Eric DeVolder (10):
  drivers/base: refactor cpu.c to use .is_visible()
  drivers/base: refactor memory.c to use .is_visible()
  crash: move a few code bits to setup support of crash hotplug
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  crash: memory and CPU hotplug sysfs attributes
  x86/crash: add x86 crash hotplug support
  crash: hotplug support for kexec_load()
  crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
  x86/crash: optimize CPU changes

 .../ABI/testing/sysfs-devices-memory          |   8 +
 .../ABI/testing/sysfs-devices-system-cpu      |   8 +
 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 +
 arch/x86/Kconfig                              |   3 +
 arch/x86/include/asm/kexec.h                  |  18 +
 arch/x86/kernel/crash.c                       | 140 ++++++-
 drivers/base/cpu.c                            |  83 +++-
 drivers/base/memory.c                         |  91 ++++-
 include/linux/crash_core.h                    |   9 +
 include/linux/kexec.h                         |  63 +++-
 include/uapi/linux/kexec.h                    |   1 +
 kernel/Kconfig.kexec                          |  35 ++
 kernel/crash_core.c                           | 355 ++++++++++++++++++
 kernel/kexec.c                                |   5 +
 kernel/kexec_core.c                           |   6 +
 kernel/kexec_file.c                           | 187 +--------
 kernel/ksysfs.c                               |  15 +
 18 files changed, 819 insertions(+), 234 deletions(-)

-- 
2.31.1

