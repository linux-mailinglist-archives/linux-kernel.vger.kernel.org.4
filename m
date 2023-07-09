Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EB774C69A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjGIRVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjGIRVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:21:00 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427DC126
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:20:59 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9741caaf9d4so417291066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688923257; x=1691515257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3d7q2/vlt5YrrWAL09ifVs1xvdjL9WjQiw4+TgpXhUg=;
        b=AFkNHHxGZLKlaAM85wjkAakAlx727nrL8JPLrVtWCSwSyqtLj83hyIKVISKN8dbQCy
         qDPEah08I0qCJS8/LXiD20SY16fA3kPmLwKHYnEV+t3GdtkFeNXqojzr4cn5W9yyy/9F
         D0WIGzoqQ66QZK7tWQkiawf5EWr3vU7s0wQlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688923257; x=1691515257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3d7q2/vlt5YrrWAL09ifVs1xvdjL9WjQiw4+TgpXhUg=;
        b=DS2KDDQ8xbvEkgn3RJR8oUx0tPvc4ZuFelRXEqYDQUd9SjkOMeTU3Md/39QywQb5uz
         u3QSz2jhpqJdvBbfYtCWipSOkGB+LmvEzvbcNt3o84fpjhSg5MM1dSEjKzfG86aJ79Id
         JMyb0BN9CLTTTNPBUsg5SvgwJ7Lw/kepyUlmA+c5YdCViAISSZiS/+NwXUv8vlTecf4p
         nNYOfuZ0ZzVO+EtEwvkFGqCiVJnxkccz2BGw8iqs93FjyFXmAYqwVrnT+nJrdz9Ub3rs
         FXu2ce6NgbUtAQ7QKh+9NdjCH5bthtggOoy7qjFrb3ibZHzd6a0cYjdYt/wu6TaUSLGd
         m79A==
X-Gm-Message-State: ABy/qLZonSsY9dP5AJjt2FpATfVCTh/HBEmKFAsfYYlZs8JZWkQkczhA
        Fe4af/+PidrGFZ2zgO/0Ws3xiNOgZtKwKWjA7GZor0El
X-Google-Smtp-Source: APBJJlE5+Wc+MM7QvMVF3SbaPxsRD3xRjOcFJlArAJgXdfN1RSAdw4ucMLzcPCOVYdi0EUP6wlbVyw==
X-Received: by 2002:a17:906:f8ca:b0:992:7329:fe4f with SMTP id lh10-20020a170906f8ca00b009927329fe4fmr8580379ejb.73.1688923257563;
        Sun, 09 Jul 2023 10:20:57 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090616c900b009932337747esm4996091ejd.86.2023.07.09.10.20.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 10:20:56 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51e56749750so580623a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 10:20:56 -0700 (PDT)
X-Received: by 2002:aa7:d959:0:b0:51d:ece5:afd9 with SMTP id
 l25-20020aa7d959000000b0051dece5afd9mr9169734eds.21.1688923256422; Sun, 09
 Jul 2023 10:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230709081903.GCZKptd16D1sbcDoIy@fat_crate.local>
In-Reply-To: <20230709081903.GCZKptd16D1sbcDoIy@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Jul 2023 10:20:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiY8nehcZfNA6vo_vws7TqvwcDrPNt6_McqkHXs4zbuNw@mail.gmail.com>
Message-ID: <CAHk-=wiY8nehcZfNA6vo_vws7TqvwcDrPNt6_McqkHXs4zbuNw@mail.gmail.com>
Subject: Re: [GIT PULL] objtool/urgent for v6.5-rc1
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2023 at 01:19, Borislav Petkov <bp@alien8.de> wrote:
>
> - Fix a post-merge semantic conflict due to btrfs_assertfail() not being
>   a noreturn function anymore

I had actually applied this directly last week already, since it was I
who had missed the semantic conflict.

See commit 06697ca69bca ("objtool: Remove btrfs_assertfail() from the
noreturn exceptions list").

Your pull request would obviously merge cleanly, but I'll just skip it
as "nothing new".

                 Linus
