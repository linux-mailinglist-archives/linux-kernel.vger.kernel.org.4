Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66DC67EBDE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbjA0RCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjA0RCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:02:12 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A1259C5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:02:10 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id d16-20020a4a5210000000b004f23d1aea58so676302oob.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4TlDtVFpYFpxEFCsfHrOa8jm9QVhigpm3WfIEVpmBFY=;
        b=ZKoWX5BHY1bXfJD6kdGl73qaUQ++BSNTbGBdldD34BtH+OLR1yJm9jPfS8mcNp9lTn
         b57MdWN0BrnQt/0LnYqsTQrFNFB628A0eRE6lqR0cNb+ICviaPHty7m1RtYiauol51+X
         vFDqc8/FCQCphG8FPMBFixdzxZ3NRRB+abLtrnPRrsJTrjURUmqyPi4Ohq6lPqxG3CaU
         Ctn/hhTL3fPWtkoGmTJLSsieWsXUUHoVc+kZrZ9Wcq0AKt4sf8n8nqmCYPOmewCUbuxC
         IVS89jDZicK1u45tNSCON6W/5DLpjVwHdAUQcZsfXGA3TZx9aHu0wsSXesR4kYMmlBBB
         sIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4TlDtVFpYFpxEFCsfHrOa8jm9QVhigpm3WfIEVpmBFY=;
        b=V51CiP+HMphQbrPh/t80zbcWVoD7lvTX5t5QnXWkCm/Rjq2WZvFheUfEjL/gnyGGzj
         9pvOdBaPQOI5YeUn5p0E3aUwQAkHGUEeRTwIlZFmITH+pOFZpyzQDAmdkFyX/aV5mdeQ
         gcj6Girhi11Ih8zO+9k6ArYPHimWychanapGnRuZQPCLO3/Z7/uywDdgdYD6rPkFkbf2
         zFTGq+q2g+Z3HrhkK+y2jq5+X/5EVL1FTZO5hYPMeFGCcq4IoLMbTgK1eyTAchnd1vrz
         czNzL9Yhd+gYiXxcd+Qjy4+cHbH6c4i0JHVm12i9yrHB79TnJSVNbyiV8m76TX9ko72W
         mO4Q==
X-Gm-Message-State: AFqh2kqnCiglSUyN0SW2PyRasJ8Uyhd9CK/gulCGkicbn26s3Fg2fiDR
        RWFrVO+jVu9S98v4p/6hRj7ZyQ==
X-Google-Smtp-Source: AMrXdXtQXI0GhVIDb+uEEjqEDgruY6w0uBngDWKMdq5CL8owUXbUDSOUibOOkEt7HEuzYUAMjPT9/Q==
X-Received: by 2002:a4a:b5cb:0:b0:4a3:c9f5:c1ab with SMTP id u11-20020a4ab5cb000000b004a3c9f5c1abmr16568129ooo.6.1674838928928;
        Fri, 27 Jan 2023 09:02:08 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b48-20020a4a98f3000000b00499527def25sm1825707ooj.47.2023.01.27.09.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:02:08 -0800 (PST)
Date:   Fri, 27 Jan 2023 09:02:04 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     David Hildenbrand <david@redhat.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: kernel BUG in page_add_anon_rmap
In-Reply-To: <adc9152e-c547-12ec-3538-006500619896@redhat.com>
Message-ID: <713c6242-be65-c212-b790-2b908627c1b4@google.com>
References: <IA1PR07MB983017D2FBA174D2FF78CEB6ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com> <Y9LNCouUvsUFCYkT@casper.infradead.org> <adc9152e-c547-12ec-3538-006500619896@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2120464753-1674838934=:9139"
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

--8323328-2120464753-1674838934=:9139
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 27 Jan 2023, David Hildenbrand wrote:
> On 26.01.23 19:57, Matthew Wilcox wrote:
> > On Wed, Jan 25, 2023 at 11:59:16PM +0000, Sanan Hasanov wrote:
> >> Good day, dear maintainers,
> >>
> >> We found a bug using a modified kernel configuration file used by syzb=
ot.
> >>
> >> We enhanced the coverage of the configuration file using our tool,
> >> klocalizer.
> >>
> >> Kernel Branch:=C2=A06.2.0-rc5-next-20230124
> >> Kernel
> >> config:=C2=A0https://drive.google.com/file/d/1MZSgIF4R9QfikEuF5siUIZVP=
ce-GiJQK/view?usp=3Dsharing
> >> Reproducer:=C2=A0https://drive.google.com/file/d/1H5KWkT9VVMWTUVVgIaZi=
6J-fmukRx-BM/view?usp=3Dsharing
> >>
> >> Thank you!
> >>
> >> Best regards,
> >> Sanan Hasanov
> >>
> >> head: 0000000000020000 0000000000000000 00000004ffffffff ffff8881002b8=
000
> >> page dumped because: VM_BUG_ON_PAGE(!first && (flags & (( rmap_t)((((1=
UL)))
> >> << (0)))))
> >> ------------[ cut here ]------------
> >=20
> > I know it says "cut here" and you did that, but including just a few
> > lines above that would be so much more helpful.  I can infer that this
> > is a multi-page folio, but more than that is hard to tell.
> >=20
> >> kernel BUG at mm/rmap.c:1248!
> >=20
> > That tracks with VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), pag=
e);
> >=20
> >> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> >> CPU: 7 PID: 14932 Comm: syz-executor.1 Not tainted 6.2.0-rc5-next-2023=
0124
> >> #1
> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
> >> 04/01/2014
> >> RIP: 0010:page_add_anon_rmap+0xddd/0x11c0 mm/rmap.c:1248
> >> Code: c0 ff 48 8b 34 24 48 89 df e8 1f ff 07 00 49 89 c6 e9 85 f6 ff f=
f e8
> >> 52 73 c0 ff 48 c7 c6 c0 3c d8 89 48 89 ef e8 b3 23 f8 ff <0f> 0b e8 3c=
 73
