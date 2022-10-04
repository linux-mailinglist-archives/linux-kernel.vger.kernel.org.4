Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A745F4A84
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJDUzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJDUzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:55:37 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6FD2A43B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 13:55:36 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1322d768ba7so10634359fac.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=i/q6zCo6uZn5YFcofNOMTsjwW/LKGiHOxuAGM6UhUzs=;
        b=ND/gybQA4CKTUaptFFIy2tjNe9PchnhIMte9RFBXPLR2oiSuz4WOdkoAtngtt7/r9S
         N8UPUhVC9K43mGtqCUfZYIzJqKJTtFizqK/OuowWFJcQGs8bOaZG/El0odhHgBHT8EbV
         +jm3XnLCzNQgzPgxkCJ8PYznQ0PzbbrNbIhHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=i/q6zCo6uZn5YFcofNOMTsjwW/LKGiHOxuAGM6UhUzs=;
        b=IcZImU3bsLSTY0S5x0jZQL8rUKVcuGAYckmFOmNQWKkHpRvD9l2QblGZ42VUaqrV70
         vkaQjfrA2Ad3rE1CpRrS7gymaKrDOD+kItCXu4NU5bAovrq9Xg/IjOTnZvmivzmk/SqU
         uQW1dOrz5WgBckOxlkL79w8xBwY/ko9i39e6SHGBUd7Zvwkjj5nmlCNK62c6tRb9moxf
         4/HVRjC65l72XxqQiMKvhrI9xK4HTAb8UkkWGssO2MR1MxImUrEfo7l9+ZrUy7XP22MR
         7KccSTmp4jzkG57DYL//6P55y4sllqhxM/P1m9xPCQ6LvXoA63Df7MOO9bh+4wC1jBOI
         ajyw==
X-Gm-Message-State: ACrzQf29CGv6gK+gKNWAZ8tTKTZ0ZwM4KfRL8+PBsVVCZe/IJelNUIo0
        BGcuQOO+yRDDwKF/CqYoW1x9k8K+E5d93A==
X-Google-Smtp-Source: AMsMyM6ocCfJnp0DajROT37+B1t1vcfPVVoPa51SYtLSCx7+bPtmloDLKXw/+NXDVr0z28t+drTK/w==
X-Received: by 2002:a05:6870:2417:b0:127:be13:2d1 with SMTP id n23-20020a056870241700b00127be1302d1mr884504oap.268.1664916935169;
        Tue, 04 Oct 2022 13:55:35 -0700 (PDT)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id j8-20020aca1708000000b00353e16148c0sm526046oii.11.2022.10.04.13.55.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 13:55:34 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id c17-20020a4aa4d1000000b0047653e7c5f3so9566923oom.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 13:55:34 -0700 (PDT)
X-Received: by 2002:a05:6830:611:b0:65c:26ce:5dc with SMTP id
 w17-20020a056830061100b0065c26ce05dcmr10793439oti.176.1664916933857; Tue, 04
 Oct 2022 13:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
 <87sfk3mim9.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87sfk3mim9.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Oct 2022 13:55:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
Message-ID: <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
Subject: Re: [GIT PULL] LSM patches for v6.1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Oct 4, 2022 at 1:37 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Please don't pull the user namespace bits of this code.

Eric, already done.

And I think you are in denial about how many problems the
user-namespace stuff has caused.

Distros are literally turning it off entirely because the whole "let
users create their own namespace" has *NOT* been a great success.

I personally think it was a mistake. We're stuck with it, but we most
definitely need knobs to manage it that isn't just "enable/disable
USER_NS" in the kernel config.

So this whole "don't do this" approach you have is not acceptable.

99% of all code does NOT WANT the user namespace thing, and it's been
a big new attack surface for the kernel getting things subtly wrong.

I do not understand your "people need to be able to do this with no
controls", when the alternative is to literally turn it off ENTIRELY.

I'm not saying that an LSM is the only place to do it, but I don't
think there have been any better suggestions either.

Put another way: your "no limits are acceptable" is simply not
realistic, and you haven't given any sane alternatives that I am aware
of. No way to say "sure, let trusted system apps create their
namespaces, but not random things".

                Linus
