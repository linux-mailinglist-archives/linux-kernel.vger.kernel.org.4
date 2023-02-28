Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B26B6A5CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjB1P7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjB1P66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:58:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CC03251A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677599890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LqHzMmMAnP1j9fnVg4LOhn3aCa8U954IIbyJ+XoGXFE=;
        b=TEGRO9yoZbrxVYA0mj8SvtCb8i5hssLz6zMqkmaPXN0bs7Pe5nleZvbUSHw5chsJcbO6kZ
        1YLvapcHbOYOl/EH1ofX58PhhByDTTIXXq6Evdoyuewj8hqsp652IG2o38w/A3wZ/B9Ykx
        M4ZyDl0oZilFzu7fhLHBSacDx36H8N8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-5l7Do7jSNUyHZYOesBYYDQ-1; Tue, 28 Feb 2023 10:58:09 -0500
X-MC-Unique: 5l7Do7jSNUyHZYOesBYYDQ-1
Received: by mail-qk1-f199.google.com with SMTP id b22-20020ae9eb16000000b007427f9339c0so6245131qkg.17
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:58:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677599889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqHzMmMAnP1j9fnVg4LOhn3aCa8U954IIbyJ+XoGXFE=;
        b=oYpG3i3+/AmPdgoqkcR0w5oBvGREGzcXon+ODGvrfJALmFkmfBHAHeLkGELVBfRilq
         EKi3ZOdU1eGLQpEjxGhhsiPWIW6e7tcINff/Nr4fRFa0IUBoLfXfBCBTfBhecvkn9a2T
         WyaA9qi3cKIzi3aJJe2ayGvwv9Hs9GDwUcPrRGaKw9Nyw6uzZmpjFbaHTBmxJYCIo7Bj
         PHSGJHaY7Pfg0MuyA/m7+N3QF31z0ggKDa8TP9wuTda3dy9TsnbBhMNGMcr7IQlO8+k1
         XM3GWaqGSprcwWlaTPEyCFEphUsxN2q1OeeitigxyAE5vGE5Cx8RjsOMZs9TNUcS9Cwz
         YQ5A==
X-Gm-Message-State: AO0yUKX98HxxWiIuBcHrd+M61E6PPTEAtMAy0SVBXbf3wgB6bJ2d4VGr
        al/3tfv61WP69EIag0VRY1UqRGZtP4D2mbV0/T/qZWJ77Uk2KuPFEE1bslLeRwJaIKmzzYoECig
        5lFJAifm4r2+OhbJ62RV80QwR
X-Received: by 2002:a05:622a:1391:b0:3bf:c38c:1d6c with SMTP id o17-20020a05622a139100b003bfc38c1d6cmr5768472qtk.2.1677599888771;
        Tue, 28 Feb 2023 07:58:08 -0800 (PST)
X-Google-Smtp-Source: AK7set+U773QNP+ssZhiqbrn5y7DM4uIzHgQC6u+cRGTVrfYVTaGdnUQdsYt5XzYtHnQvfU2XGVSgQ==
X-Received: by 2002:a05:622a:1391:b0:3bf:c38c:1d6c with SMTP id o17-20020a05622a139100b003bfc38c1d6cmr5768446qtk.2.1677599888461;
        Tue, 28 Feb 2023 07:58:08 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id v22-20020a05622a131600b003b8558eabd0sm6845693qtk.23.2023.02.28.07.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:58:07 -0800 (PST)
Date:   Tue, 28 Feb 2023 10:58:06 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Message-ID: <Y/4kjnom6MQqh9iA@x1n>
References: <20230227230044.1596744-1-peterx@redhat.com>
 <Y/1Mh5uivFt+zWKM@x1n>
 <e1e0ed70-76df-647f-30ac-0bb6ae8dc05c@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1e0ed70-76df-647f-30ac-0bb6ae8dc05c@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 12:21:45PM +0500, Muhammad Usama Anjum wrote:
> Hi Peter,

Hi, Muhammad,

