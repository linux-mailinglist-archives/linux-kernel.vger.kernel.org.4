Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C98F5B7A07
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiIMStM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiIMSs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:48:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C8179A54
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 11:29:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id go34so29540845ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 11:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5mHZ5ROhl2xtNeHNSULnEJ0gJ4kTfFmkLYuGrarU5rA=;
        b=i3HOGXCvTpvPOHn1H8Lzjo7VBm1nTBxu4nFJrI6Ry6CZW7KR/BTxrtwzlYJpTnL5Tt
         C6SXwUVjrF1JCQj0rytXR4POr0Le1lZ7cZFHKtbjGcMbC8/bgI+xvJDzaJXOf4Bzkn44
         d7DDMdwE3l0gG+82A+XDawz0oYY6ndayYtlzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5mHZ5ROhl2xtNeHNSULnEJ0gJ4kTfFmkLYuGrarU5rA=;
        b=uZPFEyWW/yIPVFbTsD3/4VU4wMKtF2zc1U+3t/VghWlANVqGTrtpaiy2GmB/qs06lH
         x3lexFWr9uBxcv3GITvxcjaR65tqfes9BNCXEIbUwIrh5Zl2vgQm1sk5VZ9Nk0n3Mmuh
         owbo0RanpIqqjgcUnj6bDashLO3hrszsUZ6VcCAc18jnWnKr8LHKWoneLdWagSPusvUw
         MCocyWLBKmf0sOBNkr14vZAUeRGiD+MmABFBa44i5qkJSE1iXso4uNynIPW4RSZzskTt
         0fypLKKPCL5WUMK6Y2SgD8xmcoLENvN/S3XMToZem70Q+TvsAVJmpz737vXOQfwHDgUa
         p9gA==
X-Gm-Message-State: ACgBeo32MkdbpVr0TLJTIB9s6kIK1mnaem4X/1Xz7sVcUblYU/9gCud4
        6yG4HJGHRUofxx2kbkN3pf3LJkd+8eTrR41d3jpYOw==
X-Google-Smtp-Source: AA6agR7n+op1y5u3TFdVTIQJkvJeuzLzHoCCgaKzSWbbkyYoWVT3NsxKtPq3sWIligkAmRpGbKU4iIX5dhoSko+uN1U=
X-Received: by 2002:a17:907:84a:b0:733:735:2b1a with SMTP id
 ww10-20020a170907084a00b0073307352b1amr22752861ejb.290.1663093743437; Tue, 13
 Sep 2022 11:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220913145549.2839948-1-jthies@google.com>
In-Reply-To: <20220913145549.2839948-1-jthies@google.com>
From:   Benson Leung <bleung@chromium.org>
Date:   Tue, 13 Sep 2022 11:28:51 -0700
Message-ID: <CANLzEksnE3tNLHd4N0B3msJpJ-MQCgRSTYqts8w1SOW8PRpwDg@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: cros_ec: Notify the PM of wake events
 during resume
To:     Jameson Thies <jthies@google.com>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        pmalani@chromium.org, groeck@chromium.org, tzungbi@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jameson,

On Tue, Sep 13, 2022 at 7:55 AM Jameson Thies <jthies@google.com> wrote:
>
> cros_ec_handle_event in the cros_ec driver can notify the PM of wake
> events. When a device is suspended, cros_ec_handle_event will not check
> MKBP events. Instead, received MKBP events are checked during resume by
> cros_ec_report_events_during_suspend. But
> cros_ec_report_events_during_suspend cannot notify the PM if received
> events are wake events, causing wake events to not be reported if
> received while the device is suspended.
>
> Update cros_ec_report_events_during_suspend to notify the PM of wake
> events during resume by calling pm_wakeup_event.
>
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>
> Changes since v1:
> - Updated wording in commit message from "Log" to "Notify PM of".
>
> Changes since v2:
> - Removed Reviewed-by tag and provided more context for the update in
>   the commit message.
> ---
>  drivers/platform/chrome/cros_ec.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index 8aace50d446d..110df0fd4b00 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -349,10 +349,16 @@ EXPORT_SYMBOL(cros_ec_suspend);
>
>  static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
>  {
> +       bool wake_event;
> +
>         while (ec_dev->mkbp_event_supported &&
> -              cros_ec_get_next_event(ec_dev, NULL, NULL) > 0)
> +              cros_ec_get_next_event(ec_dev, &wake_event, NULL) > 0) {
>                 blocking_notifier_call_chain(&ec_dev->event_notifier,
>                                              1, ec_dev);
> +
> +               if (wake_event && device_may_wakeup(ec_dev->dev))
> +                       pm_wakeup_event(ec_dev->dev, 0);
> +       }
>  }
>
>  /**
> --
> 2.37.2.789.g6183377224-goog
>


-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
