Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B101678DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjAXByL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAXByK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:54:10 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A922E0D2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:54:08 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4P194W3sy1z9sQp;
        Tue, 24 Jan 2023 02:54:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1674525243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rVIgJYVPSYQ3RyxovYmTZcLZFRE4ILOTG+ukaeyT/OE=;
        b=v2NosoLhO0ouyMVU47aifqqQSv9JlZ0hcpDoTgw1Bj7Xr5lZP7WiXjDeBllZm3fuyOyOS1
        xRZxPevXgjevHxB8QH9gSiJt4UnyBISpI64dewaRyHre4IUi/xlyIz8xYPCoDABifjPyap
        iiIvHBSar1pXwlIqZSSvEU8gIOoAZX+xHWZg49kA/o8mCfSmCQpkGOZoYJxKRkiYXbfu16
        k0iFj4r0ytqzv2ectYt3OWNInHr3vzgtv7qAFUkhc4qbWOU3Rw8KXRz6D7PgN24BNpymS6
        d4cyN77pQiV/z6tnQ3zqNpX71HNkwAvL4PdT4iEya6w6Se6A9t6NT2LLyTXtWg==
Date:   Tue, 24 Jan 2023 12:53:48 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        bristot@redhat.com, ebiederm@xmission.com, brauner@kernel.org,
        viro@zeniv.linux.org.uk, alexl@redhat.com, peterz@infradead.org,
        bmasney@redhat.com
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
Message-ID: <20230124015348.6rvic5g6ymsfvj4e@senku>
References: <20230120102512.3195094-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rquzuqopfattriri"
Content-Disposition: inline
In-Reply-To: <20230120102512.3195094-1-gscrivan@redhat.com>
X-Rspamd-Queue-Id: 4P194W3sy1z9sQp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rquzuqopfattriri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-01-20, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> This patch adds a new prctl called PR_HIDE_SELF_EXE which allows
> processes to hide their own /proc/*/exe file. When this prctl is
> used, every access to /proc/*/exe for the calling process will
> fail with ENOENT.
>=20
> This is useful for preventing issues like CVE-2019-5736, where an
> attacker can gain host root access by overwriting the binary
> in OCI runtimes through file-descriptor mishandling in containers.
>=20
> The current fix for CVE-2019-5736 is to create a read-only copy or
> a bind-mount of the current executable, and then re-exec the current
> process.  With the new prctl, the read-only copy or bind-mount copy is
> not needed anymore.
>=20
> While map_files/ also might contain symlinks to files in host,
> proc_map_files_get_link() permissions checks are already sufficient.

I suspect this doesn't protect against the execve("/proc/self/exe")
tactic (because it clears the bit on execve), so I'm not sure this is
much safer than PR_SET_DUMPABLE (yeah, it stops root in the source
userns from accessing /proc/$pid/exe but the above attack makes that no
longer that important).

I think the only way to fix this properly is by blocking re-opens of
magic links that have more permissions than they originally did. I just
got back from vacation, but I'm working on fixing up [1] so it's ready
to be an RFC so we can close this hole once and for all.

[1]: https://github.com/cyphar/linux/tree/magiclink/open_how-reopen

