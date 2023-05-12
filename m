Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ACD70110E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 23:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239561AbjELV13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 17:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjELV12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 17:27:28 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CE530D8
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:27:26 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f396606ab0so1175401cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683926845; x=1686518845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQrzSoX4BEMgh4sQvp+Oyfr2kigwqdwZuISmq1ZjPMA=;
        b=ABsGeYvqpnB2WCnZdbLNvpIRZLn9LyJDsia/vNaB8KJPUcjY8Nai0KtDzJlNRIUgLp
         C5HMdd2xJpLxd+wusI/okBqza7mKWrXDIIe+eKJEH4mx2c/OQx9Y3/BTRxsEpZTTGoJy
         Agyc4fopiD2DkAbygyJt6MJQKXB3dPGo2sfnkymAPxkQ8NwediMYu8BCyBi3rvtEo/Cc
         ZRBrvfJ/psXj1bbIM0NcHrUfREpZM9EHktOhHxY4IgnNKPfSsEEcXm50CYQ791x+Vl33
         5KPJtu2LRLubuFxv7w2TG2EJaW+18efXriAODV4A2nql3Y49ZgMjsG28lziRGjBhePor
         ePlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683926845; x=1686518845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQrzSoX4BEMgh4sQvp+Oyfr2kigwqdwZuISmq1ZjPMA=;
        b=SDCWc3X3ApSwAE3IcJtIiRVdZyyam9N9gsBZYy0ITdixE5UwsrFK+wqzLKDII5PFXY
         I2vw7QiATLaQjkKDY1OtyOZRbllh04qgDoxMYhCCXH3BEZ4hp+52PRay17JPARmQXGSc
         AjoJQHtXMhRC0HI3dYHXbw89gWCTunEjKodLOwoOJPScpBQ329dVARZDUgoNo9Wona0Z
         ykxKGX/SP0WmXceP00A5rCxjAlfskASQuJSjmCVW69GCJScHQSCSzjZ4s7yO9cyHZfyy
         z7eyKAkSEoMP3g4PQZpy7SF7T0ti3oRbGFFIKEF3zd30jpuYms+igXbgFcBIFkzcFS7b
         qhqg==
X-Gm-Message-State: AC+VfDy8DTF8ZOJ6vgNYS6d2dOYeAkpaXc2rAI3YEnkSncr8Bg/bn2nY
        FOeVgxdJ9pbD0iUhdu40snsV40kfjfrGy//E6/f24A==
X-Google-Smtp-Source: ACHHUZ5rISReyNVNJQOrLE1rpa97BbiLJjA4aD4/WRWtQ6UAxiZqw9+5zyRgsUeaC49oKUet1/J5svgRQSJrDND5urU=
X-Received: by 2002:a05:622a:5cc:b0:3f2:1441:3c11 with SMTP id
 d12-20020a05622a05cc00b003f214413c11mr711936qtb.2.1683926845536; Fri, 12 May
 2023 14:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230512072036.1027784-1-junxiao.chang@intel.com>
In-Reply-To: <20230512072036.1027784-1-junxiao.chang@intel.com>
From:   James Houghton <jthoughton@google.com>
Date:   Fri, 12 May 2023 14:26:49 -0700
Message-ID: <CADrL8HV25JyeaT=peaR7NWhUiaBz8LzpyFosYZ3_0ACt+twU6w@mail.gmail.com>
Subject: Re: [PATCH] mm: fix hugetlb page unmap count balance issue
To:     Junxiao Chang <junxiao.chang@intel.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, jmarchan@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 12:20=E2=80=AFAM Junxiao Chang <junxiao.chang@intel=
.com> wrote:
>
> hugetlb page usually is mapped with pmd, but occasionally it might be
> mapped with pte. QEMU can use udma-buf to create host dmabufs for guest
> framebuffers. When QEMU is launched with parameter "hugetlb=3Don",
> udmabuffer driver maps hugetlb page with pte in page fault handler.
> Call chain looks like:
>
> page_add_file_rmap
> do_set_pte
> finish_fault
> __do_fault -> udmabuf_vm_fault, it maps hugetlb page here.
> do_read_fault
>
> In function page_add_file_rmap, compound is false since it is pte mapping=
.
>
> When qemu exits and page is unmapped in function page_remove_rmap, the
> hugetlb page should not be handled in pmd way.
>
> This change is to check compound parameter as well as hugetlb flag. It
> fixes below kernel bug which is reproduced with 6.3 kernel:
>
> [  114.027754] BUG: Bad page cache in process qemu-system-x86  pfn:37aa00
> [  114.034288] page:000000000dd2153b refcount:514 mapcount:-4 mapping:000=
000004b01ca30 index:0x13800 pfn:0x37aa00
> [  114.044277] head:000000000dd2153b order:9 entire_mapcount:-4 nr_pages_=
mapped:4 pincount:512
> [  114.052623] aops:hugetlbfs_aops ino:6f93
> [  114.056552] flags: 0x17ffffc0010001(locked|head|node=3D0|zone=3D2|last=
cpupid=3D0x1fffff)
> [  114.064115] raw: 0017ffffc0010001 fffff7338deb0008 fffff7338dea0008 ff=
ff98dc855ea870
> [  114.071847] raw: 000000000000009c 0000000000000002 00000202ffffffff 00=
00000000000000
> [  114.079572] page dumped because: still mapped when deleted
> [  114.085048] CPU: 0 PID: 3122 Comm: qemu-system-x86 Tainted: G    BU  W=
   E      6.3.0-v3+ #62
