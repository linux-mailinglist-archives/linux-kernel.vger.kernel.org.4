Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B0C68C769
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBFUQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjBFUQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:16:30 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EB12BF2C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:16:04 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x9so4862930eds.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 12:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T19J8kPZvf44xpubhvHPdVZxRQSXthgO97ymHQtN7Xc=;
        b=RjTO6MVzi55KUoms9dNcZXd4wKVbxuQvKmBG1or7HZg/j68skbpB/PoiBdKdgmUq1l
         TRZO9khr8i6KLeAPidoKodjfXTQhtJni/WNlG9eABWrQWUv6z1oWv5NSMySWYit2uJq+
         E2ZglfsGURJVxpYMZ+EnejJ7VR52aq+JwS2RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T19J8kPZvf44xpubhvHPdVZxRQSXthgO97ymHQtN7Xc=;
        b=Pb6KKB7c2dIlbLcQiBoImrloNYp9zs4M4bk01Ny9O8rAxy3JweomqbEu7IBRDMiUQA
         mYaO/NPsaQcZtcOqXjFY8rCU5SS8IupcmT8qSJ8gkRj0PIih5pzqolmJKSLfNObqMvxe
         sNfuOhQ6U8EuupU/ae+LNwL2mHFIs99Hc+mLXnE6msGxbsNOKRGRMBAnjfzLyBO0Mdgy
         +YM0i09nABQvl94CcqqFruS+5ETTnC1cZWonOWI+Zu+dOgYpu/dLBqUsEWdDIaBA/EDO
         41xViCy70F0yLmHbrhPV+EaSCLXgfxo2I3Pji8TdPoxDBdcsSqn+x0h53SwRV+fZEuKX
         yxRA==
X-Gm-Message-State: AO0yUKUrXqgisF0JKeLimrZzJxQDi7FJ2ZvSQ7zdRELp77GOlHLeQhG2
        t4fQZUkqsFkkkvozJnja/OrXdxMYbU64F16Ei63O4g==
X-Google-Smtp-Source: AK7set/KbfzxU/Hbducn17OOaHXdkEzs7Cj/3Njcyb6Uz8xKFsMvseaYz9TSmmCyQholx6Q4CgQixw==
X-Received: by 2002:a50:8746:0:b0:4a0:e234:5351 with SMTP id 6-20020a508746000000b004a0e2345351mr988706edv.15.1675714559447;
        Mon, 06 Feb 2023 12:15:59 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id s22-20020aa7cb16000000b004a236384909sm5538759edt.10.2023.02.06.12.15.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 12:15:59 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id hr39so8014147ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 12:15:58 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr166430ejw.78.1675714558652; Mon, 06 Feb
 2023 12:15:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675710734.git.dsterba@suse.com>
In-Reply-To: <cover.1675710734.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Feb 2023 12:15:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wge=yaJ47XewZ0n4EbOLh222M8mCjjmhZji=n--3eyupg@mail.gmail.com>
Message-ID: <CAHk-=wge=yaJ47XewZ0n4EbOLh222M8mCjjmhZji=n--3eyupg@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for v6.2-rc8
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Feb 6, 2023 at 11:55 AM David Sterba <dsterba@suse.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.2-rc7-tag

No such ref.

I see the unsigned branch 'for-6.2-rc7' but there's no actual tag there.

Forgot to push it out?

             Linus
