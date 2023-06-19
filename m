Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82827735789
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjFSNBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjFSNBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:01:31 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2196E7E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:01:19 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-47184397ab4so1331825e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687179679; x=1689771679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOOoSS+F0a2RdMkqm6GJBrGXPR5DaWdsNr0kGMMs4Bw=;
        b=OB3K3a9ApKPYdKLzEKgj+0sANB6yFN5fyA2ZQ5yXfulJc9FMwylO48yycbNNORDKwW
         YGm9vup9enufN5JJHX6FinTz4XpFVigEWZ7lguoNIEfAaiLtdHBsJRjw3dKrNslJ3MkV
         GgjynCEESy9hOunZFqpFCKAzNuXHLvOl/n+Ye9XF/oodN4WDUimFE7q5BYkPlMHLZsmP
         bzJwUMwYiVHgazw5f0cQJSqWsm4GrILgUoOMHP13AHtVviK2nY+VZHKKloN649LaQMYD
         VsRokbRY8e6j9oKPae8PPCMUgKznOckD+LHgxpB7ObGqpGoJHUeoTlVLWfF2ox76J+rm
         XsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179679; x=1689771679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOOoSS+F0a2RdMkqm6GJBrGXPR5DaWdsNr0kGMMs4Bw=;
        b=dMSA7OfAT8cFIk2jAmOAfeiypoGAvVOTW6XX6xCD8bkaVL5DjtjriKMcnBWyrP/S9+
         iTe3FVFaMd4zL/2EqS9Rvdh6s7JFeOiF0o28QsKXq7eN6VmrC4a7WbDMOIANX46bap/8
         fTxuphjog52KTZz/U6JRh/ffqZQqTPebVDaYmrcVwCcrRnqxIhKg8YXpGSoRw25jsA2b
         +6awuA0L9cDqR82HSG875rJANmfJfwkB6XM4FLauG3TBWEn6jMqckY+zD3D/mzCjJ3UK
         ICejhgu94ZNq/q4wrwiCjMG8a2nTvDsCeCiDihPxeg2KVFgEicuws2GkBt1jOUXnLvzq
         PiVQ==
X-Gm-Message-State: AC+VfDwAR0TMztUc1ubmGlrXKl55zJqHGAgDOt1CCD7N1jvjviORFa44
        a6U6kD4gFl6Tj0GEokd6JMKQMQW/PO76Zhn+5lAfgA==
X-Google-Smtp-Source: ACHHUZ5zM9XHtakKxyFSDb4NdBBVpJlXIrmV5Jzbs7XjYL8/AvTVYGd3lv+B7bY+b0R5GUnt7vbhKgEf4wVb2JOSWkw=
X-Received: by 2002:a1f:641d:0:b0:457:56a4:19e7 with SMTP id
 y29-20020a1f641d000000b0045756a419e7mr2192721vkb.0.1687179678927; Mon, 19 Jun
 2023 06:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230616135313.76338-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230616135313.76338-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 19 Jun 2023 15:01:08 +0200
Message-ID: <CAMRc=Md28NqUudp38yZZx1vqvyxXQ=-zaP-Wzo2dy2mbBrfB8Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Drop unused domain_ops memeber of GPIO
 IRQ chip
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 3:53=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It seems there is no driver that requires custom IRQ chip
> domain options. Drop the member and respective code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied, thanks!

Bart
