Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AED6741858
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjF1SxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:53:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36150 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231672AbjF1SxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:53:16 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SGwwb1019770;
        Wed, 28 Jun 2023 18:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=W8iEv38eAoUWiIac6DamuSVNXvMP78ssEHCbdxW608k=;
 b=Jm95YVh/IdrTZhjHKwce8+4Lfl0yxzm+4gJEtx2ICMtRwc2NnprzNDYSz+210SmKjWbZ
 as4TK6tA2jvzOVOPLYUPBpzEjVZeVWql78FYO36y542FPfy4W8Tz4spR4VF/S74ArED+
 fMLo09fDxvypssjL1eiRa43NhyDz9vNQbPBtRK+Exz07ndqlDq5fdVeZBTFf+66Zf2Zl
 b6S/EnrTiiWIIJ5orN35+OCr6XXXOOUG7XgEXKNQMzBHSMt61vOoskYRroM/dRNwDPzp
 AEIeTl4+8cfU1jmtnENBAxmKwWUemellebcNqhVAbXj+Qi+v4IWFgFbNLzPFVHMCdGsW iA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdgjua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SI734F019935;
        Wed, 28 Jun 2023 18:52:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxc6cxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iN85890X1L3QqQdoRYsYt9+kZj7X6nigTm/keRQvMidQl/vKKHsmk1Rb6zSI7SHzVou5X0uy2c12bw6HHe3K+Hfo0NXiB+OJa7zCMp15eI9G+t2vHeXwlpfCpNBlKb/7306qkwNLBQo4wCPtt8G7XdAKf6yDJUDgWe3o3ahWdwVm0NaMcXN7WCPmB3iklcmq5ec6y7ToEJnGiDnXBBjGFz3nPffkooUYCC5+O+gbygYfjJqvm3AvXDAlEHB9fMzy8XnjhrRMsWklqCYrf0Oik/4eYgM2c4NMe/mpH6cKs18QHfGVGwzJZQbdS0M6lt+yhchpXu9Wu0/A72sUUidjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8iEv38eAoUWiIac6DamuSVNXvMP78ssEHCbdxW608k=;
 b=hlpr8sRJxwzsDl5/ihTt+avl1dUviTrgRIwZK8ZDgpL8/Uena4IQhWq/0poJOQyk42B7T1QG+WBfEfjtI2Js5oblJVDx0uHqOnOUwhwN1I4oiNN4vRLidEU3R+JCCUA8JA2RlqeTSnXRP9Ex90iK7sk36BXLwf8vZjq4zamGVc3w2+offMNbQqi7b+x88rTrfQqWXpESdBp4FNlhH6O/nbzi4Nug1DhOYvGZoi2gzjDmhzPoEHY2M3A3Gs9V0a2hW7/XhFGkIRjDdrffzPvrATsGx1N0Bqk7/loArASxyny//aVNNrteLqKzQKPaA0kYfSuqBs4woemwzlWA7HgjKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8iEv38eAoUWiIac6DamuSVNXvMP78ssEHCbdxW608k=;
 b=pFoUCWYOItcaZpuDwr/nPFxCeaEqzbLF0n5hKSxneETf8NBjXu32H+Ybi7crKgbiooLc8AAH7J/OeOuXiGJh0Phjvd8oGN+Ayj4yYUbZpyLA/pRT7bpAVCr/tfT3z3V5vG2zGI0szNBR0xg/fHjVi/AS6vh2YQLlMWWWJkEaW6s=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by LV3PR10MB7820.namprd10.prod.outlook.com (2603:10b6:408:1b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 18:52:39 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 18:52:39 +0000
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
Subject: [PATCH v24 05/10] kexec: exclude elfcorehdr from the segment digest
Date:   Wed, 28 Jun 2023 14:52:10 -0400
Message-Id: <20230628185215.40707-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628185215.40707-1-eric.devolder@oracle.com>
References: <20230628185215.40707-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0066.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::43) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|LV3PR10MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: eaed10e9-5c79-4776-10a0-08db7808d886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t386r8HUs28xlgMjUDoRYpF1VT3uZLNxmnEkrSXc+jm/lubkmYhbzk0Tc+qGjAKzkxyM9No4G220ImRlN1ezXNPGirfp3SPIerL4kyLdBTU4YPazX3BBZAUMHfqubJm/Pl/XF3nrK87fOo7xED4+QYYo1cyPx4pDaGsd9DQo4qY2vuDBIQz82HuNBSC1V5OdpXu5q68Ch7xtkaOD8iyYA2B0aqf1t1nkIB9kCTH0ZBB3rGYZ4YaCEsAEOhDUDg0NZHnywPZskoiJ39HrqIYe3XAEDMeN+mW72JYa38221ixQNyoLzkDsVZtFhZT2vJRpBatIHmpt5bHwkI9+0/KgvhUx2xmWvoCMP+4KweW6rA0p8BsLNeEmSoUjn6sCgdD0aXZGgoYkiZdGs6WqPzlJB+rfJY8PURW5LGgZwToMupdxh1Z6QqoGaiX2nE0wdJ6Ljy5DspCm15jupYsLDOpDE7tNjWjChCSi0XpEqa5J3VFU0jeCrLx7FG7NYI82Y2q7l5qUhf0nxb5cGUSEKg+rexNReXxoDi0N+ptjmgRr5G6ZgVUvmZO+vvbIE7j5+HL9CRfmnSWwVxcFz1VMW9oiHa9woI8KgifOo8jc73x8nRA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199021)(2906002)(83380400001)(316002)(26005)(6506007)(6512007)(1076003)(6666004)(6486002)(186003)(478600001)(86362001)(107886003)(921005)(2616005)(66476007)(41300700001)(8936002)(7406005)(7416002)(4326008)(66556008)(66946007)(8676002)(36756003)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xYMLAUdqxVmlpVWIjCQXE+3MM8gKKlaEYxrxGuE/K8txL+kVMLkE/nEbYKlJ?=
 =?us-ascii?Q?hWdKRTHwtOAP0xWkNVuu6lnlq8PziCsZmsxbOFSmVMkvRK87NYOtgoIwOxTY?=
 =?us-ascii?Q?ELkXZUN3suhRwzj4ZjkcErqYaT6bM/gtxzjW2ScBsOoPQXv/Owv3FKXzqDxZ?=
 =?us-ascii?Q?2gFMxrUEmTfjW71xPAIX3CvX+zNhWMPfVw2wpZZryuwZM4kikFOmhFVPbWPJ?=
 =?us-ascii?Q?GcNyEBCKEAltXwAnO8BW0ZxVjIwA8z51Q67bmxMNqxEpwmv5d/ZNYnCbDCD9?=
 =?us-ascii?Q?1MZL8Yg5y2iesME3NWcqSdZ9Aikr9aFIRpx4i7vKhwjJRpB07UeNih05/xxa?=
 =?us-ascii?Q?QxOEoCpxJZccIqJSavjNb0sAJhtzeQ3CgOwy8YkPFDBF4e4uO+0YY8+X5vEW?=
 =?us-ascii?Q?VE7vx16Vd8a6iLBTocndvZrYtZF1AAscXFEMtmPxMwcTCk46Aj7lBeGP/IvM?=
 =?us-ascii?Q?smqulUo/qpdgvE4jL/UYGL2ohoMtUtetr7jdYln3j6ybfi/sqhgaZBXug1rk?=
 =?us-ascii?Q?6Ky921u1jrgrSksRkgEwbR8U/3cebnv1TMrJ+eKJ1JKaimgi+smCgaAQA+02?=
 =?us-ascii?Q?NyDlMar1Gn6W27gIlZa6QMrbzux0Dyfn0Sm3qyZaMmayC0FunTwuwISBuPvJ?=
 =?us-ascii?Q?Gg4zg01KCrEJP8xe/V9rwkEVbH8OUmhpVapmBmw7vGzyiOJo4zBw1fL0eJHp?=
 =?us-ascii?Q?P6jCX6NoDu5hdAdXvx7OkVr6om6gzAnUq9oeSfhEh77BAwqwFx1qSbBwnDQC?=
 =?us-ascii?Q?Ip+fitIHciqmfZBzu2uiNrAYLMkUPvfblJ7m99lq79CWpkIwzHgTaI+YowFT?=
 =?us-ascii?Q?dss0zftO/Mwhacm88zVC01V1E5S8pFQGiMjHLLCjY8Z5e3RwfsKXCNRAsPsG?=
 =?us-ascii?Q?Iot5wDDnu8+3H4Z/bRA+Qe17ej8Xf608FGsm5iVL0fZ5mTxrguQDm+XaXtyy?=
 =?us-ascii?Q?pjdLlnUtFUXVkLQFIhnzRDKV+w3Mcdv750N7zEPSYiVQo9Yuh2vqDDL8s5pw?=
 =?us-ascii?Q?YwGv0OmDUHH7CZx16uIEIBazL4TVRbGCrBlKilc5byFkqv9s36BqwI9h+GhD?=
 =?us-ascii?Q?Bw0cPdZP8+D3fb4J9njEyPBMDoHupf74tVUQY16i5EbiP6kGusXNCi1/KwXQ?=
 =?us-ascii?Q?Erw1e2pOwa9NcTzmXg2MEaIOGLWcc6Dy7s3j1uVggKcX8siKWmzKBeCzu9aa?=
 =?us-ascii?Q?1JFp9gd/fRrf9HzSIdKlykXlaNQSl5PxXz6I6/ao9e8VsQPHpNVK0yEz7Fm5?=
 =?us-ascii?Q?KCLL8tKr871lpGvR4T16NeI0sX/yqWHT/oFurrV00eOdnuJn291qYQq7aVM3?=
 =?us-ascii?Q?tX2l/XJ18kgEoSGlkHCevNe78NQCen42ooXZJN4v+Fwbg/CoxwTqQ+TcRGT5?=
 =?us-ascii?Q?Hc0XCpc4VMCnO3jAD7hCll8gTpWAYTklQJzhdSGsAH5JcLqlQna5OAPtA57U?=
 =?us-ascii?Q?HDj2/+7tz7JcCTxJ+wz1p3pEI7pNQFc8pCdxvxxRqMlUDx7EKMSJnvnltGBT?=
 =?us-ascii?Q?fz/C9Z1XioBpCv/tEhrAwFVS5F+u9RlMCfHQjuDRKH83bgG4qoHdJHbhdQQN?=
 =?us-ascii?Q?aLDSMzqcKYAo01ZbktKTHsOlkqhP8Ki4brl6yZ+/R8sD0blMzz1QJM4dmZLi?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?kjOOjzEXcKvNmyJQ5qbyYKmcF2s+cnk8IYkqpZc3ULrgCw8klBvMbhLk1ZYm?=
 =?us-ascii?Q?GTlZQeWrPcP8rLS6CmN2qmRHZk4UGtk4ztPKsldnVKUoHm7bawRygzO6z8BS?=
 =?us-ascii?Q?Jm0pLR1K8tX51M3I2zawpOIq9o+3gUsTzxRDhkgEURxNlw6KuCL8i/3LFy+1?=
 =?us-ascii?Q?VJBVnlhPJuBkL/Y66LayKKLgyrquxrQOiuzZwcyITvcz7FUXUZFOZ4N30vZO?=
 =?us-ascii?Q?5zc+6rGOjc+f7vb0mZiiHK7eXCCk0gZ2gePs+9P+OEGfA0Xkn4QE73OAWK6+?=
 =?us-ascii?Q?VxleVG5xPHKDvQMxhw3oUxKT78zGr3TELJjx4Ah/9ztMkCSw7So18amSh/Gc?=
 =?us-ascii?Q?RjA4cVms9m6MzwvZg06OELl6hf1DuR9ZtzuIErVPL+3zK3NOKoYUgwj9bXPV?=
 =?us-ascii?Q?emkTN8NvdJyJQa6va2VAbqcBfw3P6nzIoHZdu8yXDq1GAQq60S80Uk0ZE8oZ?=
 =?us-ascii?Q?rDvTH5Z2eNn5M3Qe2DlMQR8fHEmOxz3s3axaQYcNoWZCbefPzqOIOZNDrdJl?=
 =?us-ascii?Q?Vr5mEJU5NvJs7BB4z6jYBl51JH8bMQVWgt6MUjESUBVSBtlQz4rmTp/KdWvh?=
 =?us-ascii?Q?HSb3cc+ei2n9ywBD5OlzLP61rMe4rkarLPbjqcqIIrbJvGmnCEvPyyFUkYgw?=
 =?us-ascii?Q?34Wwx6NaQgIzHa1y/p2GGNmZcS4VVBCTar9aIiSRYjQgda4XdMJJOTlpl1sr?=
 =?us-ascii?Q?SWq2f+vjEyOmirRIPLTjpCrpM6yjAhqVjtRUG0wXs03JHUYalOvg1H1Gq+EK?=
 =?us-ascii?Q?Mddqv2GulBDdiKmSZO5vwR/N0kE1hGooBbN7CDd39inbWd99iNLA2WMLDVDW?=
 =?us-ascii?Q?llsFtvc6lLXR5CwDd9ie6T2Pu100iTTOFqYLqpHc5XcXkFwugxqEkaUiteDO?=
 =?us-ascii?Q?UHaBbuu43sKPJmQLLDVJuobX1fHSF4jlsSx6Ry+ri6jXd7t0ZKP+Ugfmj5dh?=
 =?us-ascii?Q?GzSUZoIl82Qk2dHyJcNCpsX9CWCgB0adLji1bBtuF9yatu47cXdc6PiABuxU?=
 =?us-ascii?Q?TW/n6yBL4Ix+YAeoJK0NHx3qW2tGGCp0bCzxPvPAPtieDcYb6GopQG2rCf9h?=
 =?us-ascii?Q?bciR2i+Cf3xTAjcW6Te+12wNZZpA/DdLWTjPIHWHZzfWkPuN4JwxGJAC2hjj?=
 =?us-ascii?Q?OiEtTBuAnXms3vVvhDrTixnldsYvVa2VUpvRqemkTmhQE58IgCrIEws2Wf3Z?=
 =?us-ascii?Q?ka+jK7T/e0QvPompHEXbDAYZofTznulO8eh42EcM/sNQ2BZhrHSMRAv4yGfO?=
 =?us-ascii?Q?svUsj+DiJiLdL8EeWYwG2tEe3y/IzrzoccYt3PrINcrhoMFs/+lmO85a6GSR?=
 =?us-ascii?Q?kA7v8N8hxy/fFglhDmNi1luT50u2NrwRpN3UkU0JNgqiIhfHJQsOplGgpxmD?=
 =?us-ascii?Q?+sskRTcfYZRI8sBGBYz5BCGpOcpU6ZRvEw4ZHK1Y04c188v3dnGHtgtlyFh2?=
 =?us-ascii?Q?Ug2KihDKhLE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaed10e9-5c79-4776-10a0-08db7808d886
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:52:39.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CabDA/wNt1COCA0O7zUOufHH1+y6x14vNpJmtylY+vnbiN8OUZ0EtxtPNWUN/ZIjeBejwIW7FwD7P0kziomlTEesWf1GhGldDBxNsNrdbNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_13,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280168
X-Proofpoint-GUID: p7Z3ezR82gokJ_E6YVAEIVr5Gh-_7ICq
X-Proofpoint-ORIG-GUID: p7Z3ezR82gokJ_E6YVAEIVr5Gh-_7ICq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a crash kernel is loaded via the kexec_file_load() syscall, the
kernel places the various segments (ie crash kernel, crash initrd,
boot_params, elfcorehdr, purgatory, etc) in memory. For those
architectures that utilize purgatory, a hash digest of the segments
is calculated for integrity checking. The digest is embedded into
the purgatory image prior to placing in memory.

Updates to the elfcorehdr in response to CPU and memory changes
would cause the purgatory integrity checking to fail (at crash time,
and no vmcore created). Therefore, the elfcorehdr segment is
explicitly excluded from the purgatory digest, enabling updates to
the elfcorehdr while also avoiding the need to recompute the hash
digest and reload purgatory.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index e9cf9e8d8f01..824ffc5282f4 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -726,6 +726,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Exclude elfcorehdr segment to allow future changes via hotplug */
+		if (j == image->elfcorehdr_index)
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.31.1

