Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEED62FC0D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbiKRRyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiKRRyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:54:49 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7AFFCE2;
        Fri, 18 Nov 2022 09:54:48 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id z6so3602969qtv.5;
        Fri, 18 Nov 2022 09:54:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlqnSN+qPaBwTzyL2CAPXxMmkHP1kcbHFxxv679aPDE=;
        b=WETdqozBD//OevXVKteyi25UC0nqPRvrWL03bi7c5q8GlqCrdCdlid/QTNUH2Jtcsf
         ecvJHnpvp09uGgRUpTLQ5PP3ncwvjljjwpBnhm1wsMaJ5gbXRkk0cM1aRVpAfq3uNnJW
         zbf2+JzqVNWEsUkGE7OzWuNQu2nSJvmC6JKXxoKqBefvifXL2kSJ+4/CfAwKmsdJOa9q
         2QymwHX3Z7GA4Oti/xybLm/n7aSMKVVeQEVT5mXnEGrJ3beX6GAs8q/w4iabuxD7hxnI
         H/tg3h4ObmEpFvuIlu2yv6kqk1VGg7uoyWrKmn0Fr4QmhLzZcOg+U/jPNHSc8OMngolD
         141w==
X-Gm-Message-State: ANoB5pllH230MsJTRle7bsX0pyZolGWjSC/Mp3qiwBhKUMZ08ev9g1fr
        2DLF5jnm2ptL6fTZ/SDJ2qJKXTT0mw660F7uLKc=
X-Google-Smtp-Source: AA0mqf5GXPkLFnYUu7hHRe0D0Q3l2NJQjtO5Exs/VyMsF1z+ZwcgTiFcEp/8Q8zoNq5Jcw7X8xMG4iLSX1944UD49fg=
X-Received: by 2002:a05:622a:1989:b0:3a5:7cf8:1a6e with SMTP id
 u9-20020a05622a198900b003a57cf81a6emr7716974qtc.48.1668794087923; Fri, 18 Nov
 2022 09:54:47 -0800 (PST)
MIME-Version: 1.0
References: <20221116025417.2590275-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20221116025417.2590275-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Nov 2022 18:54:36 +0100
Message-ID: <CAJZ5v0hQkZ=jprMc5MNaCudKNATtjs_5Z+N7+a7eeaXRjGpaDQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] thermal: intel: Prevent accidental clearing of
 HFI status
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 3:54 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> When there is a package thermal interrupt with PROCHOT log, it will be
> processed and cleared. It is possible that there is an active HFI event
> status, which is about to get processed or getting processed. While
> clearing PROCHOT log bit, it will also clear HFI status bit. This means
> that hardware is free to update HFI memory.
>
> When clearing a package thermal interrupt, some processors will generate
> a "general protection fault" when any of the read only bit is set to 1.
> The driver maintains a mask of all read-write bits which can be set.
> This mask doesn't include HFI status bit. This bit will also be cleared,
> as it will be assumed read-only bit. So, add HFI status bit 26 to the
> mask.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Is a Fixes tag missing here?

Also, do you want it in 6.1-rc7 or would 6.2 suffice?

> ---
> Email address was wrong, so sending again.
>
>  drivers/thermal/intel/therm_throt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
> index 8352083b87c7..9e8ab31d756e 100644
> --- a/drivers/thermal/intel/therm_throt.c
> +++ b/drivers/thermal/intel/therm_throt.c
> @@ -197,7 +197,7 @@ static const struct attribute_group thermal_attr_group = {
>  #define THERM_STATUS_PROCHOT_LOG       BIT(1)
>
>  #define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(13) | BIT(15))
> -#define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11))
> +#define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(26))
>
>  static void clear_therm_status_log(int level)
>  {
> --
> 2.31.1
>
