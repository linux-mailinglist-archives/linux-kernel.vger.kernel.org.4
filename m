Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CF46640F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbjAJMxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbjAJMwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:52:39 -0500
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFD91659E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:52:38 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id ss4so21051529ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=637ubBSOoI1GiDl8Awhbjdf5a7u9yVKCckNI3WnUQtY=;
        b=xcFuwC/2l6tZLPKaO2L0garXhVNRYD4j+KHfNhCRKGwUdAG0oD9dHtdL4SAvgHzaHr
         jbx8azQu+7kPgwL3YtpdUF/UPV0o0i25FA6E6v2J567TjcfyPMrHFztjHlVivUdDC527
         hpA5YZX/dYOoVF8Fnm+aMoLh70Rs1xTPMHHpuMhvHisyMwFQOK7M5zh4mEmNTpuV+I1m
         oS5gXv9E2pJGRfBap8CUV9S65nBJeMBKA5HFc+3y5Gbo5sRM+Jr2A/9CaqgUDlD0Zhoc
         CLoT9g88becI/pmUPjgLOpn1XET3GNFbEfZviD0S0Cglp7f8V4N3NaOK5srvVMJwTawx
         scxw==
X-Gm-Message-State: AFqh2kpI6XntGLz8Z/gI5cP2u1Xk+xQKp5TGT/CdlgQLnOwJiTwLzI7j
        lGcRGptMd/nE3gn9XjXKVQNVwZGuu4cb2CStPqw=
X-Google-Smtp-Source: AMrXdXtJW7xAs+v9mRoS2wwUcy+kTOIeuPBR3D4ivws20vhJx/MP0Q4Jm0viYnM+0dANt+OLg4Nt3J5dw4DAUWjUlRs=
X-Received: by 2002:a17:907:98ee:b0:7c1:5ff0:6cc2 with SMTP id
 ke14-20020a17090798ee00b007c15ff06cc2mr4918608ejc.246.1673355156631; Tue, 10
 Jan 2023 04:52:36 -0800 (PST)
MIME-Version: 1.0
References: <20230110124256.1663859-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230110124256.1663859-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jan 2023 13:52:24 +0100
Message-ID: <CAJZ5v0g63jNzqsnvg_UC7aBhX9_aNT=s=K9JpU9x8UpfoJ=dXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] driver core: bus.h: document bus notifiers better
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 1:43 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The bus notifier values are not documented all that well, so clean this
> up and make a real enumerated type for them and document them much
> better.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/linux/device/bus.h | 43 +++++++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index d529f644e92b..1e1a593348bc 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -257,21 +257,36 @@ extern int bus_register_notifier(struct bus_type *bus,
>  extern int bus_unregister_notifier(struct bus_type *bus,
>                                    struct notifier_block *nb);
>
> -/* All 4 notifers below get called with the target struct device *
> - * as an argument. Note that those functions are likely to be called
> - * with the device lock held in the core, so be careful.
> +/**
> + * enum bus_notifier_event: Bus Notifier events that have happened
> + *
> + * These are the value passed to a bus notifier when a specific event happens.
> + *
> + * Note that bus notifiers are likely to be called with the device lock already
> + * held by the driver core, so be careful in any notifier callback as to what
> + * you do with the device structure.
> + *
> + * All bus notifiers are called with the target struct device * as an argument.
> + *
> + * BUS_NOTIFY_ADD_DEVICE: device is added to this bus
> + * BUS_NOTIFY_DEL_DEVICE: device is about to be removed from this bus
> + * BUS_NOTIFY_REMOVED_DEVICE: device is successfully removed from this bus
> + * BUS_NOTIFY_BIND_DRIVER: a driver is about to be bound to this device on this bus
> + * BUS_NOTIFY_BOUND_DRIVER: a driver is successfully bound to this device on this bus
> + * BUS_NOTIFY_UNBIND_DRIVER: a driver is about to be unbound from this device on this bus
> + * BUS_NOTIFY_UNBOUND_DRIVER: a driver is successfully unbound from this device on this bus
> + * BUS_NOTIFY_DRIVER_NOT_BOUND: a driver failed to be bound to this device on this bus
>   */
> -#define BUS_NOTIFY_ADD_DEVICE          0x00000001 /* device added */
> -#define BUS_NOTIFY_DEL_DEVICE          0x00000002 /* device to be removed */
> -#define BUS_NOTIFY_REMOVED_DEVICE      0x00000003 /* device removed */
> -#define BUS_NOTIFY_BIND_DRIVER         0x00000004 /* driver about to be
> -                                                     bound */
> -#define BUS_NOTIFY_BOUND_DRIVER                0x00000005 /* driver bound to device */
> -#define BUS_NOTIFY_UNBIND_DRIVER       0x00000006 /* driver about to be
> -                                                     unbound */
> -#define BUS_NOTIFY_UNBOUND_DRIVER      0x00000007 /* driver is unbound
> -                                                     from the device */
> -#define BUS_NOTIFY_DRIVER_NOT_BOUND    0x00000008 /* driver fails to be bound */
> +enum bus_notifier_event {
> +       BUS_NOTIFY_ADD_DEVICE =         0x00000001,
> +       BUS_NOTIFY_DEL_DEVICE =         0x00000002,
> +       BUS_NOTIFY_REMOVED_DEVICE =     0x00000003,
> +       BUS_NOTIFY_BIND_DRIVER =        0x00000004,
> +       BUS_NOTIFY_BOUND_DRIVER =       0x00000005,
> +       BUS_NOTIFY_UNBIND_DRIVER =      0x00000006,
> +       BUS_NOTIFY_UNBOUND_DRIVER =     0x00000007,
> +       BUS_NOTIFY_DRIVER_NOT_BOUND =   0x00000008,

I'm wondering why the values are in hex (the 0x prefix doesn't matter
for these numbers AFAICS) and what the initial zeros are for (AFAICS
they don't matter either).

> +};
>
>  extern struct kset *bus_get_kset(struct bus_type *bus);
>
> --
