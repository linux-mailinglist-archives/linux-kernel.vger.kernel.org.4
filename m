Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545C474185E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjF1Sx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:53:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39670 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231522AbjF1SxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:53:17 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SGwmDI002032;
        Wed, 28 Jun 2023 18:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=4JLI7/JunPAOiUTOIZei3N9WOAFJGTtHQ2DxGwPOSkk=;
 b=hnG+PxYLB5svitMuKtsT3iwWyqgDxb/rCPg1cS5LSuolv5TkqaJznLvMCjxwcv2A6GgM
 xLds+n0L2993GI1PNYgol/qYLlmp4BNhO8uLhxoM2Oq9WIJgPxMDOOh313Fl77QfUPQq
 52+byu/0Lo+BX2T9YDvQY5MBrOod585u5iP7iuzzjkw3UK3/0BNhscRaSXuCYsruR4vf
 GM49LTlijsgFlin34/KVmx0D82Cc0lQNDh9Mf/XCnYpFmw6626agiN2JqHe7CXCPfXWW
 hBVQoOxBFflrq0BZRCjikOFcUu6X/mn13SldJVetnnVysldKHIbhumfqLgeNbEhpI5cx Jg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40e6use-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SHZ3Vt008634;
        Wed, 28 Jun 2023 18:52:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx6dhrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+3zmGr4+BJSzJRsA5SMyCoMw6u64H8f2rJdGYRJCddMiGo9wt0iP53OGCfJLQjczuSGoh6mDBPe4Opi0Vjw3gbP2cHdhgImnLL/NPuUSjsF4UK9eTn35z9vHvBMW27Dx5NbcaTI3A3GPtjcnoZBgXWEjphAkeuZK0MoBCSu3kYb8JpNBuu544TB5L/CfKQVg2DircPaoE4Vn0I/aUiRHEEHqkgTRG3hilRY7fco6AEj9oDYbkrBGGcuFAncV7NttjKtxXoNjVHfpmY+pnn7PxSpwIoColjZPTLynI+fwKefmHCvD0faCupbfU1UHnQbgWBmNH/R2EraTMtHLRN0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JLI7/JunPAOiUTOIZei3N9WOAFJGTtHQ2DxGwPOSkk=;
 b=Nm8sLvo5eOcf8FRh9lxKzgPUs7iM/0OwLWyU0+l372kU8Tg0XH3FW38ib4OMXsbkABuwBAc9yymE9JP9+5YHw1utetfrdaWdvVTi3fDSMgDjYL97J3q7H8uyiX8VYRUL7OcUQ4iZj1zfKjJ3TuRYfjVzQRz80wkLvjM5b092U2NqEXOPr/aYJJ+HRq4iH8GNVZ2abnQ305+tNRtabS5z4c44lszUucGVUvNGkHHk+LAnDap8Fw/JgPuP7c1DTWvoMLaRnT4BCWRtnjZSDheK8Z9NySYVQQ3Nx5FkvU+DwDoWDqSuwOcfV1ENGvXKfUSvwXtSNlcfeKRduHhZeCz9hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JLI7/JunPAOiUTOIZei3N9WOAFJGTtHQ2DxGwPOSkk=;
 b=zyD8Waiocr7eBORT8yYjHqDqu3j6wgL9vJh1QrYb1owm4LkoBAXDSj8ZyZEa4rufDnjkMKnXFWOA51I7YBhVslnkAf+asE05zG5/V9s1jNg5ZJCsAkrtKC1rT5bj2Boir6AKWuZtxKjB7beWuWe4BCuDsbhGS2fIfPqjjLklTgk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by LV3PR10MB7820.namprd10.prod.outlook.com (2603:10b6:408:1b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 18:52:33 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 18:52:32 +0000
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
Subject: [PATCH v24 03/10] crash: move a few code bits to setup support of crash hotplug
Date:   Wed, 28 Jun 2023 14:52:08 -0400
Message-Id: <20230628185215.40707-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628185215.40707-1-eric.devolder@oracle.com>
References: <20230628185215.40707-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR18CA0012.namprd18.prod.outlook.com
 (2603:10b6:806:f3::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|LV3PR10MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 8872453b-d0a2-44cb-6b2d-08db7808d4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2KAFW1ta+sTSRu+3X/fLWDlAM0i1jTD2zV8Ruul/dkW4YhHKl/MtCmddx84DkC8PBnRc+R4AYD5iqlRA8INU+GL7M5uAVz+GMwrvpyyC5mzJvWC+ngihNs8uQn+8ZZJcNv8hwjiJUzx6KPWb0iqMAexL309axAPOSmS0h6Wx4C21niOWDQYAj2iiTKJJRpjhaXk9+ZwY6GUxH3P4zS14wOzCOFTUtxEUIre44kLaK66ghTzj9ii+321uU5mVCW4/E4IzRtdwqkw4FqrnQkz1DEKi88iiTGbruEcVNrrRkT6cec3arovq397knoPa27SiW7FyY/xzk8qAS5ciPHmiJZIpv3uxw85/MoCWl4Pyl0jcMNRTPfZUeN/+M/hhgDuFZR5+dJiwMpmLxOJeWqvUtEw0ZmcZneCk9wgb6sk7ahnvTAFQmwziW4Ftn2kvfJqInGEcpP+3/WanPUGPSlj/SY9oOgSzvCIN8AxZJhG2OC/bsm41D6zrXWfvqB+pVtC3kpcdCNqkD1bObmp/FiIi3wJCGVoCCD4kGJn75YB64nWveRY4W4EKwDtM62qkYBJQuJxPjXGjRDsHqsQkcrCKG9TlsnVLWx9JPvI8wPN1p1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199021)(2906002)(83380400001)(316002)(30864003)(26005)(6506007)(6512007)(1076003)(6666004)(6486002)(186003)(478600001)(86362001)(107886003)(921005)(2616005)(66476007)(41300700001)(8936002)(7406005)(7416002)(4326008)(66556008)(66946007)(8676002)(36756003)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7LnFo3cB54DcdJnHiiA1fiBXsgeHJOMewKdoXLcvK2iLHnbar/HRD3qYAcx8?=
 =?us-ascii?Q?Howx+I/4Hb2BUKCA99xfI53V99ENbX/x89zE1jZkRlvziHKII2bO0xO9M/ui?=
 =?us-ascii?Q?n8pDWoyjsZH7H7qnU42truymlCi5j1rNaT+RMTaEd6xXYPtQBwu8ggbDYe/V?=
 =?us-ascii?Q?X6W4gicSX+jS4kNou4kpaveWP2WYDmLqiGVsW6hlj9GUChYG4KzpxUayfR8b?=
 =?us-ascii?Q?79ZMj0thM+/uJ0EXP+/zEUtYJFY15FB9nGgKZ5MTTCbbXVAWjtSGhDQgqPtC?=
 =?us-ascii?Q?hvalP0HaAjPfdF3P2IkBLJSmXQtQrcokYwfC/FC8q6zimRWKQCi4uO5a5RVm?=
 =?us-ascii?Q?Fz3hXKP3toDuea/H6GctxIYMHYlu+i1yIP8izZj5xkNirEHtYEffPWXx3yPV?=
 =?us-ascii?Q?doeWuLSKi5w0s0igdBxdJ1Ikq/AREB2ixjlt3iU+EhoUe9z1MmUwu1faOk8n?=
 =?us-ascii?Q?U9fZpqR27P7R5HmJEDDZK81iEbpVxzm1VU7VnWTDBtR92Z4jtTvqRMdVx5Y5?=
 =?us-ascii?Q?o/nIeYslyvYh2gvf2s/+TVqxeepCPFjdyrAV4cmwdB92NtGL4FKjLiGVm6+J?=
 =?us-ascii?Q?wCEc/nQ5Y1L3f8FbMIJAYCA6vP3HFO+zIld/RReKLjmm0EoyPgRNVsnlz7B2?=
 =?us-ascii?Q?tw9YdDQslH28pNKR4OKHRi/Ke6QTz1kYBfPnz6Nf3C7YSgTfdOswzJ/R8EhK?=
 =?us-ascii?Q?Lrk9dMf5thiZcVnqh93A9TyBVz93h7T0fwya5TDn+kWEmX0nLboseQKkdQ+r?=
 =?us-ascii?Q?ZKV8u/s+X5ENsHaUS+PufZ+7pNWrC8rPm1NaxJr6QHJKrK00odcugGUD0bOp?=
 =?us-ascii?Q?44VlcbFVROOcz0hNnrQp9q0BNGEUUyURMMTdAUfGN2+qLns9+dzVYICw2wld?=
 =?us-ascii?Q?gfcIHJ1o/JeSL+Iftkl06qwVgFsLNIHIXIGXSys+zV41D/Jti8j8QbzwFbIi?=
 =?us-ascii?Q?YlekH0w0xF+px631nvqIIw7ha/JlgAZSNSBk5KIWSRHVVHhUSrIOnJvpaRri?=
 =?us-ascii?Q?B66Ry2hhBtKfPwpLR26aAFCVG08Fs7XOmI/jy0aBzbf8mZNhm2snK+0cP54Z?=
 =?us-ascii?Q?boWigpAHBemweBkXYMXO4ldMEg6auHNG+Q/prjJtWDFXjA8Hcy+r8QydRr3B?=
 =?us-ascii?Q?6uwBGI/wmHe5h2gkrZ4EFfT4lM3CgUD6N9Kg5oliD408mXIzv12dC2vpNUOq?=
 =?us-ascii?Q?rgtPgKhnw+0Ze5fdChZSL9TCKwgdvlz4lEeSS/7MiMUmVagEGv1jdduPcBWv?=
 =?us-ascii?Q?ir9UkZe9Jx4tja1u1htrds+f5iV9TjnDIjretrT9BLWC9mHw4DX3DmoQfiG7?=
 =?us-ascii?Q?P65PIoCLXlJqQUE5O43qdUcWGKzNGY+ojOdhkhwigm2L4I+ungDWizswbrOm?=
 =?us-ascii?Q?9zZq9CUEvIUJvyyFlhJ2O7+FukdZszvvkfLhOrLYR143+VCxb9mZieoRyuYQ?=
 =?us-ascii?Q?8EZPd6pekOV0xIVNMd9kvpDmoWktbywWtFewaRtg7WPuwoYza5iFKw06XPDu?=
 =?us-ascii?Q?/RWjc3YxeTOx12xtOlbNwR0CHWjIngD5f+xozr4IuUzSfvcfzWu/T+5He4Vc?=
 =?us-ascii?Q?Ut5Zep6LE3hifLwf+PfRq9df9idd10vmxkkZ+vdVXAch0cCUsR3T57wo4A9I?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Ml3VpvlL28HBaRLSZuE3fywwElEgjVoJb01ZDm+ji2GfBCxx4HSL05KvvzWL?=
 =?us-ascii?Q?400dCIGWAhD6nqk5GnlDeZQzbvEPAWePT7zX8pLl/Z1O52oYrRa85EKIR/Dq?=
 =?us-ascii?Q?d9NNQADPQybB98w37e8YORkj0KwpX/pERQZ+NOsIpu/ZYxR8DdP2fwQ3Qufb?=
 =?us-ascii?Q?D5oFcSo/qgyCsltB9VNUkez3qGCMy2BN+zh+x7PNzTN1eeFEnsUBWxS9svyQ?=
 =?us-ascii?Q?+GfmovlD6HnkvfB79fR/gvewfGlCeT0UX113+72MOobaKQ9PpGo+9d0sSbsg?=
 =?us-ascii?Q?HekbLJz2VcCZ/4RK9z5he+p43Mn+NtMWk3kuyPzXSUBHkDWHm9W8hvOFxr+c?=
 =?us-ascii?Q?7x4P7By53Dr6Rx2fyxo3QqtSSZOstrOXQ6f55r1EFzPDhiOErN0LxlD1clmy?=
 =?us-ascii?Q?2bdKW7uTRai1/FonfgXDpFAkXYMTyp/ZxD0Mxk+TG2EGkzmfp9WjhP9dGV5y?=
 =?us-ascii?Q?q15h8YlGKgyHgbNcI6bXAx5RibBUPKTJJhNzfKy30BO+KFu8Rb1QTaaqNCWU?=
 =?us-ascii?Q?H88WBw/W8XynV4isXqWBvZHwc2x91OUc7extlO1hvZHkrIJmDNWQMEvhAn5l?=
 =?us-ascii?Q?4LJKUWFc+VmBs8GfpDS2lPVWZJHLSeuJPT4hDSUVZN9En+K18Iv0g10cblhe?=
 =?us-ascii?Q?ttaG7ZGIvydH6bTQGMFW4sqU+dKp17fyX03PIpAWiXOHuajh6q4rA7bNRZbZ?=
 =?us-ascii?Q?jadh2W3sV2Zhf9/qeD79OYCHBZM3dhGh7+FqtGd74BJRusG+HqNettG8mgYP?=
 =?us-ascii?Q?veGUjZW6yCooocOxWgHhQ0YEu2T+6l51z4S/0EpDSJPEREWQu5rAWHbG6498?=
 =?us-ascii?Q?s/ULzfOLbSbhMLDT/CAD9Gtd8Df8NvwSw9KfIqv2D2eFq+xw/E0kd3L/rA8J?=
 =?us-ascii?Q?dlP6cdhSJPNzE5PzTlG/5Kh0O92Z/L0Zrci0P8M63RWxMY+Zeb8ApWRTZzc5?=
 =?us-ascii?Q?0yKmnioT+y0XPYEETAQJMmvbzoAAXBg3t2Pe+UMLc5gL7dMeFojrEmcQeay4?=
 =?us-ascii?Q?4DoBgLadSwTZTxXwQFp5AncJUG/1SfxN0ZpSU9BaUu8T+nYLvRd6Hw0xYvA9?=
 =?us-ascii?Q?YG9cDnH/+lmVaeQ/UA+py5M35Fptow3Ia+Y/w8t/1otQTI3RxPcDKvpJPZx8?=
 =?us-ascii?Q?xdEGG2DlzdJ+Js8T2MiJwCvkxKTi5BmLHgNdTaartILxCiye9tXj7S3s6cm1?=
 =?us-ascii?Q?AIO8FYgyeM3qE2sH8A5Jsw5p32IlOmDfW80eXVynTQsQQaCaMjZ6uPMnEsLl?=
 =?us-ascii?Q?0uSLT7dA55Z4S5r+/uRV+JhWsls3wfdvUvYOcJWpV+P5zTAYVxDBEdErEEVH?=
 =?us-ascii?Q?SD+mA5wkkA9uq0l4uobZLl0VAFNPEpsyGmIokhddQjGyTMH4nmMxi0wRA5D0?=
 =?us-ascii?Q?aBgWmF6BsYL4S+oECaQkvFSdxzw+nSTcJHQkYADUFwQfgQXRyaqQV9AHy82G?=
 =?us-ascii?Q?G36C0P/52Hk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8872453b-d0a2-44cb-6b2d-08db7808d4c5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:52:32.9536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX1fCev4dlCmw1kiCCtfYcfQBPaI3blcY0liHLSMRbowgiKjcsCfviXKMTQ2FmQ1npcPNQYEAQilai+hRh6mcRzTNcfAXjNRd8BqZL0E2NQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_13,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280168
X-Proofpoint-GUID: GD2Zt6Tz8fNfjiZBbm3A8mxycceacrA7
X-Proofpoint-ORIG-GUID: GD2Zt6Tz8fNfjiZBbm3A8mxycceacrA7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crash hotplug support leans on the work for the kexec_file_load()
syscall. To also support the kexec_load() syscall, a few bits of code
need to be move outside of CONFIG_KEXEC_FILE. As such, these bits are
moved out of kexec_file.c and into a common location crash_core.c.

No functionality change intended.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h |  30 +++----
 kernel/crash_core.c   | 182 ++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c   | 181 -----------------------------------------
 3 files changed, 197 insertions(+), 196 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 22b5cd24f581..811a90e09698 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -105,6 +105,21 @@ struct compat_kexec_segment {
 };
 #endif
 
+/* Alignment required for elf header segment */
+#define ELF_CORE_HEADER_ALIGN   4096
+
+struct crash_mem {
+	unsigned int max_nr_ranges;
+	unsigned int nr_ranges;
+	struct range ranges[];
+};
+
+extern int crash_exclude_mem_range(struct crash_mem *mem,
+				   unsigned long long mstart,
+				   unsigned long long mend);
+extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+				       void **addr, unsigned long *sz);
+
 #ifdef CONFIG_KEXEC_FILE
 struct purgatory_info {
 	/*
@@ -230,21 +245,6 @@ static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
 }
 #endif
 
-/* Alignment required for elf header segment */
-#define ELF_CORE_HEADER_ALIGN   4096
-
-struct crash_mem {
-	unsigned int max_nr_ranges;
-	unsigned int nr_ranges;
-	struct range ranges[];
-};
-
-extern int crash_exclude_mem_range(struct crash_mem *mem,
-				   unsigned long long mstart,
-				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
-
 #ifndef arch_kexec_apply_relocations_add
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 90ce1dfd591c..b7c30b748a16 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,6 +10,7 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -314,6 +315,187 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+			  void **addr, unsigned long *sz)
+{
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
+	unsigned char *buf;
+	unsigned int cpu, i;
+	unsigned long long notes_addr;
+	unsigned long mstart, mend;
+
+	/* extra phdr for vmcoreinfo ELF note */
+	nr_phdr = nr_cpus + 1;
+	nr_phdr += mem->nr_ranges;
+
+	/*
+	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
+	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
+	 * I think this is required by tools like gdb. So same physical
+	 * memory will be mapped in two ELF headers. One will contain kernel
+	 * text virtual addresses and other will have __va(physical) addresses.
+	 */
+
+	nr_phdr++;
+	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
+
+	buf = vzalloc(elf_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_phoff = sizeof(Elf64_Ehdr);
+	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
+	ehdr->e_phentsize = sizeof(Elf64_Phdr);
+
+	/* Prepare one phdr of type PT_NOTE for each present CPU */
+	for_each_present_cpu(cpu) {
+		phdr->p_type = PT_NOTE;
+		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		phdr->p_offset = phdr->p_paddr = notes_addr;
+		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
+		(ehdr->e_phnum)++;
+		phdr++;
+	}
+
+	/* Prepare one PT_NOTE header for vmcoreinfo */
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
+	(ehdr->e_phnum)++;
+	phdr++;
+
+	/* Prepare PT_LOAD type program header for kernel text region */
+	if (need_kernel_map) {
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (unsigned long) _text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		ehdr->e_phnum++;
+		phdr++;
+	}
+
+	/* Go through all the ranges in mem->ranges[] and prepare phdr */
+	for (i = 0; i < mem->nr_ranges; i++) {
+		mstart = mem->ranges[i].start;
+		mend = mem->ranges[i].end;
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
+	}
+
+	*addr = buf;
+	*sz = elf_sz;
+	return 0;
+}
+
+int crash_exclude_mem_range(struct crash_mem *mem,
+			    unsigned long long mstart, unsigned long long mend)
+{
+	int i, j;
+	unsigned long long start, end, p_start, p_end;
+	struct range temp_range = {0, 0};
+
+	for (i = 0; i < mem->nr_ranges; i++) {
+		start = mem->ranges[i].start;
+		end = mem->ranges[i].end;
+		p_start = mstart;
+		p_end = mend;
+
+		if (mstart > end || mend < start)
+			continue;
+
+		/* Truncate any area outside of range */
+		if (mstart < start)
+			p_start = start;
+		if (mend > end)
+			p_end = end;
+
+		/* Found completely overlapping range */
+		if (p_start == start && p_end == end) {
+			mem->ranges[i].start = 0;
+			mem->ranges[i].end = 0;
+			if (i < mem->nr_ranges - 1) {
+				/* Shift rest of the ranges to left */
+				for (j = i; j < mem->nr_ranges - 1; j++) {
+					mem->ranges[j].start =
+						mem->ranges[j+1].start;
+					mem->ranges[j].end =
+							mem->ranges[j+1].end;
+				}
+
+				/*
+				 * Continue to check if there are another overlapping ranges
+				 * from the current position because of shifting the above
+				 * mem ranges.
+				 */
+				i--;
+				mem->nr_ranges--;
+				continue;
+			}
+			mem->nr_ranges--;
+			return 0;
+		}
+
+		if (p_start > start && p_end < end) {
+			/* Split original range */
+			mem->ranges[i].end = p_start - 1;
+			temp_range.start = p_end + 1;
+			temp_range.end = end;
+		} else if (p_start != start)
+			mem->ranges[i].end = p_start - 1;
+		else
+			mem->ranges[i].start = p_end + 1;
+		break;
+	}
+
+	/* If a split happened, add the split to array */
+	if (!temp_range.end)
+		return 0;
+
+	/* Split happened */
+	if (i == mem->max_nr_ranges - 1)
+		return -ENOMEM;
+
+	/* Location where new range should go */
+	j = i + 1;
+	if (j < mem->nr_ranges) {
+		/* Move over all ranges one slot towards the end */
+		for (i = mem->nr_ranges - 1; i >= j; i--)
+			mem->ranges[i + 1] = mem->ranges[i];
+	}
+
+	mem->ranges[j].start = temp_range.start;
+	mem->ranges[j].end = temp_range.end;
+	mem->nr_ranges++;
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 69ee4a29136f..e9cf9e8d8f01 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1150,184 +1150,3 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 	return 0;
 }
 #endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
-
-int crash_exclude_mem_range(struct crash_mem *mem,
-			    unsigned long long mstart, unsigned long long mend)
-{
-	int i, j;
-	unsigned long long start, end, p_start, p_end;
-	struct range temp_range = {0, 0};
-
-	for (i = 0; i < mem->nr_ranges; i++) {
-		start = mem->ranges[i].start;
-		end = mem->ranges[i].end;
-		p_start = mstart;
-		p_end = mend;
-
-		if (mstart > end || mend < start)
-			continue;
-
-		/* Truncate any area outside of range */
-		if (mstart < start)
-			p_start = start;
-		if (mend > end)
-			p_end = end;
-
-		/* Found completely overlapping range */
-		if (p_start == start && p_end == end) {
-			mem->ranges[i].start = 0;
-			mem->ranges[i].end = 0;
-			if (i < mem->nr_ranges - 1) {
-				/* Shift rest of the ranges to left */
-				for (j = i; j < mem->nr_ranges - 1; j++) {
-					mem->ranges[j].start =
-						mem->ranges[j+1].start;
-					mem->ranges[j].end =
-							mem->ranges[j+1].end;
-				}
-
-				/*
-				 * Continue to check if there are another overlapping ranges
-				 * from the current position because of shifting the above
-				 * mem ranges.
-				 */
-				i--;
-				mem->nr_ranges--;
-				continue;
-			}
-			mem->nr_ranges--;
-			return 0;
-		}
-
-		if (p_start > start && p_end < end) {
-			/* Split original range */
-			mem->ranges[i].end = p_start - 1;
-			temp_range.start = p_end + 1;
-			temp_range.end = end;
-		} else if (p_start != start)
-			mem->ranges[i].end = p_start - 1;
-		else
-			mem->ranges[i].start = p_end + 1;
-		break;
-	}
-
-	/* If a split happened, add the split to array */
-	if (!temp_range.end)
-		return 0;
-
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
-
-	/* Location where new range should go */
-	j = i + 1;
-	if (j < mem->nr_ranges) {
-		/* Move over all ranges one slot towards the end */
-		for (i = mem->nr_ranges - 1; i >= j; i--)
-			mem->ranges[i + 1] = mem->ranges[i];
-	}
-
-	mem->ranges[j].start = temp_range.start;
-	mem->ranges[j].end = temp_range.end;
-	mem->nr_ranges++;
-	return 0;
-}
-
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
-{
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf;
-	unsigned int cpu, i;
-	unsigned long long notes_addr;
-	unsigned long mstart, mend;
-
-	/* extra phdr for vmcoreinfo ELF note */
-	nr_phdr = nr_cpus + 1;
-	nr_phdr += mem->nr_ranges;
-
-	/*
-	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
-	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
-	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two ELF headers. One will contain kernel
-	 * text virtual addresses and other will have __va(physical) addresses.
-	 */
-
-	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
-	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
-
-	buf = vzalloc(elf_sz);
-	if (!buf)
-		return -ENOMEM;
-
-	ehdr = (Elf64_Ehdr *)buf;
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
-	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
-	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
-	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
-	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
-	ehdr->e_type = ET_CORE;
-	ehdr->e_machine = ELF_ARCH;
-	ehdr->e_version = EV_CURRENT;
-	ehdr->e_phoff = sizeof(Elf64_Ehdr);
-	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
-	ehdr->e_phentsize = sizeof(Elf64_Phdr);
-
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
-		phdr->p_type = PT_NOTE;
-		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
-		phdr->p_offset = phdr->p_paddr = notes_addr;
-		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
-		(ehdr->e_phnum)++;
-		phdr++;
-	}
-
-	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr->p_type = PT_NOTE;
-	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
-	(ehdr->e_phnum)++;
-	phdr++;
-
-	/* Prepare PT_LOAD type program header for kernel text region */
-	if (need_kernel_map) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_vaddr = (unsigned long) _text;
-		phdr->p_filesz = phdr->p_memsz = _end - _text;
-		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		ehdr->e_phnum++;
-		phdr++;
-	}
-
-	/* Go through all the ranges in mem->ranges[] and prepare phdr */
-	for (i = 0; i < mem->nr_ranges; i++) {
-		mstart = mem->ranges[i].start;
-		mend = mem->ranges[i].end;
-
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-		phdr++;
-	}
-
-	*addr = buf;
-	*sz = elf_sz;
-	return 0;
-}
-- 
2.31.1

