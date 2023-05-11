Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5DF6FF55E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbjEKPBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbjEKPB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:01:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BC7106C5
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXYoYvuk9FxH532j+bcTBcbsMkNeTLAJ3cIEHSn3LeVsUDEHIzRa1cz8iRhG6YOTCisByszzqLtG2watIA+uXgq5CFkDaXoa+egHR758DnvWw5esogYp+wkpuKcmpsVCZKMKcTsjiiLtDZbsdA9uFUPqsRdJXVZxuACUJHOpX2T5ae03ypAF8Anvg5k1xdzwF1kUiSX+z+WoKUb0UEqkmJanoBHZ3G0lKVkz+xa+M+847Ylpb9yCIx+RN6qZ+gJA8x1SaUoJBmyR8rwqtWYidIE/lfDYj16ecu8B0spww+E8JhqI3ZexladPp1M4QmD+q+8J0XAA9VQL6VXp2o+Khg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPAvK6KtczdZAoCfECMAL4Fncht5KsST0n5gG2X0bL4=;
 b=XV93DbzxeFQx7X1KVkSG2GPSMecHz2v7+LJOSpjOqjLWatNvono/Em+O8Un+nAGC/We2BjEAhg3NIGDbFT3O5AM6qExDSj5yJZof3qmYkB2TRdndBEBR2bcSunb+1V/vjIAzKMqa1wuG02UeGJyg0hhlpW31x9CBdIRcq7WDIUw3Apmv4IYDhGGpDVfck0UDQyfhTDAfdp5auIlnwxrajf+sV3aGIw24J5YYS4lSkb6sZUb/+MRJAzmUGbM3yO48WZFnHr6G7IQ6aolqPK/NArBv3Fk0IKIOs3UB8Wyri5k2ZR72NbO9HKSdkpR0B1ZCTbmAMRBIrONnXkQUxt813g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPAvK6KtczdZAoCfECMAL4Fncht5KsST0n5gG2X0bL4=;
 b=FiEULSedqTXTy5go0zTdrvHy8ooN/xvIa/hHJ41rTfLIG1pJBtgL4TtNuMeAo2NkbzsWRlcX0D3RBcHkMw1sSiv09zJoaEqC9oH4wTt8eHdfZNGeU2mDzECc2rn0DqaX4JyhmYYnn3DN35YHDT9AZpIPehcV8UBSNs273Lnccg+p08GMKQjVHYMfbOzx6TBguBLbxoVZ0Yn60mwYMKNxLmTFRTZzbQJhLUkK/Odms7mjA5wIAo4Hi5r35QGDDbJCgTYqAV80LL8yafTZfyinpQ4oavpF6uvlm/nfRcwfU5d9SLrqgQDtnEAF5FBY7dPPwjqi4NqFwZDvQUgiN2iMnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA1PR12MB5638.namprd12.prod.outlook.com (2603:10b6:806:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 15:01:14 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::847b:988d:86fe:a0f8]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::847b:988d:86fe:a0f8%5]) with mapi id 15.20.6387.018; Thu, 11 May 2023
 15:01:14 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev
Subject: Re: [RESEND PATCH v1 2/5] mm: damon must atomically clear young on
 ptes and pmds
