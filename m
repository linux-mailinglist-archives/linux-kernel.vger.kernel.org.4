Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C5C6C8E4B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCYMqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYMqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:46:02 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9639511666
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=9H50zYy1hTVQ5h4tO0fvvSvntHyuAx7uritFK+m1k5Q=; b=nxCq978VBEAt4KqTkFVJARZjO6
        bDUVLnPTQLBFb7k2Bi9NeC6Gw1ivYubqin+gzQxZ8DQKqU4c6M727F6FInpuLg7i4/+1FTLGv4293
        dAx8CbCk/J+qmBZUyV1jUV2oJsMtycOYGRQw8aON0O7IunRTe9RxSDb/tq9Xa56BkTsfcNx9s2j2t
        h7Vgu3WKkGXtNWVgXnCWgMY9psggvjTy125Z+QmsxSQuZ9oWxNaDQmBrRsh9uwAiFZbhbLI4giYyP
        gR/SRTX1ElWkdzfSXON5gL8EeMI5UA/CDDGLq1zNCnrIe9DCyIl/2G6A77EPMonk9MdPlciPDN3J9
        sTTbbumJKs1XC1HG4IhvQ1VyhAFXFBEpNZOsJfLpdm8QHtqHKFgRLJf8n0XTz1/nQfrY+PmjF9F/u
        8OVqBzcsL65TZpihnQaTHfXiS35jJMs6x8N398szLaMKN+G4Bwdxph12bIsp2LkTVEVuceaEO9Fb1
        Y86ujYBCIbiYJ2I52KtHRZy2Ep8EdlfLCqXOX2beGlPYhAFSfEnDYV7kTyBrGY+ECAgNdCUvJQrnl
        WL6uwBL0sfDtE6sEWAk+hH3y9JpgJqsFMoBZJ0rvF8cFKhwJ0xHLKjeMMoKSasjLRzjQWl2t77+li
        NOKLwTZYn50Ib7xRK+uVhLnZNwST9yshJF2g5vCfA=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, Pengfei Xu <pengfei.xu@intel.com>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH 0/5] Take 3 at async RPCs and no longer looping
 forever on signals
Date:   Sat, 25 Mar 2023 13:45:44 +0100
Message-ID: <1792249.25CL7UOqfo@silver>
In-Reply-To: <19996551.RFHlWWcHjK@silver>
References: <20230211075023.137253-1-asmadeus@codewreck.org>
 <ZBb3ynXntaom/0hg@codewreck.org> <19996551.RFHlWWcHjK@silver>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 23, 2023 4:58:51 PM CET Christian Schoenebeck wrote:
> On Sunday, March 19, 2023 12:53:46 PM CET Dominique Martinet wrote:
> > It's been a while but I didn't forget...
> >=20
> > Dominique Martinet wrote on Tue, Feb 14, 2023 at 08:16:38PM +0900:
> > > > Yes, apparently it tries to write dirty pages of the mapped file an=
d keeps
> > > > hanging there [fs/9p/vfs_inode_dotl.c:586]:
> > >=20
> > > Yeah, it'd help to get the trace of the thread actually trying to do =
the
> > > IO, if it still exists.
> > > I had some hangs in the check that there are no flush in flight at so=
me
> > > point, and I thought I fixed that, but I can't really see anywhere el=
se
> > > that'd start hanging with this... it'll be clearer if I can reproduce.
> >=20
> > I couldn't reproduce this one, but manually inspecting
> > p9_client_wait_flush again I noticed the wait_event_interruptible was
> > waiting on req->flushed_req->wq but looking at req->status in the
> > condition; that was an error.
> > Also, we have a ref on req->flushed_req but not on req, so
> > req->flushed_req wasn't safe.
> >=20
> > I've changed the code to add a variable directly on req->flushed_req and
> > use it consistently, I'm not sure that's the problem you ran into but it
> > might help.
> > It's been a while but do you remember if that hang was consistently
> > happening on shutdown, or was it a one time thing?
> >=20
> > Either way, I'd appreciate if you could try my 9p-test branch again:
> > https://github.com/martinetd/linux/commits/9p-test
> >=20
> >=20
> > With that said, I expect that p9_client_wait_req will cause hangs on
> > broken servers.
> > If connection drops hopefully the reqs will just be marked as error and
> > free the thread, but I can see syzbot complaining about yet another
> > thread stuck.. Well it's interruptible at least, and bails out on
> > ERESTARTSYS.
>=20
> I gave your current test branch some spins today.
>=20
> And yes, the problem did not happen reliably each time, but consistently
> enough for me to reproduce it.
>=20
> With your latest test branch it appears to have mitigated the problem. On=
ce in
> a while on shutdown I see it blocking for few minutes, but recovering:
>=20
> [**    ] (2 of 3) A stop job is running for =E2=80=A6ave Random Seed (2mi=
n 36s / 10min)
> [  484.986388] INFO: task systemd-user-ru:8782 blocked for more than 120 =
seconds.
> [  484.990150]       Tainted: G            E      6.3.0-rc2+ #63
> [  484.992553] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [  484.993657] task:systemd-user-ru state:D stack:0     pid:8782  ppid:1 =
     flags:0x00000004
