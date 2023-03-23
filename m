Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB726C6CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjCWP7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjCWP66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:58:58 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AFDC641
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=kc9qNhC3gE7NKRhvm925TdOssXExtS9eEcMXrknzwck=; b=jrS3itjotS7JI2GnFTIdPfohrK
        X+khFANTTsAXdTFyqqXzPQBYmzvPn99ZotipiKZeSklR/6CyPQYHXkajyW+WgdF99efMiWLnuC8H4
        k/pABTuSRoRdV4LaH7IbShTCbnlUBDKFPTNCkdpw7HtVcrc4gnmmql7XZa+cS/5p5G4/egrDwkQ+A
        lShueyyTeD8Zu09tgX/Msl72iNC0MirRGLHGePyThw6qM4Y+VidtHPfPq8Jx5v52IQ2hXxTQxDNxp
        p+Cdsqw03uAch1ANnws+6pUetmTuuSE+vfa86djvcGjq00eEhZ2L+0uK7a0FYzqRqlqmiEQl0r/js
        8c8gQ6kWnrQZs3NJwWn8s/0eFs3VQao6+xmKyeFPKxOXQLvvi+IiYbXuhYawQ3bEaQqIkP3ygggYP
        AU2rbQm4eJdoUCbSIhWXa6k8/3rz10ZasRu6VXHGXIHMgQuVTF5bZPZ9QVMec3YdObqDcMcC5nKJ3
        daEIO1gLruFWxo0QmYwcQ/Uyyj2loKU/Z/5JfUc+jXm6V/UnJQWPXy1DwZFxk7zgIyxbCbUc/ICNi
        1cW/pPH9GxHgaeVVuY/e4p1VlC5pl/p3HXNMI8ya2/uu4yxTgDOCMc5KRbe9vKIINzumrV7TsSnAC
        57xYzpc7vFRqbfEScH8eIh2/MF3xWvvEkilTeSbRM=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, Pengfei Xu <pengfei.xu@intel.com>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH 0/5] Take 3 at async RPCs and no longer looping
 forever on signals
Date:   Thu, 23 Mar 2023 16:58:51 +0100
Message-ID: <19996551.RFHlWWcHjK@silver>
In-Reply-To: <ZBb3ynXntaom/0hg@codewreck.org>
References: <20230211075023.137253-1-asmadeus@codewreck.org>
 <Y+ttlog6sth3vPHJ@codewreck.org> <ZBb3ynXntaom/0hg@codewreck.org>
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

On Sunday, March 19, 2023 12:53:46 PM CET Dominique Martinet wrote:
> It's been a while but I didn't forget...
>=20
> Dominique Martinet wrote on Tue, Feb 14, 2023 at 08:16:38PM +0900:
> > > Yes, apparently it tries to write dirty pages of the mapped file and =
keeps
> > > hanging there [fs/9p/vfs_inode_dotl.c:586]:
> >=20
> > Yeah, it'd help to get the trace of the thread actually trying to do the
> > IO, if it still exists.
> > I had some hangs in the check that there are no flush in flight at some
> > point, and I thought I fixed that, but I can't really see anywhere else
> > that'd start hanging with this... it'll be clearer if I can reproduce.
>=20
> I couldn't reproduce this one, but manually inspecting
> p9_client_wait_flush again I noticed the wait_event_interruptible was
> waiting on req->flushed_req->wq but looking at req->status in the
> condition; that was an error.
> Also, we have a ref on req->flushed_req but not on req, so
> req->flushed_req wasn't safe.
>=20
> I've changed the code to add a variable directly on req->flushed_req and
> use it consistently, I'm not sure that's the problem you ran into but it
> might help.
> It's been a while but do you remember if that hang was consistently
> happening on shutdown, or was it a one time thing?
>=20
> Either way, I'd appreciate if you could try my 9p-test branch again:
> https://github.com/martinetd/linux/commits/9p-test
>=20
>=20
> With that said, I expect that p9_client_wait_req will cause hangs on
> broken servers.
> If connection drops hopefully the reqs will just be marked as error and
> free the thread, but I can see syzbot complaining about yet another
> thread stuck.. Well it's interruptible at least, and bails out on
> ERESTARTSYS.

