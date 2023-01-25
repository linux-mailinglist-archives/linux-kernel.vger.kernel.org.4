Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBB567B5E6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbjAYP3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbjAYP3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:29:11 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93462A153
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:29:07 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4P276R6xm3z9sfB;
        Wed, 25 Jan 2023 16:29:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1674660544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FSpsuw9ZKlsZRe/5r8W2yIVmPRCeLqpMDGJ2iz5tBcw=;
        b=iA7zycHP20H5sCL9K1k1uVC7ZvhzcGWsDiFplEoLCiyMA1Rxthx1PjmfYVX53DPLsl/Aap
        rWxMp4u1ZknN+OP6L5N4r3RpbxfC3RTcHbE+AJVwvllnKJI40RH8x4eEl9L36yytmBrH3X
        WkYkYRMGHf4zxex5echDzcRQKRYQxLajo5OvOE1Eu8h1o5eb5HeWCFu79w38GtPDp1A/5B
        4IszrjFmSGoVQqIksGTYsGTFLGTxGOTutYubx+IwOeJuj2nx7If7zIXIpuYRrLVcfi6gN1
        y4T1e+JJhN1TcDmXSa/4Vo55bT9dM2TwMkaGwok5brFhreSnjMuT73Ht/2PFKg==
Date:   Thu, 26 Jan 2023 02:28:47 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        bristot@redhat.com, ebiederm@xmission.com, brauner@kernel.org,
        viro@zeniv.linux.org.uk, alexl@redhat.com, peterz@infradead.org,
        bmasney@redhat.com
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
Message-ID: <20230125152847.wr443tggzb3no6mg@senku>
References: <20230120102512.3195094-1-gscrivan@redhat.com>
 <20230124015348.6rvic5g6ymsfvj4e@senku>
 <87h6wgcrv6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="slpyn7hv7j45vt4h"
Content-Disposition: inline
In-Reply-To: <87h6wgcrv6.fsf@redhat.com>
X-Rspamd-Queue-Id: 4P276R6xm3z9sfB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--slpyn7hv7j45vt4h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-01-24, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> Aleksa Sarai <cyphar@cyphar.com> writes:
>=20
> > On 2023-01-20, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> >> This patch adds a new prctl called PR_HIDE_SELF_EXE which allows
> >> processes to hide their own /proc/*/exe file. When this prctl is
> >> used, every access to /proc/*/exe for the calling process will
> >> fail with ENOENT.
> >>=20
> >> This is useful for preventing issues like CVE-2019-5736, where an
> >> attacker can gain host root access by overwriting the binary
> >> in OCI runtimes through file-descriptor mishandling in containers.
> >>=20
> >> The current fix for CVE-2019-5736 is to create a read-only copy or
> >> a bind-mount of the current executable, and then re-exec the current
> >> process.  With the new prctl, the read-only copy or bind-mount copy is
> >> not needed anymore.
> >>=20
> >> While map_files/ also might contain symlinks to files in host,
> >> proc_map_files_get_link() permissions checks are already sufficient.
> >
> > I suspect this doesn't protect against the execve("/proc/self/exe")
> > tactic (because it clears the bit on execve), so I'm not sure this is
> > much safer than PR_SET_DUMPABLE (yeah, it stops root in the source
> > userns from accessing /proc/$pid/exe but the above attack makes that no
> > longer that important).
>=20
> it protects against that attack too.  It clears the bit _after_ the
> execve() syscall is done.
>=20
> If you attempt execve("/proc/self/exe") you still get ENOENT:
>=20
> ```
> #include <stdlib.h>
> #include <stdio.h>
> #include <sys/prctl.h>
> #include <unistd.h>
>=20
> int main(void)
> {
>         int ret;
>=20
>         ret =3D prctl(65, 1, 0, 0, 0);
>         if (ret !=3D 0)
>                 exit(1);
>=20
>         execl("/proc/self/exe", "foo", NULL);
>         exit(2);
> }
> ```
>=20
> # strace -e prctl,execve ./hide-self-exe
> execve("./hide-self-exe", ["./hide-self-exe"], 0x7fff975a3690 /* 39 vars =
*/) =3D 0
> prctl(0x41 /* PR_??? */, 0x1, 0, 0, 0)  =3D 0
> execve("/proc/self/exe", ["foo"], 0x7ffcf51868b8 /* 39 vars */) =3D -1 EN=
OENT (No such file or directory)
> +++ exited with 2 +++
>=20
> I've also tried execv'ing with a script that uses "#!/proc/self/exe" and
> I get the same ENOENT.

