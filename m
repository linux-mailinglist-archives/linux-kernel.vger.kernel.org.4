Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C505F68288C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjAaJSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjAaJSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:18:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D81CD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:17:21 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675156616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=flchPXzkBDdNSZxEsClR/kTnGnw06sJxS9EL2vC5sjo=;
        b=wptcTG/SOXhaFYl7rstwUl/UXc0tt0jPs9lX1Jmg0qqu3C9enFYtg+o5T53Jk0eiBbj8y+
        EUU7aI7gJLisy92SgNnresMo2bntuDRvw3P4noixvPdsXgdf/KfIifdelIK2pKK4UEjNn3
        3z7sTvp5jfiwuI2FzeabWS0ch7XJjuxGmhAT32PclseoCmp0fWjilsnaisas4PqNajb7fA
        YaZg1UQn9n8+O4TtYd9ML4X3hARgDAerZZ0j1xKO1693+ytFhk6pGOvVgwYcdo+bk65Cca
        GN+SQZ/FZhoPxTlgOjYw60banC5LtMznXIjM3fjiVSzhi+AO/6KiFOLgB1LBHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675156616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=flchPXzkBDdNSZxEsClR/kTnGnw06sJxS9EL2vC5sjo=;
        b=jVHu1kSUsU6KvzzVy8wwbwE+GuYLKPhJP9zzWoeI2qOiilgyHwf/U4gqCL7t0Uq2k7SaQp
        1vg+wMNIJpYWbMAw==
To:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] genirq: Allocate IRQ descriptors at boot time for
 !SPARSEIRQ
In-Reply-To: <20230130005725.3517597-3-sdonthineni@nvidia.com>
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
 <20230130005725.3517597-3-sdonthineni@nvidia.com>
Date:   Tue, 31 Jan 2023 10:16:55 +0100
Message-ID: <87mt5z12t4.ffs@tglx>
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

On Sun, Jan 29 2023 at 18:57, Shanker Donthineni wrote:

> Remove the use of statically allocated arrays for IRQ descriptors.
> Instead, allocate the necessary NR_IRQ descriptors during the boot
> time in early_irq_init().

That's not what I meant. I was pondering to remove !SPARSEIRQ
completely.

That allocation does not buy us much.

Thanks,

        tglx

