Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFDE71781C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjEaHZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEaHZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:25:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5C1122
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685517942; x=1717053942;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=NJMHNWlGqt9fFaT1Uo3VmPdw4bNAlscWO8HebrvoySo=;
  b=PxJY7Sq8o9X183L1dvrsdu9d4d6rHdEJh7a428m/iZOX9Tx7Q62duU/f
   V7FIkUTJAcCezP+goKvV9z/wOzc6KV+7sSKOMw1WINR0GQ4k43aYhccVh
   2vUkY6y62+BExdksYEQgA8AZbF5ykwta0iPJp+Xa3tMr4N8nQwzPEWeN1
   JFQN20GsUwRsSApqoKFhipD4LyNQfzsxrBC/2RBkBXZ0Vw5DEUh1oCWpC
   X7fy1/oLLvB50/N2zTBKnKGmVM/IPjlJlBAGpviEdEqtch0B1akAMKO8s
   02HsMyTwPo2b9aJ/UojzzmECbN04UdBdkoSkQj84n7dhraSdwR7brIblm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="358423761"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="358423761"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 00:25:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="851107618"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="851107618"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 00:25:40 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     mpenttil@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v2] mm/migrate_device: Try to handle swapcache pages
References: <20230531044018.17893-1-mpenttil@redhat.com>
Date:   Wed, 31 May 2023 15:24:32 +0800
In-Reply-To: <20230531044018.17893-1-mpenttil@redhat.com>
        (mpenttil@redhat.com's message of "Wed, 31 May 2023 07:40:18 +0300")
Message-ID: <87wn0pt13j.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpenttil@redhat.com writes:

> From: Mika Penttil=C3=A4 <mpenttil@redhat.com>
>
> Migrating file pages and swapcache pages into device memory is not suppor=
ted.
> The decision is done based on page_mapping(). For now, swapcache pages ar=
e not migrated.
>
> Things can however be improved, for swapcache pages. Try to get rid of th=
e swap cache,
> and if successful, go ahead as with other anonymous pages.
>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Mika Penttil=C3=A4 <mpenttil@redhat.com>
> ---
>
> v2:
>   - use folio_test_anon() (Huang, Ying)
>
>=20=20
>  mm/migrate_device.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index d30c9de60b0d..829bbc526758 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -747,13 +747,25 @@ static void __migrate_device_pages(unsigned long *s=
rc_pfns,
>=20=20
>  		if (is_device_private_page(newpage) ||
>  		    is_device_coherent_page(newpage)) {
> -			/*
> -			 * For now only support anonymous memory migrating to
> -			 * device private or coherent memory.
> -			 */
> +
>  			if (mapping) {
> -				src_pfns[i] &=3D ~MIGRATE_PFN_MIGRATE;
> -				continue;
> +				struct folio *folio;
> +
> +				folio =3D page_folio(page);
> +
> +				/*
> +				 * For now only support anonymous memory migrating to
> +				 * device private or coherent memory.
> +				 *
> +				 * Try to get rid of swap cache if possible.

I think we can delete the following 2 lines of comments.  They add
nothing except what code says already.

Otherwise looks good to me.

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> +				 * page is here file or swapcache page, could be shmem also
> +				 * folio_test_anon() filters out file and shmem
> +				 *
> +				 */
> +				if (!folio_test_anon(folio) || !folio_free_swap(folio)) {
> +					src_pfns[i] &=3D ~MIGRATE_PFN_MIGRATE;
> +					continue;
> +				}
>  			}
>  		} else if (is_zone_device_page(newpage)) {
>  			/*
