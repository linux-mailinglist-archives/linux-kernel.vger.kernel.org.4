Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4090A604E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiJSROu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiJSROn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:14:43 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A673DBFA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:14:40 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-131dda37dddso21507194fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KQxzROgST2+8KIjtVZdr5+s36xe/ZTzSg3ETS6Z3ulQ=;
        b=LHMjzMXASHQR480KuNviD0xWrYZLfPGTCqeVvQUzo3gve/gy/NSntm2Y3IkOnCwj1p
         +2IyuKYK8OWw/x9y83GLy2MuG6uqB0UvRc95PvRt9RDfj9DT+fECM5grlCAHIYJa4yIC
         pJNjoJ+eCxvdc3VlvJicxtqeqtYoTOSjDGAh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQxzROgST2+8KIjtVZdr5+s36xe/ZTzSg3ETS6Z3ulQ=;
        b=2cL3bTdnV27htx78reTvbs9ebppH98eARPYohZZi5us588xme1gzGBAw5n32R30uiK
         ZX4ww3AC8WS1Nf6hCOxL2j+rY9Wkg0MpDSB2RRm4LExLr6+4kGgoBVvEJqwFfN2JEGQK
         jCzMMfNu3kQqaLNuuUiOGVIRu91SXdLVQ9ETUeAbl1TunI2DbKrxbIwxzxWgjY3YGZvi
         fQNHekOQRSdtn54ycEJxG0MAXaMiH6ZI66Ge4mnZxupahlcYpeqaR9eSRKbocXNZr3p2
         8rPthdcsUMMTXoY5h+ILX/4KDu+Rve0U6jkdNBet+5mfxc+8zJJo1WLCgo3tm+WQW9Gk
         /cWg==
X-Gm-Message-State: ACrzQf2DVrSdOTj5xvVFQp557otWzoG0nSWEREykV3dWywFgfrhf6V6s
        fLS7BPQBLLxHBQ3qpoU+CTYiV/d5o7ancg==
X-Google-Smtp-Source: AMsMyM4JVyganvPK94CCqFcWi5V1bHNknPpJeqVvRIZ4RWdw7pAKp7X6UozwP9lF6ir3TcMVDj0NGw==
X-Received: by 2002:a05:6870:70a8:b0:131:9591:3eec with SMTP id v40-20020a05687070a800b0013195913eecmr22562934oae.100.1666199679453;
        Wed, 19 Oct 2022 10:14:39 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id 94-20020a9d0de7000000b006619295af60sm7217235ots.70.2022.10.19.10.14.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 10:14:37 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id x188so20011674oig.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:14:36 -0700 (PDT)
X-Received: by 2002:a05:6808:23c3:b0:351:4ecf:477d with SMTP id
 bq3-20020a05680823c300b003514ecf477dmr5072747oib.126.1666199676600; Wed, 19
 Oct 2022 10:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org>
In-Reply-To: <20221019165455.GL25951@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Oct 2022 10:14:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
Message-ID: <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Wed, Oct 19, 2022 at 9:57 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> This is an ABI change.  It is also hugely detrimental to generated
> code quality on architectures that make the saner choice (that is, have
> most instructions zero-extend byte quantities).

Yeah, I agree. We should just accept the standard wording, and be
aware that 'char' has indeterminate signedness.

But:

> Instead, don't actively disable the compiler warnings that catch such
> cases?  So start with removing footguns like
>
>   # disable pointer signed / unsigned warnings in gcc 4.0
>   KBUILD_CFLAGS += -Wno-pointer-sign

Nope, that won't fly.

The pointer-sign thing doesn't actually help (ie it won't find places
where you actually compare a char), and it causes untold damage in
doing completely insane things.

For example, it suddenly starts warning if  you *are* being careful,
and explicitly use 'unsigned char array[]' things to avoid any sign
issues, and then want to do simple and straightforward things with
said array (like doing a 'strcmp()' on it).

Seriously, -Wpointer-sign is not just useless, it's actively _evil_.
The fact that you suggest that clearly means that you've never used
it.

                      Linus
