Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C4560C0E7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJYBVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiJYBVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:21:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0747D1ADBF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:47:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k2so8896689ejr.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ak7zVpqmX9JbVC+MV80uP0uvch3zk3QEsTkNiYdThmU=;
        b=VVj2UZgjKW7iLjIjmZ1MR4SJ5NXqYaYawUi1oSjocuBXvgJSo1rjLFy22VbFw5RPlV
         DkOqzTtsYpyeXjE4kCEM3t9rf09NAAvTbdfwt+rF5iou7TooHHypkGX0YZMvHtZzssH7
         oUyDUvwhrZaKJOilCm54ZNV0G4ux7Es875Bsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ak7zVpqmX9JbVC+MV80uP0uvch3zk3QEsTkNiYdThmU=;
        b=onChU4uQt1oQetklQEMKE8w9aGZiTQZwI6EhoDRcXXJpGNpb2p3eDFzJFx/cGsyqbl
         XnmtLwLBkLFQCTB2XDncASOiGqvZ9+2d5/sl2/7ebZdFmnTvsSNq1g8c1+XsqU7pPzLQ
         PYPvvqxcbBDNGXZpPhqgss+QaJR2yDS33wCpHIDQ9TrLlpfEobx6RXH5E9opiatiNnkE
         kJq1mPIxBMmRae0m344xZH2KmtfBUKEnX9L6qSGQQbH23i0mUm/7gmhph8lEijRtYzqH
         5/DfH2EmtQ+IcEPF/pgUl+jHlSYcvZJ5XU1A4LZTuAL8KVYDDKugprWFWCWZgNnDO/nj
         mtkA==
X-Gm-Message-State: ACrzQf3SvQWiXUpdwdUX98x33BxqN8oIZBaIWc3+VhiW9L4FnmXBZP/J
        xPA1TdrU4edbNpqgyQWTaT7th3l8xJq+4Msv
X-Google-Smtp-Source: AMsMyM4w8Uk8QK0npkrGjauUjaGVK91FcQ59MaYPmpoEFdvdZlnGOjOONPXvoBBhcrjeixF+RNNJEw==
X-Received: by 2002:a17:906:5d04:b0:77f:ca9f:33d1 with SMTP id g4-20020a1709065d0400b0077fca9f33d1mr30036768ejt.526.1666658859201;
        Mon, 24 Oct 2022 17:47:39 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7d84d000000b00458d383a6ddsm645143eds.44.2022.10.24.17.47.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 17:47:38 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id k8so9836663wrh.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:47:38 -0700 (PDT)
X-Received: by 2002:adf:db4b:0:b0:236:5665:a925 with SMTP id
 f11-20020adfdb4b000000b002365665a925mr12828901wrj.617.1666658857911; Mon, 24
 Oct 2022 17:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221019145600.1282823-1-john.ogness@linutronix.de> <20221019145600.1282823-27-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-27-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Oct 2022 17:47:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U3BSOxDV6VKsEfFUdMTzuJr_VSL9GdvqnxN6qJ8tuW=w@mail.gmail.com>
Message-ID: <CAD=FV=U3BSOxDV6VKsEfFUdMTzuJr_VSL9GdvqnxN6qJ8tuW=w@mail.gmail.com>
Subject: Re: [PATCH printk v2 26/38] kdb: use srcu console list iterator
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        kgdb-bugreport@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 19, 2022 at 7:56 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> Guarantee safe iteration of the console list by using SRCU.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/debug/kdb/kdb_io.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 550fe8b456ec..5c0bd93c3574 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -545,6 +545,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  {
>         struct console *c;
>         const char *cp;
> +       int cookie;
>         int len;
>
>         if (msg_len == 0)
> @@ -558,7 +559,8 @@ static void kdb_msg_write(const char *msg, int msg_len)
>                 cp++;
>         }
>
> -       for_each_console(c) {
> +       cookie = console_srcu_read_lock();
> +       for_each_console_srcu(c) {

Maybe it wouldn't hurt to also have a comment saying that normally the
console_srcu_read_lock() wouldn't be enough given that we're poking
into each individual console and calling ->write() but that we're
relying on the fact that all the other CPUs are stopped at the moment
and thus we should be safe.

-Doug
