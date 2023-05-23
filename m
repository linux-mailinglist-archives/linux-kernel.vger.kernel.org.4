Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE9470E4B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbjEWSa3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 May 2023 14:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjEWSa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:30:28 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7B191;
        Tue, 23 May 2023 11:30:26 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-96f44435d92so118662566b.0;
        Tue, 23 May 2023 11:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684866625; x=1687458625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfbS4pJKMPIQHwf0r8ONmf3iSeCg8srHtIH+ip6lF6w=;
        b=c2I4gnbE0B5uus84l81GrVI6fKlPuMnekiQtOl5K51ztaCGRzYXLfm1mwSA69Nry5t
         bG8qnyOeF/QrNZvGYKBrrhGHhRIxVrpROpvgE/YvAa+253L6aNC1AfhNQh9OmB8j+zd4
         4VR90vAs+DZTNj4GNOnqTtg3rvbwHotdLw9jQbRBcZrVGLq/60vCS0X459Bl1cfd37Gf
         zsoitHWpJXP8aa9FzQebpsEGB4IMuhxCNkSSwQveCwN1ZnnQG1/xSfXiLbgxtR7SFbjb
         S1Qo3cw6dOkLvvL7QynYLe5YlUoqp510xm33EJfZRColfVWBVJ5vppou1w7SbeaqH9GD
         CVwQ==
X-Gm-Message-State: AC+VfDzOh8xYvpeTaXHdk8/QcgmRQq7k9VNjth/b7RbhJxL/Fi0WSBuv
        1aVsg8krUw3SR6YivG2dz1uGyfN0AoUziBg+Uug=
X-Google-Smtp-Source: ACHHUZ66A+UCP5ILB6WJL7gRZr76fIg5QdK7B+g3Ms7DfUP8/uUNDY//3EMNEWFb62fc2+afiPxc0qNLsKcnm/cWsh8=
X-Received: by 2002:a17:906:77d8:b0:959:37cc:190e with SMTP id
 m24-20020a17090677d800b0095937cc190emr13117908ejn.3.1684866625139; Tue, 23
 May 2023 11:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230523074535.249802-1-hch@lst.de> <20230523074535.249802-4-hch@lst.de>
In-Reply-To: <20230523074535.249802-4-hch@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 May 2023 20:30:13 +0200
Message-ID: <CAJZ5v0i2eXi+UEqm0W2eiadjUw5AHT-c1OHTQkemacfL0-jo2A@mail.gmail.com>
Subject: Re: [PATCH 03/24] PM: hibernate: remove the global snapshot_test variable
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
> Passing call dependent variable in global variables is a huge
> antipattern.  Fix it up.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  kernel/power/hibernate.c | 17 ++++++-----------
>  kernel/power/power.h     |  3 +--
>  kernel/power/swap.c      |  2 +-
>  3 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 07279506366255..78696aa04f5ca3 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -64,7 +64,6 @@ enum {
>  static int hibernation_mode = HIBERNATION_SHUTDOWN;
>
>  bool freezer_test_done;
> -bool snapshot_test;
>
>  static const struct platform_hibernation_ops *hibernation_ops;
>
> @@ -684,7 +683,7 @@ static void power_down(void)
>                 cpu_relax();
>  }
>
> -static int load_image_and_restore(void)
> +static int load_image_and_restore(bool snapshot_test)
>  {
>         int error;
>         unsigned int flags;
> @@ -721,6 +720,7 @@ static int load_image_and_restore(void)
>   */
>  int hibernate(void)
>  {
> +       bool snapshot_test = false;
>         unsigned int sleep_flags;
>         int error;
>
> @@ -748,9 +748,6 @@ int hibernate(void)
>         if (error)
>                 goto Exit;
>
> -       /* protected by system_transition_mutex */
> -       snapshot_test = false;
> -
>         lock_device_hotplug();
>         /* Allocate memory management structures */
>         error = create_basic_memory_bitmaps();
> @@ -792,9 +789,9 @@ int hibernate(void)
>         unlock_device_hotplug();
>         if (snapshot_test) {
>                 pm_pr_dbg("Checking hibernation image\n");
> -               error = swsusp_check();
> +               error = swsusp_check(snapshot_test);
>                 if (!error)
> -                       error = load_image_and_restore();
> +                       error = load_image_and_restore(snapshot_test);
>         }
>         thaw_processes();
>
> @@ -982,8 +979,6 @@ static int software_resume(void)
>          */
>         mutex_lock_nested(&system_transition_mutex, SINGLE_DEPTH_NESTING);
>
> -       snapshot_test = false;
> -
>         if (!swsusp_resume_device) {
>                 error = find_resume_device();
>                 if (error)
> @@ -994,7 +989,7 @@ static int software_resume(void)
>                 MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
>
>         pm_pr_dbg("Looking for hibernation image.\n");
> -       error = swsusp_check();
> +       error = swsusp_check(false);
>         if (error)
>                 goto Unlock;
>
> @@ -1022,7 +1017,7 @@ static int software_resume(void)
>                 goto Close_Finish;
>         }
>
> -       error = load_image_and_restore();
> +       error = load_image_and_restore(false);
>         thaw_processes();
>   Finish:
>         pm_notifier_call_chain(PM_POST_RESTORE);
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index b83c8d5e188dec..978189fcafd124 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -59,7 +59,6 @@ asmlinkage int swsusp_save(void);
>
>  /* kernel/power/hibernate.c */
>  extern bool freezer_test_done;
> -extern bool snapshot_test;
>
>  extern int hibernation_snapshot(int platform_mode);
>  extern int hibernation_restore(int platform_mode);
> @@ -174,7 +173,7 @@ extern int swsusp_swap_in_use(void);
>  #define SF_HW_SIG              8
>
>  /* kernel/power/hibernate.c */
> -extern int swsusp_check(void);
> +int swsusp_check(bool snapshot_test);
>  extern void swsusp_free(void);
>  extern int swsusp_read(unsigned int *flags_p);
>  extern int swsusp_write(unsigned int flags);
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 92e41ed292ada8..efed11568bfc72 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -1514,7 +1514,7 @@ int swsusp_read(unsigned int *flags_p)
>   *      swsusp_check - Check for swsusp signature in the resume device
>   */
>
> -int swsusp_check(void)
> +int swsusp_check(bool snapshot_test)
>  {
>         int error;
>         void *holder;
> --
> 2.39.2
>
