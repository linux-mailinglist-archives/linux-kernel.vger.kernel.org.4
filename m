Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984EC6DE47A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDKTJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDKTJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:09:13 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B417340D5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:09:11 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id q4so541348uas.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1681240151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQhhr9Ip86r6ZvIfgqpM55UW/t/4MnhV/laWRNygUq4=;
        b=hMBlMJ3A1xKavy15Nnk/EULQvKAVjUVcabPbXt3f2MnKjkA0N8moehaI881iDcye7O
         w2tkLMpwBGi3b4bvq3xKqwt2o4LXRWO5dcxF5fmDFlp/ZKLcHWxLad4NkyXhpCZtwBLX
         mQBQ1bG2eePKiKjeXYgW5hrWTH7xgNeiq1QprtmTgccTFX9fsNHhEN4NvFBx1Z1UVHdE
         wtxmfktjzeEGHlmT/80fpMF1YJoEaWeClZxF1q6WfuxB+Gs92x2bQOufLeRFywuL/BMZ
         IrTDIunsdANCex7g/1QNZq5ujLkWqC1owx/lFmBrNhY2fQ/JG1YAsLr411B9m99rYZIl
         A+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681240151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQhhr9Ip86r6ZvIfgqpM55UW/t/4MnhV/laWRNygUq4=;
        b=2YV+r6HNsUFz52vpwbYKiAAOJfBxPOo62hotyEsWVkk3P/13HOm7kne9QQaUNHpeD1
         r7tge/Cg7OAPgKjywM4EMNdJCfd5J1S6cBv4rHRLBR+OSsfrVp52isK5LUdaDjd5aYFM
         Xfe8nRtCfsxn058jLkWnx6UFmmhpqgqhTK3ibaNV6Vzqne3sop6q0v2LMdLOb8Snv+JN
         t0AeViCDFOhRHxB1dlktrQBfI+LrCH3VpLR7xya2MrWE/MMwQ7EmyvpoCQ52W09qFyKS
         +Vz1D0NOFAFVYvIYm3xsY2FGD10cuMK+0ksPoV+CJ3s3zwi6hvZ2qDeIxfEdi1xWM1V0
         M4BA==
X-Gm-Message-State: AAQBX9eTTuNOyww1mkCd31OHNUzWvgiaRA6Oesiojaj3JQNYWdToN9yb
        sxXj/wYl0NwKFRjIg8qsXaKlLs9ErhPKN063aDv4vA==
X-Google-Smtp-Source: AKy350bI8o7kzdDZ+pXJmuB+ctVQta4nyVfXmcJLJqKwUgDtM7gAsZvZ8MbwMqd0LZ55wfyXB2PSb/zXAJB66h+cqqI=
X-Received: by 2002:ab0:54d8:0:b0:765:d142:bed9 with SMTP id
 q24-20020ab054d8000000b00765d142bed9mr9811992uaa.2.1681240150855; Tue, 11 Apr
 2023 12:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680543810.git.william.gray@linaro.org>
In-Reply-To: <cover.1680543810.git.william.gray@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 11 Apr 2023 21:08:59 +0200
Message-ID: <CAMRc=Mf2TQbbtCDotTFZ=-P-b8GvqRU2pcHFTA4L_=d29FRmWw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix possible deadlocks for i8255 GPIO drivers
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 7:53=E2=80=AFPM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> The 104-dio-48e and 104-idi-48 drivers leverage regmap-irq to handle
> IRQ. The default regmap locking utilizes spinlocks but this can result
> in deadlocks for IRQ chips when running -rt kernels [0]. Enable
> use_raw_spinlock for the regmap_config of these drivers to prevent such.
>
> [0] https://lore.kernel.org/all/1466065537-82027-1-git-send-email-mika.we=
sterberg@linux.intel.com/
>
> William Breathitt Gray (2):
>   gpio: 104-dio-48e: Enable use_raw_spinlock for dio48e_regmap_config
>   gpio: 104-idi-48: Enable use_raw_spinlock for idi48_regmap_config
>
>  drivers/gpio/gpio-104-dio-48e.c | 1 +
>  drivers/gpio/gpio-104-idi-48.c  | 1 +
>  2 files changed, 2 insertions(+)
>
>
> base-commit: d49765b5f4320a402fbc4ed5edfd73d87640f27c
> --
> 2.39.2
>

Both queued for fixes.

Bart
