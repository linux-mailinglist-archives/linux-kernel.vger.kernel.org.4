Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4E96F9EEA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 07:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjEHFQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 01:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjEHFQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 01:16:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D8D6E82
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 22:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683522985; x=1715058985;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=4lp1uTOss7ptF3vkv+6Y1UQ22aeHUmbrl85yaow0b3o=;
  b=In0A7CwY7zJqFw4DmFPkuFC3zpkAcEazqC1VaKNmM60WGrBnr4jSx/UY
   hol8MCpXPEnxSjWz8GqdilUSSbwKFw6KL5n46WJ0y3WWhMscgD0PjkPpS
   b3K0bOSfhso7wtHemeNf5AijEPybqmi1w+7gK54YhpQoDVcHw67HAFXZr
   C0DupqWHPzlt8ZKHSUqq4w2Ive8ZMQ2PODoxxo1BEP0aZpqeMRYWPvzLV
   xo/EsNRGXj2uO03fzEVSE4ORbN3LTlGrw3OpHVA1M0waT8RCna0G/1TKU
   hfyPpqzfmg1rr+jqmfGtXOaQy9tYEM7c6gBjsViJGfMRTk6REA9VLPDxg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="349591538"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="349591538"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 22:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="648737662"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="648737662"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 22:16:23 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mika =?utf-8?Q?Penttil=C3=A4?= <mpenttil@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com
Subject: Re: [PATCH] mm/migrate_device: Try to handle swapcache pages.
References: <20230507061726.13422-1-mpenttil@redhat.com>
        <87wn1ja793.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <f93c14f6-024d-4abc-7598-fa82cc3ea1a5@redhat.com>
Date:   Mon, 08 May 2023 13:14:47 +0800
In-Reply-To: <f93c14f6-024d-4abc-7598-fa82cc3ea1a5@redhat.com> ("Mika
        =?utf-8?Q?Penttil=C3=A4=22's?= message of "Mon, 8 May 2023 05:59:46 +0300")
Message-ID: <87sfc79zg8.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Mika Penttil=C3=A4 <mpenttil@redhat.com> writes:

> H,
>
>
> On 8.5.2023 5.26, Huang, Ying wrote:
>> mpenttil@redhat.com writes:
>>=20
>>> From: Mika Penttil <mpenttil@redhat.com>
>>>
>>> Migrating file pages and swapcache pages into device memory is not supp=
orted.
>>> The decision is done based on page_mapping(). For now, swapcache pages =
are not migrated.
>>>
>>> Things can however be improved, for swapcache pages. Try to get rid of =
the swap cache,
>>> and if successful, go ahead as with other anonymous pages.
>>>
>>> As a detail, do not mess with shmem pages, as they handle swap internal=
ly.
>>>
>>> Cc: Alistair Popple <apopple@nvidia.com>
>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>> Signed-off-by: Mika Penttil <mpenttil@redhat.com>
>>> ---
>>>   mm/migrate_device.c | 12 ++++++++++--
>>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>> index d30c9de60b0d..e8169c58c341 100644
>>> --- a/mm/migrate_device.c
>>> +++ b/mm/migrate_device.c
>>> @@ -12,6 +12,7 @@
>>>   #include <linux/mmu_notifier.h>
>>>   #include <linux/oom.h>
>>>   #include <linux/pagewalk.h>
>>> +#include <linux/shmem_fs.h>
>>>   #include <linux/rmap.h>
>>>   #include <linux/swapops.h>
>>>   #include <asm/tlbflush.h>
>>> @@ -750,10 +751,17 @@ static void __migrate_device_pages(unsigned long =
*src_pfns,
>>>   			/*
>>>   			 * For now only support anonymous memory migrating to
>>>   			 * device private or coherent memory.
>>> +			 *
>>> +			 * Try to get rid of swap cache if possible.
>>> +			 * Leave shmem pages alone, they handle swap internally
>>> +			 *
>>>   			 */
>>>   			if (mapping) {
>>> -				src_pfns[i] &=3D ~MIGRATE_PFN_MIGRATE;
>>> -				continue;
>>> +				if (shmem_mapping(mapping) ||
>>> +				    !folio_free_swap(page_folio(page))) {
>> Should we filter out file pages firstly?
>
> folio_free_swap() checks first and returns false if not swapcache page
> (ie including normal file pages) so think that is enough,

You are right.  folio_free_swap() will call folio_test_swapcache(), and
which will check folio_test_swapbacked().

And, IIUC, we don't need to check shmem too.  Because folio_free_swap()
will not return true for shmem pages.

> but maybe for clarity and not depending on it, could be good
> explicitly check for swapcache before calling folio_free_swap().

Yes.  That will be more clear.  I suggest to use folio_test_anon(), that
will filter out shmem pages too.

>>=20
>>> +					src_pfns[i] &=3D ~MIGRATE_PFN_MIGRATE;
>>> +					continue;
>>> +				}
>>>   			}
>>>   		} else if (is_zone_device_page(newpage)) {
>>>   			/*

Best Regards,
Huang, Ying
