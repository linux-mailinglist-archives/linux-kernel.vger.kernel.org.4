Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D252564D1FE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiLNVy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiLNVyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:54:24 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445D14047A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:54:23 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id b189so1146093vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NO/988FIy/m4rdDm+TJSXg/ps0g6/KRJ3d7+HM0eHiI=;
        b=Ozw5Mle1/MolDZkVlqwDg3KtP9dOLAV3Ve6u8QFjExGTiZ/g3A4bKfMDMX7QwJnuvN
         XlGyb9bVYV6Ez1BzIwAqNRlZu7AEzlJnqpHZ92Oo6Imn7qDafm5Nz0GRcqvBoeTQx+fT
         9qSjrNjRT3jNxvDd4GQPIX9ecpe6Sbix9hcyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NO/988FIy/m4rdDm+TJSXg/ps0g6/KRJ3d7+HM0eHiI=;
        b=rgfDAJ/gCmgDL+6BexJyNsyNCZs4y8bEqCDjI/EBvBhVbvm3ZiTAdfrcoBVRXFL2vi
         /aempU4ZioKpgs10yR1NRz0spXclbrE/8TRpX+t8VemmEd8K2vcpDN9/Je+U2PqqRScw
         i5hFR/MU8pCdL016wXIYA4nMQzbBm6eQtrtZuLvVvSxTPRB1GnjoxOvq2YQrxcZ4NfUm
         va89SL4zOfFNqDjfbuRTmkVjzb0xmhFvViWBIRUTdCeu9iqcni5wTG9E8kDyrvm/S3U2
         l8cwcv2RTnPe+jllV8GQqSQtk2P1K3T/knfqSo2U1JXjIgKAU8d7ozwMWpQDwlguLT/x
         zfXg==
X-Gm-Message-State: ANoB5pnXVf12A6wRBM3IPH+bVI+izNwC6nfdQeNhVizs8vCZvNWNeSPd
        z4fNAJP+kC6uwP1TzHYu7WQ0rJ2fSXnkAH0L
X-Google-Smtp-Source: AA0mqf4+d44cHZ9OCckJ352xKD6gSpRjkWAaoHHoKVCM2REW5rGmb6iI4ecW2rEhwFoCchmZs5qhlA==
X-Received: by 2002:a05:6102:3e84:b0:3b0:7212:f98e with SMTP id m4-20020a0561023e8400b003b07212f98emr19867546vsv.27.1671054861961;
        Wed, 14 Dec 2022 13:54:21 -0800 (PST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a0bc100b006bb2cd2f6d1sm10712275qki.127.2022.12.14.13.54.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 13:54:21 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id x18so1873183qki.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:54:20 -0800 (PST)
X-Received: by 2002:ae9:ef48:0:b0:6fe:d4a6:dcef with SMTP id
 d69-20020ae9ef48000000b006fed4a6dcefmr10942000qkg.594.1671054860137; Wed, 14
 Dec 2022 13:54:20 -0800 (PST)
MIME-Version: 1.0
References: <218cac2c-47ae-435d-d7d0-48e4937a7f99@canonical.com>
In-Reply-To: <218cac2c-47ae-435d-d7d0-48e4937a7f99@canonical.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Dec 2022 13:54:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiBjnEtm8cFBp=6YNFe51z6Mdb-BbEJyfka9w1fkWfPvg@mail.gmail.com>
Message-ID: <CAHk-=wiBjnEtm8cFBp=6YNFe51z6Mdb-BbEJyfka9w1fkWfPvg@mail.gmail.com>
Subject: Re: [GIT PULL] apparmor changes for v6.2
To:     John Johansen <john.johansen@canonical.com>
Cc:     LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

On Wed, Dec 14, 2022 at 10:36 AM John Johansen
<john.johansen@canonical.com> wrote:
>
> John Johansen (45):
>        apparmor: make unpack_array return a trianary value

John, this is unacceptable.

I noticed it due to the conflict, but this really is garbage.

First off, the word is "ternary" (or possibly "tristate").

Secondly, we don't do types like this

    #define tri int

and even if we did, that's a *horrible* name not just for a type, but
for a #define.

Finally, what the heck is "TRI_TRUE/TRI_NONE/TRI_FALSE"? WTF?

It looks like it is used in one single place - the return value for
"unpack_array()" (now renamed "aa_unpack_array()"), and the TRI_FALSE
case is basically an error case for an invalid case.

And TRI_NONE is just a *different* failure case ("name does not exist"
vs "data is invalid").

And then, to make matters worse, ABSOLUTELY NOBODY CARES ABOUT THE
DIFFERENCE. All real users just want to see TRI_TRUE (for "success"),
and anything else is an error anyway.

Yes, yes, there's that one KUNIT test, which wants to actually see
that TRI_FALSE because it's testing that array-out-of-bounds case. It
also - for some unfathomable reason - seems to then want to see some
particular pointer values in that invalid data after the failure,
which seems bogus, but whatever.

In other words, that type is badly done and mis-named to start with,
but then the different ternary values themselves are confusingly
mis-named too in ways that make no sense.

And to cap it all off, NOBODY CARES about those horrid things anyway.

Anyway, I started out doing the mindless conflict resolution, but then
I just couldn't deal with that 'tri' type. There were just too many
things wrong with it for me to accept it, and I felt dirty for just
editing it.

Then I tried out just making it a

     typedef enum { TRI_TRUE/TRI_NONE/TRI_FALSE } ternary_t;

which fixes some of the syntactic issues.

But the whole naming confusion of the values and how NONE-vs-FALSE
wasn't actually a useful distinction anyway made me just axe it
completely.

I'm honestly baffled by why you didn't just make it return the size or
a negative error code, like is the norm. The size is limited to 16
bits anyway, so returning an 'int' with a negative error would have
been very natural.

But just to keep the pattern with some of the other users, and
minimize my surgery, I made it just return 'bool'.

I'm sorry to do all that surgery on it, but I just couldn't stomach
doing anything else.

The resulting merge diff is fairly messy, and to make matters worse I
can't actually *test* any of this. But the code looks more palatable
to me, and I did try to be careful about my surgery.

Apologies if I broke something,

            Linus
