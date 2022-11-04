Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861AF61A2CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiKDU40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKDU4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:56:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044CEDEE1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:56:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p16so3677111wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 13:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRY3WjMJR+gDEY+LNqfUTeggtG9YcWsAif47IMb8FRA=;
        b=jUEIot2ndLamGxQNDwHkESnQSkIH6T79k6qXHzu9T8Cx4TjlGMM1idzytv0cbU8/Qc
         SkhCXGSoPqFzm9oB2MZTULVMA8C2BoMHSELuJFpAa27jpHs3UIHkGwGS9WzjMj8gsy0q
         BvYlsV03j9ty9R596AKMNxyzWaByRMtXpnUWNKGrLJSv9pS2642OzXptyeN/0FGJekLD
         iEZhIc/fTuY36zu4nzH6e72ujIsDlBNzW59XPl77H8XVcA1jpGiRTMif86b0luyZU55+
         3hrBtMhKYADwP6dRnj6PoIGKopqXybCwPuvVhWxqaBkJ2ngop8TJM2Ju6MgoyqFdN5Q0
         pNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRY3WjMJR+gDEY+LNqfUTeggtG9YcWsAif47IMb8FRA=;
        b=s/Ga5PkrwVRdl9G+GYLRM0UHankS/pLsfEkpD79uKpBw37WrL2nXtZJ2jrpbJyzn2h
         InvtFd2ylGPe1OUfSzefUf7E7Cm45RZQKg6EEEXgcn/PoeFIfwOk+xwHZD5FqQ7kKkJV
         kTy8rylb5Xnb+GtcN/ZtjaubhyusDkleVdaPOq+9J1XAFaybm/1pymrTaG2z4M2Rpng8
         0QpU/8iNRA7YsmDCHKZMqF6IPf76NtOum5Uuib4je06dkjpJgT7lblus6OlJC1S2qmeI
         P2FBwmeo/4vtrtA5aPXy5f0yMLgDlhs3ye5G1nKZDiH08+Kg0xu7mw2LPjOvao9C6Mbn
         s1nQ==
X-Gm-Message-State: ACrzQf0HtjSTkA8sE63oXJ740O9XCp9oZ4ovTWCptlvOAUW0IsvLUB6w
        DyIm7Kn+jfC5K3IKCvqnAcRg55Y3s65rLpJ9tPuljpJDqGqHPw==
X-Google-Smtp-Source: AMsMyM7dvEq2fkb9KXIXXbZLF6QXeJoTDbAGlQL31ENjbZ5VG46RNxoxoX9w6zjeRR7NlOsyVRBMLGuQqcxfWyEkrM4=
X-Received: by 2002:a05:600c:2194:b0:3cf:7065:99e5 with SMTP id
 e20-20020a05600c219400b003cf706599e5mr19867517wme.174.1667595379273; Fri, 04
 Nov 2022 13:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <Y2V2Tpu+2vzJyon2@kernel.org>
In-Reply-To: <Y2V2Tpu+2vzJyon2@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 4 Nov 2022 13:56:07 -0700
Message-ID: <CAP-5=fVkz=gKkeAV2dW5Q+XzZrjkGJ+4bSH0mc8LZZ8EJGW90A@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf trace: Add BPF augmenter to perf_event_open()'s
 'struct perf_event_attr' arg
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Nov 4, 2022 at 1:30 PM Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>
> Please test it together with what is in my tmp.perf/core branch, as it
> has the fixes for perf to build and run with libbpf 1.0, please install
> libbpf-devel from your distro, at least for now.
>
> There is polishing to do here, but its interesting as an example of how
> to augment a syscall.
>
> If you run 'perf trace -v' with
> ~acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c you'll
> see that it reuses augmenters for other syscalls that have similar
> signatures, so, in the future, doing for one struct gets it reused in
> all the other syscalls using such struct.
>
> Also more annotation is needed, as with other syscalls already in 'perf
> trace' to associate a type syscall integer arguments, for things like
> flags, enumerations not using enum, etc.
>
> - Arnaldo
>

Looks good.

