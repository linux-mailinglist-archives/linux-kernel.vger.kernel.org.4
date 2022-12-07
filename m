Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60AF646193
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLGTXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiLGTXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:23:30 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E072063D5C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:23:29 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id h16so16987016qtu.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 11:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bqmkicGOJ5e//ce4kCmYG53j4OuPG6YbSgOOMs5e4gM=;
        b=UCSMmQXIFyjNhYU7ewN//lzdYz1bZ/AW74FjJo6u4vWsyXAb5sEgYSepzBxCKxXK8M
         r0EP59OVzR9xyZYDPgtcsf/NWMSwYCzKWC5JZqzxQPwd+NycjK6+8vhdk1V+Mtg6WbwC
         7Yw8RuycTo1ojdg+AUQ8/nZuCRRvBbQ9EIbB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqmkicGOJ5e//ce4kCmYG53j4OuPG6YbSgOOMs5e4gM=;
        b=At1k2aqfPf1NwPIkw2wVXIDsv+TyNqZF6wXqXnTzrhwnLo1Q9+OegpoKdS59U8kh0Y
         dQyio3oigRJwlBnJQglEVEZ/DhaK6jZWL32R/cHVAttLp9Ey7AqmA1GKeD1sMGa3QYTi
         8sZGVKIqGDB8F7MOqL7FSkfMUORS0iGaqSLHQo2aOPOU7TAtM99/RYpZ1msdF9glSFnR
         de/c6bkzxlzb4GbfLlMaHPYa3bMaOiFXyZHRyP+Swe0oCqqoMq07OYF1niQBhalHj/AZ
         LsXICG3jDNMQjOUuDdq/P0MdM8yxNSWWD8+2wnLCoXh91TPSgqC9CnSo7Y9hPGf2stDw
         43NQ==
X-Gm-Message-State: ANoB5plLCAGyz9VgXEG6kzojpD+TbB1A4SrCecbRmUNRilYvL/8S8EAG
        iRFJOizF1/DuMiV9SyG2upbdXL6uAsXkNnwR
X-Google-Smtp-Source: AA0mqf50oLkyhw9px+92URRQvGAN37lXrkqNCEuqbgJ7iLi+15U9GD4c1EaH7aGSXw9lGLFnwUKDSw==
X-Received: by 2002:a05:622a:2283:b0:3a5:943b:8441 with SMTP id ay3-20020a05622a228300b003a5943b8441mr86107173qtb.90.1670441008686;
        Wed, 07 Dec 2022 11:23:28 -0800 (PST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id r26-20020ac867da000000b003a5689134afsm13965790qtp.36.2022.12.07.11.23.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 11:23:26 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id p12so13345560qvu.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 11:23:26 -0800 (PST)
X-Received: by 2002:a0c:c790:0:b0:4c6:608c:6b2c with SMTP id
 k16-20020a0cc790000000b004c6608c6b2cmr65839406qvj.130.1670441005701; Wed, 07
 Dec 2022 11:23:25 -0800 (PST)
MIME-Version: 1.0
References: <CA+55aFyJkpSa6rwZ-5xTihfGiNC_T0oL6txrodYBEo2-0O=p7g@mail.gmail.com>
 <1499156564-29458-1-git-send-email-peda@axentia.se> <053d7bf2-9bf3-a71c-5713-7cce19413c37@infradead.org>
 <a546f2db-371e-4d2f-a0ee-c71fcae8c548@app.fastmail.com> <41a5931e-3543-6a3d-ca85-2dd8ad581f2e@infradead.org>
 <efaf326b-3cd9-40a4-8424-b5f60270beae@app.fastmail.com> <f5fe43c0-907e-e5b0-7642-6748f3b1b31c@infradead.org>
 <09f2daca-2f5c-5371-2219-b4804a70c117@infradead.org>
In-Reply-To: <09f2daca-2f5c-5371-2219-b4804a70c117@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Dec 2022 11:23:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wieKH8mGJzDNUKuPTeXB19+9cyDa5zyKOaRasjZuZLxDA@mail.gmail.com>
Message-ID: <CAHk-=wieKH8mGJzDNUKuPTeXB19+9cyDa5zyKOaRasjZuZLxDA@mail.gmail.com>
Subject: Re: [PATCH v2] mux: remove the Kconfig question for the subsystem
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peter Rosin <peda@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 11:15 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Oops. One more thing:
> Your statement leads me to conclude that since nothing selects those 3 mux drivers,
> they don't need to be in the kernel tree at all.
>
> Done. (I hope.)

What?

Randy, do you even *read* what you write? Or, perhaps even more
importantly, what *other* people write?

It's not that those individual MUX drivers need to be selected to be
asked about.

But they won't be asked about UNLESS SOMEBODY WANTS A MULTIPLEXER.

What is your problem here?

Basically, you will only see those questions if you have a driver (or
subsystem) that does

        select MULTIPLEXER

to let the Kconfig know that "yes, I'm actually interested".

If there is no use for those mux drivers, the "depends on MULTIPLEXER"
means that those STUPID AND POINTLESS questions won't be asked.

What's so hard to understand about this?

               Linus
