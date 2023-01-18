Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E9D671F9C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjAROag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjAROaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:30:06 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62D04ED12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:17:56 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id i188so35826985vsi.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uFMItONQcV3wHNWf9eRWkDAG7Jn0b//4scmon3jUY88=;
        b=aKWai454ujSTSFS0fZtyL9Ofw6bMu1l+gf9ScaqZz7alqskx7+l9YqvRppX31BIKOs
         8x+8A6Vq7QYehwdCVYiPpHHBSjkUXA92nMh4MwbeRt8ZBMJokFtT/18lML3oBUGyO2yC
         NT5mHKKDzcDnM+YBgoPQ9wOVhY3BAFUZpKXG4iLMvRI/x20KKLYtxQ4ccTq4cRTpBgdr
         5GR+vZkwm0ZbEA35bpQocPmUqhkQ9gshidpRSxRmofNezfZCBDaLKdPRlRtQ4nyelCl8
         H5irIe4/UuxG6HGGpcAPcOqAAaFvg4K1E3ZfphtjvOIkt/z+kH0HykGxEDdHzgzITE7U
         R1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFMItONQcV3wHNWf9eRWkDAG7Jn0b//4scmon3jUY88=;
        b=xNH97dO9mmRshU8IwbNH9vA0ier1+8drLi9CZfgRZJMcTyV6BGM4IY6iOmkZmgzaQw
         9rmrDtSCOhMAex3ay0BYEp/mA5PcqsqKcsaPaQkuLas21x1cuqXnBsuChKcg0lYVkhNB
         wF5Yggn7OqqpPbxIaBqC8EZOcwaZURzIcAS6TxqB/z4rT8sVj41DbQef/32pA+pWZbeh
         JowlFfHL0Yt85qecQvI5SBkJRurd2HuKz0Zidl+FnSs5MnJnR1JEbmJJUiPIBm9Ayrhh
         tGtbWQH+cXIfJm51L8RlH2cZ5AGuNeZkw/Xex5cw98Gq+FT/Be6npHZvgcGJrhexURuu
         IL+A==
X-Gm-Message-State: AFqh2kpqSR1QBEAI8h3gRWF/S45M31k9PnMpPAxUbOE2VepZvoM/+dwf
        R66zRSOMsYmD6hHSpyRTTx5YyoXzph5CYdK5EsMIxw==
X-Google-Smtp-Source: AMrXdXuHS6Odt7c746q/SzVyx1SvpsAZROmsMt5CMpsunNF6P9iqbTAjqIzBH7aSzbl2fZn8kgrakXkULaLTFEp7qSE=
X-Received: by 2002:a05:6102:3e08:b0:3c5:1ac1:bf38 with SMTP id
 j8-20020a0561023e0800b003c51ac1bf38mr1064643vsv.78.1674051475264; Wed, 18 Jan
 2023 06:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20230116124704.30470-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230116124704.30470-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 18 Jan 2023 15:17:44 +0100
Message-ID: <CAMRc=MfR0TJ4RmuoL5-6w=vBgH9=vXGm2_a=RqxiC9Rav+0ygA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] gpio: pcf857x: Get rid of legacy platform data
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 1:46 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Platform data is a legacy interface to supply device properties
> to the driver. In this case we don't have in-kernel users for it.
> Moreover it uses plain GPIO numbers which is no-no for a new code.
>
> Just remove it for good.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied the entire series, thanks!

Bart
