Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99A3646F0E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiLHLxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLHLwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:52:45 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25FB81DBC;
        Thu,  8 Dec 2022 03:51:31 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id mn15so759088qvb.13;
        Thu, 08 Dec 2022 03:51:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/EBcLW8zYEQ4+t+S3wEcSxpFnIWriPs3pqX5SXYMw8=;
        b=2HFYh6ymMdtAfbR6lHQq28G2/W7yk0qqbILS2JWCkg6brLY6hOSeeil80ijSYMlPHG
         JezIAL5jHIV6lI1w097zEdHVz2gdmiVYq/Ag2xr0X/+ubUQ8t+VJ8Droksyl3vMZ9bmz
         D+WCfKdFO7fMLhiQ9RHgArlakeEX7d87p+ldu8X2K/9hbvF+aejoyvyEgoD4XnrO7hRo
         lFx2k2YS2kfLOFfsrK3H2u4aEr0qXCwn6bXEBO6KGobnBUhxS1gRgG1R3+Oxs1vpH5Wl
         vPdx3b2lZHGsyETnIBPDpgYXeThrif7xXHwLYvNBsduP7aQoYjge5tZbtl6OKWDFyqDW
         SufQ==
X-Gm-Message-State: ANoB5plRNjMD5fwvvoiZOpB+cAfcPqphoAm9G2Km3kxSaKlWVvkKtapP
        D9CHLLtGGdCSx5KwH/8tZh3+fKZ4Nf0W1ux+gJI=
X-Google-Smtp-Source: AA0mqf5h2CSXWVb/QRPpxwMdjYO3+RytgXcRavvYeTIJsi374NagoXdX4L8AJsyAIHDcElruy9foc2FKO0QcpKSnaVs=
X-Received: by 2002:a0c:ea49:0:b0:4c7:660f:1845 with SMTP id
 u9-20020a0cea49000000b004c7660f1845mr14762438qvp.73.1670500290885; Thu, 08
 Dec 2022 03:51:30 -0800 (PST)
MIME-Version: 1.0
References: <202212081706290141979@zte.com.cn>
In-Reply-To: <202212081706290141979@zte.com.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Dec 2022 12:51:20 +0100
Message-ID: <CAJZ5v0juOSoQt_9XLM6HmuVOR4A=rkJtucXCgCgMZAU9GhFeow@mail.gmail.com>
Subject: Re: [PATCH] thermal: Convert to use sysfs_emit_at() API
To:     ye.xingchen@zte.com.cn
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Dec 8, 2022 at 10:06 AM <ye.xingchen@zte.com.cn> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Again, please resend this after 6.2-rc1 is out, thanks!

> ---
>  drivers/thermal/thermal_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index f17ab2316dbd..91d40ce62c92 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -229,10 +229,9 @@ int thermal_build_list_of_policies(char *buf)
>         mutex_lock(&thermal_governor_lock);
>
>         list_for_each_entry(pos, &thermal_governor_list, governor_list) {
> -               count += scnprintf(buf + count, PAGE_SIZE - count, "%s ",
> -                                  pos->name);
> +               count += sysfs_emit_at(buf, count, "%s ", pos->name);
>         }
> -       count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
> +       count += sysfs_emit_at(buf, count, "\n");
>
>         mutex_unlock(&thermal_governor_lock);
>
> --
> 2.25.1
