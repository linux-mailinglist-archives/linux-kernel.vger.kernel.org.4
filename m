Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA8D6A2D23
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 03:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBZCOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 21:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBZCOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 21:14:33 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D46113FC
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 18:14:31 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id h16so12294135edz.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 18:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrheFcgQEPwZjvgo8TDr9t7WDxew84jDqDyy77Jx6U4=;
        b=LMXAOqzcMAN8M0lUbRtgYnlyXLIjveY033hYrk0yuyDTD16izAhROYfs6Dd2+iGxUl
         ri8t0ubJGiCGQKZMyPWaunCEEmpXQIGOTdBHG27Y5AbKBnuts8q1DedSkg5+wLf53rIB
         Ix7vxtPJdyIduJc/OL4K54Yie45HlYpHQ0HrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrheFcgQEPwZjvgo8TDr9t7WDxew84jDqDyy77Jx6U4=;
        b=HDU2pObU3AoU0eCqwpU1eSt5G/YBZ8hPUkdBQaQbycx+4o5dIgSF7Q88Ad8jvQ1I67
         3cXTIV4eU9M5LQ+TLcHdWslr4ML8xETNY/BaItfDWSXummnyFilUlr3Qp6Hk8HW7NAvt
         VMVbjZJZfcNhyekBn7E+/69xclttILr995S3NvQrxoc52U6lZWWrKqhN1K80LNz+x2Pq
         Etj7PEAXjkTwb+lj7Wc44rLh5Q4UZtJw5rcpqcXS14FM0IQOHcBKteAXFmgIJV/SQ+Uw
         CPDFTjx4pfGKsjOdi8RP77JvSImyL+gU6niFrUzppILOzpuu1Q8zSW76u2N3wbwDLkba
         JqVA==
X-Gm-Message-State: AO0yUKU/zNWeC1dgLBGb6HUXREEcLKMJLlZt+ZU0Px19t6jfAWA+mMdg
        SPxRZg7hrPaFj2itw0M2PLov5H6ooRjMlB9ojxQGyA==
X-Google-Smtp-Source: AK7set9n3GQ0VZslWxqFfDZyBvBcdE+lGpy46Mr0qePn1FADkdMy9kSbMEok/swKaYynsUAool/STQ==
X-Received: by 2002:a17:906:1689:b0:87b:dac1:bbe6 with SMTP id s9-20020a170906168900b0087bdac1bbe6mr29379538ejd.36.1677377670185;
        Sat, 25 Feb 2023 18:14:30 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id m18-20020a1709061ed200b008d427df3245sm1456128ejj.58.2023.02.25.18.14.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 18:14:28 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id i34so12367800eda.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 18:14:28 -0800 (PST)
X-Received: by 2002:a17:906:b55:b0:8f1:4cc5:f14c with SMTP id
 v21-20020a1709060b5500b008f14cc5f14cmr4302368ejg.0.1677377668178; Sat, 25 Feb
 2023 18:14:28 -0800 (PST)
MIME-Version: 1.0
References: <Y/iywbFbiUAA6ZD3@kroah.com> <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
 <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com> <Y/qcXOxTVHTNDQbY@mit.edu>
In-Reply-To: <Y/qcXOxTVHTNDQbY@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Feb 2023 18:14:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjPrei8BkaJ3wjGF_fTsehhQZVZppzqYrt76oc+oYXk8w@mail.gmail.com>
Message-ID: <CAHk-=wjPrei8BkaJ3wjGF_fTsehhQZVZppzqYrt76oc+oYXk8w@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 3:40=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> For what it's worth, in the VM world (e.g., qemu, AWS, GCP, Azure,
> Linode, etc.)  serial consoles are quite common way of debugging VM's,
> and as an emergency login path when the networking has been screwed up
> for some reason....

Everybody seems to be missing the point.

We don't make new drivers "default y" (or, in this case, "default SERIAL_82=
50".

It does not matter ONE WHIT if you have a serial device in your
machine. If your old driver was enabled and worked for you and you
used it daily, that is ENTIRELY IMMATERIAL to a new driver, even if
that new driver then happens to use some of the same infrastructure as
the old one did.

             Linus
