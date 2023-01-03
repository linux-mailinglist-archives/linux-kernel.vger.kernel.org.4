Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9EF65C6CB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbjACSzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjACSzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:55:33 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B2B12AB3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:55:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8CKUuclEJxYKOXypQwh9AvTcLtm8vSNTpNHDaAnkNAn6M9+LwGfIR90H+OE+fbpQflIpiJtAB2llboRedf8CsIR5NaE59ZAd5m+gw2GNQ/8qAOJQXY9WtqiGJvmxF3YOiP9lziKEIlj041mq3RVqjwiInk7nN8Qf3a7bkZUJXhR55T1q2LGVfPT34Wn6HePMZzdeoaZrAXfsfN7rZee3Bzmwt9mj2s6VoGVVDNNPN8CnlOGtDigRjlYUh1kY88/itQ+7rqxBwqW14euUJ+kHrRFb90oqJETSIaXNpaCzUuNigJIR0O85NAm97PWQhjqDK8ONil0Dvu6n9uvt9Kyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/79a6beyCYJBgMu9gqrC0+UtbvjK1Ke97P00GoveH4=;
 b=ZiuN3MLA6XwzwtePbAKF8UVscxPRO7EKD6PnOv7t39HQsgHEshcMIUc0OWxlG17ovptrfIZDb0Xe37uTFTvrGesWgtKuDOs1qsx3RDcxDRa1bRv6KKQRZPDmMnvSbGH5Hp2tr5ah4teHe3BNOpFbfXFvyCL7HhkBzV3elaImeyeduv7V4QQqNXPKNaWz4EFaG4NTLAZm7oie+ePcHxHq49hnCYtx/AvC+gUadAj13FQU+HyWNGMpDSgHF7jqR9OpgqhsMTKcq08PGimLVeY2O1JwWXLKTTZKrp5BYfPc28R8mMMfna/qMgqwupCPbX33nxRo8C32tsePCOJmwU1uuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/79a6beyCYJBgMu9gqrC0+UtbvjK1Ke97P00GoveH4=;
 b=QymLgGm0IiCRO+fI7GTRcxChkM9pBWtm7JIuZxdnzqO5VVNkixjFAIafZSaZT8N59VPKsSTKEKAWovvdIdOu6vVIigU4O/s87OFGN3RH+p8deF9Bsx67c+DDoNfAHwM5S70vp0XSGBaoyoeEpqZlb58PuE5gJhryQEisiHzOPDZYucQ89rTuqa6rA6gyJdlIjJFizOlOBqQdGbM1tP82jhqxFz9WhuwXXY4dVttbIIfJ1jD97O6xzf6Fd+4tvqngc2+tKiLQM2zQFapOeWcUu3hgwLjofpbqufsh9lVez9k1l5TJADAxjPYoHuB0MuEpJS3iKQjCRMqmh6M0G68YlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 18:55:26 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 18:55:25 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 4/8] migrate_pages: split unmap_and_move() to _unmap() and
 _move()
