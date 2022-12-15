Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793D164E262
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLOUd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLOUdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:33:54 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4171C12D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:33:53 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g7so270345lfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qqlXfGIzU/VNt4feEbI0o+f3b02zt3V3jQlCWIaHak=;
        b=ghojc+OzDLr88cTONimsYx13zSlU8yBoxGyDHdCA3Zs5HzhVUhXT1ZdOGnCdRKxTp+
         ibvguzA3sHLg4u60hUtR/+lU4VC5yUCKEU2YBTBl8wjdiY2xclHa7p2N+794gTdStd35
         +cwO5EFx+f0aOKBx1v+4hbHJIFR2uArNi3fJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qqlXfGIzU/VNt4feEbI0o+f3b02zt3V3jQlCWIaHak=;
        b=jlTURYvWIbamRW/0DUkU8Vp3vk0wSrUJNlhCJ94CpcqeByriZix6PslXO8iH69IO9V
         xn8hMReS6pDfhvc/5SiX1M0utTRen0yipukraCMFpM0wGQ+aKyAK3x07/YtkFgQBUhq4
         KDpML4qPdRq8xmkdOBRWY8ZYIT3SMMBZj5l0vFuRuESJxR3GQUND79xZJd9N/O83GX4R
         LEuhHBhU2uKSXJs5PDGJ84WLnpVsrUcJC+bYO/PrNmuq9FvI9x0rknL2+XUsdWAlcTbT
         y7lmL+B5hMhIrM7oatq3U0H5M1oalgSHST7izYb7hH237wwb177eDXwm02ROORl/qEen
         UVjw==
X-Gm-Message-State: ANoB5pnK4A1RacuRMJ1D3iLEBstr9ENPbacLolS+NYMB4aj9OJnNYh87
        ugqYz7iUAM4oxvJJpLJDtSm6vv7jtwuc1l7V12kYVQ==
X-Google-Smtp-Source: AA0mqf550WKtC84YH7YSU0aIML9lP/X0h56FM5X4YQztqAbrrSH+oCgfDzKKymm7ExPii8QF8BdTtQwkFI+mER59z5U=
X-Received: by 2002:a05:6512:224c:b0:4b5:ad89:8174 with SMTP id
 i12-20020a056512224c00b004b5ad898174mr2306563lfu.84.1671136431317; Thu, 15
 Dec 2022 12:33:51 -0800 (PST)
MIME-Version: 1.0
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <20221215165452.GA1957735@lothringen> <20221215170834.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTSW9kr3DsJm6hTQ0FfwVbVjzDa8=7H29+ysD10ZCbnHA@mail.gmail.com>
 <20221215195854.GL4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YSnwXA6Bn3Av3O0Tm=AnqKULGZJBA3Z7ZaLE814XABU6g@mail.gmail.com>
In-Reply-To: <CAEXW_YSnwXA6Bn3Av3O0Tm=AnqKULGZJBA3Z7ZaLE814XABU6g@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 15 Dec 2022 15:33:39 -0500
Message-ID: <CAEXW_YSGWgkesu7xz8HXVmH82=uN1ESUdPs2Qtkv4isNjGy-Ww@mail.gmail.com>
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check()
 comments
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 3:03 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Hi Paul,
>
> On Thu, Dec 15, 2022 at 2:58 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> [...]
> > > If the first read section's srcu_read_unlock() and its corresponding
> > > smp_mb()  happened before the flip, then the increment of old idx
> > > would happen only once. The next srcu_read_lock() will read the new
> > > index. If the srcu_read_unlock() and it's corresponding smp_mb()
> > > happened after the flip, the old_idx will be sampled again and can be
> > > incremented twice. So it depends on how the flip races with
> > > srcu_read_unlock().
> >
> > I do understand that a number of people like reasoning about
> > memory-barrier ordering, courtesy of the sequentially consistent portions
> > of the C and C++ memory models, but thinking in terms of the accesses
> > surrounding the memory barriers has been far less error-prone.
>
> Sure, but we are already talking in terms of the access to idx right?
> That's what we're saying is visible by memory barriers and we are
> trying to reason here about the ordering (flip does the write to idx
> and followed by smp_mb(), and there is corresponding read of idx on
> the srcu_read_lock() side. So we are indeed talking in terms of
> access, but let me know if I missed something.
>
> > > Also, since this is all hard to reason about I started making some
> > > diagrams, LOL. For your amusement, here is why need to scan both idx
> > > during grace period detection: https://i.imgur.com/jz4bNKd.png
> >
> > Nice!
> >
> > I suggest placing a gap between GP 2 and GP 3.  That way, you can make it
> > very clear that Reader 1's critical section starts after the end of GP 2
> > (thus clearly never blocking GP 2) and before GP 3 (thus possibly having
> > a reference to some data that is going to be freed at the end of GP 3).
> >
> > I also suggest coloring Reader 1 red and Reader 2 green, given that the
> > color red generally indicates danger.
>
> Thanks for these suggestions! I will make the update. I am planning to
> make a number of diagrams for other scenarios as well, as it helps
> visualize. Google drawing is nice for these. I am happy to share these
> with you all if there is interest :).

I made these updates, please see: https://i.imgur.com/hoKLvtt.png

Feel free to use the image for any purpose and thanks ;-)

 - Joel