Date:   Thu, 11 May 2023 11:01:12 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <9F292AC7-6632-437B-9F9F-DB3CC10240E7@nvidia.com>
In-Reply-To: <20230511132113.80196-3-ryan.roberts@arm.com>
References: <20230511132113.80196-1-ryan.roberts@arm.com>
 <20230511132113.80196-3-ryan.roberts@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_0C62BA84-9682-4BD7-82EA-B7380486FE1B_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::18) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA1PR12MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: 892acc35-c606-486a-3f50-08db523090c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sR92dKGxHgqpl0U68n5EzHjzMrZE/gOnWsjRdDK1XOmiaaRKnEfga+DSsi9zki0UDyij+qBgEQgA62hJZUMcBrEgrT4w5UPtCBfp5A34kwzjiYgzqT+SlnJQUhsBEvMpbEGHHl6dvVLEcj/xHpmG47PJqwDPA+2am2qmPpE8PW19yjboBN/wklR1MPT8AivI/7elHVUSQnuh4YK1gGd9K+UWkyF75EaUAsygj5y14nWMFWHnkFTCCI0OOR8BkmaerbHWavMdisoTrJnz+p8TtZmFqpQZnyEicmw6a9O6c32f3WgVA2YPP6h8LVWFM1rWJeyoQJpCCYDpPWGlFInxvJElXG0jDseJ8YACyTy1MN3J9/4Bp0t/dzC05BinemchjJQwkeIzPj1OduQ34lXF/MHrR5kdCyyatDYRsyXmgYEXWbQVy3NHcqfv3I82b3yRFc6eh0HYNwqh6ZiyOmk0oakitD/eY4838iBD5vLEUpMnTCgKwgPLHvebe80FFM1N1/Rb9N8OJUfKPwAjgmrBakFF30HLTIORXaNJNzVc0e5GeIDtieJgFJ5ov42YVNRHQlL5CvN6lR3xQ85Z6AyjwCObNlCbIyguRcyQ7Pq0d2jl2o1lknoD7DuhCroumsyOTVtWQbd8VonTagSiHANjKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199021)(186003)(53546011)(6512007)(6506007)(478600001)(83380400001)(26005)(2616005)(33656002)(6486002)(8936002)(86362001)(316002)(5660300002)(41300700001)(38100700002)(8676002)(66946007)(6916009)(66476007)(66556008)(36756003)(4326008)(235185007)(2906002)(54906003)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lqQPUDTyH7xFqcNBDrEpTQXx2HlbXU8EYts1o3kc6IGJSUfprxUhEDdTZOXG?=
 =?us-ascii?Q?e4cPjXmKMjZx2lHJFCJPAJycLVEOrr6I+6TWWrreI0uWG2he2Clt/QMyRYgw?=
 =?us-ascii?Q?oAi01NBzAQTGCsBpBoMzi0g/x8pRIRPOul2FB1pH9JBrsyu3VDKPBDJFe01g?=
 =?us-ascii?Q?YjQbxKKVQAHO05xZ4RBq1LnRG0QY6HW/61eHw6VDI1Kc98ijkPhxBO63Ymx7?=
 =?us-ascii?Q?4rynxCXK5aJx+C5eDvbCxcCiWMr2nWaFIPafzlOEFwKqbAuktt76hHpsha7X?=
 =?us-ascii?Q?Z9KIEs38LPjGiE8P+7v+OaRkpOvlIJCXx9TnG4EjBZBnmqQnOtGJRg7CUIBb?=
 =?us-ascii?Q?pqAQn4/SBye0JZ7m+lDWxC7m+dOjO9/m6DBlM6Mncor7/72Y8P/U+eiVhlds?=
 =?us-ascii?Q?9PgUrvvGZIWUlbmCLQ7bbc0TEl+nqKtzWdhB3ZO6rU0L5BtecxAVte6/W364?=
 =?us-ascii?Q?GVK817L/iP9Sx8UQ4EcueQsux1MGaGzTWJctvDjWYiAn1w19ETplpcTez12c?=
 =?us-ascii?Q?4aREtbVhU1nki0V1gnKw3mQCzEq6XwQ7yBEbAaiQMg3+AtxP+x6Mtu1ewWym?=
 =?us-ascii?Q?XJSoGZvHmSkX9s9EYAcH5jM5SJX/y2ppV4MApKoQzH16VAoASrs4p5pDjKkz?=
 =?us-ascii?Q?sYnQZ7Fc2UaBW7EbFl1CVACyTnJsjyVY3cNZX95b5UT5/xCucETTQUTaO34o?=
 =?us-ascii?Q?fVRvyDZheDRKc2SyuhOuPdlg4SDMQASYnboklbssZTJfpqeWgFksjaGknjvs?=
 =?us-ascii?Q?jXGWJbKcgKn1BI5OyK8fQ2ZVoers8UT5rP5yNo74aqaIacdW1RHLio0H3kGa?=
 =?us-ascii?Q?veCB9OkBYJZXZKDbsKabqWS+AUIOFRP1qGO+2rT6mluq/Lb0d4Ep6FoIHpDY?=
 =?us-ascii?Q?dpBxi0C0b2X2HG9ZIa5tVPXRPyl1rRdWQ+vec9FHevrY7JkNyF6qOEVwcSzn?=
 =?us-ascii?Q?j/aQfCn6/w9Vss5iVCmFsvDPaYUHetXMUyP4zNFulbhMLK0ZcZdAzZVZ/sj2?=
 =?us-ascii?Q?OL/7Jk8YOY2sUHcSSCQYQQ4g5oQhMG+n06oaJMmjTqgzRbAIzBTfOb08fArJ?=
 =?us-ascii?Q?UdJdgdArVxYsFq7APu6hITkkcWQLplxg9lZgQvogeskSnu/OuVTqoZbT16yl?=
 =?us-ascii?Q?4vWOLwDs5qAzVP+Ijd8iKw225Z/7WcJxQL9yiEDcMiiOQoLAezNTev6GoWLd?=
 =?us-ascii?Q?no5HSsyy7pRamH3UU+HRzTqcIkvWJDhOKINynbNoCSPjCslpEInOQblfovkO?=
 =?us-ascii?Q?INcteXvCs8SlFex6iRbYnuA6HvlS0a469eAQnTc25+c72lk+jDw06wmSuh4n?=
 =?us-ascii?Q?fS3iNEYq0aWTRGNyD1e4YsB7eEIPLyC1k+Ds+Zw/flai9fUV8LTdBiHIC49N?=
 =?us-ascii?Q?cTBqGx2AnEL7qHqV/TtfXXTm190ev8YclhEIJBom40cWT38HExrPWgKVyBRg?=
 =?us-ascii?Q?N4nCjSfyHotKEqEczDNqARkKa+2oxkX5jGKpYwKgkfJZF4FaTRSCd/Je5naL?=
 =?us-ascii?Q?oq/cpCE4/ZUUPCS7h9fsJmpfuGo6pu9PvrkzN06UkB8wF9cz8n5Tsv2OFJtz?=
 =?us-ascii?Q?rz9ddkT7xKZMhLN5t3RwgJcCzPdz4URKumCi+VCf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892acc35-c606-486a-3f50-08db523090c9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 15:01:14.5909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1LtO9xqHcpRVHfyALCumUYlTNCpTvGUzb3RnTfa3Gx1p5zuGmZ02VsrRq57jLg4
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

