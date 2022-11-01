Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A1461562A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiKAXiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKAXiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:38:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4041C427
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 16:38:12 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 4so15035732pli.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 16:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5D52avhPxbcbZms62P7jg88MPx8Vu63yNQl/KWl+6Cg=;
        b=eSAPOBiDCmg+ikv7vxQ4ChNLJT7PWqccIWCQFdJmO5nvJcQGpKZZBE5njFOcaYA0F7
         Qdn3vN1IC1lXz6NZNUBlYc7D7Ezd+khiEyIjIq7X5Ul9lDX5Mgx+yLOUSS9/WcCqOy2P
         ffHfPTRhjQWAVRguk7Bt8sUmFVG5Je3Q61uKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D52avhPxbcbZms62P7jg88MPx8Vu63yNQl/KWl+6Cg=;
        b=aE/+5BAJMMkLdYN/k88SdlnGaqEukgCOf8qMVqlTpBuEw/LrQXHdBaynQ95mgbosaK
         ZoH5Jw889S+AGyJqp0n2qr8dkPGiuOyNt0xqgmACYUnxM/HWXdRluqNeeP/IFXqBRDvq
         fylWr0R4Rp7DmvJ6fI6WdZHLODKm8vwd5fDf9NB1DJ9/d9O0DIJrrD9KqMyUpSLrIkiV
         6zfA+TAFJ8ts5tsvyYEuqo7MyA5rTazDEnegbbBrUiXzIvwQwQWxp2dWtRSYDmScYNu3
         E9Q4m9IrMo6P/oaZIDP+7K9xrFjPnrlh/8LR65D8/YkPQxk9jLRXvXWY2fg7RyFrRcv/
         noZA==
X-Gm-Message-State: ACrzQf32XpaOSV1XWsbdPaX3JOgpaO4lrIMicBSHjAg0ziHfW7eZUlVv
        l00fIwzyKnqavvb0Fqm646IntQ==
X-Google-Smtp-Source: AMsMyM4E2vAxuWKs3+GwBW0in2lTsFDbozPO3T1dsw/EaJMjkjF+4sT6dmlCesvIEX6Ym/CjUSmMpA==
X-Received: by 2002:a17:902:7c11:b0:178:a6ca:4850 with SMTP id x17-20020a1709027c1100b00178a6ca4850mr22463473pll.111.1667345891597;
        Tue, 01 Nov 2022 16:38:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 65-20020a621644000000b0056bbcf88b93sm7081158pfw.42.2022.11.01.16.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:38:11 -0700 (PDT)
Date:   Tue, 1 Nov 2022 16:38:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] LSM: Better reporting of actual LSMs at boot
Message-ID: <202211011636.8C10CB9@keescook>
References: <20221018064825.never.323-kees@kernel.org>
 <CAHC9VhTScG513+-_GDN+nzBQjASW31LrE8juU3c03=0fJ_csGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTScG513+-_GDN+nzBQjASW31LrE8juU3c03=0fJ_csGw@mail.gmail.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 05:50:09PM -0400, Paul Moore wrote:
> On Tue, Oct 18, 2022 at 2:48 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Enhance the details reported by "lsm.debug" in several ways:
> >
> > - report contents of "security="
> > - report contents of "CONFIG_LSM"
> > - report contents of "lsm="
> > - report any early LSM details
> > - whitespace-align the output of similar phases for easier visual parsing
> > - change "disabled" to more accurate "skipped"
> > - explain what "skipped" and "ignored" mean in a parenthetical
> >
> > Upgrade the "security= is ignored" warning from pr_info to pr_warn,
> > and include full arguments list to make the cause even more clear.
> >
> > Replace static "Security Framework initializing" pr_info with specific
> > list of the resulting order of enabled LSMs.
> >
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  security/security.c | 61 +++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 54 insertions(+), 7 deletions(-)
> 
> I don't know about you, but when I'm reading commit descriptions about
> how a patch changes the user visible output of something, e.g. console
> messages, I always enjoy seeing an example of the new output, both in
> normal and debug mode (hint, hint) ;)

Fair point. Commit log will be looong. :)

