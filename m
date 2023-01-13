Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F5766A37C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjAMTkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjAMTjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:39:46 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CDB85C82
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:37:14 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y205so6372362iof.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wo+1IHNp3GYXjfswkalSmonaDkZuEJUvFP7FH/2V+V4=;
        b=DIgqsRV0y0XR59XsyHI08oTXi1+MNDRXBryrpyq/ZLlbVkW9Rj2k5eA/METb9g0pdx
         ZfX8JWrM1i8effLLlc7qlWSfd7vu9WqE0KZ+z9ZTrHX4dFzPYx8Xr2qSzZM+usGRVydb
         yw4qzhy2Wqtowzyt5g1q7f+NqeAuXS+Szx8h5MpJm7iMnVdl9jyZhhcbf3p5fvJweNxL
         pD8b1Z583slMheRTEgxwNNf3fjqT7/BFlK/xL8Zo5KCmcqm9LOlnl8UQ9eNsYV2qd43l
         GBAEx01Dv5YzeYP4qJl6SBAFJe0wNNKSShUtEsqNxbPToeb6DSse25Se4MfiK1rzjRs5
         3zvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wo+1IHNp3GYXjfswkalSmonaDkZuEJUvFP7FH/2V+V4=;
        b=h3OXOeovi8Rc5BzZp4am7W4yH8bp/oxjuBRQAGg3IL/nxWXMS5ny5bBLwi9q2YZhwt
         1grjpD8b8VWQLPNlous8jeVMQ5IIj3Ch7twuqOi6sLLmh3GpuNSJNHTy6AxgshPWGfTe
         nzF1DuLFk+4oVbWHbeaDtRbvmfgzJ0uI3kgQT7jwQlkDmvlOdobLM+NEW3w+4X4APnel
         Qc0t9mWvFQFsucQoaXRig7v65TfAGLZ1KGvBQgoeHHmHr9msOuSKArRCeAaLOb6nvdmC
         8Vwp3BtkQVewN4/hQ7Tetw8k3FzjYjKuzgjdVspQP+YDbpKr7ASIUwqEj+LurAp0U5lk
         P5uA==
X-Gm-Message-State: AFqh2krI8i0IDJ9srHkYBkrYhRIMsHFjs+019kWLD+cfqAAk/FP2Pono
        GukG40RKJ8B976EFW43Ig6Owx1BGpbsiLxJmU5W6RQ==
X-Google-Smtp-Source: AMrXdXsxaDAokgsgZs4z0pPvVcPcGRbCuCnyAN4JVV7ydb88UH1KS8zRwIVB2bG/bzSMKdfVunQTiI+zii/z0tWbN6A=
X-Received: by 2002:a5d:8185:0:b0:6e3:2350:744c with SMTP id
 u5-20020a5d8185000000b006e32350744cmr4625342ion.2.1673638633212; Fri, 13 Jan
 2023 11:37:13 -0800 (PST)
MIME-Version: 1.0
References: <20230111133351.807024-1-jannh@google.com> <CAHbLzkqqKWcMOxm9V4xeyDnnqBVzUjgMaPHtxV=+X3yq4NP1zw@mail.gmail.com>
In-Reply-To: <CAHbLzkqqKWcMOxm9V4xeyDnnqBVzUjgMaPHtxV=+X3yq4NP1zw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 13 Jan 2023 20:36:37 +0100
Message-ID: <CAG48ez3JUGWyDQ1hioVVy==5QCeDw3B=3TbGT0hUa1MygqOasg@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Fix ->anon_vma race
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
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

On Thu, Jan 12, 2023 at 2:06 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Wed, Jan 11, 2023 at 5:33 AM Jann Horn <jannh@google.com> wrote:
> >
> > If an ->anon_vma is attached to the VMA, collapse_and_free_pmd() requires
> > it to be locked. retract_page_tables() bails out if an ->anon_vma is
> > attached, but does this check before holding the mmap lock (as the comment
> > above the check explains).
> >
> > If we racily merge an existing ->anon_vma (shared with a child process)
> > from a neighboring VMA, subsequent rmap traversals on pages belonging to
> > the child will be able to see the page tables that we are concurrently
> > removing while assuming that nothing else can access them.
> >
> > Repeat the ->anon_vma check once we hold the mmap lock to ensure that there
> > really is no concurrent page table access.
> >
> > Reported-by: Zach O'Keefe <zokeefe@google.com>
> > Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > zokeefe@ pointed out to me that the current code (after my last round of patches)
> > can hit a lockdep assert by racing, and after staring at it a bit I've
>
> I'm supposed the lockdep is the one in collapse_and_free_pmd(). It is
> better to have the splat included in the commit log.

I pasted the splat in
https://lore.kernel.org/linux-mm/CAG48ez3434wZBKFFbdx4M9j6eUwSUVPd4dxhzW_k_POneSDF+A@mail.gmail.com/
- which part do you think should go into the commit log? Just the
"WARNING: CPU: 14 PID: 116 at
mm/khugepaged.c:1406 collapse_and_free_pmd+0x364/0x420"? Or the whole
ASAN splat below the lockdep complaint with all three backtraces?

> > convinced myself that this is a real, preexisting bug.
> > (I haven't written a reproducer for it though. One way to hit it might be
> > something along the lines of:
> >
> >  - set up a process A with a private-file-mapping VMA V1
> >  - let A fork() to create process B, thereby copying V1 in A to V1' in B
> >  - let B extend the end of V1'
> >  - let B put some anon pages into the extended part of V1'
>
> I don't quite get why we need this step. A cow fault on A's V1 isn't
> enough to have anon_vma for V1? This should not prevent V1 and V2 from
> sharing anon_vma. Did I miss something?

You're right, these steps don't work.
