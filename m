Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA12E70E4D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbjEWSiE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 May 2023 14:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbjEWShf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:37:35 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA13018B;
        Tue, 23 May 2023 11:37:20 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso108858166b.0;
        Tue, 23 May 2023 11:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684867022; x=1687459022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOckud4CsGpi42vHzY/iN1xEHfyZzu8tYLlnQmf3XXU=;
        b=lPIgigwZ11iBv8vgKFH9/Ir3BNZpyjgySuC1i1WFp3quETnbhTdcsMvkIczDcTNYXs
         Pd/Z8dqB3bXIgfzQEQ2gaCjus3zjd2VQpsCl3e28JeeWkdo2jchb8a3ch7rE1EVwV+Er
         +mnJ9B4tkQA43cmK/bai/cAhBdGZvaBg82H3mUtr96fkuiW28UO2N8i6Vp6b+r09xNpe
         9OJvJ6pUihSJAalsJ9NV5vCB+z4UPZ8H3dkRG1JHzjEG7MGk9n88r/BiFrzw5bz9fjs/
         BSeEEf0KexWhWQYPpncR+Sxk+z026FBT8tq9RdQyg4GZpNXBAsddQPYlrcqAR89whnfV
         K2Ag==
X-Gm-Message-State: AC+VfDxukIGenn0F+ZJeCtjC39DSnGkh4hpB0K4wMr7pAMkiOkl3qwdV
        OtfdQUgRPGCsKQ9egjDQ59DGRpmOYlloeHGjcaw=
X-Google-Smtp-Source: ACHHUZ6nbFDPqkJycDJLopbKTUzhoYKAgpRsCSCy+ygpw6i+jItGXHdrxW/6BlRArGGvUIQ7qUgo8pqVVYhtrNaQv8U=
X-Received: by 2002:a17:906:6495:b0:966:2210:4065 with SMTP id
 e21-20020a170906649500b0096622104065mr14890560ejm.4.1684867022285; Tue, 23
 May 2023 11:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230523074535.249802-1-hch@lst.de> <20230523074535.249802-22-hch@lst.de>
In-Reply-To: <20230523074535.249802-22-hch@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 May 2023 20:36:51 +0200
Message-ID: <CAJZ5v0grAY02dx__4=ezxT=HuPU=2gD6bErV2fYTQiv5mRL1yg@mail.gmail.com>
Subject: Re: [PATCH 21/24] PM: hibernate: don't use early_lookup_bdev in resume_store
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

On Tue, May 23, 2023 at 9:46 AM Christoph Hellwig <hch@lst.de> wrote:
>
> resume_store is a sysfs attribute written during normal kernel runtime,
> and it should not use the early_lookup_bdev API that bypasses all normal
> path based permission checking, and might cause problems with certain
> container environments renaming devices.
>
> Switch to lookup_bdev, which does a normal path lookup instead, and fall
> back to trying to parse a numeric dev_t just like early_lookup_bdev did.
>
> Note that this strictly speaking changes the kernel ABI as the PARTUUID=
> and PARTLABEL= style syntax is now not available during a running
> systems.  They never were intended for that, but this breaks things
> we'll have to figure out a way to make them available again.  But if
> avoidable in any way I'd rather avoid that.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Fixes: 421a5fa1a6cf ("PM / hibernate: use name_to_dev_t to parse resume")

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  kernel/power/hibernate.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index c52dedb9f7c8e8..7ae95ec72f9902 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -1178,7 +1178,23 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
>         if (!name)
>                 return -ENOMEM;
>
> -       error = early_lookup_bdev(name, &dev);
> +       error = lookup_bdev(name, &dev);
> +       if (error) {
> +               unsigned maj, min, offset;
> +               char *p, dummy;
> +
> +               if (sscanf(name, "%u:%u%c", &maj, &min, &dummy) == 2 ||
> +                   sscanf(name, "%u:%u:%u:%c", &maj, &min, &offset,
> +                               &dummy) == 3) {
> +                       dev = MKDEV(maj, min);
> +                       if (maj != MAJOR(dev) || min != MINOR(dev))
> +                               error = -EINVAL;
> +               } else {
> +                       dev = new_decode_dev(simple_strtoul(name, &p, 16));
> +                       if (*p)
> +                               error = -EINVAL;
> +               }
> +       }
>         kfree(name);
>         if (error)
>                 return error;
> --
> 2.39.2
>
