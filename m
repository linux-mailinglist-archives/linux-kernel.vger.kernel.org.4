Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62931741CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 02:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjF2ATu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 20:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjF2ATo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 20:19:44 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C1E1FE8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 17:19:43 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-c01e1c0402cso113784276.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 17:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687997982; x=1690589982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOCwhEjJx8m3P+uqoutMCex7br6Ar+jNddvYlIlOyow=;
        b=wgd1l0e6NxvG1GpXVymBS3uJ69Blzs9EFo6/MXhliF4battkWVspUOPLIdzzMHC5Ro
         gmsdw6hUkihqQ6GKX7nQ9twqe/F2drQsF9cpTryOoHtP02Onh8YYQcZux8Elx7c4f+Qg
         xLz9w9Cs+QIy9HaZxfzyURb19BfFZLJDK1yiY/55vUdpd1tzKyzK6xXaIXHhxaUpwd0O
         wzKEmbCXND8r1t/DXs0B2Xx/6Pe040lmSb1blovGw5fbxhjQ8Vh+K3vy2YkVsyjfCcCT
         1oI4MrQjAQrsogmH4762py+PmEOhXhI3ocL06hr9MALERuHQVGcbr7T8bSNL3gUV/JBj
         EovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687997982; x=1690589982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOCwhEjJx8m3P+uqoutMCex7br6Ar+jNddvYlIlOyow=;
        b=g8bS+U38v313JGUV6TTEqDiCV+NyYWqbZhtMieyrEiJGO9kzVslg14LtbMh47TkNaO
         yAYsFH3VepTMA0HCVfJMsLriHB6rlNt36S7Q5yxnxxiF0u0vJ5fqFMhPipsH0jjMXEos
         qTcb99vC3D/ODP/3L2G+JHNIZozCJuQmByYD6POMaYfCOncm7yzJJjPjpSgGc4FhDttv
         99THIg/KRh7SFEPeXgg3Wfb4cqOItdDxbT3BDmksh4BKk8oGJK5n2jbOmJ1YSBQCDJre
         ud1lp+9SOEU0h9XhrvrKzcpDoFdInRhI/ha4hUJZCQkZn9Z5kW0kSN61zKJmabvm/U09
         aMPA==
X-Gm-Message-State: AC+VfDzhX8fzrWPC35i/ficcFb2N8krRrRtdaRZVv8oyNNJZ2pi9mVNK
        AYkz9yfDMNN1Z/DwYfZtvwbw41LhjQ8xMAcpvwzeMQ==
X-Google-Smtp-Source: ACHHUZ7U/sX1kQxj3Jm03KS0hnL5ZTZUFQ4b26UvL7OHyLyRT80mf67FkcvPkUx5YvOymCMLCMVJnqSMy1HkGbVY7h8=
X-Received: by 2002:a25:37d6:0:b0:c1e:f730:6856 with SMTP id
 e205-20020a2537d6000000b00c1ef7306856mr8608614yba.27.1687997982159; Wed, 28
 Jun 2023 17:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230628172529.744839-1-surenb@google.com> <20230628172529.744839-7-surenb@google.com>
 <ZJxulItq9iHi2Uew@x1n>
In-Reply-To: <ZJxulItq9iHi2Uew@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 28 Jun 2023 17:19:31 -0700
Message-ID: <CAJuCfpEPpdEScAG_UOiNfOTpue9ro0AP6414C4tBaK1rbVK7Hw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] mm: handle userfaults under VMA lock
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:32=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Wed, Jun 28, 2023 at 10:25:29AM -0700, Suren Baghdasaryan wrote:
> > Enable handle_userfault to operate under VMA lock by releasing VMA lock
> > instead of mmap_lock and retrying. Note that FAULT_FLAG_RETRY_NOWAIT
> > should never be used when handling faults under per-VMA lock protection
> > because that would break the assumption that lock is dropped on retry.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Maybe the sanitize_fault_flags() changes suite more in patch 3, but not a
> big deal I guess.

IIUC FAULT_FLAG_RETRY_NOWAIT comes into play in this patchset only in
the context of uffds, therefore that check seems to be needed when we
enable per-VMA lock uffd support, which is this patch. Does that make
sense?

>
> Acked-by: Peter Xu <peterx@redhat.com>

Thanks!

>
> Thanks!
>
> --
> Peter Xu
>
