Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8217460F5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjGCQuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCQuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:50:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2F5B3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 09:50:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-991c786369cso552243066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688403008; x=1690995008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N5iIDHM8fiZi7DwEjnp/WStuW97jTuZeedkTNeA9kM8=;
        b=hc17WQY+3SCnKRL3D0voPolC9rqrH1x060vdHoksqs0hZWmXsfJyhkN7tTxbu46ybX
         J8ncLZ74LPrOPPBhjwkTMz7Jc658pFJ3LpzvUWTgdhyDhp9njj8wuzF4EKcrSH/ePtrB
         54r99rNIYM7R71OSPep/oDY+2Umf6m4Kb+7aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688403008; x=1690995008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5iIDHM8fiZi7DwEjnp/WStuW97jTuZeedkTNeA9kM8=;
        b=bL0I6P28lvImsjO5OnM1xpUNsf+emtzJD/XGb8+9VsKjKrAZJSvwZnANA/zRxOa2hq
         1G2X1AH0Ad+SrbXALasOqL7NPDRO45LuutGL+l60lTDAVF3WjTdmgvhEO6/zFc6wE64g
         eRUe9zLHMWa8nz/sFtZdH/RgQRnmxnqHaSd3MWxtQZCgKbaAhuo97S3VhLEhVYAau6gJ
         u0A6/lVaH6MGHdIutfWG5suevOxU3sexV0UwO7lqq7xKzUJFx87aP5hzbZ8TonW+Gnyv
         DTiJk8bOyNuvroNxmkfZSXVVZWAZVucOpHSv4sWbPFmP1eliXtALvJ6GXsq1k6/FqQHF
         f/Mw==
X-Gm-Message-State: ABy/qLbL313FZ2NzNXqV+Am8funtI9oiutcmSMntqYquuQvYohkJ5c/U
        PU7nUPMTzAbwxa+rqTv5uGfHohvQyVZiVY0ywSJtlDzd
X-Google-Smtp-Source: APBJJlFHzr0Njf31lUHlm5z7AZMm9RiQSqakokALUfyZ8pKW0Qs/OTOUqTppM0A7IrN5BuckChq7Pg==
X-Received: by 2002:a17:906:fa18:b0:992:e1:93c with SMTP id lo24-20020a170906fa1800b0099200e1093cmr7639970ejb.37.1688403007975;
        Mon, 03 Jul 2023 09:50:07 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id j9-20020a170906050900b0094e7d196aa4sm12202954eja.160.2023.07.03.09.50.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 09:50:07 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51d8fa4dbf9so5288116a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 09:50:07 -0700 (PDT)
X-Received: by 2002:aa7:d1c3:0:b0:51d:ebf4:9874 with SMTP id
 g3-20020aa7d1c3000000b0051debf49874mr6983134edp.2.1688403007144; Mon, 03 Jul
 2023 09:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <2023063001-overlying-browse-de1a@gregkh> <0b2aefa4-7407-4936-6604-dedfb1614483@gmx.de>
 <5fd98a09-4792-1433-752d-029ae3545168@gmx.de> <CAHk-=wiHs1cL2Fb90NXVhtQsMuu+OLHB4rSDsPVe0ALmbvZXZQ@mail.gmail.com>
 <CAHk-=wj=0jkhj2=HkHVdezvuzV-djLsnyeE5zFfnXxgtS2MXFQ@mail.gmail.com>
 <9b35a19d-800c-f9f9-6b45-cf2038ef235f@roeck-us.net> <CAHk-=wgdC6RROG145_YB5yWoNtBQ0Xsrhdcu2TMAFTw52U2E0w@mail.gmail.com>
 <2a2387bf-f589-6856-3583-d3d848a17d34@roeck-us.net> <CAHk-=wgczy0dxK9vg-YWbq6YLP2gP8ix7Ys9K+Mr=S2NEj+hGw@mail.gmail.com>
 <c21e8e95-3353-fc57-87fd-271b2c9cc000@roeck-us.net> <CAHk-=wj+F8oGK_Hx6YSPJpwL-xyL+-q2SxtxYE0abtZa_jSkLw@mail.gmail.com>
 <7146f74d-8638-46c7-8e8c-15abc97a379f@gmx.de>
In-Reply-To: <7146f74d-8638-46c7-8e8c-15abc97a379f@gmx.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Jul 2023 09:49:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjqp09i1053vqFc41Ftegkrh0pD+MKY-3ptdYu3FUh6Bw@mail.gmail.com>
Message-ID: <CAHk-=wjqp09i1053vqFc41Ftegkrh0pD+MKY-3ptdYu3FUh6Bw@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review - hppa argument list too long
To:     Helge Deller <deller@gmx.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John David Anglin <dave.anglin@bell.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2023 at 00:08, Helge Deller <deller@gmx.de> wrote:
>
> Great, that patch fixes it!

Yeah, I was pretty sure this was it, but it's good to have it
confirmed. Committed.

> I wonder if you want to
> #define VM_STACK_EARLY VM_GROWSDOWN
> even for the case where the stack grows down too (instead of 0),
> just to make clear that in both cases the stack goes downwards initially.

No, that wouldn't work for the simple reason that the special bits in
VM_STACK_INCOMPLETE_SETUP are always cleared after the stack setup is
done.

So if we added VM_GROWSDOWN to those early bits in general, the bit
would then be cleared even when that wasn't the intent.

Yes, yes, we could change the VM_STACK_INCOMPLETE_SETUP logic to only
clear some of the bits in the end, but the end result would be
practically the same: we'd still have to do different things for
grows-up vs grows-down cases, so the difference might as well be here
in the VM_STACK_EARLY bit.

                 Linus
