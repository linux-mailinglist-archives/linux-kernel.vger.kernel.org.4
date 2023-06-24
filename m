Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDDA73C5D0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 03:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjFXBXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 21:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFXBX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 21:23:28 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06ED272D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 18:23:26 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-780bd47ef93so42240939f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 18:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687569806; x=1690161806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZsvr5JwV+gVT9wANlk5FqC0I5kNocAXRzdPnCa/F3o=;
        b=jEKBwT1wRaTJs6VimsVN3vNnFfohxicSDRFnTcL7XxI92YzWiVYuVhaSZoHYAuXQ+n
         Xj6XtgbMsMPUGi7kBpbEEGaUbFOtdoPVwTTnbpdne67M0H86bt6eVSuaRUIkLL04fRoM
         PJXAUvMm25nc+IXBkQHaYGzBy5/1ULOsXZKa/kJKaVfeLoDM8SPjTM2qZx6yZ3A3/bXS
         ErtwXs31MtgJAN1naO052apryU87i10sQfjIXli90Y6Mkik9oLjbtMzTLP4z2PTuP8kC
         bTvMUZAFYGZFW8GZFmtnsMmdaJlmjkc7c4KchLDzLlYrfCxL4Ah96JAC8lacE6obZIwi
         ATIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687569806; x=1690161806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZsvr5JwV+gVT9wANlk5FqC0I5kNocAXRzdPnCa/F3o=;
        b=ZJjUID1z2GmKySr1q/E5Y2V//Rh8hTwcSNg9eVMKzQFgtjdRiLQT8LGnvm/HcULFeQ
         RpIk8YARaNFLJvozb9RsnXgHgoohaWNvrUvmwYhFJYYDW1pywHV8lkxLoqwcKDq7rIqG
         ujFxR3kad6HVBNQd1CSSQq0K66bu1NDTbCAGv3gDpCyBDXq0bPhsyuGg7tmWOvAuKYsG
         O1oGqKAK+uIBSJTD2NMbAzKGXmXClNkkU0kHqMQ70aEYbEQPzIh4YRAH8JvDNWsZobs3
         YBZvX6dxchhI5AmZDZ78PoX80b0J2LshKz9u5Z0XTb85UY+8/WmgM3RTOTdKIO9GNGpw
         V/4g==
X-Gm-Message-State: AC+VfDz+R2+0sR/VG5NVQU4OZJe2uD4lYSK8TSGfAhzU+84vDTD5QkR4
        PyuXu+Hqljq5PXsWOtm6tIpZUTv//SEtbQ==
X-Google-Smtp-Source: ACHHUZ55eO65eU0kw6j73LnGtUMTnt6ixrmSUGswB1tjZV2Q0QN2T8Z5HARLf9Rs833+kcACdyn2Zg==
X-Received: by 2002:a6b:6b0e:0:b0:76c:56fb:3c59 with SMTP id g14-20020a6b6b0e000000b0076c56fb3c59mr17390982ioc.10.1687569805933;
        Fri, 23 Jun 2023 18:23:25 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id z22-20020a6be216000000b0076c5926b381sm201308ioc.31.2023.06.23.18.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 18:23:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 23 Jun 2023 15:23:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: arm32 build warnings in workqueue.c
Message-ID: <ZJZFiupBPBrl9mL_@slm.duckdns.org>
References: <CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com>
 <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com>
 <ZJX27JDyrgvdeCe4@slm.duckdns.org>
 <CAHk-=wiKoRSXMkwcMN=70nG8aOAJxuF3PUqHSBRJ7dTfnZ1n=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiKoRSXMkwcMN=70nG8aOAJxuF3PUqHSBRJ7dTfnZ1n=g@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

On Fri, Jun 23, 2023 at 03:15:51PM -0700, Linus Torvalds wrote:
> On Fri, 23 Jun 2023 at 12:48, Tejun Heo <tj@kernel.org> wrote:
> > The behavior change in gcc-13 is fine on its own but it's frustrating
> > because there's no way to obtain previous behavior
> 
> No, the previous gcc behavior was just buggy and wrong.
> 
> I'm actually surprised at what gcc did. It means that each enum, has a
> different type. That's just completely wrong, and means that there is
> no such thing as a proper enum type.

I agree that the previous behavior is out there. It's just that it's been
like that forever and that's been the only way to make constants externally
visible.

> And the types are entirely random. They are *not* the types of the
> initializers. Try this:
> 
>     enum {
>         A = (char) 1,
>         B = (unsigned long) 2,
>         C = (long long) 3,
>         D = (unsigned long) 0x123456789,
>     };
> 
>     int tA(void) { return sizeof(A); }
>     int tB(void) { return sizeof(B); }
>     int tC(void) { return sizeof(C); }
>     int tD(void) { return sizeof(D); }
>     int T(void)  { return sizeof(enum bad); }
>     int crazy(void)  { return sizeof(typeof(A)); }
> 
> and look at the insanity when you compile it with "gcc -S".

Oh yeah, the sizes make no senes.

> So no. There is NO WAY we want to ever "obtain previous behavior".
> That is just garbage. Any code that depends on that behavior is just
> actively wrong.

Nothing is willingly depending on the crazy type behavior. However, enums
are the only thing we've got if we want to make the constant values visible
externally, so we have to make do with them somehow. It has always been iffy
but also mostly bearable. Recent round of problems stem from the fact that
gcc-13 changed the behavior and it sometimes gets nasty to satisfy both
interpretations with the same code. Hypothetically, if we were to declare
that we no longer supported old craziness, cleaning things up would be
straight-forward.

That day will come in the future but, in the meantime, we have to deal with
enums whose sizes are going to be different depending on the complier
version. It's pretty unpleasant but likely manageable in practice. The only
way I can think of to keep the before and after behaviors the same is
defining every enum in its own enum block. ie. Explicitly force each to be
its own type. With a macro helper, code would probably look okay and we'd be
explicitly telling the compiler to pick the type that can contain the value
while maintaining signedness. That would give us consistent behaviors across
the gcc-12/13 boundary. It sure doesn't feel great tho.

Unless we declare that we don't care about external visibility and are done
with enums, none of the available options aren't great, which isn't too
surprising given the sad state enums have been in.

Thanks.

-- 
tejun
