Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE90B634F28
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 05:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiKWEpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 23:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiKWEpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 23:45:41 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6337ECC16E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 20:45:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RizZZc2y+XNKSLtMIJP9iK3NzjSLi60GO0BC1o5GfjglC6cV4UljdhFN3eIcX4XGjQga7VJRwGZQspA0xkRF0SvI2oTYrH7IUUci8pO1Jyv9Il7S6sIvzkR3acTBenUvAAv5yyW31q2XKiGdFpWLToWTVqgsmHEQGDryx1SQphmJdFLPGbOTeFCw93E4oyCNphk8hhIXAW/kSGB92caNm7dB33gniTvUdkPexf9HiPejRRgCXLCvOrzH4Xb3rLSiLUNr7Tb+VREBbhpwMCcT2ebTKV+fxmkiyAnxs5FaXdBsVdSQdBbreXe/i16W/g0Hqo+2OUNNP7+pC/6w+e07NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lr+G0fvjU0fBJ+Rx3zl3M6BEUoBn9KbCPMMMUfwYfA0=;
 b=WG6RbOB2wgAF4MRiwoT3yf3db+eLeGZ0Ti9sua8f+1iyHo3+lO5UQjAMFyD/23vFXkdu0DFqE4215xvfx290R3OMMCm53IFDUaofpGeUr5um9Ea6al6X+VkZZm1dhQYroQNZDkADx3KpgrDdSrv7+CWyb5ZS1RnysZlEeClYlETCUrdqgjgYkkSV76Ma/VKgGQm/k9qonWFQ0r6SMsoAvFnt3bQcZQ3safWIohE4BgGlKJVAAZCZlAm0vv8WIWNBJKfhcjahA6FL9jhfKeXNrLCR12SI6J4TnxXuSeiwCZnzFCeggkDl15VO6Vletq7Q2C9UTN7VhOEM7sUSoroJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr+G0fvjU0fBJ+Rx3zl3M6BEUoBn9KbCPMMMUfwYfA0=;
 b=HGpgdecmVhN2h6rlpxPRULTS7lt6bT3swHaVWj9fFSU18ZqFAA8N0A/ZWVhIlGppAubbB4XRlVVtZwLDqhRwcFWbGd5uSegrhdQHaoC1KZvxIh0hpKkWu49naDqEjkDqGn7+xT4FMG58Eujt7fV/0AujYQRE0aK7yWlruYWhnoG4I+b1x54X9ShnS79wqA6IpyC/r6ifWLkQQbcyrCGcpQ/AatULq8vxsVEiX7+/bbZ2IKoeGEtnqDK94FtVWU7/SW1sZ6vXqf/Oo0v0ZqDTmeXbDgkFDKdeD9maHjaF6WLFQSZVV5/DmvQ4BNAMNge1TUb85El1pvyssYmfqReO4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 04:45:38 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8%3]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 04:45:38 +0000
