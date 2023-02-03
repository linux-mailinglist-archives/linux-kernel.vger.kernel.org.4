Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D581868A038
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjBCR2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjBCR2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:28:41 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38C69D58A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:28:38 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id m10so149912ljp.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jcGTJkSRElQWrb9yzcLonI7fxCZr7wWW4tGlsk/tHYo=;
        b=HZemfMfg8ngdOQaiHKp61kFhQhBx4H8DjoSZ2hwoAfU8dIBMaPwuXFV9vTGbO2Qt8I
         kJTovuBQ9jvLogqEDEg9ewtiTnD0uWz9ZnRcYB4kzFV5QXXnjekDYsypq1VWnTbB+roe
         P0GL2eGH4MwkOvrIMROoGCqCbueJrnomuVCSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcGTJkSRElQWrb9yzcLonI7fxCZr7wWW4tGlsk/tHYo=;
        b=Y8wHikU0sYdw/YUper2CunpX8z+nEgzBtRDeSuzCaC39u6FYI1FqwwUUZUVjmra2xj
         5xoVQrVR8IrufM2quEMNh2g8uOvdOsW9uxjZIjM6blAaNwXvKkYmDReJ7ptJgmsVAneC
         J6dQILI1anOEzOA2XQ3lZlmdhmd1p2/LsiDjSsFvoKMIMfw1kgWmWUf7IzuF0ljHYd8c
         ieSlc6R+L44d+Xz+HYN3JaVBooF5BcJUhHiM+bOY3EYJmA6gUrgU3evHIUUOXhG/mWoM
         r9v4j/hqHChcuO69JBP/a6chmxbHZ1PKzAwZ5/s+SxAMkPpvKCBz3t4yfClLbEPU1EF2
         T+Nw==
X-Gm-Message-State: AO0yUKU4FrCCvHIb+0zU5c7t7TKbddabm2Dk/o2wac6tuPM3diM+UNQF
        xp5QQFWest8FBpox4l64UCFb4RpG+/yFr+avYByEvQ==
X-Google-Smtp-Source: AK7set8Yk0648zK1MtTlHr9QZTzO8Q2mF54xVfOqjS88dn2Pzz+iu5ndoEDcQBPegvC5KLwv4J7OGvgYw2j7CQBPBDg=
X-Received: by 2002:a2e:a36c:0:b0:28b:7226:f203 with SMTP id
 i12-20020a2ea36c000000b0028b7226f203mr1747427ljn.207.1675445316825; Fri, 03
 Feb 2023 09:28:36 -0800 (PST)
MIME-Version: 1.0
References: <20230203014021.3408798-1-qiang1.zhang@intel.com>
In-Reply-To: <20230203014021.3408798-1-qiang1.zhang@intel.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 3 Feb 2023 12:28:25 -0500
Message-ID: <CAEXW_YSUZ8VZnkGBnPxaYH6Lj0Xd8JB4B3AJVrGwP1Sv4yHKBw@mail.gmail.com>
Subject: Re: [PATCH v3] rcutorture: Create nocb tasks only for
 CONFIG_RCU_NOCB_CPU=y kernels
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 8:35 PM Zqiang <qiang1.zhang@intel.com> wrote:
>
> When setting nocbs_nthreads to start rcutorture test with a non-zero value,
> the nocb tasks will be created and invoke rcu_nocb_cpu_offload/deoffload()
> to toggle CPU's callback-offload state, but for CONFIG_RCU_NOCB_CPU=n
> kernel, the rcu_nocb_cpu_offload/deoffload() is a no-op and this is also
> meaningless for torture_type is non-rcu.
>
> This commit therefore add member can_nocbs_toggle to rcu_torture_ops
> structure to avoid unnecessary nocb tasks creation.
>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
>  kernel/rcu/rcutorture.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 297da28ce92d..d01127e0e8cd 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -3708,6 +3708,12 @@ rcu_torture_init(void)
>                 pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabled.\n");
>                 fqs_duration = 0;
>         }
> +       if (nocbs_nthreads != 0 && (cur_ops != &rcu_ops ||
> +                                       !IS_ENABLED(CONFIG_RCU_NOCB_CPU))) {
> +               pr_alert("rcu-torture types: %s and CONFIG_RCU_NOCB_CPU=%d, nocb toggle disabled.\n",
> +                               cur_ops->name, IS_ENABLED(CONFIG_RCU_NOCB_CPU));
> +               nocbs_nthreads = 0;
> +       }
>         if (cur_ops->init)
>                 cur_ops->init();
>
> --
> 2.25.1
>
