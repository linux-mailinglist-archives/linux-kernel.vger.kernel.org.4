Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3510642817
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiLEMIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiLEMIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:08:37 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AD86562
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:08:36 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t18so790787pfq.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 04:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YzA+kzcNiJY0uT8e5WY2pmN89WAQuiOE1BfYZ/zqVSE=;
        b=FzjLCssB4kY8nE93FwXgrZV4RgdGvrnzWT0IlnuXVLNN/qsp/5YghonYRgUZa/9Ygz
         sGDL4DEQ7X9kaKEwKHxnmEK+C2i5u6kjQtW/Mh/iVY8LiNyUVMp+M/Yavd9hRj8mSHbX
         LYRVNFsK/3VukjBEhSWzTZ5V7c/dFt0/XKLwBjrWfcyZrLW0Q+UpskeDVtLo85NfVbRX
         oCSR7BzX8h89jFnO0V61PO8nXY4KwVS0+RgZssV6+Ghj9R+FDh12R27T+bIAzmSHziZk
         9wKbIBOhyfqZ5DkuEV2vEBwNv9OExy3MyuOna8Uf3cVLabdOEdNC5PcONGS0yHWtY5cU
         ZPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzA+kzcNiJY0uT8e5WY2pmN89WAQuiOE1BfYZ/zqVSE=;
        b=rnseEtGGBMJIEHGA51o8ZAJHrUIlvrsFc+Do0ki6k9wMwV1UsM9VUwziuX3bixDZ39
         8matulzE52kg4+P040VQg/Efne6OuG9e1EwSeWJiOXJ6vN0z8z4JGihiTmc7EoE2wSRp
         epyDnx6b1segUFMcoz4TKggArzcvKWC+qB/4Ni0QybUDA/uheKKcO0UrPLsvx5QafhOf
         a/MuVgweJ+nfLXvclHdmnIsCbGyehNPHHstZ4eyK/mFN1EidJ+D9Zx7uUZ/+IJ1s+2R+
         7G2BiNmAQfWCY8gj2+2ofIzv1iHR8nbvlQ3iU5sZNjMwELWUxzbtKnf41sUgPgTa0cYN
         n4AQ==
X-Gm-Message-State: ANoB5pkE3WsmH2n+Bs2+8nuB1Sbqao/HXcA8MEzqN9ZUpDNwOwAVT0Qe
        sjpsm+3/KKOTLWooG8TCFI3w98VEGUKn3rOpoohRdg==
X-Google-Smtp-Source: AA0mqf7vN3fErWWmDTm/kGooXVcBnAxCtNzf37QKiSTJHuetaaYEBZ5rNkggiAHrgkwL0Gz3cMspUfOKedNR5BL4EbI=
X-Received: by 2002:a63:2154:0:b0:477:b650:494b with SMTP id
 s20-20020a632154000000b00477b650494bmr53261535pgm.434.1670242115671; Mon, 05
 Dec 2022 04:08:35 -0800 (PST)
MIME-Version: 1.0
References: <5627469.DvuYhMxLoT@kreacher> <4789678.31r3eYUQgx@kreacher>
In-Reply-To: <4789678.31r3eYUQgx@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 5 Dec 2022 13:07:59 +0100
Message-ID: <CAPDyKFqu9-=L9B-Vkzqom6akVpim0R2_DPj__3t3dp9Y_oUEEg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PM: runtime: Do not call __rpm_callback() from rpm_idle()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tushar Nimkar <quic_tnimkar@quicinc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 at 15:32, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Calling __rpm_callback() from rpm_idle() after adding device links
> support to the former is a clear mistake.
>
> Not only it causes rpm_idle() to carry out unnecessary actions, but it
> is also against the assumption regarding the stability of PM-runtime
> status accross __rpm_callback() invocations, because rpm_suspend() and
> rpm_resume() may run in parallel with __rpm_callback() when it is called
> by rpm_idle() and the device's PM-runtime status can be updated by any
> of them.

Urgh, that's a nasty bug you are fixing here. Is there perhaps some
links to some error reports that can make sense to include here?

>
> Fixes: 21d5c57b3726 ("PM / runtime: Use device links")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/runtime.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -484,7 +484,17 @@ static int rpm_idle(struct device *dev,
>
>         dev->power.idle_notification = true;
>
> -       retval = __rpm_callback(callback, dev);

Couldn't we just extend __rpm_callback() to take another in-parameter,
rather than open-coding the below?

Note that, __rpm_callback() already uses a "bool use_links" internal
variable, that indicates whether the device links should be used or
not.

> +       if (dev->power.irq_safe)
> +               spin_unlock(&dev->power.lock);
> +       else
> +               spin_unlock_irq(&dev->power.lock);
> +
> +       retval = callback(dev);
> +
> +       if (dev->power.irq_safe)
> +               spin_lock(&dev->power.lock);
> +       else
> +               spin_lock_irq(&dev->power.lock);
>
>         dev->power.idle_notification = false;
>         wake_up_all(&dev->power.wait_queue);
>
>
>

Kind regards
Uffe
