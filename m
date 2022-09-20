Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6AD5BD8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 02:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiITAPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 20:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiITAPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 20:15:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66102140C6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 17:15:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sb3so2371316ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BgWrStjazBL3noD9/vk03t6GhWMu6WHkO8oDZrwsiw4=;
        b=SJSO8IZCt0Y5kVGyIwQdueMBTnqTxxL958lu9VE+yxSsYNOU0eyCEEmnqg94jyfjNV
         KNmUMvZPN7glZM0GJC6KmElL09bXeF6IzD009CSYWLhp9dSWYCICBezT84oZ8V12JkEM
         /7eszFNQyjg/zQP3c6u5LG9DPaqw5laxsPfEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BgWrStjazBL3noD9/vk03t6GhWMu6WHkO8oDZrwsiw4=;
        b=PePleT5jwQd8NI5ulvQedRZ9g1G1f/YMyEOdW8BiOjnmUtBXadwb39EcIOK82olqRP
         7hnuboLldW1fAP6OcLYoEkqkWiOovE40Uq8wGyME8ZuBtCV2wEia6SsAs5srFrSXSDuH
         Syw2MLcDhHCaSfbLCb4tmj4zB3EuR40TkgCjQ7y29+J5MweQpg9fIheFpQVxZNYG4ns1
         GLXfs1+j/8uvW/DNQjCBlN5JdKrdU/E0OVcmCVXJkAiD/0Cx0spivLGGTEa0NRonTG7u
         2LAqKvLAeoQjYTTFcMJhJrgz+MnJpApwy1qldsnd+RSsqjX/YvWkjuZT5A65fhPoxHLi
         byaA==
X-Gm-Message-State: ACrzQf3Aj+r918fzzIs+rT8YyEaKDceTzwJ2Ka56+FdaZvPKwVNXWdId
        PfT4npChVc+ky97kZpI/EG6EqbOsay5juC64ZG8=
X-Google-Smtp-Source: AMsMyM6yuWFWallLhZS6CBxCLBrPXgdMC84ez9uOtLynBYT0rP1NQfHTXcr4uetlLZ8Auq9jWdpdSQ==
X-Received: by 2002:a17:907:6e2a:b0:780:6ace:7a93 with SMTP id sd42-20020a1709076e2a00b007806ace7a93mr15027700ejc.186.1663632941433;
        Mon, 19 Sep 2022 17:15:41 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id fe5-20020a056402390500b0044e6802623dsm60447edb.18.2022.09.19.17.15.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 17:15:41 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id r7so1706056wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 17:15:41 -0700 (PDT)
X-Received: by 2002:a19:4f45:0:b0:49a:63c9:190d with SMTP id
 a5-20020a194f45000000b0049a63c9190dmr6637732lfk.61.1663632930544; Mon, 19 Sep
 2022 17:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-13-ojeda@kernel.org> <Yu5Bex9zU6KJpcEm@yadro.com>
 <CANiq72=3j2NM2kS8iw14G6MnGirb0=O6XQyCsY9vVgsZ1DfLaQ@mail.gmail.com>
 <Yu6BXwtPZwYPIDT6@casper.infradead.org> <Yyh3kFUvt2aMh4nq@wedsonaf-dev>
 <CAHk-=wgaBaVaK2K=N05fwWSSLM6YJx=yLmP4f7j6d6o=nCAtdw@mail.gmail.com>
 <CAHk-=whTDbFZKB4KJ6=74hoLcerTm3JuN3PV8G6ktcz+Xm1qew@mail.gmail.com>
 <YyivY6WIl/ahZQqy@wedsonaf-dev> <CAHk-=whm5Ujw-yroDPZWRsHK76XxZWF1E9806jNOicVTcQC6jw@mail.gmail.com>
 <Yyjut3MHooCwzHRc@wedsonaf-dev> <CAHk-=wityPWw4YkHeMNU4iGanyiC3UwDRhbOHYCJrhB2paCGwA@mail.gmail.com>
 <CAFRnB2VPpLSMqQwFPEjZhde8+-c6LLms54QkMt+wZPjOTULESw@mail.gmail.com> <CAHk-=wiyD6KqZN8jFkMHPRPxrbyJEUDRP6+WaH9Q9hjDB5i1zg@mail.gmail.com>
In-Reply-To: <CAHk-=wiyD6KqZN8jFkMHPRPxrbyJEUDRP6+WaH9Q9hjDB5i1zg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Sep 2022 17:15:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6sDFk8ZXSEKUMj-J9zfrMSSO3jhBEaveVaJSUpr=O=w@mail.gmail.com>
Message-ID: <CAHk-=wj6sDFk8ZXSEKUMj-J9zfrMSSO3jhBEaveVaJSUpr=O=w@mail.gmail.com>
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
        linux-kernel@vger.kernel.org, me@kloenk.de, milan@mdaverde.com,
        mjmouse9999@gmail.com, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, thesven73@gmail.com,
        viktor@v-gar.de, Andreas Hindborg <andreas.hindborg@wdc.com>
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

On Mon, Sep 19, 2022 at 4:58 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This is not some kind of "a few special things".
>
> This is things like absolutely _anything_ that allocates memory, or
> takes a lock, or does a number of other things.

Examples of "number of other things" ends up being things like
"accessing user memory", which depending on what you are doing may be
very common too.

And btw, it's not only about the (multiple kinds of) atomic regions.

We have other context rules in the kernel too, like "does floating
point or vector unit calculations". Which you can actually do, but
only in a kernel_fpu_begin/kernel_fpu_end region.

Now, the floating point thing is rare enough that it's probably fine
to just say "no floating point at all in Rust code".  It tends to be
very special code, so you'd write it in C or inline assembly, because
you're doing special things like using the vector unit for crypto
hashes using special CPU instructions.

                  Linus
