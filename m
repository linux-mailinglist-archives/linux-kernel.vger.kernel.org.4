Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A336A2341
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBXUqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBXUqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:46:30 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CF56BF42
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:46:28 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cq23so2297123edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh95Rgg4YcfKm/rGes24KRLFGSCx31GDq9PEvrBLE2w=;
        b=HDl3QpnsHSrQh99PiNmsE/a34XldQI4WWD78I7BQjyE9b9z647fzjLVaDgFu1bKMnU
         CiPshUbbkFbN4oWWR4oxeir5QCWQhI+SyuVY66c4rsVlx08kt1P6eeNP3HR4yAy33qpy
         ko5w9buE6lBG4AzV6whLaV0OnBOseRCGdf1YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wh95Rgg4YcfKm/rGes24KRLFGSCx31GDq9PEvrBLE2w=;
        b=EnhbSqWEvDp2L576N0Lsdr0tGT/bvMd9MLWmUPuHCTePKh/54NAfSET6khh6DsofLr
         Eq3dNW+rl5utsH5eak0KxUvtOzNMo4eACYsZ+rXn/AK58NXqMerSQsooh2zlUHrWgp+2
         boQzk4YcbyEmxcdDbuDoIOI+jsPf1K9ER12O8PJUksiD8NhiGNUoLQlqZrAOsrd2J/PM
         sL2F9L2zQoGDnc65AmTZj4z3aYeRrIcg5S0l8xV33w/LyUpkcx2qWwOJzsuxYsJyDZjm
         1TTFwqutY1KtV6zFShdoDeltNz9EQPChmIzZ1uPqjwK0NLxByrUv0wdsH4Rx0dilx0Zi
         QvWg==
X-Gm-Message-State: AO0yUKVnUoIFLw9yrEuj0MsNhR3ISqUwgbJ8QOODEVwvAmN8iiGBz5cA
        WA7VuAODfQok7HCTKhol0NkIKF/SS99Vtyanmy/R6w==
X-Google-Smtp-Source: AK7set/vVBMPy82+3MN1bYVE4orLEiBFhHqVhqIISZyCIiKgmHsfO8ssQdBAi2bP3yrTM8Vlp0ftHA==
X-Received: by 2002:a05:6402:1289:b0:4ac:bdac:ce20 with SMTP id w9-20020a056402128900b004acbdacce20mr16710928edv.35.1677271586869;
        Fri, 24 Feb 2023 12:46:26 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id u23-20020a509517000000b004af588011fesm137079eda.37.2023.02.24.12.46.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 12:46:26 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id da10so2250837edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:46:26 -0800 (PST)
X-Received: by 2002:a17:906:40cc:b0:877:747d:4a82 with SMTP id
 a12-20020a17090640cc00b00877747d4a82mr11917828ejk.0.1677271088924; Fri, 24
 Feb 2023 12:38:08 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wiZ9vaM23eW2k4R-ovtcWLyL8PWvnCG=RyeY4XXgZ6BCg@mail.gmail.com>
 <03dac14b-ed62-3e2b-878f-b145383ea9f8@cs.ucla.edu>
In-Reply-To: <03dac14b-ed62-3e2b-878f-b145383ea9f8@cs.ucla.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 12:37:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=whwDyVKYtv+65N=ixfHR82Hxn2gm+VLqNR-PY-de3wXnA@mail.gmail.com>
Message-ID: <CAHk-=whwDyVKYtv+65N=ixfHR82Hxn2gm+VLqNR-PY-de3wXnA@mail.gmail.com>
Subject: Re: diffutils file mode (was Re: [PATCH 5.15 00/37] 5.15.96-rc2 review)
To:     Paul Eggert <eggert@cs.ucla.edu>
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
        srw@sladewatkins.net, rwarsow@gmx.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jim Meyering <meyering@fb.com>
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

On Fri, Feb 24, 2023 at 12:20 PM Paul Eggert <eggert@cs.ucla.edu> wrote:
>
> Thanks for pointing this out. I added this to our list of things to do,
> by installing the attached patch to the GNU diffutils TODO file. If this
> patch's wording isn't right, please let me know, as I haven't read this
> whole email thread, just the three emails sent directly to me.

Looks good to me.

The whole thread isn't actually any more interesting, it was mainly a
lot of "how did the bits get lost" confusion because it wasn't clear
whether it was some local script or quilt or whatever that lost sight
of the executable bit.

It starts with a report about how the lost bit results in a build error at

   https://lore.kernel.org/lkml/adc1b0b7-f837-fbb4-332b-4ce18fc55709@roeck-us.net/

and there's discussion about how this has happened before and how our
kernel Makefiles generally should try to not execute scripts directly
exactly because our ancient "tarballs and patches" model never
supported the executable bit etc.

So none of it is very relevant, except in the sense that it would be
convenient if diffutils did support the executable bit changes and we
wouldn't have these kinds of things happening every once in a blue
moon.

Again - there are multiple different workarounds, ranging from "we
shouldn't do that then in our makefiles" to "you can use 'git diff'
instead in the quilt scripts".

So not a huge deal - but it would just be nice if diffutils just
supported the extended format.

           Linus