> [  114.093566] Hardware name: Intel Corporation Alder Lake Client Platfor=
m DDR5 SODIMM SBS RVP, BIOS ADLPFWI1.R00.3084.D89.2303211034 03/21/2023
> [  114.106839] Call Trace:
> [  114.109291]  <TASK>
> [  114.111405]  dump_stack_lvl+0x4c/0x70
> [  114.115073]  dump_stack+0x14/0x20
> [  114.118395]  filemap_unaccount_folio+0x159/0x220
> [  114.123021]  filemap_remove_folio+0x54/0x110
> [  114.127295]  remove_inode_hugepages+0x111/0x5b0
> [  114.131834]  hugetlbfs_evict_inode+0x23/0x50
> [  114.136111]  evict+0xcd/0x1e0
> [  114.139083]  iput.part.0+0x183/0x1e0
> [  114.142663]  iput+0x20/0x30
> [  114.145466]  dentry_unlink_inode+0xcc/0x130
> [  114.149655]  __dentry_kill+0xec/0x1a0
> [  114.153325]  dput+0x1ca/0x3c0
> [  114.156293]  __fput+0xf4/0x280
> [  114.159357]  ____fput+0x12/0x20
> [  114.162502]  task_work_run+0x62/0xa0
> [  114.166088]  do_exit+0x352/0xae0
> [  114.169321]  do_group_exit+0x39/0x90
> [  114.172892]  get_signal+0xa09/0xa30
> [  114.176391]  arch_do_signal_or_restart+0x33/0x280
> [  114.181098]  exit_to_user_mode_prepare+0x11f/0x190
> [  114.185893]  syscall_exit_to_user_mode+0x2a/0x50
> [  114.190509]  do_syscall_64+0x4c/0x90
> [  114.194095]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>
> Fixes: 53f9263baba6 ("mm: rework mapcount accounting to enable 4k mapping=
 of THPs")
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> ---
>  mm/rmap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 19392e090bec6..b42fc0389c243 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1377,9 +1377,9 @@ void page_remove_rmap(struct page *page, struct vm_=
area_struct *vma,
>
>         VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>
> -       /* Hugetlb pages are not counted in NR_*MAPPED */
> -       if (unlikely(folio_test_hugetlb(folio))) {
> -               /* hugetlb pages are always mapped with pmds */
> +       /* Hugetlb pages usually are not counted in NR_*MAPPED */
> +       if (unlikely(folio_test_hugetlb(folio) && compound)) {
> +               /* hugetlb pages are mapped with pmds */
>                 atomic_dec(&folio->_entire_mapcount);
>                 return;
>         }

This alone doesn't fix mapcounting for PTE-mapped HugeTLB pages. You
need something like [1]. I can resend it if that's what we should be
doing, but this mapcounting scheme doesn't work when the page structs
have been freed.

It seems like it was a mistake to include support for hugetlb memfds in udm=
abuf.

[1]: https://lore.kernel.org/linux-mm/20230306230004.1387007-2-jthoughton@g=
oogle.com/

- James
