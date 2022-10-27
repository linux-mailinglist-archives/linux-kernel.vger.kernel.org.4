Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901EF61013C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbiJ0TME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbiJ0TMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:12:02 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1536653026
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:12:01 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 8so1805129qka.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=abXkIeZS2BqN/ZiXNcciWpaMLHMiXJFy0vINuEr3n74=;
        b=gjxfTkCV6GWVCmXpkSYG8Qc8Sn/5IWAw8JPE/ZvF6BPVUFYFqMFLeRUdbPjpUZYpfc
         /ENNSIMRBRLgyXf9RyTfJmrbNxh+6WFIpsH0tMFEqdBCCZZy+tEi+x8PhW6lVJjUr0lm
         QvaDPmeyXiewZFMvg6JXusII3iciu3g9dJlks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abXkIeZS2BqN/ZiXNcciWpaMLHMiXJFy0vINuEr3n74=;
        b=XgDyBqkTiVtr3oqosp7z4aWcKYulbV9X6O6+ThvqPiZrSGuG6PG+um9LRnL9gRW5ko
         ZcGYDsXnCa1EsqAxkwxwwIa9ZtD//gg3JQuV7h2A3OKbt9iH6PodhkDu+OYMDxD27WWE
         PJO7SSRRPtCHeF8TQhDFhR/H2no8+N0gsCPhHz8DS7s7gsLq8plqS9pmW0WFj7CwSV8E
         HivQHsWXPj54rJ1vkWvRzVFvGKadzYp7ojlYAu7OaVY499065ii/OsIirh1+CZQPyVf1
         zsJfWm2BUzOqaTajuFAR4nNmq6l51ypMg7O4S1Ytov6D5hs4FbHtTDPlQ5byfSp8bV+c
         +sYQ==
X-Gm-Message-State: ACrzQf2+9XMAdOY8a/jHKbNc9R8g9Oi6+r427D8Tg9WGrK2kPwggUIh5
        Ok5wHOnxgMH9d7R9BvvDlC4mCN9g1zPdoQ==
X-Google-Smtp-Source: AMsMyM4uKHEUaqIGxs6jCcpAN13PQi7U7GCw/cDnylAWYLnCwjdwL5NuNRNQJe7P86ZQw7zIQjpN1A==
X-Received: by 2002:a05:620a:448e:b0:6ce:8dd2:bc46 with SMTP id x14-20020a05620a448e00b006ce8dd2bc46mr36997625qkp.705.1666897919863;
        Thu, 27 Oct 2022 12:11:59 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id w29-20020a05620a095d00b006eecc4a0de9sm1461913qkw.62.2022.10.27.12.11.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 12:11:59 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-367cd2807f2so25844527b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:11:59 -0700 (PDT)
X-Received: by 2002:a81:11d0:0:b0:35b:dd9f:5358 with SMTP id
 199-20020a8111d0000000b0035bdd9f5358mr46121043ywr.401.1666897919022; Thu, 27
 Oct 2022 12:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221027150525.753064657@goodmis.org> <f62e19bb-497a-8cf6-93aa-d654d7850356@roeck-us.net>
 <20221027150237.4e69ba27@gandalf.local.home>
In-Reply-To: <20221027150237.4e69ba27@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Oct 2022 12:11:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXk3jrhzjkYgC=a7F1+oFY2wNmxeMDTza10maGU2-i4Q@mail.gmail.com>
Message-ID: <CAHk-=wiXk3jrhzjkYgC=a7F1+oFY2wNmxeMDTza10maGU2-i4Q@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
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

On Thu, Oct 27, 2022 at 12:02 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> So it works on current stable and current mainline? Does that mean we need
> to worry about this?

No, I think Guenter is saying that current mainline *without* the
patches works fine.

But v6.1-rc2 (which is quite close to that current mainline) *with*
the patches blows up.

So it's almost certainly the patches that break. There are no
appreciable timer changes in those 105 commits (there's some added
irq_work_sync but that looks very unlikely to be related.

            Linus
