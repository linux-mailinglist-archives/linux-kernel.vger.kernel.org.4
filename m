Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447C0717073
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjE3WLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjE3WLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:11:35 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF0BE5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:11:33 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-ba81deea9c2so4161577276.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685484692; x=1688076692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMyu1FVqUNEQDR9F0H42OTgZNOy0SCNDuJykJ5gkrpw=;
        b=DHM113YGgnJkBHYPTwpg3M+67zJX5zcePaPNh6JBv9Wis/NHrpDFAx0ks3iuCxJJM9
         wINi3i6AqBysE7LFcWZNehtYqKAuroIOwL8a8sd/Pi0a97YbTF7nzm1P4X6APqlcqyIf
         fgdKOvIthCN2qI3PC8nnJAGsUC9F8o24zrFn4Mx8E9fbkwmK8kyyJYs/s0lPuMtUWguz
         ZucZOJ+MFmJbUNoiUUNgppovuHCsdFcE/bKRob9Z5sqW+yx1ZriUb8o7XwInbyAtAe6l
         p7RDHaHEyNDIZpCug8G2OtGdyTPTsgojHKm3bQwt6whrQ2MHk7BXH6C5o4GygNQKDKwr
         Pl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685484692; x=1688076692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMyu1FVqUNEQDR9F0H42OTgZNOy0SCNDuJykJ5gkrpw=;
        b=P5zYnn5h2Nnv4F1QSfqN9SivxTKKutiPzLpAXTPerdD5QVi8ismtDQMECUT+zl0z/8
         F7+9SmrBKRqr8XjXeJluqdzfMKGfY60//lsZEFXJiudZYnUecYT0L8CfXBlNU+GpLAqT
         /OuRJ1MF51N94rZJekl44IVkeJl+Av8jpi44dBecVomP+BrUwEcKmTexfgDdYk84/HDM
         fjFus/b6XVbL+VGTal9ILIietzJzgpzxFfQ6X10h3G6kFKi6UoRAkU2tCbXbhnds9HKY
         p65uthVn0NbIfJeNnIiHV80J304kf0F4ojfKZavMvUByYFRTL7tldAsHmAVFKZS/CXvO
         qRJg==
X-Gm-Message-State: AC+VfDyHx/siMBqY2aTsPpAEKgrL/3IarNsxzEN1JlaoLdeMImeI7thC
        rmkPZtRPVVB9KNmP1Pp0A3Pzjp7szM51sfY/QKV5Bw==
X-Google-Smtp-Source: ACHHUZ7eWU+HQ5hk1bgtx2HWJQi7K2VIGjDa8IpMYtcmvIvul4QjT3T+wmdQAAVVcuOsIMbR3YKer0v1LTQi6GSw2pc=
X-Received: by 2002:a0d:d403:0:b0:565:ef11:1621 with SMTP id
 w3-20020a0dd403000000b00565ef111621mr3686413ywd.30.1685484691792; Tue, 30 May
 2023 15:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230428004139.2899856-1-jiaqiyan@google.com> <20230428004139.2899856-5-jiaqiyan@google.com>
 <20230530022456.GA1434147@hori.linux.bs1.fc.nec.co.jp> <CACw3F51shtGh97t3A3qhyg3E16stSifkgpcAZOi9JZuFFywfxA@mail.gmail.com>
