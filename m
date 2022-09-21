Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFC95C03CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiIUQKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiIUQJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:09:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AC79F1A7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cb7h8SSYhlfzTnejtzVSW5VaPf2YeKBpXQ2DqyfE8AgWNg2sG/F18Euyw28TuDOocrcqlXJ/pZh+hIqs7tP4vmW97OmSW7ObXN9pJvcMMPjK2TLDD0VICwKotrFi3LkiDyE1Cx2+QmqnkNyxIVuj57sQHy2S+FKl8tZw2frXfqO+HtVAG8K+JlWzXtNFHxZOqzexIgpr4bAQMB06XflEVuTCxqVoG2ym/ZTexT9yhSUDtMXIjyofWcQEP1I6+XvLJWQoABhaeZkEoaC+bMDLdr4wHMEb5zFXCC/pXwWp+qzzXM9PwK0LTf4nHAhUpUpg4DaMiU+cZt2vycF/wjHNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRvoWQsxmxOCzVQqILXItiSxPRoWuwcQi4eEyTIwjv8=;
 b=Bm+pa8lTR3zJUCbGkibtytfDxaFF/ERx4KzZCUnoiaQJI3J/9E6YMOhq76x43DXXWt5MDSqJLPCgdru+dcQk+YYSN51RxKxyWzfW8VwivaFV8nG0uXUAowzbSYgQOogXAslhTw5oVI0fQcLs/b0inL+ALko+a/n9ZJDYUnOfNTB8qUKAiTQwxCttseMIpU2xgmFqAGF0bR7VJce0eZ7Q/WGlDCE8EBtgwdsoaWOYnZtq0h6xqEP7R7c+QWf6RVwOElDq2lyhnIW9ROmBGyPeX+m8gmd4gNiV0+M0uffw/jYNlnihb3aOsjXqzml/UYobbGUYMntEu/g32z6jhuMzbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRvoWQsxmxOCzVQqILXItiSxPRoWuwcQi4eEyTIwjv8=;
 b=ftnScfl1ZQfjKs46V0gc7YkXVSClB6bXBb7sFi/rElp4fboj/97Qqbe9oJnMHzmODuY3q5P2877BTKRSicjV21sold9pAK7CK6gvi8KaW7+sWWHUNxTQj/VDLhx0O1//GSEbKidDIHU8F/HJ0uNuISh6FFtuiJKUBvfwrjY+nlTgf5OS5PABB6TBM+B1ZOVJ+DYndauk/Oc90Q71fBaSzN0dJWyWrc3btXia3Cfyq4RlpTyViFTE1kFSWlWDahPb1Ou7B3+KstTKL7SpaqnlpkbtYxZ21p2MXlqopPZTiAdyQTqNbECS4zpTWE0XwQ7AwfPJMFsyRc/aQL/aECUcHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Wed, 21 Sep
 2022 15:55:43 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::94df:bc2b:6294:8cc6]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::94df:bc2b:6294:8cc6%6]) with mapi id 15.20.5612.022; Wed, 21 Sep 2022
 15:55:43 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 1/6] mm/migrate_pages: separate huge page and normal pages
 migration
