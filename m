Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E000F6F1C07
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjD1Pzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjD1Pzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:55:37 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99B4E5B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:55:35 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5083bd8e226so15455013a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682697334; x=1685289334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xChxJ7IJyqQRc+Iv7KzaMBMnKurmuv9xIrMDMyvDmO8=;
        b=WSuwB3mxNB7cx2qpUWtEXkAC+XSbnxC8tadFflT+Ebzrg1suB8ZhU1vbvnCHguuc6X
         jHR6sauNMag5A+8Z6+wY+6d1rgfa++M8VSoYb93VpmE2Oaw6GYh9sIYJncJoS7p8KyVe
         30sUGet5iL9NUzUFidDxWw44ip5kzzKSp/wy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682697334; x=1685289334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xChxJ7IJyqQRc+Iv7KzaMBMnKurmuv9xIrMDMyvDmO8=;
        b=KAoz8kgqXbTy0pFNFi+U9r1YwOW2FydluH9WXB4SpvxsQFhyjWmHoQ4uPIxnscSnZG
         a+ohPGhhfaEEOdr3jj5alFo6Xho2t1sNOkv69k0n9g3E+jKLLHKbf1gbIvV1E4WgMsTB
         kFxPtU/vyFdN5T/Mw6rdLdbkWSCMqzK2aRkjjnbFywYnup5esULyHmKBA7aC0gA2iCTs
         W0HvJpi2VdZdNsBmaKr/+RcJfVwW7N2MPu5lyKCjZmbJCUpXgBSDwFXHHx2kv61WH7qd
         23dVsiWUSpRNm9yyN5zLY/lm3x/9Fk76Q8g4QX0LqiD5KOBpuyb+3RXYzGtZZIh5sRL5
         RCqg==
X-Gm-Message-State: AC+VfDxwnJXwx2wm7/FtwT0lW2v2nv4KWlNn3K9mA7WqsjNCzUDGx+ly
        J2D0ZeFa5iGzwDF4QNu+W05QoO+42GtVJT0SBngMng==
X-Google-Smtp-Source: ACHHUZ59ANPvId+IRX5TgjGq7I6gl6Ziw4+HLtnGM42LC5L3ZJOG1IRSODYkSQuY34VbwfKodIqaQw==
X-Received: by 2002:a05:6402:ca:b0:504:78aa:4f2d with SMTP id i10-20020a05640200ca00b0050478aa4f2dmr4814711edu.0.1682697333854;
        Fri, 28 Apr 2023 08:55:33 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id b8-20020aa7c6c8000000b005068d7ccfb0sm9144041eds.83.2023.04.28.08.55.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 08:55:33 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-504fce3d7fbso15459713a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:55:33 -0700 (PDT)
X-Received: by 2002:a17:907:961b:b0:94e:6a24:9463 with SMTP id
 gb27-20020a170907961b00b0094e6a249463mr6666354ejc.28.1682697332875; Fri, 28
 Apr 2023 08:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <ZEqEx7C2iuApvrvt@kroah.com> <CAHk-=wjcvp-JxG2PW7TF6HV2h1xx2_2SMh_HGNZuEpK0CtNTww@mail.gmail.com>
 <ZEtVvK6LTQHw6Onu@kroah.com>
In-Reply-To: <ZEtVvK6LTQHw6Onu@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Apr 2023 08:55:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wip5BKsjcN2Efu8PoWmtOdqDgmG7hGLsq_NZcz=FJVDxg@mail.gmail.com>
Message-ID: <CAHk-=wip5BKsjcN2Efu8PoWmtOdqDgmG7hGLsq_NZcz=FJVDxg@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core updates for 6.4-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 10:12=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> In the future, how do you want stuff like "when this is merged with that
> tree, something needs to be done" type of things to be pointed out?

Just having it pointed out is fine. I notice build errors on x86-64
myself, but other architectures get rather iffy. arm64 is the best of
the bunch, in that I *will* do the build test, it's just not as
timely.

If known merge issues get pointed out, I (a) know to look out for them
and (b) know that the trees involved actually were in linux-next and
people were paying attention.

It's usually not been a problem with your trees, particularly since
most of your stuff does build on x86. This whole CDX subsystem being
arm64-only is not great for build coverage.

               Linus
