Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B31729468
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241250AbjFIJMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241436AbjFIJMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:12:22 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE5449EA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:07:59 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-33d928a268eso244165ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 02:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686301639; x=1688893639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVqqNiTWipF9tqQGIXfWiYHdhPZGr5sY95HAiAKaa/c=;
        b=hCpzPeWKrNa3kekE9t5+6tDGSGcCQNB3zp8QEUHG4S9aAMvfBGhQ4PfM93rGsuXPFa
         XAdMHbYGoAgMHUdP7C86X3/YC5WBNHcO+tYLDQ7WJRH3KHMLAhAPceHEz5V+7a0eNz8n
         6BdC2h3I6c52v+lOoNNkqwgFIRxI4y27BpE5+EQ5P94dTP6vMSPoEzHQ766ExdYHZyCe
         bWLvSKay1lJ71VzY0BYjxm0cgMMSDA5XA4F8DOYu6EbSlK4V1KEpgo0701dPY9IADLJR
         imqcGAwsIwdrHTunYAFWuUgoUTl9bxSM7r7RNzf7zJJvpJRLUZXM/8Sz3/X1hRhSW5jD
         GJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686301639; x=1688893639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVqqNiTWipF9tqQGIXfWiYHdhPZGr5sY95HAiAKaa/c=;
        b=KR6Dr80aU8FJh3BLQ/2sZmKQfkPVsz5ccoZkrr+w2Yy04h7WII1yD9/EYwdOuQ/eg1
         9lwvfttJ6r/uYXycxm1NWcGeBHI8NQTI2G7fLFQazu+CcU7zNIt8K8fd4m9R1Xq5AkHO
         /efxIOOaCooOp6Tucn26pmnJ8NFyysJqRhfL6fa+/87w5DXox1BcB6jlnBFTpXeNYcZW
         TjEC4L70fJIQNq0kpCKk+VmP8dAg6gWz4EJyohknowCRb7u5kF/WfKq2YuySDTo8a7Dm
         k25LZnNqGFHgWqC/dWc4UB/HcI6elQJbRPsa7nGUca7S2wzfnk7iyTHh5ZjnzahJXkRi
         desw==
X-Gm-Message-State: AC+VfDzy+wFHdN92rhBB5kEw+DwfgARuUWxL/u2yCRCwjeW/KSD+qUJh
        /7dVYyCbAcWxin2ufgXmhOdulHEAiNMws/txk3CzAg==
X-Google-Smtp-Source: ACHHUZ5vmT2eOAYEGZtWaf9C1WLVOXwyQP5WUv2+r5yCqWBKuOI1tIBVQM0GgqzsQe0OOAWiCe5U+vDQbastTKW7LbQ=
X-Received: by 2002:a05:6e02:1b01:b0:33d:ac65:f95e with SMTP id
 i1-20020a056e021b0100b0033dac65f95emr341983ilv.12.1686301639383; Fri, 09 Jun
 2023 02:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230609082712.34889-1-wuyun.abel@bytedance.com>
In-Reply-To: <20230609082712.34889-1-wuyun.abel@bytedance.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 9 Jun 2023 11:07:05 +0200
Message-ID: <CANn89i+Qqq5nV0oRLh_KEHRV6VmSbS5PsSvayVHBi52FbB=sKA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] sock: Propose socket.urgent for sockmem isolation
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Tejun Heo <tj@kernel.org>, Christian Warloe <cwarloe@google.com>,
        Wei Wang <weiwan@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Xin Long <lucien.xin@gmail.com>,
        Jason Xing <kernelxing@tencent.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 10:28=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> This is just a PoC patch intended to resume the discussion about
> tcpmem isolation opened by Google in LPC'22 [1].
>
> We are facing the same problem that the global shared threshold can
> cause isolation issues. Low priority jobs can hog TCP memory and
> adversely impact higher priority jobs. What's worse is that these
> low priority jobs usually have smaller cpu weights leading to poor
> ability to consume rx data.
>
> To tackle this problem, an interface for non-root cgroup memory
> controller named 'socket.urgent' is proposed. It determines whether
> the sockets of this cgroup and its descendants can escape from the
> constrains or not under global socket memory pressure.
>
> The 'urgent' semantics will not take effect under memcg pressure in
> order to protect against worse memstalls, thus will be the same as
> before without this patch.
>
> This proposal doesn't remove protocal's threshold as we found it
> useful in restraining memory defragment. As aforementioned the low
> priority jobs can hog lots of memory, which is unreclaimable and
> unmovable, for some time due to small cpu weight.
>
> So in practice we allow high priority jobs with net-memcg accounting
> enabled to escape the global constrains if the net-memcg itselt is
> not under pressure. While for lower priority jobs, the budget will
> be tightened as the memory usage of 'urgent' jobs increases. In this
> way we can finally achieve:
>
>   - Important jobs won't be priority inversed by the background
>     jobs in terms of socket memory pressure/limit.
>
>   - Global constrains are still effective, but only on non-urgent
>     jobs, useful for admins on policy decision on defrag.
>
> Comments/Ideas are welcomed, thanks!
>

This seems to go in a complete opposite direction than memcg promises.

Can we fix memcg, so that :

Each group can use the memory it was provisioned (this includes TCP buffers=
)

Global tcp_memory can disappear (set tcp_mem to infinity)
