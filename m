Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2024C69672D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjBNOmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjBNOmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:42:51 -0500
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A802D7C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:42:49 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id bt8so11901291edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rhOH1JA55Lqc0pn8Hdascl+o8gx2osvZYrcNUFcrJQ=;
        b=BD927OHZtWema0h21XTJgHPSwKxaOczvhPCb6do3zGqCdSpV7DDUIUXSOovATmg4uL
         2114DSo+jM1mWHr1YYzOTfX+/pMUMlCRfKZprzaHI+SGnydcEYo8Qf2YOTexT6QxdVcn
         LUEAK/+33HKQ6Qc5GmsgxgRe/5KUuESO7uwkjefqirctCGhxmTuPA9me69P9OMY3Ssm8
         WmjCY/G/W8ikq1WuraMdLwMB2DgBFcnVJDXHqYoGo3kMSEUtJC8+oZeDdUOXJI5abG+b
         D7r24iFEWQ2myJMt9bBXZKkMf3EEF+z6zTMLk1Mn4g4Qt6e69C1a1U5ZWIe+o05CyEMA
         lkYQ==
X-Gm-Message-State: AO0yUKWJDx2DD/ItQe62db10ofFSm4sp7LnDlhLp5gZVClKZJn2n+O3u
        vv71xZBwMGdMDhz97Ddxs7qKJgLW4lW9YTcpKkc=
X-Google-Smtp-Source: AK7set8RwBLXbrSHzcXkug3zQIOt1dKVvylV64SqGZXj/Ux/1fQOfOo3n8MGHvSlzClXSfuf25+NC1Un2BGRA/wl/wM=
X-Received: by 2002:a50:9fc7:0:b0:4ab:1686:1134 with SMTP id
 c65-20020a509fc7000000b004ab16861134mr1257199edf.3.1676385768335; Tue, 14 Feb
 2023 06:42:48 -0800 (PST)
MIME-Version: 1.0
References: <20230214144117.158956-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230214144117.158956-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Feb 2023 15:42:37 +0100
Message-ID: <CAJZ5v0gi1VdxHvWdrmFYq4vQzbXnPpUhJa144wozp5Oaaz4yLQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: class: move EXPORT_SYMBOL_GPL() lines to the
 correct place
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 3:41 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> For some reason, the drivers/base/class.c file still had the "old style"
> of exports, at the end of the file.  Move the exports to the proper
> location, right after the function, to be correct.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/class.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index 89d4528fcc1a..2373b3e210d8 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -99,6 +99,7 @@ int class_create_file_ns(struct class *cls, const struct class_attribute *attr,
>                 error = -EINVAL;
>         return error;
>  }
> +EXPORT_SYMBOL_GPL(class_create_file_ns);
>
>  void class_remove_file_ns(struct class *cls, const struct class_attribute *attr,
>                           const void *ns)
> @@ -106,6 +107,7 @@ void class_remove_file_ns(struct class *cls, const struct class_attribute *attr,
>         if (cls)
>                 sysfs_remove_file_ns(&cls->p->subsys.kobj, &attr->attr, ns);
>  }
> +EXPORT_SYMBOL_GPL(class_remove_file_ns);
>
>  static struct class *class_get(struct class *cls)
>  {
> @@ -213,6 +215,7 @@ void class_unregister(struct class *cls)
>         class_remove_groups(cls, cls->class_groups);
>         kset_unregister(&cls->p->subsys);
>  }
> +EXPORT_SYMBOL_GPL(class_unregister);
>
>  static void class_create_release(struct class *cls)
>  {
> @@ -276,6 +279,7 @@ void class_destroy(struct class *cls)
>
>         class_unregister(cls);
>  }
> +EXPORT_SYMBOL_GPL(class_destroy);
>
>  /**
>   * class_dev_iter_init - initialize class device iterator
> @@ -460,6 +464,7 @@ int class_interface_register(struct class_interface *class_intf)
>
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(class_interface_register);
>
>  void class_interface_unregister(struct class_interface *class_intf)
>  {
> @@ -482,6 +487,7 @@ void class_interface_unregister(struct class_interface *class_intf)
>
>         class_put(parent);
>  }
> +EXPORT_SYMBOL_GPL(class_interface_unregister);
>
>  ssize_t show_class_attr_string(struct class *class,
>                                struct class_attribute *attr, char *buf)
> @@ -588,11 +594,3 @@ int __init classes_init(void)
>                 return -ENOMEM;
>         return 0;
>  }
> -
> -EXPORT_SYMBOL_GPL(class_create_file_ns);
> -EXPORT_SYMBOL_GPL(class_remove_file_ns);
> -EXPORT_SYMBOL_GPL(class_unregister);
> -EXPORT_SYMBOL_GPL(class_destroy);
> -
> -EXPORT_SYMBOL_GPL(class_interface_register);
> -EXPORT_SYMBOL_GPL(class_interface_unregister);
> --
> 2.39.1
>
