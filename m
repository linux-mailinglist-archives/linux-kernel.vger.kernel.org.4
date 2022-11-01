Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714546150D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiKARh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiKARhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:37:23 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09150B0A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:37:23 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id hh9so9744291qtb.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 10:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tX7lXOSIub172na59yiJaG9z+L0LtRtj1M1pVvgYKsY=;
        b=M/CX+v3Wlg81iz3RgKnwiosfu4e8RY466GrEZiJWm2gbSMY8mUliKIGOGqlKPw2yQP
         8awES2xSVll6TRzUIdTDUi4NH0jgIoFsYwJgNLvJXq1lusf0VYx3aD6xSavqzkdkOjjx
         0lkBkpleN7Z7Tlpo3VCp3gzjxukaBJMAwC68M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tX7lXOSIub172na59yiJaG9z+L0LtRtj1M1pVvgYKsY=;
        b=5IxgQu1fapJjZaQiRR6fZKhvzon4vMqIIg8b3vYBkulY+QKE/yrJugcGLtRREWb5Jb
         u5KH6BVxFFt3HknsIx5+mo7gNPV6yk7uXOueTQfMJOss8wKSU7uzwE/P7hbKF/J+pz6E
         4AByZWPjyPMY0gZF+AqINm2OzS2kobbpOrJsrA0N2vL4zrdOMs7YeOUYrDs7d/bC4nkm
         3fPxizGVuX63OiaXEhIxYBEIe4MHEkwPM93wMjExCk4qWDRqlZQ0RDpFsdMwtXtpOGh0
         HfQtc1GRy95OJl3To0cxh6swoqeMrMMdOznGk9vR4oKLqqZqPKidJjuHnuHCFe5vJxkg
         e/ig==
X-Gm-Message-State: ACrzQf2RHq+B/cerKact+5v/3GvIWk4qwr5YR+VJcNKdMv//BwyT9/cX
        ilTXWZ2x4dCsB0XNsqRGn+NmeHCybCum4A==
X-Google-Smtp-Source: AMsMyM4m1Mvn+cql26lRZSq7fiYvS7iEL3hrNIUczCkKhGcHFHGPNvrru/NIrrUsyJoSnIOCq408DQ==
X-Received: by 2002:ac8:7d4e:0:b0:39c:d73a:dbc5 with SMTP id h14-20020ac87d4e000000b0039cd73adbc5mr16315318qtb.650.1667324241834;
        Tue, 01 Nov 2022 10:37:21 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id dm45-20020a05620a1d6d00b006e8f8ca8287sm7038500qkb.120.2022.11.01.10.37.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 10:37:21 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 185so18200764ybc.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 10:37:21 -0700 (PDT)
X-Received: by 2002:a25:bb02:0:b0:6ca:9345:b2ee with SMTP id
 z2-20020a25bb02000000b006ca9345b2eemr7214795ybg.362.1667324240766; Tue, 01
 Nov 2022 10:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgJVNe4mUxGJE5B-_GMg0oOgxkZz3UxehVRiCT3QvoZ0w@mail.gmail.com>
 <20221101170015.GA1314742@roeck-us.net> <CAHk-=wi+5sRXL9fTHQRiR9zVEFDPhQceWACBG3QQ=9xoRVmR8g@mail.gmail.com>
In-Reply-To: <CAHk-=wi+5sRXL9fTHQRiR9zVEFDPhQceWACBG3QQ=9xoRVmR8g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Nov 2022 10:37:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNVbdynjJTe8vdpNZyXZ9Aqr9KppXdD4ZioCETtLeziw@mail.gmail.com>
Message-ID: <CAHk-=whNVbdynjJTe8vdpNZyXZ9Aqr9KppXdD4ZioCETtLeziw@mail.gmail.com>
Subject: Re: Linux 6.1-rc3
To:     Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
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

On Tue, Nov 1, 2022 at 10:29 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The random "Inconsistent kallsyms data" issue is something that we've
> had for over a decade.

Actually, it's more like two decades at least.

I had to go back to the BK archives just to see, but that
"Inconsistent kallsyms data" goes back to at least 2004, and that's
just when the warning (and that KALLSYMS_EXTRA_PASS workaround) was
introduced.

The problem itself predates it. The bitkeeper commit from June 2004 by
Keith Owens optimistically states

    Add CONFIG_KALLSYMS_EXTRA_PASS as a temporary workaround for unstable maps,
    so users can proceed while waiting for kallsyms to be fixed.

and here we are, almost two decades later, and that "temporary"
KALLSYMS_EXTRA_PASS thing still exists.

But yeah, it has always been this low-grade annoying randomness with
symbols that move around when re-linking.

             Linus
