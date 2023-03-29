Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6926CEEEA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjC2QMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjC2QMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:12:33 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D25961AB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:12:14 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id dg15so2132606vsb.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680106332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3hznV3F+Z/Oyhu924h7j62VKcfyOxZY+2JiLJNTYKE=;
        b=vlexXMgtpAYNIBPSFDHJdgzpmElgNH7qxEeVWlpSgML7bkvS8X1EgyYnvrBvBXyWhu
         xHfeXoSnUvfBvdBZtQzchG/okzUv3Oed4zXjR/E9pZkSqJmMdD/Zm67KW4PcFBncA/CB
         P5q7aofrAme4NX/vGxgIajfjNi0QxzVNZ4rAcN+25zNEPa85D8YqzJujdvyVB/NQWumW
         kiWUX56fRZYjXtzY7xwjRsJsmDUbTDzmpsigvSZBAQx8IMbCBr+SnRtbbrb80ymW5EKO
         pPk/b0bPqfBdNaL9+5Gst3WNHMf3WOxhqmxBUoRYIe5U9mYDhQqrCFK4rcXlKbUPDw7L
         37CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680106332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3hznV3F+Z/Oyhu924h7j62VKcfyOxZY+2JiLJNTYKE=;
        b=8LWmFvSMNDA6w/SyucNUlggjL6/wsHu+7NO3QpKYsn8Qt2sbH51nv/z0RYdmb9fHy1
         AnWBV6LBiVTCvN9oWgKufwz57xgm5a7MSIZeKlh0zL1qHqdOe3UF5h9PIuSNxtlXG7nl
         U4Qae9mMFaicareyPjQ8NQ/L7JmzV7/f3kB6BdvwpimTlfVlxc3gjF9/6lTcNc7aVCaj
         rB6IjliVMMGlbGPOcvnwdbmUOENto2n2iep+3Lpud4kvyWLKzgYQi4ZF4jOnTtR8tP5i
         URmYl9ZJ35nOnKga42Y1y2k6l1dIQKdUiU1dKfZOCo6gxwwQYfSZDcTGQKlNHU2KhTwu
         vpmg==
X-Gm-Message-State: AAQBX9drtXbxXEs/ZHg9uBxD37+swUUhBHJNp3RlDP5zfArN7OK+OzYc
        0jTuCgIsPma3akj26goZ1qupMmWb5eZSSiKjOy/Z+A==
X-Google-Smtp-Source: AKy350ZuxCPl4qrAw7EqVAwABL+9VqG4J+iSLum8tav51bRG0OaYNbDlJBN4wNa33KqZTFj+eoMrbrht6ZubJgjfkVo=
X-Received: by 2002:a67:d88c:0:b0:426:7730:1e6e with SMTP id
 f12-20020a67d88c000000b0042677301e6emr10530335vsj.0.1680106332468; Wed, 29
 Mar 2023 09:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230321135412.73240-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230321135412.73240-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 29 Mar 2023 18:12:01 +0200
Message-ID: <CAMRc=MeEs+FJeUoG89Uce3XnP-Z90f+9oowgB5Xi1NVF7NiRSA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] gpiolib: Replace open coded krealloc()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
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

On Tue, Mar 21, 2023 at 2:53=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> gpiod_get_array() does a new allocation in some cases, followed
> by copying previously allocated placeholder for the descriptors.
>
> Replace that with krealloc(__GFP_ZERO), since it was kzalloc()
> originally.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Series applied, thanks!

Bart
