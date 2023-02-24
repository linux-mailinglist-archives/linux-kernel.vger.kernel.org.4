Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03666A23CF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjBXVbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXVbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:31:21 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08979193FD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:31:18 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cq23so2722815edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JrE04gOVw81UKFZPld2Vl1EpoZ4FShZtZFABiCjDz1k=;
        b=U7gWuY7WPaAKGddJZQsgblTmmGzM6IGrhyDKpf4MIoCPtxKblnkp7k+m745hxwm/ui
         n52VtteVh03owR4gUOk5R8bZEWbffVclRpm8Y9uVx2kV5WrTXSUIuOGQh0Pt5tHKJcGx
         SgIim4KSTaNjJUhJgo5a4ziG5tr0JjQiKfD1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrE04gOVw81UKFZPld2Vl1EpoZ4FShZtZFABiCjDz1k=;
        b=lSIDMyQ5mg7qNUErZcCcHxOJYxg4gaeX9BqkawhkfxzJSVNVKOEhM2aVai4L68FVC9
         FIe97tI/mY6sZx39CEWgi9CxVnf8OJfpItI0YXiLSkxZLLM4iPSF6kAiOstW7hAWqGMt
         /uGJ7d2VnlQRWjTx5AHGwXovhxOOXYn1mQ8tMKzo1nyVF97xLTUrjrellDfzc0c1YmKF
         LXsiRNworXZMgv/n8/l7l9jddJCtA68dW8XIaqf9cdHhaBijv3jKHIFxWE/Kit0KXQXp
         tivUQFlUmSAZgiSkrqRMutAvMDdKENW9xpYC7HYyvAlaQvZHhik6gQ2WO2cQxcQpT3b+
         QONg==
X-Gm-Message-State: AO0yUKVBCbKnCyt42NcYj4MwMkW87Ep8endZlVXSHtbw4WznA2U1q7wt
        jBFlmzRjRFU5PU+eo92GzPaaEpREeUf+iBO1VO88Sg==
X-Google-Smtp-Source: AK7set9lZ1KZKFwhmmpkAb61ocp34zd/5zh9PJgGTQoM6hpUz1AdmP5YNS2aTtGqeYHEtxzK/eTpHg==
X-Received: by 2002:aa7:d048:0:b0:4ab:554:37ea with SMTP id n8-20020aa7d048000000b004ab055437eamr17062047edo.4.1677274276162;
        Fri, 24 Feb 2023 13:31:16 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id d1-20020a50f681000000b004ad72045ed9sm167262edn.65.2023.02.24.13.31.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 13:31:15 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id d30so2650179eda.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:31:15 -0800 (PST)
X-Received: by 2002:a17:907:73c6:b0:8f1:fd:50d0 with SMTP id
 es6-20020a17090773c600b008f100fd50d0mr2763634ejc.0.1677274275171; Fri, 24 Feb
 2023 13:31:15 -0800 (PST)
MIME-Version: 1.0
References: <Y/iywbFbiUAA6ZD3@kroah.com> <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
In-Reply-To: <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 13:30:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com>
Message-ID: <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
To:     Greg KH <gregkh@linuxfoundation.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
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

On Fri, Feb 24, 2023 at 1:24 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>         default SERIAL_8250

Hmm. Looking around, it seems to be a pattern. I'm not convinced any
of them are really valid, except probably the ones that aren't about
specific drivers, but about base support (like the "SERIAL_8250_DMA"
one).

I also do get the feeling that the base "SERIAL_8250" feature might be
better off as a _selected_ option, rather than a "ask if you want it".
I think we've ended up with that SERIAL_8250 being a base option
mainly for historical reasons (ie it was part of the original PC/AT
base specs, and then later it has become a "base driver for a lot of
random cards".

It's probably most legacy by now - it's a long time since I saw a
serial port being used outside of management ports, and even those are
often ethernet these days.

Maybe nobody cares.

             Linus
