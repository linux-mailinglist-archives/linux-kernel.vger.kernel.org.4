Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA84680B26
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjA3KpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbjA3KpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:45:05 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39384303C5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:45:02 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id e15so13424734ybn.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71XgswOr1+sZGoFqqq/sqekWXb+8lPdFnkGQ+6sDRWs=;
        b=HHtwYQLQZKO4H3ESpkSS0Toe2X0ZmQfd6n1Rig6scRX4jYa08YtNWcOmIgnoLO6xpj
         4zrOkuNbUaoErfwKvulr2O2xCzUiFxrY+CRPgmbzlICCUhapkJFOxpSyr4woqMfN7yWf
         qB9jCEKybiMPbj/1ZleTTJMfJG1e8HwDTSseYU1QePoziHf8wToe9zrt5aKuj3ibs9tQ
         8xX7ye4jfzsXwWkAim4PzrKDJ9RklqDo3rXZr2tOHLH/y4/7wkw6F0g9wvp++e3vuE0L
         9/D0sthxjO40vPv9xeSGhaTGta955VTmOfsLbxydDC8ZRVyeUEzX2fgC6kVgFAXTlg+f
         KeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71XgswOr1+sZGoFqqq/sqekWXb+8lPdFnkGQ+6sDRWs=;
        b=kqnp8eq0a+wwKcjqjjFZF3wy7hWT59h0JThBqCiyi3195bAuFrtb+6sfidlnjOF8cH
         8ZoKemv9yuCtw/j3VhzwzOgH+VAal4IwbeCBB4CZPR4v//c1dSaaj87e6/e4PRAeMapP
         YYIigkz8hp7UCtKm8g6WwkPROIf+jDNsrxDW5hVuRXB8x0h2RRnSosobj8kuoTEUqzeO
         jWR9v0Yj3RlpnmIG3iwFS+hKS8I57l94ofGFbNZDxfTG3sw35sB3IVDgUcbGAgigKF+a
         tIXLVQEuHfIk/xuQdmPX/Vnh184wkaijE04yo0twpZu1OUj0aV1pR93B7UYhWHNdHtq/
         ju+A==
X-Gm-Message-State: AO0yUKVdezag3HtZT+3Dkf522WrGYF9/ZgCj/7sl3l4Sgt459bh7aXR9
        NhMR9aloToVlRgy/aD2FOrpYarmkanmSyKyVdEkseQ==
X-Google-Smtp-Source: AK7set+ZuiLyMuoEEgzd+xb0t21ts7HDLfejBQTRcYsYZf7zDRmRCHmRPKMW/UdiBOqI8W2UQP3uJLPqw+VGdJKUIOI=
X-Received: by 2002:a25:d884:0:b0:80b:66c5:9fc5 with SMTP id
 p126-20020a25d884000000b0080b66c59fc5mr2825641ybg.210.1675075502014; Mon, 30
 Jan 2023 02:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20230127154339.157460-1-ulf.hansson@linaro.org>
 <5743fb1b-eb4b-d169-a467-ee618bcd75f5@kernel.dk> <CAPDyKFqFrB4h21F0901nBp-mpiP70nObOrCpRA0ZRfOD_kD5ug@mail.gmail.com>
 <3ba1adc6-4fb4-036c-8eca-91f549471c49@kernel.dk>
In-Reply-To: <3ba1adc6-4fb4-036c-8eca-91f549471c49@kernel.dk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 30 Jan 2023 11:44:51 +0100
Message-ID: <CACRpkdY8DbvSMcf00zSwm5z1v3nWKMoJ+wYL90E9iR2W2hpvCw@mail.gmail.com>
Subject: Re: [PATCH] block: Default to build the BFQ I/O scheduler
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 9:10 PM Jens Axboe <axboe@kernel.dk> wrote:

> On 1/27/23 8:58=E2=80=AFAM, Ulf Hansson wrote:
> > On Fri, 27 Jan 2023 at 16:48, Jens Axboe <axboe@kernel.dk> wrote:
> >> On 1/27/23 8:43=E2=80=AFAM, Ulf Hansson wrote:
> >>> Today BFQ is widely used and it's also the default choice for some of=
 the
> >>> single-queue-based storage devices. Therefore, let's make it more
> >>> convenient to build it as default, along with the other I/O scheduler=
s.
> >>>
> >>> Let's also build the cgroup support for BFQ as default, as it's likel=
y that
> >>> it's wanted too, assuming CONFIG_BLK_CGROUP is also set, of course.
> >>
> >> This won't make much of a difference, when the symbols are already in
> >> the .config. So let's please not. It may be a 'y' for you by default,
> >> but for lots of others it is not. Don't impose it on folks.
> >
> > This isn't about folkz, but HW. :-)
>
> Is it everybody? No, it's a subset. Everybody adding a new driver wants
> to default to y/m, and it's almost always wrong.

This isn't about individual drivers, as I showed from the udev rules
used by Fedora/Redhat it is clearly entire subsystems and hundreds
of drivers that desire this.

Ulf can certainly decide what is best for the MMC and memstick drivers.

Thus I think it is probably best to make each subsystem that desire
BFQ imply it.

Yours,
Linus Walleij
