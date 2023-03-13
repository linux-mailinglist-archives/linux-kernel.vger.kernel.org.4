Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C846B7786
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCMMba convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 08:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMMb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:31:28 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A38410AC;
        Mon, 13 Mar 2023 05:31:27 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id ek18so16892543edb.6;
        Mon, 13 Mar 2023 05:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678710685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0bbMhFhOI8Ji1xMopDWeP948kqcB28dUKXFSOResUE=;
        b=030Fcm68NqEEK6JIuEaSNEFaQ+MOoPl4sh7E834v8bckoWGLPo3zokbGjFriUyl1b8
         fo9P5ukPf/OUpNWaWVVRi1nFQAduAzoWk12ZlBalDzpuqW/twohNLRRvS7MLOYhKoHwS
         YX2LUNLy5CUoBITSBlUC9v5BbBVxn9mWmtUvhCqdaG0TF44VM0eqeEh3BxfWNxWA54Tu
         3+AMdTB7CWf7E6U9v3ucCvnJHUpFe9p6aTQgfLlhHs68bku9+H3rb1vUT1gjH9wds5vR
         ra+W+8Hn9wSLTk7bd3JStC6a0lPECTku08aknOrAFpV7EXnYjpJC+m6dXfnjhvFZWynH
         TRgw==
X-Gm-Message-State: AO0yUKXWOnTy8/kD5u5j1HlioHL65jFwbdZ3d1zKPZ5xsQ6hOp6HyQTq
        GUyiTVNHrjhBLdZlE5MbnrkKPfQlhrXqlLQAzug=
X-Google-Smtp-Source: AK7set9SLWkK9hDI+ESO3A0t77NH8crzKEpXMjynKfG40lU2l7vys3hVzssPtA0R4R5F4vLHco0GlWLCYPtDiOOwAEw=
X-Received: by 2002:a17:906:388d:b0:877:e539:810b with SMTP id
 q13-20020a170906388d00b00877e539810bmr17787514ejd.2.1678710685450; Mon, 13
 Mar 2023 05:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230312204150.1353517-1-robdclark@gmail.com> <20230312204150.1353517-11-robdclark@gmail.com>
In-Reply-To: <20230312204150.1353517-11-robdclark@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Mar 2023 13:31:11 +0100
Message-ID: <CAJZ5v0gEmFj5Yrm0OZx5XhvGStHXx1OsPXGQqmbFQpeYSADkwA@mail.gmail.com>
Subject: Re: [PATCH 10/13] PM / QoS: Teach lockdep about dev_pm_qos_mtx
 locking order
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 9:42 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Annotate dev_pm_qos_mtx to teach lockdep to scream about allocations
> that could trigger reclaim under dev_pm_qos_mtx.

So why is this needed?

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/base/power/qos.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index 9cba334b3729..d4addda3944a 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -1012,3 +1012,14 @@ void dev_pm_qos_hide_latency_tolerance(struct device *dev)
>         pm_runtime_put(dev);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_qos_hide_latency_tolerance);
> +
> +static int __init dev_pm_qos_init(void)
> +{
> +       /* Teach lockdep about lock ordering wrt. shrinker: */
> +       fs_reclaim_acquire(GFP_KERNEL);
> +       might_lock(&dev_pm_qos_mtx);
> +       fs_reclaim_release(GFP_KERNEL);
> +
> +       return 0;
> +}
> +early_initcall(dev_pm_qos_init);
> --
> 2.39.2
>
