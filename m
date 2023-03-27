Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275B76CAA69
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjC0QTw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 12:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjC0QTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:19:25 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EEC199A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:18:59 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id er18so27239354edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679933916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heYbHNQfEN7S9sOX/eUUSP2pPGVNkRdC0D6uHjeWTDU=;
        b=o0FI8qX6QVx750uqe0WtjRk5hXXdQQHoOy4mj4KXEg+Gs/bBWGdiQBb8y7IL8RYNJn
         BgT/5aDvnvvvx75nqOErt/A5d1q8hlrA1CgJFw1BQ8xxgF50MlS7OnG2hBIH96vwb4Qm
         XOgxENr+rfA5Nq86+ThbnB/EE2sNpYwtdJ8UEjqTNFx2Wq7Z5ZRUIdruSz6MVn8RirEA
         3XQLK85qHqbDndOlpVIeOw4hO2we/6sYXKKkeNZTOoN8EJD4t2rQzzUHD7QzcaFkn7rg
         Q2sVC3HQhDV1iVsPxhCp2HeNf10MJD9T/+fLFL+lAVgjRAzWj+vRtbg0oh+sMBBKwQH+
         CB+Q==
X-Gm-Message-State: AAQBX9dmdQqguOxnufQeqqfaQmyqx+jmq4wCO3nMYG2P/eKxaUWLbb+h
        OyHuW4fii1AbWMPn2f5idl5dpxFJlFZacQGFZVo=
X-Google-Smtp-Source: AKy350akqV8OiIdtnx6tGUo9j+P2mzwsc0LofO121pXrdAYXGLjOJhjKr+Q/hPFIs28483L4N/lIBGsnc2gRhA4HzSI=
X-Received: by 2002:a17:907:3e8b:b0:931:ce20:db6e with SMTP id
 hs11-20020a1709073e8b00b00931ce20db6emr6713871ejc.2.1679933916087; Mon, 27
 Mar 2023 09:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230327160319.513974-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230327160319.513974-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 18:18:25 +0200
Message-ID: <CAJZ5v0hZjCJK0JVQ431+CcnNSKebcunHFkMcgdYXVyPRSVwQ4A@mail.gmail.com>
Subject: Re: [PATCH] driver core: move sysfs_dev_char_kobj out of class.h
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 6:03 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The structure sysfs_dev_char_kobj is local only to the driver core code,
> so move it out of the global class.h file and into the internal base.h
> file as no one else should be touching this symbol.

Good idea.

> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/base.h          | 3 +++
>  include/linux/device/class.h | 1 -
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 6659cf1d3a44..6296164bb7f3 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -191,6 +191,9 @@ const char *device_get_devnode(const struct device *dev, umode_t *mode,
>  extern struct kset *devices_kset;
>  void devices_kset_move_last(struct device *dev);
>
> +/* /sys/dev/char directory */
> +extern struct kobject *sysfs_dev_char_kobj;
> +
>  #if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)
>  void module_add_driver(struct module *mod, struct device_driver *drv);
>  void module_remove_driver(struct device_driver *drv);
> diff --git a/include/linux/device/class.h b/include/linux/device/class.h
> index af7fefc39364..f7aad64e256a 100644
> --- a/include/linux/device/class.h
> +++ b/include/linux/device/class.h
> @@ -79,7 +79,6 @@ struct class_dev_iter {
>  };
>
>  extern struct kobject *sysfs_dev_block_kobj;
> -extern struct kobject *sysfs_dev_char_kobj;
>
>  int __must_check class_register(struct class *class);
>  void class_unregister(const struct class *class);
> --
> 2.40.0
>
