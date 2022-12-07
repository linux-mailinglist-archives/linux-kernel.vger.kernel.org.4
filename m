Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5861F645CC2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiLGOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiLGOh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:37:58 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169935FBB6;
        Wed,  7 Dec 2022 06:37:55 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id z17so10078172qki.11;
        Wed, 07 Dec 2022 06:37:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5taqlCVSBSBpZvPjZD+3+7kbvDpWqxTM95A9eF8jh5A=;
        b=Ag/o/tlh4QhAnOahLuEIqRh1MGlt5v28rqOL0ClykKbt40gmG7JQD2whmDvDlIfsaW
         ZYiDfGz2SJQV2eeODb1aR2ZncsTnteSwzzmaDqblAcqMJPvPeqDEwgclTEs11jm/pTdD
         zXLkVGHfn3PwztnlAiBMQsvkqavXOE53MULmYU/aLN4hpd9PRjNl3Smfkumgs/BL93Da
         4+vGUrM+Jp9sJhhTyGdavHK9RxkYdvtVdUctwuLoTywvucCk4bBsYE+3dRiAhCckplm3
         F6oYgW0diu/sdK6iEFkEBf/ZnK1aAQGY+b4aQMKD3Vq1GV/nIFOYgRbtuLJyDcgc1dax
         nFgw==
X-Gm-Message-State: ANoB5pmvu64tz9OeSCYlC9qObgEWOT7Py0iACpWNvNuecUxXTGxPNvI7
        PAXO03ir5dEbPZlRQlUQ5qZD5Wghdiara5+NB/Ul8Vnz
X-Google-Smtp-Source: AA0mqf6AMNMTdZd9I/1yIXOCkswsx4zgNkHAge4qWVOiD4FraWYJz+lz3MuTpXyfxCy6bVLE6CNWQn4S3kmVD/QCt80=
X-Received: by 2002:a05:620a:4611:b0:6fa:af7e:927c with SMTP id
 br17-20020a05620a461100b006faaf7e927cmr78745245qkb.443.1670423874205; Wed, 07
 Dec 2022 06:37:54 -0800 (PST)
MIME-Version: 1.0
References: <1670416895-50172-1-git-send-email-lirongqing@baidu.com>
In-Reply-To: <1670416895-50172-1-git-send-email-lirongqing@baidu.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Dec 2022 15:37:43 +0100
Message-ID: <CAJZ5v0g5kTRE+x-8xC2WwQr11j01ox=Nk0aguiC1_HGPU8W=Rw@mail.gmail.com>
Subject: Re: [PATCH 1/2][v2] cpuidle-haltpoll: Replace default_idle with arch_cpu_idle
To:     lirongqing@baidu.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, peterz@infradead.org,
        akpm@linux-foundation.org, tony.luck@intel.com,
        jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
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

On Wed, Dec 7, 2022 at 1:42 PM <lirongqing@baidu.com> wrote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> When KVM guest has MWAIT and mwait_idle is used as default idle function,
> but once cpuidle-haltpoll is loaded, default_idle in default_enter_idle is
> used, which is using HLT, and cause a performance regression. As the commit
> aebef63cf7ff ("x86: Remove vendor checks from prefer_mwait_c1_over_halt")
> explains that mwait is preferred
>
> so replace default_idle with arch_cpu_idle which can using MWAIT
> optimization.
>
> latency of sockperf ping-pong localhost test is reduced by more 20%
> unixbench has 5% performance improvements for single core
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  arch/x86/kernel/process.c          | 1 +
>  drivers/cpuidle/cpuidle-haltpoll.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index c21b734..303afad 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -721,6 +721,7 @@ void arch_cpu_idle(void)
>  {
>         x86_idle();
>  }
> +EXPORT_SYMBOL(arch_cpu_idle);

Why do you need this export at all?

>
>  /*
>   * We use this if we don't have any better idle routine..
> diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
> index 3a39a7f..e66df22 100644
> --- a/drivers/cpuidle/cpuidle-haltpoll.c
> +++ b/drivers/cpuidle/cpuidle-haltpoll.c
> @@ -32,7 +32,7 @@ static int default_enter_idle(struct cpuidle_device *dev,
>                 local_irq_enable();
>                 return index;
>         }
> -       default_idle();
> +       arch_cpu_idle();
>         return index;
>  }
>
> --
> 2.9.4
>
