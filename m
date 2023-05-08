Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AD06FB48E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjEHQAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjEHQAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:00:30 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C8540D4
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:00:28 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-757756e2eefso72086785a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 09:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683561628; x=1686153628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pB2YUBbkkhRqdEuS86bLaceZppwl5VGLTAnx/EHATw=;
        b=pS50okJn+DEj1FhKDW07zXVSpLfpXPb/fBXu4OCYGcVBBjkLHrJ4kZfooEZvcXP9rp
         0r1p5nAfrYx3zKpDb378iLebIlAjdrbzyWuA3S+bip2eB7QW9rgKCIMNkS9/xKjy/PsL
         SlSbI2PQ0ofEYV5cCMDDLftwf25XD3w2FGW6tI55Ka0+/K2uR3qaqrz8Ue0paqd3jc9l
         hmNsCbMTEyq9N06q3jW0texS/Zmou8gS7BhWp07lP+Jr9+rsLT1H5QViG3UMNnXPMCBg
         Jfwt6zsLNRcrTH3KIdrSxBbOp2dH9nDVtntlvvwzuVxH06ysu3XImTp41a9v5emfoPa/
         jTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683561628; x=1686153628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pB2YUBbkkhRqdEuS86bLaceZppwl5VGLTAnx/EHATw=;
        b=jZk86Zy5ooFVynja1oQuXb6xJDVdQTq2vuLORUIN6+RmeWOai9PedL942A+FCc3k9g
         2caYLM6iQQT08aro7EjLqEb8ANfTcKk5q51j2YaO3ga2Vti4CsodTd9IOfPZ0whw7enI
         m6lKB8I6CiCKm164SujAzUY0IO91aybE3z9kPoZ4647WKQf7MrnxUolGFDgBmI2P/6c7
         99XfpQuITAur1NVj8OJqYW1O2vh3Q4ad6OnvGTxm5O4x3cCJfS461nOOgnuHylqrXGGv
         P6KCPFQ0ZLHe6VvoCGbQcCAQLgY8S9r1L82Aoopi+EIyAVaBsst77LcJrnQZX7ebb9kl
         SONw==
X-Gm-Message-State: AC+VfDxbnqB9wEvB3evvn1l0Fpe0mTyYQfDgQUVK+uLprUEg+TnkVSUd
        HQrKfxFd+3px5rUNSalMhG8XfwNAR/BPYTZEe40=
X-Google-Smtp-Source: ACHHUZ4+YaRzP/2WFqgxw9MEO6lRKxnBbuXGeKO0JmvxRM5A20ZI9JXGXms558Gyu90FkMXNicwXp1YM+KyUP5eGb9c=
X-Received: by 2002:a05:6214:2427:b0:61a:c2bf:9f0b with SMTP id
 gy7-20020a056214242700b0061ac2bf9f0bmr18496822qvb.6.1683561627381; Mon, 08
 May 2023 09:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230505185054.2417128-1-nphamcs@gmail.com> <20230506030140.GC3281499@google.com>
 <20230508140658.GA3421@cmpxchg.org>
In-Reply-To: <20230508140658.GA3421@cmpxchg.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 8 May 2023 09:00:16 -0700
Message-ID: <CAKEwX=MtunOe6A--SG3ud-gUFg3bXFJgG4csgwHeZFAEqjCgHg@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: move LRU update from zs_map_object() to zs_malloc()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 7:07=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Sat, May 06, 2023 at 12:01:40PM +0900, Sergey Senozhatsky wrote:
> > On (23/05/05 11:50), Nhat Pham wrote:
> > > Under memory pressure, we sometimes observe the following crash:
> > >
> > > [ 5694.832838] ------------[ cut here ]------------
> > > [ 5694.842093] list_del corruption, ffff888014b6a448->next is LIST_PO=
ISON1 (dead000000000100)
> > > [ 5694.858677] WARNING: CPU: 33 PID: 418824 at lib/list_debug.c:47 __=
list_del_entry_valid+0x42/0x80
> > > [ 5694.961820] CPU: 33 PID: 418824 Comm: fuse_counters.s Kdump: loade=
d Tainted: G S                5.19.0-0_fbk3_rc3_hoangnhatpzsdynshrv41_10870=
_g85a9558a25de #1
> > > [ 5694.990194] Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive=
 MP, BIOS YMM16 05/24/2021
