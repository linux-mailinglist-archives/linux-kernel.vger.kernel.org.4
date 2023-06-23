Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B686E73C3DB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjFWWQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFWWQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:16:13 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2BE26B9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:16:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f8775126d3so1524663e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687558570; x=1690150570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IM/mEkKe71KZTI/kTIp11qigW/W1AwrUpi5SsZrhLxk=;
        b=CmVcWvxiOdjhrCnWk1p5QFZj2mnsgInHLvjgSGXbS9VlRmQM1F1O+2587zVCmZQg01
         yDUPQYTl0e4r99QqOMivUEQWV0LCKyAKBRgNnz6wnpdq8U44c0fLzzFDpVjepjEUJq25
         YTW4gDscPAR2jV4WRzjG5b5WUwYqpcr5F2UwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687558570; x=1690150570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IM/mEkKe71KZTI/kTIp11qigW/W1AwrUpi5SsZrhLxk=;
        b=CLZxsb0NUt6QuMN1us4AM0rlU1+QAggq2z1oXBej9ab6yZLMHe7Khp8kdwVRMP6EYc
         Nel96hwA/L7rijHg+6lLjhuaeVi0cIGkPp6GxGScM5qefCWxigZP51btBq7irXlak+NW
         hLHe0rmVBoilwAEfd1luBtPPZuNh/jrSbS/BwUPTJbMyMScnTOQMFKT8fE3FM0CLjeMn
         CXExKyUNeHD95L7bg7NsOXXf6nmvE9vW51ElO2IZf9F6FALqxyfPocv4is1LLc2DpLTf
         24KseZ5jmdoscDVKI767TBOKKeJ8jtXCMSMuiCpIXhD6l2BCQbXEyii9eRr169t3XpXI
         GZVQ==
X-Gm-Message-State: AC+VfDxJpJLKz7m+K90KJ6OEwVA5qZKpZySTRzWOLuL3z74cRh4PM+gY
        ONlFVEqiCEMGH2fZoIW6FamJ015nz6gknKV8lO4mdvGq
X-Google-Smtp-Source: ACHHUZ6FqdJ+YkQOWmTa9Jr6op0Kf7gSXbc0oLZ4G5MjxCODn0GHUzUZ+5PVStn1pW86x3Ed1HaKUw==
X-Received: by 2002:a19:3843:0:b0:4f3:982a:8be1 with SMTP id d3-20020a193843000000b004f3982a8be1mr13187708lfj.69.1687558570310;
        Fri, 23 Jun 2023 15:16:10 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id y19-20020a056402135300b0051bee1eadccsm7597edw.31.2023.06.23.15.16.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 15:16:09 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51bea30ccbcso1181755a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:16:09 -0700 (PDT)
X-Received: by 2002:aa7:cd45:0:b0:514:994c:2982 with SMTP id
 v5-20020aa7cd45000000b00514994c2982mr14929532edw.40.1687558568768; Fri, 23
 Jun 2023 15:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com>
 <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com> <ZJX27JDyrgvdeCe4@slm.duckdns.org>
In-Reply-To: <ZJX27JDyrgvdeCe4@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jun 2023 15:15:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKoRSXMkwcMN=70nG8aOAJxuF3PUqHSBRJ7dTfnZ1n=g@mail.gmail.com>
Message-ID: <CAHk-=wiKoRSXMkwcMN=70nG8aOAJxuF3PUqHSBRJ7dTfnZ1n=g@mail.gmail.com>
Subject: Re: arm32 build warnings in workqueue.c
To:     Tejun Heo <tj@kernel.org>
Cc:     Dave Airlie <airlied@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, 23 Jun 2023 at 12:48, Tejun Heo <tj@kernel.org> wrote:
>
> The behavior change in gcc-13 is fine on its own but it's frustrating
> because there's no way to obtain previous behavior

No, the previous gcc behavior was just buggy and wrong.

I'm actually surprised at what gcc did. It means that each enum, has a
different type. That's just completely wrong, and means that there is
no such thing as a proper enum type.

And the types are entirely random. They are *not* the types of the
initializers. Try this:

    enum {
        A = (char) 1,
        B = (unsigned long) 2,
        C = (long long) 3,
        D = (unsigned long) 0x123456789,
    };

    int tA(void) { return sizeof(A); }
    int tB(void) { return sizeof(B); }
    int tC(void) { return sizeof(C); }
    int tD(void) { return sizeof(D); }
    int T(void)  { return sizeof(enum bad); }
    int crazy(void)  { return sizeof(typeof(A)); }

and look at the insanity when you compile it with "gcc -S".

So no. There is NO WAY we want to ever "obtain previous behavior".
That is just garbage. Any code that depends on that behavior is just
actively wrong.

I had to go look at what sparse does, because I didn't think I would
ever have made it match that crazy gcc behavior.

But it does - because a few years ago Luc added the logic to match
gcc, and it never triggered me.

Oh, how very horrible.

                Linus