> 
> More comments below ...
> 
> > diff --git a/security/security.c b/security/security.c
> > index 9696dd64095e..6f6079dec270 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -159,7 +159,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
> >                 lsm->enabled = &lsm_enabled_true;
> >         ordered_lsms[last_lsm++] = lsm;
> >
> > -       init_debug("%s ordering: %s (%sabled)\n", from, lsm->name,
> > +       init_debug("%s ordered: %s (%sabled)\n", from, lsm->name,
> >                    is_enabled(lsm) ? "en" : "dis");
> 
> This isn't your fault, but since you're changing this line let's get
> rid of the "en"/"dis" and do a proper "enabled"/"disabled" string to
> make it slightly easier to find string while grep'ing through the
> sources.  Example:
> 
>   init_debug("... %s\n", (is_enabled(lsm) ? "enabled" : "disabled"));

Sure, will do.

> 
> > @@ -307,7 +308,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
> >                 if (exists_ordered_lsm(lsm))
> >                         continue;
> >                 set_enabled(lsm, false);
> > -               init_debug("%s disabled: %s\n", origin, lsm->name);
> > +               init_debug("%s skipped: %s (not in requested order)\n",
> > +                          origin, lsm->name);
> 
> I'm not sure the distinction between "disabled" and "skipped" above is
> that significant, and in fact I tend to think "disabled" is more
> appropriate.  There is also some (minor) advantage to keeping the user
> visible log messages consistent.
> 
> However, I do think the parenthetical explanations are a nice addition.
> 
> (If we did go the "skipped" route, I think we should also change the
> "security=%s disabled: %s\n" further up the function for the sake of
> consistent language.)

I prefer "skipped", so I'll update the security= report...

> 
> > @@ -318,6 +320,44 @@ static void __init lsm_early_task(struct task_struct *task);
> >
> >  static int lsm_append(const char *new, char **result);
> >
> > +static void __init report_lsm_order(void)
> > +{
> > +       struct lsm_info **lsm, *early;
> > +       size_t size = 0;
> > +       char *effective, *step, *end;
> > +
> > +       /* Count the length of each enabled LSM name. */
> > +       for (early = __start_early_lsm_info; early < __end_early_lsm_info; early++)
> > +               if (is_enabled(early))
> > +                       size += strlen(early->name) + 1;
> > +       for (lsm = ordered_lsms; *lsm; lsm++)
> > +               if (is_enabled(*lsm))
> > +                       size += strlen((*lsm)->name) + 1;
> > +
> > +       /* Allocate space with trailing %NUL or give up. */
> > +       size += 1;
> > +       effective = kzalloc(size, GFP_KERNEL);
> > +       if (!effective)
> > +               return;
> > +       end = effective + size;
> > +       step = effective;
> > +
> > +       /* Append each enabled LSM name. */
> > +       for (early = __start_early_lsm_info; early < __end_early_lsm_info; early++)
> > +               if (is_enabled(early))
> > +                       step += scnprintf(step, end - step, "%s%s",
> > +                                         step == effective ? "" : ",",
> > +                                         early->name);
> > +       for (lsm = ordered_lsms; *lsm; lsm++)
> > +               if (is_enabled(*lsm))
> > +                       step += scnprintf(step, end - step, "%s%s",
> > +                                         step == effective ? "" : ",",
> > +                                         (*lsm)->name);
> > +
> > +       pr_info("initializing lsm=%s\n", effective);
> 
> Instead of going through all the trouble of determining the string
> size and formatting the string via a series of scnprintf() calls, why
> not cut out the intermediate string buffer and use
> pr_info()/pr_cont()?  What am I missing?

I just kinda dislike pr_cont(), but yeah, it's a lot shorter. :P

 security/security.c |   32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

> 
> > @@ -393,13 +436,17 @@ int __init security_init(void)
> >  {
> >         struct lsm_info *lsm;
> >
> > -       pr_info("Security Framework initializing\n");
> > +       init_debug("legacy security=%s\n", chosen_major_lsm ?: " *unspecified*");
> > +       init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
> > +       init_debug("boot arg lsm=%s\n", chosen_lsm_order ?: " *unspecified*");
> >
> >         /*
> >          * Append the names of the early LSM modules now that kmalloc() is
> >          * available
> >          */
> >         for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
> > +               init_debug("  early started: %s (%sabled)\n", lsm->name,
> > +                          is_enabled(lsm) ? "en" : "dis");
> 
> See the earlier comment about "en"/"dis" versus "enabled"/"disabled".
> 
> However, I wonder how useful the above debug message is when you
> consider report_lsm_order().  Since report_lsm_order() dumps both the
> early and normal LSMs, perhaps it makes more sense to annotate the
> output there to indicate early vs normal LSM loading?

I think of it as "debug" being a "show your work" mode, and the final
list should always be visible.

I will send a v2.

-Kees

-- 
Kees Cook
