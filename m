Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF39665826
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbjAKJx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238742AbjAKJx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:53:27 -0500
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FD2F0A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:51:03 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id s5so21505045edc.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpFo+O8qS7NH3jrF08AXi3xEDczSSjFjrCll7MZBd7o=;
        b=hOVAVOp2ZcnT77ct62gCnmgsUf2nI54Ac+ZA2RYqvsrm02YK38MohATC+gwGWgLvSf
         uHTMTAg04fMQLwGdTtlcFgWjPqpmhnt3uy0wyA6biR2zufmXPtpCXIo2TOiXLV9x10En
         HSDVCUDuCl9zfaV5BszQZG2dJhhEKpvxRwrgN9SKczIBL3KBbDunTcsYi/J19BA7fuzO
         rtd6+yArxDvaCp056sAXh/8eX3Zo+Gv92kAI4R68YT+mz0e6iIzCcBFRlDuts5xtvwTt
         ejiarBQEdsYaTzOjEBe9f1+dzT4WE6NUOqxW99/R4D32AN/1qwPP24ufNBxD/qb6Z4hO
         BvWg==
X-Gm-Message-State: AFqh2kpOBwr/b/2lkbINuAhiklH4y4wWlaIyiImqOXEGymZqu+vYD3CR
        +BOutgHi4NfTFk9z/O7W+/xJGzNpWH+/yHtOzKdN5YxuBHM=
X-Google-Smtp-Source: AMrXdXuRiZLKSgkQVxn1xTUcieSKQlliXk42T2ogw0cYWyEXGcVjQDzR0cv8FYXPwFJQJu4tErDft0CfQoq7s4gS63Y=
X-Received: by 2002:a05:6402:c44:b0:499:c651:625d with SMTP id
 cs4-20020a0564020c4400b00499c651625dmr665628edb.413.1673430661871; Wed, 11
 Jan 2023 01:51:01 -0800 (PST)
MIME-Version: 1.0
References: <20230111093327.3955063-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230111093327.3955063-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 Jan 2023 10:50:49 +0100
Message-ID: <CAJZ5v0jDb9gbXNc8oeW4poPh_MQydOqjyfgWmDehfTeG_5F8uA@mail.gmail.com>
Subject: Re: [PATCH] driver core: change to_subsys_private() to use container_of_const()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 10:33 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The macro to_subsys_private() needs to switch to using
> container_of_const() as it turned out to being incorrectly casting a
> const pointer to a non-const one.  Make this change and fix up the one
> offending user to be correctly handling a const pointer properly.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/base.h  | 2 +-
>  drivers/base/class.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 2e08258ce82e..3d1da1027206 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -53,7 +53,7 @@ struct subsys_private {
>         struct kset glue_dirs;
>         struct class *class;
>  };
> -#define to_subsys_private(obj) container_of(obj, struct subsys_private, subsys.kobj)
> +#define to_subsys_private(obj) container_of_const(obj, struct subsys_private, subsys.kobj)
>
>  struct driver_private {
>         struct kobject kobj;
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index 86ec554cfe60..3366da9c3ff6 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -64,7 +64,7 @@ static void class_release(struct kobject *kobj)
>
>  static const struct kobj_ns_type_operations *class_child_ns_type(const struct kobject *kobj)
>  {
> -       struct subsys_private *cp = to_subsys_private(kobj);
> +       const struct subsys_private *cp = to_subsys_private(kobj);
>         struct class *class = cp->class;
>
>         return class->ns_type;
> --
> 2.39.0
>
