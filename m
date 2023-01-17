Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D566E7AC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjAQUZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjAQUV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:21:27 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1A95CE5F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:13:32 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id j1so7089591iob.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=33Ncea+r49M0JFeF3LtrfUuUT4g5hGuOl0GtEnc7zfw=;
        b=M82Qd6AI0hYaULrWAi7eXudgqNOdBArrqWl8NUWMhweZ1mgAI2BOdntQuu6w6SxKp3
         uPJGFLbnFvsoOAWbhlp5NMRCHg+Ij7ymAgzX0aOEZfRkK1FUl2Sw7+1qzFBooxTHNDFH
         QwP5WpHzLvBQvF6ibc3RcXcXxlP0nI86XHv6uJSb+9THDwwqwYrQ5yeOi9sTFLXgYRRW
         ucAECxKZmfng297NPeMfRzYIf4RRtEH/TGcdtzC4B45Z7WI2Rn9YTRlrTOKIM3kJaq0P
         Vgk2T1bWc1Hp06NcNbnlU8lfB32azU1uJViZMnpHy9r0yXJ2JHPoMOPAq+kDhSVl3qrN
         7/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33Ncea+r49M0JFeF3LtrfUuUT4g5hGuOl0GtEnc7zfw=;
        b=4EWWeJqN2zos9Z+4XytpCh/SXadJQtmcdQabISMOj1sKHqJ19As+2S2ALzWgbnf3oD
         OwhXOtG372exQo4UhYqiHaUOICcwIBMb0Ex9bpOaGG3pS8gh1cL+o18PeY7RkZBIwhzt
         XDSe4wDdu0dKzAOsIxaTe7ZVj7Lp6DnKoY8pk6395w28P+aplQUrBli6czWcJyTRA+nM
         VlVWknG+GuPGCYWMMjmSOmbDLK71ZAJFHfpMkUvuvNhzL7jN7uKXbby1dLzFvg3/wxPN
         NcN9QS1RtipQlKWQ38sJ8zyzAjgzW7pB76UAE9odutCjxmw/cGnEh62pOsI2xmexDzK/
         0G1Q==
X-Gm-Message-State: AFqh2kpfnrYA2tTa8XqBQvMnO3Z7wQuXxHY8ki46yuQaSj54oTRQmLM8
        LmajotL+CTL4OmZtUeznvoZHCSitdsNNrRbgAAesnA==
X-Google-Smtp-Source: AMrXdXsDLyLv3tnBqT3yJqNdPKtwS3NIDmj8Ad2h0WWLOnTb1J4nJmCvaMK3XkzXh05XxIo4fWEHMFhVoNhEqk6Lc5Q=
X-Received: by 2002:a5d:945a:0:b0:6e3:2350:744c with SMTP id
 x26-20020a5d945a000000b006e32350744cmr199633ior.2.1673982805815; Tue, 17 Jan
 2023 11:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20230111133351.807024-1-jannh@google.com>
In-Reply-To: <20230111133351.807024-1-jannh@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 17 Jan 2023 20:12:49 +0100
Message-ID: <CAG48ez36Nio9GzU_m168AEJMXxtcNtdgq6YpAhLq-aKNQA_9fg@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Fix ->anon_vma race
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org
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

On Wed, Jan 11, 2023 at 2:33 PM Jann Horn <jannh@google.com> wrote:
> If an ->anon_vma is attached to the VMA, collapse_and_free_pmd() requires
> it to be locked. retract_page_tables() bails out if an ->anon_vma is
> attached, but does this check before holding the mmap lock (as the comment
> above the check explains).

@akpm please replace the commit message with the following, and maybe
also add a "Link:" entry pointing to
https://lore.kernel.org/linux-mm/CAG48ez3434wZBKFFbdx4M9j6eUwSUVPd4dxhzW_k_POneSDF+A@mail.gmail.com/
for the reproducer.


If an ->anon_vma is attached to the VMA, collapse_and_free_pmd() requires
it to be locked.
Page table traversal is allowed under any one of the mmap lock, the
anon_vma lock (if the VMA is associated with an anon_vma), and the
mapping lock (if the VMA is associated with a mapping); and so to be
able to remove page tables, we must hold all three of them.
retract_page_tables() bails out if an ->anon_vma is attached, but
does this check before holding the mmap lock (as the comment above
the check explains).

If we racily merge an existing ->anon_vma (shared with a child process)
from a neighboring VMA, subsequent rmap traversals on pages belonging to
the child will be able to see the page tables that we are concurrently
removing while assuming that nothing else can access them.

Repeat the ->anon_vma check once we hold the mmap lock to ensure that there
really is no concurrent page table access.

Hitting this bug causes a lockdep warning in collapse_and_free_pmd(),
in the line
"lockdep_assert_held_write(&vma->anon_vma->root->rwsem)".
It can also lead to use-after-free access.
