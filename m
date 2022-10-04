Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5365F4027
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiJDJpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiJDJoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:44:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023E8E5E;
        Tue,  4 Oct 2022 02:41:53 -0700 (PDT)
Date:   Tue, 4 Oct 2022 11:41:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664876511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bu0+vYYTyXokrfZ6CX46FlXV91bID4Pr3VTGgw2ncOU=;
        b=eeBfzN5wPkNF7fYV7yfojFjwTRJXiqbJXt5wa9PmP4ZKWTbPF69hOvat/50/5KlAudUzw5
        cBw2bKkc+vGAUfYkl8w+SP7YQ3qda07mRlruYWs05jtrvCOACbMCoHmzkU/cjLJ/+XZwWB
        V8mXR36VUi9emHozshCqEqwj/2kP5EWcNEjwO0FrjUTSR2EcfSv5qKxdlz4MwpsjuCvs42
        ZeMxXJNO72Vgj0dROE+lDMRwuskwE/ioEQ8dOqymfVZu1I7352Jf+1YPrzHbmjLIeBL7iO
        MnN5IwU6oKli7yslnip3jNx2dbR+4Y4fY16CGFZh2bRDlp/qNGIIOnGZo4QZbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664876511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bu0+vYYTyXokrfZ6CX46FlXV91bID4Pr3VTGgw2ncOU=;
        b=oE91omfEhqEXdzO2EQ+S8R07PFmvCcgX0YdttCjfqPep2mgb4iFv5sp0VcBsLBtdTGZkVT
        KsnLxfClu8G+11BQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Eric Chanudet <echanude@redhat.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: qcom-ipcc: flag IRQ NO_THREAD
Message-ID: <Yzv/3vsIMtgu7noY@linutronix.de>
References: <20221003170849.383005-1-echanude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221003170849.383005-1-echanude@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-03 13:08:49 [-0400], Eric Chanudet wrote:
> PREEMPT_RT forces qcom-ipcc's handler to be threaded with interrupts
> enabled, which triggers a warning in __handle_irq_event_percpu():
>     irq 173 handler irq_default_primary_handler+0x0/0x10 enabled interrupts
>     WARNING: CPU: 0 PID: 77 at kernel/irq/handle.c:161 __handle_irq_event_percpu+0x4c4/0x4d0
> 
> Mark it IRQF_NO_THREAD to avoid running the handler in a threaded
> context with threadirqs or PREEMPT_RT enabled.

The important bit of information is that this is a IRQ-multiplexer and
such it must not be threaded. Otherwise its child-interrupts would be
invoked from the thread handler which is not desired.
This is noticed by PREEMPT_RT but also on a non-PREEMPT_RT kernel where
`threadirqs' has been used.

Side note: Using request_irq() has the side effect that this interrupt
pops-up in /proc/interrupts and the "child-interrupt", too. So you
account two interrupts while "one" on the HW side occurred. 
Maybe irq_set_chained_handler_and_data() would be better use.
Either way, this addresses the problem,

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Signed-off-by: Eric Chanudet <echanude@redhat.com>

Sebastian
