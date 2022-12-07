Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3646646186
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiLGTRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLGTRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:17:13 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96265578EA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:17:10 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id x28so15861435qtv.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 11:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+2le/sI31rwoT0CDamjLE930vcz/00uHM7kqPVJnYrw=;
        b=T3alC4NFoI3V7D988e51SnU8VyqoHzcmeQ84iJunfZ9zQ+wtqxSUCG1VCdOfsMWDwf
         O+MgbUEyIQA8jrOfhH1xBaM3SpsIQ7YfZEbBpB1DY/FcpMGS3BMbxVsHB1z2M5y9w0Pa
         v2FNXyHn53NCVS12PHW3PhWizYlPRarzOomzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2le/sI31rwoT0CDamjLE930vcz/00uHM7kqPVJnYrw=;
        b=TICEe2E5XAIpoZr4OfeYDOzdC9mgWoTbBS9I/MX8MXa8jT+XL2jaXULxS6A30dWo7H
         DH44T1Wenvgs8Aqdptg/w73/4kRUvyqIcBtJmy5dk7KIMXHi8hV4FKy8Z+IDCUxCnrv9
         fyKJI2A8u94CwSGmGJlGxGDUjAM8qC5NbscS1QSx+6oYH8obO5xPPL0CFxKc3DUF+jWK
         I+fL/bCEtSn7GW1jW0o5acXATXk52qib9HAnxfddKtqtq4m65c22s3XsvER5JI6s3FB/
         VLX065J23z/c6tYvtHpmfV1mp1peoVqGWAAG2b9qHBZyWVt/9PLZVc3O55QIkaCxBQEl
         fpZA==
X-Gm-Message-State: ANoB5pkkX50XoJT//1PDQz0g/v5sOc+LIEtGn38hc683Veui1J+yTZia
        guC/ipejqdfqKQYRBDuiNKXifWUPj1WJY4Xb
X-Google-Smtp-Source: AA0mqf6DwDqXwrHAqv7bLPeiptdnZv89CzrH1HU2Bu5M9aU4XJU2+5AtSs2LP1Z/YPPojvEGJJN7DA==
X-Received: by 2002:ac8:4987:0:b0:3a5:274c:611e with SMTP id f7-20020ac84987000000b003a5274c611emr83851427qtq.143.1670440629299;
        Wed, 07 Dec 2022 11:17:09 -0800 (PST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id j6-20020a05620a288600b006fc7302cf89sm18011383qkp.28.2022.12.07.11.17.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 11:17:08 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id v8so10698257qkg.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 11:17:08 -0800 (PST)
X-Received: by 2002:a37:54e:0:b0:6fc:c48b:8eab with SMTP id
 75-20020a37054e000000b006fcc48b8eabmr15349880qkf.216.1670440627927; Wed, 07
 Dec 2022 11:17:07 -0800 (PST)
MIME-Version: 1.0
References: <CA+55aFyJkpSa6rwZ-5xTihfGiNC_T0oL6txrodYBEo2-0O=p7g@mail.gmail.com>
 <1499156564-29458-1-git-send-email-peda@axentia.se> <053d7bf2-9bf3-a71c-5713-7cce19413c37@infradead.org>
 <a546f2db-371e-4d2f-a0ee-c71fcae8c548@app.fastmail.com> <41a5931e-3543-6a3d-ca85-2dd8ad581f2e@infradead.org>
 <efaf326b-3cd9-40a4-8424-b5f60270beae@app.fastmail.com> <f5fe43c0-907e-e5b0-7642-6748f3b1b31c@infradead.org>
In-Reply-To: <f5fe43c0-907e-e5b0-7642-6748f3b1b31c@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Dec 2022 11:16:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=whWKBKmoq-BOCgFGfZQ45vPP2ujb-wAG8q2PCvjngz3yg@mail.gmail.com>
Message-ID: <CAHk-=whWKBKmoq-BOCgFGfZQ45vPP2ujb-wAG8q2PCvjngz3yg@mail.gmail.com>
Subject: Re: [PATCH v2] mux: remove the Kconfig question for the subsystem
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peter Rosin <peda@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Dec 7, 2022 at 11:03 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 12/7/22 10:57, Arnd Bergmann wrote:
> >
> > They cannot, that is the entire point of hiding the subsystem
> > when it is not used.
>
> OK, if you say so. That doesn't make any sense to me, but whatever,
> I'll drop it.

The config phase of the kernel is one of the more annoying parts (the
rest is pretty much "make" and "make install"), and we should strive
to make it as simple and obvious as possible.

One big thing for that is to *not* ask questions that make no sense.

We already hide a number of them, either by disallowing them ("this
driver only makes sense on this architecture" kinds of things) or by
always forcing them on  ("if you're building for a PC, you're getting
the keyboard driver whether you want it or not").

And in many cases, we don't have questions at all, but enable code
based on automatic selection (ie "you wanted ACPI support, so we'll
enable CRC32 support because the ACPI code needs it").

I don't understand *why* you'd ever want more nonsensical questions?

Why would you ever want to ask a human "do you want this code that is
never used"?

That, to me, is actively a horrible thing to do. It only makes the
Kconfig worse. Don't do it.

         Linus