Before:
$ sudo perf trace -e ./augmented_raw_syscalls.o,perf_event_open
--max-events 10 perf stat --quiet sleep 0.001
    0.000 ( 0.011 ms): perf/366155 perf_event_open(attr_uptr:
0x56344c9ab1e0, pid: 366156 (perf), cpu: -1, group_fd: -1, flags:
FD_CLOEXEC) =3D 3
    0.014 ( 0.261 ms): perf/366155 perf_event_open(attr_uptr:
0x56344c9ae6b0, pid: 366156 (perf), cpu: -1, group_fd: -1, flags:
FD_CLOEXEC) =3D 4
    0.276 ( 0.192 ms): perf/366155 perf_event_open(attr_uptr:
0x56344c9ae920, pid: 366156 (perf), cpu: -1, group_fd: -1, flags:
FD_CLOEXEC) =3D 5
    0.470 ( 0.012 ms): perf/366155 perf_event_open(attr_uptr:
0x56344c9aeb90, pid: 366156 (perf), cpu: -1, group_fd: -1, flags:
FD_CLOEXEC) =3D 7
    0.485 ( 0.005 ms): perf/366155 perf_event_open(attr_uptr:
0x56344c9acdc0, pid: 366156 (perf), cpu: -1, group_fd: -1, flags:
FD_CLOEXEC) =3D 8
    0.493 ( 0.003 ms): perf/366155 perf_event_open(attr_uptr:
0x56344c9aaf60, pid: 366156 (perf), cpu: -1, group_fd: -1, flags:
FD_CLOEXEC) =3D 9
    0.498 ( 0.003 ms): perf/366155 perf_event_open(attr_uptr:
0x56344c9ad030, pid: 366156 (perf), cpu: -1, group_fd: -1, flags:
FD_CLOEXEC) =3D 10
    0.502 ( 0.002 ms): perf/366155 perf_event_open(attr_uptr:
0x56344c9ad2a0, pid: 366156 (perf), cpu: -1, group_fd: -1, flags:
FD_CLOEXEC) =3D 11
    0.506 ( 0.002 ms): perf/366155 perf_event_open(attr_uptr:
0x56344c9a3120, pid: 366156 (perf), cpu: -1, group_fd: -1, flags:
FD_CLOEXEC) =3D 12
    0.510 ( 0.003 ms): perf/366155 perf_event_open(attr_uptr:
0x56344c9a3410, pid: 366156 (perf), cpu: -1, group_fd: 12, flags:
FD_CLOEXEC) =3D 13