References: <20221123005752.161003-1-gshan@redhat.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com, david@redhat.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH] mm: migrate: Fix THP's mapcount on isolation
Date:   Wed, 23 Nov 2022 15:26:25 +1100
In-reply-to: <20221123005752.161003-1-gshan@redhat.com>
Message-ID: <87sfias2hd.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::6) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CO6PR12MB5443:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c8547c-5273-4aa3-40b9-08dacd0d915b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mD+Vc165R6oMZMq+V4vAZqG8AbiHGAdknxUzFxsAcN/SvpqQV18bPiE5jT6RElTFSPrfoJIgLgmtmzO2j/V7wTFBVHLmuze56oZgUoGmZ0+zL+SMGXnAr56cx56ZJcfPHplJA39nmBeHWGYEUZa+Z9NRLgD6L3BI5haDBFYqtAZ3cvxuY4Fpn3ZvWWAGHfLsnwEPWGLrhV3DWOPcevYuZhTVNlOZJHWigJqhEnEhaJ5MVG+I2Z+lJeXfVX/yEi8CqE1eWmHFfd4JJcqFB3+5zi+nMTFQAqzxqxFdliXGsHCjWeNj95I5i95rRQv2Ye+5ZnfANwv0t1YF5qfGcivH0tUpqirOGj6cqnZ1EUrMh5T5wnzDTt88Cr7pPlld8L/JffdFVdcBKo0cQqCjVQ+ag1pL4Yjl6akF0DMbV6pA9FeY09j+b6bM0yHioejLIPgFBJdJUlsZtDHx83sLyL8by/snMZ5HC2/mP74Txj0VyqZAkRNX8NqnSlAtvPJ+SNp7zp81/tl2zLmP+DTz679L0FJPPD5v8HvAxFKdKW/LzpLXixeJtJ/gmI5yP2xx8DQPALKA64xSw7/rJDhn1S8g3VkqumVEPrpJSR7Vqd1Q0Dwoe244FU9MDIly91p0xBMG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(8676002)(66556008)(316002)(6512007)(66476007)(66946007)(6916009)(4326008)(26005)(41300700001)(36756003)(6506007)(2616005)(6666004)(6486002)(2906002)(38100700002)(83380400001)(8936002)(186003)(478600001)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vynIw4jZj6P084QgTFaylCqAL9ZWCVnXy3+YBvjz7KK9fzRUXDfr4Qjy4PO0?=
 =?us-ascii?Q?oicCgc6DcKKV5jj50IkiXOR9raBt3dcjJKsabdB7XnaF/HXg7Au/fyBTL3/Z?=
 =?us-ascii?Q?MRWLHAHTI4MT+2YV0roIoudFi2fXT2Gqqd4WdqSokXhbARy7I8kuKxzyw0gG?=
 =?us-ascii?Q?EXdMBCOwS6AOLk3DhxR5FK5uPgfFn2HGPH0DPNATer8F1hV6+2Uw8XuDRW+b?=
 =?us-ascii?Q?Z1OGkgKxWx3Mkja8fH9cPvz4EztKYLq9jskN/AWNHIoXj2Kr3obE5mCvI2ym?=
 =?us-ascii?Q?npUwijxzlU1GlvmywzHK+BE8jiCUzESy266WCy7D4JDllF1wGbHFVPeZ+nYR?=
 =?us-ascii?Q?W44bzt9BK2luN2p/UtoeA7dU1u3moH75Hvo4Vn0dYloW1HlLB+VgCmPzNbDn?=
 =?us-ascii?Q?3w46V5r7y3VZlfHWi6CojcQG152OB9HjzPXmvTU4t6Gr/h71xrj3mdnHA7Hg?=
 =?us-ascii?Q?ZvfBPiL/zh6K9s7+eMD7unBx6crF5i7x7DWF97tCREgrMblK8GOPZzqIC/5T?=
 =?us-ascii?Q?pCzWoIODMU3EG9iC+ECPz7oWmTXHPL8MRUJRG9t/0bZT5c/3cBSsh8tFht5o?=
 =?us-ascii?Q?zmJVY1DKuj2lBRZxaE/XuHp8mVUUner+xTXG3cD+FImItAqHLN19KkDaWBMw?=
 =?us-ascii?Q?sTmudD2eSY93NkaBFLd4NbrBZH4li2chkf4SfTv+qFdO8ZkbZMxMcU7QFiJS?=
 =?us-ascii?Q?TzwGMCi8+I1k54mqhKsptAOnEjZirv1G1bBIZJ/iNJHJaIuMdm0JrZ/vKwoO?=
 =?us-ascii?Q?6j5h26BYAqAetP5p4LYsMtpYjRVC8oDr2rUpAE/mwUhBTStPk+KMEzlFCJ6G?=
 =?us-ascii?Q?YAuQPerOPDjFk5xtqrLkj99DyrAUC25sJBf5ehhleaWhYMoOFLB3PeHY3sYg?=
 =?us-ascii?Q?ArVUfp5mP+WkaRY9xNB0MT9dAE8y1ZOywfQvA8wcMbrXoxa082PESaHVDgIN?=
 =?us-ascii?Q?NkfME7VClZPJDxYG+qOznmCmu6sjnUwMDVHgVoEMlr6/12oQaCcqBjCnw6tO?=
 =?us-ascii?Q?9NFlk4nHy3TKgpQjo5YtjmeZnps8PsLiiBVgpO+XqnznHG9KFRFsBCF+EOcW?=
 =?us-ascii?Q?z8PT1q/JAzwBj/RN+MaMPFpC2defV8dPV1skdmkxQUi2NAIFfyroQLcTsw66?=
 =?us-ascii?Q?YzhuGQ65GRrO+51+LO6sCJSAQMvOGabgaTdtF2eNXRA8mE7OmqqlP23i8Hp4?=
 =?us-ascii?Q?70Utbl4LizAZwHe3ZGGcbvEnSCSkzaD0TSqCl5K077BFbt0YjksiQCS7d2iQ?=
 =?us-ascii?Q?VH9TDFPBq6t4TTcohNs7sfytFVtRxxc0V+xaav0FSSRjGqaPnq0pSInZogEk?=
 =?us-ascii?Q?Gx7xw/GP3NQyeG7g6Uu41+d5dUdczHZGw+kOft/6UWoDTAYhnmll/FXCH8bX?=
 =?us-ascii?Q?8Hk9Uiqs/egEcnGeLcvOBLJGDY2Vo6B1UzVRRR+trSz4nkB3TMIfV4NEKoXE?=
 =?us-ascii?Q?sClie8YVkhFA4w0KhQ8a4NO+WdNCa4v4bR6EThs9USCjqeq/w5w1xT6vSieF?=
 =?us-ascii?Q?bZUzVQUo2+k07h1MB/l+pP0K7JHv5Du84Mxwq3sT/d62E5cvP8QOrVV+qP0s?=
 =?us-ascii?Q?3y47hGPhdmPQInhYA01kVk/J/koqd8ion/FI/h4+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c8547c-5273-4aa3-40b9-08dacd0d915b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 04:45:38.4698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAxoV7uF3YI0pVz5Mpsz+RTLaIefFnYaRIkDkluW0WrKPI2wJIEHF+E0U6HnIK2V27HuoEulMLFq2E4Me2HZwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gavin Shan <gshan@redhat.com> writes:

