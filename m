Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93E46FF55F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbjEKPB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbjEKPBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:01:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCF0211F
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:01:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTdZUhxc3jyLdSJaO0Mus32Vt0THXke6d0V622M8lKgxp93cWhhJ1WYzzDsIvdXTXiDqx3II1UxdO2QfyUMdlD87/YFB9oECFVlHl1s4eqVsUMxLWjFj5upotmkCHj4297hdw6RZjRLxOdD4LitkuYU3/Ljkc6WtEUIHFgrRSL+Au2mB8QEYvmqmlHe5DdRA2QqkL4KRz/O4Hddtflp428UKBwP4+zVcBM3N8yn6V08bceYzwRW8YXzIBlhtRQzjYp4VzvE87SOT/Efj2RA7wEVvi0CL3UI8RKr5s3EAoekRhZ66LkMgOFigp9gZY7yDDbAfbYYjb1rBWjBQsATs7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldHDqI3XOCecPSp8MJQaZX4AJxaTdC3AD+5L0P+XEV4=;
 b=LFkWm6S3A2aeqCmFLx/yHKkGcmDApOB3N2vojmDeUyJT6d8M0zYFnks9NbfacONnwVdglWwypPPdB6tLvWFPmHhHD78MsMQHqtwOoSMtD8Zq29IU+OHJr7wIFw/qFtyDvrd7S8J4zSiuBjYVOWDL9STP5uFiUr8/CRfduQ5GDbV0rnD3NZSmYUDnLqq2zh8JHFLNjHCaamT4e5FVnAX6ZfsDgYKudP/1eJ3kXbuhLljqeO2F3Rt7cK+bGY8flib3Gf+hyjdyw48dgl1AleFh3q9UALB4JOLO7wyfzIAIybjn3Tu62B//pH8b5eOw/2KGsG4RtpPDdqfRiC2k2OVjSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldHDqI3XOCecPSp8MJQaZX4AJxaTdC3AD+5L0P+XEV4=;
 b=S7Mz4t6jEPCSEcVITdaBWfmrd3u++idoscHcltnQGnUxHROK0FnR8ruEbPQt0C8+nqaqGOdWAsp6u5PaPvtMdZ5CEdunSTkYmRM5KUM/IKgH5NBWyibWNY3BAZkKYeGOU0gG8xifeGbedazwET9+t7jVBluMOyAKrQ1caC6+N7GHjOz26yFtQcS9oR6vxzhni3qQI+trXiryVyN5dR1plK80ouwxgX1SBsPNGG24WaSjnzZp4KVeSyPN9hXN8kqv9+qhBdEWWpgQulwvDDVqIX/vjnIg5TvgUGLcb/STKONMPoYLwcnmcxFLOyJMfQMY8Qn6rdxIDYJCUkC20ypHjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA1PR12MB5638.namprd12.prod.outlook.com (2603:10b6:806:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 15:01:34 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::847b:988d:86fe:a0f8]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::847b:988d:86fe:a0f8%5]) with mapi id 15.20.6387.018; Thu, 11 May 2023
 15:01:34 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev
Subject: Re: [RESEND PATCH v1 3/5] mm: Fix failure to unmap pte on highmem
 systems
