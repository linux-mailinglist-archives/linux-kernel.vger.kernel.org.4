Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC96600BA5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiJQJz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiJQJzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:55:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5D91901D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:55:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l22so15229663edj.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=30EAH+XQfO06e4I2eO6QbmQTxUyBtzeSnBO6VcUGovU=;
        b=A+vzie+Aa0ZqBEvoKjH3Iyik7guSk3Hj87QY6tGOEcp8B9mjzR84xnOzZ6pXK1uFbH
         RTI9LdnRwuSZma670NiYkz5gFoTzRsXYWUeEXlhu720/PJMQJ4k4fOajgt+qxITMCk9k
         1fGz1t443zQ+k/7aQjSePoy7ZSwOBEmh0YLzHK9rTTcwfuxMQbHaj9wHgk1kpPCo/g20
         4/0uctMBA976F8NyYCgPXXxweCYTulLkesiJ61KpeWAuIEokXJEmuHwrvkFOhLEOS0Nf
         HCoFqgN1nlmMDrsGPNCx1+uvj2Lbd0KY99hl3tFOat2AYYElRHMTNy8IyMXUHqtBhopq
         eM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30EAH+XQfO06e4I2eO6QbmQTxUyBtzeSnBO6VcUGovU=;
        b=dpHqnkyL999pFv/m313tA0vfZJ+5IV/RVCobDl5wtA0JEIVuQHp4i/oK52n+mYfSW4
         bDRBjrZsUlyGr4kOIopJBKIC5DhhP8zdJrYys21ffJIZj0ZSVEU9QOLkByx8zu8rk5PU
         iMQS7cUD0R1b3J23U8pSwSW6J0qLLazuZbPAOLmzpTDjO/0OsS+G9gtU1tfZdzRq4r5s
         oqcaGf6x3Lwp1boVGpwoOG0g2dfChnqK7N0YuB/nNBOSr4//xYTyWMVdulqQm0zJQCfv
         jygGNVe2wNLMzkGpekc7CwTEu8oGwitAkafmuXuzMa5847oqM1NhjUJOIyS1WqcpVRWo
         +apA==
X-Gm-Message-State: ACrzQf1no5XgGfhV+dify71lNwYlvoEZVilQbvh+fxnd1Tr4ng6jE+47
        r0DLbT3qmJ33ihb/vnksQZ32uzbCapcd8rHkcXt936Y+DDs=
X-Google-Smtp-Source: AMsMyM6CVAqN3RuuHWsXYQ9UticrO6eK4VOYvsDHtH6SLWpkaSBuVLEAPy6VWCl0UwB6PuOYrp/2Qb96Jj6NNhv8VYE=
X-Received: by 2002:a05:6402:2694:b0:45c:a035:34bc with SMTP id
 w20-20020a056402269400b0045ca03534bcmr9347063edd.158.1666000518591; Mon, 17
 Oct 2022 02:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221010125221.28275-1-andriy.shevchenko@linux.intel.com> <20221010125221.28275-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221010125221.28275-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Oct 2022 11:55:07 +0200
Message-ID: <CACRpkdan+xdcEdXz96Hm2dYWtQdEEqFGQazMYK1_9nonSCsnJw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] pinctrl: cy8c95x0: Implement ->gpio_request_enable()
 and ->gpio_set_direction()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 2:52 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Without ->gpio_request_enable() and ->gpio_set_direction()
> callbacks it's not possible to mux GPIO via standard GPIO
> interfaces (like `gpioget` or `gpioset` tools in user space).
>
> Implement those functions to fill the above mentioned gap.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied, it looked a bit scary but I realize you probably
have tested it on the hardware and made sure it works.

Yours,
Linus Walleij
