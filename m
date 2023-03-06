Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4F76AC323
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCFOY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjCFOYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:24:10 -0500
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC402CC49
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:23:18 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-536bf92b55cso185776657b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678112461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5dOWzz5ptG78/24FUVPQGUEThQ6H9diL9d3zhvn+uWM=;
        b=GNs48ysPbT/xZ24D4CfgtbT9TZY3jSruyqLWF5Fty1geh6KAQp8eXevTTOfRrxGoqR
         mEG1UOzDvKmcE14L7+UEteRTt1OAXVAa2ExjPl98v7DlH34ZFXtGgrBBr3FTBs5BCqgc
         xhBv7a5nSXvLqYxurnCASKlNTk/gB7RxuxujOSiRFBjGXExeWMO/WKqXI8LzgfDw7jvw
         z65e6Xw0SRWVGgPKZkBREn9O6AC5oGztdhduwBZVu3cH05+XgSWEINmgjl0FRJorH9sg
         eggxDRSs4XVFSNvXGkZBQbbXObC/ezaFPG4NiFrb8t6yZ6nZ7LCs3kSMVTOCqsf4WoqH
         3v5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678112461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5dOWzz5ptG78/24FUVPQGUEThQ6H9diL9d3zhvn+uWM=;
        b=vJZUe9IHt5qRlShm29et9CD9Q0Ta1QjMYObgusesenIvkfjZXyICk9VqtpfYaPXbNt
         Qot6wloMyRL6jFKHYd3ZfM6xLrhSt9BtPMPyV/mjcCGiPsiJIqvlBrNRcangTRU2HJG6
         qqTetf+okvznsfSdQHilzykHHvjOhNzivcI+RAibXH0bFIeC8dm/YehTRazhxGAmwW11
         35eVNO7h42XKQE0HvVigEk2PZRxelu7zFbsnYOg/YSP9gQynp4m8zB2HCKFDoq796x7X
         m1rd/Jjtg7i4BcwmySceU3uCPrc/SvA1HzFIROZvDsc62PvoQ8eX+N9I7kxxQe0qDNaA
         DhKw==
X-Gm-Message-State: AO0yUKVvCQ5QQJAyzVbhdfZaO/KEz0HeilziCHm1E3Q4mmP0mLYOP1YO
        ATwAAVbK6leiCLdl/5jjO852jnaCj0n/lMRgUn7HjqgBMmhOgtc3
X-Google-Smtp-Source: AK7set8qwioBxXmsDhA0H0TuRhZ8UNvJ2+iD4V1ti22S71JgWl+a31bTY+XLGka4hSvMtw5SMO+aM+npxDywx06BCDw=
X-Received: by 2002:a81:a12:0:b0:533:9d13:a067 with SMTP id
 18-20020a810a12000000b005339d13a067mr9186983ywk.3.1678112461287; Mon, 06 Mar
 2023 06:21:01 -0800 (PST)
MIME-Version: 1.0
References: <20230227205131.2104082-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20230227205131.2104082-1-dario.binacchi@amarulasolutions.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Mar 2023 15:20:50 +0100
Message-ID: <CACRpkdYLRyAzRuQDe2PZxOGQG_YwmE2YNnE8UDcj_c+Nt0HH5A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: use dynamic allocation of GPIO base
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Marek Vasut <marex@denx.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 9:51 PM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:

> Since commit 502df79b860563d7 ("gpiolib: Warn on drivers still using static
> gpiobase allocation"), one or more warnings are printed during boot on
> systems where static allocation of GPIO base is used:

Patch applied for fixes.

Yours,
Linus Walleij
