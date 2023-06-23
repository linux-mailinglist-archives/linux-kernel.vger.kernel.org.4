Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44F673C401
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjFWWWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFWWWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:22:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E278219AB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:22:41 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f86dbce369so1552019e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687558960; x=1690150960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rvN0kECg6txQDm3l8YgQDgQlz8OGdukT1rUSdEC/b8s=;
        b=Pugyc4fmIjlij/N3c77/Dkuisre12LEpKE8R2btjyuYw4w0OHH/Q8LvzH5PRm9RXzn
         lLxb/TTtrXO7sjlBWv2+B3VHEGXxwuArmKJm5dfIW6neiDEQKxDzBuunAoDKKj2qOwt3
         1wGHA1epucIBFkjqNTS+KoYSe+GlDWRnNgt6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687558960; x=1690150960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvN0kECg6txQDm3l8YgQDgQlz8OGdukT1rUSdEC/b8s=;
        b=lEtNavfq+nf8nsGC04jREgiRa1aY3BSAgHhT7UlwGoLJQGqYwT91CzPMXfjvkBqEVf
         B27mqEf+El9iRggJTAqPY8zcMpYuMlfr9i123ilhvArTIkBuZAX1tELsiplitTfu4ufh
         oIe5ZR8Xy4IZErePAoBU49KB1CCQd7O/tTDRkd8gv6sSpKeJiOkazj6EYFmjeOAeity4
         p8Ia8TAigZFUgjBsB4fNdXQ6Dlf8MDj83lwMSfPfE9ZEy1NKvbEKfO2ByRpoMZDRM1N/
         sJVtYU7k6Oqn5/JNq1r4Fe3Gy0zK9wd2KpfR/reVMxCiw+VZAVvp5x+5tyABuvdwFHyK
         k5FQ==
X-Gm-Message-State: AC+VfDzSG5ZdckpOIicWJRz0fW4USKKelxnLajqMeUUrKaNcWzcAArDV
        ZWempGYQUioNPCXJx3i98aZ/mZ4ZKEDP/qJELMQJG/H0
X-Google-Smtp-Source: ACHHUZ6M1/x3HVCB/QB/YctS9BHAD+FJzmkS525n+BugeTijCcdCkku/6HwWXB2MtqjPRqsBtcefGg==
X-Received: by 2002:a05:6512:291:b0:4f8:6e26:9347 with SMTP id j17-20020a056512029100b004f86e269347mr12365062lfp.68.1687558959802;
        Fri, 23 Jun 2023 15:22:39 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id q10-20020ac24a6a000000b004f875238d95sm45911lfp.173.2023.06.23.15.22.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 15:22:39 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b46a06c553so19443401fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:22:39 -0700 (PDT)
X-Received: by 2002:a2e:b046:0:b0:2b4:75f0:b9e0 with SMTP id
 d6-20020a2eb046000000b002b475f0b9e0mr10639869ljl.37.1687558958759; Fri, 23
 Jun 2023 15:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com>
 <CAHk-=wi=eDN4Ub0qSN27ztBAvHSXCyiY2stu3_XbTpYpQX4x7w@mail.gmail.com>
 <ZJX27JDyrgvdeCe4@slm.duckdns.org> <CAHk-=wiKoRSXMkwcMN=70nG8aOAJxuF3PUqHSBRJ7dTfnZ1n=g@mail.gmail.com>
In-Reply-To: <CAHk-=wiKoRSXMkwcMN=70nG8aOAJxuF3PUqHSBRJ7dTfnZ1n=g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jun 2023 15:22:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgj45awSzkC2CnavVcpxXWxR9yoqx=VJd3CxMEKmSVTtg@mail.gmail.com>
Message-ID: <CAHk-=wgj45awSzkC2CnavVcpxXWxR9yoqx=VJd3CxMEKmSVTtg@mail.gmail.com>
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

On Fri, 23 Jun 2023 at 15:15, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I had to go look at what sparse does, because I didn't think I would
> ever have made it match that crazy gcc behavior.
>
> But it does - because a few years ago Luc added the logic to match
> gcc, and it never triggered me.
>
> Oh, how very horrible.

Yeah, I just went back and checked an older version of sparse - and
that older version actually DTRT, and gave every enum the proper type
(ie in that example I posted, every enum size was 8 bytes).

So even sparse now gets this wrong, because sparse was explicitly made
to match that horrid gcc behavior. I guess we got warnings from
sparse, and then that caused Luc to "fix" sparse and nobody realized
that the warnings were good.

                Linus