Date:   Thu, 11 May 2023 11:01:33 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <2E10F2A8-D954-451D-9CA7-042E55394FF7@nvidia.com>
In-Reply-To: <20230511132113.80196-4-ryan.roberts@arm.com>
References: <20230511132113.80196-1-ryan.roberts@arm.com>
 <20230511132113.80196-4-ryan.roberts@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_C184A589-30EE-40FC-B337-3E77EE76A2DB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::18) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA1PR12MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: 314a0f29-6337-4a7a-a7f8-08db52309c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvU6KbS0dWLCh2hMHe2/IX5EI+iU58s/LHZUpMmTiHRxrmojI1v6FbNbsjjdsQYOo2CiT480052k+HFfyMnEcp61Ncv7yevP0SGslsUm2HJ89fP9o5ADCX/fh5zVxqMpSe/WclzNqmxtZSAqiHV9DrfZYIcVopbH2amxIbK/EWy6i+dTgx72k6wBmJjNziJ96Ce2Vv0oNX+70sQNL7t5LzKyt3hcrJVsPc5KKu0t2Syvk7pfFamG4J/jBRregSOEwvPqc5Ca9zqUOjiasfCD9y15as412sa9NxMO1szcIswP+PJvo9IUTh9UqtyEkMeI0Zkq1JjMlhIqzmIDeoRTsk+aY2bY5OB0iHPGbbr71o4oBhJ1qebngNlp6RSWXIeF2wI6wDDEuKYsTpsGzo85m6XuWBQfV9Z+zB+IUu/W0SNAleUqmUEh54U011YQVnIy/m9A62rQhEqwssnsWSQJGlwAlt/pN6PmPg7rIDOY5XQkMVPafeKrKpxWE24jal6T058RyMx54AIfyi95VmOxFwqNNp1syBVjokEs12qwEhSI9wG65Zc0ssLbJqPsFmgxMg3feHIDYNNem5D0abZBufcsJpJbVr68/3ZglM7L741O1DX59droWrj3oMQObBydcdFbzKyZCJRRNh1BsKTdcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199021)(186003)(53546011)(6512007)(6506007)(478600001)(83380400001)(26005)(2616005)(33656002)(6486002)(8936002)(86362001)(316002)(5660300002)(41300700001)(38100700002)(8676002)(66946007)(6916009)(66476007)(66556008)(36756003)(4326008)(235185007)(2906002)(54906003)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XLUx2pYtht2fQ0zMJaca1ICxrQP60hdUpbfc2hVazkfWNJWU6U+U7eJnzEMy?=
 =?us-ascii?Q?51IwqsqaHJgSImXJj5OUXIGUH5EjrqqcMx5SUkC+n5Weqb909cWJ0JAQ+BTm?=
 =?us-ascii?Q?Syi/IJijvcZ0AsuSu1Y1Whmv38BiHZ7NpTNbyQcKjrZ9H5aEG7maO7UwZHp5?=
 =?us-ascii?Q?oiPinCtvKJ8odhlh2bhykSzNhtsTgVw2Ena1io//tJHJStrjfjKX+R4+Dcdy?=
 =?us-ascii?Q?x5M5pRN1CoilgitXimVmOyzfkuVCX5iNNmIrqzSOxQVDd1KjGcyIMtQlF6XN?=
 =?us-ascii?Q?nANFpgHdHSA/zzuVPL8akgqnnaZFsJliq9Zzd3+YD4sTahQdcsYStIza9KmX?=
 =?us-ascii?Q?QJT2U5sADntLxIdEUno4rTbNROOnn0LYZ4m8mHz4KKYJq7vUc1MPz7S65hKg?=
 =?us-ascii?Q?G7+kAgiW6CH62Ab/bJZ7YaK9alWA4rId/jsk1eGKHWOFW3D9X1sdq90vrEGh?=
 =?us-ascii?Q?6zxYNKptzLihbw13x3OQ2KIAhVejK5j8hP+eyAwaGNgsz0P/ZAUp7j7N/WaA?=
 =?us-ascii?Q?mcCqNleDTe3yWJhKAZd7mfj8ZiS9KhaEuchYj7wnhmGNfUqtdij8H5nV5s2+?=
 =?us-ascii?Q?FYOt3d+5oVEe8mJxi+ekKuIu/aVN8WUVa8ru7/c1C3d+ExWI9zy/a34Sp7YZ?=
 =?us-ascii?Q?cqSurfCrW11EWEpbLL5ouyYtT0HrOhyudi9pQsGGmyTj9Q7/cZPcKGVB8kyU?=
 =?us-ascii?Q?/N3q4HZ3qgA/KyWxGiKosiLX91O96vPOzbAdeStU95Te0t6Qu+OjLJ8h+u6H?=
 =?us-ascii?Q?CkmxEvY4ZdnoPzn0YLKYk/mqf+ZRWnoiVK5Mn6bSevCjctNHlvjlXodGJ8K/?=
 =?us-ascii?Q?AC9sGzZVadHEjhUB8f/wEfMiTqqEFQinVd7j/CycQAPSH396X/B5GCXcUATm?=
 =?us-ascii?Q?Etipcn1i8/XRretIsAXnWjCUtVKiM51GL9vXDNTxztIbiIUu/jhx/ceU/ipP?=
 =?us-ascii?Q?9DtS4Gbdd2J/mRP5WjO9+Egji9JjxDWwUJUtR3QBovbo6/JO8aizBsKS9vR/?=
 =?us-ascii?Q?KnI/jqgMb0iVXADTD1fIEaT55iIOW50aYfFrkzhEEtf2dpI5mY8opGjBM2+y?=
 =?us-ascii?Q?uFGnljGmhtrxrCfqh5VZjgumyMxKg0LKxLPZuW3IY0MBg66Lky4qR3du0PQ3?=
 =?us-ascii?Q?nmB1HIcDhIy8fACwn0zsS9ltbSxCKkNTyZ4e+zC4Syht6KkgIo9cSzgfFcBn?=
 =?us-ascii?Q?rlhMOF6Hto7aCjAG30/BXrbW1AxVXJ8JCtEGTyS+NLCZrkGZCimPOxT61S+v?=
 =?us-ascii?Q?MhgaNAfToUwunsQbxXKXnNn3RCUTGl0+IgGo31xZZ5JiWYIPmGs55O3l31U+?=
 =?us-ascii?Q?f8ZlB2DaOqCmoVTRuwHg6SNwKx9C6CHsGd55tLM/CaG9a34Bt2d//wIytCW9?=
 =?us-ascii?Q?ss1ZgM9scQ+4t6YgMDa+teQUZLUpetZhw2zEe6ZmxePmL060SX6QZyu0wCfo?=
 =?us-ascii?Q?YrgL2QaBrHtJvI/FcprGqCCQ7De3vKka9pcxeLCT9K0HAE/cg6fNHcNYx9dx?=
 =?us-ascii?Q?jBrpsZFfxkUiILd7+a9pNBfbmEgOkWjc36g9DMVEn5HV0HABiFWKuf8yV/+J?=
 =?us-ascii?Q?YmxUyd5PA+MfdFqxWIFCBkFszSwCAxvmrvBaQyAo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314a0f29-6337-4a7a-a7f8-08db52309c71
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 15:01:34.1175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laXLfhUTOkHffBiyRaNTu5i5DDARhzubTgvgywm+hTQ72mwVeSQ+q0ZGFr0C7A95
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5638
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_C184A589-30EE-40FC-B337-3E77EE76A2DB_=
Content-Type: text/plain

