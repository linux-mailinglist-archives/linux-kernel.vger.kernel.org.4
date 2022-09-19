Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4AD5BD886
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiISX6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiISX6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:58:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48B051408
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:58:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a26so2370350ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=k3xlnAyuOJefFP7D3SzMTJMGo96xFtxvnNEEJ0Y5xB0=;
        b=CELKTFYiDZ28jArQvDpCb7qvvmdR8edtKyTcfxOM06jxTtB2qlY/zEckJKnjqVYSUg
         /1qq7YY2fOwFzO8ZWvQluuxKF4YNZ/cX2DQjVxmpBio5Cm9RlMhyOPAY60phndmXv31l
         qegbKlImOq5akFoRY3p69urdyJAV4aubfYBpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=k3xlnAyuOJefFP7D3SzMTJMGo96xFtxvnNEEJ0Y5xB0=;
        b=HZrQ6igUQrgOsz2+nC0FEZ4exlofWXH8QcMnJPrAEUwOQyIVyRRZeA05Q6NGw4wdoy
         eQ9VFsF0KtU1ckFZMtv6NIBDFZVPA3AiwFET3Z2OUp47dAOBFQKKyEogZLZKLaqpUlE4
         UE33pSTPXv2DVxOr/Azy9OgR2Id4QUSsMyVid1OHRMwtOLTntq6Md0ciC180vf2ln80z
         D52HKpBHqgwa9zuqq2orGe/tPKdV+X4eQxOJJ+jWllO9QYIO1tYI+4jxYFGYQBi+FNtU
         ZlB57tFyCKUaicQfzBecG1HmwpuvSRoj1mP6RwPBXGj1hMPVdVTfdUteqPx/5V6HW6sn
         wRpw==
X-Gm-Message-State: ACrzQf0ng4s0wHgZJJ8XWCujpPxFP/10QzkJvN57jI1zmLwG9HPc6kPW
        gKJ67K/NUWYbx83+AilI3mcBCCVlM6WZPemcLfU=
X-Google-Smtp-Source: AMsMyM6WGtwjHjmuh6mUNkMdyTXp3A2298vu+SkXY7vHAL+Zhe2TtELhTKzJUV7N6AVxL5WRBIV63A==
X-Received: by 2002:a17:906:4fd1:b0:781:35c1:3664 with SMTP id i17-20020a1709064fd100b0078135c13664mr6664559ejw.140.1663631917473;
        Mon, 19 Sep 2022 16:58:37 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id u8-20020a50eac8000000b004536d530ca5sm25658edp.38.2022.09.19.16.58.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 16:58:37 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id bq9so1625030wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:58:34 -0700 (PDT)
X-Received: by 2002:ac2:5cd7:0:b0:49f:ae59:3b87 with SMTP id
 f23-20020ac25cd7000000b0049fae593b87mr2724088lfq.291.1663631903618; Mon, 19
 Sep 2022 16:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-13-ojeda@kernel.org> <Yu5Bex9zU6KJpcEm@yadro.com>
 <CANiq72=3j2NM2kS8iw14G6MnGirb0=O6XQyCsY9vVgsZ1DfLaQ@mail.gmail.com>
 <Yu6BXwtPZwYPIDT6@casper.infradead.org> <Yyh3kFUvt2aMh4nq@wedsonaf-dev>
 <CAHk-=wgaBaVaK2K=N05fwWSSLM6YJx=yLmP4f7j6d6o=nCAtdw@mail.gmail.com>
 <CAHk-=whTDbFZKB4KJ6=74hoLcerTm3JuN3PV8G6ktcz+Xm1qew@mail.gmail.com>
 <YyivY6WIl/ahZQqy@wedsonaf-dev> <CAHk-=whm5Ujw-yroDPZWRsHK76XxZWF1E9806jNOicVTcQC6jw@mail.gmail.com>
 <Yyjut3MHooCwzHRc@wedsonaf-dev> <CAHk-=wityPWw4YkHeMNU4iGanyiC3UwDRhbOHYCJrhB2paCGwA@mail.gmail.com>
 <CAFRnB2VPpLSMqQwFPEjZhde8+-c6LLms54QkMt+wZPjOTULESw@mail.gmail.com>
In-Reply-To: <CAFRnB2VPpLSMqQwFPEjZhde8+-c6LLms54QkMt+wZPjOTULESw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Sep 2022 16:58:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyD6KqZN8jFkMHPRPxrbyJEUDRP6+WaH9Q9hjDB5i1zg@mail.gmail.com>
Message-ID: <CAHk-=wiyD6KqZN8jFkMHPRPxrbyJEUDRP6+WaH9Q9hjDB5i1zg@mail.gmail.com>
Subject: Re: [PATCH v9 12/27] rust: add `kernel` crate
To:     Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>, ojeda@kernel.org,
        ark.email@gmail.com, bjorn3_gh@protonmail.com, bobo1239@web.de,
        bonifaido@gmail.com, boqun.feng@gmail.com, davidgow@google.com,
        dev@niklasmohrin.de, dsosnowski@dsosnowski.pl, foxhlchen@gmail.com,
        gary@garyguo.net, geofft@ldpreload.com, gregkh@linuxfoundation.org,
        jarkko@kernel.org, john.m.baublitz@gmail.com,
        leseulartichaut@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, m.falkowski@samsung.com,
        me@kloenk.de, milan@mdaverde.com, mjmouse9999@gmail.com,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        thesven73@gmail.com, viktor@v-gar.de,
        Andreas Hindborg <andreas.hindborg@wdc.com>
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

On Mon, Sep 19, 2022 at 4:50 PM Alex Gaynor <alex.gaynor@gmail.com> wrote:
>
> Rust's rules are that a function that's safe must not exhibit UB, no
> matter what arguments they're called with. This can be done with
> static checking or dynamic checking, with obvious trade offs between
> the two.

I think you are missing just how many things are "unsafe" in certain
contexts and *cannot* be validated.

This is not some kind of "a few special things".

This is things like absolutely _anything_ that allocates memory, or
takes a lock, or does a number of other things.

Those things are simply not "safe" if you hold a spinlock, or if you
are in a RCU read-locked region.

And there is literally no way to check for it in certain configurations. None.

So are you going to mark every single function that takes a mutex as
being "unsafe"?

Or are you just going to accept and understand that "hey, exactly like
with integer overflows, sometimes it will be checked, and sometimes it
just won't be".

Because that is literally the reality of the kernel. Sometimes you
WILL NOT have the checks, and you literally CANNOT have the checks.

This is just how reality is. You don't get to choose the universe you live in.

                  Linus
