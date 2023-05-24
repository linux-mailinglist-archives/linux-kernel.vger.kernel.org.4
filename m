Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358C270FC08
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjEXQ43 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 12:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjEXQ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:56:02 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3737F13E;
        Wed, 24 May 2023 09:56:01 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-50d897af77bso298196a12.1;
        Wed, 24 May 2023 09:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684947359; x=1687539359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k71AaKPH+PKMyjKj9rRd3a33/dwSoj0nZEwywN8KLBk=;
        b=eiwk9lWovS4bVkyYfCGwd1C7ITCS/HzX1u8y2V6ve8WEUSjon88H6Sw2v0fBDN/prb
         h5KmSmLzgFxNXZgLBTZKOcWoA0MP82Ly/0lC3OPrX4jcV+hAGF4iJG8Qex5msJ2f9TFQ
         TLRlpX2/09jBShECusOyF9gQbeoXbo85iT87ZaXoHC8k1HhJrfXABRoeSAbYF9yyk7AH
         bCw9U3rsn9ZTRLIzzMrLlF9jjaLThy725DfV0eJE3oRyvtyzAduUH+n0o8Rpla6KfNos
         hQZ1oqW2/T091SCVUEy5Y4lTYIlv76NRYgpmfSa8i36h+Z/apsgXENoRoZvpg2nIadyu
         Y5RQ==
X-Gm-Message-State: AC+VfDwe3OZflFgYbv0oaORxgsa1Ryibupr+6MzGNLoqWrqGMq7pF8g7
        +xrgWnlhBOACJzmaFca7LJlhRJvOlXvlxyt/qvg=
X-Google-Smtp-Source: ACHHUZ4tFT+T7dpzQdI8IrNhlNCDrWw+hRlNVd/dZe5o2/a0BdoFWWMjqgLP+2sQyJx+x9LbHGcVWlwpWoMFR6zouuo=
X-Received: by 2002:a17:906:7a52:b0:965:b73d:592c with SMTP id
 i18-20020a1709067a5200b00965b73d592cmr16017501ejo.4.1684947359345; Wed, 24
 May 2023 09:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230502150435.423770-1-kai.heng.feng@canonical.com>
In-Reply-To: <20230502150435.423770-1-kai.heng.feng@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 18:55:48 +0200
Message-ID: <CAJZ5v0gYMLopZuTr1nE9GDMJ_r8O-+YWz+SLAKm9-muBVrk8+A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PM: suspend: Define pm_suspend_target_state
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        bblock@linux.ibm.com, acelan.kao@canonical.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 5:05 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Define pm_suspend_target_state so it can still be used when
> CONFIG_SUSPEND is not set.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v4:
>  - Move pm_suspend_target_state to CONFIG_SUSPEND block.
>
> v3:
>  - New patch to resolve undefined pm_suspend_target_state.
>
>  drivers/base/power/wakeup.c | 5 -----
>  include/linux/suspend.h     | 4 +++-
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 7cc0c0cf8eaa..a917219feea6 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -19,11 +19,6 @@
>
>  #include "power.h"
>
> -#ifndef CONFIG_SUSPEND
> -suspend_state_t pm_suspend_target_state;
> -#define pm_suspend_target_state        (PM_SUSPEND_ON)
> -#endif
> -
>  #define list_for_each_entry_rcu_locked(pos, head, member) \
>         list_for_each_entry_rcu(pos, head, member, \
>                 srcu_read_lock_held(&wakeup_srcu))
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index d0d4598a7b3f..474ecfbbaa62 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -202,6 +202,7 @@ struct platform_s2idle_ops {
>  };
>
>  #ifdef CONFIG_SUSPEND
> +extern suspend_state_t pm_suspend_target_state;
>  extern suspend_state_t mem_sleep_current;
>  extern suspend_state_t mem_sleep_default;
>
> @@ -337,6 +338,8 @@ extern bool sync_on_suspend_enabled;
>  #else /* !CONFIG_SUSPEND */
>  #define suspend_valid_only_mem NULL
>
> +#define pm_suspend_target_state        (PM_SUSPEND_ON)
> +
>  static inline void pm_suspend_clear_flags(void) {}
>  static inline void pm_set_suspend_via_firmware(void) {}
>  static inline void pm_set_resume_via_firmware(void) {}
> @@ -503,7 +506,6 @@ extern void pm_report_max_hw_sleep(u64 t);
>
>  /* drivers/base/power/wakeup.c */
>  extern bool events_check_enabled;
> -extern suspend_state_t pm_suspend_target_state;
>
>  extern bool pm_wakeup_pending(void);
>  extern void pm_system_wakeup(void);
> --

Applied as 6.5 material under an edited subject and with some edits in
the changelog.

Thanks!
