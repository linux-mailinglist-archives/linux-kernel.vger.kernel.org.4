Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01488687FE1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjBBOYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjBBOYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:24:00 -0500
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F68D885FF;
        Thu,  2 Feb 2023 06:23:59 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id z11so2185409ede.1;
        Thu, 02 Feb 2023 06:23:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RzEIJmt2DZ7V5qJE+Ct+m6zMS1blZQex0DpQjtUY6tE=;
        b=kHT19yynvJoTyswOGj1ClIte6YLQdgVEXw0d/+jrMElkpLckJL0HA+q2ATwQhFZThi
         qdhVBtp7bqFYb/tWnMj9B4f3LUSUlERi//vPUt0LLtuZBf3VtZF4qDkEGtKWDdUnfDLu
         5WmBoS1lKqjyw1RL9Q3RV7QeTB/4n5TBvYuhLoNNDt/9pPwUsamcpM+rskoz9Wd+vyVi
         vAfwkn6J0SesQkfR4Co3oM2X5YdIWsnxUYMrZEXk/LeV8P/v3362SZfg79hhdrW6NQJr
         7nq5PkpoAl4h4NEoYFrPNuWAt6FdtY7AwdnwWF1nHUg3KEsYQp/JJ5xommbLGIPop5+P
         zEhA==
X-Gm-Message-State: AO0yUKXRpqVlEfIExyeYiF79SAR2Sy0O9HIzdkqrbtt8oJFu7oxLe85I
        FOWpcWq2lY5bY1e4jXyyzHOYtODUsQ9/ODUNQSU=
X-Google-Smtp-Source: AK7set8ebHDg8XvEy7+8ZHTBcpmxLGohKddJp0/3iZVIQv4XJV8+kSxvKXw1Jr65wJDfOQxtB+ZScs4ARnPJG5ZVK1s=
X-Received: by 2002:aa7:d752:0:b0:4a2:58f5:ddef with SMTP id
 a18-20020aa7d752000000b004a258f5ddefmr2004478eds.0.1675347837563; Thu, 02 Feb
 2023 06:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20230202141545.2295679-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230202141545.2295679-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Feb 2023 15:23:46 +0100
Message-ID: <CAJZ5v0gMpORi=kB4-PFswmhY2HJggJO+Qh2SMjCuHyn3z+zmTw@mail.gmail.com>
Subject: Re: [PATCH] drivers: base: power: fix memory leak with using debugfs_lookup()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 3:15 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  To make things simpler, just
> call debugfs_lookup_and_remove() instead which handles all of the logic
> at
> once.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/power/domain.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 967bcf9d415e..6097644ebdc5 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -220,13 +220,10 @@ static void genpd_debug_add(struct generic_pm_domain *genpd);
>
>  static void genpd_debug_remove(struct generic_pm_domain *genpd)
>  {
> -       struct dentry *d;
> -
>         if (!genpd_debugfs_dir)
>                 return;
>
> -       d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
> -       debugfs_remove(d);
> +       debugfs_lookup_and_remove(genpd->name, genpd_debugfs_dir);
>  }
>
>  static void genpd_update_accounting(struct generic_pm_domain *genpd)
> --

Does this depend on anything in your tree, or can I apply it?
