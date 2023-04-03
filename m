Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AEC6D4FBC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjDCR5h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Apr 2023 13:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjDCR5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:57:23 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FB140C7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:57:13 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id cn12so120693605edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680544632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JD74zvu5PhDi9TeO5OaVRzWLRZY1j9Wulq+9wskASto=;
        b=lMh+eeWjpvTmuEQVxs4NF2CDxOiQFY9xw5J++3sbXvTnm5asu1V/U2n5FpZYxgFYXf
         LV1NWRHnBjv1WsqoCEA/CvaFnEEGamIsgYVYBFNq+biGv5XfIBwaIFakwLfqG5wQ4faV
         OKNdnOQMONPqG/qpOtjmOEyvVNDtADVyxRpYF5yq/id5JaxcaQoOqnh8mXImvVVzWaIH
         cdReAa0uWk419GkwG0jXZrxvYjUme7K1IgHP9eaqDz/swf7JlnXruw7f6adXQu+iDeIx
         PRFkFQIzcpgSZfs7luIWLWJrHQhG6yAd9rZepY8/HVPYSe4moGl6c2vxV5JSK5heKnVG
         EExA==
X-Gm-Message-State: AAQBX9ciZyy0FXiaFly5PiHuvbJjaA+4XdlGam8WREI2RASxnD4nHBiO
        y8bSqcUAdmKcg9S8dg3YPolQcKlQgEFYW8tyxJ8=
X-Google-Smtp-Source: AKy350aWH+7epuP8/TDN+Zq5JP+yyeahagpujfx8F3WN5d8baUAK5/N28NR8RSW4zaKweUNpbjSIegGzkwu9GVUmq4A=
X-Received: by 2002:a50:bac1:0:b0:4fa:3c0b:74b with SMTP id
 x59-20020a50bac1000000b004fa3c0b074bmr52259ede.3.1680544632141; Mon, 03 Apr
 2023 10:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <2023040244-duffel-pushpin-f738@gregkh> <2023040248-customary-release-4aec@gregkh>
In-Reply-To: <2023040248-customary-release-4aec@gregkh>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Apr 2023 19:57:01 +0200
Message-ID: <CAJZ5v0hiqqKaBd3vDu74V9KwJY6J_w2iLuc_shb+C-LBaArxaA@mail.gmail.com>
Subject: Re: [PATCH 2/5] driver core: class: make class_register() take a
 const *
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
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

On Sun, Apr 2, 2023 at 7:59 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Now that the class code is cleaned up to not modify the class pointer
> registered with it, change class_register() to take a const * to allow
> the structure to be placed into read-only memory.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/base.h          | 2 +-
>  drivers/base/class.c         | 6 +++---
>  include/linux/device/class.h | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index e96f3343fd7c..eb4c0ace9242 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -54,7 +54,7 @@ struct subsys_private {
>         struct device *dev_root;
>
>         struct kset glue_dirs;
> -       struct class *class;
> +       const struct class *class;
>
>         struct lock_class_key lock_key;
>  };
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index 53fc7052340c..05bce79d3d19 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -93,7 +93,7 @@ static ssize_t class_attr_store(struct kobject *kobj, struct attribute *attr,
>  static void class_release(struct kobject *kobj)
>  {
>         struct subsys_private *cp = to_subsys_private(kobj);
> -       struct class *class = cp->class;
> +       const struct class *class = cp->class;
>
>         pr_debug("class '%s': release.\n", class->name);
>
> @@ -110,7 +110,7 @@ static void class_release(struct kobject *kobj)
>  static const struct kobj_ns_type_operations *class_child_ns_type(const struct kobject *kobj)
>  {
>         const struct subsys_private *cp = to_subsys_private(kobj);
> -       struct class *class = cp->class;
> +       const struct class *class = cp->class;
>
>         return class->ns_type;
>  }
> @@ -175,7 +175,7 @@ static void klist_class_dev_put(struct klist_node *n)
>         put_device(dev);
>  }
>
> -int class_register(struct class *cls)
> +int class_register(const struct class *cls)
>  {
>         struct subsys_private *cp;
>         struct lock_class_key *key;
> diff --git a/include/linux/device/class.h b/include/linux/device/class.h
> index f3c418fa129a..4bf46f9bbb56 100644
> --- a/include/linux/device/class.h
> +++ b/include/linux/device/class.h
> @@ -76,7 +76,7 @@ struct class_dev_iter {
>         const struct device_type        *type;
>  };
>
> -int __must_check class_register(struct class *class);
> +int __must_check class_register(const struct class *class);
>  void class_unregister(const struct class *class);
>  bool class_is_registered(const struct class *class);
>
> --
> 2.40.0
>
