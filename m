Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E946A66F8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCAEdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCAEdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:33:03 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E54AB74F;
        Tue, 28 Feb 2023 20:33:01 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id a9so2603350plh.11;
        Tue, 28 Feb 2023 20:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677645181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BUFS3+ohbwNXbu3J/sdx7ngaO9F+ivRU8ju2bKz74QI=;
        b=JlPP0rfTNgmSQugKRn7rks8FU516k3xNxlmq33mYzg87OnSx47U0tbd+jCgalcVRaE
         kRovTIEt4RF173QvBgeQPl/cmd8mccsZuVIej7mZ/+uymktMrNn8FXwUkXKDSXRU5eSQ
         WXQ6b0pB1lKrT9kYSu9Na/ebKsic/xL0Ou9CqeQlQk6JazxVllS202mEx24bmkdAQQtw
         jGw0BER/7ao9ET2vdexcf9Z1YOFLKkbwnWE6/kZOxdBZhHQXjkf+ZjJikarU5UlrfDHx
         inu9KWkU5Fojo5tGjGu/6NdGND9KhpP+1NbgUFq++XWuYBh4G6Up6ndMujlYCI4S+las
         +jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677645181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUFS3+ohbwNXbu3J/sdx7ngaO9F+ivRU8ju2bKz74QI=;
        b=KRwFLqKvJbvUeOtPmItim0fguup5ifIQa0oUzEIHi4o4qcN9KKEvcGzIOwv5dgYXOa
         yGwNfXKr3czbkMpBJzC1YfuCC9lQ4Cl9rHPT4SsKc3ANTw0P+wZJX7fbcGLU82IXdYrj
         XqE5cZpyIc59nYn8jrqwICRAQpgP3lRtCgodEndZLXoDZQc+WnTyXMPkvfPsocM0MiPs
         9OnNZI6lLuedmYVXRfAEZIPRrVP3fItPVrcNUTECQN3a9accV2nYn0nUFDmDGvXjg+3e
         5EmAS5G3lSL2dZKOLzM3xSVBebyLm4RsXNowZqZklScNmFpgalvRKL++aC4Ku4Q9iV/J
         XwrQ==
X-Gm-Message-State: AO0yUKUPh3UdoRgH2+q7yGR+FomfI6LF0VKilzdeFme/5WJiV0HbOdo3
        qot6QRMw8fUm0wowQ+8YM3M=
X-Google-Smtp-Source: AK7set+P0g2qq4VURHF1j1I1pd5Yn+043bFtzzeuCoUD2J0zkXQYeLBZyYag+o77hcZq+eDIox8UNQ==
X-Received: by 2002:a17:903:40c6:b0:19c:d6d0:7887 with SMTP id t6-20020a17090340c600b0019cd6d07887mr4464395pld.30.1677645180693;
        Tue, 28 Feb 2023 20:33:00 -0800 (PST)
Received: from debian.me (subs02-180-214-232-73.three.co.id. [180.214.232.73])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902ed0b00b0019602b2c00csm7279061pld.175.2023.02.28.20.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 20:32:59 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 969D8100FE8; Wed,  1 Mar 2023 11:32:56 +0700 (WIB)
Date:   Wed, 1 Mar 2023 11:32:56 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux Documentation <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] kcov: improve documentation
Message-ID: <Y/7VeHQBL43MzIPR@debian.me>
References: <583f41c49eef15210fa813e8229730d11427efa7.1677614637.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MY45FsvfwBPyRUm7"
Content-Disposition: inline
In-Reply-To: <583f41c49eef15210fa813e8229730d11427efa7.1677614637.git.andreyknvl@google.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MY45FsvfwBPyRUm7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2023 at 09:04:15PM +0100, andrey.konovalov@linux.dev wrote:
> diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/k=
cov.rst
> index d83c9ab49427..4527acfa023d 100644
> --- a/Documentation/dev-tools/kcov.rst
> +++ b/Documentation/dev-tools/kcov.rst
> @@ -1,42 +1,50 @@
> -kcov: code coverage for fuzzing
> +KCOV: code coverage for fuzzing
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> =20
> -kcov exposes kernel code coverage information in a form suitable for cov=
erage-
> -guided fuzzing (randomized testing). Coverage data of a running kernel is
> -exported via the "kcov" debugfs file. Coverage collection is enabled on =
a task
> -basis, and thus it can capture precise coverage of a single system call.
> +KCOV collects and exposes kernel code coverage information in a form sui=
table
> +for coverage-guided fuzzing. Coverage data of a running kernel is export=
ed via
> +the ``kcov`` debugfs file. Coverage collection is enabled on a task basi=
s, and
> +thus KCOV can capture precise coverage of a single system call.
> =20
> -Note that kcov does not aim to collect as much coverage as possible. It =
aims
> -to collect more or less stable coverage that is function of syscall inpu=
ts.
> -To achieve this goal it does not collect coverage in soft/hard interrupts
> -and instrumentation of some inherently non-deterministic parts of kernel=
 is
