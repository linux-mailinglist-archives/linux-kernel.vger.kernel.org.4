Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE85770E499
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjEWSZm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 May 2023 14:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjEWSZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:25:40 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43D6132;
        Tue, 23 May 2023 11:25:19 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-96ffba243b1so62148366b.0;
        Tue, 23 May 2023 11:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684866318; x=1687458318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNBtaQFevQ/ylnGP2LIVhsaLMMYO1oXGQ/WUEPR0bCM=;
        b=C3+WeSsrRXPBr5uvHfxaUtxn7SxYu2XOspuVuvTUvx9YpsTLXs4Nuj4uEUoRU4AG0e
         IJihSTmdHm1CQfXfeFmdijQZaxBBc0gNg8J8fi12IyRgO+28qmqeee73ZJWeUnt7/Bhb
         kO+6YNLK0bfcPkzUD6NoCXzPSdcbTJVP+Wj8v7WCuSnlVdoRd5eBxpRfPnkUaCiS3Yct
         5uKBidvO58NGKcKp6LJKGJT6HeHAWx+guxJmJ66nV6yOIV5gczEoTUnFSwJS8J8oBZva
         lqejvpDmI1OqhXRW91FjY3HeduwwR81flKpSlfpEtpJXokqI3IttM7iUYXZ16yvton7W
         cWlQ==
X-Gm-Message-State: AC+VfDyGsJ0tgT6sSGiYMeK3qSDd2mf2mHVoHrBwcODBBCsKjGeeUcxN
        RG7wReIQakFTU0XXkIHzNdW75IoiosOAk2AIth3pe5yd
X-Google-Smtp-Source: ACHHUZ6gJY/Um7fOx7eNZKmYsbI52dpazWi4mSyNnBLr8xAnhL3tvrxqwLCwiKib75/UOF7I96GahuJGbNIY2CxoOCM=
X-Received: by 2002:a17:906:778b:b0:96f:56ab:c6a5 with SMTP id
 s11-20020a170906778b00b0096f56abc6a5mr11986106ejm.3.1684866318116; Tue, 23
 May 2023 11:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230523074535.249802-1-hch@lst.de> <20230523074535.249802-3-hch@lst.de>
In-Reply-To: <20230523074535.249802-3-hch@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 May 2023 20:25:06 +0200
Message-ID: <CAJZ5v0j2N7Cdih0B66-w3ig=2E=MHNt=71mdT5O3OUmq_jsULQ@mail.gmail.com>
Subject: Re: [PATCH 02/24] PM: hibernate: factor out a helper to find the
 resume device
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 9:45 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Split the logic to find the resume device out software_resume and into
> a separate helper to start unwindig the convoluted goto logic.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  kernel/power/hibernate.c | 72 +++++++++++++++++++++-------------------
>  1 file changed, 37 insertions(+), 35 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 30d1274f03f625..07279506366255 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -910,6 +910,41 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data)
>  }
>  EXPORT_SYMBOL_GPL(hibernate_quiet_exec);
>
> +static int find_resume_device(void)
> +{
> +       if (!strlen(resume_file))
> +               return -ENOENT;
> +
> +       pm_pr_dbg("Checking hibernation image partition %s\n", resume_file);
> +
> +       if (resume_delay) {
> +               pr_info("Waiting %dsec before reading resume device ...\n",
> +                       resume_delay);
> +               ssleep(resume_delay);
> +       }
> +
> +       /* Check if the device is there */
> +       swsusp_resume_device = name_to_dev_t(resume_file);
> +       if (swsusp_resume_device)
> +               return 0;
> +
> +       /*
> +        * Some device discovery might still be in progress; we need to wait for
> +        * this to finish.
> +        */
> +       wait_for_device_probe();
> +       if (resume_wait) {
> +               while (!(swsusp_resume_device = name_to_dev_t(resume_file)))
> +                       msleep(10);
> +               async_synchronize_full();
> +       }
> +
> +       swsusp_resume_device = name_to_dev_t(resume_file);
> +       if (!swsusp_resume_device)
> +               return -ENODEV;
> +       return 0;
> +}
> +
>  /**
>   * software_resume - Resume from a saved hibernation image.
>   *
> @@ -949,45 +984,12 @@ static int software_resume(void)
>
>         snapshot_test = false;
>
> -       if (swsusp_resume_device)
> -               goto Check_image;
> -
> -       if (!strlen(resume_file)) {
> -               error = -ENOENT;
> -               goto Unlock;
> -       }
> -
> -       pm_pr_dbg("Checking hibernation image partition %s\n", resume_file);
> -
> -       if (resume_delay) {
> -               pr_info("Waiting %dsec before reading resume device ...\n",
> -                       resume_delay);
> -               ssleep(resume_delay);
> -       }
> -
> -       /* Check if the device is there */
> -       swsusp_resume_device = name_to_dev_t(resume_file);
>         if (!swsusp_resume_device) {
> -               /*
> -                * Some device discovery might still be in progress; we need
> -                * to wait for this to finish.
> -                */
> -               wait_for_device_probe();
> -
> -               if (resume_wait) {
> -                       while ((swsusp_resume_device = name_to_dev_t(resume_file)) == 0)
> -                               msleep(10);
> -                       async_synchronize_full();
> -               }
> -
> -               swsusp_resume_device = name_to_dev_t(resume_file);
> -               if (!swsusp_resume_device) {
> -                       error = -ENODEV;
> +               error = find_resume_device();
> +               if (error)
>                         goto Unlock;
> -               }
>         }
>
> - Check_image:
>         pm_pr_dbg("Hibernation image partition %d:%d present\n",
>                 MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
>
> --
> 2.39.2
>
