Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4F574185F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjF1Sx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:53:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37278 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232033AbjF1SxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:53:16 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SGwo5i011874;
        Wed, 28 Jun 2023 18:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=rAap41MLGGcantWJmWHHzuP2VyBfpqCHGeczaU2RdgM=;
 b=u+Ozt4ELNamIEIZ/KCtDR/dZ1DjX95u/fv52TPZVqL2lq+5P85cKLGsGGYAg9RVrqc08
 EXeeyxwg110q2zNwh9NUi7mFxvrs54paq8ZLtwAd5jKuA5NjzaWnRK9UeAhU2YMvzoE6
 mp1eMtTdTWSnSKQ3DyQLAnt5foCzEmNaoduKR4wyW5WjTqFIAGqYrC/qxr7B9yMKe+30
 W5+GA14pcmy+Tjb8fICim55/0rqatpV9lL1eDEC4WWzHacP42oHhtwIGKolU9ilcku/k
 5sLFw5eATujuOodMio35K75ZRd32edqLklMecUUhTobhMdk9MdifV9KNz+JDtsISBDgx ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq938mfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SIDli6029650;
        Wed, 28 Jun 2023 18:52:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx6dmh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHpfgg0OxLtsrFSBUXRdE0x683O6AhfKUcBHky2hYLUIn3ZgqgIT0ZHKAVgxlY2Eod9CmGg1X8tvXyz0dRqm3f5rtbxuXRBCort5vSxb2woE4WlEbkwO21dzlUvFmv14XpSzmeKOL4o5ZM7qBWVRorvFHpxz6pcHMtqgXZ9XjCyo7WExXT2Q1Oi30ne8Ht+2eqtfW2QBgj2QNGMmsNe/zHw6KIuY3i1wpp10VZYZ+UrjJoYGg2PjmfP+yNdbZlWCYPmge5yIzTGRcm4+8sF7HxaNodYU1xfBOucnLm848ppaXfdIJJE6Jno5WGOSDYcUnp9oGJOnnytigyO76EbpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAap41MLGGcantWJmWHHzuP2VyBfpqCHGeczaU2RdgM=;
 b=Tia7nsWEL4Za06sBqz3kVU4iLPquqS/E2liT1DLftZNkA+XVW42YS9SsLvhXzDKtCBK7ceJ5v3OyX2fwjuABKkEd9LMnNhfCdUdtYeSJ+1jrzAn1XFaGltvK36GDELIe1JlPRF6IJD0TNNcHpymzK2bUKvZMRefaLGCdis1tzvE+lv1n8rIMXNAsLkzKtvhAPkSQL2Vrp3Ewimwi4bqxASkBC1dBjP2CkIIKiYyQPuiPA4akV/BW0/uQNmCof5ctIpr8+ruG7fk6pm7UAriLVDsrb1MU72uU6t6WJ42ukHE1qn5oKTUAZI7Tb51+J4JMwuJl9hl1hYkT3nQEB10VBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAap41MLGGcantWJmWHHzuP2VyBfpqCHGeczaU2RdgM=;
 b=HeNTZQzLOD+BLWN6NgaNrCqFpy6Zj8Uuy+attDy3Roljiaq1dFtMywSn8oDbvJvf4JDzgmWMdpBXD1uQLZ+7Zc6qxhRHuBm+/mgqcL+kV2tvIkP4OPoi32qB+xh6f0z28MLONJLPetdGiT7YgEk53Yslbd/bwGJczYiupfdZfdc=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by LV3PR10MB7820.namprd10.prod.outlook.com (2603:10b6:408:1b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 18:52:35 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 18:52:35 +0000
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
Subject: [PATCH v24 04/10] crash: add generic infrastructure for crash hotplug support
Date:   Wed, 28 Jun 2023 14:52:09 -0400
Message-Id: <20230628185215.40707-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628185215.40707-1-eric.devolder@oracle.com>
References: <20230628185215.40707-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0189.namprd04.prod.outlook.com
 (2603:10b6:806:126::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|LV3PR10MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: fef5c95c-e490-4fad-571d-08db7808d66b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRBviYGYX3gFUotVM1R+56k0Yb5jdcOYV+prZOTpPc4ikI88bEJV6ecrT2LqNDW29oCUD9JLGt5g7mQIO+cFADXf9rXZ6ApiCK5R6Hkys/8GB9r8pWbpV5kjXokmThLEgkivkhpiLGG2jrIUMcKdd31WUNK3QxMCR6KkBXQB7IcArL1mc1E5/voQbk4iwrubbV0F4QNk1oi7TuSiC8UowD/qE8YBteOrj5lAhUd9pE1Em9Q268evWqB+97bXo1L0XQvEHHVUcdZyVHWA0tlD/qPmqvbMLXacCDs/Fzhic0cL3MoY3tW/rZX0mUbLR+FLTwYJX1nnm3ib+SyEK6C0jr8hxkRBxG/TWDmFIMtmzfEq/Nhy5C/D6OLJnH9EyFyV+m9Gt8u5aM/XAwkfcMmSTXJCk66VW/+Et6cV7FlnbOW/eutUGOQp+30FYpapfecljJdFgcmwSfyb2Xc0q0XZroc1GlyDO9QBAt1eHPysw4Hy6vZ6beDQtTGxnWOiALub3qJ0EIjrpXcwdqAttGTySC4nDOvMdBp254GOGcEyC9W836yJBbPFddsR1W1AyZMtdMaPEiDgMLTJoeBTr0pGNJN1O9zaMa47LE2lLASno5R304tNj2zlKvAicQUeNR1t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199021)(2906002)(83380400001)(316002)(30864003)(26005)(6506007)(6512007)(1076003)(6666004)(6486002)(186003)(478600001)(86362001)(107886003)(921005)(2616005)(66476007)(41300700001)(8936002)(7406005)(7416002)(4326008)(66556008)(66946007)(8676002)(36756003)(38100700002)(5660300002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dt0FifDCjW/joEUTDHMn6in0SxB1eyEbL+91FxnV2gP8tBSbgyITsE3g5erl?=
 =?us-ascii?Q?jXSL6qGIzNQOAnCwUOfyy86FzGAUf9fI1g6hCWJkCRab7uMkck7vK75g6oV3?=
 =?us-ascii?Q?SeqySN5OO2/Y8cPdlwF2buDaGFaySd5m1OvE2tNnbE8CmhdqEhu88cOpX9QW?=
 =?us-ascii?Q?jYzCL/CUuEQna3frdQl3JY9kDxzocBvLJ3yJhkkGLRhPcoqxbtcQtU24TqlB?=
 =?us-ascii?Q?vgY5J4VJTESdp6YBl4/46ZXSCP9aX9fOG/X6mn2EJEsYCkwxU/Tnoj5/KFpZ?=
 =?us-ascii?Q?iLd06ZAENsstnfihAnVylh7CmUArMpDfb3+e1Vbv8B/scaV2l/42PboNb+52?=
 =?us-ascii?Q?FgPo9DvhJSWenyVhhiAZr6NeQPsJWgC5iG76OO6E51OifH9l5EqEsOnggHPy?=
 =?us-ascii?Q?aS8wTxfuP1HjZyP0ygobnzH3jAu7IGOacoC+vw0oLpi45lIewEzRSZPG9hBC?=
 =?us-ascii?Q?8o+riAwTPtUMp2El5yrHUpgPENSd5wyboOiYoT4YqgU+WRKzhkNPJ/PV7giT?=
 =?us-ascii?Q?zN9SlkhJIdP0I+JD0zkwRsR0c6Nhsoq9156RbHCwZS1InbjGj30j2vFByx8I?=
 =?us-ascii?Q?Ly17gbdqS+0dotS6+23B0RoSrMogvKE8m2PZ1YxPZs51FfLsO5uY5dzwO6/f?=
 =?us-ascii?Q?M/NIcGbfxlnLKVPvPkQMXwAK/xdmQbyYdBsnFfAO73soLPhRi0x/aSjW9J9E?=
 =?us-ascii?Q?OlFjwiN3TRds1qlYDOhOrfqvOIZ+vnvtXUPycvEOv/up9RkEetXCi0ciO7wa?=
 =?us-ascii?Q?8j/3JTLfzEFSqZsybUivk7nM8iUlMaFcE54UdVJjtSYq1bORcNoG1BxX/ZVI?=
 =?us-ascii?Q?7u7eAdipx1LFUwqyjNBm1y//d/tZO5wEQK7ZrSL6X7Zx3KLAjY42Ili78NKG?=
 =?us-ascii?Q?3Br5BH7GdlwYzfMRb3mGPuLgynydzJmjj2xvKjkPsLDbHESFNugSIOzPk0VQ?=
 =?us-ascii?Q?fGjqGVfBEkSQYNQO5j8GQl38CIlBMnefZO1TH6vRlavdxOPpZ2SARAiFfrgH?=
 =?us-ascii?Q?FS3fxG3NJ7eJDjaD57DWq9BeYwrYq234RWpEn4vlB3rleTvkLE10exjM8TW5?=
 =?us-ascii?Q?0Nk+8uMG557twXq01x8H4lph7xxY/A8Ros5RW6N2HwRYBnRBx/wh0qFc9RYb?=
 =?us-ascii?Q?xdK7gacnQxZXmKnDMiNZ3Bt8PSmc63Dc/GVyiP7hSbGaiXhAJ9gN0RfLdNGg?=
 =?us-ascii?Q?dWwNbD1PN9OdXWJ5XKZP7SbY4Y8wSoHv2RuFyHM4WgBoru+eqzi/g8SXCsLA?=
 =?us-ascii?Q?c0kyLsdCuinV766E8AFHMe23qsaSobYotmjwT2XAP1giMmc4VrCTzQ0nnkyN?=
 =?us-ascii?Q?dThrV9c+PCvvtjJnwKMd2D/qtADgPIln5Axorl8sbhNinIbf+K44DVaTBobm?=
 =?us-ascii?Q?lmR2p09eh4iBD0Vi8Jc4wGDzR0Q2VxwiIoFC2x/gMYGQZWIl05Adj/p7aRjZ?=
 =?us-ascii?Q?Iq7K6BGW9kJ8+YYg50NtuaSoKoB2GSnJusKSegS2yl8rC0KRmOEjxAhQc2Oe?=
 =?us-ascii?Q?bo48wgmpjSToyWK3OVLXQPfASvTXZoSYJxbiqFIwCyBo51pl4PxaXQ5vFWyD?=
 =?us-ascii?Q?UxbCZz6p97ojU+DumH7jaD93ezmrx2LM4WIK4wo5v6nWT8WpzyZRjq1HcQ6K?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?BK5OvqQCmiI4tmv8iqwHk/k2Yi3ErKWjqhLJ0TlsWdaCu1rE5ZlelT6xGO5U?=
 =?us-ascii?Q?LiW5BHL4Qqn5DOQGwUPU+6hUdyr0Snb/RhDzT3jpeC0BA9U+1efMnl2FF2xD?=
 =?us-ascii?Q?Fb6p8AzPKfhtGXoGDSAgxW+OU4/BzX9jVZ7Jy1tQODDPxTBh5/BdXSfnn9CM?=
 =?us-ascii?Q?A8y/3N6JIqZEzhuYI1HTGWcER9lfjYVMsE6gxSh1bPjNGmzHnUhnomIHg+0h?=
 =?us-ascii?Q?8Ziinl8ciokTnZhhF1yaIU0gfXgeLJ1gFDYYo9A9ssRN4r02xetfaZzIZDuP?=
 =?us-ascii?Q?H0OCJKv25znlns/NLldv4tGVYm0RbySjjflyqx3WyEul7JHlgm7v3wZliCdV?=
 =?us-ascii?Q?PLoFexQsw+DjHRR4002bffl2rnlhV1dWzTM/eaMtVfrtMlTvcfqV22DxC29e?=
 =?us-ascii?Q?0A+u6GQAlT2w0Wg/jScrih/yNd8P9Wg5rpUXeBhOSaJZpEycXE1x0LQT4rc+?=
 =?us-ascii?Q?LTpixzqKArHD9kDgMm3XCWBWhJVKQCrQyCUJM6LYqwuFHKwnFHQT6AcMvtdZ?=
 =?us-ascii?Q?PSvnE2Z6qdv8gV10+95R1Qh4pIo4wPjQ/pQZqbKJQluv0L/Axwvgwhxswo1H?=
 =?us-ascii?Q?QYJ4zDB+MIeUQME77hBLk/5yX0GlHuOYVPo+3tXxl7aCm65Ib8cK7uCD1KMp?=
 =?us-ascii?Q?9uc9m85vLpf63KgcYKCZd/BIOnuU1geMuzh6g4OdiuxK7oBPoUtFZ1NPcLx9?=
 =?us-ascii?Q?yqxltbMwMCBxyTKjyPuuC/laSsmZt3ox5D4dm5dX+8liursORS6BRGPQEo2x?=
 =?us-ascii?Q?ryy01YpGGBIinE42dxLvqxGIJmetqnmhd5HwiNH6YgsNaBeJZH7qEb0nbsza?=
 =?us-ascii?Q?3mS9WCUw3fmzuw5PEU+axuQeWJm20K5s0Vwsjvs2cLHdFTWXF7bfkb8LNcZj?=
 =?us-ascii?Q?cO58CPLwLoxFDd/eeq5ELsdnEm6sqvZ9rsQGhTaGy4XbIq/ivz6qiXPQvOfq?=
 =?us-ascii?Q?IECY7fLtITw7dSNs27qZVINuZ4s/JWn61uU8fotDfHqbOeuZu1tdFzD6+/WR?=
 =?us-ascii?Q?k6kv9MG8EuvloTxJRlB9PUHRUlpY1ROncEDJ5g6T5nfIYpdjeJNwjgoql89U?=
 =?us-ascii?Q?IfYnUs1bYsM8pwspcUyrjzWQe2EVgokD//7+pE/QI/yN3Bwj6weNksY1uPPQ?=
 =?us-ascii?Q?8Njf7YOaPbCsRY7r0MOwdz9wobgM4X67cFvFH9HomK5oOiyja+MjYrTZ4D51?=
 =?us-ascii?Q?oLc4tMOtdNLDWxVYWV/MMQNSNC/Fr1d4CYXPE/uwtOq7lQSnBdxD895+DLx+?=
 =?us-ascii?Q?GFNqEqR2vEiSdH1HSUzpj0RilS9MaGqH2/T6htW3zVmElezxuYCtHoZj1Al+?=
 =?us-ascii?Q?ZEIB9xoqXrZtWilVQELUlN6crjydbKSxlI7ks0irwFvg9W7OcifJMHAlKpCL?=
 =?us-ascii?Q?XUQiRC/26wcQlhjjq4djHq3qTyGL2W5j0vSE4MXek51/olR1GBHKWyfOFAAK?=
 =?us-ascii?Q?psbk590TTSU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef5c95c-e490-4fad-571d-08db7808d66b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:52:35.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fonRkjWN2IG4Dv1PpafefE4Y5/oiojFvy+Hz5AH9a6E1hOYrKAaeY6IAKSfsZUAE+zqWn6Qx2RccU0LsDKAYGzOAvIXYCHRPReGwSqnSENQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_13,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280168
X-Proofpoint-ORIG-GUID: C5V9V5jb0H9Cf2VEhxQmtxM0txuOQyLP
X-Proofpoint-GUID: C5V9V5jb0H9Cf2VEhxQmtxM0txuOQyLP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support crash hotplug, a mechanism is needed to update the crash
elfcorehdr upon CPU or memory changes (eg. hot un/plug or off/
onlining). The crash elfcorehdr describes the CPUs and memory to
be written into the vmcore.

To track CPU changes, callbacks are registered with the cpuhp
mechanism via cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN). The
crash hotplug elfcorehdr update has no explicit ordering requirement
(relative to other cpuhp states), so meets the criteria for
utilizing CPUHP_BP_PREPARE_DYN. CPUHP_BP_PREPARE_DYN is a dynamic
state and avoids the need to introduce a new state for crash
hotplug. Also, CPUHP_BP_PREPARE_DYN is the last state in the PREPARE
group, just prior to the STARTING group, which is very close to the
CPU starting up in a plug/online situation, or stopping in a unplug/
offline situation. This minimizes the window of time during an
actual plug/online or unplug/offline situation in which the
elfcorehdr would be inaccurate. Note that for a CPU being unplugged
or offlined, the CPU will still be present in the list of CPUs
generated by crash_prepare_elf64_headers(). However, there is no
need to explicitly omit the CPU, see justification in
'crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()'.

To track memory changes, a notifier is registered to capture the
memblock MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The CPU callbacks and memory notifiers invoke crash_handle_hotplug_event()
which performs needed tasks and then dispatches the event to the
architecture specific arch_crash_handle_hotplug_event() to update the
elfcorehdr with the current state of CPUs and memory. During the
process, the kexec_lock is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |   9 +++
 include/linux/kexec.h      |  11 +++
 kernel/Kconfig.kexec       |  31 ++++++++
 kernel/crash_core.c        | 142 +++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c        |   6 ++
 5 files changed, 199 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..e14345cc7a22 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,13 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_NONE			0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_CPU		2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_REMOVE_MEMORY		4
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 811a90e09698..b9903dd48e24 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -33,6 +33,7 @@ extern note_buf_t __percpu *crash_notes;
 #include <linux/compat.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/highmem.h>
 #include <asm/kexec.h>
 
 /* Verify architecture specific macros are defined */
@@ -360,6 +361,12 @@ struct kimage {
 	struct purgatory_info purgatory_info;
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	int hp_action;
+	int elfcorehdr_index;
+	bool elfcorehdr_updated;
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
@@ -490,6 +497,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#ifndef arch_crash_handle_hotplug_event
+static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 5d576ddfd999..7eb42a795176 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -107,4 +107,35 @@ config CRASH_DUMP
 	  For s390, this option also enables zfcpdump.
 	  See also <file:Documentation/s390/zfcpdump.rst>
 
+config CRASH_HOTPLUG
+	bool "Update the crash elfcorehdr on system configuration changes"
+	default y
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	depends on ARCH_SUPPORTS_CRASH_HOTPLUG
+	help
+	  Enable direct update to the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions to be dumped upon a crash)
+	  in response to hot plug/unplug or online/offline of CPUs or
+	  memory. This is a much more advanced approach than userspace
+	  attempting that.
+
+	  If unsure, say Y.
+
+config CRASH_MAX_MEMORY_RANGES
+	int "Specify the maximum number of memory regions for the elfcorehdr"
+	default 8192
+	depends on CRASH_HOTPLUG
+	help
+	  For the kexec_file_load() syscall path, specify the maximum number of
+	  memory regions that the elfcorehdr buffer/segment can accommodate.
+	  These regions are obtained via walk_system_ram_res(); eg. the
+	  'System RAM' entries in /proc/iomem.
+	  This value is combined with NR_CPUS_DEFAULT and multiplied by
+	  sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
+	  segment size.
+	  The value 8192, for example, covers a (sparsely populated) 1TiB system
+	  consisting of 128MiB memblocks, while resulting in an elfcorehdr
+	  memory buffer/segment size under 1MiB. This represents a sane choice
+	  to accommodate both baremetal and virtual machine configurations.
+
 endmenu
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index b7c30b748a16..53d211c690a1 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -11,6 +11,8 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/kexec.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -18,6 +20,7 @@
 #include <crypto/sha1.h>
 
 #include "kallsyms_internal.h"
+#include "kexec_internal.h"
 
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
@@ -697,3 +700,142 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+/*
+ * To accurately reflect hot un/plug changes of cpu and memory resources
+ * (including onling and offlining of those resources), the elfcorehdr
+ * (which is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories.
+ *
+ * In order to make changes to elfcorehdr, two conditions are needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources; the elfcorehdr memory size
+ * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ */
+static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	struct kimage *image;
+
+	/* Obtain lock while changing crash information */
+	if (!kexec_trylock()) {
+		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		return;
+	}
+
+	/* Check kdump is not loaded */
+	if (!kexec_crash_image)
+		goto out;
+
+	image = kexec_crash_image;
+
+	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
+	else
+		pr_debug("hp_action %u\n", hp_action);
+
+	/*
+	 * The elfcorehdr_index is set to -1 when the struct kimage
+	 * is allocated. Find the segment containing the elfcorehdr,
+	 * if not already found.
+	 */
+	if (image->elfcorehdr_index < 0) {
+		unsigned long mem;
+		unsigned char *ptr;
+		unsigned int n;
+
+		for (n = 0; n < image->nr_segments; n++) {
+			mem = image->segment[n].mem;
+			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+			if (ptr) {
+				/* The segment containing elfcorehdr */
+				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
+					image->elfcorehdr_index = (int)n;
+				kunmap_local(ptr);
+			}
+		}
+	}
+
+	if (image->elfcorehdr_index < 0) {
+		pr_err("unable to locate elfcorehdr segment");
+		goto out;
+	}
+
+	/* Needed in order for the segments to be updated */
+	arch_kexec_unprotect_crashkres();
+
+	/* Differentiate between normal load and hotplug update */
+	image->hp_action = hp_action;
+
+	/* Now invoke arch-specific update handler */
+	arch_crash_handle_hotplug_event(image);
+
+	/* No longer handling a hotplug event */
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_updated = true;
+
+	/* Change back to read-only */
+	arch_kexec_protect_crashkres();
+
+	/* Errors in the callback is not a reason to rollback state */
+out:
+	/* Release lock now that update complete */
+	kexec_unlock();
+}
+
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+
+	case MEM_OFFLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	return 0;
+}
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		register_memory_notifier(&crash_memhp_nb);
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
+			"crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
+	}
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 3d578c6fefee..8296d019737c 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -277,6 +277,12 @@ struct kimage *do_kimage_alloc_init(void)
 	/* Initialize the list of unusable pages */
 	INIT_LIST_HEAD(&image->unusable_pages);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_index = -1;
+	image->elfcorehdr_updated = false;
+#endif
+
 	return image;
 }
 
-- 
2.31.1

