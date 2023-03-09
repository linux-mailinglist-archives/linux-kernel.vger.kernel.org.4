Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E5C6B262F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjCIOCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjCIOAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:00:24 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956CA5F6E1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:58:30 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-536bbef1c5eso36277407b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 05:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678370310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9FztTG0yEY1M7up9GTdt6AZAFT3eSix/P5t5wSb4M4Q=;
        b=yAH/1mbhCjrFmFWF6Ajt/KXo9D7ovq1fnbB7Z+inJdmHtUffl59r1xzmst6ICHNFZg
         i01B3Qi6MnbM9rpq5S7zRZqOGUGn2M+pX6zPcK87lzJ0QMhOkJxlNLUOiGI5ksen0EgX
         QA8Ltpbgnks1U7FfkUb9RZW3Pw043jWkUkg9hrgURiXf+wi4qA1t0EdPBZGMDr6H/F+v
         TT3Jaelr+Z0HPprgak1KyqyRwT1I+2wR8lbR5/7M26kgszUQ4Q6PuVHO3qfMPc4k1Kwz
         bB0horMRmWBi6gkNGH1sseNwjP9scQpr7q+QMoRgr/zPr5JXHbqw/j98A0ukGCCQa079
         VRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678370310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FztTG0yEY1M7up9GTdt6AZAFT3eSix/P5t5wSb4M4Q=;
        b=opNrtILZQqcGg6+OcZEC9yte8IsMDg6pOyc9SEZP6GgYpoBA031A44s89vqGF44Rve
         +9kGpuhZEodG24o8fOLMjcxJufcaWZs7CsP5/HPoYR1fBCC0ivBDZUOOLANkLDRClFSm
         S1RfjrYkiVNS+bhHsK677ZFjx4ayKmKp2Y4JEKl2NH9YwfIBGm3H9fg0pXBKVGcpvKm0
         cG33VRjZbEG9PP4XzboaD7waSAjgT8J+PV290yrViJY0MZzhNrtnJkETKbPYDvxdDCox
         6/81xnij6OHvN3xvOjf3k99nTpy9LZ8+29qBJTlRxZLUWPlet6DnDCLnUoSSsCuQGhCx
         cg4Q==
X-Gm-Message-State: AO0yUKX/39tg6PI4xH4UP9jxtx8IKPKIqnx4yXMpgkWJBYbR5uF9Xcep
        DMOjNqdrvs8c46PaqAo6n03a/zMWFaVYdZmm0ZN9MTnjJ4P6b6QeQ8g=
X-Google-Smtp-Source: AK7set9Lddr01I7FEPfmy28PrzTHgUL7aK4KyPL5RLNUWqq7nUyUumYXZQJ2gOopwUmMWUHGn85S3hP+MtQ1thjJ2dk=
X-Received: by 2002:a81:ae4b:0:b0:536:5557:33a8 with SMTP id
 g11-20020a81ae4b000000b00536555733a8mr14124567ywk.9.1678370309858; Thu, 09
 Mar 2023 05:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20230307182557.42215-1-andriy.shevchenko@linux.intel.com> <20230307182557.42215-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230307182557.42215-3-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Mar 2023 14:58:18 +0100
Message-ID: <CACRpkdb1fO3kBhyQbi0Gnw+SK3ejL3ACW=fJPNUitMXQfN3vvA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] gpiolib: Get rid of gpio_bus_match() forward declaration
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 7:25 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> There is nothing specific about gpio_bus_match(), so we may
> simply move it to the top of the file and get rid of forward
> declaration.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
