Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6BA741851
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjF1Sxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:53:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42128 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232064AbjF1SxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:53:18 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SGwm76002041;
        Wed, 28 Jun 2023 18:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=kqZzUcUI7g9GrNNQb568EFpHtig8R3NmjYR2Lpu3gEg=;
 b=PEHdWS8bLy+bP0M31qQ/8kf/fWEZqoFKO3T7IpW7AU5YESzpLMI4a6HBMqyxINpdxAl3
 eWMXq3CYIeKcOFs8QFhV+DKVafZpG+BVnhDZGoVteDwA/Ixf+gFPLTYD9jpSJpGXjA6Z
 aY2wFL903BB825lRQ10CEQx+YrprkeGdW8q/waRC2YmMzeITt7abmPGj56NsfNRMOX2R
 JAudDwSg9TFL9+Vz9UEllOjtlDQWYvYAv7wGW6gd6cIgzKU1OJFSo0XUAR5N/zB7sGKs
 MElXLWg1pV9TgWZt2Tkj3g7MVFKlFpKnGvJcRrSlDIue/V404n0gRHXxZ/1RjbB4ufJk Kg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40e6uww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SHeXd1019984;
        Wed, 28 Jun 2023 18:52:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxc6d44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbW4I5JUQnMteEKhIIbRVoBG4i528sh6E4By+ZG6J2hskDy/R92T83uOH2F3pVa8NflpRAQr1N108xVkm3jEi9TVixaNrRSts1CnbQJpZUWm9zD3QzZJ76yMq3vd6gxkjMpmYhS8XLhcCXSTZ8NHlgLnUMqk2wp6wc4RwrLn5AJATzB8znpiYAku4AKZ6ny/LOvHvdUHOqkdq8KwYqlRNUIW+fV+aCzxqoI4VM4kT/DCdd/zzvutC4H7H3Wu5laMcZLu4V2BvAJp2lNyJiDB3z/dkOn07jiRi+m0fIw+9D7QrTkpSqw76uk3+xHYbWTEmsSYZN7XIlBRzzNGngAy/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqZzUcUI7g9GrNNQb568EFpHtig8R3NmjYR2Lpu3gEg=;
 b=OCAvY9yciT8nTKYZYJcVkrLc3NCWmZsrXSQTcML6jaaG6yDfe2o061sktMjKXCm42FQ3qPY6oqixM4oCV9jT2s9+HD2gXbMA92AZ6BTNwqXR4GQr4/KY7uOuc+mNVm3xnkBRzhb2iuTe2O1DeJr+mnJbHG9J7dBAtiqtpPBq0GoevfckGLANXvqONCqxn34Nu9DVMUg9Pq3zl3L7CTriEGDN5gD1L+XU1YucltiLoSFwL8BaSdrbgU7YpIcfCOBQtXmFKc+d+4ubS9M0Xsfopciaz9KHXJuKTCw77glDqmOPs5GFG4HsHRmu0Mh5LYYHlPfbv5ON8EI37PeSglYVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqZzUcUI7g9GrNNQb568EFpHtig8R3NmjYR2Lpu3gEg=;
 b=ZM9Z1L3lLEGwV3w1839+OkOi3Y4l/dl0J0mYeoNYvTRsOAo1rrNO6Q7M4mMKxERwBp8ZAG9OuKr2Z7xW08V2rNNnJz9LM93G4t0VjJLkhQih6TunHVYckjlcurxCgjxmBiDFtTLSxgmhEOR1snXX4ayx3BfL/SL5/55rPDS/HMU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by LV3PR10MB7820.namprd10.prod.outlook.com (2603:10b6:408:1b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 18:52:50 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 18:52:50 +0000
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
Subject: [PATCH v24 09/10] crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
Date:   Wed, 28 Jun 2023 14:52:14 -0400
Message-Id: <20230628185215.40707-10-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628185215.40707-1-eric.devolder@oracle.com>
References: <20230628185215.40707-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::19) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|LV3PR10MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: ba26dda1-3456-4c8c-bad3-08db7808df7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNK4r3qODmyE5LvK1S4wwb6b5bLbTNeeFI7H5miyK82Lx6vGQ2qQQAlSvXHc8D7oZ7Dnft3msfhhNVIaaEyNO2g4GL5ICfHerh5LTtG8vprkwEBfSdcGvpeKXw2fGKH1qt+dvk6mgGL8EgQhPUshrgqEKZ+Pj+sBhT8iyG+DcqjU6SbwS/xmGNd9w7rzqCBgO+jzZCpzgbomF10ywpCENyVmvx+Efv1xYsgPWxfTYHtA98F78lrpGNNw2NcBwaQoqfyu5geTyxPo/dlPiAjHxJ153DaioVVdMAZnfgjx3y4xOrHsM1EBX81YThGVJWkFf6+71imuIvFF8/EFoEtVWMHRr0xK66iV+tk5erFDex/xg68tMcnI/Q1LDvGAoHAcDPDfPCtDTZWvdoyQPxJ3UXF2q5ZbuWtQIOH/7lu7WLHK9GwTZGOyR1sGDewC+QMJkq/PmzFajEVKs5iP4m2nLzhR+xpLMSxFRI5NdVlGdBrKYy3+BTY04CF5e7KrmBVbcAvSJpXOwUKAYuBcFuqcNk3LgCqPsvdS8fEnjODHyWRb5MdcA4HaXvr24yXL0aj4l76kEMx//jjh315gmje/7BV5w0J5x7nws68+NeSz9Q8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199021)(2906002)(83380400001)(316002)(26005)(6506007)(6512007)(1076003)(6666004)(6486002)(186003)(478600001)(86362001)(107886003)(921005)(2616005)(66476007)(41300700001)(8936002)(7406005)(7416002)(4326008)(66556008)(66946007)(8676002)(36756003)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6MDEkhzcXiH/T+h27rmYp4YS/2wdrhDnxw1uwoOsVSmr8EheuACjCsYqjv0s?=
 =?us-ascii?Q?11BDgOCh+HJobw5PzpoTkoc1eYahmPCSWM4hJRSoQl/pCIEEa7sQY01uV0lk?=
 =?us-ascii?Q?bBNPqW6gWFmLmWgXvlStcHVVXJuQNlJ4zynRmWHCaeHPXhBFaSzOTHU5X9se?=
 =?us-ascii?Q?p/CigzYBa8+sj66RKtBfFvtIDZpXMi6ja/kyqRWdXV43ksCzcUbhqxrNRHKg?=
 =?us-ascii?Q?UUkBecoC0lYQgf9LcBtb7mUhjyWKYF9Z1v23yr/w1PJDoyV2uBPrz/6mqPpm?=
 =?us-ascii?Q?gBrCloIB18zv1Pc7c0EJdK03xii8oM4MyxpAMtat0GAguPu3G43UvHF19iDR?=
 =?us-ascii?Q?KbeX884rJaCj9xvuCB/Ew6KOPVehug1Kc3VSyHkWPTLD7wPLOOFZguqgpII6?=
 =?us-ascii?Q?tcLFW5TBR1Vi7XvqwrZrUKd8EnU94FJhH+NXtm9xzo5T49/p9UlGaLKgxsRT?=
 =?us-ascii?Q?Id8G16rgQ9VepJB9yZQyZAF5GYEob3y9eNvc5uCDVnuOMWQz+3uBYYxzs1UH?=
 =?us-ascii?Q?ayrN7VARc0wOUn1J/A6dmlKt66kCKbEIgJYmtEjhSm0ZeOTyBoZi8PL9MUXy?=
 =?us-ascii?Q?s5tDaWwGIRP6+ZJnP9ilEsQV9nChPEnDJpZ8nmiHVzVE2P8pFiEjA8Z/z4Nc?=
 =?us-ascii?Q?I0eFGcGWAEB833DPYMby3PJRobodoGt/j9aPk+22lurxrqCsqErwMK2XjYFt?=
 =?us-ascii?Q?kTz81mwDyTtS49T3VYZg3Bc2bkiPIzAwuqYYeXDef9bfN4WODCr3wQPke8kt?=
 =?us-ascii?Q?RWgLeOrl2CXinAIU3CdrSYFJg4TMy5SwXGe0V2mCXQzrw9p4j9k8wcyPwFBv?=
 =?us-ascii?Q?KGjgD6Xx+h16Zu0n4Y6COpHk5jsFNBMkiFtilo+0i2lx83EBgSpS0BI0Leam?=
 =?us-ascii?Q?4lZ2jcFm1b82vRKevSNI53ezMKTa11fbL8GW2zoCXSQQmCnsBYhak9HysK8G?=
 =?us-ascii?Q?0sFTJEboY6ecWUiyqikD1BoALrwCcYrqx9GjicIa+QRQRHMnnhY4ZChq9O5I?=
 =?us-ascii?Q?tRk9rLawFguZ6hW3jN5ql5jfVT3x0IB23UrfOgr41E6E/77iVlxUM378KM+T?=
 =?us-ascii?Q?7Id1EbssMlwO1XDjVzDB9kfhBlMAbpKuJHgdczLh0vZqty/9X5k9GdDrjlKN?=
 =?us-ascii?Q?qZXMLLMwsuRQR+FtVjUo19ZX5mFWE2d8eqmlcgYsW7XU7/0txGGPHNvOrGIb?=
 =?us-ascii?Q?PF1JIRqlWtHtJ+WOgxFC/XLUwetcruahT3Bk5mEUEIDuW4tWlrf4dQ5xesyq?=
 =?us-ascii?Q?RepG0yMDJajOTJidN2vng1ZaotQs8patr9ghigGP/169MXtD427kDEK/hnCY?=
 =?us-ascii?Q?pq6JD5e+i6xJgy7TcVnXN6qo2H77tDasjr9rHhmrnQTRQq6x9H7s6ud70Cyy?=
 =?us-ascii?Q?UbKQ4ALAFbyhqGLmEujrC9qEw9xSgsU1GuGHAIT+sunMAmgjLczjOhi601jL?=
 =?us-ascii?Q?z1hkGRuqhpN4NopUynHhh+BXxnODNNt3uJOvfnAcWSZPoliTvMXpYjrzwaWH?=
 =?us-ascii?Q?YKmSedlrgnDtajwm4sdH9YpJnMdzp6oRiQ9922SxXDlsdb74RbQu7wzo+wFm?=
 =?us-ascii?Q?wJ26h+oIccZvcZ5fUADMILxMnTSL+l8f7aHR4PqzCzOvIphn7VQjUOT8M8Ja?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Y8T6ZkKHHVSUUHMKz9fjrCFv5ZaL4sJwEb04MKhY8ZmhJWKMzOAOJvfZ6FMH?=
 =?us-ascii?Q?51BlyH/qGdawtH3gHmK/k6yZzV74TJJN+MI5Z7jcsc2LUvvBcw45Vl+C5fn+?=
 =?us-ascii?Q?Xtrn7hTkBNKz/1JHkZ6te82pjxO392BwxvTL2fm/Kg6nB4HHxABHCaIVaJT9?=
 =?us-ascii?Q?qNw36EaUXn4q64bq0LZ21MQd1DkoTDHxy7iTzpsHMPqhPZEDkt8gWFUk4knT?=
 =?us-ascii?Q?p9V6xiN7nwUyd5l49NbtZ8HYn4/R0+VZSu+wkwgbK/C8YhZ/WulXzaPCBurk?=
 =?us-ascii?Q?6KUnbhq4TJwWnz0xHmIh83dzCKFefVy3ks3gQf9rComH6wluEFY3t0AEBibI?=
 =?us-ascii?Q?khTIyyCj+mmofayhvH4Lked3N6wNiwUj6lws8dZKEGLMxd6w2JJUfvEqR5yw?=
 =?us-ascii?Q?rNBVu0gwy6WZ4ElK2ZwClVDKXd1z5E11Ls+olY8oUKxbw6LCC98QrhIjP1uJ?=
 =?us-ascii?Q?4JtudZjQSDEuTC52zLirl2UHmTzBcy32vtu1Tr1ftexZa2QOJIMr5TajXv8i?=
 =?us-ascii?Q?rzpMBM87E3xX1BSUAvcUALvCxjU5XQMd6DAQsjiSUfhEGJ0DXlWGaTeGs9Dk?=
 =?us-ascii?Q?73Bvxo1kC//MsuMSV3vygBOrc+mjXJNCDjX6T3RWkU1unxUInTO4jNZN+kYL?=
 =?us-ascii?Q?50mQib5iAVGgLftTX2ctFS3yqRpi2JzjrY4buKKXfyYMpMRc+9nwYKWde/VL?=
 =?us-ascii?Q?W3egbNYCM9mEvAEBLWMFVUrsQEb512x0tJSxjA946RR1u6QAnmTtOJTZpE7Y?=
 =?us-ascii?Q?OU8dJ1V1AF3T4DOZL09uG8I/596IthJf1CC6hD2VLKYTrG+Gvgd9XcwVtoY0?=
 =?us-ascii?Q?dYpqh7RV1w/6zUSf3AetEsYfvtfN/YUhBAhxAieaDWYLI9d4JkdkrEN4Bdj4?=
 =?us-ascii?Q?0PFBZcOa/bR7r6Vrq/kYQTPlzfBa2wbazfDmgLn5y7Prn88vQ249XqtkdIjq?=
 =?us-ascii?Q?NgMjsFjtJeYlXW7xGi1iYsHZhq76XpwE7XfSG5vDQeQt2su5q5lnpY6zdYz+?=
 =?us-ascii?Q?8Mlp+A8gcViZBsGZ1bmtMUJ4JoES6IQsKdtP4nB9UWmxv8yb5WLkkuU2ZDmA?=
 =?us-ascii?Q?5bu5bgwz6BW4pZ//L5ahjbbRnumPa7CPP2h1BFN/eUos3Zg0Jy1xE1mlR6rd?=
 =?us-ascii?Q?8L9yMh+AiWQ2MXZXUzp8EEa351O2HEQv0hT9dr5U7Pjg5GgbTJJjBaAwU9og?=
 =?us-ascii?Q?9dbrNbAOLjYxkG1/AwdGF2Mv9lpNnUbQM/I6IkbjebqgECc/OjSsSIpw3h/H?=
 =?us-ascii?Q?MhligMH3ca+uFR+iaB3D3GoPrBJ6tkGt3SpAV94OI6cfSIwZCU5/JY3rCBlQ?=
 =?us-ascii?Q?l7FNX6MQ9ulBMAYRGWE5xenoJFtsirfrFmWHsb2wiN7+WHI0MzqRkfAUZOJ4?=
 =?us-ascii?Q?I1y0re54XaMLDfMgqoYPC7GtdGpSMrHQ/KJLHh05jKiOK7IRaJDIcAvGxhH0?=
 =?us-ascii?Q?59w+rud8YzI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba26dda1-3456-4c8c-bad3-08db7808df7a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:52:50.8418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaHb7SReA4dEq6xdH00xeWWBZTu0PxhGBjdrfrjtYU4uK8pA1TXMJZXc1ogRIFla+48xWUHL2JR4Py5LLQuzmZxA/E4Wv8NsatT9Rc8Y+hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_13,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280168
