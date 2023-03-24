Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8741C6C7EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjCXNY1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Mar 2023 09:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjCXNY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:24:26 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F248F970;
        Fri, 24 Mar 2023 06:24:25 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id eh3so7833090edb.11;
        Fri, 24 Mar 2023 06:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679664263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xANE6v66oWohP4PebACyO/lC5X5hzxKTlxET4jvaQ2c=;
        b=rbStYVPAz5Uj0e+iyCxEzXwsIEuumdhlWcNorjU8OYPcN94Z+cs7vBF7t/24Of+yxZ
         fS40h6sEEaovVp+SWT0a9SuI9pK9FkRg4DjTXDOoeUG9MRQAuH/wTrPWd7D3pOrWxNS2
         MGlCGQV90ssg0p0WuVMn+8SQcSLfKbPpuKg5CjfVLckM6Arqe++WHEThQiKDE+QS94kI
         cxM5IjzuqPGY78aE/PF5Rfbu5tr1nE8XTSNhh3bxw3cFyW2oZnjTMACXBlgubC3xmeYs
         smqRndd0+3MiEuxBt9klmRr5yIA+V6gwE5P3INTiF8u3y8rAmRIpZgiNZDMSW/Gh88b+
         S7Bw==
X-Gm-Message-State: AAQBX9egZFexGYJxulwEJGFZMMosga/JBJf0LydUFH9mlKIZZBJBFsYb
        EhaFkN1n3MElkhPii/lyD6ITPfdNIJhgpC5A4GE=
X-Google-Smtp-Source: AKy350ZxOwLtvgcPNmIhWFUpTMkvqD/15JP96Vd6HCbIxMQB9mjPEDxZpbuhD+XZEG7JVVjG7PFRMmtKoD7VagOPClk=
X-Received: by 2002:a17:907:d02:b0:931:6921:bdbb with SMTP id
 gn2-20020a1709070d0200b009316921bdbbmr1360329ejc.2.1679664263688; Fri, 24 Mar
 2023 06:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230324070807.6342-1-rui.zhang@intel.com> <20230324070807.6342-4-rui.zhang@intel.com>
In-Reply-To: <20230324070807.6342-4-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Mar 2023 14:24:12 +0100
Message-ID: <CAJZ5v0gXfHQmRGEiHsZRXxTB+=dTLca9fbyQA299gL49ysF6rg@mail.gmail.com>
Subject: Re: [PATCH 4/5] thermal/core: Enforce paired .bind/.unbind callbacks
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
> The .bind/.unbind callbacks are designed to allow the thermal zone
> device to bind to/unbind from a matched cooling device, with thermal
> instances created/deleted.
>
> In this sense, .bind/.unbind callbacks must exist in pairs.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/thermal_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 5225d65fb0e0..9c447f22cb39 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1258,6 +1258,11 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>         if (num_trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp) && !trips)
>                 return ERR_PTR(-EINVAL);
>
> +       if ((ops->bind && !ops->unbind) || (!ops->bind && ops->unbind)) {

This can be written as

        if (!!ops->bind != !!ops->unbind) {

> +               pr_err("Thermal zone device .bind/.unbind not paired\n");

And surely none of the existing drivers do that?  Because it would be
a functional regression if they did.

> +               return ERR_PTR(-EINVAL);
> +       }
> +
>         if (!thermal_class)
>                 return ERR_PTR(-ENODEV);
>
> --
