Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7193E5FA9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 03:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJKBUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 21:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJKBUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 21:20:21 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA57C13DD4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 18:20:19 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-131ea99262dso14292501fac.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 18:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OBsU0GNWyfIKR8QJhJdP9cW2g/Tm8RsQ4/KCjmFrIcA=;
        b=ZYVC0As2dCkDlVVlxAaYR+Vf5j5NHKgM7FosPug9FKJ5N7poc0XVAWPatSsmLcJT2t
         hLId+80pcemqXzCYeaeUbvev6Avt0/+4+V1qVg8GDdlY0oReQH/zZH/TRufdS0zf7JZB
         /cReB6BKayZEApCnRjZzHWK4YpRpUlNMWvxIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBsU0GNWyfIKR8QJhJdP9cW2g/Tm8RsQ4/KCjmFrIcA=;
        b=Sdb96epgD/DcVMKzf31ML0Pt7s3yOuTPYByFXjplms9EMg6rMTcPkv8+PtsHQ7VSK2
         057uvk14kZ59pv+Dm8Nxc1/hXotz9mdMAllTNCutowjRfXPiZeZnwdOcwFZD0BwMlvg7
         MLQQ3ufgbLvr9H+ZO1wipptYIAXAQDBC4G1qd4e/qfr009YgXaRIXjMxUPyTKhEJ7x6f
         MtvTwR4QniNA0DbNlqzDkLwBLF19Ti+Yh1rGTiRvFMGZGkDk/vCvpOJmAuJjbf/MkWQA
         b2uxSTjXFo51tFkFms2oRiAOTvC0it8C/UrAeZfWPtWyTqBP3E+01tnTwBRJBmy0vBot
         o5hQ==
X-Gm-Message-State: ACrzQf0OBxt8x8AKwDQVN+bJCGSy0Jt6L19xkyEcojwcWh5SXLtm/iU1
        1ZSmo9iNVGhlsu3LDOQa5uy7+qlvK1Zv+g==
X-Google-Smtp-Source: AMsMyM68JZZtruPPUx1s5GkLRegx5Cd1O3onDPKqoavzHro5JtOwuxY8/4+ShTlEEltm8GzTjjvGbg==
X-Received: by 2002:a05:6870:b021:b0:132:e501:41a9 with SMTP id y33-20020a056870b02100b00132e50141a9mr14927038oae.93.1665451218171;
        Mon, 10 Oct 2022 18:20:18 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id x3-20020a056808144300b00349a06c581fsm4962459oiv.3.2022.10.10.18.20.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 18:20:17 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id n83so14395282oif.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 18:20:16 -0700 (PDT)
X-Received: by 2002:a54:4899:0:b0:354:add8:52ab with SMTP id
 r25-20020a544899000000b00354add852abmr2158006oic.229.1665451216585; Mon, 10
 Oct 2022 18:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221008132113.919b9b894426297de78ac00f@linux-foundation.org>
In-Reply-To: <20221008132113.919b9b894426297de78ac00f@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Oct 2022 18:20:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigZoriP8ZB+V87Jf+EQV=ka6DQe_HCAQmh3Dmus2FFhw@mail.gmail.com>
Message-ID: <CAHk-=wigZoriP8ZB+V87Jf+EQV=ka6DQe_HCAQmh3Dmus2FFhw@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.1-rc1
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Sat, Oct 8, 2022 at 1:21 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Alexander Potapenko (43):
>       crypto: kmsan: disable accelerated configs under KMSAN

Ok, so this conflicted pretty badly with the crypto tree having
re-organized their Kconfig files.

I channelled my inner Alexander the Great, and just cut the whole
thing through by disabling all the architecture-accelerated crypto
includes when KMSAN was enabled.

 But that's very different from your tree that disabled the options
individually, so some KMSAN person should probably look around at it
and decide whether some more subtle approach is called for.

The other thing I notice from just doing a build is that I now get

   vmlinux.o: warning: objtool: kasan_report+0x12: call to
stackleak_track_stack() with UACCESS enabled

which may just be a "need to teach objtool this is ok", but I'm not
seeing why it's now starting to happen. Maybe just code generation
changed for some reason, or maybe it's just that config options ended
up changing enough to expose this on my allmodconfig builds.

Cc'ing people who may know better.

This is just my reaction from doing the merge and test-build. There
may or may not be more commentary once I've actually tried to boot
into this thing.

               Linus
