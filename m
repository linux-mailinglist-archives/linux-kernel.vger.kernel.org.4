Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C49074184D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjF1SxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:53:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37092 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231916AbjF1SxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:53:16 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SGwlru011815;
        Wed, 28 Jun 2023 18:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Nlp/oHypkgqILKUkxsjCRnUeHefJfb6/VFa3Fe0IQP4=;
 b=wEDojz5EXTZD9bYL4oDmK+Z6WGFb+A3H/lYaWc0gt7UOV6qavrq/dwQqz+GP4TWJ2z9/
 im4MwaWaj8UFfo/TJvsSL05l76dRtgEIDitmpbAh7ksD58YPStLAonWbB1Lnu9BFry+u
 CBMvs9eSUK6Wrw5IUJdmKD7W0wqByOh3fQM4XM1czBi630Q+kaeYcy59yDRnFgii1YGW
 7JGHSVfMSg/lQELXhuvghz69cQaC77kvmwVKcisMMOPTf15PrfUZMR0LN+vMDBuGlqIu
 qpUh1qWzCKHZ4REeX0/EQsdqB9GLTWhghrNPxYzavIEcSaQDr1ge6VMXMImYeo8H5kR+ nQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq938me7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SIAF0N019910;
        Wed, 28 Jun 2023 18:52:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxc6cs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRBaetnxKKQp16askjhdKNsw/z5/+vPpD/4818cWZo7tEFkP58IJMuGp4xOJPNoVT06k3YwSZYAS+YwZ0xEuni2umvGCYlnDBsHAoEgvlh6WzYdQo7XW3tWmQi3CH7gS0OeYKvLXXdU5fChUZ7AHYYY1f0uM0x0Y4R9l4CluNm3uHKfNwsksFtg+BSEZMvbp+QUQ6MwhcPZrg0tukBAt7Q4DXLpG9mNKpMgedWJeNXEG1XMSqyGBxH+nEJhNISMugEXii3Jj4I201ibVkc6X11jHaiQcn9B1HaJ/hbHZohR+qDTIsNqxnfV84JuTtXWaK3UTGkcdo5AfMVQ9vmfnJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nlp/oHypkgqILKUkxsjCRnUeHefJfb6/VFa3Fe0IQP4=;
 b=PmNdQ/ThdzVQfNdxP3VWOOeK4j7Ic2xEDc05r2NuFrU0GBn5vp6k245Py+CGbP0mgtzBQx8oZELXQM7xEn3SGLriEtDb9EOG4oOQkI+HLk8PD8z1BlpIiCE+JvYj3slCE4D1yEle/QzpKu0+mwAKNtecTRlItGa3HAwYn6xawxIKM9BnqcwgTyu9hZpWxPiHpYsJAs5rKIiNZVjTP0LCZB9e1S+9QbXaeCb1f8n1RXy4ERlpy/mOxm526/y43GETLziYT0LTsN1N9juFPahVDYxM1EIaNPBJ3HEoz2tFzrhyWYjv4m4Y3mE4gpbWRHxEuW7zJeE5ofcspzsQTcG4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nlp/oHypkgqILKUkxsjCRnUeHefJfb6/VFa3Fe0IQP4=;
 b=GA8eWVcfriY0UOBZC8Lz6w6JmCn78MsjrtwVmoayL7Gz33cLfUqjZA3kykZHn+IHAHjacWQyEQZ4UTbYSbFyvCJuEfefI42/ZCTOu85S2DgP1TDJQtFPoHnoxwqP6v6w6y/fyvd/0k6ffwLK0n1dS2yb/rLk3OotTHF9VK0nADE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by LV3PR10MB7820.namprd10.prod.outlook.com (2603:10b6:408:1b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 18:52:30 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 18:52:30 +0000
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
Subject: [PATCH v24 02/10] drivers/base: refactor memory.c to use .is_visible()
Date:   Wed, 28 Jun 2023 14:52:07 -0400
Message-Id: <20230628185215.40707-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628185215.40707-1-eric.devolder@oracle.com>
References: <20230628185215.40707-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR18CA0026.namprd18.prod.outlook.com
 (2603:10b6:806:f3::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|LV3PR10MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 31af01ab-f988-47d9-40d3-08db7808d343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZY0pl8kacdguKCc6ErHusyUYZHjwavz/+DZ6xiuj4hZ57L6LVnqNLRDjaKgezJcaShFI09xDvPAJisV6j7cBfWS/2GoxK6OeVNeceTHxhIyivKceicC6/2vOHjD5x9yLRspRRNbTeZl/iixzTZbpY7LWrRHjsPMVimHbsRiwaee24nG5clyMeAxCgYP06GGY6vD8OJXPc+HR+KHHG62aov4+HtIzGe2w+elgTQEyqeDY3Z0GfVr/tngs1gkX12F9km/2GLvGLva4xi8/mch/QeHvVAdN8AQPa6IDwOt/SYOpWY7T6Tq+ib78tWWb9YONCVEJfwJYn2foOzGyApUHvwJhs6lMMYydrbz5rXVOfqyTbZcEMp3fG7RH+5hreC42AOzLXf/1+UmJKncvVEwYa9dTazYPhgYVEck9hOU1KXLcZxCAYZY67COu3fp9JdkJwBY/Tz8Ekq+3mqiOvMRUdyp2xE9+t4KnvbzHNWdU3ejGnyJwrsDe1d9bih/iSqfnzhwcJQGfdqvQblQ/pmEz2pA7xyE3Ua64ncwFQ3peGaUP+qZ6PlJ+Qbpuf0rqj0GgPK7gTnybOwNsTx1whgj3ZI/PNC7Nvl4m0c+XJwLWWs0HpM6OUea0MO74wVd5dw6S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199021)(2906002)(83380400001)(316002)(26005)(6506007)(6512007)(1076003)(6666004)(6486002)(186003)(478600001)(86362001)(107886003)(921005)(2616005)(66476007)(41300700001)(8936002)(7406005)(7416002)(4326008)(66556008)(66946007)(8676002)(36756003)(38100700002)(5660300002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?34tY1uLMlIKWQ3svrmqUzGTts3kIr6IrckEWIAw6shL6QMPzHCpSnT1aC+kD?=
 =?us-ascii?Q?v+0WNuhJ29rbGHerWR1sVb9Pxbji0ZAxMVb4zgP22VUhAiEy6uPXVF9AaB/J?=
 =?us-ascii?Q?c1DErMz1z8pJQmBH/Ur6CioYDq6OpQ6SpTYQwy+yus2xhtH8ltY4NQbFq/UO?=
 =?us-ascii?Q?KZx3TgOASORncOFs2AKCT7aSA7QDNtgIFhkD0u8wZr7q1/zPK+bQqmPUQTEu?=
 =?us-ascii?Q?4SzeFTsZRH83ltP+FlA5GnE8qmVApa6QdeFSu8X7ZXpr2CKZSQAVACw6Q+T1?=
 =?us-ascii?Q?OTPsNnwHt5HosKoV177bLtCFaDWTmNpZqVrp5sEAwxV4PTolJm6KGB5VLRHz?=
 =?us-ascii?Q?6QVtVByYS3S484lcpHgFWf5tNA2c41GaPqlphPWfvdayW/ZZOaSzZy5JYcOv?=
 =?us-ascii?Q?E7S3Pf/zoXPxk7zlo2vn5aP0o7tHzh4HzLuoSGKMkSgbjd1q+4o6U0VoR66l?=
 =?us-ascii?Q?VnD5gU0bBvGzyu43sqaIgELSddqxWR6sHlUuQWjcJ3bs0U72AiJO3oAei53R?=
 =?us-ascii?Q?UCMZs2r6thHb4SuUzASXNFv/8dADj38/uYUdx8pEFmNiMxXLFVSPv3aqKLlL?=
 =?us-ascii?Q?jm5hYxP3Ua76Dx7RRTl0GVIb4cCJ9BdJhTH4/YqjV5Irxrs9GCqvkM7GkDOR?=
 =?us-ascii?Q?/bkl1SRCgJS3HOugh87a8nMqVKv9sCsHX/7Bngwo0FOxJOLTAVj3XyPZ/6Mg?=
 =?us-ascii?Q?hXS/WQJ66loqQ0VuxVikv2J+1Cn92ZJ+yZUsPYdL0zSmeGewVA2gOxMvGjAX?=
 =?us-ascii?Q?d7ZDcy4ETd5vrG5LXpvN+wpJFS7t05hDks2aRk1y3Xt8mLcPCU/oJjsTt9Zm?=
 =?us-ascii?Q?5LERFK0OASpQeh7yD4V/ZPKIQ+Cw9PkT4++9/gIwpbkVDFYi1wpSitjxH4l1?=
 =?us-ascii?Q?TifTBPtMxsdJQnfng1qc9wsty80CD5tUnshbW50OBQGsMwn7yvytwVSB762c?=
 =?us-ascii?Q?F5G6V5+4l5KY1Y57ZZ2Ztdccj8umU/dtyURlVUmbNeQmQldOkM50hGi0R0oe?=
 =?us-ascii?Q?kRzFutLh8qnUhknXZIelDffGG1DWlKiRRQ2Mr8N24v2MJ86vDiuzzx0LfKUb?=
 =?us-ascii?Q?E77nI6bJwhutfUnchVw2PqsNTivkEhGZq5lNWutcx7kXrCA1K4NCJ/Rj13Y+?=
 =?us-ascii?Q?EFoz+Tgs8WYvCpXhvJWHrM8C3rtLXweFqdWzVDqxS61908coGAU2JfrGCGHs?=
 =?us-ascii?Q?Ie+PHEI0EyrgH6GehgeyxERupoDLVq/lDT7O/e6h+p4X0hpth4XTyBUqg5ru?=
 =?us-ascii?Q?IojonurCNIYqfZrlFK4L1JjxAmD36urVogCUerlNvIiajWBv9hW1q5Xhtq44?=
 =?us-ascii?Q?+0LXEpZ2rQwf3no+fb30+R/ae2vP8G+PHkm7bzRRDmHZoBfbL89dakCy0gx5?=
 =?us-ascii?Q?F7TEcvjsNxUBBEqKOe4XNF9zmdHCEGjjoFwGSMqz7JFUIt0h4dtysfvZLYEX?=
 =?us-ascii?Q?lSPpMs6Hffkg7NpXyHBiWxta+03IOoCw9XCl40AAYyElachV3v9YlFBGNDnn?=
 =?us-ascii?Q?q+G8q/VKoL7fz4biKmGeZ4ddcpL5zMQolhxGHVZIOkgix2QBS5MtbBS1Pd9Y?=
 =?us-ascii?Q?MIG2fg7jm5/7Mv+CNetVqSnzisxgDzq2/B6N1iZFDZCRt1F+7JJZ/OkYOD6/?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?URtZn70u93EDMt5K8iBYG9b1i6pKmF4dtfdHn4qbRrWGH596NgTZX5R/gWoZ?=
 =?us-ascii?Q?viPm1EViYVYpBzI1RaqQYpJz91gZ5D3V234gYFeKLZmcpD8G33vqMs/YRVit?=
 =?us-ascii?Q?7yMutp7gDANazLxUSoUb4xfuBvuqDiBwyLXYAqzQY7mGqeqSzx2l9oDgZmK1?=
 =?us-ascii?Q?VB1l+QHU2DxepZgXbQqk+T3tYpFPigo0UYNkl+xQj+JnJJp7lto1+j4SxKg1?=
 =?us-ascii?Q?jAgM/1fj4nC976nnsAEs1juXE0vVHzRvTkKFvwqPx1U5IxuEvh8CaifU5u8L?=
 =?us-ascii?Q?JMZnZ9wmcoxHLcFTQ4sgl93a3nLlPmrn5a9WoCFvXbXNx+F76/tkUOvltj4v?=
 =?us-ascii?Q?DGhW+wuioonHzbzhOvx+AxQI8xzl9gRSwsqJwn6IEaVDOFWcVZPtwuQdrdCh?=
 =?us-ascii?Q?jkOO1idhkywra0toY11LmT2V1rAlVIOIn7AO5DGSbT4vGMD5Glyn9Ph6dLgF?=
 =?us-ascii?Q?7MIbnKTA403iZZ0x5y1YWHnq905dLe4sgcj/MaPK9iB9TdqewM5pAZVFIZM/?=
 =?us-ascii?Q?UmRPm1yJd3TbdFBojtj/nV+G3nHGTfWZbgsXXCGJ3Nz0HJ4wz7TBCx+HnRun?=
 =?us-ascii?Q?BOnN4Ym/5N95hCaaunuPYyk19MDU1RiMHrrm7eeZQXwrha7yiZhmLNZirFhD?=
 =?us-ascii?Q?fx3+o4mK5L42Q8MnJL4490zyMwF8IgxJgXuaZvtv97rxi30zziNp674ScjaT?=
 =?us-ascii?Q?PbKP6nA4imTYr/PPl1OuRDJxojNdEUaJek4JPhBzh4zoJJzeOgM63RCTHejl?=
 =?us-ascii?Q?soOxt1wJiJjgR4SUreydr4k9c3hLqjZWD1IQmEJ5OMpjmPRdPEuvOTlth5rs?=
 =?us-ascii?Q?cGTrHhN+QvUJtCXS37xXHAx9SwDA1V85ITsl368sy25u9mq/6wFOMRjysbvW?=
 =?us-ascii?Q?vjqH4DDXlnvFg6CPp5DwpaTptDL5AjhG2v8lXjATcfzGOiJczyFNu43tVjhY?=
 =?us-ascii?Q?gOjuV8Swz6EoIW2kajMZ73Y4Lei7TOCkD+aZmQyLvTAjtEV1hu5ogC2iHbIJ?=
 =?us-ascii?Q?6Wn9nHA+mbjRStffmXGo3PVjhVlWQ6hnvXXxfvjA1HV26FZwERkvviiqyNaD?=
 =?us-ascii?Q?jDSLvN/7OLY2FPC1P/odxSVyCwjFC2+N55G8UQ4WqdHwhNTNsN5V72J9x9wp?=
 =?us-ascii?Q?dlcK5E3ycuBRqabwMnU2CBOsyjLNMRf1mD6zD77OGRBG+hmYDmDRPzi/WD7e?=
 =?us-ascii?Q?8Za7tKIqUIAxk/WHhF4nGNtSrg32cR3ZZeKmLTrVRRoYb+8gtFhPk8P9bUKv?=
 =?us-ascii?Q?abi74hr2KlY9dETN5YAx+yNosvOROcPZU0vkDAwGFLDVPhJuuY8T+6ArvHpT?=
 =?us-ascii?Q?MUCoA8LZz61YOnqVYGOKgGx5+ZKPLZ2WPalUfL4UQ0FO/fvuwopj7LEOQNPu?=
 =?us-ascii?Q?7viUZgpfcNinSxnWSXc6HQyr51Iv9YpK0LleEYbquRnRC4jSNmOtHUAggD4U?=
 =?us-ascii?Q?qpMgUGqr7tM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31af01ab-f988-47d9-40d3-08db7808d343
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:52:30.4452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeboyiBjZ05uQafzkaxyon6u7g6sRF5T2XOSWdWAc21AAb1JcyA8UGYQv67XOHBXUCXBEJhne9hRm6zj+jYIHuNh2/3K5WBsTh/QqdmXCgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_13,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280168
X-Proofpoint-ORIG-GUID: Z38sp8V1JUnGnibKTkDYpu9lWibXkn8Q
X-Proofpoint-GUID: Z38sp8V1JUnGnibKTkDYpu9lWibXkn8Q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman requested that this file use the .is_visible()
method instead of #ifdefs for the attributes in memory.c.

 static struct attribute *memory_memblk_attrs[] = {
     &dev_attr_phys_index.attr,
     &dev_attr_state.attr,
     &dev_attr_phys_device.attr,
     &dev_attr_removable.attr,
 #ifdef CONFIG_MEMORY_HOTREMOVE
     &dev_attr_valid_zones.attr,
 #endif
     NULL
 };

and

 static struct attribute *memory_root_attrs[] = {
 #ifdef CONFIG_ARCH_MEMORY_PROBE
     &dev_attr_probe.attr,
 #endif

 #ifdef CONFIG_MEMORY_FAILURE
     &dev_attr_soft_offline_page.attr,
     &dev_attr_hard_offline_page.attr,
 #endif

     &dev_attr_block_size_bytes.attr,
     &dev_attr_auto_online_blocks.attr,
     NULL
 };

To that end:
 - the .is_visible() method is implemented, and IS_ENABLED(), rather
   than #ifdef, is used to determine the visibility of the attribute.
 - the DEVICE_ATTR_xx() attributes are moved outside of #ifdefs, so that
   those structs are always present for the memory_memblk_attrs[] and
   memory_root_attrs[].
 - the #ifdefs guarding the attributes in the memory_memblk_attrs[] and
   memory_root_attrs[] are moved to the corresponding callback function;
   as the callback function must exist now that the attribute is always
   compiled-in (though not necessarily visible).

No functionality change intended.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 drivers/base/memory.c | 78 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 13 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index b456ac213610..f03eda7e1c9c 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -405,10 +405,12 @@ static int print_allowed_zone(char *buf, int len, int nid,
 
 	return sysfs_emit_at(buf, len, " %s", zone->name);
 }
+#endif
 
 static ssize_t valid_zones_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
+#ifdef CONFIG_MEMORY_HOTREMOVE
 	struct memory_block *mem = to_memory_block(dev);
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
@@ -444,9 +446,11 @@ static ssize_t valid_zones_show(struct device *dev,
 out:
 	len += sysfs_emit_at(buf, len, "\n");
 	return len;
+#else
+	return 0;
+#endif
 }
 static DEVICE_ATTR_RO(valid_zones);
-#endif
 
 static DEVICE_ATTR_RO(phys_index);
 static DEVICE_ATTR_RW(state);
@@ -496,10 +500,10 @@ static DEVICE_ATTR_RW(auto_online_blocks);
  * as well as ppc64 will do all of their discovery in userspace
  * and will require this interface.
  */
-#ifdef CONFIG_ARCH_MEMORY_PROBE
 static ssize_t probe_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
+#ifdef CONFIG_ARCH_MEMORY_PROBE
 	u64 phys_addr;
 	int nid, ret;
 	unsigned long pages_per_block = PAGES_PER_SECTION * sections_per_block;
@@ -527,12 +531,13 @@ static ssize_t probe_store(struct device *dev, struct device_attribute *attr,
 out:
 	unlock_device_hotplug();
 	return ret;
+#else
+	return 0;
+#endif
 }
 
 static DEVICE_ATTR_WO(probe);
-#endif
 
-#ifdef CONFIG_MEMORY_FAILURE
 /*
  * Support for offlining pages of memory
  */
@@ -542,6 +547,7 @@ static ssize_t soft_offline_page_store(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t count)
 {
+#ifdef CONFIG_MEMORY_FAILURE
 	int ret;
 	u64 pfn;
 	if (!capable(CAP_SYS_ADMIN))
@@ -551,6 +557,9 @@ static ssize_t soft_offline_page_store(struct device *dev,
 	pfn >>= PAGE_SHIFT;
 	ret = soft_offline_page(pfn, 0);
 	return ret == 0 ? count : ret;
+#else
+	return 0;
+#endif
 }
 
 /* Forcibly offline a page, including killing processes. */
@@ -558,6 +567,7 @@ static ssize_t hard_offline_page_store(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t count)
 {
+#ifdef CONFIG_MEMORY_FAILURE
 	int ret;
 	u64 pfn;
 	if (!capable(CAP_SYS_ADMIN))
@@ -569,11 +579,13 @@ static ssize_t hard_offline_page_store(struct device *dev,
 	if (ret == -EOPNOTSUPP)
 		ret = 0;
 	return ret ? ret : count;
+#else
+	return 0;
+#endif
 }
 
 static DEVICE_ATTR_WO(soft_offline_page);
 static DEVICE_ATTR_WO(hard_offline_page);
-#endif
 
 /* See phys_device_show(). */
 int __weak arch_get_memory_phys_device(unsigned long start_pfn)
@@ -611,14 +623,35 @@ static struct attribute *memory_memblk_attrs[] = {
 	&dev_attr_state.attr,
 	&dev_attr_phys_device.attr,
 	&dev_attr_removable.attr,
-#ifdef CONFIG_MEMORY_HOTREMOVE
 	&dev_attr_valid_zones.attr,
-#endif
 	NULL
 };
 
+static umode_t
+memory_memblk_attr_is_visible(struct kobject *kobj,
+			       struct attribute *attr, int unused)
+{
+	umode_t mode = attr->mode;
+
+	if (attr == &dev_attr_phys_index.attr)
+		return mode;
+	if (attr == &dev_attr_state.attr)
+		return mode;
+	if (attr == &dev_attr_phys_device.attr)
+		return mode;
+	if (attr == &dev_attr_removable.attr)
+		return mode;
+	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE)) {
+		if (attr == &dev_attr_valid_zones.attr)
+			return mode;
+	}
+
+	return 0;
+}
+
 static const struct attribute_group memory_memblk_attr_group = {
 	.attrs = memory_memblk_attrs,
+	.is_visible = memory_memblk_attr_is_visible,
 };
 
 static const struct attribute_group *memory_memblk_attr_groups[] = {
@@ -878,22 +911,41 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
 }
 
 static struct attribute *memory_root_attrs[] = {
-#ifdef CONFIG_ARCH_MEMORY_PROBE
 	&dev_attr_probe.attr,
-#endif
-
-#ifdef CONFIG_MEMORY_FAILURE
 	&dev_attr_soft_offline_page.attr,
 	&dev_attr_hard_offline_page.attr,
-#endif
-
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
 	NULL
 };
 
+static umode_t
+memory_root_attr_is_visible(struct kobject *kobj,
+			       struct attribute *attr, int unused)
+{
+	umode_t mode = attr->mode;
+
+	if (IS_ENABLED(CONFIG_ARCH_MEMORY_PROBE)) {
+		if (attr == &dev_attr_probe.attr)
+			return mode;
+	}
+	if (IS_ENABLED(CONFIG_MEMORY_FAILURE)) {
+		if (attr == &dev_attr_soft_offline_page.attr)
+			return mode;
+		if (attr == &dev_attr_hard_offline_page.attr)
+			return mode;
+	}
+	if (attr == &dev_attr_block_size_bytes.attr)
+		return mode;
+	if (attr == &dev_attr_auto_online_blocks.attr)
+		return mode;
+
+	return 0;
+}
+
 static const struct attribute_group memory_root_attr_group = {
 	.attrs = memory_root_attrs,
+	.is_visible = memory_root_attr_is_visible,
 };
 
 static const struct attribute_group *memory_root_attr_groups[] = {
-- 
2.31.1

