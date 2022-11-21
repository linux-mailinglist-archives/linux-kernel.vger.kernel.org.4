Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E5E63213D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiKULue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiKULuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:50:13 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A4029808
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:50:12 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id d18so4296368qvs.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPRFFDX3sukLa+H8slFSfV4bRc1zyJQTvoCuAInx6IY=;
        b=Q0G3THeXjDq7gq8CZS4lZDCyBv1RkMyWppyWTuB61qfiswgdqQEkYnQN+dmD7uZWlV
         jafxV6fLkfXYRa6RMsadQzMq+g/S9A7qv/p0l2k6MgMa0vKu4N+SiZAz5OfYUvkelI6P
         uX653AR3N03vmf4CUlGXCQnSKqUNT6SoVvfHsa6w8Bxqpj5/++CB6Yayy5DmpEQJ2Gg4
         8qZmP4gDT+twUjDTQI5NiUjw8h2TK+DDcm48730vlJHtr5GnxKTqy0/MjfoCqpzNandq
         2XabSiW7t7NVq/VL2MU+jfjf1B8N/lXZezbZKR6aPIwUMNkcoy8aFQtGofNXMHoNBPCb
         tayQ==
X-Gm-Message-State: ANoB5pmgmyrFr6p1Kii33TqHwTa5FLfJFNQlrljIe386HBsUxIJaLlp4
        J0k5nfmzsTFG7wW3nDH8zJiN1D9b0XRpa4yxBaBDcShI3UY=
X-Google-Smtp-Source: AA0mqf6FDzINKHpNjIj/oCDhtBMmufnAaE4Y2hiR8KcpM9BLPiP953f6WGEk4FsaM333r7AHPBK9F/nv3+5d+I+2ia4=
X-Received: by 2002:a05:6214:558e:b0:4c0:8055:fb5 with SMTP id
 mi14-20020a056214558e00b004c080550fb5mr17280305qvb.73.1669031411616; Mon, 21
 Nov 2022 03:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20221121094649.1556002-1-gregkh@linuxfoundation.org> <20221121094649.1556002-2-gregkh@linuxfoundation.org>
In-Reply-To: <20221121094649.1556002-2-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Nov 2022 12:49:56 +0100
Message-ID: <CAJZ5v0iNDXhFMP5CK_ZNBm5AXZ1cWkAUfeGbfXFZeJr5RjNFTw@mail.gmail.com>
Subject: Re: [PATCH 2/5] kobject: make kobject_namespace take a const *
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Mon, Nov 21, 2022 at 10:46 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> kobject_namespace() should take a const *kobject as it does not modify
> the kobject passed to it.  Change that, and the functions
> kobj_child_ns_ops() and kobj_ns_ops() needed to also be changed to const
> *.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  include/linux/kobject.h    | 2 +-
>  include/linux/kobject_ns.h | 4 ++--
>  lib/kobject.c              | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index d978dbceb50d..5a2d58e10bf5 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -112,7 +112,7 @@ extern struct kobject * __must_check kobject_get_unless_zero(
>                                                 struct kobject *kobj);
>  extern void kobject_put(struct kobject *kobj);
>
> -extern const void *kobject_namespace(struct kobject *kobj);
> +extern const void *kobject_namespace(const struct kobject *kobj);
>  extern void kobject_get_ownership(const struct kobject *kobj,
>                                   kuid_t *uid, kgid_t *gid);
>  extern char *kobject_get_path(const struct kobject *kobj, gfp_t flag);
> diff --git a/include/linux/kobject_ns.h b/include/linux/kobject_ns.h
> index 2b5b64256cf4..be707748e7ce 100644
> --- a/include/linux/kobject_ns.h
> +++ b/include/linux/kobject_ns.h
> @@ -47,8 +47,8 @@ struct kobj_ns_type_operations {
>
>  int kobj_ns_type_register(const struct kobj_ns_type_operations *ops);
>  int kobj_ns_type_registered(enum kobj_ns_type type);
> -const struct kobj_ns_type_operations *kobj_child_ns_ops(struct kobject *parent);
> -const struct kobj_ns_type_operations *kobj_ns_ops(struct kobject *kobj);
> +const struct kobj_ns_type_operations *kobj_child_ns_ops(const struct kobject *parent);
> +const struct kobj_ns_type_operations *kobj_ns_ops(const struct kobject *kobj);
>
>  bool kobj_ns_current_may_mount(enum kobj_ns_type type);
>  void *kobj_ns_grab_current(enum kobj_ns_type type);
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 26e744a46d24..6e0bf03f4f36 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -25,7 +25,7 @@
>   * and thus @kobj should have a namespace tag associated with it.  Returns
>   * %NULL otherwise.
>   */
> -const void *kobject_namespace(struct kobject *kobj)
> +const void *kobject_namespace(const struct kobject *kobj)
>  {
>         const struct kobj_ns_type_operations *ns_ops = kobj_ns_ops(kobj);
>
> @@ -1039,7 +1039,7 @@ int kobj_ns_type_registered(enum kobj_ns_type type)
>         return registered;
>  }
>
> -const struct kobj_ns_type_operations *kobj_child_ns_ops(struct kobject *parent)
> +const struct kobj_ns_type_operations *kobj_child_ns_ops(const struct kobject *parent)
>  {
>         const struct kobj_ns_type_operations *ops = NULL;
>
> @@ -1049,7 +1049,7 @@ const struct kobj_ns_type_operations *kobj_child_ns_ops(struct kobject *parent)
>         return ops;
>  }
>
> -const struct kobj_ns_type_operations *kobj_ns_ops(struct kobject *kobj)
> +const struct kobj_ns_type_operations *kobj_ns_ops(const struct kobject *kobj)
>  {
>         return kobj_child_ns_ops(kobj->parent);
>  }
> --
> 2.38.1
>
