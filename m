Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A4D5FA2E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJJRtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJJRtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:49:01 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6B06AE93
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:49:00 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id l5so13437736oif.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t6AnctMq6jcWU65azFD7ujfCqCgsVowVLieEc9E+DWw=;
        b=QOeVBRQN+Q6/JVqyQ1QSzTDGyA0KnWKs7yemkDcgaOGwHMfi1On4bqzJeZSoaaimYK
         gv0mf2riBtms9yQCuXGaCIhu/kcuwGiWIlB/jUOQHSEFVboYF5I32sx5XlbRIGvJ6jeF
         TA9b8h4qpdaohbQvOvC9NjNY0CQu1ikEyfa+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6AnctMq6jcWU65azFD7ujfCqCgsVowVLieEc9E+DWw=;
        b=VuZNDFSdScT7GnZgvM1qPgTJAQ1qWNguDpWksXO/5ApPbuQ5N9Ogqi7M3Hr6rWf76I
         PPEiS49ivdpcwr8K0MEng7V996WdyvtUxZc1Feb7N41ElQMALtUapQ42yCnefD1px6PQ
         cBdoSl+EyCB0t0yiqRU67qDeA1dEBaGEaZ0ojqPQYfJsnuoeZUAI4GO/ZdLrzH7WkPlM
         llfLKA/VOSI0ahxmxQfCHpjnXKvvHkYsq81LEHpwHNZ8tK30Fv23TE3vnC8iodwk0+CH
         ttLjAAq3SnD2CcTX5OLL34QLWv8b3tPZbl4lmzYC9FOTw1kJHgaG3Rgxgd5TBCVMeANO
         I0yQ==
X-Gm-Message-State: ACrzQf26LC7Xfz990pv9qrasj5TchO80JYWg/8O8kdb9akyXYMKOE7fG
        3eqSyZoa0o8f2hitdGrGKpNOAB/aEtWTqA==
X-Google-Smtp-Source: AMsMyM6wz/HimEOFlTYIHxvs9J/TIl5wGoRzQgMEG8u7lbf0OG7E1XXyRxRMx1Lzi1Ezvqcv7u5K0w==
X-Received: by 2002:aca:be8b:0:b0:353:b991:398 with SMTP id o133-20020acabe8b000000b00353b9910398mr10141500oif.17.1665424139651;
        Mon, 10 Oct 2022 10:48:59 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id g36-20020a9d12a7000000b006619fe836f9sm1116327otg.55.2022.10.10.10.48.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 10:48:58 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id o64so13420928oib.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:48:58 -0700 (PDT)
X-Received: by 2002:a54:4899:0:b0:354:add8:52ab with SMTP id
 r25-20020a544899000000b00354add852abmr1323762oic.229.1665424138521; Mon, 10
 Oct 2022 10:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221003174431.1189919-1-Jason@zx2c4.com>
In-Reply-To: <20221003174431.1189919-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Oct 2022 10:48:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGc7MYRW=vXyY-m_r9c7-_i8k1nsHM0RuJw_9qZWWP9g@mail.gmail.com>
Message-ID: <CAHk-=wgGc7MYRW=vXyY-m_r9c7-_i8k1nsHM0RuJw_9qZWWP9g@mail.gmail.com>
Subject: Re: [GIT PULL] random number generator updates for 6.1-rc1
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
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

On Mon, Oct 3, 2022 at 10:45 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> - The original jitter algorithm intended (I believe) to schedule the timer for
>   the next jiffy, not the next-next jiffy, yet it used mod_timer(jiffies + 1),
>   which will fire on the next-next jiffy, instead of what I believe was
>   intended, mod_timer(jiffies), which will fire on the next jiffy. So fix
>   that. (If you did actually intend the next-next jiffy for this voodoo, let
>   me know and I'll happily send you a new pull.)

Just as long as you verified that yes, it will actually do the next timer.

At some point we had timer logic that went "trigger timer callback
immediately if it was in the past". I didn't want to have to worry
about that, this the "jiffies + 1".

I suspect we long ago got rid of that "trigger immediately" because of
deadlocks, and that I was just being a worry-wart about behavior that
we haven't had for decades, so your patch looks fine. But you might
want to make sure.

                   Linus
