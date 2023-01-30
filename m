Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C0A68080B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbjA3JAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbjA3JAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:00:37 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5771027997
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:00:35 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id e16so11887633ljn.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o4goC00EkIWkDaKtqyTtWFudz4ow776Co421veWBFv8=;
        b=qKnRdRbm8dxI2wYdKscZL7nk3i6L07fv+KvkcY2LKUV3CTM15qQAWPDH6FnM5mt0Kq
         qWx3HTNjo9AQmx+fmI7j699It4/oEHCBzlrxa7cByjMV9M7oWwJprB/BY8OmMD8/wLP/
         tZv8mz3q/wtdG3DXDfSoRDHmndegR0ImdoGTa7IBXIh92Ll2PV8GyqZoQ5o8g6gc5We/
         kddHCp2vB5SbVXJEcYkjDGZmAZyDI8b00LaRpOt2FAVSaOyq1VZvNRZqZ8HRAO5wI7OE
         th47rCAB9WoZc0y/CuU62DJw4/1Z54bJnx1tS6ixnhO5fSZ/wW62Weyb76LpGrDt9/fi
         2/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4goC00EkIWkDaKtqyTtWFudz4ow776Co421veWBFv8=;
        b=UrJzmU87TIaUSXTFigMJ+Xmpf5gGumLRZp12WvGLWMmhxSpYLqL45gh6EKOy5LUZkt
         MfLYeQxTrVjdly72MmttFYARk54U0AJVZlhDj2IdU1ikHSfFeYTsX5pMq362WWuY0SDI
         6Xc111k5Vb66c5vwHhYu+/EMJgtCcoSbV3IOSLvm49wPNu/RVqskLgJ1oRI8SRMU2lyL
         wWejvbllymitI951WO3a+LMa8zmuLfymYDJBt6VnDpRnfDZCfdjKrK65TirgK+Jk0RoL
         HSdsvcenKcMTemU1CSQwri9ZhTlU934QdMV95jMea4f5jfsFYq9tz9vuRp3pTcaZ38xh
         /pjw==
X-Gm-Message-State: AO0yUKVTqGMOJ8MQtNDEJGzeagyP8l50Fkr+bYunQPPXnY3w28A8lYTY
        7SHjup26xTM7rpg3VxFcILwIiceoOXzBj8w5AdQ5F7S3TJCn9do4vBQ=
X-Google-Smtp-Source: AK7set+Zb71Wk5u4TfLX15p388KImys4JbPqG9R3g5B6u0SIzNYdGG+M38gtVlxrqfWlktiK7bET4R69oG79Htx+k0M=
X-Received: by 2002:a2e:aa14:0:b0:28f:81a2:6eb with SMTP id
 bf20-20020a2eaa14000000b0028f81a206ebmr1307259ljb.118.1675069233468; Mon, 30
 Jan 2023 01:00:33 -0800 (PST)
MIME-Version: 1.0
References: <20230126105128.2249938-1-dvyukov@google.com> <20230126154118.2393850-1-dvyukov@google.com>
 <CANpmjNM=PVigDZKu-H_-cLECUJKSx7TH+kxSjfF=4UHdrGBj+g@mail.gmail.com>
 <87o7qlgjce.ffs@tglx> <CACT4Y+aMLeCo9+nwXrFWo8FLG8rKHDe8v2ppkZ+mOaKAF6qtgw@mail.gmail.com>
 <20230128195641.GA14906@redhat.com>
In-Reply-To: <20230128195641.GA14906@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 30 Jan 2023 10:00:20 +0100
Message-ID: <CACT4Y+YzTK8+gKm9pZ1hwGvaN-ExmVLuxZYKVia+dnakv6+b5A@mail.gmail.com>
Subject: Re: [PATCH v4] posix-timers: Prefer delivery of signals to the
 current thread
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 28 Jan 2023 at 20:56, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Dmitry,
>
> I agree with what you said, just one note...
>
> On 01/27, Dmitry Vyukov wrote:
> >
> > After this change the test passes quickly (within a second for me).
>
> yet perhaps it makes sense to slightly change it? It does
>
>         +static void *distribution_thr(void *arg) {
>         +       while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
>         +       return NULL;
>         +}
>
> so distribution_thr() eats CPU even after this thread gets a signal and thus
> (in theory) it can "steal" cpu_timer_fire() from other threads unpredictably
> long ? How about
>
>         -       while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
>         +       while (__atomic_load_n(&got_signal, __ATOMIC_RELAXED));
> ?

But why?
IIUC this makes the test even "weaker". As Thomas notes it's already
somewhat "weak". And this would make it even "weaker". So if it passes
in the current version, I would keep it as is. It makes sense to relax
it only if it's known to fail sometimes. But it doesn't fail as far as
I know. And the intention is really that the current version must pass
-- all threads must get signals even if other threads are running.
