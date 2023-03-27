Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5946CABD8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjC0R2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjC0R2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:28:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87D7359E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:28:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 185-20020a250ac2000000b00b6d0cdc8e3bso9196860ybk.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679938109;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LUllPEN7E28gEOOMvY1305OSaMld6R2CdduD/pulZGo=;
        b=f38TOHv9lGU4fDEyD0d7usBYUKKI26E9JwLQil5v9PcIbPqb0xIgqNnaNCIvfEfdE4
         pe1iRZu+0ikZhruVicCmht2rT/n4RmspG98vFdntkPjErFQpraLTeKUgldfy2HvuGmIJ
         ecnvBSZd24Qf3Nl0JuVYh/j/qMyio6LMeQ2tk/sv5tzDzq126ddYijOh06b6WwQBDjoh
         W9srxjQLpQ61/OgLrJ7l1SYeD79zRMVgZNkbCPLQ7F4auRZhHuiVzaxTvPk4kEcmNL1f
         i7cMuZWplov1eziga8utETJx1PtNOEICXnhYaqO439Pb0pv6QaO71raPD9GtRga1qqWo
         Ct3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679938109;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUllPEN7E28gEOOMvY1305OSaMld6R2CdduD/pulZGo=;
        b=ORpaIyxDXfnaLI232qmfXe37LJz75gGhGNz8VECigGQI6px29f6AAx80MY6v4ENRvb
         L7kB+gI8oNNjmziH26PXVJpbqaO0tEo18tFIdlCHvGONNPegY75SIfGRGc9O2FGxZ0YF
         3bVVI0+5wezmpsmiFj7CyGZ0lSq5irr7ybEiK0GMLBSVphCOcVTSu2AQgwIWfmjW1c5O
         NYE6IBIhD154S2CZmRiLjAi8ZYWgnSMKK8wrYjhBJWRWf/vo5Nrcjsub1+CaLTD5N1nv
         iac/6qdVqkF7A1mDvPZ/1l9HQ4S0Tb7v6o5ahwxfeQbued93LsBJ3R5+YQF2skm+KdI4
         Jljw==
X-Gm-Message-State: AAQBX9eTBrcP9rxroUXFGmYc6EVmo0gGuXgUXBI/gllLJfndB/FHK1iz
        wsa6zvI5/DxVUXZ3foDFj4ORmow=
X-Google-Smtp-Source: AKy350Z1+MgAzknQGUJKy6oEkgwYXa5vL4np5vkzxiW/YFOnJqUfDiXlYWinVQn+LHsejQP4I0d0gtI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:70d:b0:b45:5cbe:48b3 with SMTP id
 k13-20020a056902070d00b00b455cbe48b3mr7920402ybt.0.1679938109116; Mon, 27 Mar
 2023 10:28:29 -0700 (PDT)
Date:   Mon, 27 Mar 2023 10:28:27 -0700
In-Reply-To: <20230326092208.13613-1-laoar.shao@gmail.com>
Mime-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com>
Message-ID: <ZCHSOxto9DlEzVy9@google.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
From:   Stanislav Fomichev <sdf@google.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26, Yafang Shao wrote:
> Currently only CAP_SYS_ADMIN can iterate BPF object IDs and convert IDs
> to FDs, that's intended for BPF's security model[1]. Not only does it
> prevent non-privilidged users from getting other users' bpf program, but
> also it prevents the user from iterating his own bpf objects.

> In container environment, some users want to run bpf programs in their
> containers. These users can run their bpf programs under CAP_BPF and
> some other specific CAPs, but they can't inspect their bpf programs in a
> generic way. For example, the bpftool can't be used as it requires
> CAP_SYS_ADMIN. That is very inconvenient.

> Without CAP_SYS_ADMIN, the only way to get the information of a bpf object
> which is not created by the process itself is with SCM_RIGHTS, that
> requires each processes which created bpf object has to implement a unix
> domain socket to share the fd of a bpf object between different
> processes, that is really trivial and troublesome.