Date:   Tue, 03 Jan 2023 13:55:23 -0500
X-Mailer: MailMate (1.14r5933)
Message-ID: <2F103F3F-6CE1-4832-B6EE-5D7C2D405FC9@nvidia.com>
In-Reply-To: <20221227002859.27740-5-ying.huang@intel.com>
References: <20221227002859.27740-1-ying.huang@intel.com>
 <20221227002859.27740-5-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_DB4D7853-80DA-41FD-9F15-6ACC3F3388C6_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::11) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 874406cd-2501-46d6-be80-08daedbc130b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7G5MSS+6MeFZdL0Suf2v64M5rFKwqFPTjddOr95PNJXC9T4MuTaxrWur9nPepBCxreXpDJlLVzGrDSfzw+nN1KlvI+sU8FGB1prW73Du6ABAAxxx3Iei1qbx3AyCD5Lp0bpDyHHZVFIWfpzNP5pLKMt75p/Z9LgT7e2q3vpV3TqQP5OK+SwJ9HEIOFbF28a0gizYsmPx/TbkxfyElYfdvtWDJmlRaDZA7k/z+zW1+NXJt5B2zW6jXsqvPWeB2Yh2p/xT0zmKhrrhoah3vdF+Xpk3pVqB33JHx9TCIlD49fTWzIfrkwaDBDcbgs9wcxJWMvNkfZM+ZBWH74Yygm7oMcD2Hohie6JCpvx0xH0z5AV0j0vE27JHVCfaIBA4VGzQuoHHmAzwF1zQQHC9ZItArtcsvGL/h8VKtXxQM0KJKaoccilHz7rBRYKAtsnY+9gKxsTP1h/6EmR2ir7h1cyk/EKTciqHZErlRA8KyLMpMYihHwwGIcjGzLyJVgGRQBf8IpgNXfuXXKyJIKbCNEmdWnTXUks4Mc7j77bfmzPXqOp40+i/q98Y3iuV13n3cyZyI/xoirr3kbACcsFrpFzbRGZlT1jdtv0diaqoxAEM+xqZEY8Am2suFJ3vme3DqCHGMLJu3d+rBwxSAoyGMGDFIo80aEmfcuzkTbstF0AamTnbjz0KaRtYf/J2GQqZd2KmUWHb3NWGfd+b5HSGKC4pjJuvV34RBClfJZkQdojQ9i71IUnEJnmStWcTCjoW4tsA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199015)(2616005)(83380400001)(86362001)(33656002)(36756003)(38100700002)(6916009)(54906003)(316002)(2906002)(235185007)(41300700001)(7416002)(8936002)(5660300002)(66476007)(66946007)(66556008)(4326008)(8676002)(26005)(186003)(53546011)(478600001)(6512007)(6486002)(6506007)(22166006)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DR2SS6QCcfkjAsMoHxiyCrpHd70+wCftbmElp7gxkz0VS7SYtO8c0y4B6bWK?=
 =?us-ascii?Q?epUpKlTF2gJ78x/zgW+HmlwN84kJ8gF3HY2WFw9nSzgA+j+AU+FiyF0lQWVR?=
 =?us-ascii?Q?gDY4FKECv1sWNN+ZJ1hO69z7nkhBzPzStojSg1eDDRIPqrKRE2JUk/9Eylu1?=
 =?us-ascii?Q?dcDUvG3wyha0YXLBRtdrpGDm6CVmCdGOWe8RDyWaT/wSTJxjSx+JUWVwFeRx?=
 =?us-ascii?Q?xZVwbfVafI4Vlz21/ngEcbfwpEGAlYzsuwT1P7AIe2Lh8GWk5pJk3whmCEtq?=
 =?us-ascii?Q?jZSEfuRLmUC/GDBPW/jFzDHl4fUbAn1vd8mRphw/aT8fdKaFpkQeafvl6kLP?=
 =?us-ascii?Q?t9eEIfxHgfQtJvF6pslH/TeCGd69zkB0mVhtize1xZV7xFpmfHg0xYzuX+JP?=
 =?us-ascii?Q?ZJiWa/64u+Lx8ahdPQYPwT9BW7BwgLaV38ibjkLVQk26hFZGeJ2uYck4dqyU?=
 =?us-ascii?Q?QoFoKqpIG+/o9LlWtP9i6wdiXReCFMRB+TuA8/fUq4BJfk2gESxmnG+wesyk?=
 =?us-ascii?Q?0VAh6cAP33y5QDGy68JhnP7xjCUmkV+DkFZr1krPt6j/yIJFKUa34ZH+dRjH?=
 =?us-ascii?Q?DYp4UnGrEjnFuKzDMWFLpCWN3fwson9DZKilbaEJgXhy+f6FIgO/dfZNuFfo?=
 =?us-ascii?Q?xWJR0lB59IYqlyDx3KtiBZm2slE7jdht2sY8lQEZqjxorIRRbYBgkUsKCmnK?=
 =?us-ascii?Q?RA95UCK7+mP1zNBoAA0yY3pCl3srz/W0rCUqESoV9PM6QcUYjVQ64ua9bANe?=
 =?us-ascii?Q?iVL7AXHBS49dlbWtT+G/QDmBUSSB2v7kOna4HeocsW9Cndm2Mr/MjH6nNTLI?=
 =?us-ascii?Q?/crami9lT9TzqPxnBMXU4/VQThjc88lHbtANv4otA1Pt/+BFDbxwidwk2yJc?=
 =?us-ascii?Q?D+CwoZBGd9KtpSsC7EBu3+9lGKW92NSSPBcUdY2KGAF9wXqeXt1wsiqtyvq4?=
 =?us-ascii?Q?fL8zc4C4K42jY96rYUO/gTC/DLWt34+65/QCMGUGqwKvknLSXbmBYFLJH+jt?=
 =?us-ascii?Q?SINqXzUkuX9/VeEM0jvnpdsfBDwDiOg4Wr1QAFxVdjiIsQFBRsJioYhgJlkZ?=
 =?us-ascii?Q?S5Ji67ktrPlb6GUL+mGuf9OWELXxiDU//N9AtDtW6dT5pQo4F9jE/QwoWn7M?=
 =?us-ascii?Q?ed9DP4bthgl1ekDdp1/0lBSeSQESyvPW58b/1QgRPKQ3OYQPEceTmRA/KWzT?=
 =?us-ascii?Q?CnZz8ML6LDhkcqiD8A7wnnqUexlcdvCMapFQb4hPaG66AiAQYeiK7iWEUDrx?=
 =?us-ascii?Q?FBTAleUkVNLwHL3JiU3OxDlDFtJsGVCj7xX6PKjmTq6ekOkh7WdzWtjN9Wu7?=
 =?us-ascii?Q?P2T+vVP94vvpfhcbM3Nya4OMuHq7qgQNuPg7xSdWhZbOGaJ2LuNJXo1pPEox?=
 =?us-ascii?Q?OeHnEcyMjxMflNi00jm2bio8w49BpM1MICAAAYBm0KZPBQt/q94Z5MlnDMEJ?=
 =?us-ascii?Q?niW5+CpGyGq9qPT1/XyaaCJSiqj9XnR21wfJGLm+N4eaGwvuBHQZqw7FSQ1b?=
 =?us-ascii?Q?kuBixkK9hrtY16pl6ATbNRaBQnuUm43xxee9sfJVzYY+ozKGKMjo5qyQvy6F?=
 =?us-ascii?Q?AA5PlHKTDo8vV/7nvCA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874406cd-2501-46d6-be80-08daedbc130b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 18:55:25.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2juuMka9lcMDPYz6JGBJqBSiiJBJSztgcUCZeIIZ7IZoC4plOpyYpBAyM524Ek7O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_DB4D7853-80DA-41FD-9F15-6ACC3F3388C6_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Dec 2022, at 19:28, Huang Ying wrote:

> This is a preparation patch to batch the folio unmapping and moving.
>
> In this patch, unmap_and_move() is split to migrate_folio_unmap() and
> migrate_folio_move().  So, we can batch _unmap() and _move() in
> different loops later.  To pass some information between unmap and
> move, the original unused dst->mapping and dst->private are used.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: haoxin <xhao@linux.alibaba.com>
> ---
>  include/linux/migrate.h |   1 +
>  mm/migrate.c            | 162 +++++++++++++++++++++++++++++-----------=

>  2 files changed, 121 insertions(+), 42 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 3ef77f52a4f0..7376074f2e1e 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -18,6 +18,7 @@ struct migration_target_control;
>   * - zero on page migration success;
>   */
>  #define MIGRATEPAGE_SUCCESS		0
> +#define MIGRATEPAGE_UNMAP		1
>
>  /**
>   * struct movable_operations - Driver page migration
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 97ea0737ab2b..e2383b430932 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1009,11 +1009,29 @@ static int move_to_new_folio(struct folio *dst,=
 struct folio *src,
>  	return rc;
>  }
>
> -static int __unmap_and_move(struct folio *src, struct folio *dst,
> +static void __migrate_folio_record(struct folio *dst,
> +				   unsigned long page_was_mapped,
> +				   struct anon_vma *anon_vma)
> +{
> +	dst->mapping =3D (struct address_space *)anon_vma;
> +	dst->private =3D (void *)page_was_mapped;
> +}
> +
> +static void __migrate_folio_extract(struct folio *dst,
> +				   int *page_was_mappedp,
> +				   struct anon_vma **anon_vmap)
> +{
> +	*anon_vmap =3D (struct anon_vma *)dst->mapping;
> +	*page_was_mappedp =3D (unsigned long)dst->private;
> +	dst->mapping =3D NULL;
> +	dst->private =3D NULL;
> +}
> +

We probably need comments on these two functions on using dst->mapping
and dst->private. It might be hard to get the behavior later by
digging into the git log and/or looking at the code.

> +static int __migrate_folio_unmap(struct folio *src, struct folio *dst,=

>  				int force, enum migrate_mode mode)
>  {
>  	int rc =3D -EAGAIN;
> -	bool page_was_mapped =3D false;
> +	int page_was_mapped =3D 0;
>  	struct anon_vma *anon_vma =3D NULL;
>  	bool is_lru =3D !__PageMovable(&src->page);
>
> @@ -1089,8 +1107,8 @@ static int __unmap_and_move(struct folio *src, st=
ruct folio *dst,
>  		goto out_unlock;
>
>  	if (unlikely(!is_lru)) {
> -		rc =3D move_to_new_folio(dst, src, mode);
> -		goto out_unlock_both;
> +		__migrate_folio_record(dst, page_was_mapped, anon_vma);
> +		return MIGRATEPAGE_UNMAP;
>  	}
>
>  	/*
> @@ -1115,11 +1133,40 @@ static int __unmap_and_move(struct folio *src, =
struct folio *dst,
>  		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
>  			       !folio_test_ksm(src) && !anon_vma, src);
>  		try_to_migrate(src, 0);
> -		page_was_mapped =3D true;
> +		page_was_mapped =3D 1;
>  	}
>
> -	if (!folio_mapped(src))
> -		rc =3D move_to_new_folio(dst, src, mode);
> +	if (!folio_mapped(src)) {
> +		__migrate_folio_record(dst, page_was_mapped, anon_vma);
> +		return MIGRATEPAGE_UNMAP;
> +	}
> +
> +
> +	if (page_was_mapped)
> +		remove_migration_ptes(src, src, false);
> +
> +out_unlock_both:
> +	folio_unlock(dst);
> +out_unlock:
> +	/* Drop an anon_vma reference if we took one */
> +	if (anon_vma)
> +		put_anon_vma(anon_vma);
> +	folio_unlock(src);
> +out:
> +
> +	return rc;
> +}
> +
> +static int __migrate_folio_move(struct folio *src, struct folio *dst,
> +				enum migrate_mode mode)
> +{
> +	int rc;
> +	int page_was_mapped =3D 0;
> +	struct anon_vma *anon_vma =3D NULL;
> +
> +	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
> +
> +	rc =3D move_to_new_folio(dst, src, mode);
>
>  	/*
>  	 * When successful, push dst to LRU immediately: so that if it
> @@ -1140,14 +1187,11 @@ static int __unmap_and_move(struct folio *src, =
struct folio *dst,
>  		remove_migration_ptes(src,
>  			rc =3D=3D MIGRATEPAGE_SUCCESS ? dst : src, false);
>
> -out_unlock_both:
>  	folio_unlock(dst);
> -out_unlock:
>  	/* Drop an anon_vma reference if we took one */
>  	if (anon_vma)
>  		put_anon_vma(anon_vma);
>  	folio_unlock(src);
> -out:
>  	/*
>  	 * If migration is successful, decrease refcount of dst,
>  	 * which will not free the page because new page owner increased
> @@ -1159,19 +1203,32 @@ static int __unmap_and_move(struct folio *src, =
struct folio *dst,
>  	return rc;
>  }
>
> -/*
> - * Obtain the lock on folio, remove all ptes and migrate the folio
> - * to the newly allocated folio in dst.
> - */
> -static int unmap_and_move(new_page_t get_new_page,
> -				   free_page_t put_new_page,
> -				   unsigned long private, struct folio *src,
> -				   int force, enum migrate_mode mode,
> -				   enum migrate_reason reason,
> -				   struct list_head *ret)
> +static void migrate_folio_done(struct folio *src,
> +			       enum migrate_reason reason)
> +{
> +	/*
> +	 * Compaction can migrate also non-LRU pages which are
> +	 * not accounted to NR_ISOLATED_*. They can be recognized
> +	 * as __PageMovable
> +	 */
> +	if (likely(!__folio_test_movable(src)))
> +		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
> +				    folio_is_file_lru(src), -folio_nr_pages(src));
> +
> +	if (reason !=3D MR_MEMORY_FAILURE)
> +		/* We release the page in page_handle_poison. */
> +		folio_put(src);
> +}
> +
> +/* Obtain the lock on page, remove all ptes. */
> +static int migrate_folio_unmap(new_page_t get_new_page, free_page_t pu=
t_new_page,
> +			       unsigned long private, struct folio *src,
> +			       struct folio **dstp, int force,
> +			       enum migrate_mode mode, enum migrate_reason reason,
> +			       struct list_head *ret)
>  {
>  	struct folio *dst;
> -	int rc =3D MIGRATEPAGE_SUCCESS;
> +	int rc =3D MIGRATEPAGE_UNMAP;
>  	struct page *newpage =3D NULL;
>
>  	if (!thp_migration_supported() && folio_test_transhuge(src))
> @@ -1182,20 +1239,50 @@ static int unmap_and_move(new_page_t get_new_pa=
ge,
>  		folio_clear_active(src);
>  		folio_clear_unevictable(src);
>  		/* free_pages_prepare() will clear PG_isolated. */
> -		goto out;
> +		list_del(&src->lru);
> +		migrate_folio_done(src, reason);
> +		return MIGRATEPAGE_SUCCESS;
>  	}
>
>  	newpage =3D get_new_page(&src->page, private);
>  	if (!newpage)
>  		return -ENOMEM;
>  	dst =3D page_folio(newpage);
> +	*dstp =3D dst;
>
>  	dst->private =3D NULL;
> -	rc =3D __unmap_and_move(src, dst, force, mode);
> +	rc =3D __migrate_folio_unmap(src, dst, force, mode);
> +	if (rc =3D=3D MIGRATEPAGE_UNMAP)
> +		return rc;
> +
> +	/*
> +	 * A page that has not been migrated will have kept its
> +	 * references and be restored.
> +	 */
> +	/* restore the folio to right list. */
> +	if (rc !=3D -EAGAIN)
> +		list_move_tail(&src->lru, ret);
> +
> +	if (put_new_page)
> +		put_new_page(&dst->page, private);
> +	else
> +		folio_put(dst);
> +
> +	return rc;
> +}
> +
> +/* Migrate the folio to the newly allocated folio in dst. */
> +static int migrate_folio_move(free_page_t put_new_page, unsigned long =
private,
> +			      struct folio *src, struct folio *dst,
> +			      enum migrate_mode mode, enum migrate_reason reason,
> +			      struct list_head *ret)
> +{
> +	int rc;
> +
> +	rc =3D __migrate_folio_move(src, dst, mode);
>  	if (rc =3D=3D MIGRATEPAGE_SUCCESS)
>  		set_page_owner_migrate_reason(&dst->page, reason);
>
> -out:
>  	if (rc !=3D -EAGAIN) {
>  		/*
>  		 * A folio that has been migrated has all references
> @@ -1211,20 +1298,7 @@ static int unmap_and_move(new_page_t get_new_pag=
e,
>  	 * we want to retry.
>  	 */
>  	if (rc =3D=3D MIGRATEPAGE_SUCCESS) {
> -		/*
> -		 * Compaction can migrate also non-LRU folios which are
> -		 * not accounted to NR_ISOLATED_*. They can be recognized
> -		 * as __folio_test_movable
> -		 */
> -		if (likely(!__folio_test_movable(src)))
> -			mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
> -					folio_is_file_lru(src), -folio_nr_pages(src));
> -
> -		if (reason !=3D MR_MEMORY_FAILURE)
> -			/*
> -			 * We release the folio in page_handle_poison.
> -			 */
> -			folio_put(src);
> +		migrate_folio_done(src, reason);
>  	} else {
>  		if (rc !=3D -EAGAIN)
>  			list_add_tail(&src->lru, ret);
> @@ -1499,7 +1573,7 @@ static int migrate_pages_batch(struct list_head *=
from, new_page_t get_new_page,
>  	int pass =3D 0;
>  	bool is_large =3D false;
>  	bool is_thp =3D false;
> -	struct folio *folio, *folio2;
> +	struct folio *folio, *folio2, *dst =3D NULL;
>  	int rc, nr_pages;
>  	LIST_HEAD(split_folios);
>  	bool nosplit =3D (reason =3D=3D MR_NUMA_MISPLACED);
> @@ -1524,9 +1598,13 @@ static int migrate_pages_batch(struct list_head =
*from, new_page_t get_new_page,
>
>  			cond_resched();
>
> -			rc =3D unmap_and_move(get_new_page, put_new_page,
> -					    private, folio, pass > 2, mode,
> -					    reason, ret_folios);
> +			rc =3D migrate_folio_unmap(get_new_page, put_new_page, private,
> +						 folio, &dst, pass > 2, mode,
> +						 reason, ret_folios);
> +			if (rc =3D=3D MIGRATEPAGE_UNMAP)
> +				rc =3D migrate_folio_move(put_new_page, private,
> +							folio, dst, mode,
> +							reason, ret_folios);
>  			/*
>  			 * The rules are:
>  			 *	Success: folio will be freed
> -- =

> 2.35.1


--
Best Regards,
Yan, Zi

--=_MailMate_DB4D7853-80DA-41FD-9F15-6ACC3F3388C6_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmO0ehsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU80YQAKic33zSfzW5Ac/EpYMMPdi/iXI4mAFFPAsj
wBBQZ6U9h1JU5ROql3OpplTL1gYoe0/KsSi02iudJNOwb9m+GNYkV5hGtAqAJJu4
mDPA8z4FBGFx/EA5x4KgdCQkb3UtYIHKBiNM4ZVhGKok21d3/ExepvMPxfGTaIVx
Gg10fQuT9XNYNT8IfGH9yika6/wQcoIdgTebYiMlxO+vmRSSW2W7TTLUvBsh3F+W
+lte8LRLpLeFn+NY8bBz83zTjPZbLGLJGUa334VmVZ7tSNDT3e/DSs8HTg6rZXEY
QG/rhmRSF5hqlSsaRu2LTkaqS/I6WDRO/wFh/gxBK0vL1T7LCxD7Kh/KfeTuuw22
CFgo+FIlFYrssSdWEJvgQYBBovqk/kzJwYN3oQv2TnRi0CCIZSploPGCfGp/qhuh
9d6gyT3we3dzeJTM4ClVEfduq4LuuDLxaXS+UYP/Dgh2vemOceogNR/g22wPLh3R
PGnFzmQ61wT7D65Mj5Uvlmi1wsVa4JmWKpmtIFnNRZsL4+BoYUYZE5zfgpJQX/M/
pXXX1gIf/ORTMlMSWjI80c1Vc1RjiNIqNOaXy28/h2q/nXs76axlAe/9jOLYs+8h
S69vp756zlCAgC/nFEF/nopUbU19zMLR6tPnai0OvKpkAbCiuIjjHmshwIm1NeC1
jk+yih3O
=fSb8
-----END PGP SIGNATURE-----

--=_MailMate_DB4D7853-80DA-41FD-9F15-6ACC3F3388C6_=--