> [  484.994863] Call Trace:
> [  484.995398]  <TASK>
> [  484.995866] __schedule (kernel/sched/core.c:5304 kernel/sched/core.c:6=
622)=20
> [  484.996614] schedule (kernel/sched/core.c:6699 (discriminator 1))=20
> [  484.997283] d_alloc_parallel (./include/linux/spinlock.h:350 fs/dcache=
=2Ec:2626 fs/dcache.c:2707)=20
> [  484.998150] ? __pfx_default_wake_function (kernel/sched/core.c:6944)=20
> [  484.999213] __lookup_slow (fs/namei.c:1671)=20
> [  485.000006] walk_component (./include/linux/fs.h:773 fs/namei.c:1704 f=
s/namei.c:1994)=20
> [  485.000805] path_lookupat (fs/namei.c:2451 fs/namei.c:2475)=20
> [  485.001594] filename_lookup (fs/namei.c:2504)=20
> [  485.002452] ? __check_object_size (mm/usercopy.c:196 mm/usercopy.c:251=
 mm/usercopy.c:213)=20
> [  485.003523] ? strncpy_from_user (./include/asm-generic/access_ok.h:40 =
=2E/arch/x86/include/asm/uaccess.h:551 lib/strncpy_from_user.c:138)=20
> [  485.004537] user_path_at_empty (fs/namei.c:2879)=20
> [  485.005508] do_faccessat (fs/open.c:484)=20
> [  485.006410] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/c=
ommon.c:80)=20
> [  485.007281] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:=
120)=20
> [  485.008495] RIP: 0033:0x7f7b4527d8f7
> [  485.009380] RSP: 002b:00007ffc9ee73c08 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000015
> [  485.011118] RAX: ffffffffffffffda RBX: 00007f7b44ee2608 RCX: 00007f7b4=
527d8f7
> [  485.012831] RDX: 000000000000001c RSI: 0000000000000000 RDI: 00007f7b4=
4eda86b
> [  485.014560] RBP: 0000000000000003 R08: 0000000000000000 R09: 00007f7b4=
5360be0
> [  485.016246] R10: 00005571ade756c0 R11: 0000000000000246 R12: 00007ffc9=
ee73cf8
> [  485.017937] R13: 00007ffc9ee73d18 R14: 00007f7b44ee2610 R15: 000000000=
0000000
> [  485.019669]  </TASK>
>=20
> However that happens now before unmount rule is reached on shutdown?
> Previously it was hanging after the shutdown rule was reached. Does this =
make
> sense?

Correction: I still get the previous issue on unmount with your latest vers=
ion
as well. :/

Call trace looks slightly different, but it seems to be the same issue:

[  OK  ] Reached target Unmount All Filesystems.
[*     ] A stop job is running for Load/Save Random Seed (3min 27s / 10min)
[  243.031668] INFO: task systemd-journal:199 blocked for more than 120 sec=
onds.
[  243.036460]       Tainted: G            E      6.3.0-rc2+ #63
[  243.037666] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[  243.039004] task:systemd-journal state:D stack:0     pid:199   ppid:1   =
   flags:0x00004004
[  243.040434] Call Trace:
[  243.040878]  <TASK>
[  243.041265] __schedule (kernel/sched/core.c:5304 kernel/sched/core.c:662=
2)=20
[  243.041887] ? __pagevec_release (./include/linux/pagevec.h:38 mm/swap.c:=
1063)=20
[  243.042594] schedule (kernel/sched/core.c:6699 (discriminator 1))=20
[  243.043150] io_schedule (kernel/sched/core.c:8859 kernel/sched/core.c:88=
85)=20
[  243.043751] folio_wait_bit_common (mm/filemap.c:1293)=20
[  243.044519] ? __pfx_wake_page_function (mm/filemap.c:1083)=20
[  243.045321] folio_wait_writeback (./arch/x86/include/asm/bitops.h:207 ./=
arch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented=
=2Dnon-atomic.h:142 ./include/linux/page-flags.h:518 mm/page-writeback.c:31=
25)=20
[  243.046043] __filemap_fdatawait_range (./arch/x86/include/asm/bitops.h:7=
5 (discriminator 3) ./include/asm-generic/bitops/instrumented-atomic.h:42 (=
discriminator 3) ./include/linux/page-flags.h:473 (discriminator 3) mm/file=
map.c:526 (discriminator 3))=20
[  243.046828] ? filemap_fdatawrite_wbc (mm/filemap.c:393)=20
[  243.047622] ? __filemap_fdatawrite_range (mm/filemap.c:424)=20
[  243.048531] filemap_write_and_wait_range (mm/filemap.c:689 mm/filemap.c:=
669)=20
[  243.049358] v9fs_vfs_setattr_dotl (./include/linux/pagemap.h:60 fs/9p/vf=
s_inode_dotl.c:587) 9p
[  243.050229] notify_change (fs/attr.c:486)=20
[  243.050924] ? __vfs_getxattr (fs/xattr.c:426)=20
[  243.051571] ? do_truncate (./include/linux/fs.h:763 fs/open.c:67)=20
[  243.052224] do_truncate (./include/linux/fs.h:763 fs/open.c:67)=20
[  243.052816] do_sys_ftruncate (fs/open.c:194)=20
[  243.053548] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/com=
mon.c:80)=20
[  243.054187] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:12=
0)=20
[  243.055057] RIP: 0033:0x7f6db123ab77
[  243.055706] RSP: 002b:00007ffc4dda0ca8 EFLAGS: 00000206 ORIG_RAX: 000000=
000000004d
[  243.056978] RAX: ffffffffffffffda RBX: 00007ffc4dda0cf0 RCX: 00007f6db12=
3ab77
[  243.058198] RDX: 000055715f9b2a00 RSI: 0000000001000000 RDI: 00000000000=
00018
[  243.059478] RBP: 000055715f9b2bf0 R08: 0000000000000001 R09: 000055715f9=
b2c74
[  243.060716] R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffc4dd=
a0ce8

I just realized I don't have to do anything fancy to reproduce this. I just
have to boot and shutdown guest few times to trigger it.



