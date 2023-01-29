Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1711767FD2C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 07:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjA2Gtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 01:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2Gto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 01:49:44 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EB42203E
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 22:49:42 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-163adf0cfc4so286750fac.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 22:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xuk/F/qL7MKVeL0ItEGKgOlymizhMFbzQX+eMzmUH8E=;
        b=GeVdaE3khpUjaaN6KVMaUvePylekdJv7O68mPVFytB7sGgZLiALLJyMiTltWhGnG2O
         dpGj8Ngf0d0v60YY1WcBJlyQeT9sYt+vrdyq9bDnL8DwOlZ8lwcQnShYwYE4GL8g5X3K
         gILLIJ4W3vLU6naAwxELyGtSEvhL0tWNu6qbL89VBGMHY9medXGUsoE1A163rewMplYt
         m+UPpIV2rcIwh3VL1wh+/FvcdIjI46SE+3m65V/2VW6mXdo2OuENSe8HkHA7OWeorogQ
         tuu0HGn7hXKNh8Pv084JxCZ2+r9gZw3C3wr/8tGhxJhnhNg1mKcqFJAm/1cgnFjMg2f2
         uC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xuk/F/qL7MKVeL0ItEGKgOlymizhMFbzQX+eMzmUH8E=;
        b=VvHReav+bCxCA31CjONBLptVK5AK+BlmUs1KsHeh1emRyzN+J5g1GJESoL+/z0BwMe
         2wtnrQAojCZs9002O3tnqxjNbnVFafmCfAi3MB+qfuFKsG2rmoWcih51TVcZR2o2QySY
         +xERkJnCcTreFP3lZEDAAK5Nrs0ScbeBatazA9bsLJTV8vnZ4Op25ReaNB683m6hiM3g
         YJE7rtNq+6SzE3c8xLUbg18FZmgFk35j6hz38DAgv530GE1tzQws3weKTNkCnG2fJQFp
         HaiALbNpxf1ntc2xdoLlqQ/pzMK5znnPB1CFxEUQ275A5za4lwg/Wk6GfazoszYm5I7/
         nwBg==
X-Gm-Message-State: AFqh2kpv8ArmctKOTeYC9jrBIUo839810pQuholuGPLUfQ52TCB0RXSv
        OHuH757BpfYHaBr2W6mJGrqHDg==
X-Google-Smtp-Source: AMrXdXuzGRm+HNddhS5FNEJtOAlyIv/9Kvhz8vO0UGHPoZAq8fCkFDz3/RbrXxehZfkYogoJt84EgQ==
X-Received: by 2002:a05:6870:610d:b0:15f:13db:ed3b with SMTP id s13-20020a056870610d00b0015f13dbed3bmr12534973oae.57.1674974980784;
        Sat, 28 Jan 2023 22:49:40 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z20-20020a4ad1b4000000b0051762747277sm790223oor.41.2023.01.28.22.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 22:49:39 -0800 (PST)
Date:   Sat, 28 Jan 2023 22:49:31 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
cc:     Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: kernel BUG in page_add_anon_rmap
In-Reply-To: <713c6242-be65-c212-b790-2b908627c1b4@google.com>
Message-ID: <9d8fb9c-1b81-67cd-e55b-34517388e1ab@google.com>
References: <IA1PR07MB983017D2FBA174D2FF78CEB6ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com> <Y9LNCouUvsUFCYkT@casper.infradead.org> <adc9152e-c547-12ec-3538-006500619896@redhat.com> <713c6242-be65-c212-b790-2b908627c1b4@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-1811275884-1674974979=:23545"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-1811275884-1674974979=:23545
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 27 Jan 2023, Hugh Dickins wrote:
> On Fri, 27 Jan 2023, David Hildenbrand wrote:
> > On 26.01.23 19:57, Matthew Wilcox wrote:
> > > On Wed, Jan 25, 2023 at 11:59:16PM +0000, Sanan Hasanov wrote:
> > >> Good day, dear maintainers,
> > >>
> > >> We found a bug using a modified kernel configuration file used by sy=
zbot.
> > >>
> > >> We enhanced the coverage of the configuration file using our tool,
> > >> klocalizer.
> > >>
> > >> Kernel Branch:=C2=A06.2.0-rc5-next-20230124
> > >> Kernel
> > >> config:=C2=A0https://drive.google.com/file/d/1MZSgIF4R9QfikEuF5siUIZ=
VPce-GiJQK/view?usp=3Dsharing
> > >> Reproducer:=C2=A0https://drive.google.com/file/d/1H5KWkT9VVMWTUVVgIa=
Zi6J-fmukRx-BM/view?usp=3Dsharing
> > >>
> > >> Thank you!
> > >>
> > >> Best regards,
> > >> Sanan Hasanov

