Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822D161FF46
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbiKGUNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiKGUNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:13:39 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237E82AE21
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:13:38 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b21so12077694plc.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k8EUFEtQtPp5wi61CP1QJz9xHMjgAa1yVc6pY8V0J90=;
        b=BQT4hLiiNPmn6f3BxnJlJ/dUG2Fuu5F5NOayg/wozaqhclutSwVozNcp9IQrJs7BEx
         uEKtHMnDF+Jvvw0aNmbfiOAKip8v4v3Ki/il6DKKJBWWVupNMwMLLj7FTGSXgMID+CQU
         0nNW64Psay5UopdLn9JdB6JuAfYG7nA06iOM8Q0tXxsAWQHZdEmqfBdrXiRlFbZPlncy
         zF4Hj3YsFVaR2yLgvV7+YKbg2fh/XsjMND4/jeYp9PFUpcHRBJ6C2HkqvvGFpNn60vq5
         bysrQsjcInRD0BtnWMJZz8IS9euybhfFdmu58azZTqD5g99mvRZ4I7dke3jyIrxGGpNj
         jfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8EUFEtQtPp5wi61CP1QJz9xHMjgAa1yVc6pY8V0J90=;
        b=hBXPOXQHSt4vDNt49wxN5kjYoAAmCFyU0DT3BiFaqGxAf2tJxZWX8bRxLwTJVqZwGh
         oQ25oWlebCWl5UYeQF9KN+xZw/g4Sd8p2Z2K59o6ELgfM29HTjUWl3g1HQqy+Hj6S6xw
         Zy7w4kABM0YxRzjYCssi7y4RrZ5lU4iYInIyo+QR9ig33Y2BxS4SGeL8rYRtPk9EsOze
         B9Tzixk+ZP69vKmdufRC/ZjGKoahvVmaD/p2rqCxOgX8+sgcXe/zWa6wCTQCNy9bQ6vB
         1Ta0yFo3RHPLOE1S6cHFnAwaRM622A0Ngp0sy4nFEavDZa15Q0j8zlABnshZzHltWAbn
         ZEMA==
X-Gm-Message-State: ACrzQf30tKui9lKVLHAMzs5FGkxWIP87JwjPVVRNeMRUyBMqataJ5pfo
        BX4tUAkXya1Ghym6/EjCJ+EMpLvbqiWyLE3CYKZS8g==
X-Google-Smtp-Source: AMsMyM4r39aPv3/RDP5gqVTAMK+bW31ALLLoSbUFaPKhUJbyNRGkpcf+/D4oBnSI7HwXYUhn2sQD/+znIf0BB9H11AE=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr71862280pjb.164.1667852017652; Mon, 07
 Nov 2022 12:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20221028073740.7259-1-yann.gautier@foss.st.com>
In-Reply-To: <20221028073740.7259-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Nov 2022 21:13:00 +0100
Message-ID: <CAPDyKFptJkHGaz9zc2G65tyS=2weH7ueV1d_CAszKfAgsqCkAw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: properly select voltage range without power cycle
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, christophe.kerello@foss.st.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 at 09:38, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> In mmc_select_voltage(), if there is no full power cycle, the voltage
> range selected at the end of the function will be on a single range
> (e.g. 3.3V/3.4V). To keep a range around the selected voltage (3.2V/3.4V),
> the mask shift should be reduced by 1.
>
> This issue was triggered by using a specific SD-card (Verbatim Premium
> 16GB UHS-1) on an STM32MP157C-DK2 board. This board cannot do UHS modes
> and there is no power cycle. And the card was failing to switch to
> high-speed mode. When adding the range 3.2V/3.3V for this card with the
> proposed shift change, the card can switch to high-speed mode.
>
> Fixes: ce69d37b7d8f ("mmc: core: Prevent violation of specs while initializing cards")
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 95fa8fb1d45f..c5de202f530a 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1134,7 +1134,13 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
>                 mmc_power_cycle(host, ocr);
>         } else {
>                 bit = fls(ocr) - 1;
> -               ocr &= 3 << bit;
> +               /*
> +                * The bit variable represents the highest voltage bit set in
> +                * the OCR register.
> +                * To keep a range of 2 values (e.g. 3.2V/3.3V and 3.3V/3.4V),
> +                * we must shift the mask '3' with (bit - 1).
> +                */
> +               ocr &= 3 << (bit - 1);
>                 if (bit != host->ios.vdd)
>                         dev_warn(mmc_dev(host), "exceeding card's volts\n");
>         }
> --
> 2.25.1
>
