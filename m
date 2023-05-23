Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C37670E4C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbjEWSeB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 May 2023 14:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjEWSd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:33:58 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8E4119;
        Tue, 23 May 2023 11:33:57 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-96ffba243b1so62410366b.0;
        Tue, 23 May 2023 11:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684866836; x=1687458836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2+6ZeOuWaMysW6pOftnvqcNpFa0QK0NSRKjideDKrk=;
        b=cq5rWfUqMn4qFJsZr/VXv7yONOYg3dfueq+X6jw8TKayt04JcDi0NO/RvLvusKF6uX
         3BFy8tP/Xb/yp3rW39/PpeBFRNVSH7rcz1yvyWJZa48+vZSuqPq7agoamgXNuaQoJMjq
         J72O2NSZJBhUFzEGpX/kroRJhPGYj4j8AfExpXPnUbI/GQYKGn0T2BoBNxu/ZgSb0Bt9
         X5GbeXySslyufFS8eEXqheE5n83+5fYb5MXZ0/wg3VVDglMfsAxy8NBxPAlOFfLfAePB
         HaboPHFPIhwJ5uCBIGQVa7QbGDey+rUhexE45X+KH1vHQJiNpQ96/Sd3Bw/VNr6umc+S
         2E5w==
X-Gm-Message-State: AC+VfDzHXsUN0l2EJUu5OyutNeu9eHLYSSHd/MTpet5P8FFsbBCUJyru
        y9+FbwL0PPGvr4QpauKggHv3Y5DU2UNEXqMM+64=
X-Google-Smtp-Source: ACHHUZ74qE46raE7hGqKO0rIs0tcDFMUtKQ9FPO83vqo+TKQ8WKbpVYAKFIYoGywc2NBe5UcG4EZWgMxDbsnjHTCn2U=
X-Received: by 2002:a17:906:748c:b0:965:9c7d:df96 with SMTP id
 e12-20020a170906748c00b009659c7ddf96mr14578825ejl.1.1684866835592; Tue, 23
 May 2023 11:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230523074535.249802-1-hch@lst.de> <20230523074535.249802-5-hch@lst.de>
In-Reply-To: <20230523074535.249802-5-hch@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 May 2023 20:33:44 +0200
Message-ID: <CAJZ5v0jrj3PaC5oZt22DQoJARUcpXaerS-Cmx+34du7=p9WDSw@mail.gmail.com>
Subject: Re: [PATCH 04/24] PM: hibernate: move finding the resume device out
 of software_resume
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 9:45 AM Christoph Hellwig <hch@lst.de> wrote:
>
> software_resume can be called either from an init call in the boot code,
> or from sysfs once the system has finished booting, and the two
> invocation methods this can't race with each other.
>
> For the latter case we did just parse the suspend device manually, while
> the former might not have one.  Split software_resume so that the search
> only happens for the boot case, which also means the special lockdep
> nesting annotation can go away as the system transition mutex can be
> taken a little later and doesn't have the sysfs locking nest inside it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  kernel/power/hibernate.c | 80 ++++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 41 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 78696aa04f5ca3..45e24b02cd50b6 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -907,7 +907,7 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data)
>  }
>  EXPORT_SYMBOL_GPL(hibernate_quiet_exec);
>
> -static int find_resume_device(void)
> +static int __init find_resume_device(void)
>  {
>         if (!strlen(resume_file))
>                 return -ENOENT;
> @@ -942,53 +942,16 @@ static int find_resume_device(void)
>         return 0;
>  }
>
> -/**
> - * software_resume - Resume from a saved hibernation image.
> - *
> - * This routine is called as a late initcall, when all devices have been
> - * discovered and initialized already.
> - *
> - * The image reading code is called to see if there is a hibernation image
> - * available for reading.  If that is the case, devices are quiesced and the
> - * contents of memory is restored from the saved image.
> - *
> - * If this is successful, control reappears in the restored target kernel in
> - * hibernation_snapshot() which returns to hibernate().  Otherwise, the routine
> - * attempts to recover gracefully and make the kernel return to the normal mode
> - * of operation.
> - */
>  static int software_resume(void)
>  {
>         int error;
>
> -       /*
> -        * If the user said "noresume".. bail out early.
> -        */
> -       if (noresume || !hibernation_available())
> -               return 0;
> -
> -       /*
> -        * name_to_dev_t() below takes a sysfs buffer mutex when sysfs
> -        * is configured into the kernel. Since the regular hibernate
> -        * trigger path is via sysfs which takes a buffer mutex before
> -        * calling hibernate functions (which take system_transition_mutex)
> -        * this can cause lockdep to complain about a possible ABBA deadlock
> -        * which cannot happen since we're in the boot code here and
> -        * sysfs can't be invoked yet. Therefore, we use a subclass
> -        * here to avoid lockdep complaining.
> -        */
> -       mutex_lock_nested(&system_transition_mutex, SINGLE_DEPTH_NESTING);
> -
> -       if (!swsusp_resume_device) {
> -               error = find_resume_device();
> -               if (error)
> -                       goto Unlock;
> -       }
> -
>         pm_pr_dbg("Hibernation image partition %d:%d present\n",
>                 MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
>
>         pm_pr_dbg("Looking for hibernation image.\n");
> +
> +       mutex_lock(&system_transition_mutex);
>         error = swsusp_check(false);
>         if (error)
>                 goto Unlock;
> @@ -1035,7 +998,39 @@ static int software_resume(void)
>         goto Finish;
>  }
>
> -late_initcall_sync(software_resume);
> +/**
> + * software_resume_initcall - Resume from a saved hibernation image.
> + *
> + * This routine is called as a late initcall, when all devices have been
> + * discovered and initialized already.
> + *
> + * The image reading code is called to see if there is a hibernation image
> + * available for reading.  If that is the case, devices are quiesced and the
> + * contents of memory is restored from the saved image.
> + *
> + * If this is successful, control reappears in the restored target kernel in
> + * hibernation_snapshot() which returns to hibernate().  Otherwise, the routine
> + * attempts to recover gracefully and make the kernel return to the normal mode
> + * of operation.
> + */
> +static int __init software_resume_initcall(void)
> +{
> +       /*
> +        * If the user said "noresume".. bail out early.
> +        */
> +       if (noresume || !hibernation_available())
> +               return 0;
> +
> +       if (!swsusp_resume_device) {
> +               int error = find_resume_device();
> +
> +               if (error)
> +                       return error;
> +       }
> +
> +       return software_resume();
> +}
> +late_initcall_sync(software_resume_initcall);
>
>
>  static const char * const hibernation_modes[] = {
> @@ -1176,6 +1171,9 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
>         char *name;
>         dev_t res;
>
> +       if (!hibernation_available())
> +               return 0;
> +
>         if (len && buf[len-1] == '\n')
>                 len--;
>         name = kstrndup(buf, len, GFP_KERNEL);
> --
> 2.39.2
>
