Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502016E155E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjDMTpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDMTpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:45:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F656E91
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:45:37 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-504dfc87927so2195144a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681415136; x=1684007136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88EFnL+Iup5e+05FhvL6jyNeiQTCaWgRGCFvR1JP38o=;
        b=ZtCKQZrLgkgivZRPYxzDX2JQp/+IFqVi/4GqLXx5xrMw8e5J1faiKuLAd37SML1gUr
         atW417I1a9aS5z45tNWN234ACP9BudUAv3atS/FdmuCWdtXBaJ+vF4zY3rp2EjKWYsb6
         1VjGiOIP6r6pUeWELZh6W0OoSgGYm+K+Urf6MRbgzL0ccP8UuNsO3s6JXzpa6Z45ftgk
         mKNPc5MCpOhdrjinEtpd9JIDlPeEUKbmoqG5tmrmFDcoHnY9kBjmZy0J9HVxzDll2An9
         ves5Jraa7wXtv5aryYv3w3EdR5uIbmky7k787yhI9T5NRfNKDx8PAwXh8Ld2CnwtzYHx
         k3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681415136; x=1684007136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88EFnL+Iup5e+05FhvL6jyNeiQTCaWgRGCFvR1JP38o=;
        b=CkJ598q0v3O2F8pANvV6dXRF5dnCCwulLWtW0hzqEnuF5QXUEcimbxJiuHyiGMatUz
         toLXVh7O+J1FGXzBtM2D2/9BOhnW/Z75NJvr9bLtRuXx+vOyesVihK5U8p5MvZ/CptVL
         HH5gIh/sAG/+cF26obvRhEMlAihP6jjMmhP8QITzjdSPUNg2Jq7Pt8w4zGf7r4n1FwCS
         LrDAqDzwyfRKqR45utVsYazn4ExW2K8di8PMxayaCvJQNjFkxKJmJB1X2yS9BSNisAZj
         UDu1FcXd9NuBj3ME8+XikQY85c5749+pRH7uP5rYNrHiYqgRnnCeMN+8dHycDHYpnUfy
         dqDg==
X-Gm-Message-State: AAQBX9fGTu6ieLAqnDr1rVIuco+Rw3GJ7rNRChNmGda9Ou8m5iBREqZU
        W4btUOP/YTzRJ/Ok3LCoBTCfEJgrX7fQ1z6nUQOCgA==
X-Google-Smtp-Source: AKy350Yau9Uf2g3DEINeSuj0OVv5i5Z1SKO/3AzTPErsOaG/BCkUgsFxi51PEgNXrD9GsG0de0ZZVRKWhnWphmvdxLI=
X-Received: by 2002:a50:aa84:0:b0:504:7094:2b59 with SMTP id
 q4-20020a50aa84000000b0050470942b59mr1796723edc.7.1681415135796; Thu, 13 Apr
 2023 12:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1676378702.git.quic_charante@quicinc.com>
In-Reply-To: <cover.1676378702.git.quic_charante@quicinc.com>
From:   Frank van der Linden <fvdl@google.com>
Date:   Thu, 13 Apr 2023 12:45:24 -0700
Message-ID: <CAPTztWYgRORXKp83Spm3DX8qJsi1rw5s=WbPcjUYfOxFXxRAwg@mail.gmail.com>
Subject: Re: [PATCH V7 0/2] mm: shmem: support POSIX_FADV_[WILL|DONT]NEED for
 shmem files
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
        markhemm@googlemail.com, rientjes@google.com, surenb@google.com,
        shakeelb@google.com, quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Feb 14, 2023 at 4:53=E2=80=AFAM Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