After:
$ sudo /tmp/perf/perf trace -e
./augmented_raw_syscalls.o,perf_event_open --max-events 10 perf stat
--quiet sleep 0.001
    0.000 ( 0.009 ms): perf/366177 perf_event_open(attr_uptr: { type:
1, size: 128, config: 0x1, sample_type: IDENTIFIER, read_format:
TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1,
enable_on_exec: 1, exclude_guest: 1 }, pid: 366178 (perf), cpu: -1,
group_fd: -1, flags: FD_CLOEXEC) =3D 3
    0.013 ( 0.093 ms): perf/366177 perf_event_open(attr_uptr: { type:
1, size: 128, config: 0x3, sample_type: IDENTIFIER, read_format:
TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1,
enable_on_exec: 1, exclude_guest: 1 }, pid: 366178 (perf), cpu: -1,
group_fd: -1, flags: FD_CLOEXEC) =3D 4
    0.107 ( 0.026 ms): perf/366177 perf_event_open(attr_uptr: { type:
1, size: 128, config: 0x4, sample_type: IDENTIFIER, read_format:
TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1,
enable_on_exec: 1, exclude_guest: 1 }, pid: 366178 (perf), cpu: -1,
group_fd: -1, flags: FD_CLOEXEC) =3D 5
    0.135 ( 0.026 ms): perf/366177 perf_event_open(attr_uptr: { type:
1, size: 128, config: 0x2, sample_type: IDENTIFIER, read_format:
TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1,
enable_on_exec: 1, exclude_guest: 1 }, pid: 366178 (perf), cpu: -1,
group_fd: -1, flags: FD_CLOEXEC) =3D 7
    0.162 ( 0.006 ms): perf/366177 perf_event_open(attr_uptr: { size:
128, sample_type: IDENTIFIER, read_format:
TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1,
enable_on_exec: 1, exclude_guest: 1 }, pid: 366178 (perf), cpu: -1,
group_fd: -1, flags: FD_CLOEXEC) =3D 8
    0.169 ( 0.002 ms): perf/366177 perf_event_open(attr_uptr: { size:
128, config: 0x1, sample_type: IDENTIFIER, read_format:
TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1,
enable_on_exec: 1, exclude_guest: 1 }, pid: 366178 (perf), cpu: -1,
group_fd: -1, flags: FD_CLOEXEC) =3D 9
    0.172 ( 0.003 ms): perf/366177 perf_event_open(attr_uptr: { size:
128, config: 0x4, sample_type: IDENTIFIER, read_format:
TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1,
enable_on_exec: 1, exclude_guest: 1 }, pid: 366178 (perf), cpu: -1,
group_fd: -1, flags: FD_CLOEXEC) =3D 10
    0.176 ( 0.002 ms): perf/366177 perf_event_open(attr_uptr: { size:
128, config: 0x5, sample_type: IDENTIFIER, read_format:
TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1,
enable_on_exec: 1, exclude_guest: 1 }, pid: 366178 (perf), cpu: -1,
group_fd: -1, flags: FD_CLOEXEC) =3D 11
    0.179 ( 0.002 ms): perf/366177 perf_event_open(attr_uptr: { type:
4, size: 128, config: 0x400, sample_type: IDENTIFIER, read_format:
TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP, disabled: 1, inherit:
1, enable_on_exec: 1, exclude_guest: 1 }, pid: 366178 (perf), cpu: -1,
group_fd: -1, flags: FD_CLOEXEC) =3D 12
    0.182 ( 0.003 ms): perf/366177 perf_event_open(attr_uptr: { type:
4, size: 128, config: 0x8000, sample_type: IDENTIFIER, read_format:
TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP, inherit: 1,
exclude_guest: 1 }, pid: 366178 (perf), cpu: -1, group_fd: 12, flags:
FD_CLOEXEC) =3D 13

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ----
>
> Using BPF for that, doing a cleverish reuse of perf_event_attr__fprintf()=
,
> that really needs to be turned into __snprintf(), etc.
>
> But since the plan is to go the BTF way probably use libbpf's
> btf_dump__dump_type_data().
>
> Example:
>
> [root@quaco ~]# perf trace -e ~acme/git/perf/tools/perf/examples/bpf/augm=
ented_raw_syscalls.c,perf_event_open --max-events 10 perf stat --quiet slee=
p 0.001
> fg
>      0.000 perf_event_open(attr_uptr: { type: 1, size: 128, config: 0x1, =
sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING=
, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 2588=
59 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 3
>      0.067 perf_event_open(attr_uptr: { type: 1, size: 128, config: 0x3, =
sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING=
, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 2588=
59 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 4
>      0.120 perf_event_open(attr_uptr: { type: 1, size: 128, config: 0x4, =
sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING=
, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 2588=
59 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 5
>      0.172 perf_event_open(attr_uptr: { type: 1, size: 128, config: 0x2, =
sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING=
, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 2588=
59 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 7
>      0.190 perf_event_open(attr_uptr: { size: 128, sample_type: IDENTIFIE=
R, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit=
: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 258859 (perf), cpu: -1, gr=
oup_fd: -1, flags: FD_CLOEXEC) =3D 8
>      0.199 perf_event_open(attr_uptr: { size: 128, config: 0x1, sample_ty=
pe: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disable=
d: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 258859 (perf)=
, cpu: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 9
>      0.204 perf_event_open(attr_uptr: { size: 128, config: 0x4, sample_ty=
pe: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disable=
d: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 258859 (perf)=
, cpu: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 10
>      0.210 perf_event_open(attr_uptr: { size: 128, config: 0x5, sample_ty=
pe: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disable=
d: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 258859 (perf)=
, cpu: -1, group_fd: -1, flags: FD_CLOEXEC) =3D 11
> [root@quaco ~]#
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-trace.c                    |  3 +-
>  .../examples/bpf/augmented_raw_syscalls.c     | 44 +++++++++++++++++++
>  tools/perf/trace/beauty/perf_event_open.c     | 44 +++++++++++++++++++
>  3 files changed, 90 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 72991528687ea60b..5690c33c523b37d7 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1053,7 +1053,8 @@ static struct syscall_fmt syscall_fmts[] =3D {
>           .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT,       /* dfd */ }=
,
>                    [2] =3D { .scnprintf =3D SCA_OPEN_FLAGS, /* flags */ }=
, }, },
>         { .name     =3D "perf_event_open",
> -         .arg =3D { [2] =3D { .scnprintf =3D SCA_INT,        /* cpu */ }=
,
> +         .arg =3D { [0] =3D { .scnprintf =3D SCA_PERF_ATTR,  /* attr */ =
},
> +                  [2] =3D { .scnprintf =3D SCA_INT,        /* cpu */ },
>                    [3] =3D { .scnprintf =3D SCA_FD,         /* group_fd *=
/ },
>                    [4] =3D { .scnprintf =3D SCA_PERF_FLAGS, /* flags */ }=
, }, },
>         { .name     =3D "pipe2",
> diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/per=
f/examples/bpf/augmented_raw_syscalls.c
> index 926238efd7d8d0df..0599823e8ae1b4c0 100644
> --- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
> +++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
> @@ -129,6 +129,7 @@ struct augmented_args_payload {
>                         struct augmented_arg arg, arg2;
>                 };
>                 struct sockaddr_storage saddr;
> +               char   __data[sizeof(struct augmented_arg)];
>         };
>  };
>
> @@ -293,6 +294,49 @@ int sys_enter_renameat(struct syscall_enter_args *ar=
gs)
>         return augmented__output(args, augmented_args, len);
>  }
>
> +#define PERF_ATTR_SIZE_VER0     64      /* sizeof first published struct=
 */
> +
> +// we need just the start, get the size to then copy it
> +struct perf_event_attr_size {
> +        __u32                   type;
> +        /*
> +         * Size of the attr structure, for fwd/bwd compat.
> +         */
> +        __u32                   size;
> +};
> +
> +SEC("!syscalls:sys_enter_perf_event_open")
> +int sys_enter_perf_event_open(struct syscall_enter_args *args)
> +{
> +       struct augmented_args_payload *augmented_args =3D augmented_args_=
payload();
> +       const struct perf_event_attr_size *attr =3D (const struct perf_ev=
ent_attr_size *)args->args[0], *attr_read;
> +       unsigned int len =3D sizeof(augmented_args->args);
> +
> +        if (augmented_args =3D=3D NULL)
> +               goto failure;
> +
> +       if (bpf_probe_read(&augmented_args->__data, sizeof(*attr), attr) =
< 0)
> +               goto failure;
> +
> +       attr_read =3D (const struct perf_event_attr_size *)augmented_args=
->__data;
> +
> +       __u32 size =3D attr_read->size;
> +
> +       if (!size)
> +               size =3D PERF_ATTR_SIZE_VER0;
> +
> +       if (size > sizeof(augmented_args->__data))
> +                goto failure;
> +
> +       // Now that we read attr->size and tested it against the size lim=
its, read it completely
> +       if (bpf_probe_read(&augmented_args->__data, size, attr) < 0)
> +               goto failure;
> +
> +       return augmented__output(args, augmented_args, len + size);
> +failure:
> +       return 1; /* Failure: don't filter */
> +}
> +
>  static pid_t getpid(void)
>  {
>         return bpf_get_current_pid_tgid();
> diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace=
/beauty/perf_event_open.c
> index 11d47dbe63bd1edc..01ee15fe9d0c7a98 100644
> --- a/tools/perf/trace/beauty/perf_event_open.c
> +++ b/tools/perf/trace/beauty/perf_event_open.c
> @@ -44,3 +44,47 @@ static size_t syscall_arg__scnprintf_perf_flags(char *=
bf, size_t size,
>  }
>
>  #define SCA_PERF_FLAGS syscall_arg__scnprintf_perf_flags
> +
> +struct attr_fprintf_args {
> +       size_t size, printed;
> +       char *bf;
> +       bool first;
> +};
> +
> +static int attr__fprintf(FILE *fp __maybe_unused, const char *name, cons=
t char *val, void *priv)
> +{
> +       struct attr_fprintf_args *args =3D priv;
> +       size_t printed =3D scnprintf(args->bf + args->printed , args->siz=
e - args->printed, "%s%s: %s", args->first ? "" : ", ", name, val);
> +
> +       args->first =3D false;
> +       args->printed +=3D printed;
> +       return printed;
> +}
> +
> +static size_t perf_event_attr___scnprintf(struct perf_event_attr *attr, =
char *bf, size_t size, bool show_zeros __maybe_unused)
> +{
> +       struct attr_fprintf_args args =3D {
> +               .printed =3D scnprintf(bf, size, "{ "),
> +               .size    =3D size,
> +               .first   =3D true,
> +               .bf      =3D bf,
> +       };
> +
> +       perf_event_attr__fprintf(stdout, attr, attr__fprintf, &args);
> +       return args.printed + scnprintf(bf + args.printed, size - args.pr=
inted, " }");
> +}
> +
> +static size_t syscall_arg__scnprintf_augmented_perf_event_attr(struct sy=
scall_arg *arg, char *bf, size_t size)
> +{
> +       return perf_event_attr___scnprintf((void *)arg->augmented.args, b=
f, size, arg->trace->show_zeros);
> +}
> +
> +static size_t syscall_arg__scnprintf_perf_event_attr(char *bf, size_t si=
ze, struct syscall_arg *arg)
> +{
> +       if (arg->augmented.args)
> +               return syscall_arg__scnprintf_augmented_perf_event_attr(a=
rg, bf, size);
> +
> +       return scnprintf(bf, size, "%#lx", arg->val);
> +}
> +
> +#define SCA_PERF_ATTR syscall_arg__scnprintf_perf_event_attr
> --
> 2.37.3
>