I gave your current test branch some spins today.

And yes, the problem did not happen reliably each time, but consistently
enough for me to reproduce it.

With your latest test branch it appears to have mitigated the problem. Once=
 in
a while on shutdown I see it blocking for few minutes, but recovering:

[**    ] (2 of 3) A stop job is running for =E2=80=A6ave Random Seed (2min =
36s / 10min)
[  484.986388] INFO: task systemd-user-ru:8782 blocked for more than 120 se=
conds.
[  484.990150]       Tainted: G            E      6.3.0-rc2+ #63
[  484.992553] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[  484.993657] task:systemd-user-ru state:D stack:0     pid:8782  ppid:1   =
   flags:0x00000004
[  484.994863] Call Trace:
[  484.995398]  <TASK>
[  484.995866] __schedule (kernel/sched/core.c:5304 kernel/sched/core.c:662=
2)=20
[  484.996614] schedule (kernel/sched/core.c:6699 (discriminator 1))=20
[  484.997283] d_alloc_parallel (./include/linux/spinlock.h:350 fs/dcache.c=
:2626 fs/dcache.c:2707)=20
[  484.998150] ? __pfx_default_wake_function (kernel/sched/core.c:6944)=20
[  484.999213] __lookup_slow (fs/namei.c:1671)=20
[  485.000006] walk_component (./include/linux/fs.h:773 fs/namei.c:1704 fs/=
namei.c:1994)=20
[  485.000805] path_lookupat (fs/namei.c:2451 fs/namei.c:2475)=20
[  485.001594] filename_lookup (fs/namei.c:2504)=20
[  485.002452] ? __check_object_size (mm/usercopy.c:196 mm/usercopy.c:251 m=
m/usercopy.c:213)=20
[  485.003523] ? strncpy_from_user (./include/asm-generic/access_ok.h:40 ./=
arch/x86/include/asm/uaccess.h:551 lib/strncpy_from_user.c:138)=20
[  485.004537] user_path_at_empty (fs/namei.c:2879)=20
[  485.005508] do_faccessat (fs/open.c:484)=20
[  485.006410] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/com=
mon.c:80)=20
[  485.007281] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:12=
0)=20
[  485.008495] RIP: 0033:0x7f7b4527d8f7
[  485.009380] RSP: 002b:00007ffc9ee73c08 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000015
[  485.011118] RAX: ffffffffffffffda RBX: 00007f7b44ee2608 RCX: 00007f7b452=
7d8f7
[  485.012831] RDX: 000000000000001c RSI: 0000000000000000 RDI: 00007f7b44e=
da86b
[  485.014560] RBP: 0000000000000003 R08: 0000000000000000 R09: 00007f7b453=
60be0
[  485.016246] R10: 00005571ade756c0 R11: 0000000000000246 R12: 00007ffc9ee=
73cf8
[  485.017937] R13: 00007ffc9ee73d18 R14: 00007f7b44ee2610 R15: 00000000000=
00000
[  485.019669]  </TASK>

However that happens now before unmount rule is reached on shutdown?
Previously it was hanging after the shutdown rule was reached. Does this ma=
ke
sense?

> > Anyway, I found another bug, just running ./configure on a random proje=
ct
> > (picked coreutils tarball) fails with interrupted system call ?!
>=20
> That other bug was weird, I could reproduce it reliably until I rebooted
> the host because of an unrelated nfs bug on the host, and after reboot I
> couldn't reproduce anymore.
> I'll chalk it down to buggy host/weird happenstance, but something to
> watch for if random EINTR happen again :/



