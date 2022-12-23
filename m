Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E72654C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 06:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLWFgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 00:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWFgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 00:36:42 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33A3DF92
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 21:36:40 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id j1so866845uan.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 21:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bqOdnql9DdGsjMFzlBdMyQlpOPEtA9CzvIt8a1m/1qQ=;
        b=iahlX6eDDt9vszlqKAg78kRKGWOvC2Ifah70G1Pr4nHx9X7FzR2PqpqindWa1HCY0I
         ouG2e2ulWvwcfee385as4Ikp6wCEMDXa/2TyYm9MPypN2CC9uGKMQ+MkRJnPr/MFMxOS
         +aCWGZPwLSmxX6fTLNoCbm9nYnix4Qb5o40fPNfqYmJlKf8x6hk+mtBXxcGmaRv0SsPN
         XRyYqrQ3iADxK5vb0FfNwIZnWWF1Gka0RkWH5j8dWpg6Bj7lAE2p/GUvsBPvCZDLBxHc
         27l2DYA5sup+Un3llX03B2KjU5LmMWDkApF96GMj22uUqnKE7UU0uiUC5aTPAMj/fjVg
         orDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqOdnql9DdGsjMFzlBdMyQlpOPEtA9CzvIt8a1m/1qQ=;
        b=f2jNmh1ULmlVgyHieMlfdxIxasaQ68fG9g6/xa/u0hF0k+yNn8gbsI6PuawqbJIb5h
         rBoca03kY7Ve3QV2MKC6yt/pwmrJw8S7R4Lguoxb+FFRbJHClxxO/IOKm2oie4oY1J+Z
         DafE4Blw7Az0vK+wTpI6ovC8C1S3It70BUqW7I3bVWp8JbrUOe5Uh0LqpF6wwY13ye2L
         dNXKGwk286BN3C1Q94/nuEMtog21rUv4Lac392MPzHtw9caIv1rAW6K4QCt96fcCSyB7
         PJmhAcgtVOriUUnlXF18lykWIu6ORdGaeEEQXEil8fzA9CjBFDzMxCuXG3+XLCFp7PSi
         3vrA==
X-Gm-Message-State: AFqh2kqlMLOfNNrEVmkk5wMwS/ZjU5hG7u/bqIQoAy0f1z1ogUaATHKE
        l9aV6h/jfIJFXBeRYzJo7baXvWNUgr0T99ahdPNIcQ==
X-Google-Smtp-Source: AMrXdXu+fog9QxdwgOVF66eKYKyF2I8mlZCVImYIQixWPo5tHen5IwoxdURbZcy16RxccGeNM+lQC4w3IPsehfTKq48=
X-Received: by 2002:ab0:32d1:0:b0:419:1a4a:cefa with SMTP id
 f17-20020ab032d1000000b004191a4acefamr774080uao.66.1671773799747; Thu, 22 Dec
 2022 21:36:39 -0800 (PST)
MIME-Version: 1.0
References: <20221222185049.737625-1-cristian.marussi@arm.com>
In-Reply-To: <20221222185049.737625-1-cristian.marussi@arm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 23 Dec 2022 11:06:29 +0530
Message-ID: <CAFA6WYP++tYORr+-EDPF1EKakwJHaH+_WFq8kzWY-UU3yQJ7Gg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Rework SCMI initialization and probing sequence
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, Ludvig.Parsson@axis.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2022 at 00:22, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> Hi,
>
> under some configurations the SCMI core stack, which is now initialized
> as a whole at the subsys_initcall level, can be dependent on some other
> Kernel subsystems (like TEE) when some SCMI transport backend like optee
> is used.

Thanks Cristian for the rework, but this doesn't seem to address
reluctance to carry forward the DT legacy (see [1]).

TLDR, it has led to misrepresentation of OP-TEE transport as follows:

    First represented as a platform device via DT (compatible =
"linaro,scmi-optee";) and then
    Migrated to being a TEE bus device (UUID: 0xa8cfe406, 0xd4f5,
0x4a2e, 0x9f, 0x8d, 0xa2, 0x5d, 0xc7, 0x54, 0xc0, 0x99)

Do we really need to have a platform device for every SCMI transport?

[1] https://lore.kernel.org/lkml/CAFA6WYPwku8d7EiJ8rF5pVh568oy+jXMXLdxSr6r476e0SD2nw@mail.gmail.com/

-Sumit

>
> This has been reported to lead to some awkward probe loop which, even
> though successful at the end, leaves a track of errors in the logs coming
> directly from the core Linux driver model facilities.
>
> In order to solve this issue and cleaning up a bit the SCMI stack startup
> sequence, this small series reviews and reworks the SCMI core stack
> initialization and probe logic.
>
> Basically the SCMI Bus is split into its own module (scmi-core.ko) which is
> initialized at subsys_initcall, while the SCMI core stack, including its
> various transport backends (like optee, mailbox, virtio, smc), is kept into
> a distinct module (scmi-module.ko) which get initialized at module_init.
>
> The SCMI driver users initlevel, instead, remains unchanged at module_init.
>
> No change is made to the Kconfig: the main ARM_SCMI_PROTOCOL option will
> now cause both modules to be built.
>
> This allows the other possibly needed subsystems to be up and running
> well before the core SCMI stack and its dependent transport backends, so
> solving the reported issue.
>
> Tested with SCMI transports mailbox/virtio and, in a previous draft, optee,
> in a number of different load/unload/bind/unbind combinations both as
> builtin and as LKMs.
>
> Applies on v6.1.
>
> Any feedback, testing welcome.
>
> Thanks,
> Cristian
>
> Cristian Marussi (9):
>   firmware: arm_scmi: Simplify chan_available transport operation
>   firmware: arm_scmi: Use dedicated devices to initialize channels
>   firmware: arm_scmi: Move protocol registration helpers
>   firmware: arm_scmi: Add common notifier helpers
>   firmware: arm_scmi: Refactor protocol device creation
>   firmware: arm_scmi: Move handle get/set helpers
>   firmware: arm_scmi: Refactor device create/destroy helpers
>   firmware: arm_scmi: Introduce a new lifecycle for protocol devices
>   firmware: arm_scmi: Split bus and driver into distinct modules
>
>  drivers/firmware/arm_scmi/Makefile  |   8 +-
>  drivers/firmware/arm_scmi/bus.c     | 388 ++++++++++++-----
>  drivers/firmware/arm_scmi/common.h  |  25 +-
>  drivers/firmware/arm_scmi/driver.c  | 623 ++++++++++++++--------------
>  drivers/firmware/arm_scmi/mailbox.c |   6 +-
>  drivers/firmware/arm_scmi/optee.c   |   6 +-
>  drivers/firmware/arm_scmi/smc.c     |   6 +-
>  drivers/firmware/arm_scmi/virtio.c  |   4 +-
>  include/linux/scmi_protocol.h       |   5 -
>  9 files changed, 622 insertions(+), 449 deletions(-)
>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
