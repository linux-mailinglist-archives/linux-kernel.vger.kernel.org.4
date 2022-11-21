Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11484632138
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiKULtt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Nov 2022 06:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiKULtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:49:42 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1942871B;
        Mon, 21 Nov 2022 03:49:40 -0800 (PST)
Received: by mail-qk1-f174.google.com with SMTP id x18so7786993qki.4;
        Mon, 21 Nov 2022 03:49:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lbzYkmJhxm5C+/5IVFkRr+sFHYjfyy9aJrVSznookE=;
        b=FroeX4zcqIGR8MG5kdyM2yOek4t2ISFjlMCX+MD0MxP920Z+p1tHkfhAA9ZX84LPZK
         nuL8w3hp52Pktp+52q05QWzsVZdjC8w9uv5AehGoWOu7J2TMSWWQ/63jdfUMDR60w3j+
         eamsBDp3mEvNSYeQ9tY3gId0Q0zr5BCkLKH9qhOioD52qGAVcVLSqBr3yLFW6ZdB/a6L
         OsJjT30JsB7DEduh47h494Udt2kDltynkFymoDkxQ3QAyIxu5AITzcxP412RBh1OBJhs
         1FfXm00TdrOxHvEBcux5BvilW3GxVVYYX9UexBuGiPKNveuH5faPBgHb/phYSVv6dUU4
         2axg==
X-Gm-Message-State: ANoB5plS5hQVWRy1CrN2bkYCpK6SrqJ7ZFpkrkqQdoi8v2P6MH4/kV0K
        47rN2yef3Rma/0XgvngnfOVvL39PKFTZV/U4OKc=
X-Google-Smtp-Source: AA0mqf46epIs+NcHJYD6sFzeJoDiCU0QUrd8rQyiq1r2eQjiNS7/0XOCN53oHWUTPo5MxqAfEsJksRoUxCgj+R4BG3Y=
X-Received: by 2002:a05:620a:4611:b0:6fa:af7e:927c with SMTP id
 br17-20020a05620a461100b006faaf7e927cmr15551057qkb.443.1669031379745; Mon, 21
 Nov 2022 03:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20221121094649.1556002-1-gregkh@linuxfoundation.org> <20221121094649.1556002-3-gregkh@linuxfoundation.org>
In-Reply-To: <20221121094649.1556002-3-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Nov 2022 12:49:25 +0100
Message-ID: <CAJZ5v0j=HLEdKUhHjWGd8NTNLYW4n1q4OAKer-EZSufgX0ujeQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] kobject: kset_uevent_ops: make filter() callback take
 a const *
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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
> The filter() callback in struct kset_uevent_ops does not modify the
> kobject passed into it, so make the pointer const to enforce this
> restriction.  When doing so, fix up all existing filter() callbacks to
> have the correct signature to preserve the build.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: linux-media@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linaro-mm-sig@lists.linaro.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/bus.c                    | 2 +-
>  drivers/base/core.c                   | 4 ++--
>  drivers/dma-buf/dma-buf-sysfs-stats.c | 2 +-
>  include/linux/kobject.h               | 2 +-
>  kernel/params.c                       | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 7ca47e5b3c1f..4ec6dbab73be 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -163,7 +163,7 @@ static struct kobj_type bus_ktype = {
>         .release        = bus_release,
>  };
>
> -static int bus_uevent_filter(struct kobject *kobj)
> +static int bus_uevent_filter(const struct kobject *kobj)
>  {
>         const struct kobj_type *ktype = get_ktype(kobj);
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index a79b99ecf4d8..005a2b092f3e 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2362,12 +2362,12 @@ static struct kobj_type device_ktype = {
>  };
>
>
> -static int dev_uevent_filter(struct kobject *kobj)
> +static int dev_uevent_filter(const struct kobject *kobj)
>  {
>         const struct kobj_type *ktype = get_ktype(kobj);
>
>         if (ktype == &device_ktype) {
> -               struct device *dev = kobj_to_dev(kobj);
> +               const struct device *dev = kobj_to_dev(kobj);
>                 if (dev->bus)
>                         return 1;
>                 if (dev->class)
> diff --git a/drivers/dma-buf/dma-buf-sysfs-stats.c b/drivers/dma-buf/dma-buf-sysfs-stats.c
> index 2bba0babcb62..f69d68122b9b 100644
> --- a/drivers/dma-buf/dma-buf-sysfs-stats.c
> +++ b/drivers/dma-buf/dma-buf-sysfs-stats.c
> @@ -132,7 +132,7 @@ void dma_buf_stats_teardown(struct dma_buf *dmabuf)
>
>
>  /* Statistics files do not need to send uevents. */
> -static int dmabuf_sysfs_uevent_filter(struct kobject *kobj)
> +static int dmabuf_sysfs_uevent_filter(const struct kobject *kobj)
>  {
>         return 0;
>  }
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index 5a2d58e10bf5..640f59d4b3de 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -135,7 +135,7 @@ struct kobj_uevent_env {
>  };
>
>  struct kset_uevent_ops {
> -       int (* const filter)(struct kobject *kobj);
> +       int (* const filter)(const struct kobject *kobj);
>         const char *(* const name)(struct kobject *kobj);
>         int (* const uevent)(struct kobject *kobj, struct kobj_uevent_env *env);
>  };
> diff --git a/kernel/params.c b/kernel/params.c
> index 5b92310425c5..d2237209ceda 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -926,7 +926,7 @@ static const struct sysfs_ops module_sysfs_ops = {
>         .store = module_attr_store,
>  };
>
> -static int uevent_filter(struct kobject *kobj)
> +static int uevent_filter(const struct kobject *kobj)
>  {
>         const struct kobj_type *ktype = get_ktype(kobj);
>
> --
> 2.38.1
>
