Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3797369511E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjBMTyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBMTyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:54:44 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14E1CC2D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:54:42 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so12337wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2vuBCjWyLhGKyLiFDDfTVVh49Ihox9xK/vm4ucik5GY=;
        b=feqFLvqEzftNYjlODppR0WRBKw3g1FCtY/whK+Z3O28dNUO/VHio73S3Ki/BGO/11A
         e6oHDVP+h9gPE/YBO9/XlKuoTcEPwo/iL0VzAiMU4sS6w1MpODYv/QXutZqfnNjMbQ74
         Qs1MgTdufkacL77v+5umKIj2XSzc4GH8Fghu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vuBCjWyLhGKyLiFDDfTVVh49Ihox9xK/vm4ucik5GY=;
        b=sw9ehr0DSknekvUjw22hUNJi5djEqzIoVtGQvfCYy7Sn+QSF3tGfd4UBfEpVJ16hWR
         9WAe+37WmoBnRsl++2+1NmVsWltctruIX4AEVrZUTRVDOk79TWHrWEEizFwNfQ8tJ2u6
         SjHkPu/hgYsduPMJkEMmj50McwmjTgx8Uwdg8nbUn4nVh8yCFeNiJ+aWtdKVIBHZXIp6
         b6H/62hJRQHU6YTFIys3WieYly9LkA4ReYW4a3XzaDNFuDndQBhg9tQZZ1eKDxpJfkbY
         uZvG2d7SPeG2SDG5iUMKNBbhUz7Uwoars9XGszunHO0x+E+R32Rzak1nSQZOwyVL9HWq
         BtCw==
X-Gm-Message-State: AO0yUKXxaanNpTacHX3WbXlIZQ2s9Hfc5oc42ktLT5UjNPPm/MJrPImd
        wsUzr4sBguUDrCPalNMUEfEt+uKCEBVoCb/QPms=
X-Google-Smtp-Source: AK7set9ZA+9Q2t78VqJmKX29CybT8JBGoOBLFcoieKoPWEuhA4XClScc2KupU9+ldYjT2boVmrdvJw==
X-Received: by 2002:a05:600c:4f8e:b0:3df:f2a5:49e0 with SMTP id n14-20020a05600c4f8e00b003dff2a549e0mr22275258wmq.40.1676318081022;
        Mon, 13 Feb 2023 11:54:41 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003db0ee277b2sm18311839wmq.5.2023.02.13.11.54.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 11:54:40 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id c1so10734872edt.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:54:40 -0800 (PST)
X-Received: by 2002:a50:aa88:0:b0:4ac:c720:207c with SMTP id
 q8-20020a50aa88000000b004acc720207cmr2076999edc.5.1676318080138; Mon, 13 Feb
 2023 11:54:40 -0800 (PST)
MIME-Version: 1.0
References: <20230213010020.1813-1-michael.christie@oracle.com> <20230213010020.1813-5-michael.christie@oracle.com>
In-Reply-To: <20230213010020.1813-5-michael.christie@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Feb 2023 11:54:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj0oA0VV77eAgMYFSJm7SBQ15vDLFjcFnNvWrbCRXXSpA@mail.gmail.com>
Message-ID: <CAHk-=wj0oA0VV77eAgMYFSJm7SBQ15vDLFjcFnNvWrbCRXXSpA@mail.gmail.com>
Subject: Re: [PATCH 4/5] kernel: Prepare set_kthread_struct to be used for setup_thread_fn
To:     Mike Christie <michael.christie@oracle.com>
Cc:     brauner@kernel.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
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

On Sun, Feb 12, 2023 at 5:00 PM Mike Christie
<michael.christie@oracle.com> wrote:
>
> This preps set_kthread_struct to be used for a setup_thread_fn callback
> by having it set the task's comm and also returning an int instead of a
> bool.

Ok, so I like the concept, but this patch is just too ugly for words,
and very very confused.

Now, some of it is pre-exisging nasty code just moved around:

> +       mutex_lock(&create->name_mutex);
> +       if (!create->name_args) {
> +               mutex_unlock(&create->name_mutex);
> +               return -EINTR;
> +       }
> +
> +       va_copy(name_args, *create->name_args);
> +       len = vsnprintf(tsk->comm, TASK_COMM_LEN, create->name_fmt, name_args);
> +       va_end(name_args);
> +       if (len >= TASK_COMM_LEN) {
> +               /* leave it truncated when out of memory. */
> +               kthread->full_name = kvasprintf(GFP_KERNEL, create->name_fmt,
> +                                               *create->name_args);
> +       }
> +       mutex_unlock(&create->name_mutex);

The *whole* point of my suggestion was to stop having silly pointless
locking on the name, because this all should be local to that one
thread creation, so that "name_mutex" kind of makes this all
pointless,

But what the heck is this:

> +       mutex_init(&create->name_mutex);
> +       create->name_fmt = namefmt;
> +       va_copy(name_args, args);
> +       create->name_args = &name_args;

That's just crazy talk.

Please just create the name once.

And please don't think that just because it was using a "va_list", you
need to keep it in that format.

Just make it create the name in __kthread_create_on_node() and be done
with it. That code already does a

        struct kthread_create_info *create = kmalloc(sizeof(*create), ..

and you can just make a sufficiently large buffer there. Don't worry
about "kthread->fuil_name" being huge, it should just be bigger than
16. Make it be 32 or something. Nobody wants a larger "full name"
anyway.

No name_mutex, no va_list that is bigger than the buffer we'd need for
the name anyway. Just "create the name once".

IOW, this patch is just being much too complicated for no good reason.
The point was to make it _simpler_ to do thread setup, not more
complicated.

        Linus
