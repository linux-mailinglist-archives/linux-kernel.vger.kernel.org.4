Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DF85F0D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiI3OKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiI3OKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:10:13 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A83A5F80
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:10:10 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id e145so5361990yba.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DsDpak4hGP9eOQqikyTZRbcLuJcQ1VFkpeBTwP7Tglg=;
        b=cKTwlKQSMUY6uDctsm5SrLjchJI9rQzQhlcplGxLuO9/jzzixwYQ6iGA+x70gaLIyf
         D5rV2WTYTrGPXnuWnW4I2k34Lm4Sh9cCrV0ZhlbgpEyrtEzwOf6gjiv4Oi5/LL7xDplN
         3hWJPN6oxbLBD6uMtJyIq/rxORsZPm4jg8Wpn5s3SeClJyTZGjK9RMTPzKdCEFdsPo5m
         27hEL/L8rIl0AlmhnGU6rrKzFiZ0YX4rDvdSUgSJhugMAhSb6yhuHntly9zEr0Re3e7u
         QS+XUFxiWdGaewNbTKc5HvxHc60He+02gCZzpsBn/4Stwr9nShRBaEfT9sb7uyHn4uQR
         /v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DsDpak4hGP9eOQqikyTZRbcLuJcQ1VFkpeBTwP7Tglg=;
        b=WH0AB/M7ZwzlVVHqKGQtvKn0Z2Hp6Ju2PIszgc917whi8a+6Myk7Ox/zkhyfwIZdW+
         HbChjntR966oBkLZ2xJBsVQwYNJGrsU3taBQdFF5lwgcLPiHMWyvFMMDCs4XeS48N1HM
         nsgjICO5Lys2FKTuSyg7S5woPxKw8MWfYyf0r7BGYULFPblGR0EtvZqM9MFd0NHUCBRG
         oe5RIxLhvT4rUGAgK3TYiC9L7pdtD4UPFWb7wSfGmFYzjZTK0c18OSgUxjwA6bCW15ek
         wl2p6NlAr4iHlyNcbYVI9jXNizS0KlkzgqnHJMmBMD466F8/ar0HChk6FAt6dOYwFISR
         u2/g==
X-Gm-Message-State: ACrzQf0NRv+K5+jimFA1zUuXOTeC6oYjVmjcPTJdUNSyixZVXr2JKGcB
        uEqHwQN3xW7RmFqsW1BatUgZZe45e5NFOEUeqGMZFw==
X-Google-Smtp-Source: AMsMyM4bYGIr/YojNkWActQYGGG+goRSFSZWwk+hqiwEg7gC8d11FKELyxohMTv2TxTqiT1XVRw3LdSzuGw8Fh/Q/7Q=
X-Received: by 2002:a05:6902:100b:b0:6af:cda:704d with SMTP id
 w11-20020a056902100b00b006af0cda704dmr8118126ybt.584.1664547009228; Fri, 30
 Sep 2022 07:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008ea2da05e979435f@google.com> <0000000000000f962805e9d6ae62@google.com>
 <YzYFIK/jFiN6WEzT@ZenIV>
In-Reply-To: <YzYFIK/jFiN6WEzT@ZenIV>
From:   Marco Elver <elver@google.com>
Date:   Fri, 30 Sep 2022 16:09:32 +0200
Message-ID: <CANpmjNPXPoguZAS9L0XPey4=XX1NSTDEB_mA7j7t10FThefuUQ@mail.gmail.com>
Subject: Re: [syzbot] kernel panic: stack is corrupted in writeback_single_inode
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+84b7b87a6430a152c1f4@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Hrutvik Kanabar <hrutvik@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sept 2022 at 22:50, Al Viro <viro@zeniv.linux.org.uk> wrote:
[...]
> ... and you _still_ have not bothered to Cc ntfs maintainers.
> Once more, with feeling:
>         If you are fuzzing something (ntfs, in this case), the people most
> interested in your report are the maintainers of the code in question.
> You know that from the moment you put the test together.  No matter where
> exactly the oops gets triggered, what it looks like, etc.

Apologies - we just updated syzbot to do better, so for bugs like this
it should now pick appropriate sub-filesystem maintainers.

Thanks,
~~ Marco
