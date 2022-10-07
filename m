Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407405F7D7B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 20:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJGSpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 14:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJGSps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 14:45:48 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECBA7E816
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 11:45:46 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-12c8312131fso6520252fac.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c+tH9xLqFZ0nYBsdjjRXGUorlZh62oBNwN5T/65jp+o=;
        b=NQ5D+a0a7pKOENLJjxMHyemqO9juxJt+ABUKqk5NxgodnT+ACXADP4rCUFGqQJ8Tnl
         NFM1s6yVwObEVJTJzqhuCJ3RSP6zBniVDdipY70rbMazKTwhniIIABCNAgGE5qXJb65z
         LlBsFghYYblXpaE5nODHfl6DTeLJWyAg6fYg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+tH9xLqFZ0nYBsdjjRXGUorlZh62oBNwN5T/65jp+o=;
        b=lbXVBo0lyDm3/DTtK3SK6WCpHBcPoHiY3qacxfExKb9HZnaaYNm4BqmRk4j71OZcMv
         evA3CV9TBamq4LB0hALtMXKxm9DkP/MCX9+tehagiFb5pHLfWtmcylixAW5FAu/zfkgE
         OpJDoGHfoKmbibHP9oGqXIKHX3SuOwP1QowcZpqxKV7xBA5uXAF96amGE/LHyyXGO4AK
         F9iLCeVO47OptBiJcxaH20TeNdiM2WVYbhZseN2/ODexA1hNXICTBh1yTO3oTrPH8G12
         XEAJLdZ1OAr58aT0f7LMlGJrqSrpT5ncuJFl020FHBkzMj0WucqcLD43IqiXWhTozd5b
         jbTg==
X-Gm-Message-State: ACrzQf1UAecorSg9ylV2uggoFtLbH7dhUHe2uTREL4AXWdMmDv7T0zKS
        aKtzj3bg1TrynU1TYQlB4ZqlqFOLFvyIaw==
X-Google-Smtp-Source: AMsMyM6hWhDSyUOQjpwUuNPo4Gy4XapgwbXvXDTywUYxyiwgnHLYi76dn10HTymH9RnAdwZudmLi3w==
X-Received: by 2002:a05:6870:959f:b0:132:fe86:4df8 with SMTP id k31-20020a056870959f00b00132fe864df8mr5814964oao.58.1665168345454;
        Fri, 07 Oct 2022 11:45:45 -0700 (PDT)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com. [209.85.160.50])
        by smtp.gmail.com with ESMTPSA id p18-20020a4a95d2000000b0047f72b6988fsm1226608ooi.45.2022.10.07.11.45.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 11:45:44 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1324e7a1284so6491623fac.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 11:45:43 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr3322948oad.126.1665168343571; Fri, 07
 Oct 2022 11:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <Yz18QA27+gN0oaM3@google.com> <CAHk-=whK-q1W-X0q0f_nBJ9sKyta-DVJhEAS4BF_oKAVAUQ4Jw@mail.gmail.com>
 <Y0AmmR2NfKc/Y7Mb@google.com>
In-Reply-To: <Y0AmmR2NfKc/Y7Mb@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Oct 2022 11:45:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=hh8xkPjiySnjAyR66AG64eyZ1Y9gHw+MCs8uuSZReA@mail.gmail.com>
Message-ID: <CAHk-=wg=hh8xkPjiySnjAyR66AG64eyZ1Y9gHw+MCs8uuSZReA@mail.gmail.com>
Subject: Re: [GIT PULL] Backlight for v6.1
To:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Oct 7, 2022 at 6:16 AM Lee Jones <lee@kernel.org> wrote:
>
> PR satisfying this dependency was submitted the following day:

.. you ignored the whole "another driver hit v6.0 without ever getting
the dependency".

So this whole thing with "dead driver because the config option it
depended on didn't even exist" wasn't some little temporary thing.
It's literally there in a released kernel, which has a whole driver in
it that cannot actually even be enabled.

And now that I *did* get the MFD update, I notice that the build
coverage of *that* is pitiful too.

In particular, there was a silent semantic conflict in the Crystal
Cove (intel PMIC) driver with the i2c changes. I noticed it because
there were other things going on, and I went and looked.

But most notably I *didn't* notice it due to any build coverage,
because the Kconfig for that thing seems designed to hide the driver.
It does have

        depends on (X86 && ACPI) || COMPILE_TEST

so that it *looks* like it should get compile test coverage even
outside of x86, but in reality,  even on x86 it's actually really hard
to test, because it also has

        depends on I2C_DESIGNWARE_PLATFORM=y

so if you do a regular "allmodconfig" build, that driver doesn't
actually get any build testing at all, because while that platform is
indeed enabled, it's only a module.

So I caught this particular issue, but I really think that code that
cannot be enabled at all even for build testing - or code that is
quite hard to enable either intentionally or by mistake - is a
problem. And right now MFD was involved in both of the issues I've
noticed this merge window.

That's not a great look.

                Linus
