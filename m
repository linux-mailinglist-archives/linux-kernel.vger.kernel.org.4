Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A9F63213E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiKULuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiKULue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:50:34 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE52520341
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:50:33 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id k2so6635837qvo.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:50:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vM9IytLH07S9l82QF9h03u/KdFe4rcZrcYs4tSHSYN8=;
        b=NKcXR9FjcUeORPb72kEelYMicf3DS88evWDwAqfvjLU3YKob08KPTv2JoZu9f1BITR
         73Ko/kYUAn+57Gx0bu4B58DWDRZsVm+I0FbVNnUuG7P8vHJSnpyf399kYF3FG7+OGaDK
         Zfy1ujaPYrsf9bZPYD4ZIRhpgCcN1wW26amidhVvVlL6/0N6ysdXBoGBc2ytrGZg1an6
         6HoTTcjTdIuBGtPhfOx6IaF+43FMplbtXg8XkLu88d6kcMtpAp/1Ow6LXrYcKVMtORlp
         fNK4b5cGEEyDtv64OFCyrXOM9tLm43Q7O5T6HCK1+KDgs4SpUB6XoOZvSnc//rCghiyb
         NIRg==
X-Gm-Message-State: ANoB5pkG5HbAigV+MYdL4LiaOHxxE0be/JMFugz9jwO3bnvSxBADGcgv
        kTDGJCNR3bZetjd1iOTXI6KJxiifA1RUo8EnbB0=
X-Google-Smtp-Source: AA0mqf5a1KfP8eLw51/njf3NsZatGLM3tJI8a0m2WJuhIsFmB8vljZkah9i1LnYCRd5I9/NjA1cL6Kq5v8sFuRTR6z4=
X-Received: by 2002:ad4:534b:0:b0:4b1:8429:a8a7 with SMTP id
 v11-20020ad4534b000000b004b18429a8a7mr1180085qvs.52.1669031433042; Mon, 21
 Nov 2022 03:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20221121094649.1556002-1-gregkh@linuxfoundation.org> <20221121094649.1556002-4-gregkh@linuxfoundation.org>
In-Reply-To: <20221121094649.1556002-4-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Nov 2022 12:50:18 +0100
Message-ID: <CAJZ5v0h6S_CNnKULDrA3OyL5weQEJ2wE5-rnza3qBYxsMWAVsg@mail.gmail.com>
Subject: Re: [PATCH 4/5] kobject: kset_uevent_ops: make name() callback take a
 const *
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 10:47 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The name() callback in struct kset_uevent_ops does not modify the
> kobject passed into it, so make the pointer const to enforce this
> restriction.  When doing so, fix up the single existing name() callback
> to have the correct signature to preserve the build.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/core.c     | 4 ++--
>  include/linux/kobject.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 005a2b092f3e..a3e14143ec0c 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2376,9 +2376,9 @@ static int dev_uevent_filter(const struct kobject *kobj)
>         return 0;
>  }
>
> -static const char *dev_uevent_name(struct kobject *kobj)
> +static const char *dev_uevent_name(const struct kobject *kobj)
>  {
> -       struct device *dev = kobj_to_dev(kobj);
> +       const struct device *dev = kobj_to_dev(kobj);
>
>         if (dev->bus)
>                 return dev->bus->name;
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index 640f59d4b3de..58a5b75612e3 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -136,7 +136,7 @@ struct kobj_uevent_env {
>
>  struct kset_uevent_ops {
>         int (* const filter)(const struct kobject *kobj);
> -       const char *(* const name)(struct kobject *kobj);
> +       const char *(* const name)(const struct kobject *kobj);
>         int (* const uevent)(struct kobject *kobj, struct kobj_uevent_env *env);
>  };
>
> --
> 2.38.1
>
