Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D30E735E71
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjFSUZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFSUZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48485CC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687206275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L+7NDxcHQTB4tiGksszjGmWGVz0Hs3EOY3lovbfaDMI=;
        b=EJLm31LqfZLJoQsREcMfryTJw4ELgkTqIgw+Z2w8JEZYjb0Xb49Q+uS5cYFBn8/HWFq1ev
        Z2KJMXHLWK/CUD8KVEYISVPZ7IJqJJ9zDMi8orXtnQntmCON8idPttQFPLIFCbZotL0VQW
        vl7bdKLQ7zA2naIeNa5kRe9FyV9gW7I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-IaidyvNzPTiD-bAA2DHNSA-1; Mon, 19 Jun 2023 16:24:33 -0400
X-MC-Unique: IaidyvNzPTiD-bAA2DHNSA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f8283a3a7aso9957591cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687206273; x=1689798273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+7NDxcHQTB4tiGksszjGmWGVz0Hs3EOY3lovbfaDMI=;
        b=AvmQAs37KSRbjAsvnnuo+AMWWUTLAw1395ZWMpmM/EO8JVx/2MvWiY8GEC9fkV+x/7
         cPj64orM2zzzykq6/WOay4shI+ujrbLzH5Aj8pMK4be5SR0KRb67bQmfLXaDNe5UcvN1
         pkebV0Hsmojy7qHsAfp4OhObV9lxpXdtC3gkT0Uhp5aLWzrxpesbRDHj1yb9tMaJYPbm
         hCQZDyLfDxVqjsiyE3vJk8v+7ttEVMrFErv7xJo2B7ewYrgrepTcjnMfoBCkHgB389js
         UpmiVV79FUvMXF7QbLjRqcm5MdMB8WgIZgJwDDHVY22b/c26EaVJ/oLcdKK0NtjZ/oR/
         QuUQ==
X-Gm-Message-State: AC+VfDxfyiLXCcE/a/JY7EkV+PZq3bFprE/GC+eu3RylwjC30Fc7ELnu
        r41ivO0a9VgFFWX26ksvoiYS8n6izhP9Q+h/sDqh5oC+tDtFqm6+li2GEtj1lDB9M4+mH9yKMop
        t/fXjGlOgxPWnZpNkFs89Ce65
X-Received: by 2002:ac8:5842:0:b0:3f9:cb97:f15a with SMTP id h2-20020ac85842000000b003f9cb97f15amr14546253qth.0.1687206273195;
        Mon, 19 Jun 2023 13:24:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6WIOHDZ2wnZk1jY00viqycxxSeQBQ8/Wl9zGA/XOhryPBnhgsBROAKpvOdG1nbeCdTgeRN9A==
X-Received: by 2002:ac8:5842:0:b0:3f9:cb97:f15a with SMTP id h2-20020ac85842000000b003f9cb97f15amr14546240qth.0.1687206272971;
        Mon, 19 Jun 2023 13:24:32 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id i10-20020ac860ca000000b003f9cca00552sm238782qtm.93.2023.06.19.13.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:24:32 -0700 (PDT)
Date:   Mon, 19 Jun 2023 16:24:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 6/7] mm/gup: Accelerate thp gup even for "pages != NULL"
Message-ID: <ZJC5f+oXEKGS0jtW@x1n>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-7-peterx@redhat.com>
 <d8c76484-1030-44a3-b148-7e69fa84243a@lucifer.local>
 <ZJCuepgy3+66S03G@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJCuepgy3+66S03G@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 03:37:30PM -0400, Peter Xu wrote:
> Here what I can do is still guard this try_grab_folio() and fail the GUP if
> for any reason it failed.  Perhaps then it means I'll also keep that one
> untouched in hugetlb_follow_page_mask() too.  But I suppose keeping the
> WARN_ON_ONCE() seems still proper.

Here's the outcome that I plan to post in the new version, taking care of
try_grab_folio() failures even if it happens, meanwhile remove the
compound_head() redundancy on the page.

__get_user_pages():
...
===8<===
			/*
			 * This must be a large folio (and doesn't need to
			 * be the whole folio; it can be part of it), do
			 * the refcount work for all the subpages too.
			 *
			 * NOTE: here the page may not be the head page
			 * e.g. when start addr is not thp-size aligned.
			 * try_grab_folio() should have taken care of tail
			 * pages.
			 */
			if (page_increm > 1) {
				struct folio *folio;

				/*
				 * Since we already hold refcount on the
				 * large folio, this should never fail.
				 */
				folio = try_grab_folio(page, page_increm - 1,
						       foll_flags);
				if (WARN_ON_ONCE(!folio)) {
					/*
					 * Release the 1st page ref if the
					 * folio is problematic, fail hard.
					 */
					gup_put_folio(page_folio(page), 1,
						      foll_flags);
					ret = -EFAULT;
					goto out;
				}
			}
===8<===

Thanks,

-- 
Peter Xu

