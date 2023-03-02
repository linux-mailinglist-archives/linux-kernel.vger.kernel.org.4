Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC06F6A834C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjCBNOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjCBNOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:14:22 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2915C65D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 05:14:20 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 82so3496344ybn.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 05:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SHzh9ShIvFPn7HOTZweKIS7UkzOK37tK0kiJ2StVBxM=;
        b=ITHk3whIdHxBMeAqSBE8tmlj6upx0KKDtuKgN2IBGIuzEHkJ/5Q0HJSYWO5aGCVQ5u
         Yq6u/We4h2rqRsQdfpiKl2asLB9fRkeXGxe6CXaEHwZdSr7IKx7gzn9l2/fJSUIc73ac
         XUS0BpcWyjdsY655F0rm9JhQSi5LVyNnM/1OoslZkaj3J8U54sj4EgvPego3FAaBpSEj
         fxuxoY61FXwSEvYJY0lpUfh+2KUkbbtwcgQpasJtSRdL39GgF3xkS6uKa1zYfgNHm58X
         VYoKmYGriQNA8rre/7U4dfUqV9MbCYoN0Ad2SOtZXBGjYS9EVyPWWo2QlRwZeUcQRiTV
         3G+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHzh9ShIvFPn7HOTZweKIS7UkzOK37tK0kiJ2StVBxM=;
        b=wd1bdWGialahXbP1uOIT7/OIxEEXhxh88G4aOY4t5s28nKaSDO9K9kIgd7AmgeoRoE
         XKvfyL/Soia9jod7PgvNxAgY/b4o6z3QSTubroQp8NeODvyIn93CSNLZPt9nfNQVA/2o
         47Paqy2RLK7/PKISTAL//JZeZAtD9LtMbGRfiasCYPqvQZ6gWYkdvtJgKjUM1muin4oc
         hv6+pauBVTdfx5vRLkyGuQRGmIkodUtgMxnjw5T2fNY6dekdcfZFJ4sDqvy9NCX3RXb2
         aRi/K1u9XenO11CP2AkHQItS91TB4K4Uhg6VTf7at1L98dLUlpKxbCSKMiSldY+doimj
         LL7A==
X-Gm-Message-State: AO0yUKUMK6aDICYFBU+elkaImWUsl8yyjtyVOtMkzaGPj4jr/0jqe4T+
        J5BevWXmOdxaBre1q56Uiq6QpOxriuhbH9TWLFlLmg==
X-Google-Smtp-Source: AK7set+3x8rLQ1MbjNMDiL/Ox/wbEo4Y0dUY8G9Ub4XYd+HNXsd5ek746c2XiQuEdBfud1Y8Fl0N4OcEZ/py3+z5oIk=
X-Received: by 2002:a25:fb0e:0:b0:ac9:cb97:bd0e with SMTP id
 j14-20020a25fb0e000000b00ac9cb97bd0emr1489579ybe.5.1677762859622; Thu, 02 Mar
 2023 05:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20230302014639.297514-1-saravanak@google.com>
In-Reply-To: <20230302014639.297514-1-saravanak@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Mar 2023 14:14:08 +0100
Message-ID: <CACRpkdacG4yxtZqwG5hKRY_8nY9qWeNPb-ZttMCnFH7ojZ3kCA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: Mark a fwnode as initialized when using
 CLK_OF_DECLARE() macro
To:     Saravana Kannan <saravanak@google.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 2:46 AM Saravana Kannan <saravanak@google.com> wrote:

> We already mark fwnodes as initialized when they are registered as clock
> providers. We do this so that fw_devlink can tell when a clock driver
> doesn't use the driver core framework to probe/initialize its device.
> This ensures fw_devlink doesn't block the consumers of such a clock
> provider indefinitely.
>
> However, some users of CLK_OF_DECLARE() macros don't use the same node
> that matches the macro as the node for the clock provider, but they
> initialize the entire node. To cover these cases, also mark the nodes
> that match the macros as initialized when the init callback function is
> called.
>
> An example of this is "stericsson,u8500-clks" that's handled using
> CLK_OF_DECLARE() and looks something like this:
>
> clocks {
>         compatible = "stericsson,u8500-clks";
>
>         prcmu_clk: prcmu-clock {
>                 #clock-cells = <1>;
>         };
>
>         prcc_pclk: prcc-periph-clock {
>                 #clock-cells = <2>;
>         };
>
>         prcc_kclk: prcc-kernel-clock {
>                 #clock-cells = <2>;
>         };
>
>         prcc_reset: prcc-reset-controller {
>                 #reset-cells = <2>;
>         };
>         ...
>         ...
> };
>
> This patch makes sure that "clocks" is marked as initialized so that
> fw_devlink knows that all nodes under it have been initialized.
>
> If the driver creates struct devices for some of the subnodes,
> fw_devlink is smart enough to know to wait for those devices to probe.
> So, no special handling is required for those cases.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Link: https://lore.kernel.org/lkml/CACRpkdamxDX6EBVjKX5=D3rkHp17f5pwGdBVhzFU90-0MHY6dQ@mail.gmail.com/
> Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_phandle()")
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Works like a charm on U8500!
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
