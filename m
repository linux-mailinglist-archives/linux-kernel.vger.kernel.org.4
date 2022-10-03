Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637BF5F28EE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 09:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJCHBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 03:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJCHBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 03:01:07 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAFC183AB;
        Mon,  3 Oct 2022 00:01:04 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id bv17so6306353wrb.10;
        Mon, 03 Oct 2022 00:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QZxEh5TlGS++zfFKZtN1bwu8VZwicVL3B9zKI6Kxkv4=;
        b=3KSwQDeOnUibGP+tiAG5QhpPMcVZWgJmL2d/3Gx5HTmzObOm1htIMIENHQJG8d+nWp
         mjNM4eKn+39aemRSi47S6xOyWrqdmxtFS8cum5vFN49LhxXM8dt4RqgKHM9/B5i5Ox32
         89KDTuXcAFy5IHMD5W1iq/LAOWVsbdKodqlBviXnSBhgWnUKfHsbIx19TzMzJRnjZsv/
         Y4ZHFmmztXwlTmKSHfC6adf7cKlV6K2CVJr7TUMzCH5P2BOrs+5WwILJqfuSolvSZ47n
         BG3NLbx7+oAcX1+m3q5Q9TQ69fOwBz2rdEHIoxT231n486juzdsls/uIZChg1VZJMrGC
         X8Wg==
X-Gm-Message-State: ACrzQf3efDUFizHa0/GYS5lyimUQW4WjW4hIP5cHbuqwbpuhenTvrkjS
        k4/e/CaxMgbVE+ajLO6pacL6c92qCkqnvg==
X-Google-Smtp-Source: AMsMyM7oTmPD9TmDJpCJLB5vx4Vxbpy4WraurpF7b0hIVCUMh3x/LYxkMeo2Z1XcyBUM3+J1f7gZ4w==
X-Received: by 2002:a5d:6484:0:b0:22e:3456:37fa with SMTP id o4-20020a5d6484000000b0022e345637famr3710653wri.203.1664780462955;
        Mon, 03 Oct 2022 00:01:02 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b003b31c560a0csm11376995wmb.12.2022.10.03.00.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 00:01:02 -0700 (PDT)
Message-ID: <bbde3488-be49-371d-3de3-89e759d639f4@kernel.org>
Date:   Mon, 3 Oct 2022 09:01:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 14/14] tty: gunyah: Add tty console driver for RM
 Console Services
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-15-quic_eberman@quicinc.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220928195633.2348848-15-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28. 09. 22, 21:56, Elliot Berman wrote:
> --- /dev/null
> +++ b/drivers/tty/gunyah_tty.c
> @@ -0,0 +1,409 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) "gh_rsc_mgr_console: " fmt
> +
> +#include <linux/gunyah_rsc_mgr.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/workqueue.h>
> +#include <linux/spinlock.h>
> +#include <linux/tty_flip.h>
> +#include <linux/console.h>
> +#include <linux/module.h>
> +#include <linux/kfifo.h>
> +#include <linux/kref.h>
> +#include <linux/slab.h>
> +#include <linux/tty.h>

Sort alphabetically, please. Not by inv. xmas tree.

> +/*
> + * The Linux TTY code does not support dynamic addition of tty derived devices so we need to know
> + * how many tty devices we might need when space is allocated for the tty device. Since VMs might be
> + * added/removed dynamically, we need to make sure we have enough allocated.
> + */
> +#define RSC_MGR_TTY_ADAPTERS		16
> +
> +/* # of payload bytes that can fit in a 1-fragment CONSOLE_WRITE message */
> +#define RM_CONS_WRITE_MSG_SIZE	((1 * (GH_MSGQ_MAX_MSG_SIZE - 8)) - 4)

"1 *" is kind of superfluous.

"- 8 - 4" -- it's too many magic constants in here. Define macros for them.

> +struct rm_cons_port {
> +	struct tty_port port;
> +	u16 vmid;
> +	bool open;
> +	unsigned int index;
> +
> +	DECLARE_KFIFO(put_fifo, char, 1024);

Why is tty_port::xmit_fifo not enough?

> +	spinlock_t fifo_lock;
> +	struct work_struct put_work;
> +
> +	struct rm_cons_data *cons_data;
> +};
> +
> +struct rm_cons_data {
> +	struct tty_driver *tty_driver;

It looks weird to have a driver per console/device.

> +	struct device *dev;
> +
> +	spinlock_t ports_lock;
> +	struct rm_cons_port *ports[RSC_MGR_TTY_ADAPTERS];
> +
> +	struct notifier_block rsc_mgr_notif;
> +	struct console console;
> +};
> +
> +static void put_work_fn(struct work_struct *ws)
> +{
> +	char buf[RM_CONS_WRITE_MSG_SIZE];

Ugh, is this 1024-12? Do not do this on stack!

> +	int count, ret;
> +	struct rm_cons_port *port = container_of(ws, struct rm_cons_port, put_work);
> +
> +	while (!kfifo_is_empty(&port->put_fifo)) {
> +		count = kfifo_out_spinlocked(&port->put_fifo, buf, sizeof(buf), &port->fifo_lock);
> +		if (count <= 0)
> +			continue;

This does not make much sense. 1) kfifo_is_empty() is not locked; 2) 
it's overly complicated. It can be, IMO:
while (1) {
   count = kfifo_out_spinlocked();
   if (!count)
     break;


> +static int rsc_mgr_console_notif(struct notifier_block *nb, unsigned long cmd, void *data)
> +{
> +	int count, i;

Not unsigned?

> +	struct rm_cons_port *rm_port = NULL;
> +	struct tty_port *tty_port = NULL;
> +	struct rm_cons_data *cons_data = container_of(nb, struct rm_cons_data, rsc_mgr_notif);
> +	const struct gh_rm_notification *notif = data;
> +	struct gh_rm_notif_vm_console_chars const * const msg = notif->buff;

Interesting mix of inconsistencies. Once you start with const, once you 
place it after struct. Please make it consistent (start with const).

ANd here, you should apply inv. xmas tree sorting.

> +
> +	if (cmd != GH_RM_NOTIF_VM_CONSOLE_CHARS ||
> +		notif->size < sizeof(*msg))
> +		return NOTIFY_DONE;

Weird indentation. notif->size should start with either 4 spaces less or 
one more tab.

regards,
-- 
js
suse labs

