Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999046A0E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 17:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBWQxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 11:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBWQxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 11:53:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7261D4ECF2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 08:53:50 -0800 (PST)
Date:   Thu, 23 Feb 2023 17:53:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677171228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PPkdGpOVZMRH9SM6Z7dqNvPo2gM32EX9HbvF5pyxx3w=;
        b=GmHFvbDOoUsuPuZRY2416+3hvxQMRBRgFu86d5fC0oAuGBua9OeS2CUQ4+rztacHWFGiyf
        qJyQtvspBl5I0WivIptl1VP1iI7K9FmPQsRnIWXpkl1CAul66gKAmSyc84p0T3Pywu8nvB
        cBMylkiqStr+4nySvwQGNTkPpMfIThdmv3S+nLBesVMLUOo4UGJ7Ra3jHo5Cwd2b+Xj8aj
        6tUNylfnUXAYZLprNaaXorkQR5N5cZN2QIYkRgMroBiiJ7Rvsa2S6Z0kK9J9R3tzKi+Vlx
        QAMSaAkM3eDNgD2ROH6l+NUm9j/OArRtMzi54sQMEHQ1JEztAj+kFQOjskB7VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677171228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PPkdGpOVZMRH9SM6Z7dqNvPo2gM32EX9HbvF5pyxx3w=;
        b=rGRmlFS6xVN59xZgKx3KZM0lz188qes20hnMDPA/GkuEymtiOGMohnm0DdX7Y+eCaRYls2
        WCYWPZir58UkmTCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: Consider task_struct::saved_state in
 wait_task_inactive().
Message-ID: <Y/eaGdGD0sOAXWW+@linutronix.de>
References: <Y++UzubyNavLKFDP@linutronix.de>
 <Y/YaTojZ1stY2fAO@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/YaTojZ1stY2fAO@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-22 14:36:14 [+0100], Peter Zijlstra wrote:
> Which if the very few wait_task_inactive() users requires this?

ptrace is the remaining (known) one (just verified on v6.2-rt3).
ptrace_check_attach() waits for the child which blocks on tasklist_lock.

tglx argued that wait_task_inactive() should work regardless of the
task, that is being waited for, blocks on a sleeping lock.

Sebastian
