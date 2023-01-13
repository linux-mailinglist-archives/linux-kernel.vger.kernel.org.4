Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F49E66A3CD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjAMUBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjAMUBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:01:33 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5DD83E0C;
        Fri, 13 Jan 2023 12:01:30 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id az20so35647579ejc.1;
        Fri, 13 Jan 2023 12:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8h4FM5Yah9+1s69S3Tpy1g06YL7NXwd6Be7KRZZVjo=;
        b=5DDhlubkQcS23SojcpHiMPICLJY2tgOi6kTZK+wZaBJn2u4ciz7R0vynuAiJDy4/4I
         K5aywq5d4uRTO/ruOCyY01yW0zybNDwsEYM+GnrgT2QTQXUYYi3BOPa7LLfPpn0UJwZZ
         VUXgVES30jcfo/UqRZSHlHYENhGq1SiXT9zr+6hjrXwnie7haz3lJkah8kmArEnD8dcB
         YjtAVZs5pZSuQH0bW9UGodW82Mlh2XoFWMlU406AONTzAZQ7IReXJKkYGOWU22PG1acl
         20yIblV6jvkCGPsawqmUbwj3GDEfGsSKS3AjC5mJicmKIWaeWLtz8FPNaWyRX30xzZK8
         YbxA==
X-Gm-Message-State: AFqh2kouWzq7d4LvfcjCnCxPqnfo+GUbrXqP2a9z+VotQnXVRfeonN1Z
        NX9nwB9V+5WYNzqHIU7W7lQJf4zvSR2gyLm0OG2fpVH7
X-Google-Smtp-Source: AMrXdXvtzfulXjief5eu2O7psrMpxIy6ySvJ6xob6pTI92g8+/l7uWRz1A+g49VM2SXsHORTmy3FqTplRwkyqVowev4=
X-Received: by 2002:a17:907:8d0e:b0:7b2:7b45:2cd2 with SMTP id
 tc14-20020a1709078d0e00b007b27b452cd2mr7286659ejc.615.1673640089136; Fri, 13
 Jan 2023 12:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20221215181848.129326-1-helgaas@kernel.org>
In-Reply-To: <20221215181848.129326-1-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Jan 2023 21:01:17 +0100
Message-ID: <CAJZ5v0jHYQHKsg=5OLCUuv=x2F0YN1D_VF984VKDKa7t-1rHJg@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Simplify __rpm_get_callback()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 7:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Simplify __rpm_get_callback() slightly by returning as soon as the return
> value is known.  No functional change intended.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/base/power/runtime.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 50e726b6c2cf..7171ed0668f3 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -20,8 +20,7 @@ typedef int (*pm_callback_t)(struct device *);
>
>  static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
>  {
> -       pm_callback_t cb;
> -       const struct dev_pm_ops *ops;
> +       const struct dev_pm_ops *ops = NULL;
>
>         if (dev->pm_domain)
>                 ops = &dev->pm_domain->ops;
> @@ -31,18 +30,14 @@ static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
>                 ops = dev->class->pm;
>         else if (dev->bus && dev->bus->pm)
>                 ops = dev->bus->pm;
> -       else
> -               ops = NULL;
>
>         if (ops)
> -               cb = *(pm_callback_t *)((void *)ops + cb_offset);
> -       else
> -               cb = NULL;
> +               return *(pm_callback_t *)((void *)ops + cb_offset);
>
> -       if (!cb && dev->driver && dev->driver->pm)
> -               cb = *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
> +       if (dev->driver && dev->driver->pm)
> +               return *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
>
> -       return cb;
> +       return NULL;
>  }
>
>  #define RPM_GET_CALLBACK(dev, callback) \
> --

Applied as 6.3 material, thanks!
