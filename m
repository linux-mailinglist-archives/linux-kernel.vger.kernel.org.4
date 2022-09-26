Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626FD5EB4A4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiIZWkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiIZWkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:40:15 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA70E476F3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:40:09 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-127ba06d03fso11170819fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4KiOCtK+FPFBaBSD234AcIQn4ASKrCbdEIcGR0w5qNk=;
        b=7+CFRdW0czdFMr1fo9cqKgwdxvrbCUgUi7NgTJtgJQ3kn42uE8kl6ujsx/zLde2e27
         T+ZOnm2/q3O/3H/OVE9eJGRXyUXjuBdxpYKtJLFjG/LrO+OesomoiF2jfjAw2Algu83k
         Uh/WPeXaXa26ZafAV+73r8GzNQaMcLnAsBKdhXzSNvSHNDin8kJufynJ4zRompBBsn6k
         HKNSoQoX+zfprEEdRC9e4yOGnbULJVD9jX2bSIOXTiU/S7i3CYEiMCtp20c69am4sxIV
         trxEzqWF7S14zPqZwGBLxKhoUDbzRq4LqMx0VlPHXSwjodF5VvtQ7jN4w/9JNvvORLTo
         sJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4KiOCtK+FPFBaBSD234AcIQn4ASKrCbdEIcGR0w5qNk=;
        b=Nmn21pgAwwfsJOU7fIewxuRuhvC204aOjQA7PjQVoRG2RB8/FbC0MNjBJXXbssVqcC
         IMtkmzVBspYic3dDUQlscw2q665I/CKsgpy5RzdlzCi3LJj9Sw2Bup4TgdbefJUoyTCM
         nk9PzJZDjWbvNqVmd5hhTqItWV9Pn6/B8s+AoWhlsu57jS09CDAIPiBMj7pteNM/26A5
         TxvaOabHJWOmewRNT9T3ye8sXBptSHezhNB4EHTJC1rWmb/wDYwtnIDfVykML2apX4l5
         xaG7bRlGHnsrGzQsDpF5n/ZP1Az6yJqhWta5eZxFCqaxz24k5+nP/FZccgpZy1rh6Q29
         c//A==
X-Gm-Message-State: ACrzQf30jt+RBg3OCtDVwROwY7jslT1OlGMsrqPO5zVAuv5KKlY1H3HK
        k+zoOXjtWt5+X68xaA/UW47w9ya7R4r3NI8QpTpk
X-Google-Smtp-Source: AMsMyM5Ll9Hz28q5EJA3C/EjbWd7oQiroSVNZyLN57TX2DOCveozh6b12WXc6/n86trpkP0syEDwGLAINQe6ZtKirUg=
X-Received: by 2002:a05:6870:15c9:b0:101:e18b:d12d with SMTP id
 k9-20020a05687015c900b00101e18bd12dmr552208oad.51.1664232008652; Mon, 26 Sep
 2022 15:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220926131643.146502-1-nathanl@linux.ibm.com> <20220926131643.146502-2-nathanl@linux.ibm.com>
In-Reply-To: <20220926131643.146502-2-nathanl@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Sep 2022 18:39:57 -0400
Message-ID: <CAHC9VhQwypiLEwdiktaycyeMiArajgDd7YNiOoZ-XFaMx72Qqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] powerpc/pseries: block untrusted device tree
 changes when locked down
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org,
        mpe@ellerman.id.au, serge@hallyn.com, ajd@linux.ibm.com,
        gcwilson@linux.ibm.com, nayna@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 9:17 AM Nathan Lynch <nathanl@linux.ibm.com> wrote:
>
> The /proc/powerpc/ofdt interface allows the root user to freely alter
> the in-kernel device tree, enabling arbitrary physical address writes
> via drivers that could bind to malicious device nodes, thus making it
> possible to disable lockdown.
>
> Historically this interface has been used on the pseries platform to
> facilitate the runtime addition and removal of processor, memory, and
> device resources (aka Dynamic Logical Partitioning or DLPAR). Years
> ago, the processor and memory use cases were migrated to designs that
> happen to be lockdown-friendly: device tree updates are communicated
> directly to the kernel from firmware without passing through untrusted
> user space. I/O device DLPAR via the "drmgr" command in powerpc-utils
> remains the sole legitimate user of /proc/powerpc/ofdt, but it is
> already broken in lockdown since it uses /dev/mem to allocate argument
> buffers for the rtas syscall. So only illegitimate uses of the
> interface should see a behavior change when running on a locked down
> kernel.
>
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/reconfig.c | 5 +++++
>  include/linux/security.h                  | 1 +
>  security/security.c                       | 1 +
>  3 files changed, 7 insertions(+)

Thanks for moving the definitions.

Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

> diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
> index cad7a0c93117..599bd2c78514 100644
> --- a/arch/powerpc/platforms/pseries/reconfig.c
> +++ b/arch/powerpc/platforms/pseries/reconfig.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/notifier.h>
>  #include <linux/proc_fs.h>
> +#include <linux/security.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
>
> @@ -361,6 +362,10 @@ static ssize_t ofdt_write(struct file *file, const char __user *buf, size_t coun
>         char *kbuf;
>         char *tmp;
>
> +       rv = security_locked_down(LOCKDOWN_DEVICE_TREE);
> +       if (rv)
> +               return rv;
> +
>         kbuf = memdup_user_nul(buf, count);
>         if (IS_ERR(kbuf))
>                 return PTR_ERR(kbuf);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 7bd0c490703d..39e7c0e403d9 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -114,6 +114,7 @@ enum lockdown_reason {
>         LOCKDOWN_IOPORT,
>         LOCKDOWN_MSR,
>         LOCKDOWN_ACPI_TABLES,
> +       LOCKDOWN_DEVICE_TREE,
>         LOCKDOWN_PCMCIA_CIS,
>         LOCKDOWN_TIOCSSERIAL,
>         LOCKDOWN_MODULE_PARAMETERS,
> diff --git a/security/security.c b/security/security.c
> index 4b95de24bc8d..51bf66d4f472 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -52,6 +52,7 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>         [LOCKDOWN_IOPORT] = "raw io port access",
>         [LOCKDOWN_MSR] = "raw MSR access",
>         [LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
> +       [LOCKDOWN_DEVICE_TREE] = "modifying device tree contents",
>         [LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
>         [LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
>         [LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
> --
> 2.37.3
>


-- 
paul-moore.com
