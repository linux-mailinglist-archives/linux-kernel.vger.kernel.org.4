Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4717C69E826
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBUTQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBUTQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:16:57 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B032D178
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:16:53 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x10so20646125edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ayM9JpW1yE32OZcyE9Bl9slBlfyuVWriu50vG7JoYY=;
        b=L3/v9ARQy8prPgHsE2w6q6n2R6+UafTI69txUo49ZhFuN8slMzaVBY5R/5YVbR+i0M
         cvu1xxUPWw4eQ+an2+JlAeGlA520l3W20zJreOS+YSOeNeYhmk9cJ1HOufILo+SAROp7
         BnlAfKASsWa7yVuCatugVAB1RmHpCf3clJfxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ayM9JpW1yE32OZcyE9Bl9slBlfyuVWriu50vG7JoYY=;
        b=SXLTQ95ouUyGVnQJyCCW+CkUnOUUQSzciTVwYgO3e/xNps+9TAOypmD3rUkvjVbgJz
         e5GNl1AIj9JX3aU2OsZBdWFSdmWGmi8qK+ovrkpxKiTzADoBLdcsx0r1hc/DA8ntVv9X
         66dqblBnQyeSo3F9euR1BX/TDgZ6XBIzJ7DQNcM1Z6omBKAwsoTXJ9V6ThxjothWIAeJ
         /5MTIDTj98RFqVXxOp9bNxVFDZbSnHDkohya0o5ZJfnTaSIk77l4wFsQjNyQC/Cwyi5o
         YfaZqYb2JgUoZC7rVG91oaHJ0eKIcjS4V+YdxkyynZeeASDLCv6gkQTc3/E1eHn6my0V
         L2bA==
X-Gm-Message-State: AO0yUKXkYBytvRMNiGlHmVfVX20jSO5SD9IWlWR65jfTHEvfK2S3iuoQ
        +vo3Pr4jC12M009tsLqDYXRrbfP4Z4A0TYUWiJA=
X-Google-Smtp-Source: AK7set+SCEwf3OPnNa4wWW4CEdoQ4NHli8dFH0soi84dSCw/KIF0NrRywytf2wFOHXpY3npwb2ESdQ==
X-Received: by 2002:a17:906:c289:b0:8b8:c04f:c5f9 with SMTP id r9-20020a170906c28900b008b8c04fc5f9mr14279328ejz.73.1677007011725;
        Tue, 21 Feb 2023 11:16:51 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id r14-20020a1709067fce00b008dffda52d71sm1048329ejs.124.2023.02.21.11.16.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 11:16:51 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id g1so21210156edz.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:16:50 -0800 (PST)
X-Received: by 2002:a50:d614:0:b0:4ae:f144:2c8e with SMTP id
 x20-20020a50d614000000b004aef1442c8emr3490838edi.5.1677007010586; Tue, 21 Feb
 2023 11:16:50 -0800 (PST)
MIME-Version: 1.0
References: <63efd7ab.170a0220.3442b.6609@mx.google.com>
In-Reply-To: <63efd7ab.170a0220.3442b.6609@mx.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Feb 2023 11:16:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgw++ccN-Pd1npZsBSDD3z6EGUSKsWuAEh5YC-TmfJAug@mail.gmail.com>
Message-ID: <CAHk-=wgw++ccN-Pd1npZsBSDD3z6EGUSKsWuAEh5YC-TmfJAug@mail.gmail.com>
Subject: Re: [GIT PULL] hardening updates for v6.3-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Sam James <sam@gentoo.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-hardening@vger.kernel.org
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

On Fri, Feb 17, 2023 at 11:38 AM Kees Cook <keescook@chromium.org> wrote:
>
> Please pull these hardening updates for v6.3-rc1.

So I've pulled this, but while looking at it, I see commit
5c0f220e1b2d ("Merge branch 'for-linus/hardening' into
for-next/hardening").

And that one-liner shortlog part is literally the whole commit message.

I've said this before, and apparently I need to say this again: if you
cannot be bothered to explain *WHY* a merge exists, then that merge is
buggy garbage by definition.

This really should be a rule that every single developer should take
to heart. I'm not just putting random words together in a random
order.

I repeat: if you cannot explain a merge, then JUST DON'T DO IT.

It's really that simple. There is absolutely *NEVER* an excuse for
merges without explaining why those merges exist.

In this case, I really think that merge should not have existed at
all, and the lack of explanation is because there *IS* no explanation
for it.

But if there was a reason for it, then just state it, dammit, and make
that merge commit look sensible.

Because right now it just looks entirely pointless. And I literally
*detest* pointless merges. They only make the history look worse and
harder to read.

                     Linus
