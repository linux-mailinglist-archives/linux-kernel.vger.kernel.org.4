Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0092E694B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjBMPoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBMPoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:44:10 -0500
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6165A193E5;
        Mon, 13 Feb 2023 07:44:09 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id sb24so8958273ejb.8;
        Mon, 13 Feb 2023 07:44:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6P1M03nAGklqioioBz5l92wTPaumCnFmPv0TkmyVJs=;
        b=jbXJuVUMnvBSbRIYbafo0w8zy+3vWLDXdtEl6dRbpTMeEr98GuylKiO/HqfXXrfbl5
         gK+zEJh86yLwhrnEvVkTERvhnBGA8NipF1VrhGqclnEs9wMRbvc+iTQCmeP1lE0ynHEK
         r4jFhlYrTWenTmHP7rtpVibbTzdFUpA9DkI7GzP8tFYJ5Rv07E9T73n2CelMKhm16jBT
         0fY4GhrdxOiJmFc60wBJ1cRBBoVRjsWfr40VSrGiWIu+RcoZDROAYo4tMODOmxjg+SIZ
         Q+wrJG6i/I7aB5T6JR0aV7M2wapnBeTnuap4v2rlVXjSRjYM9g4JgI3kjqEzNfUAzTYN
         MsTQ==
X-Gm-Message-State: AO0yUKUD9k7sQzRdyvkP1pJJnLI3LFUANSPXSyGh2tkLk/Gb3uLkyW/9
        CO7LEIVj7bUMFITanT2iYprTZnUpEco8sKlZLCw=
X-Google-Smtp-Source: AK7set9+h6LXEdBoEOXJ/EpXDzRjTyUp1CUkJ8lFaqmb5RT9stK+jkAejviMv1YvZ4XL1LuaUHMJdEPOgJWMNPeEMDE=
X-Received: by 2002:a17:906:1f04:b0:879:9c05:f5fb with SMTP id
 w4-20020a1709061f0400b008799c05f5fbmr4757820ejj.5.1676303047936; Mon, 13 Feb
 2023 07:44:07 -0800 (PST)
MIME-Version: 1.0
References: <20230213132048.2612961-1-rf@opensource.cirrus.com>
In-Reply-To: <20230213132048.2612961-1-rf@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 16:43:56 +0100
Message-ID: <CAJZ5v0hE7u_rTEn1KRFhE55Y3MHS_Le4rAbFPmR+0r+Eg=3K9Q@mail.gmail.com>
Subject: Re: [PATCH] PM: Add EXPORT macros for exporting PM functions
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
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

On Mon, Feb 13, 2023 at 2:20 PM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Add a set of macros for exporting functions only if CONFIG_PM
> is enabled.
>
> The naming follows the style of the standard EXPORT_SYMBOL_*()
> macros that they replace.
>
> Sometimes a module wants to export PM functions directly to other
> drivers, not a complete struct dev_pm_ops. A typical example is
> where a core library exports the generic (shared) implementation
> and calling code wraps one or more of these in custom code.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  include/linux/pm.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 93cd34f00822..21618f7087f8 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -379,9 +379,17 @@ const struct dev_pm_ops name = { \
>         const struct dev_pm_ops name;                                   \
>         __EXPORT_SYMBOL(name, sec, ns);                                 \
>         const struct dev_pm_ops name
> +#define EXPORT_PM_FN(name)             EXPORT_SYMBOL(name)
> +#define EXPORT_PM_FN_GPL(name)         EXPORT_SYMBOL_GPL(name)
> +#define EXPORT_PM_FN_NS(name, ns)      EXPORT_SYMBOL_NS(name, ns)
> +#define EXPORT_PM_FN_NS_GPL(name, ns)  EXPORT_SYMBOL_NS_GPL(name, ns)

Why are the non-GPL variants needed?

>  #else
>  #define _EXPORT_DEV_PM_OPS(name, sec, ns)                              \
>         static __maybe_unused const struct dev_pm_ops __static_##name
> +#define EXPORT_PM_FN(name)
> +#define EXPORT_PM_FN_GPL(name)
> +#define EXPORT_PM_FN_NS(name, ns)
> +#define EXPORT_PM_FN_NS_GPL(name, ns)
>  #endif
>
>  #define EXPORT_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "", "")
> --
> 2.30.2
>
