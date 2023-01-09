Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A7D663402
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbjAIWfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237856AbjAIWee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:34:34 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD51183AB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:34:33 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id qb7so7341273qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 14:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EMSZpqLoelwVL3RJvee/aXBXiDqbnSM5XzpQm7l2pMw=;
        b=X6h3npwjtEyOy3oAqdRDLqD+PojsSLHre8gy1KpEzrrCpBRS1SMbr1l7FaD5ob73vo
         vizEFUB2X7TRuxcta0zMVC52gMyawbptyC4C77BrgI9R0YVJqfodI/CR0TuKRiWdAM6B
         /C2uiJlQJwohEU1G9y717N7h/2G/UIXs4Enyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMSZpqLoelwVL3RJvee/aXBXiDqbnSM5XzpQm7l2pMw=;
        b=UMmLBd9iMODEa/mbtDE9QaoobeiLvFYPziWvehzuRE4Vvbpdpy2/xIDwJ/safiQG76
         IekMfd6ACnPybPx3pcns0xCWk65Y+xrJfgX5wCEf1h0NpM+Lcj0Og0HBkXlKx2xXpCtf
         s3fxgR8wAo2JRGCPf4aqPP+4M2eqL68bJHGIwFA8Xj1iideUrWBVTSQWzkLl50HrDoRo
         x2HAnLcGYU0bR3zSxL2GtwM/2QIQPKzb52cDRS2bxGsw8iBvanTz8EvnSW1tKoNXYYBb
         kMZtSw8y+7uEQ/JZcT8NN7L+bXP9SQ68OI8gjMyT91TLclIpzEMtPsslVJAs5B3hd11A
         /Uxw==
X-Gm-Message-State: AFqh2kpj+XsQE34ayHEhN/UBAJtbWEFzqg0Ll/LbeH/2CO6jjpXitdM2
        70HgNEPTYO7PqNvRwcSzZVjxSz3qVq6VN/pTp7Y=
X-Google-Smtp-Source: AMrXdXvuyfqKqS/4MJ8blCv5qLJMCrzIG7hN5OwCQuupzktm1EqXpqcK7eBG+KjCHFxWFTaCi+Xo6g==
X-Received: by 2002:a0c:9166:0:b0:4df:59a8:b700 with SMTP id q93-20020a0c9166000000b004df59a8b700mr83804621qvq.42.1673303672322;
        Mon, 09 Jan 2023 14:34:32 -0800 (PST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id h18-20020a05620a401200b006fc5a1d9cd4sm6201937qko.34.2023.01.09.14.34.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 14:34:32 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id s5so4981691qtx.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 14:34:31 -0800 (PST)
X-Received: by 2002:a05:622a:2598:b0:3ae:db1:185f with SMTP id
 cj24-20020a05622a259800b003ae0db1185fmr145364qtb.436.1673303671540; Mon, 09
 Jan 2023 14:34:31 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjwrqFcC9-KkfboqATYwLfJHi_8Z5mTrJh=nf8KT_SjUA@mail.gmail.com>
 <20230109174742.GA1191249@roeck-us.net> <CAHk-=whC+YpdympyegB0Wr_0_6=LYggdabkMExRus2DtAdsv-Q@mail.gmail.com>
 <CANpmjNOmDp_sZgRuks3OZfT015vLwSKcfdFFC=yLGPUNOxnecg@mail.gmail.com>
In-Reply-To: <CANpmjNOmDp_sZgRuks3OZfT015vLwSKcfdFFC=yLGPUNOxnecg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Jan 2023 16:34:15 -0600
X-Gmail-Original-Message-ID: <CAHk-=whGP8c9J96mvMqUu96DmFzgs8Gcg072_njEEwuym=Woyg@mail.gmail.com>
Message-ID: <CAHk-=whGP8c9J96mvMqUu96DmFzgs8Gcg072_njEEwuym=Woyg@mail.gmail.com>
Subject: Re: Linux 6.2-rc3
To:     Marco Elver <elver@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <kees@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
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

On Mon, Jan 9, 2023 at 4:30 PM Marco Elver <elver@google.com> wrote:
>
> The 1.5kB array is being fixed by
> https://lore.kernel.org/lkml/20221231004514.317809-1-jcmvbkbc@gmail.com/
> -- I suppose it's fair if you'd like to pull that patch right away, or
> wait for the next PR from the xtensa tree (Cc Max).

I'll wait for the pull request, and hope that this gets in by rc4 and
we don't have another -rc with this issue.

Hint hint,
                Linus
