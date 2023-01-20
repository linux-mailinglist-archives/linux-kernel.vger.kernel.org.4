Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB866675AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjATRBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjATRBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:01:03 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49503D907;
        Fri, 20 Jan 2023 09:01:02 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id g11so2000589eda.12;
        Fri, 20 Jan 2023 09:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZ5dOpfh8ZOhZvWVPguQPpxA+30UUOjKPT6F8QZ3W7I=;
        b=3tSkCgclqDyOsGskszuPh3gFHCyl+HEzm7gT44CY1rbwZI6A/YPx+akUNbXov04ecs
         yd0zS5xaDN+77xteV4O2kejqjKPk44LDbaO2RQcVaeMM1ihkZVl5VfWuJVth6fvYim9h
         jOkVk6ehu4MXEs0KEl4IR9yfAedyppLW7MlFj/HrjDGyCijpDhkzxSHKnYH80nwYKuaP
         mqYH9bgk3Z7m9GshttyKa6Aj9JXOcz82bTWHMGmQ+RXWYlbvgea4Fq+cbTL/NLoP4eu6
         eQdRlSYWJPbuDUvZsIetcuosuPraYlknWTkWAw34OMiOd0XXI6bhwgYo2+upKHD6KhE4
         9EZw==
X-Gm-Message-State: AFqh2ko+J2aM39S+BKrNb6kcwdiYr8sDyG/UriR2Yn93CQlcSr1STniR
        uT+RKa3q5eGphqu/gbZuvt6TRhqpaSStaCNrol4=
X-Google-Smtp-Source: AMrXdXvCmzlJZRcfPnECd+LuT0ZrmSBmRf14N0XJsYBb7KYSReG4+AEXypyoBY08LxIVT+AoQ8az8zygYe1o3QExa5c=
X-Received: by 2002:aa7:de87:0:b0:495:daa9:b0f9 with SMTP id
 j7-20020aa7de87000000b00495daa9b0f9mr1340919edv.3.1674234061415; Fri, 20 Jan
 2023 09:01:01 -0800 (PST)
MIME-Version: 1.0
References: <202301171042170334662@zte.com.cn>
In-Reply-To: <202301171042170334662@zte.com.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 18:00:50 +0100
Message-ID: <CAJZ5v0iyQ-psrkZ8XzPxwD+Qf63MwEfRqLjA-qUJBPiYPQjKsQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/int340x_thermal: Convert to use sysfs_emit_at() API
To:     ye.xingchen@zte.com.cn
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, srinivas.pandruvada@linux.intel.com,
        dave@stgolabs.net, chuansheng.liu@intel.com,
        joeyli.kernel@gmail.com, jiasheng@iscas.ac.cn,
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

On Tue, Jan 17, 2023 at 3:42 AM <ye.xingchen@zte.com.cn> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  .../thermal/intel/int340x_thermal/int3400_thermal.c    | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index db8a6f63657d..c1fc4a78607c 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -130,10 +130,7 @@ static ssize_t available_uuids_show(struct device *dev,
>
>         for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; i++) {
>                 if (priv->uuid_bitmap & (1 << i))
> -                       length += scnprintf(&buf[length],
> -                                           PAGE_SIZE - length,
> -                                           "%s\n",
> -                                           int3400_thermal_uuids[i]);
> +                       length += sysfs_emit_at(buf, length, int3400_thermal_uuids[i]);
>         }
>
>         return length;
> @@ -151,10 +148,7 @@ static ssize_t current_uuid_show(struct device *dev,
>
>         for (i = 0; i <= INT3400_THERMAL_CRITICAL; i++) {
>                 if (priv->os_uuid_mask & BIT(i))
> -                       length += scnprintf(&buf[length],
> -                                           PAGE_SIZE - length,
> -                                           "%s\n",
> -                                           int3400_thermal_uuids[i]);
> +                       length += sysfs_emit_at(buf, length, int3400_thermal_uuids[i]);
>         }
>
>         if (length)
> --

Applied as 6.3 material with a modified changelog, thanks!