> >> c0 ff 48 c7 c6 00 3b d8 89 48 89 ef e8 9d 23 f8 ff
> >> RSP: 0018:ffffc9000c56f7b0 EFLAGS: 00010293
> >> RAX: 0000000000000000 RBX: ffff88807efc6f30 RCX: 0000000000000000
> >> RDX: ffff8880464fd7c0 RSI: ffffffff81be733d RDI: fffff520018adedb
> >> RBP: ffffea0000c68080 R08: 0000000000000056 R09: 0000000000000000
> >> R10: 0000000000000001 R11: 0000000000000001 R12: ffffea0000c68000
> >> R13: 0000000000000001 R14: ffffea0000c68088 R15: 0000000000000000
> >> FS:  00007f717898a700(0000) GS:ffff888119f80000(0000)
> >> knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007f7178947d78 CR3: 000000004a9e6000 CR4: 0000000000350ee0
> >> Call Trace:
> >>   <TASK>
> >>   remove_migration_pte+0xaa6/0x1390 mm/migrate.c:261
> >=20
> >                          if (folio_test_anon(folio))
> >                                  page_add_anon_rmap(new, vma, pvmw.addr=
ess,
> >                                                     rmap_flags);
> >=20
> > Earlier in that function, we had:
> >                  if (folio_test_anon(folio) &&
> >                  !is_readable_migration_entry(entry))
> >                          rmap_flags |=3D RMAP_EXCLUSIVE;
> >=20
> > so that also makes sense.  We can also infer that RMAP_COMPOUND wasn't
> > set, so we're trying to do just one page from the folio.
> >=20
> > All right, back to rmap.c:
> >=20
> >                  first =3D atomic_inc_and_test(&page->_mapcount);
> >=20
> > So first is clearly false (ie _mapcount was not -1), implying somebody
> > else already mapped this page.  Not really sure what's going on at
> > this point.  Seems unlikely that the folio changes in
> > remove_migration_pte() are responsible since they're from last January.
> > Huang has some more changes to migrate.c that I don't feel qualified
> > to judge.
> >=20
> > Nothing's jumping out at me as obviously wrong.  Is it possible to
> > do a bisect?
>=20
> I reproduced on next-20230127 (did not try upstream yet).
>=20
> I think two key things are that a) THP are set to "always" and b) we have=
 a
> NUMA setup [I assume].
>=20
> The relevant bits:
>=20
> [  439.886738] page:00000000c4de9000 refcount:513 mapcount:2
> mapping:0000000000000000 index:0x20003 pfn:0x14ee03
> [  439.893758] head:000000003d5b75a4 order:9 entire_mapcount:0
> nr_pages_mapped:511 pincount:0
> [  439.899611] memcg:ffff986dc4689000
> [  439.902207] anon flags:
> 0x17ffffc009003f(locked|referenced|uptodate|dirty|lru|active|head|swapbac=
ked|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
> [  439.910737] raw: 0017ffffc0020000 ffffe952c53b8001 ffffe952c53b80c8
> dead000000000400
> [  439.916268] raw: 0000000000000000 0000000000000000 0000000000000001
> 0000000000000000
> [  439.921773] head: 0017ffffc009003f ffffe952c538b108 ffff986de35a0010
> ffff98714338a001
> [  439.927360] head: 0000000000020000 0000000000000000 00000201ffffffff
> ffff986dc4689000
> [  439.932341] page dumped because: VM_BUG_ON_PAGE(!first && (flags & ((
> rmap_t)((((1UL))) << (0)))))
>=20
>=20
> Indeed, the mapcount of the subpage is 2 instead of 1. The subpage is onl=
y
> mapped into a single
> page table (no fork() or similar).
>=20
> I created this reduced reproducer that triggers 100%:
>=20
>=20
> #include <stdint.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include <numaif.h>
>=20
> int main(void)
> {
> =09mmap((void*)0x20000000ul, 0x1000000ul, PROT_READ|PROT_WRITE|PROT_EXEC,
> =09     MAP_ANONYMOUS|MAP_FIXED|MAP_PRIVATE, -1, 0ul);
> =09madvise((void*)0x20000000ul, 0x1000000ul, MADV_HUGEPAGE);
>=20
> =09*(uint32_t*)0x20000080 =3D 0x80000;
> =09mlock((void*)0x20001000ul, 0x2000ul);
> =09mlock((void*)0x20000000ul, 0x3000ul);
> =09mbind((void*)0x20002000ul, 0x1000ul, MPOL_LOCAL, NULL, 0x7fful,
> =09MPOL_MF_MOVE);
> =09return 0;
> }
>=20
> We map a large-enough are for a THP and then populate a fresh anon THP (P=
MD
> mapped)
> to write to it.
>=20
> The first mlock() will trigger PTE-mapping the THP and mlocking that subp=
age.
> The second mlock() seems to cause the issue. The final mbind() triggers p=
age
> migration.
>=20
> Removing one of the mlock() makes it work. Note that we do a double
> mlock() of the same page -- the one we are then trying to migrate.
>=20
> Somehow, the double mlock() of the same page seems to affect our mapcount=
=2E
>=20
> CCing Hugh.

Thanks David - most especially for the reproducer, not tried here yet.
I'll assume this is my bug, and get into it later in the day.

Hugh
--8323328-2120464753-1674838934=:9139--
