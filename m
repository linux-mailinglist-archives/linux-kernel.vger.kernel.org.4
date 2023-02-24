Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D8B6A24D6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 00:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBXXBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 18:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBXXBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 18:01:36 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E08B66946
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 15:01:35 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ec43so3291448edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 15:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg3E9MD03sMZ5EAXXDkRbOWuc4O2GoPxS+AaaBN2r9o=;
        b=SS2lXO49JnG1/vM1ng6i05vmXKtRlYWwABgq0Qu/efvdwaym+x/YMOImEryB+YmS1Q
         DKDbVw+CGs27Dcz/kl6vXHzN2BA3DRUvswyZN6u8kZmb5PgmZ/R6yV+XH3ioHh83B+RO
         3wOcg4VreRoYI4T86GyzREuqp/ND+S012VaAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wg3E9MD03sMZ5EAXXDkRbOWuc4O2GoPxS+AaaBN2r9o=;
        b=k00OhogzSvaVq0SycyG/0uHUTzKOcIgttLCbCtq5HtZhFuoEYXdKHOBFR2Pz8XX9bK
         WNj6BGGlsIgSsusA8+BDTZUpt6ehggkZX+9zieHPMePeqkVt/oMcyQfyBjui4bzx3Nkz
         K88harZfNChkQeQ7Zy6/GkVY/Ptekf6Rh/SKSyCaWi91c2hlFhMketq8c1WXjnmfYNCJ
         qHe+/Fi+VhjrgA8gk5NDTE+F4Q8rZBDO9Vqou4vFiaFgcBfkHhn5FNQgOS5zKhGBnjhr
         08LnSPPllmnbb7MZqCvOTl2FudnE/HuOccjeGh3l6NQ50Emzy4CI47L6KfkpB9tWI3PB
         8qnA==
X-Gm-Message-State: AO0yUKUoAJugdYx6pGybnX4rbMA1HFht6yL921GjETYoKssV/FZWxdju
        1IIYe2s9WuLsGNzm0azK0VaLAIamtCJk6wVRiZhLnA==
X-Google-Smtp-Source: AK7set+970zpKZCqFeamE/FvUvQQnKz0ryK2rRMTan4ih8z5Q8bjtn/E5sohPnpgfTCtumkUKmseNg==
X-Received: by 2002:a17:907:76ad:b0:8b1:749f:b2bc with SMTP id jw13-20020a17090776ad00b008b1749fb2bcmr25343606ejc.11.1677279693191;
        Fri, 24 Feb 2023 15:01:33 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id y23-20020a50ce17000000b004af6163f845sm233769edi.28.2023.02.24.15.01.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 15:01:32 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id o12so3276298edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 15:01:32 -0800 (PST)
X-Received: by 2002:a17:906:40cc:b0:877:747d:4a82 with SMTP id
 a12-20020a17090640cc00b00877747d4a82mr12083350ejk.0.1677279691776; Fri, 24
 Feb 2023 15:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20230220152938.45f62d5a@canb.auug.org.au> <Y/ODNJ3MfoD6dUru@casper.infradead.org>
 <20230221175436.599166f9@canb.auug.org.au> <20230223144722.635ab483@canb.auug.org.au>
 <5f228150-0e29-6d58-3dcf-776bc2a630b7@gmail.com> <20230224161128.0949d8ae@canb.auug.org.au>
 <CAHk-=whssVtOq-6r-n6+=gVLC=zXCsr5TBq6Ke+JaGeQW3d8Cw@mail.gmail.com> <Y/k4Jvph15ugcY54@mit.edu>
In-Reply-To: <Y/k4Jvph15ugcY54@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 15:01:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjnL81j5WvDr_R3Rg9k9fw94RxRM0xJsQgiWUjPZimF5w@mail.gmail.com>
Message-ID: <CAHk-=wjnL81j5WvDr_R3Rg9k9fw94RxRM0xJsQgiWUjPZimF5w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mm-stable tree with the ext4 tree
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
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

On Fri, Feb 24, 2023 at 2:20 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> 3)  I'll then send the ext4 dev branch (minus the data=writepage
> cleanups) as a pull request to Linus.  Next week, after Jan has a
> chance to review my patch conflict resolutions, I'll send a second
> pull request with the data=writepage cleanups.  (As usual, I'll do my
> full set of test runs before sending the pull request.)
>
> Linus, are you OK with this plan?

Yeah. I think the whole "do two completely different things to the
same area in parallel" was horrible, and we should strive to avoid
that kind of thing in filesystems in general.

So let's just serialize them instead of doing them at the same time
and try to merge them together.

Even if the merge is then successful, it just seems unnecessarily
risky from a "what if somebody reports a problem, and it bisects to
the merge, and then we have something subtle going on".

              Linus
