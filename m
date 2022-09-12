Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438385B62DB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiILVhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiILVhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:37:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE144BD32
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:37:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id lc7so23325262ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=R2eR+zL2wRHc9ncPta4J1bGSX7YZcFCg5pJmVeSKDAk=;
        b=ivNz0GcRtBBjVtRYxqIYlWxIhUEO5TPXYkDNBcBLYvYAsNY8+wDCappA395P46Z+e8
         Z/XcYiHevUhxjLnBOw8pALKfjz6k9HyW6mvFaLcBny17l2C3qyuhfkiFW8SgWSSO+tmp
         XvKXwXHiXRTwXg+DYGsjydVnS5MRkFYi4HNAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=R2eR+zL2wRHc9ncPta4J1bGSX7YZcFCg5pJmVeSKDAk=;
        b=f5NnbktbIzGt7FTRezcEaQzgpAO1JW0h2nskgMULt4Y74RFlEFCiqVqr513lTcy+hi
         tDaVpdoc3Rq8B3wUTqlAcDMu6c/JF5XLgnFuyCuABygAJkm6xvlvlGw/x2pautBeLasI
         Q2Verfe0CiKFa1nVyragl+XxC4y27qn1bDGEKM7AHYN8aU9CYOE4eceroqys7b357bUn
         NJFYkUktnEYWDZzZ8NPy+PqZgzUe4DPJhnj8hZNvdPXq8vsE7KM5qLwLh1Z7p6JFpqBB
         Hbf3PMfcDrs3/8+ZdACtcCwVxkzQ5iRdinPUSG/JAaVOn3AEl1D+MxT7sHe7H4Dm+IrL
         b4qw==
X-Gm-Message-State: ACgBeo0R2m7FKmKNU4jHEbJi0R/6EWN8nLcjArV+hwFBPsN4dyt0kPNe
        a/oxTxOkH7xaDLuFYtSqwRJOG+csm416PhKLRdSGGw==
X-Google-Smtp-Source: AA6agR7Jc96Ysk1hj97djcQcVnDrOPolRaN4o1Oti0xbAQg3oyFEQLmM6+USIjmjrEPxMn+KJ4TkyHRStISn+BHHdrw=
X-Received: by 2002:a17:907:3e12:b0:741:66c4:5658 with SMTP id
 hp18-20020a1709073e1200b0074166c45658mr19754280ejc.486.1663018668683; Mon, 12
 Sep 2022 14:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220912213334.2703872-1-jthies@google.com>
In-Reply-To: <20220912213334.2703872-1-jthies@google.com>
From:   Benson Leung <bleung@chromium.org>
Date:   Mon, 12 Sep 2022 14:37:36 -0700
Message-ID: <CANLzEksE+YVjPGG6Or0_7pE5D9o+DmmDTZ1KZap2QGKSexiJNA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec: Log wake events during resume
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

On Mon, Sep 12, 2022 at 2:34 PM Jameson Thies <jthies@google.com> wrote:
>
> Update cros_ec_report_events_during_suspend to log wake events during
> resume by calling pm_wakeup_event.
>

Minor nit, isn't it more accurate to say that this change "signals" or
"notifies" a wakeup event rather than just log? Log indicates some
print to a logging service, which may happen, but as a side effect of
the actual pm_wakeup_event call, which does something real on its own.

Thanks,
Benson

> Signed-off-by: Jameson Thies <jthies@google.com>
> Reviewed-by: Prashant Malani <pmalani@chromium.org>
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
>


-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