> > > [ 5695.007072] RIP: 0010:__list_del_entry_valid+0x42/0x80
> > > [ 5695.017351] Code: 08 48 83 c2 22 48 39 d0 74 24 48 8b 10 48 39 f2 =
75 2c 48 8b 51 08 b0 01 48 39 f2 75 34 c3 48 c7 c7 55 d7 78 82 e8 4e 45 3b =
00 <0f> 0b eb 31 48 c7 c7 27 a8 70 82 e8 3e 45 3b 00 0f 0b eb 21 48 c7
> > > [ 5695.054919] RSP: 0018:ffffc90027aef4f0 EFLAGS: 00010246
> > > [ 5695.065366] RAX: 41fe484987275300 RBX: ffff888008988180 RCX: 00000=
00000000000
> > > [ 5695.079636] RDX: ffff88886006c280 RSI: ffff888860060480 RDI: ffff8=
88860060480
> > > [ 5695.093904] RBP: 0000000000000002 R08: 0000000000000000 R09: ffffc=
90027aef370
> > > [ 5695.108175] R10: 0000000000000000 R11: ffffffff82fdf1c0 R12: 00000=
00010000002
> > > [ 5695.122447] R13: ffff888014b6a448 R14: ffff888014b6a420 R15: 00000=
000138dc240
> > > [ 5695.136717] FS:  00007f23a7d3f740(0000) GS:ffff888860040000(0000) =
knlGS:0000000000000000
> > > [ 5695.152899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 5695.164388] CR2: 0000560ceaab6ac0 CR3: 000000001c06c001 CR4: 00000=
000007706e0
> > > [ 5695.178659] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> > > [ 5695.192927] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000=
00000000400
> > > [ 5695.207197] PKRU: 55555554
> > > [ 5695.212602] Call Trace:
> > > [ 5695.217486]  <TASK>
> > > [ 5695.221674]  zs_map_object+0x91/0x270
> > > [ 5695.229000]  zswap_frontswap_store+0x33d/0x870
> > > [ 5695.237885]  ? do_raw_spin_lock+0x5d/0xa0
> > > [ 5695.245899]  __frontswap_store+0x51/0xb0
> > > [ 5695.253742]  swap_writepage+0x3c/0x60
> > > [ 5695.261063]  shrink_page_list+0x738/0x1230
> > > [ 5695.269255]  shrink_lruvec+0x5ec/0xcd0
> > > [ 5695.276749]  ? shrink_slab+0x187/0x5f0
> > > [ 5695.284240]  ? mem_cgroup_iter+0x6e/0x120
> > > [ 5695.292255]  shrink_node+0x293/0x7b0
> > > [ 5695.299402]  do_try_to_free_pages+0xea/0x550
> > > [ 5695.307940]  try_to_free_pages+0x19a/0x490
> > > [ 5695.316126]  __folio_alloc+0x19ff/0x3e40
> > > [ 5695.323971]  ? __filemap_get_folio+0x8a/0x4e0
> > > [ 5695.332681]  ? walk_component+0x2a8/0xb50
> > > [ 5695.340697]  ? generic_permission+0xda/0x2a0
> > > [ 5695.349231]  ? __filemap_get_folio+0x8a/0x4e0
> > > [ 5695.357940]  ? walk_component+0x2a8/0xb50
> > > [ 5695.365955]  vma_alloc_folio+0x10e/0x570
> > > [ 5695.373796]  ? walk_component+0x52/0xb50
> > > [ 5695.381634]  wp_page_copy+0x38c/0xc10
> > > [ 5695.388953]  ? filename_lookup+0x378/0xbc0
> > > [ 5695.397140]  handle_mm_fault+0x87f/0x1800
> > > [ 5695.405157]  do_user_addr_fault+0x1bd/0x570
> > > [ 5695.413520]  exc_page_fault+0x5d/0x110
> > > [ 5695.421017]  asm_exc_page_fault+0x22/0x30
> > >
> > > After some investigation, I have found the following issue: unlike ot=
her
> > > zswap backends, zsmalloc performs the LRU list update at the object
> > > mapping time, rather than when the slot for the object is allocated.
> > > This deviation was discussed and agreed upon during the review proces=
s
> > > of the zsmalloc writeback patch series:
> > >
> > > https://lore.kernel.org/lkml/Y3flcAXNxxrvy3ZH@cmpxchg.org/
> > >
> > > Unfortunately, this introduces a subtle bug that occurs when there is=
 a
> > > concurrent store and reclaim, which interleave as follows:
> > >
> > > zswap_frontswap_store()            shrink_worker()
> > >   zs_malloc()                        zs_zpool_shrink()
> > >     spin_lock(&pool->lock)             zs_reclaim_page()
> > >     zspage =3D find_get_zspage()
> > >     spin_unlock(&pool->lock)
> > >                                          spin_lock(&pool->lock)
> > >                                          zspage =3D list_first_entry(=
&pool->lru)
> > >                                          list_del(&zspage->lru)
> > >                                            zspage->lru.next =3D LIST_=
POISON1
> > >                                            zspage->lru.prev =3D LIST_=
POISON2
> >
> >                                       Will list_del_init() there do the=
 trick?
> >
> > >                                          spin_unlock(&pool->lock)
> > >   zs_map_object()
> > >     spin_lock(&pool->lock)
> > >     if (!list_empty(&zspage->lru))
> > >       list_del(&zspage->lru)
> >
> >       list_del_init()
>
> The deeper bug here is that zs_map_object() tries to add the page to
> the LRU list while the shrinker has it isolated for reclaim. This is
> way too sutble and error prone. Even if it worked now, it'll cause
> corruption issues down the line.
>
> For example, Nhat is adding a secondary entry point to reclaim.
> Reclaim expects that a page that's on the LRU is also on the fullness
> list, so this would lead to a double remove_zspage() and BUG_ON().
>
> This patch doesn't just fix the crash, it eliminates the deeper LRU
> isolation issue and makes the code more robust and simple.

I agree. IMO, less unnecessary concurrent interaction is always a
win for developers' and maintainers' cognitive load.

As a side benefit - this also gets rid of the inelegant check
(mm =3D=3D ZS_MM_WO). The fact that we had to include a
a multi-paragraph explanation for a 3-line piece of code
should have been a red flag.