> advices to shmem files which can be helpful for the drivers who may want
> to manage the pages of shmem files on their own, like, that are created
> through shmem_file_setup[_with_mnt]().
>
> Changes in V7:
>  -- Use folio based interface, shmem_read_folio(), for FADV_WILLNEED.
>  -- Don't swap the SHM_LOCK'ed pages.
>
> Changes in V6:
>  -- Replaced the pages with folio's for shmem changes.
>  -- https://lore.kernel.org/all/cover.1675690847.git.quic_charante@quicin=
c.com/
>
> Changes in V5:
>  -- Moved the 'endbyte' calculations to a header function for use by shme=
m_fadvise().
>  -- Addressed comments from suren.
>  -- No changes in resend. Retested on the latest tip.
>  -- https://lore.kernel.org/all/cover.1648706231.git.quic_charante@quicin=
c.com/
>
> Changes in V4:
>   -- Changed the code to use reclaim_pages() to writeout the shmem pages =
to swap and then reclaim.
>   -- Addressed comments from Mark Hemment and Matthew.
>   -- fadvise() on shmem file may even unmap a page.
>   -- https://patchwork.kernel.org/project/linux-mm/patch/1644572051-24091=
-1-git-send-email-quic_charante@quicinc.com/
>
> Changes in V3:
>   -- Considered THP pages while doing FADVISE_[DONT|WILL]NEED, identified=
 by Matthew.
>   -- xarray used properly, as identified by Matthew.
>   -- Excluded mapped pages as it requires unmapping and the man pages of =
fadvise don't talk about them.
>   -- RESEND: Fixed the compilation issue when CONFIG_TMPFS is not defined=
.
>   -- https://patchwork.kernel.org/project/linux-mm/patch/1641488717-13865=
-1-git-send-email-quic_charante@quicinc.com/
>
> Changes in V2:
>   -- Rearranged the code to not to sleep with rcu_lock while using xas_()=
 functionality.
>   -- Addressed the comments from Suren.
>   -- https://patchwork.kernel.org/project/linux-mm/patch/1638442253-1591-=
1-git-send-email-quic_charante@quicinc.com/
>
> changes in V1:
>   -- Created the interface for fadvise(2) to work on shmem files.
>   -- https://patchwork.kernel.org/project/linux-mm/patch/1633701982-22302=
-1-git-send-email-charante@codeaurora.org/
>
>
> Charan Teja Kalla (2):
>   mm: fadvise: move 'endbyte' calculations to helper function
>   mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem
>
>  mm/fadvise.c  |  11 +-----
>  mm/internal.h |  21 +++++++++++
>  mm/shmem.c    | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 138 insertions(+), 10 deletions(-)
>
> --
> 2.7.4
>
>

I didn't see this patch before, so I looked a bit at the history. At
some point, in v3, dealing with mapped pages for DONTNEED was left
out, they are now skipped. Unfortunately, that makes this patch no
longer usable for a case that we have: restoring the (approximate)
swap state of a tmpfs file. This involves walking a potentially large
number of regions, and explicitly pushing them out to swap. This can
be used to e.g. restore the state VM memory that is backed by a tmpfs
file, avoiding memory usage by cold VM pages after resume.

If DONTNEED also reclaims mapped pages (e.g. they get pushed out to
swap, if any), implementing the above use case efficiently is simple:
use io_uring with a vector that contains each region and the fadvise
method.

Without DONTNEED reclaiming mapped pages, you'd have to do mmap +
madvise(MADV_PAGEOUT) for each region that you want swapped out, which
is rather inefficient.

I understand that the semantics for POSIX_FADV_DONTNEED on shmem/tmpfs
files are open to interpretation, as it is a special case. And you can
certainly make the argument that relying on behavior caused by what
can be considered an implementation detail is bad.

So, is there any way we can make this use case work efficiently using
this patch?

You state in the commit message:

> So, FADV_DONTNEED also covers the semantics of MADV_PAGEOUT for file page=
s
> and there is no purpose of PAGEOUT for file pages.

But that doesn't seem correct: for shmem file pages, there actually
can be a purpose, and the FADV_DONTNEED as implemented for shmem in
this patch set does not cover the semantics.

You can say that it doesn't need to cover the pageout case of mapped
shmem pages, and that's fair. But I don't think you can claim that it
covers the case as currently implemented.

I suppose there are three options here:

1) Do nothing, this use case will just have to spend more time doing
mmap+madvise
2) Don't skip mapped pages for POSIX_FADV_DONTNEED in shmem_fadvise
3) Implement something like POSIX_FADV_PAGEOUT_NP, which would include
mapped pages.

What do people think?

- Frank
