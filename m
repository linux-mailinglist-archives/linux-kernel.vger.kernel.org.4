Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5D86FC8F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbjEIO1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbjEIO1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:27:21 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03C51BEC
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:26:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClG+MK1e0A/Oj3orPNGSV2HM94biaGUHJFJwZxG06qkF2aDlQj1qVWTuypATj8W2GITjnX6jcyzonk/zPl0aLNII1IRkz9Zdupu6s+LNP2bA7vdgVfxR1YTdsO6gSd6TRMtbZQmROnIB1Frvj39uui8KuYH7UCx8Cdj0aYdrQ3T0KryK7k0hDpvr3q0upEaDXXCC/enC2iGOeV/qaDYUxhd8SLPoMt9OncoT4lRzrNyHCO9zU9sgITceM0L/B3i0xWfvPmuMINfYX4Q90glEGzSNNfcvUn5rldxjlQ3jy4irs+woVWAd+n+bcoCmrAZ4GNgd+jF/6CaeEW5T8VMBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxoT/QZRFqwQA04MOFG4BQRly1B1I+Cyzyaf+GLQlPo=;
 b=cF2JeEbaosKYIRwWybIlrGpXiFg00rsG0S3HKBHtQSzSIlsLs28Lh0dsx0VfioL//vsxq7Vmi6zkEEzidEWvd0wlxo11RIoj4LHv9h9lKyTCvnW8RT8k5zQPF5X2jJ0IhbcyDrb4P7fqVNp6gpuKbNLlZCMtpbdXHAmX6uGvWJchRzGE1CeO0PMQGWXJ7/IZ0KiDs1cWvZubNCJAZT9CsrlGsQBpDVPUroxp4fDsnFy5OLKHEOsbzRLJQcfVIX8sBr2r/8asyvKxwahaYb31p3y0uTzgAutJpOiqFFZ3sfFQfir0QgcCWCaIKecty5koYSdjnKht0tUsF8G7syvBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxoT/QZRFqwQA04MOFG4BQRly1B1I+Cyzyaf+GLQlPo=;
 b=ppiVIr1ZzescvCe1ClCgeeDstC03dzz4ePwj+1gxcBTLz+ibdg1IQkgRIEhbghHfDGCkZbzawiHrCA0IhK6SlOMYaIbDnVjlkkTU3kHmL6uLxcq2ITPLq3seeFnBQS089c4pkKsgWlyCik02EQS8UxAhzQ4HcHBMNapnj1vHDa3e/1U/xH0ha50BUsbCKgz1Bj0NN5OkBQJriKOlcTd4b+qPsL/5O+OE5VrC3dFKtjHUyFk50FzStRhyHbrr5TakiI+IuYKF8b/SbwDPbSWj66Z0Gzs+MU1oQkV9wipG3HOF133gJr5c0wzFWqc+3rZDTReUEV3038kadwCrOI8FAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 14:26:49 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::847b:988d:86fe:a0f8]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::847b:988d:86fe:a0f8%5]) with mapi id 15.20.6387.018; Tue, 9 May 2023
 14:26:49 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xin Hao <xhao@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH 2/2] migrate_pages_batch: code cleanup: remove is_large
