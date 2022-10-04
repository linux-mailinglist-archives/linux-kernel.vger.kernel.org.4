Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CF25F48FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJDSEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 14:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJDSEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:04:09 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CB6474C7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 11:04:09 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so9291419oop.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 11:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sor9D9i/EJpgjGPLpMubXbPXNL6NfcDkrHXBrZqrku4=;
        b=etS61wv0tV5Tr5yGB26lMRJz5KF87CbWf8vsC0mcngDXaqkhSZKuaPi8OghfGOQLQj
         aP98reDcR1aPBsiupOp8u3oTidiuNovXySlB1hshVQjrHYVtiJmk1WYMVamRA54IQTb6
         359w1y6S03b8fDqbMY6dbwRQ8Nj6JfRjoQhMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sor9D9i/EJpgjGPLpMubXbPXNL6NfcDkrHXBrZqrku4=;
        b=NdCp0pTi4rxxD7MRAYvOZw9BA2IgFgB8a9OS2UuSnorL6wXsKn9ugdNtfCq7Dl4+Tc
         a+mF6l5+qZw9Smuem4x+HER0I7JotUC51+ZIs8i+RpDUXGXDvUNX5S/Q697aiXgHBeEu
         eaiFIJbdk4bx9bhbfwaB21t8svbQdcDdbo8n2I4fF7lFbDwO8U3a/17BV4VYjlzLu9jr
         UMwqQ3vC/qk4BcTxtjTTQVfFEaW8/oLV+tJHJo4SMt3z5wcb6U9dxDV8QJeVGGPV2Qqk
         +Ss5hb797EWuNDqWO1JlmqZxvpPdbBwecOBdnQifMGm3xuBmJ3kxgetwYa9VXf0ibRzE
         xmRg==
X-Gm-Message-State: ACrzQf0iLsacb0lzU1ZFaaTbode5xSoGuvFn/12VHd+36HgV8K/kHKX3
        Z5myQmVvGGec8LyTgCNUg+qV9/tCRj4LHg==
X-Google-Smtp-Source: AMsMyM6N1r7azXX++X/RGAs5iwrvNe7F3fmvjoZVLk6nikprxAq2HdX79Kuu0htDSYq9fDfijhAbng==
X-Received: by 2002:a9d:6004:0:b0:660:cd92:f891 with SMTP id h4-20020a9d6004000000b00660cd92f891mr1105400otj.94.1664906646404;
        Tue, 04 Oct 2022 11:04:06 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id e4-20020a05683013c400b00655dda40f54sm3145745otq.78.2022.10.04.11.04.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 11:04:05 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id s192so987216oie.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 11:04:05 -0700 (PDT)
X-Received: by 2002:aca:b957:0:b0:351:4ecf:477d with SMTP id
 j84-20020acab957000000b003514ecf477dmr469103oif.126.1664906645054; Tue, 04
 Oct 2022 11:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info> <20221004175354.bfvg3vhfqch35ib5@meerkat.local>
In-Reply-To: <20221004175354.bfvg3vhfqch35ib5@meerkat.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Oct 2022 11:03:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7HyGxs2Ad-UiF-3qeLJnPc_WGKOVqYqaTjrbRig0V9Q@mail.gmail.com>
Message-ID: <CAHk-=wi7HyGxs2Ad-UiF-3qeLJnPc_WGKOVqYqaTjrbRig0V9Q@mail.gmail.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla blues"
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
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

On Tue, Oct 4, 2022 at 10:53 AM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> 2. Create and maintain a mapping from MAINTAINER subsystem entries to
>    Product/Component categories in Bugzilla (the scheme to be established).

It's probably worth asking the 0day people what they do.

Maybe they do it all manually and have no real helping infrastructure,
but I see emails from them that often (but certainly not always) seem
to get the right people involved.

And while the MAINTAINER file is useful for a fiel mapping, I'm not
convinced it's all that useful for the "product/component category"
mapping, because I doubt people will actually fill that in well (and
reliably) enough.

With actual bisection data, it's fairly easy (get the emails from the
commit that got bisected). But things like "use the backtrace in the
oops to figure out who to add to participants" is likely a bit more of
a "use clever heuristics" kind of thing.

Anyway, I do think that some kind of automation would be really good,
at least for reports that have bisection information or backtraces in
them. Without automation, people _will_ be overwhelmed on the first
level response to bug reports (ie the "try to figure out who to bring
in" front).

But if the automation is too stupid, people will start ignoring the
report emails just on the assumption that it got thihngs wrong.

Of course, if the automation is really solid enough, I think it should
work on lore.kernel.org, not on just a bugzilla thing.

             Linus
