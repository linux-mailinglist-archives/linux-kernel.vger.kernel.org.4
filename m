Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439626CF699
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjC2WxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjC2WxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:53:14 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65611BF4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 15:53:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id eh3so69368436edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 15:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680130392; x=1682722392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztt4XFkdOFxnroO6qadslI1I0UT7PQhmogtjb3zlPm8=;
        b=CtS6hyfl71szMpW7Hfutk0Wc5SOIDNvuY2WEZACNZhH/Sbiwuyyt/jUsmtNStXpQoE
         Hpx2A7phRYTDi7NBR+WfNZHvAh7LNiSxwRksUx4GelnPQ3gnyVlKtyKeHK5SDcrFv5w+
         hU8LA3uzncSNWDxPFZmehTSHSTqN7DJPagOQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680130392; x=1682722392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztt4XFkdOFxnroO6qadslI1I0UT7PQhmogtjb3zlPm8=;
        b=WhFchhD6ZC9Kn/xB8Di8BwLOQpKCAjjVeyxo8tEfuXDtj0Oyh0cxrHoleiF+Hf5axX
         ozcGbgfeZs69fx1l+ptmRE4dfCMpL3UznJqJ5R+hbpJSxkv9od7a+24Ss6NjfI3Tsegu
         g0+7kO5oexb83A3gp3cCeYn0pkpzn+UQu9ByhSqNgV5fKLL69FsAG5RmN5uRoRs5RKbH
         CImDl7kPOx6RiYQmUOdkAkJMDWMpdGW5ZMIujXaGlLpaWghsW12KY3CVHYjyvTPs4mgn
         a/dLXIfPcGjI14yFRDd9HR+dgOVSaKQsuAkFuR0CEPynZe0zNxLiQKni4RCZEuRYGelE
         kDmw==
X-Gm-Message-State: AAQBX9d6ybKs1BSBlK4hIpuyJOrdQW8HqYmtCJFTmkxSRI7kQQiQOqC3
        Viru/Ks4WdO4MLekWRW/EMtTyJbAb1GnJbmWs8QIqVeh
X-Google-Smtp-Source: AKy350Ysr9knlt4bm6c+NO/24FJhoPzbisjqoTLMDKi78lHwBnf5X+VEmURrkfR3MSFvasylApN0jQ==
X-Received: by 2002:a17:907:9801:b0:934:60b1:a4b7 with SMTP id ji1-20020a170907980100b0093460b1a4b7mr25512707ejc.51.1680130391761;
        Wed, 29 Mar 2023 15:53:11 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id gu12-20020a170906f28c00b008b17de9d1f2sm17228562ejb.15.2023.03.29.15.53.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 15:53:11 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id i5so69651230eda.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 15:53:11 -0700 (PDT)
X-Received: by 2002:a17:906:eec7:b0:93e:186f:ea0d with SMTP id
 wu7-20020a170906eec700b0093e186fea0dmr10346227ejb.15.1680130390802; Wed, 29
 Mar 2023 15:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230329165819.50ce6ab1@gandalf.local.home>
In-Reply-To: <20230329165819.50ce6ab1@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Mar 2023 15:52:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEdcjdceNdfVGPEcbSmAKh_rjtBSy5_Z3Yyx2GFEgLFA@mail.gmail.com>
Message-ID: <CAHk-=wiEdcjdceNdfVGPEcbSmAKh_rjtBSy5_Z3Yyx2GFEgLFA@mail.gmail.com>
Subject: Re: [BUG v6.3-rc4+] WARNING: CPU: 0 PID: 1 at drivers/thermal/thermal_sysfs.c:879
 cooling_device_stats_setup+0xac/0xc0
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 1:58=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> In preparation to adding my patch that checks for some kinds of bugs in
> trace events, I decided to run it on the Linus's latest branch, to see if
> there's any other trace events that may cause issues. But instead I hit
> this unrelated bug. Looks to be triggering an added lockdep_assert() on
> boot up.

So I think that lockdep assert is likely bogus.

It was added in commit 790930f44289 ("thermal: core: Introduce
thermal_cooling_device_update()") but the reason I say it's bogus is
that I don't think it has ever been tested:

> static void cooling_device_stats_setup(struct thermal_cooling_device *cde=
v)
> {
>         lockdep_assert_held(&cdev->lock); <<<---- line 879

Yeah, so cooling_device_stats_setup() is called from two places:

 - thermal_cooling_device_setup_sysfs()

 - thermal_cooling_device_stats_reinit()

and that first place is when that cdev is created, before it's
registered anywhere. It's not locked in that case, and yes, the
lockdep_assert_held() will trigger.

As far as I can tell it will always trigger, and this lockdep_assert()
has thus never been tested with lockdep enabled.

The "stats_reinit" case seems to also be called from only one place
(thermal_cooling_device_update()), and that path does indeed hold the
cdev->lock.

That lockdep could be made happy by having
thermal_cooling_device_setup_sysfs() create that device with the cdev
lock held. I guess that's easy enough, although somewhat annoyingly
there is no "mutex_init_locked()", you have to actually do
"mutex_init()" followed by a "mutex_lock()". And obviously unlock it
after doing the setup_sysfs().

But I question whether the lockdep test should be done at all. I find
it distasteful that it was added with absolutely zero testing.

                Linus