X-Proofpoint-GUID: 0gxgbTEiHel7Q1fbdSDmLFOxBFxQPQis
X-Proofpoint-ORIG-GUID: 0gxgbTEiHel7Q1fbdSDmLFOxBFxQPQis
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function crash_prepare_elf64_headers() generates the elfcorehdr
which describes the CPUs and memory in the system for the crash kernel.
In particular, it writes out ELF PT_NOTEs for memory regions and the
CPUs in the system.

With respect to the CPUs, the current implementation utilizes
for_each_present_cpu() which means that as CPUs are added and removed,
the elfcorehdr must again be updated to reflect the new set of CPUs.

The reasoning behind the move to use for_each_possible_cpu(), is:

- At kernel boot time, all percpu crash_notes are allocated for all
  possible CPUs; that is, crash_notes are not allocated dynamically
  when CPUs are plugged/unplugged. Thus the crash_notes for each
  possible CPU are always available.

- The crash_prepare_elf64_headers() creates an ELF PT_NOTE per CPU.
  Changing to for_each_possible_cpu() is valid as the crash_notes
  pointed to by each CPU PT_NOTE are present and always valid.

Furthermore, examining a common crash processing path of:

 kernel panic -> crash kernel -> makedumpfile -> 'crash' analyzer
           elfcorehdr      /proc/vmcore     vmcore

