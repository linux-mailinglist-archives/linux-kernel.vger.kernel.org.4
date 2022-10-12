Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC56B5FBFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 06:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJLEQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 00:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLEQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 00:16:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0953C1F9C8;
        Tue, 11 Oct 2022 21:16:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id b2so15128399plc.7;
        Tue, 11 Oct 2022 21:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJHfxSkAdEzE02kXCOugwTptSZXfoXHK5Lb1A5ICHqE=;
        b=Rrlze0pGp+8MKXLRlhhIebryFh3ieyIMcB2o/aN8bjOFElKnqhRCzRyHGrM5Ozy7As
         XhXjKxEggNG5Lq8X0WD11nEVuFKlpRcousRl0vhe9BDA1cQ3rvLIzKYMScw5Z4eWQDiV
         kkU2o8DvnldcSo7CAhpg17gqnMnuxSzNkSBjav+oezmEK2JTYHvS8CgGOe3YKMHbfvbN
         ZYWbRgD1IQojFQlnXpywJWIdifq69Fkn1ebFLY2WDVr30lmWm6GK06Wy7ukasO1ixAex
         rzBeX3Nx/p2r6SDE10qwD7taeC/QpSgCiEajfmS1rQVxcAnLQgman2U5iQSqlAoY8DvT
         Fndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJHfxSkAdEzE02kXCOugwTptSZXfoXHK5Lb1A5ICHqE=;
        b=7k98C08MGr5Hozit3GjEYLwBzd1sCwBH13COdPSj2cFbsOHrDV+AAZavvg7SiME1RD
         xz+IZHi5UPJN5kMbD0d5pvr2KwolNe4JEnsY5TDUQ52rIoBB4V53bStxcGcDGWQO02sB
         f2ozvtRF2LugB66Y47fEQ9msbU0jXb8GbTsBufgz4lj3C1EZm9GjOvlMGsWqlokJC+wq
         QOrwmL2mU9ZFN71h9y64khS0sXxVL0IdBH8yfoD1m7XY3WZshEE1LRoMYzaIk0/VAwAk
         9gdZCW/eroDjNo5hXGZSRFtkqPw13XW+f0r/qy0HQsEsDyczqbT6yC0W2p5xRLoNzOQ/
         +HIA==
X-Gm-Message-State: ACrzQf1ChdfZR/PjFKupCWAu+Qrb4OFARuFn9zbhIJXkzlS/KOgH46Ms
        L4PBi9qkkW2+WYpZq4GSOjg=
X-Google-Smtp-Source: AMsMyM7rH8I0S5TWLH2Y55oSGySHBD+eCj3dU5URWQ7rKYl8bkEET6BJVaqQnparD2Ld5bLDcnLWuQ==
X-Received: by 2002:a17:90a:bd91:b0:20d:2add:96a4 with SMTP id z17-20020a17090abd9100b0020d2add96a4mr2849825pjr.195.1665548197414;
        Tue, 11 Oct 2022 21:16:37 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-2.three.co.id. [180.214.232.2])
        by smtp.gmail.com with ESMTPSA id x12-20020aa78f0c000000b0052c849d0886sm9816734pfr.86.2022.10.11.21.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 21:16:36 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D02D41005BB; Wed, 12 Oct 2022 11:16:32 +0700 (WIB)
Date:   Wed, 12 Oct 2022 11:16:32 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     corbet@lwn.net, mhocko@suse.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        wuyun.abel@bytedance.com
Subject: Re: [RFC] mm: add new syscall pidfd_set_mempolicy()
Message-ID: <Y0Y/oGToVk3ags7h@debian.me>
References: <20221010094842.4123037-1-hezhongkun.hzk@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kr4kyCS+bdnKay0q"
Content-Disposition: inline
In-Reply-To: <20221010094842.4123037-1-hezhongkun.hzk@bytedance.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kr4kyCS+bdnKay0q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2022 at 05:48:42PM +0800, Zhongkun He wrote:
> There is usecase that System Management Software(SMS) want to give a
> memory policy to other processes to make better use of memory.
>=20

Better say "There are usecases when system management utilities
want to apply memory policy to processes to make better use of memory".

> The information about how to use memory is not known to the app.
> Instead, it is known to the userspace daemon(SMS), and that daemon
> will decide the memory usage policy based on different factors.
>=20

Better say "These utilities doesn't set memory usage policy, but
rather the job of reporting memory usage and setting the policy is
offloaded to an userspace daemon."

> To solve the issue, this patch introduces a new syscall
> pidfd_set_mempolicy(2).  it sets the NUMA memory policy of the thread
> specified in pidfd.
>=20

Better say "To solve the issue above, introduce new syscall
pidfd_set_mempolicy(2). The syscall sets NUMA memory policy for the
thread specified in pidfd".

> In current process context there is no locking because only the process
> accesses its own memory policy, so task_work is used in
> pidfd_set_mempolicy() to update the mempolicy of the process specified
> in pidfd, avoid using locks and race conditions.
>=20

Better say "In current process context there is no locking because
only processes access their own memory policy. For this reason, task_work
is used in pidfd_set_mempolicy() to set or update the mempolicy of process
specified in pid. Thuse, it avoids into race conditions."

> The API is as follows,
>=20
> 		long pidfd_set_mempolicy(int pidfd, int mode,
>                                      const unsigned long __user *nmask,
>                                      unsigned long maxnode,
>                                      unsigned int flags);
>=20
> Set's the [pidfd] task's "task/process memory policy". The pidfd argument
> is a PID file descriptor (see pidfd_open(2) man page) that specifies the
> process to which the mempolicy is to be applied. The flags argument is
> reserved for future use; currently, this argument must be specified as 0.
> Please see the set_mempolicy(2) man page for more details about
> other's arguments.
>=20

