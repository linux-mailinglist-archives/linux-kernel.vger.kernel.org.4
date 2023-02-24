Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C76A2238
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjBXTRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBXTRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:17:13 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050756A9E0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:17:12 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i34so1289908eda.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HH0zAL0zwAD0TFUh4VaOGtbBT10Co7dyTSR8JSwAXuA=;
        b=GtNE3Ed1l5jwOVYSMAkytt7K/8+r0xcYErBg1jFJR5NuoG8BIRbsy2Au89zhNyAcQ5
         Qset4AKkaxqaU31Ahm2BzjHwj5/D3tZRCwbV3hv+mTG4u7BFAaWSjvrxeuWemjLrqLBl
         2/r5V3P+oRo0NvtuhmHFYeTsTmraiROQHo6n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HH0zAL0zwAD0TFUh4VaOGtbBT10Co7dyTSR8JSwAXuA=;
        b=xx8GT+TCNgdHS9c7AEGXoeCIRlZKPbIWEnwFBSMeTebllbd9bXfpqTDRYMSQy9I7do
         xoGbTusnxtBRXTcBVWtXNlKBNZHL/9J5Jvwgf1RUuruh7P33O+PrWy8ch6YORBfnDp5n
         sN8pI6oLXvXKmPYa8pbog2Gynq+ClnJ30zDQ4d5tYwJaMmm5tT5n/NH4x7NV0SFkur0V
         gj5ocq2iEJNNTR0yFBgwJ/Lp7LnQfk6piwA9B2teyJUArCz0Q8g3VoRjctBrlDQxJRhO
         u3Wi8f9g9UjfK2O1eW7/0U97Xx4rtNkDC7CxOn7H33y8rSAX8Z85OgGoPgnmn34O8SUF
         +OrQ==
X-Gm-Message-State: AO0yUKVpetLIlr1D4pECACSgvVKgnzlrWjIYd3Onyjz7Tfz747O/KZE2
        tPGgPLbzKa3rLem9OD3BedNzp8/+w7+Rz9f9e4f0iA==
X-Google-Smtp-Source: AK7set/w3qQJdGITZIvIpVEmebp90ikG1D9ddB4v3n0B6AKYSGOKZLmOP6OBxqD8QC3vYr65/awLDw==
X-Received: by 2002:a05:6402:697:b0:4af:5aa1:65d7 with SMTP id f23-20020a056402069700b004af5aa165d7mr11941395edy.27.1677266230220;
        Fri, 24 Feb 2023 11:17:10 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id r4-20020a50c004000000b004af6f37d25bsm39881edb.76.2023.02.24.11.17.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 11:17:09 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id o12so1241288edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:17:09 -0800 (PST)
X-Received: by 2002:a17:907:60cd:b0:8f5:2e0e:6dc5 with SMTP id
 hv13-20020a17090760cd00b008f52e0e6dc5mr545864ejc.0.1677266228845; Fri, 24 Feb
 2023 11:17:08 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 11:16:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZ9vaM23eW2k4R-ovtcWLyL8PWvnCG=RyeY4XXgZ6BCg@mail.gmail.com>
Message-ID: <CAHk-=wiZ9vaM23eW2k4R-ovtcWLyL8PWvnCG=RyeY4XXgZ6BCg@mail.gmail.com>
Subject: diffutils file mode (was Re: [PATCH 5.15 00/37] 5.15.96-rc2 review)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Jim Meyering <meyering@fb.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        stable <stable@vger.kernel.org>, patches@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        srw@sladewatkins.net, rwarsow@gmx.de
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

On Fri, Feb 24, 2023 at 8:55 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Ok, it's not quilt's fault, it's GNU diff's fault from what I can tell.
> quilt relies on diff to generate the patch, and I can't figure out how
> to get diff to notice file permissions at all.  Am I just missing
> an option to 'diff' somewhere that I can't find in the manual?

No, I think you're right.

GNU patch was updated long ago to understand and apply the extended
git patch data.

But as far as I can tell, GNU diffutils have never actually grown the
ability to generate those extensions, even though at least the mode
bit one should be fairly simple (the file rename/copy ones are rather
more complicated, but those are just a "make diffs more legible and
compact" convenience thing, unlike the executable bit thing that
allows for scripts to remain executable).

> Anyway, quilt can handle replacing what it uses for 'diff', so I'll just
> replace it with 'git diff' and that seems to solve the problem for me!

That does sound like the right solution.

I don't think the diffutils people really care, but let's cc Paul
Eggert and Jim Meyering anyway, just in case. Because looking at the
diffutils git tree, it's still actively maintained even if the patch
load seems quite low.

Maybe there's some patch floating around that would allow diffutils to
also add those mode change lines. A quick google didn't find anything,
but Paul and Jim would probably know (or can just say "yeah, not even
interested").

                Linus
