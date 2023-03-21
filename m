Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983D16C39C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCUTEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCUTEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:04:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD52A559F3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:04:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h8so63725478ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679425443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86Y1u5mLe9v/pBUgkOz+GqSgxjFJqe1/jbcXyRYiTnE=;
        b=flGgnsoy2zA9nwYcGJNTRsyctDtIDckL2GqnI2TIwCNHrfNhGbyfl0vzhMEASxp1Fy
         T/A/1w9Kr4ji9Pvl/2AxLUDqc/HU7yq4NQzEHfA0URTc/GmspvlQBsV63VY80iXpBj5l
         zAp2RomfgS+QF2V2+e5DaAVGGqyuYp2aSgJPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679425443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86Y1u5mLe9v/pBUgkOz+GqSgxjFJqe1/jbcXyRYiTnE=;
        b=sRt7fYhgP3YSjxSfmeyIrZKQaclJRFYe63I8E2SaeOVzyDhV/F7UXtjr8DQaG5rj39
         KUf2nfw0QNaD/tLf8Y3q/ssVL+7lw0vgQSiCd7Z4fsC6piH84gxKgOKEpAu9nnjaOQjc
         UBSUq+noWCW96GcTH+3DjP6oRYtDejJXdm7X3EWpLL1xl+KmUDbPzYfOa0LZzJgcF/Sw
         1zx67G8/gr0iVvCAqp3h6U4qYsX2IV09zJ0aPTmaNAgnyb7DTo4ht6432ziFHY0VSLQx
         evirRq7XQMpk+nDaede4jtPnzNmEM2eQKOIqXPIEKV+FbOJx2YnLJtXdsqnuRgx0NngG
         cj2w==
X-Gm-Message-State: AO0yUKVMf9d1deux+tAVkA3bKc5jwFmVhhpxhSb73iK3HgU8BWzWiY8o
        pXrbbVufymnoeH/ub/JNxD1OVzu9sHUkogKUYZpoE/Kt
X-Google-Smtp-Source: AK7set992TJEw2I5lzryzcT2qaTwOVpnO5XIpQi/Y22bYoQMJPkmybfhiTGf5rO9+LUonYpfE1xcSg==
X-Received: by 2002:aa7:d486:0:b0:4fb:7986:47b3 with SMTP id b6-20020aa7d486000000b004fb798647b3mr4580862edr.17.1679425443182;
        Tue, 21 Mar 2023 12:04:03 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id n4-20020a5099c4000000b00501cc88b3adsm2744125edb.46.2023.03.21.12.04.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 12:04:02 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id w9so63781587edc.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:04:02 -0700 (PDT)
X-Received: by 2002:a17:907:9b03:b0:932:da0d:9375 with SMTP id
 kn3-20020a1709079b0300b00932da0d9375mr2435070ejc.4.1679425442225; Tue, 21 Mar
 2023 12:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230320205617.GA1434@sol.localdomain> <CAHk-=whefxRGyNGzCzG6BVeM=5vnvgb-XhSeFJVxJyAxAF8XRA@mail.gmail.com>
 <20230320225934.GB21979@sol.localdomain> <20230321020313.GA108653@mit.edu>
In-Reply-To: <20230321020313.GA108653@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Mar 2023 12:03:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVTfej6+D62rzedjY_wzBVFqH0+U5vbq+ava8VhYPH3g@mail.gmail.com>
Message-ID: <CAHk-=wjVTfej6+D62rzedjY_wzBVFqH0+U5vbq+ava8VhYPH3g@mail.gmail.com>
Subject: Re: [GIT PULL] fscrypt fix for v6.3-rc4
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 7:03=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> Another option is WARN_RATELIMITED.

I don't think that exists.

There's 'pr_warn_ratelimited()', but honestly, the rate limiting is a
joke. It's fine for things that never happen, but if you can flood
things without the rate limiting, you can still flood things with the
rate limiting.

The default rate limiting is "max five reports every five seconds".

For some "this should never happen", a reasonable rate limit might be
"once every 24 hours" or something like that. Just make sure that if
the machine stays up for months or years at a time, it doesn't get
hidden in all the *other* noise.

Our rate limiting sucks. The only thing that really saves it is that
rate limiting is used for things that never happen in the first place,
and the default values are basically picked for "this is a network DoS
attempt, let's make sure it stands out in the logs without completely
bogging down the machine".

So no. Please don't use "ratelimited" for "this shouldn't happen".
It's still going to suck. We had that *exact* thing just a couple of
weeks ago:

   https://lore.kernel.org/all/CAHk-=3DwjTMgB0=3DPQt8synf1MRTfetVXAWWLOibnM=
Kvv1ETn_1uw@mail.gmail.com/

where the networking people thought that ratelimiting would be a good idea.

It's not a good idea.

                    Linus
