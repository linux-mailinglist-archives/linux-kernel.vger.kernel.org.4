Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81B063F3E6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiLAPaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiLAP3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:29:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E12AA8EF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 07:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669908521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BdDC1WAtZV0XTmkt9D4E/axQjlEA5HE6l2HGiOiq2ps=;
        b=KPS1TEdpQIzAHjsPJzKc3bEYjcV1zIGSHX/cPQ8Aq0mcjjnqhR1xbF9uAYVse2t/UG+gzd
        WfLNRm4mRA9s0FcgOJWFHvvosohMtLHlMfh00iwrGbNwFRrSbY5i1/HrKvrscG/5DAwR3C
        PZsMlFfupcK2eaCiamen7/1OW2RQT6A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-uaAeKKQoPAuFDvqcDryCdQ-1; Thu, 01 Dec 2022 10:28:39 -0500
X-MC-Unique: uaAeKKQoPAuFDvqcDryCdQ-1
Received: by mail-qv1-f71.google.com with SMTP id nk7-20020a056214350700b004c68c912c93so5462697qvb.16
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 07:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdDC1WAtZV0XTmkt9D4E/axQjlEA5HE6l2HGiOiq2ps=;
        b=n+cz2PJD5Q8dgxAemFWolvkwtCTX6dCXhAY3uLiM85AmJY+cy5tATy4Fl00nxE5L3x
         3keK/jNsexI29G9zpCkZIr9Sdl2VfedZm7LOnrk2TQu7Qw0Df0Rg0H2p2wzi8MzPrYEr
         aIC9CX5Ry0UO8zcVFz9NJyrJwlfg/pOVgra30oAvuHDz3A4hmk3fINGDmBQy4yYxdQ5b
         N0k1LP3t4w4wv4ihcTJnXtX7dDwjz0WdwXcT3npfxKGoz8B9nOw4KE+e/g/F0TClge1b
         OYYA7HztxuEYUrxmGyA8rILh43TB2yAWdnaL6efyp4HTx+zkT6VsoHU3g7TmmgJPZnAm
         7Q8A==
X-Gm-Message-State: ANoB5pmLlRoszHWM7dbDfpurkzVGz4D9gCVK7qTUT/pyRMWvDYsLKIK3
        FMlQ0s9Xo1l0TI/0JqebiTRafhsZxKlmNzCXjTVnylStP7dRgm9hwUsyg0t4Ms/E8qdNfDt4Z6x
        88U+WnqWctQBliW+rW3a3J/Pc
X-Received: by 2002:ae9:e415:0:b0:6f3:e5c8:ddde with SMTP id q21-20020ae9e415000000b006f3e5c8dddemr42575919qkc.80.1669908512370;
        Thu, 01 Dec 2022 07:28:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7SDmgvGwuxBNpX3bmNkH7gq7tVsmOyoad4tTaFFGWQ0CEzE5W7pZEcGNLGqCcuZqnkFFN+XA==
X-Received: by 2002:ae9:e415:0:b0:6f3:e5c8:ddde with SMTP id q21-20020ae9e415000000b006f3e5c8dddemr42575895qkc.80.1669908512067;
        Thu, 01 Dec 2022 07:28:32 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id h13-20020a05620a244d00b006fba44843a5sm3670991qkn.52.2022.12.01.07.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 07:28:31 -0800 (PST)
Date:   Thu, 1 Dec 2022 10:28:30 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/migrate: Fix read-only page got writable when
 recover pte
Message-ID: <Y4jIHureiOd8XjDX@x1n>
References: <20221114000447.1681003-1-peterx@redhat.com>
 <20221114000447.1681003-2-peterx@redhat.com>
 <5ddf1310-b49f-6e66-a22a-6de361602558@redhat.com>
 <20221130142425.6a7fdfa3e5954f3c305a77ee@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CjNznIJt6mVQmyak"
Content-Disposition: inline
In-Reply-To: <20221130142425.6a7fdfa3e5954f3c305a77ee@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CjNznIJt6mVQmyak
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi, Andrew,