> 
> Thank you so much for sending.
> 
> On 2/28/23 5:36 AM, Peter Xu wrote:
> > On Mon, Feb 27, 2023 at 06:00:44PM -0500, Peter Xu wrote:
> >> This is a new feature that controls how uffd-wp handles none ptes.  When
> >> it's set, the kernel will handle anonymous memory the same way as file
> >> memory, by allowing the user to wr-protect unpopulated ptes.
> >>
> >> File memories handles none ptes consistently by allowing wr-protecting of
> >> none ptes because of the unawareness of page cache being exist or not.  For
> >> anonymous it was not as persistent because we used to assume that we don't
> >> need protections on none ptes or known zero pages.
> >>
> >> One use case of such a feature bit was VM live snapshot, where if without
> >> wr-protecting empty ptes the snapshot can contain random rubbish in the
> >> holes of the anonymous memory, which can cause misbehave of the guest when
> >> the guest OS assumes the pages should be all zeros.
> >>
> >> QEMU worked it around by pre-populate the section with reads to fill in
> >> zero page entries before starting the whole snapshot process [1].
> >>
> >> Recently there's another need raised on using userfaultfd wr-protect for
> >> detecting dirty pages (to replace soft-dirty in some cases) [2].  In that
> >> case if without being able to wr-protect none ptes by default, the dirty
> >> info can get lost, since we cannot treat every none pte to be dirty (the
> >> current design is identify a page dirty based on uffd-wp bit being cleared).
> >>
> >> In general, we want to be able to wr-protect empty ptes too even for
> >> anonymous.
> >>
> >> This patch implements UFFD_FEATURE_WP_UNPOPULATED so that it'll make
> >> uffd-wp handling on none ptes being consistent no matter what the memory
> >> type is underneath.  It doesn't have any impact on file memories so far
> >> because we already have pte markers taking care of that.  So it only
> >> affects anonymous.
> >>
> >> The feature bit is by default off, so the old behavior will be maintained.
> >> Sometimes it may be wanted because the wr-protect of none ptes will contain
> >> overheads not only during UFFDIO_WRITEPROTECT (by applying pte markers to
> >> anonymous), but also on creating the pgtables to store the pte markers. So
> >> there's potentially less chance of using thp on the first fault for a none
> >> pmd or larger than a pmd.
> >>
> >> The major implementation part is teaching the whole kernel to understand
> >> pte markers even for anonymously mapped ranges, meanwhile allowing the
> >> UFFDIO_WRITEPROTECT ioctl to apply pte markers for anonymous too when the
> >> new feature bit is set.
> >>
> >> Note that even if the patch subject starts with mm/uffd, there're a few
> >> small refactors to major mm path of handling anonymous page faults. But
> >> they should be straightforward.
> >>
> >> So far, add a very light smoke test within the userfaultfd kselftest
> >> pagemap unit test to make sure anon pte markers work.
> >>
> >> [1] https://lore.kernel.org/all/20210401092226.102804-4-andrey.gruzdev@virtuozzo.com/
> >> [1] https://lore.kernel.org/all/Y+v2HJ8+3i%2FKzDBu@x1n/
> >>
> >> Signed-off-by: Peter Xu <peterx@redhat.com>
> >> ---
> >> v1->v2:
> >> - Use pte markers rather than populate zero pages when protect [David]
> >> - Rename WP_ZEROPAGE to WP_UNPOPULATED [David]
> > 
> > Some very initial performance numbers (I only ran in a VM but it should be
> > similar, unit is "us") below as requested.  The measurement is about time
> > spent when wr-protecting 10G range of empty but mapped memory.  It's done
> > in a VM, assuming we'll get similar results on bare metal.
> > 
> > Four test cases:
> > 
> >         - default UFFDIO_WP
> >         - pre-read the memory, then UFFDIO_WP (what QEMU does right now)
> >         - pre-fault using MADV_POPULATE_READ, then default UFFDIO_WP
> >         - UFFDIO_WP with WP_UNPOPULATED
> > 
> > Results:
> > 
> >         Test DEFAULT: 2
> >         Test PRE-READ: 3277099 (pre-fault 3253826)
> >         Test MADVISE: 2250361 (pre-fault 2226310)
> >         Test WP-UNPOPULATE: 20850
> > 
> > I'll add these information into the commit message when there's a new
> > version.
> I'm hitting a bug where I'm unable to write to the memory after adding this
> patch and wp the memory. I'm hitting this case in your test and my tests as
> well. Please apply the following diff to your test to reproduce on your end:
> 
> --- uffd_wp_perf.c.orig 2023-02-28 12:09:38.971820791 +0500
> +++ uffd_wp_perf.c      2023-02-28 12:13:11.077827160 +0500
> @@ -114,6 +114,7 @@
>          start1 = get_usec();
>      }
>      wp_range(uffd, buffer, SIZE, true);
> +    buffer[0] = 'a';
>      if (start1 == 0)
>           printf("%"PRIu64"\n", get_usec() - start);
>      else

This is expected, because the test didn't start any fault resolving thread,
so the write will block until someone unprotects the page.

But it shouldn't happen to your use case if you applied both WP_UNPOPULATED
& WP_ASYNC.

Could you try "cat /proc/$PID/stack" to see where does your thread stuck
at?

-- 
Peter Xu

