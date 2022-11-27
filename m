Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933D4639DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 00:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiK0XAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 18:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK0XAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 18:00:17 -0500
X-Greylist: delayed 900 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Nov 2022 15:00:16 PST
Received: from smtp2.dei.uc.pt (smtp.dei.uc.pt [193.137.203.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFC5D105;
        Sun, 27 Nov 2022 15:00:16 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        (user=sneves mech=PLAIN bits=0)
        by smtp2.dei.uc.pt (8.15.2/8.14.4) with ESMTPSA id 2ARMe3ZY028407
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 27 Nov 2022 22:40:09 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.dei.uc.pt 2ARMe3ZY028407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dei.uc.pt;
        s=default; t=1669588809;
        bh=pP7EychdTeHb0EDOPmOHs6dm6IB9tlMRybklmtPiPxs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CPG37KF2woI+vwvwk4YeYpbJ7f9ojnlpL4ebT3qHYnhIjbjYtSwyiNbyP4iGRUcRJ
         agYets6rbONb0pd86ZejtsCS8a3simCy2l/jRNl2smS7GvM/y7j1Ig2DjRj8p2gCBP
         BnVrtKXXlPoSYN2HUimvgGW7MvtUjadlX+0BMJ/4=
Received: by mail-lf1-f54.google.com with SMTP id d6so14802203lfs.10;
        Sun, 27 Nov 2022 14:40:09 -0800 (PST)
X-Gm-Message-State: ANoB5plfv/v+hdKN1ttkBb3enAACmB7QYSHz4YoWipQUHrWadn4dpBux
        8XjSWv6PnF85Pti5CPVe/iHQPgBkhm5kWHWiyrM=
X-Google-Smtp-Source: AA0mqf6/QqYK8Ow78Dq/iCZ+7AyFn1rnL14fN4db8EpNio8qIMAF6I4CpzY2inQz7lBHVHBN7nbuUBKchS1L7zCQpz4=
X-Received: by 2002:a19:675c:0:b0:4a2:5be6:c0bf with SMTP id
 e28-20020a19675c000000b004a25be6c0bfmr18154758lfj.390.1669588803552; Sun, 27
 Nov 2022 14:40:03 -0800 (PST)
MIME-Version: 1.0
References: <20221124165536.1631325-1-Jason@zx2c4.com> <20221124165536.1631325-4-Jason@zx2c4.com>
 <874jumy6me.ffs@tglx> <Y4PfjcQRfezjH4f+@zx2c4.com>
In-Reply-To: <Y4PfjcQRfezjH4f+@zx2c4.com>
From:   Samuel Neves <sneves@dei.uc.pt>
Date:   Sun, 27 Nov 2022 22:39:27 +0000
X-Gmail-Original-Message-ID: <CAEX_ruEq8_W8i-+cfri2-BYBNDgZCinsfFKVeFjxNSfnGxW1xg@mail.gmail.com>
Message-ID: <CAEX_ruEq8_W8i-+cfri2-BYBNDgZCinsfFKVeFjxNSfnGxW1xg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] x86: vdso: Wire up getrandom() vDSO implementation
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-FCTUC-DEI-SIC-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-FCTUC-DEI-SIC-MailScanner-ID: 2ARMe3ZY028407
X-FCTUC-DEI-SIC-MailScanner: Found to be clean
X-FCTUC-DEI-SIC-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
        score=-59.69, required 3.252, autolearn=not spam, ALL_TRUSTED -10.00,
        BAYES_00 -0.10, DKIM_SIGNED 0.10, KAM_DMARC_STATUS 0.01,
        L_SMTP_AUTH -50.00, T_DKIM_INVALID 0.30)
X-FCTUC-DEI-SIC-MailScanner-From: sneves@dei.uc.pt
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 10:13 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Thomas,
>
> On Sat, Nov 26, 2022 at 12:08:41AM +0100, Thomas Gleixner wrote:
> > Jason!
> >
> > On Thu, Nov 24 2022 at 17:55, Jason A. Donenfeld wrote:
> > > +++ b/arch/x86/entry/vdso/vgetrandom-chacha.S
> > > +/*
> > > + * Very basic SSE2 implementation of ChaCha20. Produces a given positive number
> > > + * of blocks of output with a nonce of 0, taking an input key and 8-byte
> > > + * counter. Importantly does not spill to the stack. Its arguments are:
> >
> > Basic or not.
>
> Heh, FYI I didn't mean "basic" here as in "doesn't need a review", but
> just that it's a straightforward technique and doesn't do any
> complicated multiblock pyrotechnics (which frankly aren't really
> needed).
>
> > This needs a Reviewed-by from someone who understands SSE2
> > and ChaCha20 before this can go anywhere near the x86 tree.
>
> No problem. I'll see to it that somebody qualified gives this a review.
>

I did look at this earlier. It looks fine. I would recommend changing

+ /* copy1,copy2 = key */
+ movdqu 0x00(key),copy1
+ movdqu 0x10(key),copy2

to

+ /* copy1,copy2 = key */
+ movups 0x00(key),copy1
+ movups 0x10(key),copy2

which has the same semantics, but saves a couple of code bytes. Likewise for

+ movdqu state0,0x00(output)
+ movdqu state1,0x10(output)
+ movdqu state2,0x20(output)
+ movdqu state3,0x30(output)

Otherwise,

Reviewed-by: Samuel Neves <sneves@dei.uc.pt> # for vgetrandom-chacha.S
