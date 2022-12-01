Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0C363F5F0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiLARHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiLARHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:07:31 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12542AD99D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:07:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o12so2416189pjo.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 09:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2h6V7XvvjPy1lxD6pcJR/fFIby5mlqq6VvEqNgaJZlA=;
        b=BB+tP7KcNNb8N9JizMDMdyQGv0d/dZxpBKqOVBhdM+8pqZK0WkeumDcg213DNWErEM
         w+eTxnf8yqEzZTWCm0AwLbLM65sPH/0A1jzJWV/TsFGXDa0L1m0kFFcQhj8hdMdDNxyg
         sYs1R8dB1XvBq2U08TJVpoz4A1p5tghKTeK4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2h6V7XvvjPy1lxD6pcJR/fFIby5mlqq6VvEqNgaJZlA=;
        b=BA5EQhCWcJUZHAWlMlRJ8I5tWmOCnkD8JEU70/XL1BOdXOsXgeBUZUmJKUnG+JHrrb
         9SPpCpqL8Wlx2d6MEeimBsEXxvOBt44mbZmy9+uOWQ9tOPmCxyNcstNe/pxOVxuyb5do
         I19vk0crk6/PqU7uymxc9Oahx4VEqtxif8VTMm3Vd2ENi46/bGeOKZVkijbpqiyMbfBN
         fWvCDQS/sMY9AxKkI1DgxhCv1CQMT5OSugzEXikie1+rICGQDVnR5vdCum5j6NXQEU6n
         KHju2HcoVzQ3HpNQPAfnKVWCfbcOiG8lcdZjsU5oLrLVNACpmuF7YPPVBnwKRrXmSQ6F
         WS3A==
X-Gm-Message-State: ANoB5pniw8/GaihXnsqJa2E8ubwVpvZxJ17059yraglWRN8DCEc5Gbe2
        fykB/I+cealcFQNJPm8/oJBFEg==
X-Google-Smtp-Source: AA0mqf60jfKiNSgx+GE25w+lQV1VW2FGq5KDM0pvIkRI+4RDr6EW2tpwewecphWAWs7Pm7ZM+gv81Q==
X-Received: by 2002:a17:90a:29e4:b0:219:4056:720c with SMTP id h91-20020a17090a29e400b002194056720cmr20051470pjd.53.1669914450359;
        Thu, 01 Dec 2022 09:07:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h15-20020a056a00000f00b0056ba7ce4d5asm3531488pfk.52.2022.12.01.09.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:07:29 -0800 (PST)
Date:   Thu, 1 Dec 2022 09:07:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Kees Cook <kees@kernel.org>, akpm@linux-foundation.org,
        elver@google.com, kasan-dev@googlegroups.com, davidgow@google.com,
        Jason@zx2c4.com, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] lib: fortify_kunit: build without structleak plugin
Message-ID: <202212010906.0CE64E9CD@keescook>
References: <20221128104403.2660703-1-anders.roxell@linaro.org>
 <5FC4A1FD-9631-43B2-AE93-EFC059F892D3@kernel.org>
 <CADYN=9LT7xWScSiprwgB2DhTN-Mws7rxG33BRZwLktK7P_jzkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYN=9LT7xWScSiprwgB2DhTN-Mws7rxG33BRZwLktK7P_jzkQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 03:20:13PM +0100, Anders Roxell wrote:
> On Mon, 28 Nov 2022 at 15:09, Kees Cook <kees@kernel.org> wrote:
> >
> > On November 28, 2022 2:44:03 AM PST, Anders Roxell <anders.roxell@linaro.org> wrote:
> > >Building fortify_kunit with strucleak plugin enabled makes the stack
> > >frame size to grow.
> > >
> > >lib/fortify_kunit.c:140:1: error: the frame size of 2368 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

(It seems like lkml never got this email? Or at least I didn't find it
on lore, so "b4" was unhappy...)

> > Under what config
> 
> I saw this with a arm64 allmodconfig build [1],
> 
> > and compiler version do you see these warnings?
> 
> Toolchain
> aarch64-linux-gnu-gcc (Debian 11.3.0-6) 11.3.0

Thanks! I've applied this to my tree.

-- 
Kees Cook