>=20
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
> v2: https://lkml.org/lkml/2023/1/19/849
>=20
> Differences from v2:
>=20
> - fixed the test to check PR_SET_HIDE_SELF_EXE after fork
>=20
> v1: https://lkml.org/lkml/2023/1/4/334
>=20
> Differences from v1:
>=20
> - amended more information in the commit message wrt map_files not
>   requiring the same protection.
> - changed the test to verify PR_HIDE_SELF_EXE cannot be unset after
>   a fork.
>=20
> fs/exec.c                        | 1 +
>  fs/proc/base.c                   | 8 +++++---
>  include/linux/sched.h            | 5 +++++
>  include/uapi/linux/prctl.h       | 3 +++
>  kernel/sys.c                     | 9 +++++++++
>  tools/include/uapi/linux/prctl.h | 3 +++
>  6 files changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/exec.c b/fs/exec.c
> index ab913243a367..5a5dd964c3a3 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1855,6 +1855,7 @@ static int bprm_execve(struct linux_binprm *bprm,
>  	/* execve succeeded */
>  	current->fs->in_exec =3D 0;
>  	current->in_execve =3D 0;
> +	task_clear_hide_self_exe(current);
>  	rseq_execve(current);
>  	acct_update_integrals(current);
>  	task_numa_free(current, false);
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 9e479d7d202b..959968e2da0d 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1723,19 +1723,21 @@ static int proc_exe_link(struct dentry *dentry, s=
truct path *exe_path)
>  {
>  	struct task_struct *task;
>  	struct file *exe_file;
> +	long hide_self_exe;
> =20
>  	task =3D get_proc_task(d_inode(dentry));
>  	if (!task)
>  		return -ENOENT;
>  	exe_file =3D get_task_exe_file(task);
> +	hide_self_exe =3D task_hide_self_exe(task);
>  	put_task_struct(task);
> -	if (exe_file) {
> +	if (exe_file && !hide_self_exe) {
>  		*exe_path =3D exe_file->f_path;
>  		path_get(&exe_file->f_path);
>  		fput(exe_file);
>  		return 0;
> -	} else
> -		return -ENOENT;
> +	}
> +	return -ENOENT;
>  }
> =20
>  static const char *proc_pid_get_link(struct dentry *dentry,
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 853d08f7562b..8db32d5fc285 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1790,6 +1790,7 @@ static __always_inline bool is_percpu_thread(void)
>  #define PFA_SPEC_IB_DISABLE		5	/* Indirect branch speculation restricted=
 */
>  #define PFA_SPEC_IB_FORCE_DISABLE	6	/* Indirect branch speculation perma=
nently restricted */
>  #define PFA_SPEC_SSB_NOEXEC		7	/* Speculative Store Bypass clear on exec=
ve() */
> +#define PFA_HIDE_SELF_EXE		8	/* Hide /proc/self/exe for the process */
> =20
>  #define TASK_PFA_TEST(name, func)					\
>  	static inline bool task_##func(struct task_struct *p)		\
> @@ -1832,6 +1833,10 @@ TASK_PFA_CLEAR(SPEC_IB_DISABLE, spec_ib_disable)
>  TASK_PFA_TEST(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
>  TASK_PFA_SET(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
> =20
> +TASK_PFA_TEST(HIDE_SELF_EXE, hide_self_exe)
> +TASK_PFA_SET(HIDE_SELF_EXE, hide_self_exe)
> +TASK_PFA_CLEAR(HIDE_SELF_EXE, hide_self_exe)
> +
>  static inline void
>  current_restore_flags(unsigned long orig_flags, unsigned long flags)
>  {
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index a5e06dcbba13..f12f3df12468 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -284,4 +284,7 @@ struct prctl_mm_map {
>  #define PR_SET_VMA		0x53564d41
>  # define PR_SET_VMA_ANON_NAME		0
> =20
> +#define PR_SET_HIDE_SELF_EXE		65
> +#define PR_GET_HIDE_SELF_EXE		66
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 5fd54bf0e886..e992f1b72973 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2626,6 +2626,15 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long,=
 arg2, unsigned long, arg3,
>  	case PR_SET_VMA:
>  		error =3D prctl_set_vma(arg2, arg3, arg4, arg5);
>  		break;
> +	case PR_SET_HIDE_SELF_EXE:
> +		if (arg2 !=3D 1 || arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		task_set_hide_self_exe(current);
> +		break;
> +	case PR_GET_HIDE_SELF_EXE:
> +		if (arg2 || arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		return task_hide_self_exe(current) ? 1 : 0;
>  	default:
>  		error =3D -EINVAL;
>  		break;
> diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/=
prctl.h
> index a5e06dcbba13..f12f3df12468 100644
> --- a/tools/include/uapi/linux/prctl.h
> +++ b/tools/include/uapi/linux/prctl.h
> @@ -284,4 +284,7 @@ struct prctl_mm_map {
>  #define PR_SET_VMA		0x53564d41
>  # define PR_SET_VMA_ANON_NAME		0
> =20
> +#define PR_SET_HIDE_SELF_EXE		65
> +#define PR_GET_HIDE_SELF_EXE		66
> +
>  #endif /* _LINUX_PRCTL_H */
> --=20
> 2.38.1
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--rquzuqopfattriri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCY886JwAKCRAol/rSt+lE
b3MQAQDDveVi4o0vXJ6qHHQzcQjazllKcApyz000lVJS9VzVfAD+ORMU6lqNCCS+
rUoOX5ixae5c85HTgS/qR6f0Qla9tQQ=
=BDyX
-----END PGP SIGNATURE-----

--rquzuqopfattriri--
