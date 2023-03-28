Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F9F6CC125
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjC1Nji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjC1Njc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E065BBB3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680010711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g90pz48Kx7RGbPy//HaUA4HNcsTt1lBnS5HOOjFdtAs=;
        b=BZGs1ZYH50Neo+JYB0WDuUsObDLgp1H+0kiANBxWksxQw+naBqNxITR+2wNoHjeBeaWftl
        0c4W9BOKjUOUyYZSmEOCsIq54MnKVF9I/0lpMr4wwTJll0gNhJBTu2IVhgqNKXvb1mqQqf
        T9CuwgLSQ1oPoyrhMLy2jwLNMeCoOkI=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-t18H3M7zMPqVWaRyqEPlgQ-1; Tue, 28 Mar 2023 09:38:30 -0400
X-MC-Unique: t18H3M7zMPqVWaRyqEPlgQ-1
Received: by mail-ua1-f69.google.com with SMTP id d42-20020ab014ad000000b0075c9df2d66bso5724165uae.14
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680010710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g90pz48Kx7RGbPy//HaUA4HNcsTt1lBnS5HOOjFdtAs=;
        b=6Dy+zXBxMz7E+l7lu+6hDJmGLn1pgh1y/Q5p5yigTEzIzwbcy9jFBs3GWGgSyzwQ6Z
         9et9j3OUfJ/xSF06iKRgqoM1v63MSS77M+bZorwIAdog6czeWPrQngZe2Y4ZVzD3UtVh
         L60HXMDUDA6TvbrTewPHja0GNUZVlB3eEXve96wvWQSgxhlgPqohgKunKBGZOLVgzgzj
         wwhoMOqvw9m84BoOyYpIecl5kxKpfTEz2vzW7E/B45t/j0GluzBWBGNKqwVlrQCi13WX
         r+nn8dFxFS4XZLLrUU+7+GEwZiT6hIHNRNAsbf4sRqBN7XLMmRb1yR5FKJOlEVLC3ukn
         Ptdw==
X-Gm-Message-State: AAQBX9eyDDyIZbbBCIGP53sqSJF0HX6lX7LeEl1CHVXbd1O8U3XFpoG7
        JZe4nAoMFkKX0Vo0HlebqEv9AfTZFHf3je8uUUqAX2jwtFGZAWOpR81XTl3aBCc7dQiBNTG/klM
        naIWWiZGiLdHWC673GKHvDdeXoYTJAvm3Xgzolbb9
X-Received: by 2002:a1f:1d15:0:b0:435:56e:154e with SMTP id d21-20020a1f1d15000000b00435056e154emr8305805vkd.1.1680010709597;
        Tue, 28 Mar 2023 06:38:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZtHLcJTXTJSQdQiRxqGfYvQ0q6CQiNt7I/lWQiEALL8iVM9rSc275o14cscuvLpUBDrnDxyCOAnXnll2F9LYk=
X-Received: by 2002:a1f:1d15:0:b0:435:56e:154e with SMTP id
 d21-20020a1f1d15000000b00435056e154emr8305790vkd.1.1680010709181; Tue, 28 Mar
 2023 06:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230328-soc-mailbox-v1-0-3953814532fd@marcan.st> <20230328-soc-mailbox-v1-2-3953814532fd@marcan.st>
In-Reply-To: <20230328-soc-mailbox-v1-2-3953814532fd@marcan.st>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Tue, 28 Mar 2023 14:38:13 +0100
Message-ID: <CAOgh=Fzyw_V1ZZOiFbbtFowmZZxEs3+jRJNomT1nufEJZNn90A@mail.gmail.com>
Subject: Re: [PATCH 2/5] soc: apple: mailbox: Add ASC/M3 mailbox driver
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

On Tue, 28 Mar 2023 at 14:20, Hector Martin <marcan@marcan.st> wrote:
>
> This new driver is based on the existing apple-mailbox driver, but
> replaces the usage of the mailbox subsystem with directly exported
> symbols.
>
> As part of this refactor, this adds support for using the hardware FIFOs
> (not supported in mailbox) and implicitly fixes a bunch of bugs caused
> by bad interactions with the mailbox subsystem. It also adds runtime-PM
> support.
>
> The new config symbol is APPLE_MBOX, while the module name remains
> identical ("apple-mailbox"). The configs are mutually exclusive in
> Kconfig, to avoid conflicts.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Watched the stream