On 11 May 2023, at 9:21, Ryan Roberts wrote:

> The loser of a race to service a pte for a device private entry in the
> swap path previously unlocked the ptl, but failed to unmap the pte. This
> only affects highmem systems since unmapping a pte is a noop on
> non-highmem systems.
>
> Fixes: 16ce101db85d ("mm/memory.c: fix race when faulting a device private page")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/memory.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_C184A589-30EE-40FC-B337-3E77EE76A2DB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmRdA00PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUVrgP/2z30A6J/GERdz8FtEp4mnwSF7udKoBM5nwA
0VJ6aDhJf32/XcZujHW4FOtcDPMpRKjGgb38Gw7EF73zJy7Vl7USeGadv1dtwDog
4y71m8QWv59UwfnxUrp/tptJLcLFFqs5pPmRZCzEKCroN7d+ixLrulxCpROehHEi
3Q2RPBvnjgcEgRa+/Ua3GMF/BXLDABo/aloKrfcKCuRwl3urVdPFaWHKs9a+IQ0o
4s7BwYTDAIMTFidQVQLIZJ5e5i9Vwljkp6dXzdYk883RL/8bGBmAACn/3Ukk986h
FPWtnsQHvvOKkz20ZLGwjib3UXkp5Vk31UCt/PpBmGNcToKXAklUJPqZXS7YlD/M
mo+NvgiEcLwMHeeM96O4bl8UdZJhAbL4ytnVD9eqQCzzJrlcecfwGO/WCHXcDy5A
Wf2oXJiXKlzhAN4LlxX/sabWSv+EyR+bdba5n2QiKHsV9uCIQC87qc/uDEKEgUlB
QA/xYwbkzNOIL0aexZ7RGJCXz5DA+IsVMJq7Cla1OicSrmOIJTMEOJQ2PI439vzi
n05+IqVw2dM2UIh/9IMwnd26zisQGthGp4nxdfGzSQsa6+LZSVhphdjiUfSk/+zg
ESM+ngNRxVjemYzO+rMshbCsZOHLHLAKbpLeolfTCe+XoGxGY+wlwtwMUdm1+uLD
ZR61gEMU
=nuDq
-----END PGP SIGNATURE-----

--=_MailMate_C184A589-30EE-40FC-B337-3E77EE76A2DB_=--
