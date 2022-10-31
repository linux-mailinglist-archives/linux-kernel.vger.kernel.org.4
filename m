Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3486137EB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJaN0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiJaN0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:26:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DA7FD31;
        Mon, 31 Oct 2022 06:26:47 -0700 (PDT)
Date:   Mon, 31 Oct 2022 14:26:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667222806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mb0Ej1ortleeAucLmIkRx/CfRh3SIJWlRcaDUzgtOlY=;
        b=WeedCGcxygL/AggvsG+rVn/FHu5H6ziSUozUC/fJ/bMoSWtDrNpd6SlR/dHC0QctebkcKA
        lo+n7VEq6CdbwF0mLlqp89sw2ajFaJ11fFHnmpIINpxEU0g38AM9UeeuzwxSO9ueDWz3os
        jAS2ahjHSS6B0TKVQSjaJyrO2tAtNrYDUrGNO88pOxBYM+YlN/2X3eIPkwSLzLRf7Gjs3X
        0Jf1F359W/RcZ87vgqLHYq/mEc9RtSy7psBsAmnAYCLU7T1KYy6CIa0Uar3CGKkXIbuVU9
        L18Bc6/IMIj1CNgtxs7mtuRBWAGsai2Jq9jV2YijLZYxNNw6p0+HEY2GJpav9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667222806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mb0Ej1ortleeAucLmIkRx/CfRh3SIJWlRcaDUzgtOlY=;
        b=7ae/r6wgnayJ24/06k3+EUyTMjDRV+GCjzJhZBVutHnmA3vWVxdfOvtAti3p0aP7xtDI4c
        mhPsmxl628tmftAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, stable-rt@vger.kernel.org
Subject: Re: [ANNOUNCE] v6.0.5-rt14
Message-ID: <Y1/NFIjRFZzszZB6@linutronix.de>
References: <Y1o8hqwQKDpOTkNr@linutronix.de>
 <649af0f6-e5e2-c450-879c-e9153e0c0abc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <649af0f6-e5e2-c450-879c-e9153e0c0abc@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-28 11:47:28 [+0200], Pierre Gondois wrote:
> Hello Sebastian,

Hi Pierre,

> About the issues Valentin reported:
> 
> - [SPLAT 1/3] arm_pmu: Sleeping spinlocks down armpmu_alloc_atomic()
> will be fixed by:
> https://lore.kernel.org/all/20220930111844.1522365-1-mark.rutland@arm.com/

This is still pending and I don't see it in next. Could someone give me
a ping once this is merged, please?

> - [SPLAT 2/3] irqchip/gic-v3-its: Sleeping spinlocks down gic_reserve_range()
> was fixed by:
> https://lore.kernel.org/lkml/20211027151506.2085066-3-valentin.schneider@arm.com/

That is
   d23bc2bc1d634 ("irqchip/gic-v3-its: Postpone LPI pending table freeing and memreserve")
   v5.17-rc1

> - [SPLAT 3/3] gpio: dwapb: Sleeping spinlocks down IRQ mapping
> was fixed by:
> https://lore.kernel.org/all/20220419012810.88417-1-schspa@gmail.com/
  3c938cc5cebcb ("gpio: use raw spinlock for gpio chip shadowed data")
  v5.19-rc1

Is someone picking the two up or RT-stable?

> Regards,
> Pierre

Sebastian
