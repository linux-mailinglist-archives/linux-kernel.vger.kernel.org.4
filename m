Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E7D6D22F4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjCaOuI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 10:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjCaOuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:50:03 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45F81BF74
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:50:01 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id cn12so90653241edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680274200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syebFilsfNeEFu55k4xWWOzQOPuiXAMHIbvfLQ2A9OI=;
        b=lRIAadkDNaRB8B08dKqkzaIHTcFSjd25SSBtVnFk4olAYZa+EBYYkUTkEs3KQ9x7G+
         M3qTxw/l1GQZzQdvA9+d3Ea9lBs1+dztVLwddwmzPvXVVA066m3bz97FWHfSu0PKmvJJ
         NRGnzwzXgfUyri/Qeuno58Kz75hSJIAsX/hkaPp1g8hIRQfzsFR+EuELdEgobhYHk1/w
         TCDMRFiPyZNhDp1AufpUsn0jfC9SEtFgZ14L6TXJBPHBDd3fwzdKwgHzQvRbGHMeqt6+
         HKjo0zowWD8PDFhrrsTmakEj/0+Z6krWtIpgGbzLhBn41/iD+cksyOKUQJmKn0f5QVta
         eGjg==
X-Gm-Message-State: AAQBX9dTeWPUaMN5vXqnF4Qr8UVUFgmcg7rGlLYqIzHpD7daw9dJ+9zO
        jzBRU6x+oqRUnXMGSUa1RK5c7LAZ4wsoKIdBThOKUw13qso=
X-Google-Smtp-Source: AKy350arWe8gwZqemsHbQgs9rdKMmHUDQbK4CS1oHOCQaRfOLYE9Ivi7NIgB+4CHP+DxTnhzdU9AygkQvyq+9UZ1k2k=
X-Received: by 2002:a17:907:3e8b:b0:931:ce20:db6e with SMTP id
 hs11-20020a1709073e8b00b00931ce20db6emr15295923ejc.2.1680274200318; Fri, 31
 Mar 2023 07:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230331093318.82288-1-gregkh@linuxfoundation.org> <20230331093318.82288-4-gregkh@linuxfoundation.org>
In-Reply-To: <20230331093318.82288-4-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 16:49:49 +0200
Message-ID: <CAJZ5v0gu1=RNg3NH41puwqtQbg9dPMj3sj8qcXMzevqWTv=nfw@mail.gmail.com>
Subject: Re: [PATCH 4/7] driver core: clean up the logic to determine which
 /sys/dev/ directory to use
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

On Fri, Mar 31, 2023 at 11:33 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When a dev_t is set in a struct device, an symlink in /sys/dev/ is
> created for it either under /sys/dev/block/ or /sys/dev/char/ depending
> on the device type.
>
> The logic to determine this would trigger off of the class of the
> object, and the kobj_type set in that location.  But it turns out that
> this deep nesting isn't needed at all, as it's either a choice of block
> or "everything else" which is a char device.  So make the logic a lot
> more simple and obvious, and remove the incorrect comments in the code
> that tried to document something that was not happening at all (it is
> impossible to set class->dev_kobj to NULL as the class core prevented
> that from happening.
>
> This removes the only place that class->dev_kobj was being used, so
> after this, it can be removed entirely.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I like this.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/base.h     | 10 ++++++++++
>  drivers/base/core.c     | 22 ++++------------------
>  drivers/base/devtmpfs.c |  9 ---------
>  3 files changed, 14 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 6296164bb7f3..4660e1159ee0 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -209,6 +209,16 @@ int devtmpfs_init(void);
>  static inline int devtmpfs_init(void) { return 0; }
>  #endif
>
> +#ifdef CONFIG_BLOCK
> +extern struct class block_class;
> +static inline bool is_blockdev(struct device *dev)
> +{
> +       return dev->class == &block_class;
> +}
> +#else
> +static inline bool is_blockdev(struct device *dev) { return false; }
> +#endif
> +
>  /* Device links support */
>  int device_links_read_lock(void);
>  void device_links_read_unlock(int idx);
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index e3bc34fcf779..dbc2ba6dfffc 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3430,27 +3430,13 @@ int dev_set_name(struct device *dev, const char *fmt, ...)
>  }
>  EXPORT_SYMBOL_GPL(dev_set_name);
>
> -/**
> - * device_to_dev_kobj - select a /sys/dev/ directory for the device
> - * @dev: device
> - *
> - * By default we select char/ for new entries.  Setting class->dev_obj
> - * to NULL prevents an entry from being created.  class->dev_kobj must
> - * be set (or cleared) before any devices are registered to the class
> - * otherwise device_create_sys_dev_entry() and
> - * device_remove_sys_dev_entry() will disagree about the presence of
> - * the link.
> - */
> +/* select a /sys/dev/ directory for the device */
>  static struct kobject *device_to_dev_kobj(struct device *dev)
>  {
> -       struct kobject *kobj;
> -
> -       if (dev->class)
> -               kobj = dev->class->dev_kobj;
> +       if (is_blockdev(dev))
> +               return sysfs_dev_block_kobj;
>         else
> -               kobj = sysfs_dev_char_kobj;
> -
> -       return kobj;
> +               return sysfs_dev_char_kobj;
>  }
>
>  static int device_create_sys_dev_entry(struct device *dev)
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index ae72d4ba8547..b848764ef018 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -94,15 +94,6 @@ static struct file_system_type dev_fs_type = {
>         .mount = public_dev_mount,
>  };
>
> -#ifdef CONFIG_BLOCK
> -static inline int is_blockdev(struct device *dev)
> -{
> -       return dev->class == &block_class;
> -}
> -#else
> -static inline int is_blockdev(struct device *dev) { return 0; }
> -#endif
> -
>  static int devtmpfs_submit_req(struct req *req, const char *tmp)
>  {
>         init_completion(&req->done);
> --
> 2.40.0
>
