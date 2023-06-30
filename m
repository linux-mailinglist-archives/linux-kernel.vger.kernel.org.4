Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B077E74351D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjF3GeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjF3GeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:34:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07EC30C5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:34:05 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98e1d3be004so173501266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688106844; x=1690698844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TpIIQ08qfNEuob2XBLG/PQlcqkOfTkfohi2v2vX8ccE=;
        b=R1qcu44JUgGBeFFJQSAhWNM56IvipBV6F7S0BbQR8QPPyDbcV206yK5Kll7wAXppub
         lb7WTfOZmpcUMNA0ANMBQYzo7ca07jpnehpywPDfi48k+YGSMRcr2+FV+PkwfYTgF0Sj
         8Dx0HwFueHsgkPUBMKJ9m1sbLIGeMPP93ywow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688106844; x=1690698844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpIIQ08qfNEuob2XBLG/PQlcqkOfTkfohi2v2vX8ccE=;
        b=UHaNe1zj+4IO2MOTbqI7E/dqc2VwKPKNqmBrqCv/Nt/bpIhQA2NFRaFIfuJR9uCABp
         TipwwRBglb5tuqnNHL7RRu6+6jTXbKFUI0Gce3Cx5CjkITM7MN6H1wo5OgzvWJfbbj14
         chQ6uNfzT/qO8npm9nuv4L0vUhIUD5Uga6kd6RGYOMfx056uz/xV+Kb7eNDLCOzNRvMC
         oRj7Z9+FDIzfrLzW/A2KtWiJUkOjQIArR+DPmEdyzWGoTTSCbfjbAPzRe+jTkIoZEN95
         2C0SiASTWtCb60gseBajTg3nQvC44xfzD+h+FNpwltFmGWs9ntRXf3wCkfK+GBWMDbjJ
         i1TQ==
X-Gm-Message-State: ABy/qLZUZ5YMSb+B0TKJqUBcuuagGsp2OIxmMKPmeSw+rCikf5jOfTUX
        /YZNANV9c5yUoX3NHF4KUVcUGxwvtFX3VcnPFDt7n16a
X-Google-Smtp-Source: APBJJlGK9VemRwaNIhaXX4nYCWlXYJoAbX/Vs+QjFrqhy0P9D0JpD1N6gGhxVXyAGlwWQy0y3VIwPg==
X-Received: by 2002:a17:906:3516:b0:978:8e58:e1a9 with SMTP id r22-20020a170906351600b009788e58e1a9mr1123907eja.15.1688106844363;
        Thu, 29 Jun 2023 23:34:04 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id n14-20020a170906118e00b0098ce63e36e9sm7815217eja.16.2023.06.29.23.34.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 23:34:03 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51dec0b6fecso676627a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:34:02 -0700 (PDT)
X-Received: by 2002:aa7:d551:0:b0:51d:af77:d201 with SMTP id
 u17-20020aa7d551000000b0051daf77d201mr909491edr.18.1688106842535; Thu, 29 Jun
 2023 23:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com> <fbe57907-b03f-ac8c-f3f4-4d6959bbc59c@roeck-us.net>
In-Reply-To: <fbe57907-b03f-ac8c-f3f4-4d6959bbc59c@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 23:33:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
Message-ID: <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Jason Wang <wangborong@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 at 23:29, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Did you see that one (in mainline) ?
>
> Building csky:defconfig ... failed

Nope. Thanks. Obvious fix: 'address' is called 'addr' here.

I knew we had all these tiny little mazes that looked the same but
were just _subtly_ different, but I still ended up doing too much
cut-and-paste.

And I only ended up cross-compiling the fairly small set that I had
existing cross-build environments for. Which was less than half our
~24 different architectures.

Oh well.  We'll get them all. Eventually. Let me go fix up that csky case.

              Linus
