Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106585E7BCB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiIWN0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbiIWN0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:26:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F6B145CA6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 06:26:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r7so28582wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nX/6+loplHgFJT8kUh2DaZVIOlAUdD2TqBvnDdwr7aE=;
        b=zO9vbyWNjy0PacyXptByLwKcbKljVXwkFXuhRToBCZtT8PIHa0uRfUrvJKIgMWz7jA
         JcnS0OhBPVyZbHyeVsChSyOY1pqKb7s8IpQjeGcbDDIBEQIxD/C+53bPd97jui5U0vRB
         2PG+9bAHes7ggkOd+bD7DCmcSIQdbfeM9diNNwBoZX4FvgZP+lDY1invPHhfPirpR8tc
         ZD3BG3l3hpJz8CyFCkArfZI1tXSQ51rCZ92nlMbQzhiLsVZv40yG/BrdiBzWWEdv3+Yq
         cBRcVRvCZFKs+Up2KLID+QGfVKkgmqyb6CudO6UfP9OcfKq87UmznWMjFqg6JBhXPUSi
         FY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nX/6+loplHgFJT8kUh2DaZVIOlAUdD2TqBvnDdwr7aE=;
        b=hRE2knvQe15l0QU8QPrr8r7cCe2oQDm9HoxmWwe3maCIEpT3GhvTG63YnvqZiUbRUK
         O/JN+/LonNJZkwZRZu75ZojwJp2DJQQ0xiOYqPrfoUawETPpcWiwyimOAC9DGioOZYuO
         IocIX0DiGiJGu4QLyE4ytde5Q7GvcAYQSxH3J3GnY6G6N68qsXAknkarSLZbTJVL5Uel
         Sl55ByHJ/BBc0Q/G2MuBG3iCiLSt8YFxoOTLN8j5ilo5kRWQoJOEWhO5oDBzw+lpxIlR
         HbobxLQotQuLXun4omryfLkxKOCDR2sOEl9gdt33f21+vmSuo9Jh1XuavgN6VJi//9+L
         1s7Q==
X-Gm-Message-State: ACrzQf1MWvTnIkk3Oext5c7f/uXgsT5hRJWDz+EdJzK5fMOwvOWfUhz5
        8nKVk6YhG9eSooUgAfRCIIOJ7ZohnMfkusIB+K+cl+nGr1k=
X-Google-Smtp-Source: AMsMyM5Hwm5z8nHMJU3o3+1pxIo2s6caIcdyscKttqVtqZ86KBo6V8EuE8SL6NwE+bRv++IJJ3/RogZgqq8M8uuC8Ss=
X-Received: by 2002:a5d:6d8e:0:b0:22a:4831:e0e with SMTP id
 l14-20020a5d6d8e000000b0022a48310e0emr4991454wrs.442.1663939560054; Fri, 23
 Sep 2022 06:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <12079576.O9o76ZdvQC@kreacher>
In-Reply-To: <12079576.O9o76ZdvQC@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 23 Sep 2022 15:25:23 +0200
Message-ID: <CAPDyKFpVMnxCd9bMg=Wd7_TpSsNM6699NG0QLz8q=KWXk9G9hw@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Return -EINPROGRESS from rpm_resume() in the
 RPM_NOWAIT case
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Thu, 22 Sept 2022 at 20:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The prospective callers of rpm_resume() passing RPM_NOWAIT to it may
> be confused when it returns 0 without actually resuming the device
> which may happen if the device is suspending at the given time and it
> will only resume when the suspend in progress has completed.  To avoid
> that confusion, return -EINPROGRESS from rpm_resume() in that case.
>
> Since none of the current callers passing RPM_NOWAIT to rpm_resume()
> check its return value, this change has no functional impact.

Sounds like there are additional improvements that can be made around
this, right?

>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Looks good to me!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/runtime.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -792,10 +792,13 @@ static int rpm_resume(struct device *dev
>                 DEFINE_WAIT(wait);
>
>                 if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
> -                       if (dev->power.runtime_status == RPM_SUSPENDING)
> +                       if (dev->power.runtime_status == RPM_SUSPENDING) {
>                                 dev->power.deferred_resume = true;
> -                       else
> +                               if (rpmflags & RPM_NOWAIT)
> +                                       retval = -EINPROGRESS;
> +                       } else {
>                                 retval = -EINPROGRESS;
> +                       }
>                         goto out;
>                 }
>
>
>
>