Date:   Tue, 09 May 2023 10:26:40 -0400
X-Mailer: MailMate (1.14r5963)
Message-ID: <69A2F0FD-2F25-412B-978E-57984064E75C@nvidia.com>
In-Reply-To: <20230509022014.380493-2-ying.huang@intel.com>
References: <20230509022014.380493-1-ying.huang@intel.com>
 <20230509022014.380493-2-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_24FD1E67-2EAF-447B-A19F-455B98FB027D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:208:329::15) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed293dd-a5da-4bee-0d9a-08db50996d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcMrlwCizRH2OPZAjdBztv2aoeui7EnYYqXSGZA6EWFmeoJ09yn7e6puyo7plyeo91tN3hMdw6j+fzmMZHrcaPGOC65FhtItDR8l/NuIPrtLGd1qFScEhTwXdWc7o9bwBq5x0s/o9NYjJ17mwBGsaqH+OjR+dantKNXR3dcocj0cfRycLtllaK6Q5uCgVAHR9jO/NHKL9GI/J+NaB/6ctgoXZZFhzEMoDgz+q3YfQdJYovI2JQbXdylC4NYlSXRpzBNlsFybN4vk5du6K0ETqRaOc8HpS8nrmt24Kpar330YkXYzd1oazYNcdTYxIFGUDCCWgfjGMpu44gBhmu3ULXc6V2KnCmJhvcgj6nsSttG2ZDT+ZlyUyvldN6MjBF8k/ZUAnOBvrIXcAqTyJioKEthDLdFyjWxZUbkdT0bPotm0uS+D8jfn1YhkQGI2AUJmEfc2q7GLYTbRDjIWdFtSa8ucANIbNJ7bJoJiPhWoNu4Akmclmgr//rU15NJEjjhOkysxOJrQIG7FRJGdK1zcf2dsITsz9IXwp5nAwgjUCuhHmk3GhLxJp6bGQJzO3WoW1Gpi+VGdRn3M9h76ZlR3Y5hl7UKRYAHlMfLfXpW9Zps1EitaMjr1C3X7VYQKvGpzgFMKFyhzVVXo19t/QwvY7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(2906002)(8676002)(8936002)(316002)(66476007)(41300700001)(478600001)(6916009)(5660300002)(4326008)(54906003)(6666004)(66556008)(66946007)(235185007)(6486002)(107886003)(6512007)(6506007)(26005)(53546011)(186003)(36756003)(2616005)(83380400001)(86362001)(38100700002)(33656002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f3gd1NcO983zuChTYLhB+3Za2j/ikVTQmmaLajfIXOjbgAD8DhkNt/zdGJYq?=
 =?us-ascii?Q?Aam5bHhwGjUb1m93/yjxJW94m9dyX+w7JTx1lA1NInOicBBkfV9b5WqvGir0?=
 =?us-ascii?Q?BNkhCRRY3Yry3g/8dMmqU/qjpcsLtanNuOzwEtGEKCKsQX/mEae1dlB0Ydy/?=
 =?us-ascii?Q?guTX6eVAGkJ3JPrFZ9wD+Zv/XtCQC2qYnUwzFaDeSVvqhSphmayQ7WXURWXF?=
 =?us-ascii?Q?emJmJxc+b0Q6TjhWOgyfVoE7HLnoc9MFs4gLqq90lM4E+LkHBEOYqfMFmq0Q?=
 =?us-ascii?Q?sSwVxXfaRD403CG4LEnLUqLUK5je5rsHWIeD/7g4J30dkiAUzD2HITO2n1K+?=
 =?us-ascii?Q?wXTAq9ojx/AMcRdY+PlzPFfuBA+Z5d4v3imcLD5z0T/d7OsgGhsh6It2wqq6?=
 =?us-ascii?Q?SOEgG+XtkMjzlG4JeqhHrO+l7Dry3uP8E1sbPc82SD24T1Dyv6g8mEDCfRmS?=
 =?us-ascii?Q?me3fvu/A+fr0lVwgGQPLkkjcxoMGrVfnmqhRGTk+TspKT09aM60/WFL0hngq?=
 =?us-ascii?Q?F/RiW3+f5jFkj6wR0aGhCBJUKTKuRQDuYwARvGMEoZjRjexhf7t/iL8VhTLF?=
 =?us-ascii?Q?imtUi/CJonNgd4JVneFZo+TlAjpg7evBecevoUnm+WGiAwYWpELd8lxGzJrk?=
 =?us-ascii?Q?qVcYoetnPDACmbhvoJnlRLaoFjNcclgfUd7nVvu4l3kbGinNwdgb6/8bxk1F?=
 =?us-ascii?Q?+gi7cZNAi0RTzPvHoqug+KgNKS+VIKGd2V1laBMWFHm54w+LklYzmLmv9zdG?=
 =?us-ascii?Q?byXtpqcm9mBSzgWCb+PA1NHgAHGNaYP7Y9fcyQj30CtSdGPrGXKonxjfIg1S?=
 =?us-ascii?Q?/0AQFjgOTsrTLsNlAdYEKgJYpLLFFMn2LBN0FsRF5XDpkbCTawkAq+IGMjbL?=
 =?us-ascii?Q?u6qemsRnyqHoaM+wDlKi35jdeiokk8316d/dokZVAe5HP7qFP/JYSRbGFrk7?=
 =?us-ascii?Q?6NMUVOMwvaECUXX4+L4+Y8K4U48I/a/T+b2lrGJ+gQf9uLR5Et9cluRFor+w?=
 =?us-ascii?Q?yGX+8wYz0/5y7QqlVaI8bi9mvkRJRiwvHy4bmb+L7U3n2tAzJMhsiP69Rqg+?=
 =?us-ascii?Q?rUAm1lYqPQIqRCQpImXuLrj6FjADkjyd483PvTHv1ZNiJfHYOB63T+hiEmyJ?=
 =?us-ascii?Q?z3VLbwXxdG8TRtuKkExmu+aC8Z4jjAI4ztAFCfeH9iiTM+pmATo0N8Fx2vDc?=
 =?us-ascii?Q?4aUVqYwQaPzLc7emPWmGGSjSApTCCy2tPM51H3mJZ6as/D/AsPLJsoE8AliC?=
 =?us-ascii?Q?Tkua5h9x0CEj71YQDlABcRL7l4NCR8aIzlKggG81/yKr2Yo+g1PaP7arPTRe?=
 =?us-ascii?Q?YQ6iLmkGQMFdnU3HxOHu0lNN1ygZJGPkQOn9Pk7KOCbwBCJ9Pt9cI+8TciqY?=
 =?us-ascii?Q?dALe8cnoKZ4ZzdDO+w6Zs+As1Rx/EwfipSDHz/iWcNMi1/9G6DM5cXI64ha4?=
 =?us-ascii?Q?hH2OtijgjSw9WVC7rgP2wBAcL6WY/MMZJNwcvg1pDmw5TnBTtEilJs8yAK51?=
 =?us-ascii?Q?q17yOECds0iYgzq2DholXT+xe6TmXt+EXmxic8BVDW4UmzzQVSwUpfg692pz?=
 =?us-ascii?Q?YBtLkvHz/ZKDLfQykPBHg4P5BOH+wNb5lJqI0hL+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed293dd-a5da-4bee-0d9a-08db50996d14
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 14:26:49.4842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bt0nJXwbgHgnxQpYDl5Ej4h6Xlj/1QMhH8NdmDwb4+ICcxy2CCWRAvTrV7ME7n1e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_24FD1E67-2EAF-447B-A19F-455B98FB027D_=
Content-Type: text/plain

