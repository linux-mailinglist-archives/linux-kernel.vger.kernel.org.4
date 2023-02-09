Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33818690292
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBIIz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBIIz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:55:56 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C6053E6F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:55:54 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id o5so1271349ljp.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 00:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j/nTYGgZ1XHRzJPT8H8qfStrWDflyDZ6TSwRAnls8wY=;
        b=EwK6fYrkbaY11TxD8La7TSPkBhTJXzAaRcqe2koKaQ4ftSuYE4HvFeHBpaevRd22At
         nzkg5y5yTZXhDSdEiy02CqKU0kcwWDJ+5g2nEaPIzVvCHLiA2DN+Uttv262LlydVfk8A
         Mlc5HAcENMsxP4oZDWhTt0ZZ2JYL3NlIAMQXyxkigLUbRQkU8ObTcLwPmrUgXkXYHyb9
         JIMcd1HGIV2p/ASRiKDOamVn7+Opq40c4w4Td++dES3321l3vKbVbEEeGNVxaZN/PMKu
         YOIp55T1ZIacR92YVFZgOci/ZXC8ZJLS/ICJPXoO3rIcS/8mcUCK2Fd6j+MZ1b8An+s2
         PKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/nTYGgZ1XHRzJPT8H8qfStrWDflyDZ6TSwRAnls8wY=;
        b=1g+0BZUrNMaQXqYjKvnS1rmvxMlmxojoZ9jmryY+KcDxKSyrWZqWcwZvzSP+HWiUIQ
         9ZcHzLmuttlGfGlCULPMIc5mFREg5UqPAjJml6cyudrirRatAAUa4Jx5Z45ojQkh/IRK
         RZzYBhrJLMtatZgbI+LI7mCbRq4uCvY7RxauTJI0WzmwEOyXJCzm1bAoQHugvoec/MZm
         Z/FOCbiD+CVHDJ6wZIq/ibXSfjdILb4Azn/o1ZUICMdQ2FF7vtiGEwbREQKS0sg3Qrgz
         naHWCJO/1Ns2vNmb7sWBF1iS3w06nj4HNpMfwuzsxB3aaauq8Ls6yJIs6cvHz6/WUqLj
         r8pQ==
X-Gm-Message-State: AO0yUKXlaM5XAUuqusJc++5dLQcgoYHE9VrJr1zwwex7h+4ti2SSmnS4
        dhx30KgbzqLdA8+NOtrAPgdJB7nFEb+NtvT0eaunmw==
X-Google-Smtp-Source: AK7set/nGmuNrCLdSZY/fa2Ckq+YgbShiO8RbfWjafqP8Ay+nNy1XXH8TEsvtFlnxU7tpvowJhm4lwF1ubdBSZCMJPY=
X-Received: by 2002:a05:651c:2cb:b0:28b:7bae:65de with SMTP id
 f11-20020a05651c02cb00b0028b7bae65demr1615983ljo.124.1675932952903; Thu, 09
 Feb 2023 00:55:52 -0800 (PST)
MIME-Version: 1.0
References: <20230209031159.2337445-1-ouyangweizhao@zeku.com>
In-Reply-To: <20230209031159.2337445-1-ouyangweizhao@zeku.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Feb 2023 09:55:39 +0100
Message-ID: <CACT4Y+Zrz4KOU82jjEperYOM0sEp6TCmgse4XVMPkwAkS+dXrA@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: fix deadlock in start_report()
To:     Weizhao Ouyang <ouyangweizhao@zeku.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Weizhao Ouyang <o451686892@gmail.com>,
        Shuai Yuan <yuanshuai@zeku.com>, Peng Ren <renlipeng@zeku.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 at 04:27, Weizhao Ouyang <ouyangweizhao@zeku.com> wrote:
>
> From: Weizhao Ouyang <o451686892@gmail.com>
>
> From: Shuai Yuan <yuanshuai@zeku.com>
>
> Calling start_report() again between start_report() and end_report()
> will result in a race issue for the report_lock. In extreme cases this
> problem arose in Kunit tests in the hardware tag-based Kasan mode.
>
> For example, when an invalid memory release problem is found,
> kasan_report_invalid_free() will print error log, but if an MTE exception
> is raised during the output log, the kasan_report() is called, resulting
> in a deadlock problem. The kasan_depth not protect it in hardware
> tag-based Kasan mode.

I think checking report_suppressed() would be cleaner and simpler than
ignoring all trylock failures. If trylock fails, it does not mean that
the current thread is holding it. We of course could do a custom lock
which stores current->tid in the lock word, but it looks effectively
equivalent to checking report_suppressed().



> Signed-off-by: Shuai Yuan <yuanshuai@zeku.com>
> Reviewed-by: Weizhao Ouyang <ouyangweizhao@zeku.com>
> Reviewed-by: Peng Ren <renlipeng@zeku.com>
> ---
> Changes in v2:
> -- remove redundant log
>
>  mm/kasan/report.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 22598b20c7b7..aa39aa8b1855 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -166,7 +166,7 @@ static inline void fail_non_kasan_kunit_test(void) { }
>
>  static DEFINE_SPINLOCK(report_lock);
>
> -static void start_report(unsigned long *flags, bool sync)
> +static bool start_report(unsigned long *flags, bool sync)
>  {
>         fail_non_kasan_kunit_test();
>         /* Respect the /proc/sys/kernel/traceoff_on_warning interface. */
> @@ -175,8 +175,13 @@ static void start_report(unsigned long *flags, bool sync)
>         lockdep_off();
>         /* Make sure we don't end up in loop. */
>         kasan_disable_current();
> -       spin_lock_irqsave(&report_lock, *flags);
> +       if (!spin_trylock_irqsave(&report_lock, *flags)) {
> +               lockdep_on();
> +               kasan_enable_current();
> +               return false;
> +       }
>         pr_err("==================================================================\n");
> +       return true;
>  }
>
>  static void end_report(unsigned long *flags, void *addr)
> @@ -468,7 +473,10 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_ty
>         if (unlikely(!report_enabled()))
>                 return;
>
> -       start_report(&flags, true);
> +       if (!start_report(&flags, true)) {
> +               pr_err("%s: report ignore\n", __func__);
> +               return;
> +       }
>
>         memset(&info, 0, sizeof(info));
>         info.type = type;
> @@ -503,7 +511,11 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
>                 goto out;
>         }
>
> -       start_report(&irq_flags, true);
> +       if (!start_report(&irq_flags, true)) {
> +               ret = false;
> +               pr_err("%s: report ignore\n", __func__);
> +               goto out;
> +       }
>
>         memset(&info, 0, sizeof(info));
>         info.type = KASAN_REPORT_ACCESS;
> @@ -536,7 +548,10 @@ void kasan_report_async(void)
>         if (unlikely(!report_enabled()))
>                 return;
>
> -       start_report(&flags, false);
> +       if (!start_report(&flags, false)) {
> +               pr_err("%s: report ignore\n", __func__);
> +               return;
> +       }
>         pr_err("BUG: KASAN: invalid-access\n");
>         pr_err("Asynchronous fault: no details available\n");
>         pr_err("\n");
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20230209031159.2337445-1-ouyangweizhao%40zeku.com.
