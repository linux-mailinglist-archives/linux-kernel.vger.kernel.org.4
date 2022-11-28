Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAA963AEEA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiK1R3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiK1R2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:28:55 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EF310C5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:28:54 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id c7so8105971iof.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DhDrYg4g1x+JxtVDLaGWmIpSSuuuWjjuf9g438COr5g=;
        b=V6oH2pM16SHJb5m5KNmrVdpO4FrL7Y4wVIfpebMu4kCqottczpktAKma0V0y1h9tee
         L6bH98hxE3KP7G0lPPLwfKEx+guVO0WzcpbO7b3q92I7H+RQjKxOmVzBcaBpow9o7oq3
         JO9W2rXlrPMmCXN5XAHLKCaz1erT/iLmFFR+ME69o41961RAPwSxQVMBc7TG6lusksXx
         39AKWl5RSc3ritoFWO8Rv2ILZnXobHxwLwxwWr9AatmtbtlVE9XJIqTgZ7na6etvjWQ2
         QpnOS4COvGxuCUQY6fw/U9BZ9UH3RjmECZ4JFDMKuJJ3LYCzaPMGavVM1supUhUIN6yw
         hg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhDrYg4g1x+JxtVDLaGWmIpSSuuuWjjuf9g438COr5g=;
        b=BOL6Zr84A8cGzr4GCEJV2LE2nxXetnKWibSMffuvSzO+ZTewCjWz1HztIpBiy9XvRe
         5Fo2/iWIP0kPNIrsY9plUi02edWykWqGCHL+5vhV7eXTtYbZQ0kWf8aoipIOmICZtE6M
         JgQ8Xb0NOdu5kRtNSXY/rp3BhFdxJ45kJB7/CM+DkMByYhAmdLHVDwW4MvSyPFCUedB4
         LQHJro5b2NxGNb50bfHODSjbaViAnLhBkNN0DOtZxpFNYDW28RqdvyIUSLSGlgCEInby
         1k57C9/vUnvUb7MhEtW6ZMdNeZteAXnQBpRJYhC5Vgu2WXVwQJWOxDUnuUXnXo3owytE
         zDoA==
X-Gm-Message-State: ANoB5pkse0Unw/5H8EYF/qjK8MKyOSU9gZ10dNZnM25fZ9BKcxxMveoM
        P2FKhUu6UoRKk+ZKr766jwyIid/uEr29TPqNC/8ABg==
X-Google-Smtp-Source: AA0mqf69YHGvGGlXd1/FdL1gB/jMpQ3dz5R9l9t94Din6TsW/O1fxlgR3v+ZSaI1yPYUaWmKVP4eUZpKpQ5qCET7Hew=
X-Received: by 2002:a6b:e714:0:b0:6df:7332:70f0 with SMTP id
 b20-20020a6be714000000b006df733270f0mr4663320ioh.154.1669656534048; Mon, 28
 Nov 2022 09:28:54 -0800 (PST)
MIME-Version: 1.0
References: <20221125213714.4115729-1-jannh@google.com> <fec3f46e-a777-06e7-0ba0-a8cf169afa02@redhat.com>
In-Reply-To: <fec3f46e-a777-06e7-0ba0-a8cf169afa02@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 28 Nov 2022 18:28:17 +0100
Message-ID: <CAG48ez11R7LMxCM0QrqHT16ugqsECswCosNkQV62QsLZaLaeYQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm/khugepaged: Take the right locks for page table retraction
To:     David Hildenbrand <david@redhat.com>
Cc:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 2:53 PM David Hildenbrand <david@redhat.com> wrote:
> On 25.11.22 22:37, Jann Horn wrote:
> > pagetable walks on address ranges mapped by VMAs can be done under the mmap
> > lock, the lock of an anon_vma attached to the VMA, or the lock of the VMA's
> > address_space. Only one of these needs to be held, and it does not need to
> > be held in exclusive mode.
> >
> > Under those circumstances, the rules for concurrent access to page table
> > entries are:
> >
> >   - Terminal page table entries (entries that don't point to another page
> >     table) can be arbitrarily changed under the page table lock, with the
> >     exception that they always need to be consistent for
> >     hardware page table walks and lockless_pages_from_mm().
> >     This includes that they can be changed into non-terminal entries.
> >   - Non-terminal page table entries (which point to another page table)
> >     can not be modified; readers are allowed to READ_ONCE() an entry, verify
> >     that it is non-terminal, and then assume that its value will stay as-is.
> >
> > Retracting a page table involves modifying a non-terminal entry, so
> > page-table-level locks are insufficient to protect against concurrent
> > page table traversal; it requires taking all the higher-level locks under
> > which it is possible to start a page walk in the relevant range in
> > exclusive mode.
> >
> > The collapse_huge_page() path for anonymous THP already follows this rule,
> > but the shmem/file THP path was getting it wrong, making it possible for
> > concurrent rmap-based operations to cause corruption.
>
> This sounds sane and correct to me. No expert on file-THP, though.
>
> For anon-THP it's the mmap lock and the rmap locks. I assume the only
> difference for file-THP is that the rmap lock is actually the mapping
> lock. Looking at rmap_walk_file(), that seems to be the case.

Yeah. You can also have private file VMAs that are associated with
both a mapping and a set of anon_vmas, and in that case you would need
to lock the mmap, the mapping, and the anon_vma root; but the file THP
code in khugepaged instead just bails on file VMAs with an anon_vma.

> I wish at least PTE table removal could be done easier ... I already
> experimented some time ago with some ideas (e.g., lock in PMD table
> memmap) but it's all far from trivial and space in the memmap is rare.

Because you want it to be faster? Is that for the THP usecase or something else?
