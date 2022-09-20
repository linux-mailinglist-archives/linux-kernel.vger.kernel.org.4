Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0315BE1D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiITJXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiITJXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:23:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E28A65542
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:23:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id q21so2879671edc.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FXiNfepxJrvOUrfb1YxH7Pel/Cje0OE10jz6+lex/TM=;
        b=guE99RcAaUGTvO8x8ElP6g9s7Z4r1vPcqM3m9mzNvpYCswGJ0GOVPIGySRH6M+ZTHf
         J11l234AuV3N2DMry+BktRG7IY9LahLQLcwvlTYFPKlQWQTu3GfWZ6xKieOhHxHxwvsD
         I+O++Ua7JP7bzDhudwUai2UxAE5gFamipOgxNBT1x50Q5l3M5ynekMSSLEVt1vgcmLCg
         WCMFiqwzWji4qxT5bMs+C74cLxVaGg1uJyr3UxLAsSRjtShC8H0wjKydHVsd1bglNZCO
         fWTNWiZi4ihlwHzfDLHQjwzEwGENUkdXIjw4O1e9eT72kfXH8w/sZb5YmFv8ayguLafq
         Jfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FXiNfepxJrvOUrfb1YxH7Pel/Cje0OE10jz6+lex/TM=;
        b=aEBa6NmaY+3omEOdEd2beEzr1YIdZ1aLoXaZHz6PkB0WaGsHDq7fCjtIu4iITuD6yg
         mjKHvPqxSqCZi2tbieGeOt6w4HuYEq9KVeFcftxuZ9vjgrnFC7abAxj7RvQeKAsAtfXB
         VJ+WSSuAW/s6yU1GBESZhMHe2NZrUhW9QYq4WytDHNruFjrRq2pKcNE6je6Feqt+b37X
         /Jcv/7uYP4tyj5YdoftGnxP5rDoBZNEShhPW381A60g98IrZBUtgOFfssX0mb8npUlTV
         0StqhXLPW6GiKcBnjdy6OGt8oGE31QsuVjf2LeUJqDNlr/k4khE9fxuv1FjRECETvWhf
         SBzg==
X-Gm-Message-State: ACrzQf2HEYgHVeeb5+cyHvbT6O1xHSMdN9arEj4iofpTl0AMbJEIAEVt
        1YiLVq1MypRX7qMDP7q+sW1GRSieLl/3LwIEuAfewQ==
X-Google-Smtp-Source: AMsMyM7j+YU6EJ75vs2WPTdt6CnZ0wUw5/FkNXLfgZLo0D7gocwjseu3VV64XBEDlUJ2EeMO0jGpqnTAdEMaM1AhpJk=
X-Received: by 2002:aa7:c050:0:b0:453:4427:a947 with SMTP id
 k16-20020aa7c050000000b004534427a947mr18178530edo.172.1663665781787; Tue, 20
 Sep 2022 02:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220916205450.86278-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220916205450.86278-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Sep 2022 11:22:50 +0200
Message-ID: <CACRpkdaGR5hhmrPEaQ_3vNGiCefnGg2efHaGMg9smAdTfZV7uA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] pinctrl: cy8c95x0: Lock register accesses in cy8c95x0_set_mux()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Sep 16, 2022 at 10:54 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> It seems that cy8c95x0_set_mux() missed serialization of IO access.
> And its implementation looks half-baked. Add locking to the function.
>
> Fixes: e6cbbe42944d ("pinctrl: Add Cypress cy8c95x0 support")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

All three patches are straight-forward and elegant so I just applied
them.

Yours,
Linus Walleij
