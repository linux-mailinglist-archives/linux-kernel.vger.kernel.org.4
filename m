Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B643566687D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 02:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbjALBix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 20:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjALBiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 20:38:50 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A9B40C29
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:38:49 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id p188so17077097yba.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvPtEwtZM9M8vhjcnDBhdGXaa7R7IpCHINyiVw91Tqw=;
        b=ew490uHSuUDb6IZiNj7J2omgVWofPd8fWgOYael7TpZBTXDtsHSAd1MktEsOv9faYX
         dk/AonZsRunyMpaJLLzXaM8J0rTiwnXf8VG29KNWe62a/gal2kTOWFjr0sequymp1DCY
         deryNvmfVbw3MfE8u6IwwSbV2nln5PFQpFtFcpyOWSMd9CXS/AKtS1p1YOGlfMpw79jP
         l5NkVrrTWEoDSakAg1zFF/4YwIyh4Rbq1+qoZZdl/j2jVgBkjX4nVsmfV9VLo3uChPQg
         JBL++ZZpMvU46kwYRyxClLlCAHYkOfjPCY0EBI0/s73cr3oKqru9ihboYjhKi2PyyHda
         So2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvPtEwtZM9M8vhjcnDBhdGXaa7R7IpCHINyiVw91Tqw=;
        b=rBM1RtDfB3vNDT9QTBozX+s+JcuQAWQJ0w8v7PX0tBWkYTrzp4yR+/K0kcUf+lxD65
         Jpi73KHJGXdU+4pi3AVYiTgCkgOEZFUgIO8qN/3QX/6MFMPU2cTk7Wg7vqgniZCTv5EN
         d7+VnZ87xC/tVddal5bqZPodWYc4DlTgL+splf36zElI5Jsfax2je2rROG3N7dKLaVSx
         OTDImfDD5t6Z94VmDGxIlWveklFxJHRpUDVzsLV4lqtBjtFvCawou76RGzww0ek0wlUV
         v1iNiJoNfMmw8m2wo09HvFCplp+tWEZijNEMWSpU+RfbPRRgqeQ6+jIG1W6dFwPOASq+
         ojSw==
X-Gm-Message-State: AFqh2kpP/avy+d55N2MH7x9xDuYWFpjjq6WKEZTKatLqiTjfi3rTeMdr
        ScnqtLT5pOb2nz7NkpprpYKD9suxwKAkOvCnAtFE5Q==
X-Google-Smtp-Source: AMrXdXvR3AqsbCqjGKXvVsjswPX5UqCPBEwDxqz1k68HMcWKzjDj13JnbxiAoe4wa4zNk7Y/0aKbvez2mpNXiWGJ/+s=
X-Received: by 2002:a05:6902:3cb:b0:6f7:dc52:d2cc with SMTP id
 g11-20020a05690203cb00b006f7dc52d2ccmr8940765ybs.292.1673487528875; Wed, 11
 Jan 2023 17:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20221214225123.2770216-1-yuanchu@google.com> <20230111141716.GA14685@blackbody.suse.cz>
In-Reply-To: <20230111141716.GA14685@blackbody.suse.cz>
From:   Yuanchu Xie <yuanchu@google.com>
Date:   Wed, 11 Jan 2023 17:38:37 -0800
Message-ID: <CAJj2-QHxcC3u49Boh7t0Z2tZfhrg_W5uLqBcMDYmukJra8D22Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] mm: multi-gen LRU: working set extensions
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
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

On Wed, Jan 11, 2023 at 6:17 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> On Wed, Dec 14, 2022 at 02:51:21PM -0800, Yuanchu Xie <yuanchu@google.com=
> wrote:
> > that's frequently used. The only missing pieces between MGLRU
> > generations and working set estimation are a consistent aging cadence
> > and an interface; we introduce the two additions.
> >
> > Periodic aging
> > =3D=3D=3D=3D=3D=3D
> > MGLRU Aging is currently driven by reclaim, so the amount of time
> > between generations is non-deterministic. With memcgs being aged
> > regularly, MGLRU generations become time-based working set information.
>
> Is this periodic aging specific to memcgs? IOW, periodic aging isn't
> needed without memcgs (~with root only)
> (Perhaps similar question to Aneeh's.)
Originally, I didn't see much value in periodic aging without memcgs,
as the main goal was to provide working set information.
Periodic aging might lead to MGLRU making better reclaim decisions,
but I don't have any benchmarks to back it up right now.

>
> > Use case: proactive reclaimer
> > =3D=3D=3D=3D=3D=3D
> > The proactive reclaimer sets the aging interval, and periodically reads
> > the page idle age stats, forming a working set estimation, which it the=
n
> > calculates an amount to write to memory.reclaim.
> >
> > With the page idle age stats, a proactive reclaimer could calculate a
> > precise amount of memory to reclaim without continuously probing and
> > inducing reclaim.
>
> Could the aging be also made per-memcg? (Similar to memory.reclaim,
> possibly without the new kthread (if global reclaim's aging is enough).)
It is possible. We can have hierarchical aging, invoked by writing to
memory.aging with a time duration. For every child memcg, if its young
generation is older than (current time - specified duration), do
aging.
However, now we need a userspace tool to drive the aging, invoking
this interface every few seconds, since every memcg is aged at a
different cadence.
Having a kthread perform aging has the benefit of simplicity, gives a
source of truth for the aging interval, and makes the feature more
accessible. The application developers, if they want to take a look at
the page idle age stats, could do so without needing additional
ceremony.

Thanks,
Yuanchu
