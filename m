Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9482C687C19
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjBBLVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBBLVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:21:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0B069B15
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 03:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675336854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9fG+mLi1sHTSjuOd5Ks82kJWa6WXxxrGWKTgpND0+ng=;
        b=GVSn030zh2s1XDtA6gmlST4omo3hoPXfyuI7d6JAyNYD1kaA3Cm8ibow0uU183OFvrKnvT
        ASqY+r1JecWskFjFaAYCeV0PZrmMa9albq/ybiY/nd0/Gy894JQEAxtV2zrAyr358DuKBi
        8yKMT9IKPcsjfz8/6K6aPke6PUNTokQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-19-Bgh-srgSOhy7bBkm9inaIw-1; Thu, 02 Feb 2023 06:20:53 -0500
X-MC-Unique: Bgh-srgSOhy7bBkm9inaIw-1
Received: by mail-pg1-f200.google.com with SMTP id bk2-20020a056a02028200b004a7e2a790d2so866873pgb.18
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 03:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fG+mLi1sHTSjuOd5Ks82kJWa6WXxxrGWKTgpND0+ng=;
        b=VV3TVGsZIwP0lkkBjujp8uU0CKqjkBT0ZKqkBRhVQpg+WTsiJgRc5toafJ8y8sS1Th
         nmjdvyv9CdI8st7F57C3D2POET3tHNzp1z3Rc345C1DuOAVP8VtskjX1pizpMhjhyNi2
         /TRACJWXknuXk7tkEqZpQSKA+YaBTcSUuQFKuzzgWnnopQQkYgTOjzmULJwFyOe8c6DZ
         K69rNlVhdzLQjcb4nek9NUmp2MKfsbZATzcc1x7fjZNqhKk0Wn1s5f9eMiCCDyHG5Vn2
         ZOtcpW0jkHytc/ZSxR03GfWhm1To6PIptTPskSZrwXGtXcKU3TcbEZ46FyhdBnI6tGHx
         YUfQ==
X-Gm-Message-State: AO0yUKUq4aAzpZkUhmssSvP+Qbuayoo6HxYrio2yYXmTnoJcAaSWxpZe
        0J3eeKLxuD4Ug6p9TYs5zdaW/tJvCjtJUskjMLmE1PEmsXO0jU9i/IZYdwH8EbwZC/Wat7f7zAx
        3Z+b7bIxG2t7ehoZNEXVoJmRr+OkdwwgCbebp3JO4
X-Received: by 2002:a17:90a:c254:b0:22c:5548:d7e5 with SMTP id d20-20020a17090ac25400b0022c5548d7e5mr521247pjx.27.1675336852286;
        Thu, 02 Feb 2023 03:20:52 -0800 (PST)
X-Google-Smtp-Source: AK7set82+wN39UJY3aGt0nV0PlH4EFUnLP8c4ca1tpS6HDyuJGTUC63XeRr8meu1LI3/H5oInHQ99YQUAAZkiPqy3yk=
X-Received: by 2002:a17:90a:c254:b0:22c:5548:d7e5 with SMTP id
 d20-20020a17090ac25400b0022c5548d7e5mr521244pjx.27.1675336852028; Thu, 02 Feb
 2023 03:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20230117172649.52465-1-wander@redhat.com> <875yd4k8qd.ffs@tglx>
 <CAAq0SUkN38V00HqV3Hk3ee_-=vfkKxG9xtR3n=4gAT+zCs+=Zg@mail.gmail.com>
 <87fsc6i6ud.ffs@tglx> <CAAq0SU=FmkSyS=-SQJBoHYEtZExK3Qn9Wqcn-c+BnmfVeO3q6g@mail.gmail.com>
 <20230131175350.s7eiz55fozlhaegh@fedora> <87k010zevz.ffs@tglx>
In-Reply-To: <87k010zevz.ffs@tglx>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Thu, 2 Feb 2023 08:20:40 -0300
Message-ID: <CAAq0SUkykcMBZqFpgM=KCZTpxWmD12eCWFZxk+AYNS8K_QBcnQ@mail.gmail.com>
Subject: Re: [PATCH] rtmutex: ensure we wake up the top waiter
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "open list:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 5:07 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Jan 31 2023 at 14:53, Wander Lairson Costa wrote:
> > On Tue, Jan 31, 2023 at 02:46:19PM -0300, Wander Lairson Costa wrote:
> >> > If you have traces which show the sequence of lock events leading to
> >> > this problem, then you should be able to decode the scenario. If you
> >> > fail to extract the information, then please provide the traces so we
> >> > can stare at them.
> >> >
> >>
> >> Here we go:
> >>
> >> Let L1 and L2 be two spinlocks.
> >>
> >> Let T1 be a task holding L1 and blocked on L2. T1, currently, is the top
> >> waiter of L2.
> >>
> >> Let T2 be the task holding L2.
> >>
> >> Let T3 be a task trying to acquire L1.
> >>
> >> The following events will lead to a state in which the wait queue of L2
> >> isn't empty but nobody holds it.
>
> That explains it nicely. Care to resend with proper explanations in the
> changelog?
>

Sure thing, thanks.

