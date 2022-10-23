Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E15A6094FC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJWRG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJWRG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:06:57 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3453172FF4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:06:56 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a24so4524365qto.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kOUgJwP9L3v0DckAUfe63NOI3jJFAkRIP3oOVWHsOHw=;
        b=a1rQ1It9tKFigGcY/5mjnzWCZuD7Rl2ZuaPYzwHFWSMznJ5PYK6eZx/kMuv0KrLDUt
         qz4o4vVGAVPRrHoquKPMtxKYQHvyrT3cJzJFsvM9xLlvG7Vw9zKz5zGq7xxPSsLacdpy
         9MUm6wjYT7393yl4CMI2l0/bbG4i9OuxitfYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOUgJwP9L3v0DckAUfe63NOI3jJFAkRIP3oOVWHsOHw=;
        b=mxYritb9mVrVf01YpKLIU4iYT+XKGANBN9W3O1ucAR8jSZdZZg6GKj0EFa8EWuWDNK
         E6PQlwC6rnDN5DkZlVKnsur0jGZbojKRIKAz1fEEy0zjL5NeIzqOhXUKL9eD+hOXPqXI
         WfjMviB3yiITPcNprNwMIdw3TEDQ+FQhFjJcoTf8A/jMAQHhEsijCaYqJFQmTr7Ru7Bj
         MCBqCTWQFbJTIDzV/rA26a7nVNHYdcrYq49MeXNH2kofyaCufN0/lPryYu5AygwtXDvF
         vLaeP0VbgECqQpZPcQrrm3k86CVFr4ZzBnluvSl1fYHNOFOXtikBapsvbpU5CkYhFsiA
         //jA==
X-Gm-Message-State: ACrzQf2/FcK5UyApzXfcLGIQ2g1W7wPm9hHKsKwkzXxLwiu+cjne0Cc/
        q6wZOumrL6mXzauqz6UBLsNaN6x7UAJGLA==
X-Google-Smtp-Source: AMsMyM6mwBWLfYE12OkaR6nOn3ROSGcAumxMB/U+fglbm1lucqod00EPHOSk9VuqH9rgfqAzKXer7A==
X-Received: by 2002:a05:622a:214:b0:39c:de63:2580 with SMTP id b20-20020a05622a021400b0039cde632580mr24276224qtx.31.1666544814986;
        Sun, 23 Oct 2022 10:06:54 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id fd4-20020a05622a4d0400b0039cd508f1d3sm11541159qtb.75.2022.10.23.10.06.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 10:06:54 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id o70so8752009yba.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:06:54 -0700 (PDT)
X-Received: by 2002:a05:6902:1352:b0:6bb:3f4b:9666 with SMTP id
 g18-20020a056902135200b006bb3f4b9666mr23956344ybu.101.1666544813909; Sun, 23
 Oct 2022 10:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <Y1ULKYsASLRoVb7N@zn.tnic> <Y1UPYnju4qOTsusI@zn.tnic>
In-Reply-To: <Y1UPYnju4qOTsusI@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Oct 2022 10:06:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0afQB2odHZcfmtymR0q9wJEO8gGQo_Cob+KHgsimG5w@mail.gmail.com>
Message-ID: <CAHk-=wj0afQB2odHZcfmtymR0q9wJEO8gGQo_Cob+KHgsimG5w@mail.gmail.com>
Subject: Re: [GIT PULL] x86/urgent for 6.1
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
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

On Sun, Oct 23, 2022 at 2:54 AM Borislav Petkov <bp@suse.de> wrote:
>
> Whoops, I mistyped the version in the tag. Lemme know if you need a
> properly renamed tag: x86_urgent_for_v6.1_rc2

Heh, no, it doesn't matter. As long as the pull request is unambiguous
(which is only really an issue at the end of the release window when I
start getting a mix of last-minute fixes, and early pull requests for
the next merge window), it's all good.

Nobody will look at the tag name afterwards, so the tag-name being a
bit odd doesn't really matter. In fact I often edit out the free-form
commentary in the form of "This pull request for version Xyz does.."
from merge commit messages people send me, because it's not relevant
or interesting in the history.

But hey, I appreciate the heads-up about the name mix-up (although,
again, the only time it tends to actually matter is for that
end-or-release time frame where there can be actual confusion).

                       Linus
