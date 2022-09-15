Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FEB5BA106
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIOSyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIOSyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:54:36 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDDFD95
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 11:54:35 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3454e58fe53so232130527b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=M9Uyr86VKp7mZacSFez6ONLouI5Cb32MK9f5LSKE/bk=;
        b=KFzrXeOqSBulwk8KcX7zrPHv6vryJOJf6+X4SU4NDJ+zCsod+4RsqGjVy7qPElLAUI
         nVP3OvzjV/W5MWpQOM9xfAzcalBw1oyFZIggHo26pI3sxc0YmFNRaFDIL3aRi8HMOxH/
         Fq03WQSY4vazoMy2/+IDE6X9eRe7G3DreocJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=M9Uyr86VKp7mZacSFez6ONLouI5Cb32MK9f5LSKE/bk=;
        b=ckaebZmM3TvcrvyL/DboUFahlrSzMIkje2kEguk++d+yCklsOO6n4j/NXFdrtzX79j
         1rDhK0NCic364+wTv04C9mIf0CIs/phvFHBuUr+HS14SPeC+AvdYsnk8M2BMNphusa9+
         IqxatwLggQHS7aCpKQCVvzZ4ljfOMZdhtDa9enMWpIAn5TJsHgwxSjY3DE+QvldqIrds
         y0VQD0XmCcKRpEIe7yQjZX4v1kzDIwb6iCjgsEGysUIMnjsfHCwNyf8mXscKwLvV2Qs4
         72cV3t2UpkXMkELbXLxYrvQyZNNK9D+wTI6d3pNq8BPtv7V37n6lzjvvP0m18KsfL3y2
         LpYg==
X-Gm-Message-State: ACrzQf32BrItzzaX86CPv/tCbRLm2VW7VjvhOPtLWKe4vn7yH/4BGElq
        odLDyLDzn7ZtMh8DQ/v8XoEGMeBkotPDb6Q90BIiXw==
X-Google-Smtp-Source: AMsMyM5mOUJ8Ad20AIrZF5CfWfFQBQcn+HO432DqRBGF/X+LbSHrHRfJddOyn5AhiLbSLa+vBcwdLnPsca/+gisVeWU=
X-Received: by 2002:a81:10c3:0:b0:349:8b81:9fb0 with SMTP id
 186-20020a8110c3000000b003498b819fb0mr1137081ywq.269.1663268074753; Thu, 15
 Sep 2022 11:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220915002235.v2.1.I7c0a79e9b3c52584f5b637fde5f1d6f807605806@changeid>
 <YyNIOg1mtnzQz1H7@zx2c4.com>
In-Reply-To: <YyNIOg1mtnzQz1H7@zx2c4.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Thu, 15 Sep 2022 14:54:24 -0400
Message-ID: <CAG-rBijUSQ-kA0-pS=JCVX9ydeaSCd9Ub=yryGk4zsbcv3dTzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] random: move add_hwgenerator_randomness()'s wait
 outside function
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, linux@dominikbrodowski.net
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Alex Levin <levinale@google.com>,
        Andrey Pronin <apronin@google.com>,
        Stephen Boyd <swboyd@google.com>,
        Rajat Jain <rajatja@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik, Jason,

On Thu, Sep 15, 2022 at 11:44 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Isn't Dominik working on the same thing, but slightly different?

I don't believe Dominik is working on quite the same thing, but his
work will conflict with mine for sure:
https://lore.kernel.org/lkml/YxiXEJ6up6XEW8SM@zx2c4.com/T/

What are the odds that two people are making changes to the hwrng
kthread at the same time?

I see two possible ways forward:
1. Dominik rebases his patch against mine (iff mine finds favour).
This may simplify his patch
quite a bit, because the delayed_work abstraction tends to have fewer
footguns than
kthread.

or

2. I rebase against Dominik's.

Both are fine with me, just let me know what you think.

-Sven
