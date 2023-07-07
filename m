Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9146874B6F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjGGTMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjGGTMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:12:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCFB124
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 12:12:14 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so3717068e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 12:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688757132; x=1691349132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8RgAiRj/Ah9GpFVKQ42X3iF0te9OVig0xR7Tnv48JkA=;
        b=KBtj8DBLIvc+ld9MJdHlsAZraivfLO55rL7GtiKuwX5rEqWqeUQfPshtY+2tuA3T4k
         +78INjV8z14lc74qCfseqhhgLcSN1kS7tRrXN2C5846XV4rA0B/rnjt+kwZU8BwjKUD1
         H9qBdMYMxG+CA0wxxkI3NqA2KkFqXs5LPYKVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688757132; x=1691349132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RgAiRj/Ah9GpFVKQ42X3iF0te9OVig0xR7Tnv48JkA=;
        b=F/62OWiynBDWVPbBqyzOndHQ7GTuJUccUvmrdaJxOM9V/g5dwzUFJDbZuyQd78s2xY
         NMoENKdFkZ9A7i+V+pHAV06C2aHSGp0ezqwYMEqYgztpj0k0w7cY6E5LL4/bWOEEcdlg
         m4JyW1fhvfTMxu3l0M5yxILuGMjm++iMNigwBA21t5PuR91CPwCCPEK7QUczMVmMDCGz
         HpLD2lHpBmGVbEVaYukV2czIKjCjE7VHBxYrGvyVAYa0HhCjrvfeZkL8yITnk+VKopvm
         INqE4Bssj145qTtWC/gj4zAll22dLIsHpEIAVuJm3jXy9Bsf2GsLgvK9PDXDgYY1daJ+
         PAow==
X-Gm-Message-State: ABy/qLZdnftNhthHjwr8U04GViK6TDDH2Ky0XpzeH/8jS025jY5lbrGA
        XG0Rp572IdnN9AaphuqzoKrnPimKqPufEWKfgG9L+Rov
X-Google-Smtp-Source: APBJJlGHJ1MzMSPw63M+KiznB/9dHtIJcxQeS0KHe9L9tkXL0i0N6TcZ/Lap9dAXW3qSIImPpxJo1A==
X-Received: by 2002:a05:6512:3d28:b0:4fb:8802:9554 with SMTP id d40-20020a0565123d2800b004fb88029554mr5827313lfv.6.1688757132147;
        Fri, 07 Jul 2023 12:12:12 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id er14-20020a05651248ce00b004facdf96283sm782576lfb.254.2023.07.07.12.12.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 12:12:11 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso3706705e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 12:12:11 -0700 (PDT)
X-Received: by 2002:a05:6512:3104:b0:4fb:7626:31a8 with SMTP id
 n4-20020a056512310400b004fb762631a8mr4290389lfb.27.1688757130684; Fri, 07 Jul
 2023 12:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
 <20230704211509.GA21834@1wt.eu> <CAHk-=wjH4O6v_EwVB=t_6Haky2jOiejHbCkCTvgNQWo1ghy8-w@mail.gmail.com>
 <20230704213415.GA21872@1wt.eu> <CAHk-=wjPEjrB7eCukREhWu-0qfjbFD-K8sk1TYYRgeHzYr1tuQ@mail.gmail.com>
 <20230704215600.GA22271@1wt.eu> <CAHk-=whMytacPBHfKKi8GYdgfadNy5LA-1TDHrTtz22eJr2B1Q@mail.gmail.com>
 <20230704222758.GB22271@1wt.eu> <20230705004129.GI1178919@mit.edu> <CAKwvOd=ktNGZ=uBVxF7Wicooy7VMz1UNe5MRDkEDZPcg1_DJ2A@mail.gmail.com>
In-Reply-To: <CAKwvOd=ktNGZ=uBVxF7Wicooy7VMz1UNe5MRDkEDZPcg1_DJ2A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jul 2023 12:11:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJQS72y15+33DTZiR0pyBwFZSyd=LcN0weso_AWfCenA@mail.gmail.com>
Message-ID: <CAHk-=wiJQS72y15+33DTZiR0pyBwFZSyd=LcN0weso_AWfCenA@mail.gmail.com>
Subject: Re: Overly aggressive .gitignore file?
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
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

On Fri, 7 Jul 2023 at 11:51, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
>
> I don't really understand why *.patch is ok to have in .gitignore but
> *.mbox is not?  Wouldn't autocomplete fail due to `git status` for the
> exact same reason?

I'm sure it does. It just isn't in *my* workflow, so I don't hit it.

But if other people find the *.patch pattern annoying, I certainly
agree that that should be removed too.

               Linus