On 8 May 2023, at 22:20, Huang Ying wrote:

> Previously, in migrate_pages_batch we need to track whether the source
> folio is large/THP before splitting.  So is_large is used to cache
> folio_test_large() result.  Now, we don't need that variable any more
> because we don't count retrying and failure of large folios (only
> counting that of THP folios).  So, in this patch, is_large is removed
> to simplify the code.
>
> This is just code cleanup, no functionality changes are expected.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Xin Hao <xhao@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Alistair Popple <apopple@nvidia.com>
> ---
>  mm/migrate.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>


LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_24FD1E67-2EAF-447B-A19F-455B98FB027D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmRaWCAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUeXgP/2r1sXmQvXRUMWFqRNfmlr+GNYnLdJ4MVx2b
bMv/ryiPJo1aJPj6fSF+bDuCpAzJCd/5tWZXb1FBoJXd4v5au8TgZO2R+bGhrlN9
RPIW3sVBSwePkcgzOdbXj/xJ32KRtXzz953ZES+Xj6YbEb4ksw8czBFvQMKEtUPY
qfkshOH3G5opTqYf9nHbKmNNjblwTEoJwh3m7Q8TcC2+cMwqhe2zdSnnrrBIaubz
s1KHoh5TKh32C4rHZy30mhKUKrdPlz8VNvwWpa11ttX5RwY0hgQyvlM2jVxsbru3
tXrFdhLAcNop8Xt/+5F+SQlu4khNAHZNard4vqRsl/RKPXEjznEEYklhmb3slnUo
IrI1PYxzx9s7REI9IhXQyh89G/oBtAyVb7kaoCDhj8ApeYdf9WXn1CZr8y40g93J
06WauYAKmmPJ8qZi3gYUf9UXdLZnYRyWwPj9AcUB4ISig3oikB0rToWB5QubWx1b
rDj6E09emkgXPBLQGVxZOT5n46zuvhRpfy/WpD4DiEGzJCBYnCDsITOzTZTOTl4w
zi2a/Q9CFQkl9EHC3vU4mKzdnLTuFM+rY7nUdhXTNPEeKazx+Rsmf4J8//q2r91H
w8XF/A9LDlLkW/xVbPRwrz7BU1URIHM3gcAcJ4IMFSBBRoyk+1vdG+oRQX/7NX3F
FHNBtLxr
=PtDj
-----END PGP SIGNATURE-----

--=_MailMate_24FD1E67-2EAF-447B-A19F-455B98FB027D_=--
