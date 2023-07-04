Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74C07478CF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 21:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjGDTtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 15:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGDTtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 15:49:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A657610CF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 12:49:21 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991fe70f21bso690613966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 12:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688500160; x=1691092160;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h4y4pe8nKPNc3vbmtQQZLZUBLO/NbEWrS8puocb/Up0=;
        b=H36zhe0MwmlWlO2lW0dYKtdnedoDkVIl2291itwlJI8sIg2XeNIr94M7/xGlBhV8H2
         yjkF2b5dOSdGBQatMXvp+K10wU9IyGPI5Wi43Zc5b0jedNf/fNo9UkT25qbwgdgESQmV
         0vOLHJTSY/plvO+6TQFOZZOdcCh6hIwibOYlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688500160; x=1691092160;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4y4pe8nKPNc3vbmtQQZLZUBLO/NbEWrS8puocb/Up0=;
        b=bOMJXqDj9nrJ9Fdoa1yVrazOkw14/tjM9IOmx0C/Ag7N/0HfYhyVsSsiI+K/8/SPzx
         j7vurprUyq1qJoqUqeGJVPHIzWtKDB8C49MlMH4S8H3d1iP2b87yAr07JN8GjGMrn/3u
         NBQYtmcsw0UpTURffveTFgzON2U5AhDDAM+kSEtjCqUxFx11B5M/4iPexdVvRhcn/qkQ
         4iwAzHSzMzwwXPPuJ9RG3EnB1OViLfzsYKk/PtYqxGIGWZ1fI5HOE8Vw9c82nfZkdoAW
         HyoS1NawyaBKJOpynOZxOb94u7eKm/45ahhGbChln7Dsc+jhoa8HosHGNcTOyH4wYYxk
         129g==
X-Gm-Message-State: ABy/qLYk//OruQcUf6JjcawG9XYjlrrsufxYrCPxC2Ani8C6AoYmwwTy
        gG82We/7iCc9Y1Blg6KaEq+IJ7FLFKgpuEtjDgHJ+3sf
X-Google-Smtp-Source: APBJJlFka2d77RX2sjWFckYlsHWq+E/H/wLFH9PFXwWQuQDa//rn27b0NZVdy2Z7X+N6WUmPiZJkEg==
X-Received: by 2002:a17:906:3516:b0:978:8e58:e1a9 with SMTP id r22-20020a170906351600b009788e58e1a9mr9803415eja.15.1688500159875;
        Tue, 04 Jul 2023 12:49:19 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906948e00b00988b86d6c7csm13694623ejx.132.2023.07.04.12.49.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 12:49:19 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51da8a744c4so6638913a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 12:49:18 -0700 (PDT)
X-Received: by 2002:a50:fa96:0:b0:50b:c693:70af with SMTP id
 w22-20020a50fa96000000b0050bc69370afmr8998604edr.2.1688500158487; Tue, 04 Jul
 2023 12:49:18 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jul 2023 12:49:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
Message-ID: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
Subject: Overly aggressive .gitignore file?
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

So this keeps happening to me - I go to apply a patch I just
downloaded with 'b4', and I do my regular

     git am -s --whitespace 2023<tab>

and the dang thing doesn't autocomplete.,

The reason it doesn't auto-complete ends up being that my kernel tree
contains some other random stale mbx file from the _previous_ time I
did that, because they effectively get hidden from "git status" etc by
our .gitignore file.

So then those stale files end up staying around much too long and not
showing up on my radar even though they are just old garbage by the
time I have actually applied them.

And I always use auto-complete, because those filenames that 'b4'
generate are ridiculously long (for good reason).

And the auto-complete always fails, because b4 just uses a common
prefix pattern too (again, for a perfectly good reason - I'm not
complaining about b4 here).

This has been a slight annoyance for a while, but the last time it
happened just a moment ago when I applied David Howells' afs patch
(commit 03275585cabd: "afs: Fix accidental truncation when storing
data" - not that the particular commit matters, I'm just pointing out
how it just happened _again_).

So I'm really inclined to just revert the commit that added this
pattern: 534066a983df (".gitignore: ignore *.cover and *.mbx"). It's
actively detrimental to my workflow.

I'm not sure why that pattern was added, though. These are not
auto-generated files from our build.  So before I go off and revert
it, let's ask the people mentioned in that commit.

I *suspect* the thing that triggered this wasn't that people actually
wanted to ignore these files, but that it was related to the misguided
"let's use .gitignore to build source packages" project.

But at least for me, it's a real problem when .gitignore contains
other files than the ones we actually generate.

The only one that actually commonly affects me is the *.mbx file,
although I could certainly see the same being true of the *.cover
thing.

And there might certainly be other patterns like this that I just
don't react to, because they don't have the same detrimental effects
on how I work.

Comments?

               Linus
