Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE99863696C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbiKWTA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239234AbiKWTA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:00:26 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359D58FE5C;
        Wed, 23 Nov 2022 11:00:25 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id a27so11820373qtw.10;
        Wed, 23 Nov 2022 11:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+l0igR7hKkTKvvyys2qs4E7Aer7/krdWL5FOFxNPBAA=;
        b=ZDF5LN1+8Lifv+6tWI7k2p7BPj6et5YZPAdk8IvAoCxxSk4HyuBPS10HQbxrMGlHxk
         HPIBrkQkw9hdHwgHMwLlSWinUbyx/Ykg7I4Hsm8tbjul5luFRh3a87b2mKPWPoDN9j/t
         vDfTpq5dmNjENzJ+9mbIdH227V8cOx8Wt4DtZcmxY1lUnEDzB5Kx5DbktsxS6UCSMzgv
         i31xoo4h6BxEpb9+FmmRCzGGfrnEoL5QXu8BId+s1McNcdFiJoXCUZsSb9FhmhIjslhf
         4bpjHghsEXe8E6QQCjs15pnYON9/QU305Y5lEHwNb1kgIXVOy/+NMMaQOqDkCovrZSxl
         /ibQ==
X-Gm-Message-State: ANoB5pnsTFAbN2noX+59hpRShTKaXR18aTgtiQVYV7mnmoVrJCUTBlyj
        vrLTcNiia3utsm4e0dsxZBIBuRZkj8tR/th4o0U=
X-Google-Smtp-Source: AA0mqf7sI46tBXUWpLMXE8nVVH+hrIVtKuUyfa7scQxb2RDvbes27xd11ZfVW6gU3JWJVLyfie0RMtF+aCRX4qGnxPA=
X-Received: by 2002:ac8:60d3:0:b0:3a5:4678:5b24 with SMTP id
 i19-20020ac860d3000000b003a546785b24mr27555628qtm.411.1669230024997; Wed, 23
 Nov 2022 11:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20221112094048.3614365-1-yangyingliang@huawei.com>
In-Reply-To: <20221112094048.3614365-1-yangyingliang@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Nov 2022 20:00:14 +0100
Message-ID: <CAJZ5v0g6bct5pTruxHjjJPQpwDNR8WgqhLWaZWo8NKeRH3n6iw@mail.gmail.com>
Subject: Re: [PATCH] powercap: fix possible name leak while device_register() fails
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 10:42 AM Yang Yingliang
<yangyingliang@huawei.com> wrote:
>
> If device_register() returns error, the name allocated by
> dev_set_name() need be freed. In technical, we should call
> put_device() to give up the reference and free the name in
> driver core, but in some cases the device is not intizalized,
> put_device() can not be called, so don't complicate the code,
> just call kfree_const() to free name in the error path.
>
> Fixes: 75d2364ea0ca ("PowerCap: Add class driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/powercap/powercap_sys.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
> index f0654a932b37..11e742dc83b9 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -572,6 +572,7 @@ struct powercap_zone *powercap_register_zone(
>  err_name_alloc:
>         idr_remove(power_zone->parent_idr, power_zone->id);
>  err_idr_alloc:
> +       kfree_const(dev_name(&power_zone->dev));
>         if (power_zone->allocated)
>                 kfree(power_zone);
>         mutex_unlock(&control_type->lock);
> @@ -622,6 +623,7 @@ struct powercap_control_type *powercap_register_control_type(
>         dev_set_name(&control_type->dev, "%s", name);
>         result = device_register(&control_type->dev);
>         if (result) {
> +               kfree_const(dev_name(&control_type->dev));

Why is it necessary to free a device name explicitly after a failing
device_register()?

If it is really necessary, then there is a problem in
device_register() itself AFAICS, because it uses dev_set_name() at
least in the dev->init_name present case.

>                 if (control_type->allocated)
>                         kfree(control_type);
>                 return ERR_PTR(result);
> --
