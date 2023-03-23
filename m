Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6C76C6CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCWQBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCWQBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:01:52 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ABE2E0FB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:01:50 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y4so88915666edo.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679587309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTWMwAKhcBWTOZZjhXh8n/JlmrY7tCK7IC8lep3UpDs=;
        b=MOKQDwxr/deUL4llWSGhblhVEo9WcWB8efRLUE2dc0/j/VRqv9bfW7mrppwQxxgW5/
         tkBhmPc2q+ri9+Bv9s4HE1ypBchPI41TQJZklkyPM5Q6PZGpWEfKqozM+UTPGQQJE0dM
         hJxqGnb+d2+KlRMAUvMO8LiGIBEeAtLWMEoXFNt8F4/jnSiPtWtQD6m19Wr8h/VOWnzd
         8/xfKDTgIMwacD63eX1ewPzVWyQaygjPDTysXqZ5QUBHWAg+Pc4Q/l1gT3Kja+vh6XdT
         ZKyu/0YKEgAds7xfT+9+aomHkoK1r0md0ZyzBUSwzUwg/Ha4/tOPzpEAi28hh7nmSQNC
         hOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679587309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTWMwAKhcBWTOZZjhXh8n/JlmrY7tCK7IC8lep3UpDs=;
        b=gdjY0vAoCCEi88sxQ2OjDFA/PyCTurFJzRX/iaUvpQQYrqzQGB0oPvTaosxxeIc2TD
         TV79oJQEkgOGd1x8/g5cwT/PuNZcGQn9t20R9m1qd/oycpg5CZtTp8IlLpjCGpvku7N1
         RNrfCVL+PtqbkEUXjrafYnQFcNgZ0AhLZ/B42GkhR5UrChqzNgMeXIsdQbrNEOlcn7f5
         Whx4gJgCEYCGOuS9CO4sUBqVUMJFL46c5J5XEIPUTDz75X6os2NUv82tEUZHQ5fzKr85
         qvJuW9frfG8AbiYIKi1IbmCNp9xiJE53uEJN/5HJbWdxVf1J6AThyr4fZpMuy8EL5nJ1
         ZaQQ==
X-Gm-Message-State: AO0yUKXm5FZrkjv76/STCliOOeJx6rHZRrz7+8zLnBfd0OaWslxfZVIu
        N48PuAlHzgNxrtPUfXnUVpMApyRSeD5bhXHugDTiQA==
X-Google-Smtp-Source: AK7set9zkfda4o4m4oylMF4e69t1Blxy/92fEEEYypkDAo8tfXPW4fXGirHEAt4hm6OeEPl00/UwlGGonUDdlBqlsU0=
X-Received: by 2002:a50:cd91:0:b0:4fa:60b6:ab98 with SMTP id
 p17-20020a50cd91000000b004fa60b6ab98mr5421036edi.8.1679587309028; Thu, 23 Mar
 2023 09:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-5-yosryahmed@google.com> <20230323155613.GC739026@cmpxchg.org>
In-Reply-To: <20230323155613.GC739026@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 23 Mar 2023 09:01:12 -0700
Message-ID: <CAJD7tkZ7Dz9myftc9bg7jhiaOYcn7qJ+V4sxZ_2kfnb+k=zhJQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] memcg: sleep during flushing stats in safe contexts
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 8:56=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Mar 23, 2023 at 04:00:34AM +0000, Yosry Ahmed wrote:
> > @@ -644,26 +644,26 @@ static void __mem_cgroup_flush_stats(void)
> >               return;
> >
> >       flush_next_time =3D jiffies_64 + 2*FLUSH_TIME;
> > -     cgroup_rstat_flush(root_mem_cgroup->css.cgroup, false);
> > +     cgroup_rstat_flush(root_mem_cgroup->css.cgroup, may_sleep);
>
> How is it safe to call this with may_sleep=3Dtrue when it's holding the
> stats_flush_lock?

stats_flush_lock is always called with trylock, it is only used today
so that we can skip flushing if another cpu is already doing a flush
(which is not 100% correct as they may have not finished flushing yet,
but that's orthogonal here). So I think it should be safe to sleep as
no one can be blocked waiting for this spinlock.

Perhaps it would be better semantically to replace the spinlock with
an atomic test and set, instead of having a lock that can only be used
with trylock?

>
> >       atomic_set(&stats_flush_threshold, 0);
> >       spin_unlock(&stats_flush_lock);
> >  }
