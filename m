Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECA3628790
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbiKNRzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237879AbiKNRzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:55:10 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48393E1B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:55:09 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id v8so7888917qkg.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cxt5lANrI7FwhmoytmNAOHC5IZYAo3MSo4g0rY4GDTc=;
        b=RTd++5qhAnhu+bcs+CrcV1ZUrgpluyPk9ZWME6R6HoHbDEZgZUb4HV2LaWG1HKM+xt
         2TyO6fvzYRYxuLSk/GPlqR0vWgS5WE9rslbqvJMJcSVqOShTzLpsBqwfcNw1Bwi1QvdN
         89+bX0mbwnQAvGrkm/2gC0vyz+5cEX1vCg7pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cxt5lANrI7FwhmoytmNAOHC5IZYAo3MSo4g0rY4GDTc=;
        b=E9PNbJ5xsEjDp9Uokxn8HZjJvh3iBOTuv1RWdRr7t+V87SB9Cp4y6Jy3n87Y4XloBe
         rJcS+iGV7y46TT924UMoJfc6ZnndxWk/uwEFMshb+kNCkSNRR2Hgz6Nc/RqrQ398EtD9
         E7yzp1A1+9kTc39ine2e5mJaMoItnmsIYmP32bIEKenKYWYsHVP9Pol+5qPbTsxUYLlg
         GE20Dl2I731Rr3AlyMFV5u790saVWeZ2eymK50PH8ghahrYyTLspXfQu5ZbFDGMcJqWO
         NihYvBYkq0JgQwDGwjChk1BA9Wo+eTL8TS4W3D4BL6b+loK8Dw7LNn2h4XapC9PyotzD
         eYqA==
X-Gm-Message-State: ANoB5pmf55T0oPVg1LMtYBLAF1IF+TZDSpspiWp+s+LXRykW6NyAf6F3
        EI3/8QFU3nKg/6TXdB6j6hqTlCxlo7jUug==
X-Google-Smtp-Source: AA0mqf5DVXpCLN8oTxU1r123kyA+K+6tQphrIXpc0i+hsXgLXjN/r1S+s2cVwuXezbT6jXpMOMqCVg==
X-Received: by 2002:a37:843:0:b0:6fa:32ca:4944 with SMTP id 64-20020a370843000000b006fa32ca4944mr12343175qki.738.1668448506513;
        Mon, 14 Nov 2022 09:55:06 -0800 (PST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id y11-20020a05620a25cb00b006ef1a8f1b81sm6913941qko.5.2022.11.14.09.55.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 09:55:04 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id hh9so7230875qtb.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:55:04 -0800 (PST)
X-Received: by 2002:ac8:718a:0:b0:3a5:122:fb79 with SMTP id
 w10-20020ac8718a000000b003a50122fb79mr13117198qto.452.1668448504427; Mon, 14
 Nov 2022 09:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20221110064101.429013735@goodmis.org> <20221110064147.343514404@goodmis.org>
 <875yfitpdu.ffs@tglx> <20221113191518.0a3b29b1@rorschach.local.home>
 <87sfims7ca.ffs@tglx> <87iljhsftt.ffs@tglx> <CAHk-=wj7DtViDctAzV3PqdYBEh5vcQnRJPtFFB=uaAP=W-VG4A@mail.gmail.com>
 <20221114125031.19f8330c@gandalf.local.home>
In-Reply-To: <20221114125031.19f8330c@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Nov 2022 09:54:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgKHdre_q-1bpnhJk59nQxVC=0e0MQ9p_0dUfp8P=cALw@mail.gmail.com>
Message-ID: <CAHk-=wgKHdre_q-1bpnhJk59nQxVC=0e0MQ9p_0dUfp8P=cALw@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called
 before freeing timers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Eric Dumazet <edumazet@google.com>,
        Marcel Holtmann <marcel@holtmann.org>
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

On Mon, Nov 14, 2022 at 9:49 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I can create the above series, if Thomas is OK with this approach.

Note that I'd definitely be more comfortable with a "real"
implementation, but only if people are happy with it.

Of course, the alternative is to just keep it entirely as one single
separate branch that does all of this, and _not_ have subsystems merge
things on their own at all. The only complicated cases I've seen (but
maybe I just missed some) were networking, and they could do their
stuff later.

So I guess I don't care _that_ deeply, and if Thomas is happier with
that "keep ti separate" thing, I won't object.

                 Linus
