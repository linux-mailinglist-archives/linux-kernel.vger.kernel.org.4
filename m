Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7836F0F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344275AbjD0Xgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344291AbjD0Xgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:36:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573EE4C39
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:36:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64115e652eeso8668425b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682638589; x=1685230589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZR28aZTtyd2FOq2+x/D3Azav1fghqMGnnJ3OBjU1db8=;
        b=QcNL4WTD7BAZ45uZ2rUZBbHaGb5NGq88OMFb/hk+6h14hkmiOAuxcM6o8gxy7BWb6s
         7ZPujWviSqnQUcUVMS9L5QsXEECDvEvaPYxqivp87T18IDo0ebxAKMiYrIpH+sT5cpdy
         Sv1lHGvKFRi2CHt3R0PhNVr4VK3oxlWYxQTcLN0AWiaCV4Kv0ug4brrnI0+MMSLdO6fS
         JL8OPt4Tjqe8nb59x+qSmZBO1nOowz0M0vYoCIZXJcPjoTSbUjTe/+WlgVE8ZCTRZF//
         /soGydjss1oGYhoub1jY9+MrWs1N93zW9UX52KYodnuYbsHbJ1/Mgu1IC6Z4ZXHa4Acl
         rDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682638589; x=1685230589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZR28aZTtyd2FOq2+x/D3Azav1fghqMGnnJ3OBjU1db8=;
        b=WbodC3NB2/OMud6S80lR3/qDCW0rDX+CBxDMhZl0iRZeJjhCaH0ft4F2+QjHeE47oZ
         uJ/6V8QjlSQ6irtZPFlF4bw7XyvsV78jyWsp6ESqqayS2icTWkJVRVWPOHpCtkbjJSBy
         kj3Bw3IWUUSX91dHEzJgzEftqvywZ6cyNpJS86czocNEFzztxmbvFtU/73pFz8fRK5AS
         6X3iZBIwjCVIP2GFi066ctrVudVSW9iNvnIeHrf3uj9bDPswNVt8r85+R1rdIEx6QEMK
         NeIYqUeDnScJyIxzRzizBUltlmEjexvvXkNgwY2GKKHX5jPmoA4L7uP3Qdi+KP+NzIhv
         4QiQ==
X-Gm-Message-State: AC+VfDzwKVhfI5hdju4Ta2f45UKdacTHDEc96mYbqysTpBFeY9RYgtQq
        A3AjPxVu7eQb++9HpS27M2y3Q/9Swo2H/qC/35JxWA==
X-Google-Smtp-Source: ACHHUZ6yJzEMVVoXMIG1hh3C2IuooL/DG3uom1bZlv2jJpIj4Ggw5K4nRIaVYciqBWns5Bc7nqnAnXUjK1Eo57YDGRs=
X-Received: by 2002:a17:90a:dd83:b0:244:d441:8f68 with SMTP id
 l3-20020a17090add8300b00244d4418f68mr9245486pjv.16.1682638589170; Thu, 27 Apr
 2023 16:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com> <CAEf4BzZ2zjJKhyUtZKUxbNXJMggcot4MyNEeg6n4Lho-EVbBbg@mail.gmail.com>
 <CA+PiJmTHO3SPM_LvwFYWP+uf_KU4QytBshGzk78CZi8oGJ+rnw@mail.gmail.com> <CAEf4BzZ_4kcM5=Jo3JoWQWugS3wkrtoteyM8YqkykFvYywG+kg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ_4kcM5=Jo3JoWQWugS3wkrtoteyM8YqkykFvYywG+kg@mail.gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Thu, 27 Apr 2023 16:36:18 -0700
Message-ID: <CA+PiJmTsEsUi3c5soodZHxS_PvMPnJG-4bFvdfpLq-kPZ0j4UQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Dynptr Verifier Adjustments
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 4:39=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Don't know, show the sequence of commands you are running?
>
> I have linux source in ~/linux, and KBUILD_OUTPUT set to
> ~/linux-build/default. And it only takes this:
>
> $ cd ~/linux
> $ make -j90 # build kernel
> $ cd tools/testing/selftests/bpf
> $ make -j90 # build selftests
>
> And that's it.

I've tried the same, modulo some paths. I'm pretty sure it's version
related at this point.
The current issue I'm seeing is "error: indirect call in function,
which are not supported by eBPF" when using GCC-BPF for
progs/bind4_prog.c

Currently using clang 16.0.0 and gcc 12.2.0-14.
I did manage to get it to build by just commenting out TEST_GEN_PROGS
+=3D test_progs-bpf_gcc
