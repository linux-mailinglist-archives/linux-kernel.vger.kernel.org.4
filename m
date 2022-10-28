Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0C9611991
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiJ1Rp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJ1RpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:45:20 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F07150FAC;
        Fri, 28 Oct 2022 10:45:19 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id o8so4536445qvw.5;
        Fri, 28 Oct 2022 10:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZQHAqFn7xHc+L6KaGyhnBY2IDdvQwbbysAINIV2Tus=;
        b=B/LBiLbbUJqVRBoeAS0dCssIbAb1vT7sgkabMaWw7Mjab0GDI9toP4AlmkvvP7eQ44
         Ex0Y72VNBcvvWKWP1sLICcMGHVfPXssjWr228NuipEPa9STALc6PbhVAxm0QnBYei/vP
         9GkrHJRBbbi5JGg4sSA0YAvnHn1DgruwvOZepHFYngcq8UD6E9pQZ9hEz2ZIkHSiw364
         aFhQsDFIQudeUrgg8J+Joo0zLqjuabYxIdrwK2rabwuG4aCwkgPwPxYoR/9a6lECA8Yb
         Lx9VKiarnIYNINnBeQp+5AXJOhS3WlhqVc6GISEu2010bvdWRjszdgnQCIWas0gv6MBy
         T83A==
X-Gm-Message-State: ACrzQf0zePYJSQ/hzGmnboO35mJ35bhu0h7ycVdOB49LLMjCCa04J0tp
        2dWIK3CECpjNz0jqMcsx9d2pnD+3+0d3WoqTLUc=
X-Google-Smtp-Source: AMsMyM5kQXQVWqsSU6Ox3yyFrYUf5omerGPpDbFWWyIuatB8czIAQj/JR/xRrizGLcjX4nFjOGe5rFrWtyomOZrWpOk=
X-Received: by 2002:ad4:596b:0:b0:4b1:ee66:1cb8 with SMTP id
 eq11-20020ad4596b000000b004b1ee661cb8mr554004qvb.3.1666979118329; Fri, 28 Oct
 2022 10:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221027150525.753064657@goodmis.org> <20221027150926.394670044@goodmis.org>
In-Reply-To: <20221027150926.394670044@goodmis.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 19:45:07 +0200
Message-ID: <CAJZ5v0j_4xMY1fGY7ocbOzbJKdHDRUoY0OgyvQ=JCeNy_FOWDA@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 07/31] timers: PM: Use del_timer_shutdown()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 5:09 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> Instead of open coding making the timer look like it was not registered by
> setting the function pointer to NULL, call del_timer_shutdown() that does
> the same thing.
>
> Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Please add "wakeup:" to the subject after "PM:".

Apart from this

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/power/wakeup.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 7cc0c0cf8eaa..c690f6c0d670 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -202,12 +202,7 @@ void wakeup_source_remove(struct wakeup_source *ws)
>         raw_spin_unlock_irqrestore(&events_lock, flags);
>         synchronize_srcu(&wakeup_srcu);
>
> -       del_timer_sync(&ws->timer);
> -       /*
> -        * Clear timer.function to make wakeup_source_not_registered() treat
> -        * this wakeup source as not registered.
> -        */
> -       ws->timer.function = NULL;
> +       del_timer_shutdown(&ws->timer);
>  }
>  EXPORT_SYMBOL_GPL(wakeup_source_remove);
>
> --
> 2.35.1