> -disabled (e.g. scheduler, locking).
> +Note that KCOV does not aim to collect as much coverage as possible. It =
aims
> +to collect more or less stable coverage that is a function of syscall in=
puts.
> +To achieve this goal, it does not collect coverage in soft/hard interrup=
ts
> +(unless remove coverage collection is enabled, see below) and from some
> +inherently non-deterministic parts of the kernel (e.g. scheduler, lockin=
g).
> =20
> -kcov is also able to collect comparison operands from the instrumented c=
ode
> -(this feature currently requires that the kernel is compiled with clang).
> +Besides collecting code coverage, KCOV can also collect comparison opera=
nds.
> +See the "Comparison operands collection" section for details.
> +
> +Besides collecting coverage data from syscall handlers, KCOV can also co=
llect
> +coverage for annotated parts of the kernel executing in background kernel
> +tasks or soft interrupts. See the "Remote coverage collection" section f=
or
> +details.
> =20
>  Prerequisites
>  -------------
> =20
> -Configure the kernel with::
> +KCOV relies on compiler instrumentation and requires GCC 6.1.0 or later
> +or any Clang version supported by the kernel.
> =20
> -        CONFIG_KCOV=3Dy
> +Collecting comparison operands is supported with GCC 8+ or with Clang.
> =20
> -CONFIG_KCOV requires gcc 6.1.0 or later.
> +To enable KCOV, configure the kernel with::
> =20
> -If the comparison operands need to be collected, set::
> +        CONFIG_KCOV=3Dy
> +
> +To enable comparison operands collection, set::
> =20
>  	CONFIG_KCOV_ENABLE_COMPARISONS=3Dy
> =20
> -Profiling data will only become accessible once debugfs has been mounted=
::
> +Coverage data only becomes accessible once debugfs has been mounted::
> =20
>          mount -t debugfs none /sys/kernel/debug
> =20
>  Coverage collection
>  -------------------
> =20
> -The following program demonstrates coverage collection from within a test
> -program using kcov:
> +The following program demonstrates how to use KCOV to collect coverage f=
or a
> +single syscall from within a test program:
> =20
>  .. code-block:: c
> =20
> @@ -84,7 +92,7 @@ program using kcov:
>  		perror("ioctl"), exit(1);
>  	/* Reset coverage from the tail of the ioctl() call. */
>  	__atomic_store_n(&cover[0], 0, __ATOMIC_RELAXED);
> -	/* That's the target syscal call. */
> +	/* Call the target syscall call. */
>  	read(-1, NULL, 0);
>  	/* Read number of PCs collected. */
>  	n =3D __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
> @@ -103,7 +111,7 @@ program using kcov:
>  	return 0;
>      }
> =20
> -After piping through addr2line output of the program looks as follows::
> +After piping through ``addr2line`` the output of the program looks as fo=
llows::
> =20
>      SyS_read
>      fs/read_write.c:562
> @@ -121,12 +129,13 @@ After piping through addr2line output of the progra=
m looks as follows::
>      fs/read_write.c:562
> =20
>  If a program needs to collect coverage from several threads (independent=
ly),
> -it needs to open /sys/kernel/debug/kcov in each thread separately.
> +it needs to open ``/sys/kernel/debug/kcov`` in each thread separately.
> =20
>  The interface is fine-grained to allow efficient forking of test process=
es.
> -That is, a parent process opens /sys/kernel/debug/kcov, enables trace mo=
de,
> -mmaps coverage buffer and then forks child processes in a loop. Child pr=
ocesses
> -only need to enable coverage (disable happens automatically on thread en=
d).
> +That is, a parent process opens ``/sys/kernel/debug/kcov``, enables trac=
e mode,
> +mmaps coverage buffer, and then forks child processes in a loop. The chi=
ld
> +processes only need to enable coverage (it gets disabled automatically w=
hen
> +a thread exits).
> =20
>  Comparison operands collection
>  ------------------------------
> @@ -205,52 +214,78 @@ Comparison operands collection is similar to covera=
ge collection:
>  	return 0;
>      }
> =20
> -Note that the kcov modes (coverage collection or comparison operands) are
> -mutually exclusive.
> +Note that the KCOV modes (collection of code coverage or comparison oper=
ands)
> +are mutually exclusive.
> =20
>  Remote coverage collection
>  --------------------------
> =20
> -With KCOV_ENABLE coverage is collected only for syscalls that are issued
> -from the current process. With KCOV_REMOTE_ENABLE it's possible to colle=
ct
> -coverage for arbitrary parts of the kernel code, provided that those par=
ts
> -are annotated with kcov_remote_start()/kcov_remote_stop().
> -
> -This allows to collect coverage from two types of kernel background
> -threads: the global ones, that are spawned during kernel boot in a limit=
ed
> -number of instances (e.g. one USB hub_event() worker thread is spawned p=
er
> -USB HCD); and the local ones, that are spawned when a user interacts with
> -some kernel interface (e.g. vhost workers); as well as from soft
> -interrupts.
> -
> -To enable collecting coverage from a global background thread or from a
> -softirq, a unique global handle must be assigned and passed to the
> -corresponding kcov_remote_start() call. Then a userspace process can pass
> -a list of such handles to the KCOV_REMOTE_ENABLE ioctl in the handles
> -array field of the kcov_remote_arg struct. This will attach the used kcov
> -device to the code sections, that are referenced by those handles.
> -
> -Since there might be many local background threads spawned from different
> -userspace processes, we can't use a single global handle per annotation.
> -Instead, the userspace process passes a non-zero handle through the
> -common_handle field of the kcov_remote_arg struct. This common handle ge=
ts
> -saved to the kcov_handle field in the current task_struct and needs to be
> -passed to the newly spawned threads via custom annotations. Those threads
> -should in turn be annotated with kcov_remote_start()/kcov_remote_stop().
> -
> -Internally kcov stores handles as u64 integers. The top byte of a handle
> -is used to denote the id of a subsystem that this handle belongs to, and
> -the lower 4 bytes are used to denote the id of a thread instance within
> -that subsystem. A reserved value 0 is used as a subsystem id for common
> -handles as they don't belong to a particular subsystem. The bytes 4-7 are
> -currently reserved and must be zero. In the future the number of bytes
> -used for the subsystem or handle ids might be increased.
> -
> -When a particular userspace process collects coverage via a common
> -handle, kcov will collect coverage for each code section that is annotat=
ed
> -to use the common handle obtained as kcov_handle from the current
> -task_struct. However non common handles allow to collect coverage
> -selectively from different subsystems.
> +Besides collecting coverage data from handlers of syscalls issued from a
> +userspace process, KCOV can also collect coverage for parts of the kernel
> +executing in other contexts - so-called "remote" coverage.
> +
> +Using KCOV to collect remote coverage requires:
> +
> +1. Modifying kernel code to annotate the code section from where coverage
> +   should be collected with ``kcov_remote_start`` and ``kcov_remote_stop=
``.
> +
> +2. Using `KCOV_REMOTE_ENABLE`` instead of ``KCOV_ENABLE`` in the userspa=
ce
``KCOV_REMOTE_ENABLE``
> +   process that collects coverage.
> +
> +Both ``kcov_remote_start`` and ``kcov_remote_stop`` annotations and the
> +``KCOV_REMOTE_ENABLE`` ioctl accept handles that identify particular cov=
erage
> +collection sections. The way a handle is used depends on the context whe=
re the
> +matching code section executes.
> +
> +KCOV supports collecting remote coverage from the following contexts:
> +
> +1. Global kernel background tasks. These are the tasks that are spawned =
during
> +   kernel boot in a limited number of instances (e.g. one USB ``hub_even=
t``
> +   worker is spawned per one USB HCD).
> +
> +2. Local kernel background tasks. These are spawned when a userspace pro=
cess
> +   interacts with some kernel interface and are usually killed when the =
process
> +   exits (e.g. vhost workers).
> +
> +3. Soft interrupts.
> +
> +For #1 and #3, a unique global handle must be chosen and passed to the
> +corresponding ``kcov_remote_start`` call. Then a userspace process must =
pass
> +this handle to ``KCOV_REMOTE_ENABLE`` in the ``handles`` array field of =
the
> +``kcov_remote_arg`` struct. This will attach the used KCOV device to the=
 code
> +section referenced by this handle. Multiple global handles identifying
> +different code sections can be passed at once.
> +
> +For #2, the userspace process instead must pass a non-zero handle throug=
h the
> +``common_handle`` field of the ``kcov_remote_arg`` struct. This common h=
andle
> +gets saved to the ``kcov_handle`` field in the current ``task_struct`` a=
nd
> +needs to be passed to the newly spawned local tasks via custom kernel co=
de
> +modifications. Those tasks should in turn use the passed handle in their
> +``kcov_remote_start`` and ``kcov_remote_stop`` annotations.
> +
> +KCOV follows a predefined format for both global and common handles. Each
> +handle is a ``u64`` integer. Currently, only the one top and the lower 4=
 bytes
> +are used. Bytes 4-7 are reserved and must be zero.
> +
> +For global handles, the top byte of the handle denotes the id of a subsy=
stem
> +this handle belongs to. For example, KCOV uses ``1`` as the USB subsyste=
m id.
> +The lower 4 bytes of a global handle denote the id of a task instance wi=
thin
> +that subsystem. For example, each ``hub_event`` worker uses the USB bus =
number
> +as the task instance id.
> +
> +For common handles, a reserved value ``0`` is used as a subsystem id, as=
 such
> +handles don't belong to a particular subsystem. The lower 4 bytes of a c=
ommon
> +handle identify a collective instance of all local tasks spawned by the
> +userspace process that passed a common handle to ``KCOV_REMOTE_ENABLE``.
> +
> +In practice, any value can be used for common handle instance id if cove=
rage
> +is only collected from a single userspace process on the system. However=
, if
> +common handles are used by multiple processes, unique instance ids must =
be
> +used for each process. One option is to use the process id as the common
> +handle instance id.
> +
> +The following program demonstrates using KCOV to collect coverage from b=
oth
> +local tasks spawned by the process and the global task that handles USB =
bus #1:
> =20
>  .. code-block:: c
> =20

Otherwise LGTM.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--MY45FsvfwBPyRUm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY/7VcwAKCRD2uYlJVVFO
o8FUAP9eioDvchn/gsHMWPAWDem8tEFb8ktjTUVtjkrmtUde1AEA/Oe7b7Kxa8gX
2UHhhHntK61QsM/KZVs59oER+djYVAw=
=GJOE
-----END PGP SIGNATURE-----

--MY45FsvfwBPyRUm7--
