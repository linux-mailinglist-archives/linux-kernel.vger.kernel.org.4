Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73AD742A25
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjF2P7y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 11:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjF2P7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:59:12 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DB63595;
        Thu, 29 Jun 2023 08:58:13 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-991f9148334so24439866b.1;
        Thu, 29 Jun 2023 08:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688054292; x=1690646292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qetn1nrmN6G9CR9gXQ9Em61uIidpmKRRe6NZOrRfh0=;
        b=lNG9G60gMCUko3fblYwJRCr878uyFS69Ao5koexf7EwvMx2rv7Ikf/LjkFxoIQqYLx
         8/wiDe1c8pUNpkkBp+QcMVhRI0MkAXcpcSt8EtcSAEV83ZY3kebGIm1bBdkWggr35rl0
         gvJ3UJrVZ7WrGxiLZYvED9vPI5CX2aTOeUTo8xbPcdZB0dmnBhPyQZAp+LaQXEv23hWG
         gmmsm8Qb7njJFuXixyZgQooUodcEGuqlAnzryaqHbjZsrlSMVUhs1C4osXSj4dhkPJcX
         JcjLPP/ZiPC0yz2z5Fvx3dKIh1X4mLpovKs/GAMZ05P4yrgbiKL98Zjh+03qVdYMuon1
         +xgA==
X-Gm-Message-State: AC+VfDySib5EMGJK3qw//uA03IHtrxUcJy9upCN0tLaE/Zk1GEGo3PVi
        fkvQ2wSn84MH65VkGfhrCSU2TT8rPjDiFOoEVg4=
X-Google-Smtp-Source: ACHHUZ7+pEVSf5OQUS/L9yOGMCIw+NnHEsH8WFpD3o92yk1tDC27bL5HKJgEqqmZ2HElw6dwaudN/vgTvTilF1g5RzA=
X-Received: by 2002:a17:906:6493:b0:987:6960:36c5 with SMTP id
 e19-20020a170906649300b00987696036c5mr27088527ejm.6.1688054291833; Thu, 29
 Jun 2023 08:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230616165034.3630141-1-michal.wilczynski@intel.com> <20230616165034.3630141-5-michal.wilczynski@intel.com>
In-Reply-To: <20230616165034.3630141-5-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jun 2023 17:58:00 +0200
Message-ID: <CAJZ5v0hZ-2Ee0DCcgzHJrOikRTOJuCbEbQj24xui_-vmbd+47Q@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] acpi/video: Move handler installing logic to driver
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        lenb@kernel.org, dave.jiang@intel.com, ira.weiny@intel.com,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
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

On Fri, Jun 16, 2023 at 6:51 PM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> Currently logic for installing notifications from ACPI devices is
> implemented using notify callback in struct acpi_driver. Preparations
> are being made to replace acpi_driver with more generic struct
> platform_driver, which doesn't contain notify callback. Furthermore
> as of now handlers are being called indirectly through
> acpi_notify_device(), which decreases performance.
>
> Call acpi_dev_install_notify_handler() at the end of .add() callback.
> Call acpi_dev_remove_notify_handler() at the beginning of .remove()
> callback. Change arguments passed to the notify function to match with
> what's required by acpi_install_notify_handler(). Remove .notify
> callback initialization in acpi_driver.
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/acpi/acpi_video.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 62f4364e4460..60b7013d0009 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -77,7 +77,7 @@ static DEFINE_MUTEX(video_list_lock);
>  static LIST_HEAD(video_bus_head);
>  static int acpi_video_bus_add(struct acpi_device *device);
>  static void acpi_video_bus_remove(struct acpi_device *device);
> -static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
> +static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data);
>
>  /*
>   * Indices in the _BCL method response: the first two items are special,
> @@ -104,7 +104,6 @@ static struct acpi_driver acpi_video_bus = {
>         .ops = {
>                 .add = acpi_video_bus_add,
>                 .remove = acpi_video_bus_remove,
> -               .notify = acpi_video_bus_notify,
>                 },
>  };
>
> @@ -1527,12 +1526,15 @@ static int acpi_video_bus_stop_devices(struct acpi_video_bus *video)
>                                   acpi_osi_is_win8() ? 0 : 1);
>  }
>
> -static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
> +static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
>  {
> -       struct acpi_video_bus *video = acpi_driver_data(device);
> +       struct acpi_device *device = data;
> +       struct acpi_video_bus *video;
>         struct input_dev *input;
>         int keycode = 0;
>
> +       video = acpi_driver_data(device);
> +
>         if (!video || !video->input)
>                 return;
>
> @@ -2053,8 +2055,20 @@ static int acpi_video_bus_add(struct acpi_device *device)
>
>         acpi_video_bus_add_notify_handler(video);
>
> +       error = acpi_dev_install_notify_handler(device,
> +                                               ACPI_DEVICE_NOTIFY,
> +                                               acpi_video_bus_notify);
> +       if (error)
> +               goto err_remove_and_unregister_video;

This label name is a bit too long and the second half of it doesn't
really add any value IMV.  err_remove would be sufficient.

> +
>         return 0;
>
> +err_remove_and_unregister_video:
> +       mutex_lock(&video_list_lock);
> +       list_del(&video->entry);
> +       mutex_unlock(&video_list_lock);
> +       acpi_video_bus_remove_notify_handler(video);
> +       acpi_video_bus_unregister_backlight(video);
>  err_put_video:
>         acpi_video_bus_put_devices(video);
>         kfree(video->attached_array);
> @@ -2075,6 +2089,10 @@ static void acpi_video_bus_remove(struct acpi_device *device)
>
>         video = acpi_driver_data(device);
>
> +       acpi_dev_remove_notify_handler(device,
> +                                      ACPI_DEVICE_NOTIFY,
> +                                      acpi_video_bus_notify);
> +
>         mutex_lock(&video_list_lock);
>         list_del(&video->entry);
>         mutex_unlock(&video_list_lock);
> --
> 2.41.0
>
