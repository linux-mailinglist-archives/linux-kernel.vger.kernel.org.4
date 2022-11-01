Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DE46151A2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiKAShY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKAShV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:37:21 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAADF19016
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 11:37:20 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so17802132fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 11:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3p6CdQOHdbdKuKxtAWz3EolxIYgcxXpoZhPav3wIwE=;
        b=cBAijlHJzUf3g0Zv+VtqsggOKogW2zDxCgAm297E4z0xgpWWERJFIE0eRxG8EUJbht
         9CCCb1N5CeszOKa91yg6+kJE3Gi04x9Ib57RZ2XxkxIvxCqPkra9ds67ruhDc12mv+Wb
         ALGiYuVPSz0e/na1C8jvfcyHW3ctOr+6EVVb8jBzjS9ErD7jH0YcLjuE1NBkYEWZiuZZ
         FnklS3zjronOTwDw6JEbqslfsjdu9J2zpRf+Kb2pFqMK02cq1KzPjaizbnT7AfazuT+7
         X1uEZ5ElZ4txqvZkb5SInRFVYQ5pqRfQ/7+ZAgWeKG/3/0YRqFifrcu918svln+R8kXk
         349Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3p6CdQOHdbdKuKxtAWz3EolxIYgcxXpoZhPav3wIwE=;
        b=nvNjZaMTweJtrlocjqRt8S5+WG4kvG/QApuJPVyyzlsHbx12qKqpKFZU/p4L7sTwqr
         3vgJ5IbRs0djTLpHu4lhlsYlS4kfsRkKZhY6ikDYsuU1PnRQfUhBEKXNvn+KgsRASxMU
         u8L3mTlcX9tRIIa8u60ww7I1siaN6xfYXk7dW8ccC/clJx0ZvcuIdEurEhrMhbE5AEJT
         SaufM+upEGIn0WH46SYr8vkXJivvmbJtljnVvLQK3IWBVA7XhtG1Wc9j9oSOMcy9s5vo
         1PizivI8xR9jODMkIrIrh8NE0AlOAyG9tIZ8SzHYIxM0UH1Izf7bARXFdn3Xvpjt7Wlx
         rdHw==
X-Gm-Message-State: ACrzQf3MkLxc3UT2c/q37vrq7/4m+CYWYrsI8MtfnZF1Tb0Zv+/G0UWv
        vRZNttmqTqGQ11HYYIsRJAY=
X-Google-Smtp-Source: AMsMyM5CzUZhFdLiK+Z8O4jNF0ksMXyn7JnFG+H4bR3f/QJuLQ7xUXGwbXD920rgpocgbeRzj9cAiQ==
X-Received: by 2002:a05:6870:9193:b0:13c:f48b:505b with SMTP id b19-20020a056870919300b0013cf48b505bmr7954526oaf.122.1667327840031;
        Tue, 01 Nov 2022 11:37:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m6-20020a0568080f0600b0035173c2fddasm3682675oiw.51.2022.11.01.11.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 11:37:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 1 Nov 2022 11:37:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: Linux 6.1-rc3
Message-ID: <20221101183717.GB1328619@roeck-us.net>
References: <CAHk-=wgJVNe4mUxGJE5B-_GMg0oOgxkZz3UxehVRiCT3QvoZ0w@mail.gmail.com>
 <20221101170015.GA1314742@roeck-us.net>
 <CAHk-=wi+5sRXL9fTHQRiR9zVEFDPhQceWACBG3QQ=9xoRVmR8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi+5sRXL9fTHQRiR9zVEFDPhQceWACBG3QQ=9xoRVmR8g@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:29:01AM -0700, Linus Torvalds wrote:
> [ Adding Arnd and Masahiro in case they remember what the secret sauce
> for finding those cases was ]
> 
> On Tue, Nov 1, 2022 at 10:00 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > There is one spurious build error. It does not happen all the time,
> > and even on the same SHA it is not easy to reproduce. If I see it,
> > I may see it on one server reliably but not at all on another with
> > almost the same hardware configuration.
> >
> > Building powerpc:allnoconfig ... failed
> > --------------
> > Error log:
> > Inconsistent kallsyms data
> > Try make KALLSYMS_EXTRA_PASS=1 as a workaround
> 
> The random "Inconsistent kallsyms data" issue is something that we've
> had for over a decade.
> 

I know. Difference this time around, at least for me, is that the
table is oscillating and never converges. Another difference is that
it looks like the problem was introduced by a change in how the table
is created, not by a change in the code or the compiler/linker.
I do have a patch that lets me run as many extra passes as I want,
but that doesn't help if the table never converges.

If anyone has an idea how I can track this down, I'll be happy
to give it a try.

Thanks,
Guenter
