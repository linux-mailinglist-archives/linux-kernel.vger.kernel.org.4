Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A5B6A4230
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjB0NE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjB0NE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:04:27 -0500
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E8A9752
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:04:26 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id ee7so25555169edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeakewSvoTrri3R4W0qg/KkIdPobixgJ6jfXkFBCQm8=;
        b=2gl+/3oNj8YHjMe5m8cwFCQvIGdPiANxTSZyPcEmhqJm5RkcwSxrGI2qhpmH9iAcvs
         o1oZ3WumVo026ydYfua591IIAoNX31pAprj++Sv+/7TZiODE2d2w43SNxxxnLBWVDTx/
         EddisyZhKoZYk0GA/Vbvfc5IY/gSsXv9TjCmrdnmQTD4OAHGFNNd6ZIaFbpnLHFN7jbl
         E7N/ZkJ4U9OV/P/B1fqV6jS/0+Z3EFHJlixbVOoe/q4Q7S80AqebL7NzvzgB+kxF7M2Q
         weyV22/dD4EHJlqEBAN5pYFGu6jy6yrR1KzePzZh+CqvGPQvNK7NBBZn2gPppCBMA7EV
         8cNw==
X-Gm-Message-State: AO0yUKXq6+jn+2cUywZOrRFF/+tM2lgeQqUSQgJCMm7AfkcyOT+ryT05
        DpeFtgGGCShI/qyifdK4IqhFkJOIraFTSU2sjzg=
X-Google-Smtp-Source: AK7set9osPw45kOmhQyAm/xxmQf673f0iaFQ4yCTfK8no1bKD4W35Hmv0zBFVCl/gbl9FnOKcj1YIzo1tSqaEFZyltk=
X-Received: by 2002:a50:d51d:0:b0:4ac:b618:7fb1 with SMTP id
 u29-20020a50d51d000000b004acb6187fb1mr11665003edi.6.1677503065120; Mon, 27
 Feb 2023 05:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20230225065443.278284-1-saravanak@google.com>
In-Reply-To: <20230225065443.278284-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Feb 2023 14:04:10 +0100
Message-ID: <CAJZ5v0jFDAG7GaTLAMA0m=jvZRE-Gp4+iLoe-JjOfEXta9F1kA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: fw_devlink: Print full path and name of fwnode
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
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

On Sat, Feb 25, 2023 at 7:54 AM Saravana Kannan <saravanak@google.com> wrote:
>
> Some of the log messages were printing just the fwnode name. While it's
> short, it's not always uniquely identifiable in system. So print the
> full path and name to make debugging easier.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4f02a10f802f..44a2f6596e54 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -98,7 +98,7 @@ static int __fwnode_link_add(struct fwnode_handle *con,
>
>         list_add(&link->s_hook, &sup->consumers);
>         list_add(&link->c_hook, &con->suppliers);
> -       pr_debug("%pfwP Linked as a fwnode consumer to %pfwP\n",
> +       pr_debug("%pfwf Linked as a fwnode consumer to %pfwf\n",
>                  con, sup);
>
>         return 0;
> @@ -122,7 +122,7 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
>   */
>  static void __fwnode_link_del(struct fwnode_link *link)
>  {
> -       pr_debug("%pfwP Dropping the fwnode link to %pfwP\n",
> +       pr_debug("%pfwf Dropping the fwnode link to %pfwf\n",
>                  link->consumer, link->supplier);
>         list_del(&link->s_hook);
>         list_del(&link->c_hook);
> @@ -1104,7 +1104,7 @@ int device_links_check_suppliers(struct device *dev)
>                 if (!dev_is_best_effort(dev)) {
>                         fwnode_ret = -EPROBE_DEFER;
>                         dev_err_probe(dev, -EPROBE_DEFER,
> -                                   "wait for supplier %pfwP\n", sup_fw);
> +                                   "wait for supplier %pfwf\n", sup_fw);
>                 } else {
>                         fwnode_ret = -EAGAIN;
>                 }
> --
> 2.39.2.637.g21b0678d19-goog
>
