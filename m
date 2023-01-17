Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4898666D93C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbjAQJEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbjAQJBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:01:45 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73906302AA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:00:18 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-4d59d518505so244367417b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zWrGRRnQR7P9BWZ46zuqWgfIj5Ef7uJjsTZLk6XnJnQ=;
        b=tY0+J6UTEEMiVAGR65U4uevw6sZKF9RDSfJewWtJtt1catXoc1rLkGwxOti6Qyd15b
         bQF1FaoYSWE1o3zDGjAUSneyffWVBfYA+XQE4Ra0kzRuMuyNwQwtRlgUXJHqvmyvvq9L
         RIs2y8JrOWWPo16zRwwlQ1lqEbbS+4miEqSKXA0IC099LMbUWgjbAVxFhTZB1oWKmG/m
         iEX0xn63WRu7tCfItKyIAUN0CNh596fRUWRDcgx0wk596RAwWjqQO750Bpm74smIYwWU
         dvLvHvdp/CaoPVYha+h5yScoxMIPaN+8OTaon7Peg5Gbuh2tUzwl7ROs6UNi4KBMayNp
         3VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWrGRRnQR7P9BWZ46zuqWgfIj5Ef7uJjsTZLk6XnJnQ=;
        b=AtNvHQbPyIM2u7lEpSo4IjlGiomXUBeb19R7ccRxXa8ieWdZ8+EZShlhUsJhs6ZKjv
         TGWxTdburwaZuxX1kvROnDlYre9zBI3iMjBgzn+x9DaxUhip2SQViQXXUB4VuqZqkNR3
         s2ssxe0w8nF+ZZcUkgeDAQPrWoHoDlXJInrQdOBpWDkV+n6m6yS4cRvgiYv5NJ5eZhZy
         VKx3nacU8PR9f8WAlWC0+/4bAsbRRvJN6PlkIM19M7VguUP9HFKSmRTX6/QYxivCEiLo
         cr/0cPozpo9bWST7krh55K+65b1EKXuDQU1jeMAl5c2Z8VwKXjd8RYMpIRbuVIcvE2Q5
         SyNQ==
X-Gm-Message-State: AFqh2kq25+Mx8haACwep70bWWBa0qZHSUSVVmakzWfS3JW8A29fRGybX
        zPuMPcW6NJ6pCG91YpRA7Yq3p2Ar/MrvUl81NjGLGWdnA52pwA==
X-Google-Smtp-Source: AMrXdXsX+lunu2PMfTZooXWKP5EL/xr/pFaQ3Qz2R1n+3dVJqALyQmHmC7MvW+oCmJUFG0sc9Msp1vUTRlmSUNMYOpE=
X-Received: by 2002:a0d:f282:0:b0:4ed:c96d:1b89 with SMTP id
 b124-20020a0df282000000b004edc96d1b89mr361994ywf.130.1673946017721; Tue, 17
 Jan 2023 01:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20230116124704.30470-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230116124704.30470-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Jan 2023 10:00:06 +0100
Message-ID: <CACRpkdaEJV59myaH44aJMZrLUe5xEw98Q=jVnVbEUgMT6xMsgw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] gpio: pcf857x: Get rid of legacy platform data
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
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

On Mon, Jan 16, 2023 at 1:46 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Platform data is a legacy interface to supply device properties
> to the driver. In this case we don't have in-kernel users for it.
> Moreover it uses plain GPIO numbers which is no-no for a new code.
>
> Just remove it for good.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
