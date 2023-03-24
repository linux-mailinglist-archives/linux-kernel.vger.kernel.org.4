Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF996C7EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjCXNUf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Mar 2023 09:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjCXNUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:20:33 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680C123C44;
        Fri, 24 Mar 2023 06:20:11 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id o12so7829683edb.9;
        Fri, 24 Mar 2023 06:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679664009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNm7/WTsv7sBaucBf7bTAXfGkLVnEd5WdePhGNx//2Q=;
        b=WwKb8pq5GY3Zf1PerMx2LoRF4OyV3TzD3yNSF/3CtTGWPqwm2jkNDBiSNvfXxCLeZg
         LsV4lsTWkhElUqm1Izwha8i74Lea+k/nG14dEnS2y4815tFrJz6uBvfzRgievz5tHuTq
         mKc5/eKamD1xYJZyIi7/nxl0ZwT/czI1Dkre3XQvIWVaAPu42Fk1d3KztoD1qACU4aU/
         6MPYO+qrx2nzDtX7bgNagFESCD6i7b8GcgPKNPof9s0ReI5vO7HtKDQASxzCWqINLAiI
         AnxHLzPXxxBcM3punrtoPP/WCD1KXTcCujiFMk7lehC5kkUAnRNlZGumY84eyklhRXAN
         5YLg==
X-Gm-Message-State: AO0yUKUfWILItSbpEhEWF2PJOBl3+DWw4z7mDkIpLTV713VmzzFFwEEk
        cHkWHcLgAlI0k9yqQX74rb1m4mCXWYQad18CKVQ=
X-Google-Smtp-Source: AK7set8dlnejmmCRYT2DSMYk3Z9pKr54Cb0eO9lfMLmcMWiVEd789Qc7tz+So3x7urz8tURH9yyaWdZAYMhpI76KBtc=
X-Received: by 2002:a17:907:d20e:b0:8d7:edbc:a7b6 with SMTP id
 vd14-20020a170907d20e00b008d7edbca7b6mr1711538ejc.2.1679664009293; Fri, 24
 Mar 2023 06:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230324070807.6342-1-rui.zhang@intel.com> <20230324070807.6342-2-rui.zhang@intel.com>
In-Reply-To: <20230324070807.6342-2-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Mar 2023 14:19:58 +0100
Message-ID: <CAJZ5v0gze1wBEMcuEu4Aa9343rh-3=Bu+pdSYuY3stMd8QGf0A@mail.gmail.com>
Subject: Re: [PATCH 2/5] thermal/core: Reset cooling state during cooling
 device unregistration
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 8:08 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> When unregistering a cooling device, it is possible that the cooling
> device has been activated. And once the cooling device is unregistered,
> no one will deactivate it anymore.
>
> Reset cooling state during cooling device unregistration.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
> In theory, this problem that this patch fixes can be triggered on a
> platform with ACPI Active cooling, by
> 1. overheat the system to trigger ACPI active cooling
> 2. unload ACPI fan driver
> 3. check if the fan is still spinning
> But I don't have such a system so I didn't trigger then problem and I
> only did build & boot test.

So I'm not sure if this change is actually safe.

In the example above, the system will still need the fan to spin after
the ACPI fan driver is unloaded in order to cool down, won't it?

> ---
>  drivers/thermal/thermal_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 30ff39154598..fd54e6c10b60 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1192,6 +1192,10 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>                 }
>         }
>
> +       mutex_lock(&cdev->lock);
> +       cdev->ops->set_cur_state(cdev, 0);
> +       mutex_unlock(&cdev->lock);
> +
>         mutex_unlock(&thermal_list_lock);
>
>         device_unregister(&cdev->device);
> --
> 2.25.1
>