This is a very interesting find: the thanks go to you.

> > >>
> > >> head: 0000000000020000 0000000000000000 00000004ffffffff ffff8881002=
b8000
> > >> page dumped because: VM_BUG_ON_PAGE(!first && (flags & (( rmap_t)(((=
(1UL)))
> > >> << (0)))))
> > >> ------------[ cut here ]------------
> > >=20
> > > I know it says "cut here" and you did that, but including just a few
> > > lines above that would be so much more helpful.  I can infer that thi=
s
> > > is a multi-page folio, but more than that is hard to tell.
> > >=20
> > >> kernel BUG at mm/rmap.c:1248!
> > >=20
> > > That tracks with VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), p=
age);
> > >=20
> > >> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > >> CPU: 7 PID: 14932 Comm: syz-executor.1 Not tainted 6.2.0-rc5-next-20=
230124
> > >> #1
> > >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
> > >> 04/01/2014
> > >> RIP: 0010:page_add_anon_rmap+0xddd/0x11c0 mm/rmap.c:1248
> > >> Code: c0 ff 48 8b 34 24 48 89 df e8 1f ff 07 00 49 89 c6 e9 85 f6 ff=
 ff e8
> > >> 52 73 c0 ff 48 c7 c6 c0 3c d8 89 48 89 ef e8 b3 23 f8 ff <0f> 0b e8 =
3c 73
> > >> c0 ff 48 c7 c6 00 3b d8 89 48 89 ef e8 9d 23 f8 ff
> > >> RSP: 0018:ffffc9000c56f7b0 EFLAGS: 00010293
> > >> RAX: 0000000000000000 RBX: ffff88807efc6f30 RCX: 0000000000000000
> > >> RDX: ffff8880464fd7c0 RSI: ffffffff81be733d RDI: fffff520018adedb
> > >> RBP: ffffea0000c68080 R08: 0000000000000056 R09: 0000000000000000
> > >> R10: 0000000000000001 R11: 0000000000000001 R12: ffffea0000c68000
> > >> R13: 0000000000000001 R14: ffffea0000c68088 R15: 0000000000000000
> > >> FS:  00007f717898a700(0000) GS:ffff888119f80000(0000)
> > >> knlGS:0000000000000000
> > >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >> CR2: 00007f7178947d78 CR3: 000000004a9e6000 CR4: 0000000000350ee0
> > >> Call Trace:
> > >>   <TASK>
> > >>   remove_migration_pte+0xaa6/0x1390 mm/migrate.c:261
> > >=20
> > >                          if (folio_test_anon(folio))
> > >                                  page_add_anon_rmap(new, vma, pvmw.ad=
dress,
> > >                                                     rmap_flags);
> > >=20
> > > Earlier in that function, we had:
> > >                  if (folio_test_anon(folio) &&
> > >                  !is_readable_migration_entry(entry))
> > >                          rmap_flags |=3D RMAP_EXCLUSIVE;
> > >=20
> > > so that also makes sense.  We can also infer that RMAP_COMPOUND wasn'=
t
> > > set, so we're trying to do just one page from the folio.
> > >=20
> > > All right, back to rmap.c:
> > >=20
> > >                  first =3D atomic_inc_and_test(&page->_mapcount);
> > >=20
> > > So first is clearly false (ie _mapcount was not -1), implying somebod=
y
> > > else already mapped this page.  Not really sure what's going on at
> > > this point.  Seems unlikely that the folio changes in
> > > remove_migration_pte() are responsible since they're from last Januar=
y.
> > > Huang has some more changes to migrate.c that I don't feel qualified
> > > to judge.
> > >=20
> > > Nothing's jumping out at me as obviously wrong.  Is it possible to
> > > do a bisect?
> >=20
> > I reproduced on next-20230127 (did not try upstream yet).

Upstream's fine; on next-20230127 (with David's repro) it bisects to
5ddaec50023e ("mm/mmap: remove __vma_adjust()").  I think I'd better
hand on to Liam, rather than delay you by puzzling over it further myself.