Ah, you're right. As you mentioned, you could still do the attack
through /proc/self/map_files but that would require you to know where
the binary will be located (and being non-dumpable blocks container
processes from doing tricks to get the right path).

I wonder if we should somehow require (or auto-apply) SUID_DUMP_NONE
when setting this prctl, since it does currently depend on it to be
properly secure...

> > I think the only way to fix this properly is by blocking re-opens of
> > magic links that have more permissions than they originally did. I just
> > got back from vacation, but I'm working on fixing up [1] so it's ready
> > to be an RFC so we can close this hole once and for all.
>=20
> so that relies on the fact opening /proc/self/exe with O_WRONLY fails
> with ETXTBSY?

Not quite, it relies on the fact that /proc/self/exe (and any other
magiclink to /proc/self/exe) does not have a write mode (semantically,
because of -ETXTBSY) and thus blocks any attempt to open it (or re-open
it) with a write mode. It also fixes some other possible issues and lets
you have upgrade masks (a-la capabilities) to file descriptors.

Ultimately I think having a complete "no really, nobody can touch this"
knob is also a good idea, and as this is is much simpler we can it in
much quicker than the magiclink stuff (which I still think is necessary
in general).

> > [1]: https://github.com/cyphar/linux/tree/magiclink/open_how-reopen
> >
> >>=20
> >> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> >> ---
> >> v2: https://lkml.org/lkml/2023/1/19/849
> >>=20
> >> Differences from v2:
> >>=20
> >> - fixed the test to check PR_SET_HIDE_SELF_EXE after fork
> >>=20
> >> v1: https://lkml.org/lkml/2023/1/4/334
> >>=20
> >> Differences from v1:
> >>=20
> >> - amended more information in the commit message wrt map_files not
> >>   requiring the same protection.
> >> - changed the test to verify PR_HIDE_SELF_EXE cannot be unset after
> >>   a fork.
> >>=20
> >> fs/exec.c                        | 1 +
> >>  fs/proc/base.c                   | 8 +++++---
> >>  include/linux/sched.h            | 5 +++++
> >>  include/uapi/linux/prctl.h       | 3 +++
> >>  kernel/sys.c                     | 9 +++++++++
> >>  tools/include/uapi/linux/prctl.h | 3 +++
> >>  6 files changed, 26 insertions(+), 3 deletions(-)
> >>=20
> >> diff --git a/fs/exec.c b/fs/exec.c
> >> index ab913243a367..5a5dd964c3a3 100644
> >> --- a/fs/exec.c
> >> +++ b/fs/exec.c
> >> @@ -1855,6 +1855,7 @@ static int bprm_execve(struct linux_binprm *bprm,
> >>  	/* execve succeeded */
> >>  	current->fs->in_exec =3D 0;
> >>  	current->in_execve =3D 0;
> >> +	task_clear_hide_self_exe(current);
> >>  	rseq_execve(current);
> >>  	acct_update_integrals(current);
> >>  	task_numa_free(current, false);
> >> diff --git a/fs/proc/base.c b/fs/proc/base.c
> >> index 9e479d7d202b..959968e2da0d 100644
> >> --- a/fs/proc/base.c
> >> +++ b/fs/proc/base.c
> >> @@ -1723,19 +1723,21 @@ static int proc_exe_link(struct dentry *dentry=
, struct path *exe_path)
> >>  {
> >>  	struct task_struct *task;
> >>  	struct file *exe_file;
> >> +	long hide_self_exe;
> >> =20
> >>  	task =3D get_proc_task(d_inode(dentry));
> >>  	if (!task)
> >>  		return -ENOENT;
> >>  	exe_file =3D get_task_exe_file(task);
> >> +	hide_self_exe =3D task_hide_self_exe(task);
> >>  	put_task_struct(task);
> >> -	if (exe_file) {
> >> +	if (exe_file && !hide_self_exe) {
> >>  		*exe_path =3D exe_file->f_path;
> >>  		path_get(&exe_file->f_path);
> >>  		fput(exe_file);
> >>  		return 0;
> >> -	} else
> >> -		return -ENOENT;
> >> +	}
> >> +	return -ENOENT;
> >>  }
> >> =20
> >>  static const char *proc_pid_get_link(struct dentry *dentry,
> >> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >> index 853d08f7562b..8db32d5fc285 100644
> >> --- a/include/linux/sched.h
> >> +++ b/include/linux/sched.h
> >> @@ -1790,6 +1790,7 @@ static __always_inline bool is_percpu_thread(voi=
d)
> >>  #define PFA_SPEC_IB_DISABLE		5	/* Indirect branch speculation restric=
ted */
> >>  #define PFA_SPEC_IB_FORCE_DISABLE	6	/* Indirect branch speculation pe=
rmanently restricted */
> >>  #define PFA_SPEC_SSB_NOEXEC		7	/* Speculative Store Bypass clear on e=
xecve() */
> >> +#define PFA_HIDE_SELF_EXE		8	/* Hide /proc/self/exe for the process */
> >> =20
> >>  #define TASK_PFA_TEST(name, func)					\
> >>  	static inline bool task_##func(struct task_struct *p)		\
> >> @@ -1832,6 +1833,10 @@ TASK_PFA_CLEAR(SPEC_IB_DISABLE, spec_ib_disable)
> >>  TASK_PFA_TEST(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
> >>  TASK_PFA_SET(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
> >> =20
> >> +TASK_PFA_TEST(HIDE_SELF_EXE, hide_self_exe)
> >> +TASK_PFA_SET(HIDE_SELF_EXE, hide_self_exe)
> >> +TASK_PFA_CLEAR(HIDE_SELF_EXE, hide_self_exe)
> >> +
> >>  static inline void
> >>  current_restore_flags(unsigned long orig_flags, unsigned long flags)
> >>  {
> >> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> >> index a5e06dcbba13..f12f3df12468 100644
> >> --- a/include/uapi/linux/prctl.h
> >> +++ b/include/uapi/linux/prctl.h
> >> @@ -284,4 +284,7 @@ struct prctl_mm_map {
> >>  #define PR_SET_VMA		0x53564d41
> >>  # define PR_SET_VMA_ANON_NAME		0
> >> =20
> >> +#define PR_SET_HIDE_SELF_EXE		65
> >> +#define PR_GET_HIDE_SELF_EXE		66
> >> +
> >>  #endif /* _LINUX_PRCTL_H */
> >> diff --git a/kernel/sys.c b/kernel/sys.c
> >> index 5fd54bf0e886..e992f1b72973 100644
> >> --- a/kernel/sys.c
> >> +++ b/kernel/sys.c
> >> @@ -2626,6 +2626,15 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned lo=
ng, arg2, unsigned long, arg3,
> >>  	case PR_SET_VMA:
> >>  		error =3D prctl_set_vma(arg2, arg3, arg4, arg5);
> >>  		break;
> >> +	case PR_SET_HIDE_SELF_EXE:
> >> +		if (arg2 !=3D 1 || arg3 || arg4 || arg5)
> >> +			return -EINVAL;
> >> +		task_set_hide_self_exe(current);
> >> +		break;
> >> +	case PR_GET_HIDE_SELF_EXE:
> >> +		if (arg2 || arg3 || arg4 || arg5)
> >> +			return -EINVAL;
> >> +		return task_hide_self_exe(current) ? 1 : 0;
> >>  	default:
> >>  		error =3D -EINVAL;
> >>  		break;
> >> diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/lin=
ux/prctl.h
> >> index a5e06dcbba13..f12f3df12468 100644
> >> --- a/tools/include/uapi/linux/prctl.h
> >> +++ b/tools/include/uapi/linux/prctl.h
> >> @@ -284,4 +284,7 @@ struct prctl_mm_map {
> >>  #define PR_SET_VMA		0x53564d41
> >>  # define PR_SET_VMA_ANON_NAME		0
> >> =20
> >> +#define PR_SET_HIDE_SELF_EXE		65
> >> +#define PR_GET_HIDE_SELF_EXE		66
> >> +
> >>  #endif /* _LINUX_PRCTL_H */
> >> --=20
> >> 2.38.1
> >>=20
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--slpyn7hv7j45vt4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCY9FKrgAKCRAol/rSt+lE
b3llAP9XsHiYaV41LzHszh4L8nZhMytUX+3V+8u8N7BYz6ivBAEAygXFDsacBZqK
4fpuBsBHkJjkuYVA/uxm7pPiCj8pOQM=
=LN5h
-----END PGP SIGNATURE-----

--slpyn7hv7j45vt4h--
