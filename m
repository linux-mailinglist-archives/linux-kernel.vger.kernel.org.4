Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA860352E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJRVuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJRVuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:50:22 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAE0BCBBF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:50:21 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-35ad0584879so150269187b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AIr7KjAmozy1+mptmG8zUIs0U34qjGCIt4EFZOuEuCk=;
        b=5f3V5CFbBtYQzFwXyNKCtmHUsSs6PleEF9QYhzBNQyPCAOBQQ7wRyShF61qnHvhnXR
         WWl0Z/IdTAEj+fxpEpNtyFWqWWr7WZmYtjerF5tejZWr1RJgS0yuJiUJzzHi61jcF/KZ
         BU0jbVCth4HcARi8pjqi61F1J6ONctR44KX6dEkfG5JSROjhfJaDkyBfprGYTQBjQaL6
         2IwgzNBzQmvJezqVAxgQDPHR6Wmp0q/xT5Fei4dyGcevoiH7jrLyT11MV3tge35vu/vH
         fzDPq/4djA+oAdGOxZwih54asofz3oOO9g+wGwKYIO9q9KqonBxVj2Y+GXQ0Ltd0q9HP
         uYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIr7KjAmozy1+mptmG8zUIs0U34qjGCIt4EFZOuEuCk=;
        b=KL38kmHgPPdtodz4VqXL1UYbFhx26aEt5ziEqzGZ5Nqs7T/bqmpmbbu2qrs/JofiFs
         uLTtOvFV/UGxJ7qZG9Y9BZvBsBAtX0Q08Hr7hKaiAU6WtSF4eq0gL/WIderoHNmqtOWz
         GxijXKWLU20t6VJwFU0wFVp/A7ytg2rv5a2h9q4tcPFKLYaZ4fWM8HINhfQdd/ptN/+i
         eJ1DRevnkzvowaoq/fb4KOXXQd2PwcAcSSOraN/pRQdoePzlkqzeO+WGWNngB91cy7uW
         lpKKOJi5RXR5u7ijV1ppqR2tbaC/SkPQ99viByLaHUyRPU+3HoayHUh1Ow4Uja1bsC7X
         8pAA==
X-Gm-Message-State: ACrzQf1pQKH7PSysYXEPzIgnMTGPbyrnGQCTXhQBD1OygYvm9cSIZytQ
        FPSY40d3UM1MSe0kRe0aSEZeGNBWJ7716+WII9sm
X-Google-Smtp-Source: AMsMyM5NfkpAOvLZjGDxdzPb/OC0/MaTUz1pWaeIBwOlU9fjOACUua9kgkrL36mApne0JEiWoq0uBRRaX5lv56vO1Tw=
X-Received: by 2002:a0d:ebc1:0:b0:360:5a77:4d78 with SMTP id
 u184-20020a0debc1000000b003605a774d78mr4196697ywe.336.1666129820531; Tue, 18
 Oct 2022 14:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221018064825.never.323-kees@kernel.org>
In-Reply-To: <20221018064825.never.323-kees@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 18 Oct 2022 17:50:09 -0400
Message-ID: <CAHC9VhTScG513+-_GDN+nzBQjASW31LrE8juU3c03=0fJ_csGw@mail.gmail.com>
Subject: Re: [PATCH] LSM: Better reporting of actual LSMs at boot
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 2:48 AM Kees Cook <keescook@chromium.org> wrote:
>
> Enhance the details reported by "lsm.debug" in several ways:
>
> - report contents of "security="
> - report contents of "CONFIG_LSM"
> - report contents of "lsm="
> - report any early LSM details
> - whitespace-align the output of similar phases for easier visual parsing
> - change "disabled" to more accurate "skipped"
> - explain what "skipped" and "ignored" mean in a parenthetical
>
> Upgrade the "security= is ignored" warning from pr_info to pr_warn,
> and include full arguments list to make the cause even more clear.
>
> Replace static "Security Framework initializing" pr_info with specific
> list of the resulting order of enabled LSMs.
>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  security/security.c | 61 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 54 insertions(+), 7 deletions(-)

I don't know about you, but when I'm reading commit descriptions about
how a patch changes the user visible output of something, e.g. console
messages, I always enjoy seeing an example of the new output, both in
normal and debug mode (hint, hint) ;)

More comments below ...