--=_MailMate_0C62BA84-9682-4BD7-82EA-B7380486FE1B_=
Content-Type: text/plain

On 11 May 2023, at 9:21, Ryan Roberts wrote:

> It is racy to non-atomically read a pte, then clear the young bit, then
> write it back as this could discard dirty information. Further, it is
> bad practice to directly set a pte entry within a table. Instead
> clearing young must go through the arch-provided helper,
> ptep_test_and_clear_young() to ensure it is modified atomically and to
> give the arch code visibility and allow it to validate (and potentially
> modify) the operation.
>
> Fixes: 46c3a0accdc4 ("mm/damon/vaddr: separate commonly usable functions")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/damon/ops-common.c | 16 ++++++----------
>  mm/damon/ops-common.h |  4 ++--
>  mm/damon/paddr.c      |  4 ++--
>  mm/damon/vaddr.c      |  4 ++--
>  4 files changed, 12 insertions(+), 16 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>


--
Best Regards,
Yan, Zi

--=_MailMate_0C62BA84-9682-4BD7-82EA-B7380486FE1B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmRdAzgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUSekP/RdADZFCE+icd5hp0JxNHvFd4IKrb+ZYzsZ6
gYzmAAnoU0XFtTh1nZNvmbVZE7ITtGH9IgnLXgrZfJv6NC8WF5lT9xc5F0IQww06
8EqWPOpgHg+bBZ7bqprWjYxbFI6XYAdif9Zpb5WPrTjvecXhsgGXpC9ipbuetBAJ
F6vvb0/TkWSTSPd7VHr8dHNQnVpD4lP1wfDOCHOjTceE9COhNIiMYPDoq5YnblNq
V3JDw5u4gDjikYXdlVmGJV0kWNpezGCWsfCqf1NMR72EtWAANYzBGdZuaqJhiI8S
QqWHPDQUfUhEMArsWvhZawc45oTDNF9MnZLtP/DJhJEp9h0H+vALz/fTG1S2Jbxr
1VYUYYO9COCJi1UnlDyymwMSoj9WkfnYXJLxRxKaXE5R6YSiPRh9RAp7NtycJtME
lL4MEAkiFkTTjKiBY7tt6XbXyHwZOCbw5y0ZxbUIlZvCW7r1pZuhqYNQwPI1vR+O
VfZ+y5sDFxv2bf2rEdp5Oe3ksy4brelhRba5xPFu0L/VnyGPupYvBG4c6Z1RhLF9
t5vH84kgOUlx+MNMMXzYJA82vDW5Rgw3yhByJ0S5cUFoDzDa8hCBOjPdTNF/OCcJ
SBW5U5NYS3sYzFAbngMq/UaETZ762RQ92ao6fJ3VkRPL3s+kbaKSrYs+hMSw3hK2
L7dgGfNX
=JJyb
-----END PGP SIGNATURE-----

--=_MailMate_0C62BA84-9682-4BD7-82EA-B7380486FE1B_=--
