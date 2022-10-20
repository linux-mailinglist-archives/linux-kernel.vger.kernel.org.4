Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12962605F84
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJTL7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJTL6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:58:55 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C960613A7EE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:58:54 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id n5so392887uap.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hmdoR/w6BYsfomWVh267+r2sbsTxrmcMIZmpfdw25R8=;
        b=chHdDPwrngCggbBKdIbWiDLCXZnP7iqdEib8Kgvwcwr079ZvVEZkyUZObQbu4LPB9v
         ZmZL9dksUjp5QOtQRXo+nXXBnvv0ujExpS8AhU5qghI4lpxjdojJ+Jx1DFH/NDbbjInN
         ruQ+XSYsr7gXr+cizYo+gc/5gO69+XfMLDsAFSr2pTkJNvNGaDa611kzMo9dj1wzqVFD
         4TbBFWpTanYKbeHGfToaLYQ13uydaHAIuvhnLU/Tcm3eyy8MijhlRbUxHpVVNMcOju9n
         vuXpLEQZYve0hDHgWQLaZ75WAaibrb2NzPg58Y9znicE6ZnLCW1mmy942uanNWrXTHPm
         dTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmdoR/w6BYsfomWVh267+r2sbsTxrmcMIZmpfdw25R8=;
        b=bPfvEltFsJMkn+Z7zTdcekwsl2MFp7btn5T71vkSA9dXDJkqNgenXY97eMNG1f/1dj
         CqVq+HneFXw+oVE31982AeKaz02XjaocsZ5hZB5BMSH/VEUUEgne5wWzrHirhhVbOv1X
         rURrMiQIpu2hTkzpgDst/npfKZLEXPpdkTpit5+bRJm2n566l6GYsOe5chI3+y+YAprY
         arcJ9MRChm/O2CvWYvEaa/2DyWL1VxtG9mwqc0q/pBa0cQsFyFNS4fnPqEThH/lCYE4Q
         YkLwOMz5h5iqeOLdrEj6SorCBm7qU3OluIBdyHpVi9v9DxLluVMqKUj90n8JklCUp48X
         MHTA==
X-Gm-Message-State: ACrzQf2vnZSsRjE5AoAvRrv3OWKh5MulNqF8VJAuBkm7ZC5hMis197zN
        I7QroACZe732rMjh7M2bEPkBMtuMsM0yHP8CpuUCGw==
X-Google-Smtp-Source: AMsMyM60th5P2fPMIOJLE3lPxXDmFgQe29j7XFR82PlU8rUG/MVn+bF0Ceu1sunzO0mIDlQiOE400CHnNlslzzchU9E=
X-Received: by 2002:a67:ab02:0:b0:3a9:9953:6471 with SMTP id
 u2-20020a67ab02000000b003a999536471mr4410633vse.47.1666267133910; Thu, 20 Oct
 2022 04:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com>
In-Reply-To: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Oct 2022 13:58:42 +0200
Message-ID: <CAMRc=Md+zoaMHkDJm=SYEZMiHSF7_gYiXApuEboPU5qFpnD_1w@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] gpiolib: more quirks to handle legacy names
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 7:41 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> In preparation to converting several drivers to gpiod API, and to keep
> existing DTS working, this series adds additional quirks to locate
> gpio lines with legacy names.
>
> Additionally the quirk handling has been reworked (once again) to pull
> all simple renames (ones that do not involve change of indices or other
> complex manipulations) into a single quirk with a table containing
> transformations. This should make adding new quirks easier.
> When using legacy names gpiolib will emit a message to nudge users to
> update DTSes (when possible).
>
> Note that the last patch requires the following change from the OF tree:
>
>         88269151be67 ("of: base: make of_device_compatible_match() accept const device node")
>
> The change is also available in mainline - it has been merged in 6.1
> merge window.
>
> Thanks.
>
> To: Linus Walleij <linus.walleij@linaro.org>
> To: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
>

I applied the entire series.

Bartosz