> Hence we need a better mechanism to get bpf object info without
> CAP_SYS_ADMIN.

[..]

> BPF namespace is introduced in this patchset with an attempt to remove
> the CAP_SYS_ADMIN requirement. The user can create bpf map, prog and
> link in a specific bpf namespace, then these bpf objects will not be
> visible to the users in a different bpf namespace. But these bpf
> objects are visible to its parent bpf namespace, so the sys admin can
> still iterate and inspect them.

Does it essentially mean unpriv bpf? Can I, as a non-root, create
a new bpf namespace and start loading/attaching progs?
Maybe add a paragraph about now vs whatever you're proposing.
Otherwise it's not very clear what's the security story.
(haven't looked at the whole series, so maybe it's answered somewhere else?)

> BPF namespace is similar to PID namespace, and the bpf objects are
> similar to tasks, so BPF namespace is very easy to understand. These
> patchset only implements BPF namespace for bpf map, prog and link. In the
> future we may extend it to other bpf objects like btf, bpffs and etc.
> For example, we can allow some of the BTF objects to be used in
> non-init bpf namespace, then the container user can only trace the
> processes running in his container, but can't get the information of
> tasks running in other containers.

> A simple example is introduced into selftests/bpf on how to use the bpf
> namespace.

> Putting bpf map, prog and link into bpf namespace is the first step.
> Let's start with it.

> [1].  
> https://lore.kernel.org/bpf/20200513230355.7858-1-alexei.starovoitov@gmail.com/

> Yafang Shao (13):
>    fork: New clone3 flag for BPF namespace
>    proc_ns: Extend the field type in struct proc_ns_operations to long
>    bpf: Implement bpf namespace
>    bpf: No need to check if id is 0
>    bpf: Make bpf objects id have the same alloc and free pattern
>    bpf: Helpers to alloc and free object id in bpf namespace
>    bpf: Add bpf helper to get bpf object id
>    bpf: Alloc and free bpf_map id in bpf namespace
>    bpf: Alloc and free bpf_prog id in bpf namespace
>    bpf: Alloc and free bpf_link id in bpf namespace
>    bpf: Allow iterating bpf objects with CAP_BPF in bpf namespace
>    bpf: Use bpf_idr_lock array instead
>    selftests/bpf: Add selftest for bpf namespace

>   fs/proc/namespaces.c                      |   4 +
>   include/linux/bpf.h                       |   9 +-
>   include/linux/bpf_namespace.h             |  88 ++++++++++
>   include/linux/nsproxy.h                   |   4 +
>   include/linux/proc_ns.h                   |   3 +-
>   include/linux/user_namespace.h            |   1 +
>   include/uapi/linux/bpf.h                  |   7 +
>   include/uapi/linux/sched.h                |   1 +
>   kernel/bpf/Makefile                       |   1 +
>   kernel/bpf/bpf_namespace.c                | 283  
> ++++++++++++++++++++++++++++++
>   kernel/bpf/offload.c                      |  16 +-
>   kernel/bpf/syscall.c                      | 262  
> ++++++++++-----------------
>   kernel/bpf/task_iter.c                    |  12 ++
>   kernel/fork.c                             |   5 +-
>   kernel/nsproxy.c                          |  19 +-
>   kernel/trace/bpf_trace.c                  |   2 +
>   kernel/ucount.c                           |   1 +
>   tools/bpf/bpftool/skeleton/pid_iter.bpf.c |  13 +-
>   tools/include/uapi/linux/bpf.h            |   7 +
>   tools/testing/selftests/bpf/Makefile      |   3 +-
>   tools/testing/selftests/bpf/test_bpfns.c  |  76 ++++++++
>   21 files changed, 637 insertions(+), 180 deletions(-)
>   create mode 100644 include/linux/bpf_namespace.h
>   create mode 100644 kernel/bpf/bpf_namespace.c
>   create mode 100644 tools/testing/selftests/bpf/test_bpfns.c

> --
> 1.8.3.1

