Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A8C6F7D93
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjEEHON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjEEHOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:14:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D37D17DED
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 00:14:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaea3909d1so12942245ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683270844; x=1685862844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mNEbGlZsNmcj3zz4B24G7nWdw/7GrG+eSs3WE5Ht7g=;
        b=Djca4/jcZdXyVNOCiR3lHBGkqxrf6r6FZrbI1rzZUUzfuG4goQu9A487VEEGl8/8kL
         c9TuW7rrDkw9+2JAFfa21/HFaFmNhlyJgaNLwSmTsHnnIPrmt2Mj6EASbdEXaEUK8cLt
         Xc45jFn0jcdKFDjyk6vOTZb83Yh/FcpDbwStq4oJvac5Bh8jRwFJaFKwWZXxD/IA7Sdn
         AIU7N8i2ENl5xNPITe3dbWNn8MD5J/rwH1UylUCOEfqXTopGEVEKafFWHdHz8PICQdkw
         Y0g6gDE2bTjI3NlmzqCBxnljNZXw3NadvIvmaMHKKDqo0gToeMV9UIfs2PjhaFiZEIt6
         w7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683270844; x=1685862844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mNEbGlZsNmcj3zz4B24G7nWdw/7GrG+eSs3WE5Ht7g=;
        b=TRDzP7eN6VNFHwjvhSPrK1YOmUUo8FjLJI+Zal0YSWf26XVPPO7T5bFrLV8kjJrFgh
         Y2Fhl57GFYt9DxNOGp3DUe/h2NTO0IdXqWbKLaTIHA/OKERa8iG4ZIljNGPpVknK76RY
         xJsJuyPoRj+N0Z69ObrS8iAxJBBbtC52SkDrIsAiGd4QiGdUTpl8yD/38t2AVmR9pZQg
         kPFMuMHxH3oiVEw6mhlBuoj7AaltBvemCV1FlQ4lGt0ovDHyP4Taveeb0JXCvT0zLV+w
         Bi8BL94dSVYBUWQP2m4i5lXYY1+qp2BEuSXqHagko8ZC1SIFijjtSXqQrcivVm3J7Bgi
         9wQQ==
X-Gm-Message-State: AC+VfDy7dJAgBGsISgaItb144q3SyFUoNq4eaW/Ddw7N4/CTDnf4jGBJ
        8bGMUm6vXLfrb01tUs6aYzExtMs9w9IjBrIkbalJ6g==
X-Google-Smtp-Source: ACHHUZ7KLiz6rEDepEsMuriA67NNfkZBVLuFZXyAps0WAHbixYyYYXux6Ma6R5HzUIMJnSqYUU0Akd9hTL7XXA9Ri0Y=
X-Received: by 2002:a17:902:d483:b0:1ab:2a89:ed9d with SMTP id
 c3-20020a170902d48300b001ab2a89ed9dmr549944plg.10.1683270844385; Fri, 05 May
 2023 00:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230505060818.60037-1-zhoufeng.zf@bytedance.com> <20230505060818.60037-3-zhoufeng.zf@bytedance.com>
In-Reply-To: <20230505060818.60037-3-zhoufeng.zf@bytedance.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 5 May 2023 00:13:52 -0700
Message-ID: <CA+khW7hZb6EJcoXUzkvrHKztsQ_J4cN+RRQjF-a73A8zE8S_NA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: Add testcase for bpf_task_under_cgroup
To:     Feng zhou <zhoufeng.zf@bytedance.com>
Cc:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
        shuah@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, yangzhenze@bytedance.com,
        wangdongdong.6@bytedance.com
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

On Thu, May 4, 2023 at 11:08=E2=80=AFPM Feng zhou <zhoufeng.zf@bytedance.co=
m> wrote:
>
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>
> test_progs:
> Tests new kfunc bpf_task_under_cgroup().
>
> The bpf program saves the new task's pid within a given cgroup to
> the remote_pid, which is convenient for the user-mode program to
> verify the test correctness.
>
> The user-mode program creates its own mount namespace, and mounts the
> cgroupsv2 hierarchy in there, call the fork syscall, then check if
> remote_pid and local_pid are unequal.
>
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---

Hi Feng,

I have a comment about the methodology of the test, but the patch
looks ok to me. Why do we have to test via a tracing program? I think
what we need is just a task and a cgroup. Since we have the kfunc
bpf_task_from_pid() and bpf_cgroup_from_id(), we can write a syscall
program which takes a pid and a cgroup id as input and get the task
and cgroup objects directly in the program.

I like testing via a syscall program because it doesn't depend on the
newtask tracepoint and it should be simpler. But I'm ok with the
current version of the patch, just have some thoughts.

Hao
