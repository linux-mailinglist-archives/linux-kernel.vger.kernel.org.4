Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18696C0E33
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjCTKG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjCTKGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:06:05 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C2E10409
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:05:23 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5419d4c340aso214192357b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679306717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RS5uQJNZ1THmu6+X8Hb2Mm7jDWUuSU7jbDW+7hVrlos=;
        b=Jb44Xtwe8Y35yQASV5loMBMF0QSIw63XrGakD6XtfCfAbvOm/HWXnpBAI64kBYyRja
         EtjRUUqT7GecQtZ/BTNM5wRh4mR1Dm8X3/ssSlR4WrS3am1pjSalNEiiQ8H9Wgm6U90V
         ro+43zgOVBPrGYB+9BM/NCet5EDqRr/W6CZWsZczhIe7pGbZhPL1t9kSNfrfMuvL0Mvf
         IECWpKRYes/oJjCN7apQea6V64VE1ZrtE1TsJfdIqVCohFh0MFJCsUluLwlF9SuACccX
         sG5yYxWZVewAKIH2g38PHEJXouanmQ4QgPA4A1T1H1yttKK7iDPC4/NHn1rVaUyJNmTF
         XOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679306717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RS5uQJNZ1THmu6+X8Hb2Mm7jDWUuSU7jbDW+7hVrlos=;
        b=eE5qEYSblfI9et3vImZYckchXmF3cEukysbwx1Ve1k0HUl96owv3cTOy4TjPOEGeEm
         RKnOSFHqonHRxV1o8d1kFKok0pDR0YHOt6i4LObkdMRwiPVSq5mccK+AtCkSbsN6jYoo
         p3CGyuzsCFzH3nK4FWKYK/SZ0e0OGRs80Wchf5NxCRNGN+SuIWYKDTjcXQ9EzdMXuXDs
         aPhyye0Tt3p5+a/irc3XUBFlppQjyfp34Gn3OAQze/C4Icn0XbdzkoCjuKD1wTpAnysV
         CVVKvQitJqx/sW20agytlMyb6bgfuVz70arrWXDBLixbF61OtT3/nBG3iwwsYNDsHV9y
         A0gg==
X-Gm-Message-State: AO0yUKUIV0CYp6aYDcvlRd64U8ETYDcE4bWgalh02RXd+FmNBQwLSh+U
        0dibH9UQVShet0oEupkLinBR13rrr6+tJIoBLs4cuw==
X-Google-Smtp-Source: AK7set8yZJJ7PcEpWeL3Q3EKXcvp1UnUYfow+xu3cIExi7jlM4OJrw0lvCr1Ce3+4bMfd/5sBwGklabDX6Mfswnfh78=
X-Received: by 2002:a81:ae5f:0:b0:532:e887:2c23 with SMTP id
 g31-20020a81ae5f000000b00532e8872c23mr9961200ywk.9.1679306717628; Mon, 20 Mar
 2023 03:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230320093259.845178-1-korneld@chromium.org>
In-Reply-To: <20230320093259.845178-1-korneld@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Mar 2023 11:05:06 +0100
Message-ID: <CACRpkdbhV1qE+Kx4cqAKiv4Zacv6tQ8wKF8C6+0kZ-Dw=0cx7Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: amd: Disable and mask interrupts on resume
To:     =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        upstream@semihalf.com, rad@semihalf.com, mattedavis@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:33=E2=80=AFAM Kornel Dul=C4=99ba <korneld@chromi=
um.org> wrote:

> This fixes a similar problem to the one observed in:
> commit 4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on probe"=
).
>
> On some systems, during suspend/resume cycle firmware leaves
> an interrupt enabled on a pin that is not used by the kernel.
> This confuses the AMD pinctrl driver and causes spurious interrupts.
>
> The driver already has logic to detect if a pin is used by the kernel.
> Leverage it to re-initialize interrupt fields of a pin only if it's not
> used by us.
>
> Signed-off-by: Kornel Dul=C4=99ba <korneld@chromium.org>

Uh oh this looks serious.
Do we need a Fixes: tag and Cc: stable on this patch?

Yours,
Linus Walleij
