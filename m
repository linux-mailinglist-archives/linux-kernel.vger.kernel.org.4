Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B11A6819AD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbjA3Sve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbjA3Sv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:51:29 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ED7303D7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:51:24 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id p26so23400480ejx.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBkAm4zVJTkI3qBxAXOEQ1EcRECNJLIbKTv33w41KUw=;
        b=6hImNi5y9+HbavaiLhfzhSmHuu69foTET7ZxMDVWwRehdai1xhy5dymInWtE/xJiZt
         IZccKmZfaaFScoyNc0mAvMoAOVq3POCg5Ajr94fB8JVMvcHCXL0XcrDVD2RA4huxz7h+
         F0eLdcWdS13nTsyTpSb6gyxq83rGfmOeJDuUHeJolthUUJOegWW2BJxbTIJbC3NVhFmU
         +dCazKM0QGc2nXJNOa7JcDUbsNEOwfDmzKfc/uExA+ajcscIR6RQmDM7q/R05ncrMxF7
         tKvrAoTgUTYenUDibOW+Dt2w8mXi5DShvMZ4E6UAJRpq1jJVctMIlxK2lWVpZNVa2sq5
         1PDQ==
X-Gm-Message-State: AO0yUKWsmJNxjmoyzY9dpPeFgFePN7VXgquXvB1S5HbHD7ei0X/iMUQZ
        HeCwaW3euW5iUcB3zc8fpRYzjGrvfgyELLOGgFz6+tI9
X-Google-Smtp-Source: AK7set8BeGxBKY/GvU+XVYJX/VkZoH6wP7dK4M8sgqfc+Xq3bHzA8G6kogPHfWNGu9g/xE0hdWgZaDBhAv3fzMmNVhs=
X-Received: by 2002:a17:906:95d7:b0:88a:30dc:5730 with SMTP id
 n23-20020a17090695d700b0088a30dc5730mr902001ejy.25.1675104682790; Mon, 30 Jan
 2023 10:51:22 -0800 (PST)
MIME-Version: 1.0
References: <20230130171059.1784057-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230130171059.1784057-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Jan 2023 19:51:11 +0100
Message-ID: <CAJZ5v0jjSoNchvdDacQjakscsSK6d535Ruqd=OR_nYz4nMNwVQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: soc: remove layering violation for the soc_bus
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
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

On Mon, Jan 30, 2023 at 7:49 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The soc_bus code pokes around in the internal bus structures assuming
> that it "knows" if a field is not set that it has not been registered
> yet.  That isn't a safe assumption, so just remove the layering
> violation entirely and keep track if the bus has been registered or not
> ourselves.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/soc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
> index 22130b5f789d..0fb1d4ab9d8a 100644
> --- a/drivers/base/soc.c
> +++ b/drivers/base/soc.c
> @@ -30,6 +30,7 @@ struct soc_device {
>  static struct bus_type soc_bus_type = {
>         .name  = "soc",
>  };
> +static bool soc_bus_registered;
>
>  static DEVICE_ATTR(machine,            0444, soc_info_show,  NULL);
>  static DEVICE_ATTR(family,             0444, soc_info_show,  NULL);
> @@ -117,7 +118,7 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
>         const struct attribute_group **soc_attr_groups;
>         int ret;
>
> -       if (!soc_bus_type.p) {
> +       if (!soc_bus_registered) {
>                 if (early_soc_dev_attr)
>                         return ERR_PTR(-EBUSY);
>                 early_soc_dev_attr = soc_dev_attr;
> @@ -183,6 +184,7 @@ static int __init soc_bus_register(void)
>         ret = bus_register(&soc_bus_type);
>         if (ret)
>                 return ret;
> +       soc_bus_registered = true;
>
>         if (early_soc_dev_attr)
>                 return PTR_ERR(soc_device_register(early_soc_dev_attr));
> --
> 2.39.1
>
