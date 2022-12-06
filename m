Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178AD6442D3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiLFMBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbiLFMAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:00:54 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F9A2A275;
        Tue,  6 Dec 2022 03:59:14 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id p18so7250501qkg.2;
        Tue, 06 Dec 2022 03:59:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mGLgjowZaCmnCPsw0ckZL1G6OY59bS094DGttlz+1o=;
        b=Z4Wm+xjfSK8rwmUOSnpgJGiC8t7vXMfgZUVFmKHSdc3+jc6+EgO8UgQZOmOnPMFRt4
         //vOGFYRfIu2GPZfAMVTfD+wWcVyrjDOcJVgbc2l2Fb0q6pU59IoiKZ1CjqkQoj7fTgz
         VjfxyJbS+hTPv3mafCXq2K2hzk5aGt7KbF9kNLi9+BUKITvDkjZVU0lsWG5pTKrM1aH3
         JVV6YQiZSwqzzKj4F35xM2oFH0nYwCM0ifwFfXfLIsZP3zhd24oW/iu7EUXHXYzMhFUG
         L4bRznzNxa3zbN2KK8J9HPVkCQmKExahbRpauO8hbJCPyF40qiq3JvjHoBdLA2qLm/SM
         CttA==
X-Gm-Message-State: ANoB5pnchnxOGQtkuOWSoDzUkyT4N+tD50FJlGMbX2x9JCkUd6/fQHio
        u8KLVvqH4rFbL/mmttEZAEowic20RIrBzceah9I76U5lTNQ=
X-Google-Smtp-Source: AA0mqf54Y//WNfWTYLvhXW/qSUq8eN5CWi07t9EUeaM2kLAxjKu0L0/2nb+UgAqsuDaEMsgnKldfEJzkXWu1aYXHhWA=
X-Received: by 2002:a05:620a:22fa:b0:6fb:c38e:e5dd with SMTP id
 p26-20020a05620a22fa00b006fbc38ee5ddmr76278468qki.23.1670327953581; Tue, 06
 Dec 2022 03:59:13 -0800 (PST)
MIME-Version: 1.0
References: <1670308998-12313-1-git-send-email-lirongqing@baidu.com>
In-Reply-To: <1670308998-12313-1-git-send-email-lirongqing@baidu.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Dec 2022 12:59:02 +0100
Message-ID: <CAJZ5v0gG93BXZWOcRVpng_EN-h4+sOyUqTc1XRt4xZkqMnaZZw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle-haltpoll: Disable kvm guest polling when
 mwait_idle is used
To:     lirongqing@baidu.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, peterz@infradead.org,
        akpm@linux-foundation.org, tony.luck@intel.com,
        jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 7:43 AM <lirongqing@baidu.com> wrote:
>
> From: Li RongQing <lirongqing@baidu.com>

First off, can you please write the changelog as proper text in
English using capital letters and periods where applicable?  It is
hard to read the way it is.

> when KVM guest has mwait and mwait_idle is used as default idle function,
> Loading cpuidle-haltpoll will make idle function back to default_idle which
> is using HLT,

Which is because the ->enter callback pointer of state 1 in the
haltpoll driver points to default_enter_idle() which in turn invokes
default_idle() directly, right?

> As the commit aebef63cf7ff ("x86: Remove vendor checks from
> prefer_mwait_c1_over_halt") explains that mwait is preferred
>
> so disable kvm guest polling in this conditions to improve performance,
> like sockperf localhost test shows that latency is reduced by about 20%
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  arch/x86/include/asm/processor.h   | 2 ++
>  arch/x86/kernel/process.c          | 6 ++++++
>  drivers/cpuidle/cpuidle-haltpoll.c | 4 ++++
>  3 files changed, 12 insertions(+)
>
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 67c9d73..159ef33 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -862,4 +862,6 @@ bool arch_is_platform_page(u64 paddr);
>  #define arch_is_platform_page arch_is_platform_page
>  #endif
>
> +bool is_mwait_idle(void);
> +
>  #endif /* _ASM_X86_PROCESSOR_H */
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index c21b734..330972c 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -896,6 +896,12 @@ void select_idle_routine(const struct cpuinfo_x86 *c)
>                 x86_idle = default_idle;
>  }
>
> +bool is_mwait_idle(void)
> +{
> +       return x86_idle == mwait_idle;
> +}
> +EXPORT_SYMBOL_GPL(is_mwait_idle);
> +
>  void amd_e400_c1e_apic_setup(void)
>  {
>         if (boot_cpu_has_bug(X86_BUG_AMD_APIC_C1E)) {
> diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
> index 3a39a7f..8cf1ddf 100644
> --- a/drivers/cpuidle/cpuidle-haltpoll.c
> +++ b/drivers/cpuidle/cpuidle-haltpoll.c
> @@ -17,6 +17,7 @@
>  #include <linux/sched/idle.h>
>  #include <linux/kvm_para.h>
>  #include <linux/cpuidle_haltpoll.h>
> +#include <linux/processor.h>
>
>  static bool force __read_mostly;
>  module_param(force, bool, 0444);
> @@ -111,6 +112,9 @@ static int __init haltpoll_init(void)
>         if (!kvm_para_available() || !haltpoll_want())
>                 return -ENODEV;
>
> +       if (is_mwait_idle())
> +               return -ENODEV;
> +

So perhaps you could make default_enter_idle() be a bit more careful
about what it calls as the "default idle" routine?

>         cpuidle_poll_state_init(drv);
>
>         ret = cpuidle_register_driver(drv);
> --

Anyway, this is unlikely to get into 6.2, so please defer it until
6.2-rc1 is out.