> The issue is reported when removing memory through virtio_mem device.
> The transparent huge page, experienced copy-on-write fault, is wrongly
> regarded as pinned. The transparent huge page is escaped from being
> isolated in isolate_migratepages_block(). The transparent huge page
> can't be migrated and the corresponding memory block can't be put
> into offline state.
>
> Fix it by replacing page_mapcount() with total_mapcount(). With this,
> the transparent huge page can be isolated and migrated, and the memory
> block can be put into offline state.
>
> Fixes: 3917c80280c9 ("thp: change CoW semantics for anon-THP")
> Cc: stable@vger.kernel.org   # v5.8+
> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  mm/compaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index c51f7f545afe..c408b5e04c1d 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -990,7 +990,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		 * admittedly racy check.
>  		 */
>  		mapping = page_mapping(page);
> -		if (!mapping && page_count(page) > page_mapcount(page))
> +		if (!mapping && page_count(page) > total_mapcount(page))

We have several versions of these checks for pinned pages open-coded
around the place. See for example migrate_vma_check_page() and
folio_expected_refs(). It looks like you could use a variant of
migrate_vma_check_page() which would also check non-anon pins, although
I don't know the compaction code well enough to know if that's useful.

Either way it would be nice if we had a common helper for these kind of
checks. Guess that would be harder to backport, and the change itself
looks ok. But why isn't the fixes tag 119d6d59dcc0 ("mm, compaction:
avoid isolating pinned pages")?

>  			goto isolate_fail;
>  
>  		/*

