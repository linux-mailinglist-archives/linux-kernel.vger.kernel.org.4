Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C626F9DBD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 04:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjEHC11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 22:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjEHC1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 22:27:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14087421E
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 19:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683512842; x=1715048842;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=zKRd4CcYhxWuZ8dosZrKjFL/E+GzhFM8aaQzoYaruc4=;
  b=PCIPlgAPVNTgvmyApyP8ERLv/NiSOkoN5fvpVt0lgv0QDwH/HCnwZo7g
   euPTj/XoiQNWmrSANBNPH1PdYPTyb0vMb4MAZmh95TA/toe9tc23TfJyl
   gRo4DyqTzKMScigD54ZIwHApdnZfXBUrt2t3DlHiQeJG+4Y9bMo521Enp
   /Z7BFtc1/nKiHLMq5ea1gx2LqRmM/QCTRr5sw3YY4Bb72AUqVrPwX2ij1
   cgL4HH3FW27J8oKcYI+es5zdqG4VS11KvGysICFlHsm97fAqxl0Kcx/uQ
   sGRwsLSItyS5miTEpy7Nd7H6TFjJDYaCYeOeZDo7S9u/OTFplGrEc32HF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="348365119"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="348365119"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 19:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="787932513"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="787932513"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 19:27:19 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     mpenttil@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com
Subject: Re: [PATCH] mm/migrate_device: Try to handle swapcache pages.
References: <20230507061726.13422-1-mpenttil@redhat.com>
Date:   Mon, 08 May 2023 10:26:16 +0800
In-Reply-To: <20230507061726.13422-1-mpenttil@redhat.com>
        (mpenttil@redhat.com's message of "Sun, 7 May 2023 09:17:26 +0300")
Message-ID: <87wn1ja793.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> As a detail, do not mess with shmem pages, as they handle swap internally.
>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Signed-off-by: Mika Penttil=C3=A4 <mpenttil@redhat.com>
> ---
>  mm/migrate_device.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index d30c9de60b0d..e8169c58c341 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -12,6 +12,7 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/oom.h>
>  #include <linux/pagewalk.h>
> +#include <linux/shmem_fs.h>
>  #include <linux/rmap.h>
>  #include <linux/swapops.h>
>  #include <asm/tlbflush.h>
> @@ -750,10 +751,17 @@ static void __migrate_device_pages(unsigned long *s=
rc_pfns,
>  			/*
>  			 * For now only support anonymous memory migrating to
>  			 * device private or coherent memory.
> +			 *
> +			 * Try to get rid of swap cache if possible.
> +			 * Leave shmem pages alone, they handle swap internally
> +			 *
>  			 */
>  			if (mapping) {
> -				src_pfns[i] &=3D ~MIGRATE_PFN_MIGRATE;
> -				continue;
> +				if (shmem_mapping(mapping) ||
> +				    !folio_free_swap(page_folio(page))) {

Should we filter out file pages firstly?

> +					src_pfns[i] &=3D ~MIGRATE_PFN_MIGRATE;
> +					continue;
> +				}
>  			}
>  		} else if (is_zone_device_page(newpage)) {
>  			/*

Best Regards,
Huang, Ying
