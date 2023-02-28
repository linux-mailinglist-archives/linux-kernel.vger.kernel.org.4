Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A4F6A5032
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 01:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjB1AhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 19:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjB1AhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:37:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41DA24CBE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677544588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SxjtWOmonEjv54vByAy+hjLTxqJfnsX9F69vw39DJB8=;
        b=KBmqd2TVlcoO2n7dyspIpJO6QgXWM1QEEPLk1ZKMgJ2UwK8F82EXc8RJJivYzdDlGTq01L
        0jTYGbP1gZiujcsNFmoNzmhVVaaTIDDc+berVyoC80tjWsNzqD193wpxzT7vTQS7D2fYXE
        CXxd1sZd9JaeWRN7lWkbxZ7XXL69bgQ=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-443-KSTy1xeYO4q_vlRG2Jwc9w-1; Mon, 27 Feb 2023 19:36:27 -0500
X-MC-Unique: KSTy1xeYO4q_vlRG2Jwc9w-1
Received: by mail-io1-f71.google.com with SMTP id k23-20020a5e8917000000b0074cbfb58b5bso5231750ioj.14
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxjtWOmonEjv54vByAy+hjLTxqJfnsX9F69vw39DJB8=;
        b=uvo23Jx1Av0fVfa7+S9TYVAMxWoq6hwQEzKmQNQHD6U0xQ92decLLaKmrUfA4F7L8p
         WNxppx6i1GENihFh1BkAQVoelAbbkFz67aKqKzVBo8P+3ashpK0LJvVC8kyoAQlxOM8S
         ZVOTLzzJoN78iQJkP3LwLAO9RpbltVK1VMaaKxy+d1LM7Lnl/gy5CFSX5RT3rbd7JuNG
         t42MQ+i1voqr6XWv9yIYp6XBLriHnDlCV2VcjZWdmeF4c34FCpWn37lzFgXr/4VeLQiP
         aKWaE/fv4Bgzv0TxP6BIrolcmX9d2fs4aTHmImWIONdMLiobECRAFsh+7+KDcycp3TI2
         p8Jw==
X-Gm-Message-State: AO0yUKWjC7EAUzQsH4TQISoo9ZWMKjE5cTFnt7PVZ4TKQcClF6vMjkmF
        dQQLVmTvuT6fEofGQ51PQpmluYW0bg8tdQOw5H/7SpS9DlVWtodd0/xVbXILUOcND9nK7emkhlR
        THmA668IbbYiWRJlFr6wIMKoz1CTkgIgCx2xdz8Krg/tle6D+DnQrgLdLDUQY4wL1plp24FPMLl
        m63Hg=
X-Received: by 2002:a05:6e02:1a04:b0:317:33fe:7d59 with SMTP id s4-20020a056e021a0400b0031733fe7d59mr970204ild.2.1677544586344;
        Mon, 27 Feb 2023 16:36:26 -0800 (PST)
X-Google-Smtp-Source: AK7set/rBergQtUmEPY17azJ3MFpoNCPbvLUwDW+UH1+21oq2MKdRl0alO3tDWPV8Culg6JS1mDIxg==
X-Received: by 2002:a05:6e02:1a04:b0:317:33fe:7d59 with SMTP id s4-20020a056e021a0400b0031733fe7d59mr970177ild.2.1677544585958;
        Mon, 27 Feb 2023 16:36:25 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id c20-20020a02c9d4000000b003a9632cb099sm2420334jap.51.2023.02.27.16.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 16:36:25 -0800 (PST)
Date:   Mon, 27 Feb 2023 19:36:23 -0500
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Message-ID: <Y/1Mh5uivFt+zWKM@x1n>
References: <20230227230044.1596744-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227230044.1596744-1-peterx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 06:00:44PM -0500, Peter Xu wrote:
> This is a new feature that controls how uffd-wp handles none ptes.  When
> it's set, the kernel will handle anonymous memory the same way as file
> memory, by allowing the user to wr-protect unpopulated ptes.
> 
> File memories handles none ptes consistently by allowing wr-protecting of
> none ptes because of the unawareness of page cache being exist or not.  For
> anonymous it was not as persistent because we used to assume that we don't
> need protections on none ptes or known zero pages.
> 
> One use case of such a feature bit was VM live snapshot, where if without
> wr-protecting empty ptes the snapshot can contain random rubbish in the
> holes of the anonymous memory, which can cause misbehave of the guest when
> the guest OS assumes the pages should be all zeros.
> 
> QEMU worked it around by pre-populate the section with reads to fill in
> zero page entries before starting the whole snapshot process [1].
> 
> Recently there's another need raised on using userfaultfd wr-protect for
> detecting dirty pages (to replace soft-dirty in some cases) [2].  In that
> case if without being able to wr-protect none ptes by default, the dirty
> info can get lost, since we cannot treat every none pte to be dirty (the
> current design is identify a page dirty based on uffd-wp bit being cleared).
> 
> In general, we want to be able to wr-protect empty ptes too even for
> anonymous.
> 
> This patch implements UFFD_FEATURE_WP_UNPOPULATED so that it'll make
> uffd-wp handling on none ptes being consistent no matter what the memory
> type is underneath.  It doesn't have any impact on file memories so far
> because we already have pte markers taking care of that.  So it only
> affects anonymous.
> 
> The feature bit is by default off, so the old behavior will be maintained.
> Sometimes it may be wanted because the wr-protect of none ptes will contain
> overheads not only during UFFDIO_WRITEPROTECT (by applying pte markers to
> anonymous), but also on creating the pgtables to store the pte markers. So
> there's potentially less chance of using thp on the first fault for a none
> pmd or larger than a pmd.
> 
> The major implementation part is teaching the whole kernel to understand
> pte markers even for anonymously mapped ranges, meanwhile allowing the
> UFFDIO_WRITEPROTECT ioctl to apply pte markers for anonymous too when the
> new feature bit is set.
> 
> Note that even if the patch subject starts with mm/uffd, there're a few
> small refactors to major mm path of handling anonymous page faults. But
> they should be straightforward.
> 
> So far, add a very light smoke test within the userfaultfd kselftest
> pagemap unit test to make sure anon pte markers work.
> 
> [1] https://lore.kernel.org/all/20210401092226.102804-4-andrey.gruzdev@virtuozzo.com/
> [1] https://lore.kernel.org/all/Y+v2HJ8+3i%2FKzDBu@x1n/
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v1->v2:
> - Use pte markers rather than populate zero pages when protect [David]
> - Rename WP_ZEROPAGE to WP_UNPOPULATED [David]

Some very initial performance numbers (I only ran in a VM but it should be
similar, unit is "us") below as requested.  The measurement is about time
spent when wr-protecting 10G range of empty but mapped memory.  It's done
in a VM, assuming we'll get similar results on bare metal.

Four test cases:

        - default UFFDIO_WP
        - pre-read the memory, then UFFDIO_WP (what QEMU does right now)
        - pre-fault using MADV_POPULATE_READ, then default UFFDIO_WP
        - UFFDIO_WP with WP_UNPOPULATED

Results:

        Test DEFAULT: 2
        Test PRE-READ: 3277099 (pre-fault 3253826)
        Test MADVISE: 2250361 (pre-fault 2226310)
        Test WP-UNPOPULATE: 20850

I'll add these information into the commit message when there's a new
version.

[1] https://github.com/xzpeter/clibs/blob/master/uffd-test/uffd-wp-perf.c

-- 
Peter Xu

