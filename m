Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB4B72099C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 21:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbjFBTPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 15:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236219AbjFBTPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 15:15:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DE11BC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 12:15:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-97454836448so251773566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 12:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685733304; x=1688325304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+zVaic1GYalhazjonwvqWVXcN3YQJs5sFWND9LHSfk=;
        b=Pj/77ddPJUp8RnziITQUQC9CUJWdzIBNHUj/0ISSuJWXChzcHQcFLki4m75O0VUkYe
         KRUGWENDQDpJJBIhcMnEMftJLi64dIpzIg8MCMlUSxW+77l8X7x2CqsXWe6UkqDu04vE
         lCDug+HBs/Gssm1dy0XmFMkWFrcK/MN2oJVdFEf0Yo0mkyaQGypsk2Ojhn3J44Abx+vd
         lvldOpS4ECrlpr/JOKnLSJjfQ0tk8AZPWrBu0MaOWdRk6EG7M5aH9zAPvKiQKT2yOT7s
         RNVKoRcETgVATY0dJCyTwWUlS4wUS/nnz9f+8D2oA88pUBrF8dVlSMRBrgHHjVHBSaCj
         usPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685733304; x=1688325304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+zVaic1GYalhazjonwvqWVXcN3YQJs5sFWND9LHSfk=;
        b=XBR9caRmx8bSou4g66Wrr3A6vFqlfJ5AKX7HCkh1z6J1Beckr4TwRT/SQqRU2vtyr3
         fm7zvcLieIgju7BjnB7DcHftBlvgLdwonheLRIuivS6E/bQyHm65Q8PTb85eUgLAFA9v
         k2mvTuwcx407oNJiWqUHstgQfoE+d79o0xCyzUho1ItfTszLXTkWKioEXGaqsIxgjuyr
         b0gFCCTvJRn4wzQlLq05Vf2lehpZgoB/A1hbITwXhnbL0m/VGibHEK9aF67vevlxk6kZ
         YHSK8OqRfzEKGqsYc8IwfLX1y3BlaMfqi2XDoat3Fxr61G2idvHwYK8WpfDIDpw92RRQ
         MjFA==
X-Gm-Message-State: AC+VfDzL/y9iqoq23OzT0yYzNfl73dhI2qo6f8kvZ0ZIi8cTJ7nQKpMQ
        YyIcJjSSfBMepIJbP5T7FYKrCEc1Hdq+vbikGlQGCw==
X-Google-Smtp-Source: ACHHUZ5GhQmLbiAwNrcosHlfPpauuzT/+C4BkkZPnDvcqmorJVVRBA6VXsS1wBSS+WpvKAPjBH/4xCxiu+kXML25pEg=
X-Received: by 2002:a17:907:1c82:b0:976:8fdd:9046 with SMTP id
 nb2-20020a1709071c8200b009768fdd9046mr711987ejc.12.1685733304541; Fri, 02 Jun
 2023 12:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230531022911.1168524-1-yosryahmed@google.com>
 <20230601155825.GF102494@cmpxchg.org> <CAJD7tkaFSfpTtB_ua_9QzR2voE1-hixv6RMJZd=WqpGmY93dSw@mail.gmail.com>
 <20230602164942.GA215355@cmpxchg.org> <CAJD7tkbp96S8MdrcH8y0V2G5Q-Zq6U4DAuweYhP-MjUWgcmjsQ@mail.gmail.com>
 <20230602183410.GB215355@cmpxchg.org>
In-Reply-To: <20230602183410.GB215355@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 2 Jun 2023 12:14:28 -0700
Message-ID: <CAJD7tka18Vw7HpA1gh6wWJcaCJ_U6jNfCC696pX=UkbiXKZMvQ@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: multiple zpool support
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Fri, Jun 2, 2023 at 11:34=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Fri, Jun 02, 2023 at 09:59:20AM -0700, Yosry Ahmed wrote:
> > On Fri, Jun 2, 2023 at 9:49=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.=
org> wrote:
> > > Again, what about the zswap_tree.lock and swap_info_struct.lock?
> > > They're the same scope unless you use multiple swap files. Would it
> > > make sense to tie pools to trees, so that using multiple swapfiles fo=
r
> > > concurrency purposes also implies this optimization?
> >
> > Yeah, using multiple swapfiles helps with those locks, but it doesn't
> > help with the zpool lock.
> >
> > I am reluctant to take this path because I am trying to get rid of
> > zswap's dependency on swapfiles to begin with, and have it act as its
> > own standalone swapping backend. If I am successful, then having one
> > zpool per zswap_tree is just a temporary fix.
>
> What about making the pools per-cpu?
>
> This would scale nicely with the machine size. And we commonly deal
> with for_each_cpu() loops and per-cpu data structures, so have good
> developer intuition about what's reasonable to squeeze into those.
>
> It would eliminate the lock contention, for everybody, right away, and
> without asking questions.
>
> It would open the door to all kinds of locking optimizations on top.

The page can get swapped out on one cpu and swapped in on another, no?

We will need to store which zpool the page is stored in in its zswap
entry, and potentially grab percpu locks from other cpus in the swap
in path. The lock contention would probably be less, but certainly not
eliminated.

Did I misunderstand?