In-Reply-To: <CACw3F51shtGh97t3A3qhyg3E16stSifkgpcAZOi9JZuFFywfxA@mail.gmail.com>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Tue, 30 May 2023 15:11:20 -0700
Message-ID: <CACw3F50auHR_dWnhVq3DbUp41-y7GKHR9LeKny_8ztAOR3W5rg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/7] mm/memory_failure: unmap raw HWPoison PTEs
 when possible
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "duenwen@google.com" <duenwen@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 2:31=E2=80=AFPM Jiaqi Yan <jiaqiyan@google.com> wro=
te:
>
> On Mon, May 29, 2023 at 7:25=E2=80=AFPM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=
=A3=E3=80=80=E7=9B=B4=E4=B9=9F)
> <naoya.horiguchi@nec.com> wrote:
> >
> > On Fri, Apr 28, 2023 at 12:41:36AM +0000, Jiaqi Yan wrote:
> > > When a folio's VMA is HGM eligible, try_to_unmap_one now only unmaps
> > > the raw HWPOISON page (previously split and mapped at PTE size).
> > > If HGM failed to be enabled on eligible VMA or splitting failed,
> > > try_to_unmap_one fails.
> > >
> > > For VMS that is not HGM eligible, try_to_unmap_one still unmaps
> > > the whole P*D.
> > >
> > > When only the raw HWPOISON subpage is unmapped but others keep mapped=
,
> > > the old way in memory_failure to check if unmapping successful doesn'=
t
> > > work. So introduce is_unmapping_successful() to cover both existing a=
nd
> > > new unmapping behavior.
> > >
> > > For the new unmapping behavior, store how many times a raw HWPOISON p=
age
> > > is expected to be unmapped, and how many times it is actually unmappe=
d
> > > in try_to_unmap_one(). A HWPOISON raw page is expected to be unmapped
> > > from a VMA if splitting succeeded in try_to_split_huge_mapping(), so
> > > unmap_success =3D (nr_expected_unamps =3D=3D nr_actual_unmaps).
> > >
> > > Old folio_set_hugetlb_hwpoison returns -EHWPOISON if a folio has any
> > > raw HWPOISON subpage, and try_memory_failure_hugetlb won't attempt
> > > recovery actions again because recovery used to be done on the entire
> > > hugepage. With the new unmapping behavior, this doesn't hold. More
> > > subpages in the hugepage can become corrupted, and needs to be recove=
red
> > > (i.e. unmapped) individually. New folio_set_hugetlb_hwpoison returns
> > > 0 after adding a new raw subpage to raw_hwp_list.
> > >
> > > Unmapping raw HWPOISON page requires allocating raw_hwp_page
> > > successfully in folio_set_hugetlb_hwpoison, so try_memory_failure_hug=
etlb
> > > now may fail due to OOM.
> > >
> > > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > > ---
> > ...
> >
> > > @@ -1827,6 +1879,31 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
> > >
> > >  #ifdef CONFIG_HUGETLB_PAGE
> > >
> > > +/*
> > > + * Given a HWPOISON @subpage as raw page, find its location in @foli=
o's
> > > + * _hugetlb_hwpoison. Return NULL if @subpage is not in the list.
> > > + */
> > > +struct raw_hwp_page *find_in_raw_hwp_list(struct folio *folio,

BTW, per our discussion here[1], this routine will probably reuse what
comes out of the refactored routine.

It should be safe for try_to_unmap_one to hold a raw_hwp_page returned
from find_in_raw_hwp_list as long as raw_hwp_list is protected by
mf_mutex.

[1] https://lore.kernel.org/linux-mm/CACw3F53+Hg4CgFoPj3LLSiURzWfa2egWLO-=
=3D12GzfhsNC3XTvQ@mail.gmail.com/T/#m9966de1007b80eb8bd2c2ce0a9db13624cd265=
2e

> > > +                                       struct page *subpage)
> > > +{
> > > +     struct llist_node *t, *tnode;
> > > +     struct llist_head *raw_hwp_head =3D raw_hwp_list_head(folio);
> > > +     struct raw_hwp_page *hwp_page =3D NULL;
> > > +     struct raw_hwp_page *p;
> > > +
> > > +     VM_BUG_ON_PAGE(PageHWPoison(subpage), subpage);
> >
> > I'm testing the series (on top of v6.2-rc4 + HGM v2 patchset) and found=
 the
> > following error triggered by this VM_BUG_ON_PAGE().  The testcase is ju=
st to
> > inject hwpoison on an anonymous page (it's not hugetlb-related one).
>
> Thanks for reporting this problem, Naoya!
>
> My mistake, this assertion meant to be "if !PageHWPoison(subpage)", to
> make sure the caller of find_in_raw_hwp_list is sure that subpage is
> hw corrupted.
>
> >
> >   [  790.610985] =3D=3D=3D> testcase 'mm/hwpoison/base/backend-anonymou=
s_error-hard-offline_access-avoid.auto3' start
> >   [  793.304927] page:000000006743177b refcount:1 mapcount:0 mapping:00=
00000000000000 index:0x700000000 pfn:0x14d739
> >   [  793.309322] memcg:ffff8a30c50b6000
> >   [  793.310934] anon flags: 0x57ffffe08a001d(locked|uptodate|dirty|lru=
|mappedtodisk|swapbacked|hwpoison|node=3D1|zone=3D2|lastcpupid=3D0x1fffff)
> >   [  793.316665] raw: 0057ffffe08a001d ffffe93cc5353c88 ffffe93cc5685fc=
8 ffff8a30c91878f1
> >   [  793.320211] raw: 0000000700000000 0000000000000000 00000001fffffff=
f ffff8a30c50b6000
> >   [  793.323665] page dumped because: VM_BUG_ON_PAGE(PageHWPoison(subpa=
ge))
> >   [  793.326764] ------------[ cut here ]------------
> >   [  793.329080] kernel BUG at mm/memory-failure.c:1894!
> >   [  793.331895] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> >   [  793.334854] CPU: 4 PID: 2644 Comm: mceinj.sh Tainted: G           =
 E    N 6.2.0-rc4-v6.2-rc2-230529-1404+ #63
> >   [  793.340710] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS 1.16.1-2.fc37 04/01/2014
> >   [  793.345875] RIP: 0010:hwpoison_user_mappings+0x654/0x780
> >   [  793.349066] Code: ef 89 de e8 6e bc f8 ff 48 8b 7c 24 20 48 83 c7 =
58 e8 10 bb d9 ff e9 5f fb ff ff 48 c7 c6 80 ce 4c b1 4c 89 ef e8 1c 38 f6 =
ff <0f> 0b 48 c7 c6 7b c8 4c b1 4c 89 ef e8 0b 38 f6 ff 0f 0b 8b 45 58
> >   [  793.359732] RSP: 0018:ffffa3ff85ed3d28 EFLAGS: 00010296
> >   [  793.362367] RAX: 000000000000003a RBX: 0000000000000018 RCX: 00000=
00000000000
> >   [  793.365763] RDX: 0000000000000001 RSI: ffffffffb14ac451 RDI: 00000=
000ffffffff
> >   [  793.368698] RBP: ffffe93cc535ce40 R08: 0000000000000000 R09: ffffa=
3ff85ed3ba0
> >   [  793.370837] R10: 0000000000000003 R11: ffffffffb1d3ed28 R12: 00000=
0000014d739
> >   [  793.372903] R13: ffffe93cc535ce40 R14: ffffe93cc535ce40 R15: ffffe=
93cc535ce40
> >   [  793.374931] FS:  00007f6ccc42a740(0000) GS:ffff8a31bbc00000(0000) =
knlGS:0000000000000000
> >   [  793.377136] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   [  793.378656] CR2: 0000561aad6474b2 CR3: 00000001492d4005 CR4: 00000=
00000170ee0
> >   [  793.380514] DR0: ffffffffb28ed7d0 DR1: ffffffffb28ed7d1 DR2: fffff=
fffb28ed7d2
> >   [  793.382296] DR3: ffffffffb28ed7d3 DR6: 00000000ffff0ff0 DR7: 00000=
00000000600
> >   [  793.384028] Call Trace:
> >   [  793.384655]  <TASK>
> >   [  793.385210]  ? __lru_add_drain_all+0x164/0x1f0
> >   [  793.386316]  memory_failure+0x352/0xaa0
> >   [  793.387249]  ? __pfx_bpf_lsm_capable+0x10/0x10
> >   [  793.388323]  ? __pfx_security_capable+0x10/0x10
> >   [  793.389350]  hard_offline_page_store+0x46/0x80
> >   [  793.390397]  kernfs_fop_write_iter+0x11e/0x200
> >   [  793.391441]  vfs_write+0x1e4/0x3a0
> >   [  793.392221]  ksys_write+0x53/0xd0
> >   [  793.392976]  do_syscall_64+0x3a/0x90
> >   [  793.393790]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> >
> > I'm wondering how this code path is called, one possible path is like t=
his:
> >
> >   hwpoison_user_mappings
> >     if PageHuge(hpage) && !PageAnon(hpage)
> >       try_to_split_huge_mapping()
> >         find_in_raw_hwp_list
> >           VM_BUG_ON_PAGE(PageHWPoison(subpage), subpage)
> >
> > but this looks unlikely because the precheck "PageHuge(hpage) && !PageA=
non(hpage)" is
> > false for anonymous pages.
> >
> > Another possible code path is:
> >
> >   hwpoison_user_mappings
> >     if PageHuge(hpage) && !PageAnon(hpage)
> >       ...
> >     else
> >       try_to_unmap
> >         rmap_walk
> >           rmap_walk_anon
> >             try_to_unmap_one
> >               if folio_test_hugetlb
> >                 if hgm_eligible
> >                   find_in_raw_hwp_list
> >                     VM_BUG_ON_PAGE(PageHWPoison(subpage), subpage)
> >
> > but this looks also unlikely because of checking folio_test_hugetlb and=
 hgm_eligible
> > (I think both are false in this testcase.)
> > Maybe I miss something (and I'll dig this more), but let me share the i=
ssue.
>
> I bet it is in "is_unmapping_successful". So another problem with this
> patch is, "is_unmapping_successful" should only calls
> find_in_raw_hwp_list after it handles non hugetlb and non shared
> mapping, i.e.:
>
> struct raw_hwp_page *hwp_page =3D NULL;
>
> if (!folio_test_hugetlb(folio) ||
>     folio_test_anon(folio) ||
>     !IS_ENABLED(CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING)) {
>         ...
> }
>
> hwp_page =3D find_in_raw_hwp_list(folio, poisoned_page);
> VM_BUG_ON_PAGE(!hwp_page, poisoned_page);
>
> I will make sure these two issues get fixed up in follow-up revisions.
>
> >
> > Thanks,
> > Naoya Horiguchi
