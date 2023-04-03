Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196DF6D4FAF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjDCR4V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Apr 2023 13:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjDCR4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:56:17 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9FC19BB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:56:03 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id x3so120559301edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680544562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjUZAHF9xnS/YninJVRSTfjnx68cBz9ynBDb+CwMU28=;
        b=BJBdlql0zGY0WJdjjFMR9lFP3bD9oAGKrtZgoyoVnpG769SnjOAkDrLhODdKIM40Qm
         dg5/2Hw6aPfOifhtQ4oImktPFQEiy492uTpq8KQMqbNjN+S0E0XzQi1pmve4NfQlDp+i
         aIf/Xfx844e1nwugGe8GkrfhIn7BZGiBm/L91ouXq8mrwK5U8YsOKbGtd5t696dlCWgM
         ls09T4BD1ASxshGehMZQREwM902Zw7pKHvOit3a8btG97UA1RAq7Tf5FjKUzHR8G+lQ4
         W4odZyh8M58tjPoMv0Rblmj4fSjRNH6YrNCYNoETuWVPymFhbhwYo9X/pLdpBIdBo8Ul
         Pasg==
X-Gm-Message-State: AAQBX9fwIaOar49SXiEaA5MhPmOnm31Phn9C6upZi1K+vkcGsgDYwsZb
        Tw+YYc980BR043cb63wZLV9L758KhLwhqgqDydg=
X-Google-Smtp-Source: AKy350bxGJebw3jDyIJbvyLp1B8v/b+FVSmIG3czIeiwx3/GW8dcIFPmqzkKBUYBW1CEV7e7pUeks5wrHuQL+HOjPL0=
X-Received: by 2002:a50:9f89:0:b0:4fb:c8e3:1adb with SMTP id
 c9-20020a509f89000000b004fbc8e31adbmr47095edf.3.1680544561672; Mon, 03 Apr
 2023 10:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <2023040244-duffel-pushpin-f738@gregkh> <2023040248-outrage-obsolete-5a9a@gregkh>
In-Reply-To: <2023040248-outrage-obsolete-5a9a@gregkh>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Apr 2023 19:55:50 +0200
Message-ID: <CAJZ5v0iULFnO7Ap3xXWGLJbdL3M33p9wzmHv=xp4g7iCfmPfqg@mail.gmail.com>
Subject: Re: [PATCH 1/5] driver core: class: mark class_release() as taking a
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
> The struct class callback, class_release(), is only called in 2 places,
> the pcmcia cardservices code, and in the class driver core code.  Both
> places it is safe to mark the structure as a const *, to allow us to
> in the future mark all struct class usages as constant and move into
> read-only memory.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/class.c         | 2 +-
>  drivers/pcmcia/cs.c          | 2 +-
>  include/linux/device/class.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index 65502bd7d5c5..53fc7052340c 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -235,7 +235,7 @@ void class_unregister(const struct class *cls)
>  }
>  EXPORT_SYMBOL_GPL(class_unregister);
>
> -static void class_create_release(struct class *cls)
> +static void class_create_release(const struct class *cls)
>  {
>         pr_debug("%s called for %s\n", __func__, cls->name);
>         kfree(cls);
> diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
> index e3224e49c43f..5658745c398f 100644
> --- a/drivers/pcmcia/cs.c
> +++ b/drivers/pcmcia/cs.c
> @@ -824,7 +824,7 @@ static int pcmcia_socket_uevent(const struct device *dev,
>
>  static struct completion pcmcia_unload;
>
> -static void pcmcia_release_socket_class(struct class *data)
> +static void pcmcia_release_socket_class(const struct class *data)
>  {
>         complete(&pcmcia_unload);
>  }
> diff --git a/include/linux/device/class.h b/include/linux/device/class.h
> index 7e4a1a6329f4..f3c418fa129a 100644
> --- a/include/linux/device/class.h
> +++ b/include/linux/device/class.h
> @@ -58,7 +58,7 @@ struct class {
>         int (*dev_uevent)(const struct device *dev, struct kobj_uevent_env *env);
>         char *(*devnode)(const struct device *dev, umode_t *mode);
>
> -       void (*class_release)(struct class *class);
> +       void (*class_release)(const struct class *class);
>         void (*dev_release)(struct device *dev);
>
>         int (*shutdown_pre)(struct device *dev);
> --
> 2.40.0
>
