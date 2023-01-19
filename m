Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40460673A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjASN2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjASN2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:28:18 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7224878AA7;
        Thu, 19 Jan 2023 05:28:17 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id y19so2877255edc.2;
        Thu, 19 Jan 2023 05:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hHaYf3ShVBecDcc3xiqO8CfLSvAtlNMlbUep/ol+Mg=;
        b=3b2/i4S8Vgnp2IyDbAsFlZifG4WUB3ASU1kpD3XvYnfik1WNIfAgaj0lj5SyP52RkL
         PQotn5liq61OctJCrLysKFMnCpA3ksXlTjsm6MrG3eCIxefh+4qT1Rw5YLQtjjt4rIIg
         IW6yq7bCVgTIUCzmn89e4uJmeTwMkpgqFcOmgLsy5SCO52A2GrY0ihiUWYROFenVOxiT
         g0ib1QasMF7tba6b3uNp45UGpQ7a9BNNncVoE/eDE67khdKQihCBtyKU8hmCP3C+iJix
         o/yPtugC5w39iCW8CqZQeulvkVS+Morx+ggGT+PuCie1abg3ZssI3y0q2AibEavFvrss
         /Aww==
X-Gm-Message-State: AFqh2kqZr2aFXOc05jQiTOQPgy38tkSx7lT+6Kt+RC3muPKxZ0NyiuQv
        1Zv8hDkUTEeFZ1arnBlMC3YvV7txBXfUiFQFNzIlGsJO
X-Google-Smtp-Source: AMrXdXsF3Jm1l+oe0+CKjgE6A6a1ygDk8NI029loRUsdTpFHf/V5HMrO9fqE/FfK247w/HU5735IEN+ruVgnwmcPJ/I=
X-Received: by 2002:aa7:dd41:0:b0:47e:4f0b:7ad9 with SMTP id
 o1-20020aa7dd41000000b0047e4f0b7ad9mr859891edw.239.1674134895876; Thu, 19 Jan
 2023 05:28:15 -0800 (PST)
MIME-Version: 1.0
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
In-Reply-To: <20230118211123.111493-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Jan 2023 14:28:04 +0100
Message-ID: <CAJZ5v0h-QkrgyLYLn9S_mkWN5nN1fUXej8zmarU425xW-Lei0Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] thermal/core: Fix unregistering netlink at thermal
 init time
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        open list <linux-kernel@vger.kernel.org>
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

On Wed, Jan 18, 2023 at 10:11 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The thermal subsystem initialization miss an netlink unregistering
> function in the error. Add it.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

What tree is this series based on?

> ---
>  drivers/thermal/thermal_core.c    | 4 +++-
>  drivers/thermal/thermal_netlink.c | 5 +++++
>  drivers/thermal/thermal_netlink.h | 3 +++
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d9a3d9566d73..fddafcee5e6f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1606,7 +1606,7 @@ static int __init thermal_init(void)
>
>         result = thermal_register_governors();
>         if (result)
> -               goto error;
> +               goto unregister_netlink;
>
>         result = class_register(&thermal_class);
>         if (result)
> @@ -1621,6 +1621,8 @@ static int __init thermal_init(void)
>
>  unregister_governors:
>         thermal_unregister_governors();
> +unregister_netlink:
> +       thermal_netlink_exit();
>  error:
>         ida_destroy(&thermal_tz_ida);
>         ida_destroy(&thermal_cdev_ida);
> diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
> index 75943b06dbe7..08bc46c3ec7b 100644
> --- a/drivers/thermal/thermal_netlink.c
> +++ b/drivers/thermal/thermal_netlink.c
> @@ -699,3 +699,8 @@ int __init thermal_netlink_init(void)
>  {
>         return genl_register_family(&thermal_gnl_family);
>  }
> +
> +void __init thermal_netlink_exit(void)
> +{
> +       genl_unregister_family(&thermal_gnl_family);
> +}
> diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
> index 1052f523188d..0a9987c3bc57 100644
> --- a/drivers/thermal/thermal_netlink.h
> +++ b/drivers/thermal/thermal_netlink.h
> @@ -13,6 +13,7 @@ struct thermal_genl_cpu_caps {
>  /* Netlink notification function */
>  #ifdef CONFIG_THERMAL_NETLINK
>  int __init thermal_netlink_init(void);
> +void __init thermal_netlink_exit(void);
>  int thermal_notify_tz_create(int tz_id, const char *name);
>  int thermal_notify_tz_delete(int tz_id);
>  int thermal_notify_tz_enable(int tz_id);
> @@ -115,4 +116,6 @@ static inline int thermal_genl_cpu_capability_event(int count, struct thermal_ge
>         return 0;
>  }
>
> +static inline void __init thermal_netlink_exit(void) {}
> +
>  #endif /* CONFIG_THERMAL_NETLINK */
> --
> 2.34.1
>
