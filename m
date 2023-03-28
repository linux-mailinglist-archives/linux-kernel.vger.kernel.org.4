Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D2F6CC122
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjC1Nix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjC1Nit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:38:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27897A267
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680010685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ELZOPdZ9ahXmREqv/BhJUnUwXaKs9loNrBEDp7bMYI=;
        b=OestE+2TGetQZyR7Jlo7XYf6FQADQo6qFszn4HQWt5j43dSR5NinEnCLGrGa9WPtD/usry
        Puk7oDoQ383dy4hRRApsYi9h+8ATvby5YHpee7o/mHTfFZMXnoRl5RUFR/EzJvIAB7RSWj
        CTmZ3+RWH5uPqjOe2GXAZ6GF9g4ereE=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-vbzgAAeFOymMt1_4f9soFg-1; Tue, 28 Mar 2023 09:37:56 -0400
X-MC-Unique: vbzgAAeFOymMt1_4f9soFg-1
Received: by mail-vs1-f72.google.com with SMTP id v3-20020a67c003000000b00426a55c5f90so2107065vsi.15
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680010676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ELZOPdZ9ahXmREqv/BhJUnUwXaKs9loNrBEDp7bMYI=;
        b=46YdACN+nCRiCj96eqiq2mmUUfdOKENr9nWeSHXvApvxsvBCAyGVP1KCSidv5+jNCh
         9Rl703BMY2m/7qGKOUYJSYmtAyes5cvqPnJhZnFIwwjxteyi/kYWphEaXp8ZGJM2dkGa
         O5ZYVeK0xP5OuW75xAYiv9AvE3sBfu2IbPivFWpkCBkFjPQ6eB5PKrQIWBF8MWL/M1ND
         pcMNmLTG0pYHqGPyGy5ql/n7b6aNBoqL6B36uX2tpFy5JQRBZTgnso0RPY+CGBf4QjmE
         wVXAaZmWm92g5flRmniTqohc441p3f+Hmx7dTVWwzEDbMn/G6jbbTUSbzodCWp4sO8Ld
         JqLw==
X-Gm-Message-State: AAQBX9czzO44lEi8NUL03diGSIjHJNIBfsxH8c/jB9wG3MlXGkg+Xdy/
        c3atIqKZhEU9IxQH5oB24DZ/o4q5mXmypyRp1MQNGg+pHe1VXBiYJBRnE0tJvyyjngrHPJSZ1o6
        B2mtqMfX9FrFb/+aqQXkb7/5EnN0SVNJbgzz7BDD4
X-Received: by 2002:a67:e019:0:b0:414:4ef3:839 with SMTP id c25-20020a67e019000000b004144ef30839mr8886922vsl.7.1680010676038;
        Tue, 28 Mar 2023 06:37:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350bzHkjamopCB/emRy4NpYC/2MwLux+aQLEq3yqt9nVX8wJmaY8K25Ik9PrNlj0PPs8GQigV6hE6mUYphSPV40A=
X-Received: by 2002:a67:e019:0:b0:414:4ef3:839 with SMTP id
 c25-20020a67e019000000b004144ef30839mr8886911vsl.7.1680010675788; Tue, 28 Mar
 2023 06:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st> <20230328-soc-mailbox-v1-5-3953814532fd@marcan.st>
In-Reply-To: <20230328-soc-mailbox-v1-5-3953814532fd@marcan.st>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Tue, 28 Mar 2023 14:37:39 +0100
Message-ID: <CAOgh=FxjuMnpiyjsEebsnf8rEoZFkRQfnRLAiu3zAGttw8Y3iw@mail.gmail.com>
Subject: Re: [PATCH 5/5] soc: apple: mailbox: Rename config symbol to APPLE_MAILBOX
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Janne Grunau <j@jannau.net>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 at 14:21, Hector Martin <marcan@marcan.st> wrote:
>
> With the original owner of APPLE_MAILBOX removed, let's rename the new
> APPLE_MBOX to the old name. This avoids .config churn for downstream
> users, and leaves us with an identical config symbol and module name as
> before.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Watched the stream

Acked-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
>  drivers/soc/apple/Kconfig  | 5 ++---
>  drivers/soc/apple/Makefile | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/apple/Kconfig b/drivers/soc/apple/Kconfig
> index d0e29bbd8c6f..c5203c388bf4 100644
> --- a/drivers/soc/apple/Kconfig
> +++ b/drivers/soc/apple/Kconfig
> @@ -17,11 +17,10 @@ config APPLE_PMGR_PWRSTATE
>           controls for SoC devices. This driver manages them through the
>           generic power domain framework, and also provides reset support.
>
> -config APPLE_MBOX
> +config APPLE_MAILBOX
>         tristate "Apple SoC mailboxes"
>         depends on PM
>         depends on ARCH_APPLE || (64BIT && COMPILE_TEST)
> -       depends on !APPLE_MAILBOX
>         default ARCH_APPLE
>         help
>           Apple SoCs have various co-processors required for certain
> @@ -33,7 +32,7 @@ config APPLE_MBOX
>
>  config APPLE_RTKIT
>         tristate "Apple RTKit co-processor IPC protocol"
> -       depends on APPLE_MBOX
> +       depends on APPLE_MAILBOX
>         depends on ARCH_APPLE || COMPILE_TEST
>         default ARCH_APPLE
>         help
> diff --git a/drivers/soc/apple/Makefile b/drivers/soc/apple/Makefile
> index e52edf6a73da..20feee6f3943 100644
> --- a/drivers/soc/apple/Makefile
> +++ b/drivers/soc/apple/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_APPLE_PMGR_PWRSTATE)      += apple-pmgr-pwrstate.o
>
> -obj-$(CONFIG_APPLE_MBOX) += apple-mailbox.o
> +obj-$(CONFIG_APPLE_MAILBOX) += apple-mailbox.o
>  apple-mailbox-y = mailbox.o
>
>  obj-$(CONFIG_APPLE_RTKIT) += apple-rtkit.o
>
> --
> 2.40.0
>
>