Why duplicating from the Documentation/ below?

> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> ---
>  .../admin-guide/mm/numa_memory_policy.rst     | 21 ++++-
>  arch/alpha/kernel/syscalls/syscall.tbl        |  1 +
>  arch/arm/tools/syscall.tbl                    |  1 +
>  arch/arm64/include/asm/unistd.h               |  2 +-
>  arch/arm64/include/asm/unistd32.h             |  3 +-
>  arch/ia64/kernel/syscalls/syscall.tbl         |  1 +
>  arch/m68k/kernel/syscalls/syscall.tbl         |  1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl   |  1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl     |  1 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl     |  1 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl     |  1 +
>  arch/parisc/kernel/syscalls/syscall.tbl       |  1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl      |  1 +
>  arch/s390/kernel/syscalls/syscall.tbl         |  1 +
>  arch/sh/kernel/syscalls/syscall.tbl           |  1 +
>  arch/sparc/kernel/syscalls/syscall.tbl        |  1 +
>  arch/x86/entry/syscalls/syscall_32.tbl        |  1 +
>  arch/x86/entry/syscalls/syscall_64.tbl        |  1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl       |  1 +
>  include/linux/mempolicy.h                     | 11 +++
>  include/linux/syscalls.h                      |  4 +
>  include/uapi/asm-generic/unistd.h             |  5 +-
>  kernel/sys_ni.c                               |  1 +
>  mm/mempolicy.c                                | 89 +++++++++++++++++++
>  24 files changed, 146 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Docume=
ntation/admin-guide/mm/numa_memory_policy.rst
> index 5a6afecbb0d0..b864dd88b2d2 100644
> --- a/Documentation/admin-guide/mm/numa_memory_policy.rst
> +++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
> @@ -408,9 +408,10 @@ follows:
>  Memory Policy APIs
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -Linux supports 4 system calls for controlling memory policy.  These APIS
> -always affect only the calling task, the calling task's address space, or
> -some shared object mapped into the calling task's address space.
> +Linux supports 5 system calls for controlling memory policy.  The first =
four
> +APIS affect only the calling task, the calling task's address space, or =
some
> +shared object mapped into the calling task's address space. The last one=
 can
> +set the mempolicy of task specified in pidfd.
> =20
>  .. note::
>     the headers that define these APIs and the parameter data types for
> @@ -473,6 +474,20 @@ closest to which page allocation will come from. Spe=
cifying the home node overri
>  the default allocation policy to allocate memory close to the local node=
 for an
>  executing CPU.
> =20
> +Set [pidfd Task] Memory Policy::
> +
> +        long sys_pidfd_set_mempolicy(int pidfd, int mode,
> +                                     const unsigned long __user *nmask,
> +                                     unsigned long maxnode,
> +                                     unsigned int flags);
> +
> +Set's the [pidfd] task's "task/process memory policy". The pidfd argumen=
t is
> +a PID file descriptor (see pidfd_open(2) man page) that specifies the pr=
ocess
> +to which the mempolicy is to be applied. The flags argument is reserved =
for
> +future use; currently, this argument must be specified as 0. Please see =
the
> +set_mempolicy(2) man page for more details about other's arguments.
> +
> +
> =20
>  Memory Policy Command Line Interface
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The wording can be improved:

---- >8 ----

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Document=
ation/admin-guide/mm/numa_memory_policy.rst
index b864dd88b2d236..6df35bf4f960bd 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -410,8 +410,8 @@ Memory Policy APIs
=20
 Linux supports 5 system calls for controlling memory policy.  The first fo=
ur
 APIS affect only the calling task, the calling task's address space, or so=
me
-shared object mapped into the calling task's address space. The last one c=
an
-set the mempolicy of task specified in pidfd.
+shared object mapped into the calling task's address space. The last one
+sets the mempolicy of task specified in the pidfd.
=20
 .. note::
    the headers that define these APIs and the parameter data types for
@@ -481,11 +481,11 @@ Set [pidfd Task] Memory Policy::
                                      unsigned long maxnode,
                                      unsigned int flags);
=20
-Set's the [pidfd] task's "task/process memory policy". The pidfd argument =
is
-a PID file descriptor (see pidfd_open(2) man page) that specifies the proc=
ess
-to which the mempolicy is to be applied. The flags argument is reserved for
-future use; currently, this argument must be specified as 0. Please see the
-set_mempolicy(2) man page for more details about other's arguments.
+Sets the task/process memory policy for the [pidfd] task. The pidfd argume=
nt
+is a PID file descriptor (see pidfd_open(2) man page for details) that
+specifies the process for which the mempolicy is applied to. The flags
+argument is reserved for future use; currently, it must be specified as 0.
+For the description of all other arguments, see set_mempolicy(2) man page.
=20
=20
=20

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--kr4kyCS+bdnKay0q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY0Y/nAAKCRD2uYlJVVFO
oy70AP4wEUgCFmmVfoPF+Ih5oXK6spLPS9lHk0Dk31CIgVAE7wEAgMChcWW248/J
DbLqTdkHQzGWPrcJVo3ID2vm6Zz2MgQ=
=8XfN
-----END PGP SIGNATURE-----

--kr4kyCS+bdnKay0q--