On Wed, Nov 30, 2022 at 02:24:25PM -0800, Andrew Morton wrote:
> On Tue, 15 Nov 2022 19:17:43 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
> > On 14.11.22 01:04, Peter Xu wrote:
> > > Ives van Hoorne from codesandbox.io reported an issue regarding possible
> > > data loss of uffd-wp when applied to memfds on heavily loaded systems.  The
> > > symptom is some read page got data mismatch from the snapshot child VMs.
> > > 
> > > Here I can also reproduce with a Rust reproducer that was provided by Ives
> > > that keeps taking snapshot of a 256MB VM, on a 32G system when I initiate
> > > 80 instances I can trigger the issues in ten minutes.
> > > 
> > > It turns out that we got some pages write-through even if uffd-wp is
> > > applied to the pte.
> > > 
> > > The problem is, when removing migration entries, we didn't really worry
> > > about write bit as long as we know it's not a write migration entry.  That
> > > may not be true, for some memory types (e.g. writable shmem) mk_pte can
> > > return a pte with write bit set, then to recover the migration entry to its
> > > original state we need to explicit wr-protect the pte or it'll has the
> > > write bit set if it's a read migration entry.  For uffd it can cause
> > > write-through.
> > > 
> > > The relevant code on uffd was introduced in the anon support, which is
> > > commit f45ec5ff16a7 ("userfaultfd: wp: support swap and page migration",
> > > 2020-04-07).  However anon shouldn't suffer from this problem because anon
> > > should already have the write bit cleared always, so that may not be a
> > > proper Fixes target, while I'm adding the Fixes to be uffd shmem support.
> > > 
> >
> > ...
> >
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -213,8 +213,14 @@ static bool remove_migration_pte(struct folio *folio,
> > >   			pte = pte_mkdirty(pte);
> > >   		if (is_writable_migration_entry(entry))
> > >   			pte = maybe_mkwrite(pte, vma);
> > > -		else if (pte_swp_uffd_wp(*pvmw.pte))
> > > +		else
> > > +			/* NOTE: mk_pte can have write bit set */
> > > +			pte = pte_wrprotect(pte);
> > > +
> > > +		if (pte_swp_uffd_wp(*pvmw.pte)) {
> > > +			WARN_ON_ONCE(pte_write(pte));
> 
> Will this warnnig trigger in the scenario you and Ives have discovered?

If without the above newly added wr-protect, yes.  This is the case where
we found we got write bit set even if uffd-wp bit is also set, hence allows
the write to go through even if marked protected.

> 
> > >   			pte = pte_mkuffd_wp(pte);
> > > +		}
> > >   
> > >   		if (folio_test_anon(folio) && !is_readable_migration_entry(entry))
> > >   			rmap_flags |= RMAP_EXCLUSIVE;
> > 
> > As raised, I don't agree to this generic non-uffd-wp change without 
> > further, clear justification.
> 
> Pater, can you please work this further?

I didn't reply here because I have already replied with the question in
previous version with a few attempts.  Quotting myself:

https://lore.kernel.org/all/Y3KgYeMTdTM0FN5W@x1n/

        The thing is recovering the pte into its original form is the
        safest approach to me, so I think we need justification on why it's
        always safe to set the write bit.

I've also got another longer email trying to explain why I think it's the
other way round to be justfied, rather than justifying removal of the write
bit for a read migration entry, here:

https://lore.kernel.org/all/Y3O5bCXSbvKJrjRL@x1n/

> 
> > I won't nack it, but I won't ack it either.
> 
> I wouldn't mind seeing a little code comment which explains why we're
> doing this.

I've got one more fixup to the same patch attached, with enriched comments
on why we need wr-protect for read migration entries.

Please have a look to see whether that helps, thanks.

-- 
Peter Xu

--CjNznIJt6mVQmyak
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fixup-mm-migrate-fix-read-only-page-got-writable-whe.patch"

From d68c98047ce54c62f3454997a55f23ff6fb317cd Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 1 Dec 2022 10:19:22 -0500
Subject: [PATCH] fixup! mm/migrate: fix read-only page got writable when
 recover pte
Content-type: text/plain

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/migrate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c13c828d34f3..d14f1f3ab073 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -214,7 +214,14 @@ static bool remove_migration_pte(struct folio *folio,
 		if (is_writable_migration_entry(entry))
 			pte = maybe_mkwrite(pte, vma);
 		else
-			/* NOTE: mk_pte can have write bit set */
+			/*
+			 * NOTE: mk_pte() can have write bit set per memory
+			 * type (e.g. shmem), or pte_mkdirty() per archs
+			 * (e.g., sparc64).  If this is a read migration
+			 * entry, we need to make sure when we recover the
+			 * pte from migration entry to present entry the
+			 * write bit is cleared.
+			 */
 			pte = pte_wrprotect(pte);
 
 		if (pte_swp_uffd_wp(*pvmw.pte)) {
-- 
2.37.3


--CjNznIJt6mVQmyak--

