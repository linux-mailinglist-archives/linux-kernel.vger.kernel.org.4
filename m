Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498E469117A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjBITmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBITma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:42:30 -0500
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FBD1B547;
        Thu,  9 Feb 2023 11:42:29 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id m2so9654926ejb.8;
        Thu, 09 Feb 2023 11:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIp4RCzsuu35MBgWRTOTjpC9otkcQ5vDTd9A2EAVu3k=;
        b=YF3u5kT+yNPiebG7pUoqtB/FskZHuK+UbhVDR/s27cnDP2bcBY+UZe6HwuQ0s8OsQ8
         m3AkCvI3mciNLlmQ86PSe6NF9+ik78uJMsNxf60dl1d6kRrVZAoyyFTsyb4DQnSlMZsh
         hujgZjyllWkBAwE7iBKC3OuDR95IfahgFloxmATqRURapiZIAUNhzh4EaDIG/ilcxo1g
         BrpfYVmAqRAvV3UNzEZi/DCMkfA3TsQxYxDzLuCtOq+oe7bw9c6dfpFLzjHF7Q3aj/5U
         qwuP3RRLClbzDpFrhbvT2NV5nIZAvZWkofQ2GUJmtoDyjWKGn8zvuaR8JvjIi/wVmnvw
         vy6A==
X-Gm-Message-State: AO0yUKWkBCzJ9viM0yjBWDchoHzsrBAU/f+U/BUZ+ac53DtU6+rNaq2u
        dlQPuMbCe+HFmJJyvUu1qsMmWoDZaPWKZ8LCNKU=
X-Google-Smtp-Source: AK7set/myRyfqM930pQEapD3coaAXFkNN8bumi2nngi2vSDno8HhTBlHrWFKVLkepofAUR+80g7XcLt3CtNVOS37sLQ=
X-Received: by 2002:a17:906:ce2e:b0:87f:575a:9b67 with SMTP id
 sd14-20020a170906ce2e00b0087f575a9b67mr2949049ejb.274.1675971748184; Thu, 09
 Feb 2023 11:42:28 -0800 (PST)
MIME-Version: 1.0
References: <202301171040260804580@zte.com.cn>
In-Reply-To: <202301171040260804580@zte.com.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Feb 2023 20:42:16 +0100
Message-ID: <CAJZ5v0j2R0BW+Z9zZSW__7SxSDMuCikk5DUnDfp+VvOQdhjCuw@mail.gmail.com>
Subject: Re: [PATCH] thermal: Convert to use sysfs_emit_at() API
To:     ye.xingchen@zte.com.cn
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 3:40 AM <ye.xingchen@zte.com.cn> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/thermal/thermal_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d9a3d9566d73..5ffc7006cce4 100644
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

Applied as 6.3 material, thanks!
