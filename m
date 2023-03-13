Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D926B85F7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCMXR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCMXR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:17:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CCF7F01C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 16:17:26 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r11so3534012edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 16:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678749444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtlVwy8NXP7I/6i58PjTjIVyw7b7dT8JJCIKb9m/AVM=;
        b=M8EcihVdyxJCAVWsXbTzjmTEAXGmM/u7XQdZ/IhqUh3Xe9GfuGIgqyOlFG5mhOGgPc
         3QcCfhkLAMwueVzpMH/gj/EIam95V3Xr/LsKzVukKLz93770Mxf5T69lihI42bKk8OFs
         cXP55Yi4DR26Hp8L7G+1Y8GMENZVrJB3Org3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678749444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtlVwy8NXP7I/6i58PjTjIVyw7b7dT8JJCIKb9m/AVM=;
        b=wNy2hEiaStkSQvEU9qv0uvHVAestzKbbeYD7MXYv0Z0UkNckUA5R6DEwSlos1CKt1L
         WppFqi+Ejaa2+FW3fGeTs+c+f3/COB1OG2AeMfIKH+C8S9NhC9GHAyeUpA1vC5hccMPL
         70dgQoym5C7sIOIs5/3atzrHqK2gK26jZ6avS+kjygCZBHteLHyKqiJRPthSWGLOW7hW
         Ae5rXSM+vR0v6htttuPtHwpHHO5C5uO3SaZdspYqzS+5JWOfcD0heKr6BJ24eFjM0GqM
         k+MZ1NRzm0qzYar67GciT1Ua1kCD7YLfrxQcWUIZ7M1LmqzKVwUS8ujZthPcEWrEGJN/
         TXDQ==
X-Gm-Message-State: AO0yUKVFAsaIz8ivQzm0YNo+wP1p76ymtWLpuz6HAjfh57oSKZwjNe2I
        +6hAqjbENkBJbK1sUkO279RJmxwojwZ3u+iX4I/OYw==
X-Google-Smtp-Source: AK7set96Dtn7CWMnzUlY6UmnuRwDJ+SMMN5m3WcawWc/Ihco7YQjKq8cPlmY5b4fAHFn+NIVY/Wvpg==
X-Received: by 2002:a17:906:3986:b0:91f:32f9:82f0 with SMTP id h6-20020a170906398600b0091f32f982f0mr263548eje.29.1678749444347;
        Mon, 13 Mar 2023 16:17:24 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id m18-20020a17090679d200b008e204a57e70sm315512ejo.214.2023.03.13.16.17.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 16:17:23 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id ek18so24023112edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 16:17:23 -0700 (PDT)
X-Received: by 2002:a17:906:4096:b0:8de:c6a6:5134 with SMTP id
 u22-20020a170906409600b008dec6a65134mr105258ejj.15.1678749443449; Mon, 13 Mar
 2023 16:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com>
 <d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net> <CAHk-=wi8xQw6eTRncbJfWWYHHi0UBG2B_AfHrzZbPr=k0V_WYQ@mail.gmail.com>
 <ZA+ttVOPBvNOYHoC@lothringen>
In-Reply-To: <ZA+ttVOPBvNOYHoC@lothringen>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Mar 2023 16:17:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwQxk12jfe28DV4-1-d9np1hKFtTy-ua=F4EcT8jcOOA@mail.gmail.com>
Message-ID: <CAHk-=whwQxk12jfe28DV4-1-d9np1hKFtTy-ua=F4EcT8jcOOA@mail.gmail.com>
Subject: Re: Linux 6.3-rc2
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 4:11=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> So the hardirq interrupted some code that has softirqs disabled (or
> servicing) from the preempt mask POV but not from lockdep POV.

.. but those are two different counters, so isn't that *always* racy?
IOW, one counter being updated before the other...

IOW, isn't this *why* that check isn't supposed to ever trigger at all
from hard-irq context?

               Linus