> diff --git a/security/security.c b/security/security.c
> index 9696dd64095e..6f6079dec270 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -159,7 +159,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>                 lsm->enabled = &lsm_enabled_true;
>         ordered_lsms[last_lsm++] = lsm;
>
> -       init_debug("%s ordering: %s (%sabled)\n", from, lsm->name,
> +       init_debug("%s ordered: %s (%sabled)\n", from, lsm->name,
>                    is_enabled(lsm) ? "en" : "dis");

This isn't your fault, but since you're changing this line let's get
rid of the "en"/"dis" and do a proper "enabled"/"disabled" string to
make it slightly easier to find string while grep'ing through the
sources.  Example:

  init_debug("... %s\n", (is_enabled(lsm) ? "enabled" : "disabled"));

> @@ -307,7 +308,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>                 if (exists_ordered_lsm(lsm))
>                         continue;
>                 set_enabled(lsm, false);
> -               init_debug("%s disabled: %s\n", origin, lsm->name);
> +               init_debug("%s skipped: %s (not in requested order)\n",
> +                          origin, lsm->name);

I'm not sure the distinction between "disabled" and "skipped" above is
that significant, and in fact I tend to think "disabled" is more
appropriate.  There is also some (minor) advantage to keeping the user
visible log messages consistent.

However, I do think the parenthetical explanations are a nice addition.

(If we did go the "skipped" route, I think we should also change the
"security=%s disabled: %s\n" further up the function for the sake of
consistent language.)

> @@ -318,6 +320,44 @@ static void __init lsm_early_task(struct task_struct *task);
>
>  static int lsm_append(const char *new, char **result);
>
> +static void __init report_lsm_order(void)
> +{
> +       struct lsm_info **lsm, *early;
> +       size_t size = 0;
> +       char *effective, *step, *end;
> +
> +       /* Count the length of each enabled LSM name. */
> +       for (early = __start_early_lsm_info; early < __end_early_lsm_info; early++)
> +               if (is_enabled(early))
> +                       size += strlen(early->name) + 1;
> +       for (lsm = ordered_lsms; *lsm; lsm++)
> +               if (is_enabled(*lsm))
> +                       size += strlen((*lsm)->name) + 1;
> +
> +       /* Allocate space with trailing %NUL or give up. */
> +       size += 1;
> +       effective = kzalloc(size, GFP_KERNEL);
> +       if (!effective)
> +               return;
> +       end = effective + size;
> +       step = effective;
> +
> +       /* Append each enabled LSM name. */
> +       for (early = __start_early_lsm_info; early < __end_early_lsm_info; early++)
> +               if (is_enabled(early))
> +                       step += scnprintf(step, end - step, "%s%s",
> +                                         step == effective ? "" : ",",
> +                                         early->name);
> +       for (lsm = ordered_lsms; *lsm; lsm++)
> +               if (is_enabled(*lsm))
> +                       step += scnprintf(step, end - step, "%s%s",
> +                                         step == effective ? "" : ",",
> +                                         (*lsm)->name);
> +
> +       pr_info("initializing lsm=%s\n", effective);

Instead of going through all the trouble of determining the string
size and formatting the string via a series of scnprintf() calls, why
not cut out the intermediate string buffer and use
pr_info()/pr_cont()?  What am I missing?

> @@ -393,13 +436,17 @@ int __init security_init(void)
>  {
>         struct lsm_info *lsm;
>
> -       pr_info("Security Framework initializing\n");
> +       init_debug("legacy security=%s\n", chosen_major_lsm ?: " *unspecified*");
> +       init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
> +       init_debug("boot arg lsm=%s\n", chosen_lsm_order ?: " *unspecified*");
>
>         /*
>          * Append the names of the early LSM modules now that kmalloc() is
>          * available
>          */
>         for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> +               init_debug("  early started: %s (%sabled)\n", lsm->name,
> +                          is_enabled(lsm) ? "en" : "dis");

See the earlier comment about "en"/"dis" versus "enabled"/"disabled".

However, I wonder how useful the above debug message is when you
consider report_lsm_order().  Since report_lsm_order() dumps both the
early and normal LSMs, perhaps it makes more sense to annotate the
output there to indicate early vs normal LSM loading?

(This is one of the reasons why it can be nice to see an example of
the output in the commit description.)

-- 
paul-moore.com
