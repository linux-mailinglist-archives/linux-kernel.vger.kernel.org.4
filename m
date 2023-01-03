Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BA265C656
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbjACSfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbjACSen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:34:43 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F8FDEBE
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:34:42 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id i20so25193643qtw.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 10:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=muXoXr09Ni3EPICWvir7vBDsaSgmM1rYXROjrrwoGGo=;
        b=OLptXjoClQiBciSmwfDhwX0nKTPEJF5Tu2eLQxuc+SPV2+11g0wlm+HyFqwcVxgvSb
         hraqOuuUMXnmeENiBkxXpRBeE0J58GRjKauW1tIGHo10Wa9OfNOCF+a/zCSOrTzpr3vi
         DiS3LQN02cbG3XU51YJqj54XYc2lgbAYruyJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=muXoXr09Ni3EPICWvir7vBDsaSgmM1rYXROjrrwoGGo=;
        b=MSPHZEc6IKm+KHyb86IybGTY6S7Car21QD+vgfxufp3NfMuccEgE2FotAQkD4Pso3F
         jtj/i9d4RJJoV305xQPCCT/FWt6i7COKqzk6yhVYdZGAQtx9sV5mLQG/Kn1tG1FDADIW
         17FfUT3mwLOInI417/Nh+/g1I7jNiJXLhQ+uwrpo5jWIasO1TcAfmOqp6K7i3wH1ZyyA
         Pd8Ospg4lE0SI/qocJB7lg1geZozA25EC2UN/bg+NnJm3mOv4QnoX4PqwPtC6y21Km4p
         K7QaVvpNCVyq1NsWnIEZVGv4IC0sT8y6CwiaWjfZ61x7VEZeTIzfpCqL7rf+00v/8kfl
         b+Og==
X-Gm-Message-State: AFqh2kpkYLS4gh0appM1Wn2GxFuTBBVTvoCH3+OdCx0P07SqYu7oGVp7
        vrwRilqX0IB2rynHmXxIgc3T9cjU/6G328Q7
X-Google-Smtp-Source: AMrXdXuIOCakTsWYcu5yCt0gbSX17fw+a34NP5T9jWMtZGYMqgDuW+N0EhZQ7S3Kl6OHaDTlZvF4TA==
X-Received: by 2002:ac8:47c3:0:b0:3a8:1f82:5b6e with SMTP id d3-20020ac847c3000000b003a81f825b6emr60688033qtr.5.1672770881531;
        Tue, 03 Jan 2023 10:34:41 -0800 (PST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id fe11-20020a05622a4d4b00b003a50ef44a77sm19373046qtb.28.2023.01.03.10.34.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 10:34:40 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id v14so22439040qtq.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 10:34:40 -0800 (PST)
X-Received: by 2002:ac8:67da:0:b0:3a5:122:fb79 with SMTP id
 r26-20020ac867da000000b003a50122fb79mr1190222qtp.452.1672770880477; Tue, 03
 Jan 2023 10:34:40 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
 <20230102225656.GA3532398@roeck-us.net> <CAHk-=wjZPPscjDhsHQw_ttHOaQS69rADLm0KuRhbNavBiO62OQ@mail.gmail.com>
 <20230103014535.GA313835@roeck-us.net> <CAHk-=whmeBkyu3iS_s-yk0=t3GEoW3sQb-wJFHKykOjG=iQVFw@mail.gmail.com>
 <CAMj1kXHqQoqoys83nEp=Q6oT68+-GpCuMjfnYK9pMy-X_+jjKw@mail.gmail.com>
In-Reply-To: <CAMj1kXHqQoqoys83nEp=Q6oT68+-GpCuMjfnYK9pMy-X_+jjKw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Jan 2023 10:34:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg6K2qge_MWHX9DurBUpbd54ih482gV5rf8ts7v8TUipA@mail.gmail.com>
Message-ID: <CAHk-=wg6K2qge_MWHX9DurBUpbd54ih482gV5rf8ts7v8TUipA@mail.gmail.com>
Subject: Re: Linux 6.2-rc2
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
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

On Tue, Jan 3, 2023 at 2:59 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The purpose of this change is to prevent .note.GNU-stack from deciding
> the section type of the .notes output section, and so keeping it in
> its own section should be sufficient. E.g.,
>
> -       /DISCARD/ : { *(.note.GNU-stack) }                              \
> +       .note.GNU-stack : { *(.note.GNU-stack) }                        \

This seems to work for everybody, so let's go with this. Masahiro?

               Linus
