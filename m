Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796E46B8056
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjCMSWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCMSWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:22:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAD78092C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:22:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id k10so52253764edk.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678731722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqn/Obws/mvOXsirsuPduJgSRZ2tDsmdmCKpoj+0Jvg=;
        b=M5j7IdC55FRJSAuH7unc6HEH6Id1gYzCYt6KOAuwp74OcmSkJmGXP0fvqe9OojSt53
         bxBr2gwO+yY3MhnBrpbJw/UEGzWX9+24oqiymg7of7MKdFIQ6KHjEOOboQ4rmz0X92zL
         xJWe2WjnlcM2B13RuYh9K+QPoesU7yqDKp/+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678731722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqn/Obws/mvOXsirsuPduJgSRZ2tDsmdmCKpoj+0Jvg=;
        b=aWZq8mLas4GPyAA2vLQ9sSU7oigO8MQ33mFzMfSWW9n3+EJyQiAwXWz0qZMhrbRZt8
         rbIcsZwvqlliUyjYgxK7pUjIsUBJxn2b8F7SfqZw2AicCjDGvZbT+stbzBphmA32wbIZ
         JxX49wUoZW1e/HCa3gzsN+V7Um7EYIGSsfGoVW4g9uYghRoCfmn+vhtG9ZRADn0JhMZz
         A4iLYawhZYcJ1LI+Ir4RKAdDaFBEOfmYUX5Ot2/FRa0u72ZADNlNIhHJIXKilHpw9/d1
         QIlt9v4ajL8g18cr7+ehYYwTk/D+q+oUnET46X4etiWLMk2NN++bS8EC413aJCk6oHXi
         q3/A==
X-Gm-Message-State: AO0yUKXeaRkrgYTAViLey3XaFsTSOA9HJAwGCHQEPMWRaDLiqg+vKf+T
        2eoOuq95On4TXWQvfKq7r1s97sayzjjzdwzMyQoFuQ==
X-Google-Smtp-Source: AK7set/InrORxt8fBWO44OxJb9OMFP1GS+kji0EXmxXzcT5kWohPyABDqBN1jVhuWPXU2XBedoVgXQ==
X-Received: by 2002:a05:6402:1613:b0:4fa:c17d:8fdd with SMTP id f19-20020a056402161300b004fac17d8fddmr7311454edv.34.1678731722589;
        Mon, 13 Mar 2023 11:22:02 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id h3-20020a056402280300b004d8287c775fsm116484ede.8.2023.03.13.11.22.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 11:22:02 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id r11so749768edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:22:01 -0700 (PDT)
X-Received: by 2002:a50:d543:0:b0:4af:6e08:30c with SMTP id
 f3-20020a50d543000000b004af6e08030cmr6164365edj.4.1678731721582; Mon, 13 Mar
 2023 11:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com>
 <d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net>
In-Reply-To: <d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Mar 2023 11:21:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi8xQw6eTRncbJfWWYHHi0UBG2B_AfHrzZbPr=k0V_WYQ@mail.gmail.com>
Message-ID: <CAHk-=wi8xQw6eTRncbJfWWYHHi0UBG2B_AfHrzZbPr=k0V_WYQ@mail.gmail.com>
Subject: Re: Linux 6.3-rc2
To:     Guenter Roeck <linux@roeck-us.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Mar 13, 2023 at 8:53=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Warning backtraces in calls from ct_nmi_enter(),
> seen randomly.

Hmm.

I suspect this one is a bug in the warning, not in the kernel,
although I have no idea why it would have started happening now.

This happens from an irq event, but that check is not *supposed* to
happen at all from interrupts:

         * We dont accurately track softirq state in e.g.
         * hardirq contexts (such as on 4KSTACKS), so only
         * check if not in hardirq contexts:

but I think that the ct_nmi_enter() function was called before the
hardirq count had even been incremented.

> Sample decoded stack trace:

Hmm. That WARNING backtrace doesn't actually seem to follow the stack
chain, so it only shows the irq stack, not where the irq happened.

> Seen if CONFIG_DEBUG_LOCK_ALLOC=3Dy and CONFIG_CONTEXT_TRACKING_IDLE=3Dy.
> It seems that rcu_read_lock_sched_held() can be true when entering an int=
errupt.
>
> The problem is not seen in v6.2, but occurs randomly on ToT with various
> arm emulations.

Strange. I must be wrong about this being a race on the warning
itself, because that warning has been there for a long long time.

Adding in some people who might have more of a clue. I'm thinking
Frederic and Paul might know what's up with the context tracking, but
I don't see why this would be arm-related or have started recently.
But I do note that PeterZ did some rcuidle tracing cleanups that do
end up affecting arm too.

So adding PeterZ too.

Original email with full details at

   https://lore.kernel.org/lkml/d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-=
us.net/

for added peeps.

Anybody?

                     Linus
