Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E504F6150AB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiKAR32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiKAR3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:29:21 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501061C13D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:29:20 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id l9so10022453qkk.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 10:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qaTFr/FuiuNZiAH3Ss0+F2dl/Ud8gvJ5OjJygxhnPZo=;
        b=BwGHsZUb0BmwjRFVT+nXMtAJLL9D2F2eLD12Scofdqv2ihYtbs6au92Bqbw9El1TYJ
         6AvPratXJXnJcQEFpBoN2BwI3Q8OiMljlgIkJ6QIq8Wrb5jGMGG2eDeEVnqOdw35TNhb
         FIShVTXIOQB7iN/f0faxGyM44zTh07W8OeHAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qaTFr/FuiuNZiAH3Ss0+F2dl/Ud8gvJ5OjJygxhnPZo=;
        b=tO6gSoN8c+2z790BzIwX2+4N3u/2GciZMECpHAy2gs/34LDoUTG9SZd2U5vpw+Bilk
         KsLBh+SycjEmvZF8g5JlzKjdufQO9RYQK4l/vYYjCR+jkt+Yc7ysv2qPi4O3sUq8F+TO
         LZ+F5DBcCdePBMdPYYS25dP4ITnuS20E7MG9S1YGbPeqF66UKonNZxOgy9PVwJWlZRMM
         u8pjaA3pbTmh2humhaJ1t6IyJaF+TGgFI2Re/I12HFNIsg7ECyuq1UJ7KDJLAdeokX5Z
         cWcfaT65YF/8D9VEmEk2zACxfUgzgjHAkNC0XXzws89kNeyurwngB9MWSIL3IcZMixap
         bopg==
X-Gm-Message-State: ACrzQf1mpQWYwmG4oZ08bFvrcVfiwBk/h6wDP3ed8dMnO78gbMJEpIWr
        ljDsRTkfxx1MD3KgQuJREAYPvPLbP/Rq+Q==
X-Google-Smtp-Source: AMsMyM6RL78VMLSDLnjcWLT0zDyLNlfVj5o1IkBIv4MMAvlwZXJ09rAOf0NZp3IgaHHruKvvf0JkdA==
X-Received: by 2002:a05:620a:4249:b0:6cf:c984:65bc with SMTP id w9-20020a05620a424900b006cfc98465bcmr14275018qko.116.1667323759003;
        Tue, 01 Nov 2022 10:29:19 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id cc8-20020a05622a410800b003a4cda52c95sm3539541qtb.63.2022.11.01.10.29.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 10:29:18 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id r3so18131624yba.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 10:29:18 -0700 (PDT)
X-Received: by 2002:a05:6902:1352:b0:6bb:3f4b:9666 with SMTP id
 g18-20020a056902135200b006bb3f4b9666mr17596310ybu.101.1667323757678; Tue, 01
 Nov 2022 10:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgJVNe4mUxGJE5B-_GMg0oOgxkZz3UxehVRiCT3QvoZ0w@mail.gmail.com>
 <20221101170015.GA1314742@roeck-us.net>
In-Reply-To: <20221101170015.GA1314742@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Nov 2022 10:29:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+5sRXL9fTHQRiR9zVEFDPhQceWACBG3QQ=9xoRVmR8g@mail.gmail.com>
Message-ID: <CAHk-=wi+5sRXL9fTHQRiR9zVEFDPhQceWACBG3QQ=9xoRVmR8g@mail.gmail.com>
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

[ Adding Arnd and Masahiro in case they remember what the secret sauce
for finding those cases was ]

On Tue, Nov 1, 2022 at 10:00 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> There is one spurious build error. It does not happen all the time,
> and even on the same SHA it is not easy to reproduce. If I see it,
> I may see it on one server reliably but not at all on another with
> almost the same hardware configuration.
>
> Building powerpc:allnoconfig ... failed
> --------------
> Error log:
> Inconsistent kallsyms data
> Try make KALLSYMS_EXTRA_PASS=1 as a workaround

The random "Inconsistent kallsyms data" issue is something that we've
had for over a decade.

It plagued the arm people for a long while, and if I recall correctly
rmk was fighting it until he figured out some workaround, and then it
got very rare (but still continued to happen for other cases).

But when it happens, it's some random code or data layout thing, and
then reverting a particular commit will "fix" it - but it tends to
happen with specific configurations and compiler versions, and when
people trigger it it tends to be quite random.

Arnd fixed once case of it (again on ARM) last year, triggered by some
lld behavior: efe6e3068067 ("kallsyms: fix nonconverging kallsyms
table with lld")

And looking around, the fix for the issue that plagued rmk for so long
was fixed by this one: commit 9973290ce20a ("ARM: 7428/1: Prevent
KALLSYM size mismatch on ARM").

And since you see it on powerpc, I suspect it's some variation of
commit 516d980f8541 ("scripts/kallsyms: skip ppc compiler stub
*.long_branch.* / *.plt_branch.*") that you reported a couple of years
ago.

IOW, I expect it is - once again - some random linker-generated stub
that ends up causing problems, where the re-link stage ends up being
unstable because of some subtle alignment issue or other. I think
zero-sized symbols have often been involved.

The warning is extremely annoying, but while that warning *could* be a
sign of some serious problem in general, in this "random linker output
instability" case it should be harmless. Just very very annoying.

                    Linus
