Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B8168E18C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjBGTyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjBGTy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:54:29 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542E329E3A;
        Tue,  7 Feb 2023 11:54:23 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id dr8so45454515ejc.12;
        Tue, 07 Feb 2023 11:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8L+fDqx/TATGXdlDVn7mRHD70aOLHjjh1VpJFWElUY=;
        b=jPrPwL/UYa5KvOF27gBPGfTyl57yeOswaFseD1yVSkEKS5YtPp7yuorqh0NXOgK2cv
         nSRU79ddTx3F1KMkT1k28R9u2hBGYY68/R5GF2elzmyv5MAzS96jLPm1TfNufg0jj0Zx
         GBVz0hgK9n5PnrAlmY3IdperXquaC8yrpbMTbVE8uW/+e/cfj+LhKi+A+/+nw9MzAY6z
         dAyArs3gkgmtuc6U0UnO0auP9qyxXmbApumdUhA+dGLDrqbjgSikPsS8CkvDk535Bo89
         aGq7lX0C0j0nsbvD/rWyhKojz36l3R6eqiNZf+bf4MA0ea2G9izAdEhVU+nj9mfYdBZi
         Ad4w==
X-Gm-Message-State: AO0yUKVc8fnlvS8J+iKaRj+qPU+iQBhczOmJeYnniVV3zmVuAcjSbhia
        djygNOP0RJdbVj9zIBC0KL8SU3lKkO8SkHmkqyMD1B1t
X-Google-Smtp-Source: AK7set+aVzY12H258It3Xpxffy0h28oufgUAgJSwUd57c+FoWyGTsQsfpCo1xNqWlgKouZn+6j0utz/QP0OCJpfykcQ=
X-Received: by 2002:a17:906:ce2e:b0:87f:575a:9b67 with SMTP id
 sd14-20020a170906ce2e00b0087f575a9b67mr1230384ejb.274.1675799661789; Tue, 07
 Feb 2023 11:54:21 -0800 (PST)
MIME-Version: 1.0
References: <20230204042902.2555347-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230204042902.2555347-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Feb 2023 20:54:10 +0100
Message-ID: <CAJZ5v0hPV+hhUqC3i2CWU1NT35tBrTAA20mFnhAudS8xCi8MtA@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: intel_powerclamp: Return last requested state
 as cur_state
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com
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

On Sat, Feb 4, 2023 at 5:29 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> When the user is reading cur_state from the thermal cooling device for
> Intel powerclamp device:
> - It returns the idle ratio from Package C-state counters when
> there is active idle injection session.
> - -1, when there is no active idle injection session.
>
> This information is not very useful as the package C-state counters vary
> a lot from read to read. Instead just return the last requested cur_state.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2:
> Fixed setting of *state
>
>  drivers/thermal/intel/intel_powerclamp.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index 5f54c88b1977..0282503ecaaf 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -539,17 +539,7 @@ static int powerclamp_get_cur_state(struct thermal_cooling_device *cdev,
>                                  unsigned long *state)
>  {
>         mutex_lock(&powerclamp_lock);
> -
> -       if (powerclamp_data.clamping) {
> -               if (poll_pkg_cstate_enable)
> -                       *state = pkg_cstate_ratio_cur;
> -               else
> -                       *state = powerclamp_data.target_ratio;
> -       } else {
> -               /* to save power, do not poll idle ratio while not clamping */
> -               *state = -1; /* indicates invalid state */
> -       }
> -
> +       *state = powerclamp_data.target_ratio;
>         mutex_unlock(&powerclamp_lock);
>
>         return 0;
> --

Applied as 6.3 material, thanks!