> >=20
> > I think two key things are that a) THP are set to "always" and b) we ha=
ve a
> > NUMA setup [I assume].
> >=20
> > The relevant bits:
> >=20
> > [  439.886738] page:00000000c4de9000 refcount:513 mapcount:2
> > mapping:0000000000000000 index:0x20003 pfn:0x14ee03
> > [  439.893758] head:000000003d5b75a4 order:9 entire_mapcount:0
> > nr_pages_mapped:511 pincount:0
> > [  439.899611] memcg:ffff986dc4689000
> > [  439.902207] anon flags:
> > 0x17ffffc009003f(locked|referenced|uptodate|dirty|lru|active|head|swapb=
acked|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
> > [  439.910737] raw: 0017ffffc0020000 ffffe952c53b8001 ffffe952c53b80c8
> > dead000000000400
> > [  439.916268] raw: 0000000000000000 0000000000000000 0000000000000001
> > 0000000000000000
> > [  439.921773] head: 0017ffffc009003f ffffe952c538b108 ffff986de35a0010
> > ffff98714338a001
> > [  439.927360] head: 0000000000020000 0000000000000000 00000201ffffffff
> > ffff986dc4689000
> > [  439.932341] page dumped because: VM_BUG_ON_PAGE(!first && (flags & (=
(
> > rmap_t)((((1UL))) << (0)))))
> >=20
> >=20
> > Indeed, the mapcount of the subpage is 2 instead of 1. The subpage is o=
nly
> > mapped into a single
> > page table (no fork() or similar).

Yes, that mapcount:2 is weird; and what's also weird is the index:0x20003:
what is remove_migration_pte(), in an mbind(0x20002000,...), doing with
index:0x20003?

My guess is that the remove-__vma_adjust() commit is not properly updating
vm_pgoff into non_vma in some case: so that when remove_migration_pte()
looks for where to insert the new pte, it's off by one page.

> >=20
> > I created this reduced reproducer that triggers 100%:

Very helpful, thank you.

> >=20
> >=20
> > #include <stdint.h>
> > #include <unistd.h>
> > #include <sys/mman.h>
> > #include <numaif.h>
> >=20
> > int main(void)
> > {
> > =09mmap((void*)0x20000000ul, 0x1000000ul, PROT_READ|PROT_WRITE|PROT_EXE=
C,
> > =09     MAP_ANONYMOUS|MAP_FIXED|MAP_PRIVATE, -1, 0ul);
> > =09madvise((void*)0x20000000ul, 0x1000000ul, MADV_HUGEPAGE);
> >=20
> > =09*(uint32_t*)0x20000080 =3D 0x80000;
> > =09mlock((void*)0x20001000ul, 0x2000ul);
> > =09mlock((void*)0x20000000ul, 0x3000ul);

It's not an mlock() issue in particular: quickly established by
substituting madvise(,, MADV_NOHUGEPAGE) for those mlock() calls.
Looks like a vma splitting issue now.

> > =09mbind((void*)0x20002000ul, 0x1000ul, MPOL_LOCAL, NULL, 0x7fful,
> > =09MPOL_MF_MOVE);

I guess it will turn out not to be relevant to this particular syzbug,
but what do we expect an mbind() of just 0x1000 of a THP to do?

It's a subject I've wrestled with unsuccessfully in the past: I found
myself arriving at one conclusion (split THP) in one place, and a contrary
conclusion (widen range) in another place, and never had time to work out
one unified answer.

So I do wonder what pte replaces the migration entry when the bug here
is fixed: is it a pte pointing into the THP as before, in which case
what was the point of "migration"? is it a Copy-On-Bind page?
or has the whole THP been migrated?

I ought to read through those "estimated mapcount" threads more
carefully: might be relevant, but I've not paid enough attention.

Hugh

> > =09return 0;
> > }
> >=20
> > We map a large-enough are for a THP and then populate a fresh anon THP =
(PMD
> > mapped)
> > to write to it.
> >=20
> > The first mlock() will trigger PTE-mapping the THP and mlocking that su=
bpage.
> > The second mlock() seems to cause the issue. The final mbind() triggers=
 page
> > migration.
> >=20
> > Removing one of the mlock() makes it work. Note that we do a double
> > mlock() of the same page -- the one we are then trying to migrate.
> >=20
> > Somehow, the double mlock() of the same page seems to affect our mapcou=
nt.
> >=20
> > CCing Hugh.
>=20
> Thanks David - most especially for the reproducer, not tried here yet.
> I'll assume this is my bug, and get into it later in the day.
>=20
> Hugh
---1463760895-1811275884-1674974979=:23545--
