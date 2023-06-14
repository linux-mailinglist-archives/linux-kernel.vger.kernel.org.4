Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BB072A1AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjFIRyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjFIRyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:54:09 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26DC35B5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:54:02 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f98276f89cso13141cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 10:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686333242; x=1688925242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80A8FjuVOOa9xV5urorcQcKqtLHX/x3yj6q554YpmN4=;
        b=3aDAkRb3lc+9oQjqGBI7DxxQhUAZCXyJz4umZdc4T+QCL+WhlmT6IcVLQeZPvpuc1t
         WaMCCTXRNkd48dRGNKGZEyL3tawhP6gy7GZ/+mPabZRJ3ySOkh6qKrqMQU+9R2JSghhR
         dMi9fNhDt+RgOePLbLSV32bwAdP1jAaW1MU5HJwdU/m9ss40PrWSVoklPyaec+qBNwwy
         Ms+Eh1bui8+GG4xojnc/FFU18ZLKSBkS/7ywj8Tt5cWDQ5TF9MmwrGqNc/CtWDCgD5Jy
         k1YFAWQYH2r9Yj8cnmBMYIc3RV/2HP2lIoMdSHUYdbCW5r/DjAPhCqjvIoRpkaw7fJrB
         T36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686333242; x=1688925242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80A8FjuVOOa9xV5urorcQcKqtLHX/x3yj6q554YpmN4=;
        b=IttH77dCdaeYirEfden+guEcDfo4WXSVBtATKUwdLsbCZdZV3i6yrazSVz8sEm32Mz
         GY6kdRXMBHbeFHRxUrEa9xG9m5ug+lBX4apO+4MIRhjRZ4RyzB5z+SX2ba05NAXr6O9Z
         cP3MIwRhYsUgIByKUcUpSkHx7LoeV4r9k/H5sn6x8h5ofxyG2XfBJ0VWU+6Z/l/lvCb+
         KowHzcr3fhThWXYr+Hue2koDFLLXhQuNmMANZ6Lc2ewzcGtJ6TyMzlb9oec4FLUFk7dt
         jfxrbcyLhT+DdAK+VJdC1LPvotxgQWBU4LUAPoBMTjXc+KJcQ/hgWPW+CZx10oOHwHu1
         l1jg==
X-Gm-Message-State: AC+VfDyamUX1WZ6Q2Q5tFvcBiOaB6QegmntIj8/m/rGiNuIfxlSs51+s
        ka9xopadyQrzVqB/nVymLtKj6/E4/mbT9bFzMyUtgA==
X-Google-Smtp-Source: ACHHUZ7wpAp4kNm4XE+nmsNmT+6iKQaK3dMunm88OVGoM6QMdbZslAcsNjcQkvXXaVHYApeSLPpZAD6e/s+V0TxCxxU=
X-Received: by 2002:ac8:5b04:0:b0:3e3:8c75:461 with SMTP id
 m4-20020ac85b04000000b003e38c750461mr368917qtw.6.1686333241816; Fri, 09 Jun
 2023 10:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230609082712.34889-1-wuyun.abel@bytedance.com> <CANn89i+Qqq5nV0oRLh_KEHRV6VmSbS5PsSvayVHBi52FbB=sKA@mail.gmail.com>
In-Reply-To: <CANn89i+Qqq5nV0oRLh_KEHRV6VmSbS5PsSvayVHBi52FbB=sKA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 9 Jun 2023 22:53:50 +0500
Message-ID: <CALvZod4BuY=kHnQov6Ho+UT0_0oG6nEX1Z-pU-f4Yt9w7-=5Hg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] sock: Propose socket.urgent for sockmem isolation
To:     Eric Dumazet <edumazet@google.com>
Cc:     Abel Wu <wuyun.abel@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Christian Warloe <cwarloe@google.com>,
        Wei Wang <weiwan@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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

On Fri, Jun 9, 2023 at 2:07=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Jun 9, 2023 at 10:28=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com=
> wrote:
> >
> > This is just a PoC patch intended to resume the discussion about
> > tcpmem isolation opened by Google in LPC'22 [1].
> >
> > We are facing the same problem that the global shared threshold can
> > cause isolation issues. Low priority jobs can hog TCP memory and
> > adversely impact higher priority jobs. What's worse is that these
> > low priority jobs usually have smaller cpu weights leading to poor
> > ability to consume rx data.
> >
> > To tackle this problem, an interface for non-root cgroup memory
> > controller named 'socket.urgent' is proposed. It determines whether
> > the sockets of this cgroup and its descendants can escape from the
> > constrains or not under global socket memory pressure.
> >
> > The 'urgent' semantics will not take effect under memcg pressure in
> > order to protect against worse memstalls, thus will be the same as
> > before without this patch.
> >
> > This proposal doesn't remove protocal's threshold as we found it
> > useful in restraining memory defragment. As aforementioned the low
> > priority jobs can hog lots of memory, which is unreclaimable and
> > unmovable, for some time due to small cpu weight.
> >
> > So in practice we allow high priority jobs with net-memcg accounting
> > enabled to escape the global constrains if the net-memcg itselt is
> > not under pressure. While for lower priority jobs, the budget will
> > be tightened as the memory usage of 'urgent' jobs increases. In this
> > way we can finally achieve:
> >
> >   - Important jobs won't be priority inversed by the background
> >     jobs in terms of socket memory pressure/limit.
> >
> >   - Global constrains are still effective, but only on non-urgent
> >     jobs, useful for admins on policy decision on defrag.
> >
> > Comments/Ideas are welcomed, thanks!
> >
>
> This seems to go in a complete opposite direction than memcg promises.
>
> Can we fix memcg, so that :
>
> Each group can use the memory it was provisioned (this includes TCP buffe=
rs)
>
> Global tcp_memory can disappear (set tcp_mem to infinity)

I agree with Eric and this is exactly how we at Google overcome the
isolation issue. We have set tcp_mem to unlimited and enabled memcg
accounting of network memory (by surgically incorporating v2 semantics
of network memory accounting in our v1 environment).

I do have one question though:

> This proposal doesn't remove protocal's threshold as we found it
> useful in restraining memory defragment.

Can you explain how you find the global tcp limit useful? What does
memory defragment mean?
