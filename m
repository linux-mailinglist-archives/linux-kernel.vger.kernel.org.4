Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6977B74067D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjF0WgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjF0WgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:36:06 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D476C102
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:36:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51d9123a8abso3992202a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687905363; x=1690497363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zsdnBmMjPd9jj5iSbNeuekac37JTK9P9U9w8CL0+t24=;
        b=ZU4XTyh6wxe4WT7LkJI5PuCgGBOoFCiYS04Bf2RKwo/rEDhZ3uxeTbfDPFyJugvts7
         zIplsqkHYddHMwXwFMp53VyEK6AAmtuM1pV+r1QijSlAXtPM09AawENAjAv9nXqhSJq+
         +YdRIdB7eADSAkFqk5MpGTw1mU5r0Ei0B/p98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687905363; x=1690497363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsdnBmMjPd9jj5iSbNeuekac37JTK9P9U9w8CL0+t24=;
        b=CcZH0IhZNWG/G12SRneSVwDlbjoKvrbLafEP130BW0YAhjxJeREUTcywgAZSUE2LBG
         1r+dafyPk1YCh0wn2Jg1mYslWRFmjnaIfEEymlpdON/DyuyK1pA+YXHARywOgIkM4/TQ
         hQm/00I2igKEoIeLap0eTAfzpSHm/SlF70fBh6YvOjFru6YejJl4uU2zZygiM6fycjUd
         lRnfJw7vD63mlZsGBvrkdBVkPLS96FcRzrCr/uks5QBT1mC6P7xrMIvYI9i4NPS4feTZ
         faibO27/bMudPCRuQvHdRtglOCFm+OU6tYs5hi6ylGj8bBzJcZO32twPCdkosdEviugz
         UvLw==
X-Gm-Message-State: AC+VfDxGyQmHEA1pNK/D02gQizTjPTRKzHkBOy5eaXi01Fiqym9siq3Y
        YmExcGFHXf9c+/GqWB536dbTE1nwLzythjEccxpWmp3T
X-Google-Smtp-Source: ACHHUZ7Txl2PSgopoXHE+MXsqz8y+ugnaUOm8/cy9d1A8xX26oOIq/ukxTa10HzmT9IuGxrTixtOuw==
X-Received: by 2002:a17:907:802:b0:982:a454:6d20 with SMTP id wv2-20020a170907080200b00982a4546d20mr27134113ejb.54.1687905363238;
        Tue, 27 Jun 2023 15:36:03 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id lh8-20020a170906f8c800b009923998c8acsm851254ejb.20.2023.06.27.15.36.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 15:36:02 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51d9123a8abso3992182a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:36:02 -0700 (PDT)
X-Received: by 2002:aa7:ca55:0:b0:51d:9e0c:1396 with SMTP id
 j21-20020aa7ca55000000b0051d9e0c1396mr3815425edt.35.1687905361768; Tue, 27
 Jun 2023 15:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230627221430.464073-1-dinguyen@kernel.org>
In-Reply-To: <20230627221430.464073-1-dinguyen@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Jun 2023 15:35:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgh1CDUTJD+F_utKnbW6d=wApBMC4D8hMfOs15bAn23Bg@mail.gmail.com>
Message-ID: <CAHk-=wgh1CDUTJD+F_utKnbW6d=wApBMC4D8hMfOs15bAn23Bg@mail.gmail.com>
Subject: Re: [PATCH] Revert "nios2: Convert __pte_free_tlb() to use ptdescs"
To:     Dinh Nguyen <dinguyen@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        vishal.moola@gmail.com, akpm@linux-foundation.org,
        sfr@canb.auug.org.au
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

On Tue, 27 Jun 2023 at 15:14, Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> This reverts commit 6ebe94baa2b9ddf3ccbb7f94df6ab26234532734.
>
> The patch "nios2: Convert __pte_free_tlb() to use ptdescs" was supposed
> to go together with a patchset that Vishal Moola had planned taking it
> through the mm tree. By just having this patch, all NIOS2 builds are
> broken.

This is now at least the third time just this merge window where some
base tree was broken, and people thought that linux-next is some kind
of testing ground for it all.

NO!

Linux-next is indeed for testing, and for finding situations where
there are interactions between different trees.

But linux-next is *not* a replacement for "this tree has to work on
its own". THAT testing needs to be done independently, and *before* a
tree hits linux-next.

It is *NOT* ok to say "this will work in combination with that other
tree". EVERY SINGLE TREE needs to work on its own, because otherwise
you cannot bisect the end result sanely.

We apparently had the NIOS2 tree being broken. And the RCU tree was
broken. And the KUnit tree was broken.

In all those cases, the base tree did not compile properly on its own,
and linux-next "magically fixed" it by either having Stephen Rothwell
literally fix the build breakage by hand, or by having some other tree
hide the problem.

This is very much not ok.

I'm not sure why it happened so much this release, but this needs to
stop. People need to realize that you can't just throw shit at the
wall and see if it sticks. You need to test your own trees *first*,
and *independently* of other peoples trees.

Then, if  you have done basic testing, you can then have it in
linux-next and that hopefully then finds any issues with bad
interactions with other trees, and maybe also ends up getting more
coverage testing on odd architectures and with odd configurations.

But linux-next must not in *any* way be a replacement for doing basic
testing on your own tree first.

                  Linus
