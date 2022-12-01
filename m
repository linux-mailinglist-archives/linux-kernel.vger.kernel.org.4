Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A18563EFA7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiLALk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiLALkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:40:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961BE975EB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:40:16 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669894814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jc2rbam4Qj3eO3JOIx5RE+KusaIA1U9FRV73T9rGhU4=;
        b=ab2iKx/k01qIJ64yPbGPxSnvGi9O//hFngq2b7CuHZqpfm7hsPLBbIot3BpZlN3kXWi1dO
        PsD4dE96+B6b8Z4Fz7VpxA2dgXJnyv/nT+HVG3wT0KgOWYuNf+ThNIosUukBePJ7a4e0vG
        rivCrbXfeEW1LFw9pVAoaCrZRtYP23mXAreMN9kr3Bu4dUnLhLAcYlpePcxyqYbzugwt4e
        rMx7GTEWhyfgV2RXb4LIBqnF1ggJ9id+ZtIkDnHm8rf5NukurhE+TEwNDXRskEKDAODFsy
        2A5yElp4KESmobn3vWL0LU0TDrlH+T0bZNS0qbHb7jSUhLEkAQ7U0wlKSiACxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669894814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jc2rbam4Qj3eO3JOIx5RE+KusaIA1U9FRV73T9rGhU4=;
        b=sdce1mQLNbN/E9XjHK/bzd5WnA4lOf7xac5I/9eiTBeJIDgKmUt27de2uHwkB6v+td9vFu
        7DtBBYWy7312u1Bw==
To:     Yuan ZhaoXiong <yuanzhx326@gmail.com>, steven.price@arm.com,
        Jason@zx2c4.com, juri.lelli@redhat.com, tony.luck@intel.com,
        frederic@kernel.org, yuanzhx326@gmail.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu: printk error information when call cpu_up() failed.
In-Reply-To: <20221128132803.17599-1-yuanzhx326@gmail.com>
References: <20221128132803.17599-1-yuanzhx326@gmail.com>
Date:   Thu, 01 Dec 2022 12:40:13 +0100
Message-ID: <87h6yfs676.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28 2022 at 21:28, Yuan ZhaoXiong wrote:
> It is better to printk error information out when calling cpu_up() failed.
> Users will observe cpu up error conveniently via the kernel log.
...
> +		if (!cpu_online(cpu)) {
> +			error = cpu_up(cpu, CPUHP_ONLINE);
> +			if (error)
> +				pr_err("Error taking CPU%d up: %d\n", cpu, error);

What's useful about it? If the CPU does not come up then it won't be
online.

The error code is pretty useless too because it does not tell you which
part of the online procedure caused it to fail. Just assume it fails
with -ENOMEM, then good luck to find the callback which observed the
memory allocation fail.

Thanks,

        tglx
