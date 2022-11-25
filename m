Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9FF63900A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 19:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiKYSpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 13:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKYSpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:45:34 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2432545ECC;
        Fri, 25 Nov 2022 10:45:33 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id h24so2988062qta.9;
        Fri, 25 Nov 2022 10:45:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVnYr+yRHxw7HWghSQNQQghN0tldZQ4+ZOhhs+c595w=;
        b=LAhVU1SJdEqS6lSb4k6n+oxLjqzB3WBNEisiZqT5830TPbUo1+/ZwjKCYXFBwsR0f+
         f/7LCMECGqz8SRPxn5x1DQBJmyp/TTdXHQWWkVizSoMhiV1rtZLLEnv8xNz86nZbuc0T
         AkRPR9KoiamqaG8DXFw6qZs7FM0El+1s9xWmTCnuKH8gN8NU4KW9A2MEUUAXoPdlu/Rr
         Pvjy6DymFav/bODjmQULtg9pe6B5mBtWjEiorL74JOX4tE1rmZa9aCLakWXqYmbMpEPA
         BkqTDrPW4IdpBcklf17+/QrdngGHn1SisDBY18tNo/AuGgDMLurAzor92auBf/aA9vLc
         0o4w==
X-Gm-Message-State: ANoB5pkVv9Od87Xap/9Hr58pUis5W6PANGzifCBocugpM8/eyNFL4lKq
        VZa09XUcjo3TAw5+YiTbt1yxAVCtLgorNgNYzZU=
X-Google-Smtp-Source: AA0mqf7pZVddib+OvYk4FWSEsX10juR9fJpwuUq+tcQQmF+OpBMeEd9dyFDoObmDSDj2qk3A+42WM9Rt+mHZMc0ltjg=
X-Received: by 2002:ac8:1482:0:b0:3a5:1e6f:7e05 with SMTP id
 l2-20020ac81482000000b003a51e6f7e05mr19373259qtj.357.1669401932242; Fri, 25
 Nov 2022 10:45:32 -0800 (PST)
MIME-Version: 1.0
References: <20221112094048.3614365-1-yangyingliang@huawei.com>
 <CAJZ5v0g6bct5pTruxHjjJPQpwDNR8WgqhLWaZWo8NKeRH3n6iw@mail.gmail.com>
 <Y35zwffl7bUdjs93@kroah.com> <b4fe247b-0980-40ea-bc69-0430e3b18320@huawei.com>
In-Reply-To: <b4fe247b-0980-40ea-bc69-0430e3b18320@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Nov 2022 19:45:21 +0100
Message-ID: <CAJZ5v0j+M79zD4Tsskkpsq8gyFQ8enjoZh-f54qOu1Rs_5tojA@mail.gmail.com>
Subject: Re: [PATCH] powercap: fix possible name leak while device_register() fails
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Nov 24, 2022 at 3:16 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
>
> On 2022/11/24 3:25, Greg Kroah-Hartman wrote:
> > On Wed, Nov 23, 2022 at 08:00:14PM +0100, Rafael J. Wysocki wrote:
> >> On Sat, Nov 12, 2022 at 10:42 AM Yang Yingliang
> >> <yangyingliang@huawei.com> wrote:
> >>> If device_register() returns error, the name allocated by
> Sorry,
> I didn't describe clearly here, it's not only after device_register()
> failure, but also in the error path before register, the name is not
> freed, see description below.

So you would need to update the changelog at least.  But see below.

> >>> dev_set_name() need be freed. In technical, we should call
> >>> put_device() to give up the reference and free the name in
> >>> driver core, but in some cases the device is not intizalized,
> >>> put_device() can not be called, so don't complicate the code,
> >>> just call kfree_const() to free name in the error path.
> >>>
> >>> Fixes: 75d2364ea0ca ("PowerCap: Add class driver")
> >>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> >>> ---
> >>>   drivers/powercap/powercap_sys.c | 2 ++
> >>>   1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
> >>> index f0654a932b37..11e742dc83b9 100644
> >>> --- a/drivers/powercap/powercap_sys.c
> >>> +++ b/drivers/powercap/powercap_sys.c
> >>> @@ -572,6 +572,7 @@ struct powercap_zone *powercap_register_zone(
> >>>   err_name_alloc:
> >>>          idr_remove(power_zone->parent_idr, power_zone->id);
> >>>   err_idr_alloc:
> >>> +       kfree_const(dev_name(&power_zone->dev));
> >>>          if (power_zone->allocated)
> >>>                  kfree(power_zone);
> >>>          mutex_unlock(&control_type->lock);
> >>> @@ -622,6 +623,7 @@ struct powercap_control_type *powercap_register_control_type(
> >>>          dev_set_name(&control_type->dev, "%s", name);
> >>>          result = device_register(&control_type->dev);
> >>>          if (result) {
> >>> +               kfree_const(dev_name(&control_type->dev));
> >> Why is it necessary to free a device name explicitly after a failing
> >> device_register()?
> powercap_register_zone()
> {
>      ...
>      dev_set_name() // allocate name
>      ...
>      if (!power_zone->constraints)
>          goto err_const_alloc; //the name is leaked in this path
>      ...
>      if (!power_zone->zone_dev_attrs)
>          goto err_attr_alloc; //the name is leaked in this path
>      ...
>      if (result)
>          goto err_dev_ret; //the name is leaked in this path
>
>      result = device_register(&power_zone->dev);
>      if (result)
>          goto err_dev_ret;//put_device() is not called, the name is
> leaked in this path
>      ...
> err_dev_ret:
>      kfree(power_zone->zone_dev_attrs);
> err_attr_alloc:
>      kfree(power_zone->constraints);
> err_const_alloc:
>      kfree(power_zone->name);
> err_name_alloc:
>      idr_remove(power_zone->parent_idr, power_zone->id);
> err_idr_alloc:
>      if (power_zone->allocated)
>          kfree(power_zone);
> }

So can't the dev_set_name() be reordered closer to device_register(),
so it is not necessary to worry about freeing the name?

> >>
> >> If it is really necessary, then there is a problem in
> >> device_register() itself AFAICS, because it uses dev_set_name() at
> >> least in the dev->init_name present case.
> When the dev_set_name() called in device_register(), if register fails, the
> name is freed in its error path. But in this case, dev_set_name() is called
> outside the register, it needs call put_device() to free the name.

In any case, device_register() needs to take care of it anyway,
because it uses dev_set_name() itself in the dev->init_name case,
doesn't it?
