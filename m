Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63645F8117
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 01:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJGXW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 19:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJGXW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 19:22:26 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0834A7EFDA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 16:22:26 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-134072c15c1so3920288fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 16:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F5BoNykg9DdTP86nR1hj2qVEnNXgZAlkfk4mmiIN8uw=;
        b=IqKgaIS63r3kOIRIX2KKVR+tU8zzuK2UXxgGFqM3SAv2GBE0YhbSoTOCgCvxj0XeIK
         tQxwqHDD82hYQrSiD/ju0o+r52qvtaQZhrMRx6neV9yTNLtpk+DKKJkwmNZWqHizaQU0
         N1XgSDovli24M/rL8jTmAYH0279QHtFkCf3AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5BoNykg9DdTP86nR1hj2qVEnNXgZAlkfk4mmiIN8uw=;
        b=aP89CbLCXssSVpx7C1BJdDLb6n5sPtRjGYB2Hb1tdmS3nKSsa7gAIKEhO5xrMmCDCg
         /knI4vgaerSdcIiXOKFzdau4Ud6JTxdSU7rv0/cUvXodEchgRhVxmae34yLUfarMKTJ8
         /SQOaYWd4i7irKmN65jLhmE6GR9rHyDOQjqabSGrxsWH7gosVdn4Yf2Yeap5NGYa5991
         mKjBbsBJefnP2E8gWpnKSnb5PCqaD3dojnVSEskPhOgL/fb1B91ve8xVvwfas2dxm1MY
         zGoNNzs6nhFxCcs2bJaRxyQLTZrMYs1rKAqRGfkn5QBilNh95n3npzxMWmGQbpG31RGz
         +2aQ==
X-Gm-Message-State: ACrzQf3oxjrCkPyqg67bmxAq9PiIKJfAkV25p8Kx3wsNyppUdZ49dGYU
        iZbmAOeOXVoN39jo43tn5610txCxwHKeXQ==
X-Google-Smtp-Source: AMsMyM5c2U17teAZ04TBrNdOicAY+6/LneVYX1KocDG0uw3Qw0EZdT7LidIOlCAZiPCnfMCKUnr9Jw==
X-Received: by 2002:a05:6870:8906:b0:133:ae7:ff1f with SMTP id i6-20020a056870890600b001330ae7ff1fmr5962042oao.33.1665184944526;
        Fri, 07 Oct 2022 16:22:24 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com. [209.85.160.45])
        by smtp.gmail.com with ESMTPSA id 20-20020a544194000000b00342ece494ffsm1532951oiy.46.2022.10.07.16.22.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 16:22:23 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-132b8f6f1b2so7105483fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 16:22:23 -0700 (PDT)
X-Received: by 2002:a05:6870:c888:b0:12c:7f3b:d67d with SMTP id
 er8-20020a056870c88800b0012c7f3bd67dmr4007725oab.229.1665184943020; Fri, 07
 Oct 2022 16:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <Y0AnSpbH3B9U0H8I@matsya>
In-Reply-To: <Y0AnSpbH3B9U0H8I@matsya>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Oct 2022 16:22:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeQyCx-FGSaBckR+HgrMPYoHY2jwRq4J4JzpOczc+3fQ@mail.gmail.com>
Message-ID: <CAHk-=wjeQyCx-FGSaBckR+HgrMPYoHY2jwRq4J4JzpOczc+3fQ@mail.gmail.com>
Subject: Re: [GIT PULL]: SoundWire subsystem updates for v6.1-rc1
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, Oct 7, 2022 at 6:19 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> soundwire updates for 6.1-rc1
>
>  - Pierre-Louis Bossart did another round of Intel driver cleanup to prepare
>    for future code reorg which is expected in next cycle
>  - Richard Fitzgerald provided bus unattach notifications processing during
>    re-enumeration along with Cadence driver updates for this.
>  - Srinivas Kandagatla added  Qualcomm driver updates to handle device0 status

So one of the things I do for merge messages is I try to make them all
_somewhat_ consistent.

That means that I now ended up editing all your explanations to match
the more common pattern, where when people credit the person doing the
work they put the name in parentheses after the explanation.

Partly that is just for consistency so that our logs read more like a
uniform body of work, but it also means that you don't need to add
pointless filler words to the explanations ("did", "provided",
"added").

So if you really want to mention peoples names (and it's ok, but it
does show up in the individual commits, so I'm not convinced it's
necessary in the merge commit overview of "what happened"), please try
to use that model.

And no, we're not really all _that_ consistent, and there's really a
few different merge commit patterns that we have.

Generally I try to make my editing fairly lightweight, but this was
just _so_ different from the normal merge commit log pattern that I
felt I needed to just edit a lot more than usual.

So a gentle query to maybe try to make them more in line with the
other patterns in the future to avoid extra work?

               Linus
