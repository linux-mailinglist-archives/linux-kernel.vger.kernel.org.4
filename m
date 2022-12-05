Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7198C642A50
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiLEOYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLEOXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:23:47 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972AD1F0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:23:45 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id c15so11455228qtw.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 06:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3qjWL09FsuqRLCLvjaoUewvnT/RryaRCNj0Vg5qmUo=;
        b=QEQw6nudTlEL0LUirmxc1RruNyGqGPzTgiA2yS208YtOvAMmgFZaR0MI8/6wOpXy7x
         k1H6CYcQzSq7+TBBZFQPeXxQB8vSixB/HmxQY8JxUlR0JKwCQOIOyq3MjDBefkNNn1vk
         /1rmK6BQ0gUlWUbbb9k2Md9z1toE1ZIvclL43VRgVjtTBdeIe+N865J9zq3EW+ZGsiuw
         dAyckP/3fAkRuEOZ8xHjGNteADuaiPGsqAD49KBV7roVcyLi76Y+a7Ftt9fV0zckzBjc
         JBrSk5UJIXf/qruu8beVzVuqgF13tOHEaX3iy2Rsszbbiiixl56+1rEnf9yH7cx/1bTN
         WzwQ==
X-Gm-Message-State: ANoB5pm2A28UUqZg4Wo80VWt3yS5prRIQxfmCCr45cKR0YNp4OOmIYfH
        tw7BBNGk3UTsOAfiS8kWlw/WU+cNmrcfdLeq5QU=
X-Google-Smtp-Source: AA0mqf7IyUxO2QzWD+ZPm6uCM4EPEz/694WfUOqcd/gcyeaoaImn9lupPgieisuZel+3PnqHouImKs0R8AZEmqWhv3k=
X-Received: by 2002:a05:622a:1989:b0:3a5:7cf8:1a6e with SMTP id
 u9-20020a05622a198900b003a57cf81a6emr76783274qtc.48.1670250224736; Mon, 05
 Dec 2022 06:23:44 -0800 (PST)
MIME-Version: 1.0
References: <20221205121206.166576-1-gregkh@linuxfoundation.org> <20221205121206.166576-4-gregkh@linuxfoundation.org>
In-Reply-To: <20221205121206.166576-4-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Dec 2022 15:23:33 +0100
Message-ID: <CAJZ5v0iBoitix-Y=wAO7x-Xzjm5KAb_W6sp03tT+cgEpwXE_fw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] firmware_loader: fix up to_fw_sysfs() to preserve const
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Russ Weight <russell.h.weight@intel.com>
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

On Mon, Dec 5, 2022 at 1:12 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> to_fw_sysfs() was changed in commit 23680f0b7d7f ("driver core: make
> struct class.dev_uevent() take a const *") to pass in a const pointer
> but not pass it back out to handle some changes in the driver core.
> That isn't the best idea as it could cause problems if used incorrectly,
> so switch to use the container_of_const() macro instead which will
> preserve the const status of the pointer and enforce it by the compiler.
>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Russ Weight <russell.h.weight@intel.com>
> Fixes: 23680f0b7d7f ("driver core: make struct class.dev_uevent() take a const *")
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> v2: - respin with changed container_of_const() parameters
>
>  drivers/base/firmware_loader/sysfs.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/base/firmware_loader/sysfs.h b/drivers/base/firmware_loader/sysfs.h
> index fd0b4ad9bdbb..2060add8ef81 100644
> --- a/drivers/base/firmware_loader/sysfs.h
> +++ b/drivers/base/firmware_loader/sysfs.h
> @@ -80,11 +80,7 @@ struct fw_sysfs {
>         struct firmware *fw;
>         void *fw_upload_priv;
>  };
> -
> -static inline struct fw_sysfs *to_fw_sysfs(const struct device *dev)
> -{
> -       return container_of(dev, struct fw_sysfs, dev);
> -}
> +#define to_fw_sysfs(__dev)     container_of_const(__dev, struct fw_sysfs, dev)
>
>  void __fw_load_abort(struct fw_priv *fw_priv);
>
> --
> 2.38.1
>