Date:   Wed, 21 Sep 2022 11:55:41 -0400
X-Mailer: MailMate (1.14r5916)
Message-ID: <7192F7C6-CA9F-4184-832F-673D2ED5061D@nvidia.com>
In-Reply-To: <20220921060616.73086-2-ying.huang@intel.com>
References: <20220921060616.73086-1-ying.huang@intel.com>
 <20220921060616.73086-2-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2BCA6A24-267C-41D5-B44D-D0A1820B578F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:207:3c::45) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: d821e4c0-9b2d-4e4f-ed42-08da9be9bd90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2R0hXJnD2hUhLwZJ4VUZ+teUMrJb4uZoyyNp+OFBeteGY0+cGOiKg9dATABYxYQQggb6LQAIM7Ys14CarqEa7jJFqIUmcMpRBhYXXZT3Sr/nHiwEEOaD4K5VQykqMXVyqffNaCrtlEQETSDVVE89n7sqNwDY7QNhmVyO0euVYg4pT3JVoSiN7NSecQ2dzVZvYPzbqxjkwDfY6dUjeHMvbUqtrnJjTz9oUC6FaJBYpo8Hf1iaOANotbNGsaJYqPVP4KQHbiJOM8NGx5hIl+Cjxd2MrvQEbWgH1T2UvyQFQVWEvf0ScylgYf/LVUOoX55ne1pzyxfNe2xIqulI8OUJbQRTkaGm5KSLXpfmOwuAa1qACMQnm7gC/Hpf3LCaOGQbBm3cNiy5mKaFVfsLl28wTIJ64CwkDZ9derBbKoVyZfI/Qxda+p1HBVm+YfH2SCN6KIAIRsl9WfQ0JWdIZ4BT60o6F75lIonzfDm5PcnAqDNViMq6/0ZIAgzmqnMJk+oyTz5bric34Bej5KT0lWbJXNjNqrcAAq5nrBeznq0mZ3Y0Xel47oGUZMusn4HqviNMQmHFVL9oGCN2L2MzUInPs/PY6nOBv4pxLVALJ1I8nquL27EVAYUoOgJcl6y7GgvjcArVSixwZ75nt8M7/ng97RuIffFwkDxxpaFg5AH+FPP4R5jXFUNC2bJZecbtT1SwJqQrGHh+OT1hoGvENGB1fPswT8m/x5Y7rzcrgkp7OfT10GtA57Yy4dlyjnQDMbTGwwPcXG+SXGYjZUk/qukyhAedMT+S0ycWT/lJDltCd455EisykOTmS0y1ybl55ARN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199015)(38100700002)(6512007)(54906003)(26005)(316002)(53546011)(6506007)(6916009)(33656002)(5660300002)(235185007)(41300700001)(2616005)(186003)(8936002)(2906002)(86362001)(66556008)(66476007)(4326008)(478600001)(8676002)(66946007)(6486002)(83380400001)(36756003)(14583001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S5/uLOxrDTEI9mqhZCKSX+RVTkcgviEPhck+3v5krjbYicJxE7gN5s+GdBni?=
 =?us-ascii?Q?CBi8bGl9kFAOziHfLoZdmQeevBgOU+0+KV7LuYAAt6YcpuOGzjvsgqq7JAfx?=
 =?us-ascii?Q?lzSqH2hQaQXfGCelCMekchUtl3ZNl/0bfOIJbSKRJ+UUrc1cjTqAsrPMu+7D?=
 =?us-ascii?Q?y4yhIV9qPcxk9cXhCbSqtcnLqiNA+Lf4DULvkogGZBR5VfhObxmMZC2wz15m?=
 =?us-ascii?Q?w+xG3eY15SYCKy2PqVQfgGVJte9Z5J4TnidagQ1XDWsrwYLjx2tPMDl03uLp?=
 =?us-ascii?Q?ZNNljPRWtc0rkuPu9Gk+MV2KMmpl2KEAvh5pdL1JBDdGWgphlEh3GmFbJxbT?=
 =?us-ascii?Q?+p6JkIj8MEk40JjoZ9H4ZJJ5Jz7AO1IryAo5Qu8cBeMkcMS7UZr2xWZza5l6?=
 =?us-ascii?Q?JEE/riipL8MYMyNmvitfG0F94qpZYCE23crRKWHRnORfjmjJBVx+cvwW5GwL?=
 =?us-ascii?Q?dqMLP3CY1c21wk5kqo1RDyMG6KLjy+ZAu9P3/g39jtPxX65kB7+TRpO8M47n?=
 =?us-ascii?Q?IiDqKi25v2AH6pKVVqRcqAyNC4WmEC/FgEYWcngjY8U81nbIckuDHwr4OzHa?=
 =?us-ascii?Q?Mi6ZlTVj5aO94LAXzyMPR/9tNtSAtBaG6jpmuNacb/oeQNtg5gENz9EDEyY9?=
 =?us-ascii?Q?pNnpqcHSp+OzXMS9ddutCvaddQ1zQuDcbKmiSUfMj0YB1l/jNGPCvsDcttv2?=
 =?us-ascii?Q?2CG9h6ezJgGBUDJ5UXwb3Ec7ZM/1fZQOBD5k5ipoCUrNMm3NcuGguMix7BFW?=
 =?us-ascii?Q?wdPEZ0wN2K043wXqqkba7D2ip4i55/frk/9C9C+NlTsrjKS50oT8HHpNVr9w?=
 =?us-ascii?Q?ZTTfWDYV6EPWNSDs8eC5Og6iKG+kVPvvVCofoHgrw+ZBZgy9VSQqmV/jU8KU?=
 =?us-ascii?Q?ngWdubHlHiqAPzMQTEhNCpTX1l6tfpCR111O23yKsX3aiprVYEw0sXRm194y?=
 =?us-ascii?Q?E3ep5gqCj/C6wh0Td+ZNuFMl9R744EXTgKD1eFwXtUrBD52qvgEtOlkng44J?=
 =?us-ascii?Q?BB3Gv75ReUYJXzwyTCoNi46QQKbAoIbqYnpM+eug3FNQUkR2luu1rn/4zNAk?=
 =?us-ascii?Q?JbjrZRUlmdVVtX7k+eM/9+8vO6/9HjE73Y29AdhMkTJRzTBLLlZ+4+NyloyH?=
 =?us-ascii?Q?NZfhpTYgnZT+gqj9yOWJZ/ldbHWBsazvebzAh0PvsLnlAbJo9wftELl/U/eb?=
 =?us-ascii?Q?/xp8dLQ3/ou0bAcXWeyNjB0QzMeXH6DEAJzRhkMkqap//OQ2bS4+xkprw12O?=
 =?us-ascii?Q?oClaJOhU9K7krqQU2YwpK2kVEN1gf7SC6OOFzpiKcJo/OuDD0vf80WsBuWhq?=
 =?us-ascii?Q?fbjK5ZXBzIKOmYg9+NZgCZgO3E1oxS4sgYvEchEooFZjRg/G8X9c5Re2cXzm?=
 =?us-ascii?Q?CqC9soQkYzzWwSD+xJy9bhFqeoxeDeA3BLVNWOp/zUwK1Y5bQq6UG0sOMhCb?=
 =?us-ascii?Q?I8y0ok+Qc4q4ErOt8lb1Jo7oelM4J7VV8LAWMSMTDfNyUuo7QyZ/oJtppoh6?=
 =?us-ascii?Q?ZJyJ1yGTTVgh3FUvmprA4MVaKc5LdlXWYfpnla1kqXne4dVIOlbZF1onPuIC?=
 =?us-ascii?Q?zdkDfHeTaoNIczEu3RkLPwBHOLdoA58AY7KxgpPQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d821e4c0-9b2d-4e4f-ed42-08da9be9bd90
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 15:55:43.7360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZpf/Ak1likbKcPpNxvChqBdgTECFHaAQxKihmtwLJVjqMYN1dAtsyvoYwEo8RAU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_2BCA6A24-267C-41D5-B44D-D0A1820B578F_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Sep 2022, at 2:06, Huang Ying wrote:

> This is a preparation patch to batch the page unmapping and moving for
> the normal pages and THPs.  Based on that we can batch the TLB
> shootdown during the page migration and make it possible to use some
> hardware accelerator for the page copying.
>
> In this patch the huge page (PageHuge()) and normal page and THP
> migration is separated in migrate_pages() to make it easy to change
> the normal page and THP migration implementation.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>  mm/migrate.c | 73 +++++++++++++++++++++++++++++++++++++++++++++-------=

>  1 file changed, 64 insertions(+), 9 deletions(-)

Maybe it would be better to have two subroutines for hugetlb migration
and normal page migration respectively. migrate_pages() becomes very
large at this point.

>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 571d8c9fd5bc..117134f1c6dc 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1414,6 +1414,66 @@ int migrate_pages(struct list_head *from, new_pa=
ge_t get_new_page,
>
>  	trace_mm_migrate_pages_start(mode, reason);
>
> +	for (pass =3D 0; pass < 10 && retry; pass++) {
> +		retry =3D 0;
> +
> +		list_for_each_entry_safe(page, page2, from, lru) {
> +			nr_subpages =3D compound_nr(page);
> +			cond_resched();
> +
> +			if (!PageHuge(page))
> +				continue;
> +
> +			rc =3D unmap_and_move_huge_page(get_new_page,
> +						put_new_page, private, page,
> +						pass > 2, mode, reason,
> +						&ret_pages);
> +			/*
> +			 * The rules are:
> +			 *	Success: hugetlb page will be put back
> +			 *	-EAGAIN: stay on the from list
> +			 *	-ENOMEM: stay on the from list
> +			 *	-ENOSYS: stay on the from list
> +			 *	Other errno: put on ret_pages list then splice to
> +			 *		     from list
> +			 */
> +			switch(rc) {
> +			case -ENOSYS:
> +				/* Hugetlb migration is unsupported */
> +				nr_failed++;
> +				nr_failed_pages +=3D nr_subpages;
> +				list_move_tail(&page->lru, &ret_pages);
> +				break;
> +			case -ENOMEM:
> +				/*
> +				 * When memory is low, don't bother to try to migrate
> +				 * other pages, just exit.
> +				 */
> +				nr_failed++;
> +				nr_failed_pages +=3D nr_subpages + nr_retry_pages;
> +				goto out;
> +			case -EAGAIN:
> +				retry++;
> +				nr_retry_pages +=3D nr_subpages;
> +				break;
> +			case MIGRATEPAGE_SUCCESS:
> +				nr_succeeded +=3D nr_subpages;
> +				break;
> +			default:
> +				/*
> +				 * Permanent failure (-EBUSY, etc.):
> +				 * unlike -EAGAIN case, the failed page is
> +				 * removed from migration page list and not
> +				 * retried in the next outer loop.
> +				 */
> +				nr_failed++;
> +				nr_failed_pages +=3D nr_subpages;
> +				break;
> +			}
> +		}
> +	}
> +	nr_failed +=3D retry;
> +	retry =3D 1;
>  thp_subpage_migration:
>  	for (pass =3D 0; pass < 10 && (retry || thp_retry); pass++) {
>  		retry =3D 0;
> @@ -1431,18 +1491,14 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>  			cond_resched();
>
>  			if (PageHuge(page))
> -				rc =3D unmap_and_move_huge_page(get_new_page,
> -						put_new_page, private, page,
> -						pass > 2, mode, reason,
> -						&ret_pages);
> -			else
> -				rc =3D unmap_and_move(get_new_page, put_new_page,
> +				continue;
> +
> +			rc =3D unmap_and_move(get_new_page, put_new_page,
>  						private, page, pass > 2, mode,
>  						reason, &ret_pages);
>  			/*
>  			 * The rules are:
> -			 *	Success: non hugetlb page will be freed, hugetlb
> -			 *		 page will be put back
> +			 *	Success: page will be freed
>  			 *	-EAGAIN: stay on the from list
>  			 *	-ENOMEM: stay on the from list
>  			 *	-ENOSYS: stay on the from list
> @@ -1468,7 +1524,6 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  						nr_thp_split++;
>  						break;
>  					}
> -				/* Hugetlb migration is unsupported */
>  				} else if (!no_subpage_counting) {
>  					nr_failed++;
>  				}
> -- =

> 2.35.1


--
Best Regards,
Yan, Zi

--=_MailMate_2BCA6A24-267C-41D5-B44D-D0A1820B578F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmMrM/4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUcCsP/3Kw72gJdS8tVgiiQhqu9tnZ43pX7CPFG08u
WH4TrVzt3R0bsWNWHuQ6eYiPNqnY6bICctK0mTcaqMcFQVyv56J3F+rfFUVn9L9C
fqMvsx1GKMQ83vxrOFLc2ZRZjX/YqnzGYWiuTJyOseLpA8gliLscVIctYgljbqHV
YgpfkayAZE09y+bQJirnz4HvjsNg6B8zWDJhLE6BIcQOnJ00P0ksa4bYKAktYHzz
wAaOkjmG9EwL8PiDkoAR3KEFYS24PdYvLWUrrfg4K2JSXUX4emcn4umsaRRpdED/
JH21wpcbM9EOpRFo26YxJITuFqozwRkhc8q3e1vLHY4wHlUP2jODzVa1o1DQhK3D
e5J3kCkcSWRKsLrU0Qw79UojqvsHM7F5U9Y6s5DAdSy/8JZL9iYAGOpr38kDbLyQ
y11XZLNoZHC8Ge8t0nQRi36r7E8DqYLJPqz93+VQq2hb/Tsf2lIbp4gWvzGThvJ/
jOpCoSgilchpSDGkAXKcpkB6S/9yQohcKMF6qdWZy0CaXfdQixBjGvc/MMHwTtln
4pa9b2Nu6kkHgldBznSSWPU7RMFEZ+GKPN1ekWjwurI00xqUASE5MSHOuM2qVgMn
OrkJRHHtTG/FUy/AtTEb6aCBwIwnbPIcX5ntByMAu+POV//6Qcmkg1ZoFWg70bB6
64O24Kyb
=s80t
-----END PGP SIGNATURE-----

--=_MailMate_2BCA6A24-267C-41D5-B44D-D0A1820B578F_=--
