Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E542F66A3BD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjAMTzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjAMTyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:54:54 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBE8892C7;
        Fri, 13 Jan 2023 11:54:53 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id u19so54638534ejm.8;
        Fri, 13 Jan 2023 11:54:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3hwHrWRDYeXbE9F5VqU2zeZLznB1nQswMi8N/byOT4=;
        b=HlUYw0RZUi/at66S0ewS3aPT1BVUTjCCc6s+Mwf/zVESp/SYAkONbG53IWZd0+NNPT
         GMD7a14QT7prAfxVi/hDcoXAoV06iZ5JxleVO4Pm9b7hTmo+lMHf0m5NxJP703QVXazg
         gGupZl8KOOgJhhlFnjs6uAjXmW2USlE44Azp0RvFh6tW5BJ4dgbwvFqypXzKNAIUGJG9
         gtNdplGIq6OZb43q6nhiKXXooag7NlRavMOm5vGNNuELusX+qosbiuZD12hM2DslvG95
         JdcXY3tCFVG82Qaae5gIfOKfgxsPJannWIjJN4z4cVe8XfFnmf0JiedguNcyd6O+PDCL
         LZyA==
X-Gm-Message-State: AFqh2koZrFw7gM0UgLeFv8dtaPhfM993Jdi2Jq3JXQwIEb+qlGW4yrUh
        j/NzaAuPnTXBoBPoMToDb1XgnWFPGnQKkYwxhUk=
X-Google-Smtp-Source: AMrXdXt6vpnrW8DaG3YYeV4c/q9rW541ut5UAt+4np4gjufFCbn38auJSWEsAR6X9SIJdwPWztq4ZzYn0O763GXKzt0=
X-Received: by 2002:a17:907:8c85:b0:86a:edd1:29da with SMTP id
 td5-20020a1709078c8500b0086aedd129damr183485ejc.478.1673639692036; Fri, 13
 Jan 2023 11:54:52 -0800 (PST)
MIME-Version: 1.0
References: <20221213155448.385167-1-rf@opensource.cirrus.com>
In-Reply-To: <20221213155448.385167-1-rf@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Jan 2023 20:54:41 +0100
Message-ID: <CAJZ5v0iUsRzMzxKcwbTecQvDE2x=2QotgUe-XHYG77GOmOdV0w@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Document that force_suspend() is
 incompatible with SMART_SUSPEND
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
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

On Tue, Dec 13, 2022 at 4:54 PM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> pm_runtime_force_suspend() cannot be used with DPM_FLAG_SMART_SUSPEND, so
> note this in the kerneldoc.
>
> If DPM_FLAG_SMART_SUSPEND is set and the PM core cannot skip system resume
> it will call pm_runtime_active() on the driver. This can lead to an
> inconsistent state where:
>
>   pm_runtime_force_suspend() called ->runtime_suspend
>
> but
>
>   device_resume_noirq() called pm_runtime_set_active()
>
> This leaves the driver actually suspended but marked as active.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/base/power/runtime.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 50e726b6c2cf..b29be7d4d7d0 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1864,6 +1864,10 @@ static bool pm_runtime_need_not_resume(struct device *dev)
>   * sure the device is put into low power state and it should only be used during
>   * system-wide PM transitions to sleep states.  It assumes that the analogous
>   * pm_runtime_force_resume() will be used to resume the device.
> + *
> + * Do not use with DPM_FLAG_SMART_SUSPEND as this can lead to an inconsistent
> + * state where this function has called the ->runtime_suspend callback but the
> + * PM core marks the driver as runtime active.
>   */
>  int pm_runtime_force_suspend(struct device *dev)
>  {
> --

Applied as 6.3 material, thanks!
