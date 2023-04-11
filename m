Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8726DE3B4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjDKSQx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 14:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDKSQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:16:50 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F23E5263;
        Tue, 11 Apr 2023 11:16:49 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id qb20so22216270ejc.6;
        Tue, 11 Apr 2023 11:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681237008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxnsZJ+NacNo9ZhNTgIw4VHiynvz3ELZgFV4x0n8u0I=;
        b=S8+e1enXbuCRUP+wMgn89cASSgYDBBqV+qu4a+YMn2OJbFfgMt190EWZyjVcijEIih
         5ZNiN8jY/eVRBLyVZ4ISiR3Yl88P/GVs0DfO/wE6hosIKfL4ewPecALGmiVTWXIZ2THx
         TiDFMTsEaVGe9wnhUjaAdENcufag0DdVPDnHxcknbP1DR0yrv7k8lzU7h/9ov35Xzeyn
         YxlkyEKTmTMHAqHtIi+gpOEnCP8/BONS672xLmeLtgIXPqFcFgRak3qDEeRu3sqkhEzP
         8ALnWdKOAKnUQxzkxgaBnfrCbSyGRxfVVJ6ZaAVPwO6TS9zdsb2LNhcGKBQKUojqow1w
         /dNg==
X-Gm-Message-State: AAQBX9cRvEEpfKEBtqexid+cEEfYbISvlAdMF+/SO0QdtzcHxSf/F8Mw
        kMC8dNURhFqjkxgtrDmpCIkqWN3LbFvoncXJkso=
X-Google-Smtp-Source: AKy350bhIyizUsvdp0JSQJsA/Oez7me+/eZW0854eJp1ZLKJL+u4qISAPVrYy6yg84yEtkcW6cqrXYPne2hLiPN6+qA=
X-Received: by 2002:a17:907:1c9a:b0:94d:cf8c:1542 with SMTP id
 nb26-20020a1709071c9a00b0094dcf8c1542mr2632678ejc.2.1681237007848; Tue, 11
 Apr 2023 11:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230410205305.1649678-1-daniel.lezcano@linaro.org> <20230410205305.1649678-2-daniel.lezcano@linaro.org>
In-Reply-To: <20230410205305.1649678-2-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Apr 2023 20:16:36 +0200
Message-ID: <CAJZ5v0gA2-WBOs6-N4iaaypdq4-P0JH+jLfOsaYi4GpdqorAcQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] thermal/drivers/intel_pch_thermal: Use thermal
 driver device to write a trace
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Tim Zimmermann <tim@linux4.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 10:53 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The pch_critical() callback accesses the thermal zone device structure
> internals, it dereferences the thermal zone struct device and the 'type'.
>
> For the former, the driver related device should be use instead and
> for the latter an accessor already exists. Use them instead of
> accessing the internals.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/intel/intel_pch_thermal.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
> index dce50d239357..0de46057db2a 100644
> --- a/drivers/thermal/intel/intel_pch_thermal.c
> +++ b/drivers/thermal/intel/intel_pch_thermal.c
> @@ -127,7 +127,10 @@ static int pch_thermal_get_temp(struct thermal_zone_device *tzd, int *temp)
>
>  static void pch_critical(struct thermal_zone_device *tzd)
>  {
> -       dev_dbg(&tzd->device, "%s: critical temperature reached\n", tzd->type);
> +       struct pch_thermal_device *ptd = thermal_zone_device_priv(tzd);
> +
> +       dev_dbg(&ptd->pdev->dev, "%s: critical temperature reached\n",
> +               thermal_zone_device_type(tzd));

No, this just makes the code more complex than it is and the only
reason seems to be "cleanliness".

Something like

thermal_zone_dbg(tzd, "critical temperature reached\n");

would work, the above doesn't.  Sorry.

>  }
>
>  static struct thermal_zone_device_ops tzd_ops = {
> --
