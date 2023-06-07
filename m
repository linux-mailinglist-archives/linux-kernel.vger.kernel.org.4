Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7075D726892
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjFGSYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjFGSYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:24:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D162705
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686162143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DQ6zuroINio1c01IojiuLixyZvJ+SrwsYpib8PCoHh4=;
        b=d1O2FWlOG6BJtRKizvFo2Y1hyjU+N/rvpb/awxxLwQ/kwL92hlNnVS7h/h9FhqJDF/Cc5+
        07dYWjkVOYMp6HBS0f9lJob0g8h0CLDDa/aSVE9RvPDeae5JZ4hakufdLQVBWw4VJZHGI1
        vgipuvoZwEgOn+OepRIW0GNefK1m5Bs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-9lVTYLJmN3WY7zKXxk5KzA-1; Wed, 07 Jun 2023 14:22:21 -0400
X-MC-Unique: 9lVTYLJmN3WY7zKXxk5KzA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75eb82ada06so89026885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686162140; x=1688754140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ6zuroINio1c01IojiuLixyZvJ+SrwsYpib8PCoHh4=;
        b=KygKoFl0liMQYTu1sQjeTpBC/M/+mngLUWBY/fJx6d5oqCjVGBNkTjLIi6fP646UtM
         yc9TMx3cbuPaCS8IFybF87IiFTSM12I+q1MsvvZY9MaDkyYZUt6WvK+ityP1zfuaO9oI
         Itot/SoLCO0Q3i1oTYGLqyz9fOoCbHkKbdW7pn82mNcQnlGTh3lT9Pd0lb8FBw6Yr1za
         iFQwrLclDuvuhPSKNyZLUBI6mmMjB7SSmoQMZGdKNJm30jDh3rGYIfiBJusHnBaPp5DK
         Ts6oIQ/65xgEInyOcGrHxDtMueBSzu61iSUY6NkQfG6OD4JqftA/8Tbst/mdssDUWSgJ
         KlCw==
X-Gm-Message-State: AC+VfDwSbv1e64lLZ41v0m/zYo3xwJUyCjOOYdv6ZpZ/ND6Xe0ucDgkx
        5gYFxGCl1zMvJbEmQHMaXWlaD9S62SyK+ELM5dxjnAugzV+BseIGk72w0OmiJdjHHrjqfcWX5CW
        6zU3/6taQ4ZRUFxFOy/hwhWDs0ipOLTyJ
X-Received: by 2002:a05:622a:19a9:b0:3f6:b465:8ccc with SMTP id u41-20020a05622a19a900b003f6b4658cccmr3472034qtc.1.1686162140142;
        Wed, 07 Jun 2023 11:22:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6VsarLh9zWccCzKu6NqQJaXaG487KhdkCDF7y3mDR8vRwifniTr+jEXmQxGJvbERcYk3iHvQ==
X-Received: by 2002:a05:622a:19a9:b0:3f6:b465:8ccc with SMTP id u41-20020a05622a19a900b003f6b4658cccmr3472011qtc.1.1686162139901;
        Wed, 07 Jun 2023 11:22:19 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id l10-20020a05622a174a00b003ef2c959d1bsm85097qtk.67.2023.06.07.11.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:22:19 -0700 (PDT)
Date:   Wed, 7 Jun 2023 14:22:17 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 0/4] mm: Fix pmd_trans_unstable() call sites on retry
Message-ID: <ZIDK2a6qf1SYF/kW@x1n>
References: <20230602230552.350731-1-peterx@redhat.com>
 <ZICK3uqTeUxeIlc9@x1n>
 <97b5657d-e09d-b3a9-c09d-eaff9fb7929d@redhat.com>
 <ZICukdhrxcaA74Pp@x1n>
 <CAHbLzkoiSW3jOhFdEU5w567SyxhB05dBfTrJvKg4X59nPURz3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkoiSW3jOhFdEU5w567SyxhB05dBfTrJvKg4X59nPURz3Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 09:39:44AM -0700, Yang Shi wrote:
> I don't think this is an important thing. There are plenty of other
> conditions that could make the accounting inaccurate, for example,
> isolating page from LRU fails, force charge, etc. And it seems like
> nobody was bothered by this either.

Yes, I read that a bit more and I agree.  So let me summarize after I read
Hugh's series just now..

With the pre-requisite of the new __pte_map_offset() that Hugh proposed
here:

[PATCH 04/31] mm/pgtable: allow pte_offset_map[_lock]() to fail
https://lore.kernel.org/r/8218ffdc-8be-54e5-0a8-83f5542af283@google.com

We should not need pmd_trans_unstable() anymore as Hugh pointed out, which
I fully agree.  I think Hugh has covered all the issues that this series
wanted to address alongside, namely:

  Patch 1 (mprotect) is covered in:

  [PATCH 18/31] mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()
  https://lore.kernel.org/r/4a834932-9064-9ed7-3cd1-99466f549486@google.com

  No way to move spinlock outside, so one -EAGAIN needed which makes sense.

  Patch 2 (migrate_device) is covered in:

  [PATCH 24/31] mm/migrate_device: allow pte_offset_map_lock() to fail
  https://lore.kernel.org/r/ea51bb69-189c-229b-fc0-9d3e7be5d6b@google.com

  By a direct retry, and more code unified so even better.

  Patch 3 () is covered in:

  [PATCH 19/31] mm/mremap: retry if either pte_offset_map_*lock() fails
  https://lore.kernel.org/r/2d3fbfea-5884-8211-0cc-954afe25ae9c@google.com

  Instead of WARN_ON_ONCE(), it got dropped which looks all good, too.

  Most of patch 4's changes are done in:

  [PATCH 09/31] mm/pagewalkers: ACTION_AGAIN if pte_offset_map_lock() fails
  https://lore.kernel.org/r/6265ac58-6018-a8c6-cf38-69cba698471@google.com

  There're some different handling on memcg changes, where in Hugh's
  series it was put separately here:

  [PATCH 17/31] mm/various: give up if pte_offset_map[_lock]() fails
  https://lore.kernel.org/r/c299eba-4e17-c645-1115-ccd1fd9956bd@google.com

  After double check, I agree with Yang's comment and Hugh's approach,
  that no retry is needed for memcg.

Let's ignore this series, not needed anymore.

Thanks,

-- 
Peter Xu