reveals how the ELF CPU PT_NOTEs are utilized:

- Upon panic, each CPU is sent an IPI and shuts itself down, recording
 its state in its crash_notes. When all CPUs are shutdown, the
 crash kernel is launched with a pointer to the elfcorehdr.

- The crash kernel via linux/fs/proc/vmcore.c does not examine or
 use the contents of the PT_NOTEs, it exposes them via /proc/vmcore.

- The makedumpfile utility uses /proc/vmcore and reads the CPU
 PT_NOTEs to craft a nr_cpus variable, which is reported in a
 header but otherwise generally unused. Makedumpfile creates the
 vmcore.

- The 'crash' dump analyzer does not appear to reference the CPU
 PT_NOTEs. Instead it looks-up the cpu_[possible|present|onlin]_mask
 symbols and directly examines those structure contents from vmcore
 memory. From that information it is able to determine which CPUs
 are present and online, and locate the corresponding crash_notes.
 Said differently, it appears that 'crash' analyzer does not rely
 on the ELF PT_NOTEs for CPUs; rather it obtains the information
 directly via kernel symbols and the memory within the vmcore.

(There maybe other vmcore generating and analysis tools that do use
these PT_NOTEs, but 'makedumpfile' and 'crash' seems to be the most
common solution.)

This results in the benefit of having all CPUs described in the
elfcorehdr, and therefore reducing the need to re-generate the
elfcorehdr on CPU changes, at the small expense of an additional
56 bytes per PT_NOTE for not-present-but-possible CPUs.

On systems where kexec_file_load() syscall is utilized, all the above
is valid. On systems where kexec_load() syscall is utilized, there
may be the need for the elfcorehdr to be regenerated once. The reason
being that some archs only populate the 'present' CPUs from the
/sys/devices/system/cpus entries, which the userspace 'kexec' utility
uses to generate the userspace-supplied elfcorehdr. In this situation,
one memory or CPU change will rewrite the elfcorehdr via the
crash_prepare_elf64_headers() function and now all possible CPUs will
be described, just as with kexec_file_load() syscall.

Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index fa918176d46d..7378b501fada 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -364,8 +364,8 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
 	ehdr->e_phentsize = sizeof(Elf64_Phdr);
 
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
+	/* Prepare one phdr of type PT_NOTE for each possible CPU */
+	for_each_possible_cpu(cpu) {
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.31.1

