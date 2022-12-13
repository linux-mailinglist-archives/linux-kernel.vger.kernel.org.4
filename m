Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B39264BE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbiLMVJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiLMVJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:09:23 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C88388F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:09:22 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id x11so920273qtv.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tnFbRblvIAohtXsS7HtysL40uwtBJKnVhVEm0LDo430=;
        b=dQWkUQxFj3P4omRlo7FZ86ewcpHN7+hUf6yRLTiBKl68oUlZCERjUMbzraBwjOUQxc
         Q4WUyopqarJTZAEbZMxLL9Jcx9WNGUOdxTt3WmGNu3srsxh5TpgLzn8WgxCCyy8vG37C
         WhbqICC+7p95glWwhF9knsew44gEzDXsUGWGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnFbRblvIAohtXsS7HtysL40uwtBJKnVhVEm0LDo430=;
        b=uVH+6wC2sjeWwaO4O0YBIYUg8e7NbW9E2731+WH6106mEYS67P5KBupvLjTY3CBT8E
         vah4D83vhUTMtq2FYkmGZmgWR5SpbNnJ1NE2C3B3f5ZtCwhADl1O4hhHi2JO0Lv2kqEL
         D1EfbbhfqFDQSCrCklsFLvZfuFl5ArlvX7GbeYB3O2nYJ7iZYyFuWGkSLPB6922KJjLx
         gEndIF7xjDDHDJ22+A1p4lDEvi8uVJsz7iaPecLek0yA/XtDcU3B3x1HZh6FEKltw6sq
         0wXM3SlKq3iRBQV22p/8fVHooeX3dNQU73QEgQqYVON4Tpc+9BlpJgCty15Bg9+KrLmh
         k0yg==
X-Gm-Message-State: ANoB5pkioE6kPguVZhcKOib7RjlgD5k/llSNC7FJR9AX2M4zqlo72lvG
        pUbGYbSI7cP6SqoZTbIS/cuXZb9EfxeSYZzZ
X-Google-Smtp-Source: AA0mqf593Mm56gEJ29sq3bSPnow75qjAvXMxdLt/b+RJCgs0zeSnhd5PbSZZMAJv0soDE8JoUrmBeA==
X-Received: by 2002:ac8:7c92:0:b0:3a4:ec42:8f1f with SMTP id y18-20020ac87c92000000b003a4ec428f1fmr27467485qtv.61.1670965761274;
        Tue, 13 Dec 2022 13:09:21 -0800 (PST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id he15-20020a05622a600f00b003a591194221sm531602qtb.7.2022.12.13.13.09.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 13:09:20 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id a16so927799qtw.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:09:19 -0800 (PST)
X-Received: by 2002:a05:622a:1745:b0:3a6:8b84:47ce with SMTP id
 l5-20020a05622a174500b003a68b8447cemr33504512qtk.678.1670965759633; Tue, 13
 Dec 2022 13:09:19 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdYZDXH=_Mgv0u+B8btLjFcCSTboWFXH4u1h9V=WqLEJQA@mail.gmail.com>
In-Reply-To: <CACRpkdYZDXH=_Mgv0u+B8btLjFcCSTboWFXH4u1h9V=WqLEJQA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Dec 2022 13:09:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiK9DDH-sE7V1t_QF89nc=uEMt9mhL=LFR1a3R2AK=_ng@mail.gmail.com>
Message-ID: <CAHk-=wiK9DDH-sE7V1t_QF89nc=uEMt9mhL=LFR1a3R2AK=_ng@mail.gmail.com>
Subject: Re: [GIT PULL] pin control bulk changes for v6.2
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
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

On Mon, Dec 12, 2022 at 5:16 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> What has however conflicted in linux-next is pinctrl and the SoC tree, see:
> https://lore.kernel.org/linux-next/20221206121336.474457bb@canb.auug.org.au/
> this was caused by a merge path misunderstanding, so now it becomes
> your problem, congratulations.

Heh. That's the spirit! It's the season of giving, after all.

> However as you can see the resolution is fairly trivial and available in linux-next.

Yeah, not a problem, this was a very normal conflict.

                  Linus