Acked-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
>  drivers/soc/apple/Kconfig   |  14 ++
>  drivers/soc/apple/Makefile  |   3 +
>  drivers/soc/apple/mailbox.c | 434 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/soc/apple/mailbox.h |  48 +++++
>  4 files changed, 499 insertions(+)
>
> diff --git a/drivers/soc/apple/Kconfig b/drivers/soc/apple/Kconfig
> index a1596fefacff..caa2cf09ff7a 100644
> --- a/drivers/soc/apple/Kconfig
> +++ b/drivers/soc/apple/Kconfig
> @@ -17,6 +17,20 @@ config APPLE_PMGR_PWRSTATE
>           controls for SoC devices. This driver manages them through the
>           generic power domain framework, and also provides reset support.
>
> +config APPLE_MBOX
> +       tristate "Apple SoC mailboxes"
> +       depends on PM
> +       depends on ARCH_APPLE || (64BIT && COMPILE_TEST)
> +       depends on !APPLE_MAILBOX
> +       default ARCH_APPLE
> +       help
> +         Apple SoCs have various co-processors required for certain
> +         peripherals to work (NVMe, display controller, etc.). This
> +         driver adds support for the mailbox controller used to
> +         communicate with those.
> +
> +         Say Y here if you have an Apple SoC.
> +
>  config APPLE_RTKIT
>         tristate "Apple RTKit co-processor IPC protocol"
>         depends on MAILBOX
> diff --git a/drivers/soc/apple/Makefile b/drivers/soc/apple/Makefile
> index e293770cf66d..e52edf6a73da 100644
> --- a/drivers/soc/apple/Makefile
> +++ b/drivers/soc/apple/Makefile
> @@ -1,6 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_APPLE_PMGR_PWRSTATE)      += apple-pmgr-pwrstate.o
>
> +obj-$(CONFIG_APPLE_MBOX) += apple-mailbox.o
> +apple-mailbox-y = mailbox.o
> +
>  obj-$(CONFIG_APPLE_RTKIT) += apple-rtkit.o
>  apple-rtkit-y = rtkit.o rtkit-crashlog.o
>
> diff --git a/drivers/soc/apple/mailbox.c b/drivers/soc/apple/mailbox.c
> new file mode 100644
> index 000000000000..7bdebafa6e83
> --- /dev/null
> +++ b/drivers/soc/apple/mailbox.c
> @@ -0,0 +1,434 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Apple mailbox driver
> + *
> + * Copyright The Asahi Linux Contributors
> + *
> + * This driver adds support for two mailbox variants (called ASC and M3 by
> + * Apple) found in Apple SoCs such as the M1. It consists of two FIFOs used to
> + * exchange 64+32 bit messages between the main CPU and a co-processor.
> + * Various coprocessors implement different IPC protocols based on these simple
> + * messages and shared memory buffers.
> + *
> + * Both the main CPU and the co-processor see the same set of registers but
> + * the first FIFO (A2I) is always used to transfer messages from the application
> + * processor (us) to the I/O processor and the second one (I2A) for the
> + * other direction.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include "mailbox.h"
> +
> +#define APPLE_ASC_MBOX_CONTROL_FULL BIT(16)
> +#define APPLE_ASC_MBOX_CONTROL_EMPTY BIT(17)
> +
> +#define APPLE_ASC_MBOX_A2I_CONTROL 0x110
> +#define APPLE_ASC_MBOX_A2I_SEND0 0x800
> +#define APPLE_ASC_MBOX_A2I_SEND1 0x808
> +#define APPLE_ASC_MBOX_A2I_RECV0 0x810
> +#define APPLE_ASC_MBOX_A2I_RECV1 0x818
> +
> +#define APPLE_ASC_MBOX_I2A_CONTROL 0x114
> +#define APPLE_ASC_MBOX_I2A_SEND0 0x820
> +#define APPLE_ASC_MBOX_I2A_SEND1 0x828
> +#define APPLE_ASC_MBOX_I2A_RECV0 0x830
> +#define APPLE_ASC_MBOX_I2A_RECV1 0x838
> +
> +#define APPLE_M3_MBOX_CONTROL_FULL BIT(16)
> +#define APPLE_M3_MBOX_CONTROL_EMPTY BIT(17)
> +
> +#define APPLE_M3_MBOX_A2I_CONTROL 0x50
> +#define APPLE_M3_MBOX_A2I_SEND0 0x60
> +#define APPLE_M3_MBOX_A2I_SEND1 0x68
> +#define APPLE_M3_MBOX_A2I_RECV0 0x70
> +#define APPLE_M3_MBOX_A2I_RECV1 0x78
> +
> +#define APPLE_M3_MBOX_I2A_CONTROL 0x80
> +#define APPLE_M3_MBOX_I2A_SEND0 0x90
> +#define APPLE_M3_MBOX_I2A_SEND1 0x98
> +#define APPLE_M3_MBOX_I2A_RECV0 0xa0
> +#define APPLE_M3_MBOX_I2A_RECV1 0xa8
> +
> +#define APPLE_M3_MBOX_IRQ_ENABLE 0x48
> +#define APPLE_M3_MBOX_IRQ_ACK 0x4c
> +#define APPLE_M3_MBOX_IRQ_A2I_EMPTY BIT(0)
> +#define APPLE_M3_MBOX_IRQ_A2I_NOT_EMPTY BIT(1)
> +#define APPLE_M3_MBOX_IRQ_I2A_EMPTY BIT(2)
> +#define APPLE_M3_MBOX_IRQ_I2A_NOT_EMPTY BIT(3)
> +
> +#define APPLE_MBOX_MSG1_OUTCNT GENMASK(56, 52)
> +#define APPLE_MBOX_MSG1_INCNT GENMASK(51, 48)
> +#define APPLE_MBOX_MSG1_OUTPTR GENMASK(47, 44)
> +#define APPLE_MBOX_MSG1_INPTR GENMASK(43, 40)
> +#define APPLE_MBOX_MSG1_MSG GENMASK(31, 0)
> +
> +#define APPLE_MBOX_TX_TIMEOUT 500
> +
> +struct apple_mbox_hw {
> +       unsigned int control_full;
> +       unsigned int control_empty;
> +
> +       unsigned int a2i_control;
> +       unsigned int a2i_send0;
> +       unsigned int a2i_send1;
> +
> +       unsigned int i2a_control;
> +       unsigned int i2a_recv0;
> +       unsigned int i2a_recv1;
> +
> +       bool has_irq_controls;
> +       unsigned int irq_enable;
> +       unsigned int irq_ack;
> +       unsigned int irq_bit_recv_not_empty;
> +       unsigned int irq_bit_send_empty;
> +};
> +
> +int apple_mbox_send(struct apple_mbox *mbox, const struct apple_mbox_msg msg,
> +                   bool atomic)
> +{
> +       unsigned long flags;
> +       int ret;
> +       u32 mbox_ctrl;
> +       long t;
> +
> +       spin_lock_irqsave(&mbox->tx_lock, flags);
> +       mbox_ctrl = readl_relaxed(mbox->regs + mbox->hw->a2i_control);
> +
> +       while (mbox_ctrl & mbox->hw->control_full) {
> +               if (atomic) {
> +                       ret = readl_poll_timeout_atomic(
> +                               mbox->regs + mbox->hw->a2i_control, mbox_ctrl,
> +                               !(mbox_ctrl & mbox->hw->control_full), 100,
> +                               APPLE_MBOX_TX_TIMEOUT * 1000);
> +
> +                       if (ret) {
> +                               spin_unlock_irqrestore(&mbox->tx_lock, flags);
> +                               return ret;
> +                       }
> +
> +                       break;
> +               }
> +               /*
> +                * The interrupt is level triggered and will keep firing as long as the
> +                * FIFO is empty. It will also keep firing if the FIFO was empty
> +                * at any point in the past until it has been acknowledged at the
> +                * mailbox level. By acknowledging it here we can ensure that we will
> +                * only get the interrupt once the FIFO has been cleared again.
> +                * If the FIFO is already empty before the ack it will fire again
> +                * immediately after the ack.
> +                */
> +               if (mbox->hw->has_irq_controls) {
> +                       writel_relaxed(mbox->hw->irq_bit_send_empty,
> +                                      mbox->regs + mbox->hw->irq_ack);
> +               }
> +               enable_irq(mbox->irq_send_empty);
> +               reinit_completion(&mbox->tx_empty);
> +               spin_unlock_irqrestore(&mbox->tx_lock, flags);
> +
> +               t = wait_for_completion_interruptible_timeout(
> +                       &mbox->tx_empty,
> +                       msecs_to_jiffies(APPLE_MBOX_TX_TIMEOUT));
> +               if (t < 0)
> +                       return t;
> +               else if (t == 0)
> +                       return -ETIMEDOUT;
> +
> +               spin_lock_irqsave(&mbox->tx_lock, flags);
> +               mbox_ctrl = readl_relaxed(mbox->regs + mbox->hw->a2i_control);
> +       }
> +
> +       writeq_relaxed(msg.msg0, mbox->regs + mbox->hw->a2i_send0);
> +       writeq_relaxed(FIELD_PREP(APPLE_MBOX_MSG1_MSG, msg.msg1),
> +                      mbox->regs + mbox->hw->a2i_send1);
> +
> +       spin_unlock_irqrestore(&mbox->tx_lock, flags);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(apple_mbox_send);
> +
> +static irqreturn_t apple_mbox_send_empty_irq(int irq, void *data)
> +{
> +       struct apple_mbox *mbox = data;
> +
> +       /*
> +        * We don't need to acknowledge the interrupt at the mailbox level
> +        * here even if supported by the hardware. It will keep firing but that
> +        * doesn't matter since it's disabled at the main interrupt controller.
> +        * apple_mbox_send will acknowledge it before enabling
> +        * it at the main controller again.
> +        */
> +       spin_lock(&mbox->tx_lock);
> +       disable_irq_nosync(mbox->irq_send_empty);
> +       complete(&mbox->tx_empty);
> +       spin_unlock(&mbox->tx_lock);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int apple_mbox_poll_locked(struct apple_mbox *mbox)
> +{
> +       struct apple_mbox_msg msg;
> +       int ret = 0;
> +
> +       u32 mbox_ctrl = readl_relaxed(mbox->regs + mbox->hw->i2a_control);
> +
> +       while (!(mbox_ctrl & mbox->hw->control_empty)) {
> +               msg.msg0 = readq_relaxed(mbox->regs + mbox->hw->i2a_recv0);
> +               msg.msg1 = FIELD_GET(
> +                       APPLE_MBOX_MSG1_MSG,
> +                       readq_relaxed(mbox->regs + mbox->hw->i2a_recv1));
> +
> +               mbox->rx(mbox, msg, mbox->cookie);
> +               ret++;
> +               mbox_ctrl = readl_relaxed(mbox->regs + mbox->hw->i2a_control);
> +       }
> +
> +       /*
> +        * The interrupt will keep firing even if there are no more messages
> +        * unless we also acknowledge it at the mailbox level here.
> +        * There's no race if a message comes in between the check in the while
> +        * loop above and the ack below: If a new messages arrives inbetween
> +        * those two the interrupt will just fire again immediately after the
> +        * ack since it's level triggered.
> +        */
> +       if (mbox->hw->has_irq_controls) {
> +               writel_relaxed(mbox->hw->irq_bit_recv_not_empty,
> +                              mbox->regs + mbox->hw->irq_ack);
> +       }
> +
> +       return ret;
> +}
> +
> +static irqreturn_t apple_mbox_recv_irq(int irq, void *data)
> +{
> +       struct apple_mbox *mbox = data;
> +
> +       spin_lock(&mbox->rx_lock);
> +       apple_mbox_poll_locked(mbox);
> +       spin_unlock(&mbox->rx_lock);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +int apple_mbox_poll(struct apple_mbox *mbox)
> +{
> +       unsigned long flags;
> +       int ret;
> +
> +       spin_lock_irqsave(&mbox->rx_lock, flags);
> +       ret = apple_mbox_poll_locked(mbox);
> +       spin_unlock_irqrestore(&mbox->rx_lock, flags);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(apple_mbox_poll);
> +
> +int apple_mbox_start(struct apple_mbox *mbox)
> +{
> +       int ret;
> +
> +       if (mbox->active)
> +               return 0;
> +
> +       ret = pm_runtime_resume_and_get(mbox->dev);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Only some variants of this mailbox HW provide interrupt control
> +        * at the mailbox level. We therefore need to handle enabling/disabling
> +        * interrupts at the main interrupt controller anyway for hardware that
> +        * doesn't. Just always keep the interrupts we care about enabled at
> +        * the mailbox level so that both hardware revisions behave almost
> +        * the same.
> +        */
> +       if (mbox->hw->has_irq_controls) {
> +               writel_relaxed(mbox->hw->irq_bit_recv_not_empty |
> +                                      mbox->hw->irq_bit_send_empty,
> +                              mbox->regs + mbox->hw->irq_enable);
> +       }
> +
> +       enable_irq(mbox->irq_recv_not_empty);
> +       mbox->active = true;
> +       return 0;
> +}
> +EXPORT_SYMBOL(apple_mbox_start);
> +
> +void apple_mbox_stop(struct apple_mbox *mbox)
> +{
> +       if (!mbox->active)
> +               return;
> +
> +       mbox->active = false;
> +       disable_irq(mbox->irq_recv_not_empty);
> +       pm_runtime_mark_last_busy(mbox->dev);
> +       pm_runtime_put_autosuspend(mbox->dev);
> +}
> +EXPORT_SYMBOL(apple_mbox_stop);
> +
> +struct apple_mbox *apple_mbox_get(struct device *dev, int index)
> +{
> +       struct of_phandle_args args;
> +       struct platform_device *pdev;
> +       struct apple_mbox *mbox;
> +       int ret;
> +
> +       ret = of_parse_phandle_with_args(dev->of_node, "mboxes", "#mbox-cells",
> +                                        index, &args);
> +       if (ret || !args.np)
> +               return ERR_PTR(ret);
> +
> +       pdev = of_find_device_by_node(args.np);
> +       of_node_put(args.np);
> +
> +       if (!pdev)
> +               return ERR_PTR(EPROBE_DEFER);
> +
> +       mbox = platform_get_drvdata(pdev);
> +       if (!mbox)
> +               return ERR_PTR(EPROBE_DEFER);
> +
> +       if (!device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
> +               return ERR_PTR(ENODEV);
> +
> +       return mbox;
> +}
> +EXPORT_SYMBOL(apple_mbox_get);
> +
> +struct apple_mbox *apple_mbox_get_byname(struct device *dev, const char *name)
> +{
> +       int index;
> +
> +       index = of_property_match_string(dev->of_node, "mbox-names", name);
> +       if (index < 0)
> +               return ERR_PTR(index);
> +
> +       return apple_mbox_get(dev, index);
> +}
> +EXPORT_SYMBOL(apple_mbox_get_byname);
> +
> +static int apple_mbox_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       char *irqname;
> +       struct apple_mbox *mbox;
> +       struct device *dev = &pdev->dev;
> +
> +       mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> +       if (!mbox)
> +               return -ENOMEM;
> +
> +       mbox->dev = &pdev->dev;
> +       mbox->hw = of_device_get_match_data(dev);
> +       if (!mbox->hw)
> +               return -EINVAL;
> +
> +       mbox->regs = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(mbox->regs))
> +               return PTR_ERR(mbox->regs);
> +
> +       mbox->irq_recv_not_empty =
> +               platform_get_irq_byname(pdev, "recv-not-empty");
> +       if (mbox->irq_recv_not_empty < 0)
> +               return -ENODEV;
> +
> +       mbox->irq_send_empty = platform_get_irq_byname(pdev, "send-empty");
> +       if (mbox->irq_send_empty < 0)
> +               return -ENODEV;
> +
> +       spin_lock_init(&mbox->rx_lock);
> +       spin_lock_init(&mbox->tx_lock);
> +       init_completion(&mbox->tx_empty);
> +
> +       irqname = devm_kasprintf(dev, GFP_KERNEL, "%s-recv", dev_name(dev));
> +       if (!irqname)
> +               return -ENOMEM;
> +
> +       ret = devm_request_irq(dev, mbox->irq_recv_not_empty,
> +                              apple_mbox_recv_irq,
> +                              IRQF_NO_AUTOEN | IRQF_NO_SUSPEND, irqname, mbox);
> +       if (ret)
> +               return ret;
> +
> +       irqname = devm_kasprintf(dev, GFP_KERNEL, "%s-send", dev_name(dev));
> +       if (!irqname)
> +               return -ENOMEM;
> +
> +       ret = devm_request_irq(dev, mbox->irq_send_empty,
> +                              apple_mbox_send_empty_irq,
> +                              IRQF_NO_AUTOEN | IRQF_NO_SUSPEND, irqname, mbox);
> +       if (ret)
> +               return ret;
> +
> +       ret = devm_pm_runtime_enable(dev);
> +       if (ret)
> +               return ret;
> +
> +       platform_set_drvdata(pdev, mbox);
> +       return 0;
> +}
> +
> +static const struct apple_mbox_hw apple_mbox_asc_hw = {
> +       .control_full = APPLE_ASC_MBOX_CONTROL_FULL,
> +       .control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
> +
> +       .a2i_control = APPLE_ASC_MBOX_A2I_CONTROL,
> +       .a2i_send0 = APPLE_ASC_MBOX_A2I_SEND0,
> +       .a2i_send1 = APPLE_ASC_MBOX_A2I_SEND1,
> +
> +       .i2a_control = APPLE_ASC_MBOX_I2A_CONTROL,
> +       .i2a_recv0 = APPLE_ASC_MBOX_I2A_RECV0,
> +       .i2a_recv1 = APPLE_ASC_MBOX_I2A_RECV1,
> +
> +       .has_irq_controls = false,
> +};
> +
> +static const struct apple_mbox_hw apple_mbox_m3_hw = {
> +       .control_full = APPLE_M3_MBOX_CONTROL_FULL,
> +       .control_empty = APPLE_M3_MBOX_CONTROL_EMPTY,
> +
> +       .a2i_control = APPLE_M3_MBOX_A2I_CONTROL,
> +       .a2i_send0 = APPLE_M3_MBOX_A2I_SEND0,
> +       .a2i_send1 = APPLE_M3_MBOX_A2I_SEND1,
> +
> +       .i2a_control = APPLE_M3_MBOX_I2A_CONTROL,
> +       .i2a_recv0 = APPLE_M3_MBOX_I2A_RECV0,
> +       .i2a_recv1 = APPLE_M3_MBOX_I2A_RECV1,
> +
> +       .has_irq_controls = true,
> +       .irq_enable = APPLE_M3_MBOX_IRQ_ENABLE,
> +       .irq_ack = APPLE_M3_MBOX_IRQ_ACK,
> +       .irq_bit_recv_not_empty = APPLE_M3_MBOX_IRQ_I2A_NOT_EMPTY,
> +       .irq_bit_send_empty = APPLE_M3_MBOX_IRQ_A2I_EMPTY,
> +};
> +
> +static const struct of_device_id apple_mbox_of_match[] = {
> +       { .compatible = "apple,asc-mailbox-v4", .data = &apple_mbox_asc_hw },
> +       { .compatible = "apple,m3-mailbox-v2", .data = &apple_mbox_m3_hw },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, apple_mbox_of_match);
> +
> +static struct platform_driver apple_mbox_driver = {
> +       .driver = {
> +               .name = "apple-mailbox",
> +               .of_match_table = apple_mbox_of_match,
> +       },
> +       .probe = apple_mbox_probe,
> +};
> +module_platform_driver(apple_mbox_driver);
> +
> +MODULE_LICENSE("Dual MIT/GPL");
> +MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
> +MODULE_DESCRIPTION("Apple Mailbox driver");
> diff --git a/drivers/soc/apple/mailbox.h b/drivers/soc/apple/mailbox.h
> new file mode 100644
> index 000000000000..f73a8913da95
> --- /dev/null
> +++ b/drivers/soc/apple/mailbox.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> +/*
> + * Apple mailbox message format
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +#ifndef _APPLE_MAILBOX_H_
> +#define _APPLE_MAILBOX_H_
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +
> +/* encodes a single 96bit message sent over the single channel */
> +struct apple_mbox_msg {
> +       u64 msg0;
> +       u32 msg1;
> +};
> +
> +struct apple_mbox {
> +       struct device *dev;
> +       void __iomem *regs;
> +       const struct apple_mbox_hw *hw;
> +       bool active;
> +
> +       int irq_recv_not_empty;
> +       int irq_send_empty;
> +
> +       spinlock_t rx_lock;
> +       spinlock_t tx_lock;
> +
> +       struct completion tx_empty;
> +
> +       /** Receive callback for incoming messages */
> +       void (*rx)(struct apple_mbox *mbox, struct apple_mbox_msg msg, void *cookie);
> +       void *cookie;
> +};
> +
> +struct apple_mbox *apple_mbox_get(struct device *dev, int index);
> +struct apple_mbox *apple_mbox_get_byname(struct device *dev, const char *name);
> +
> +int apple_mbox_start(struct apple_mbox *mbox);
> +void apple_mbox_stop(struct apple_mbox *mbox);
> +int apple_mbox_poll(struct apple_mbox *mbox);
> +int apple_mbox_send(struct apple_mbox *mbox, struct apple_mbox_msg msg,
> +                   bool atomic);
> +
> +#endif
>
> --
> 2.40.0
>
>

