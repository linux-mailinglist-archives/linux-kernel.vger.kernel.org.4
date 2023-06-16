Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3B4732927
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245330AbjFPHpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241507AbjFPHpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:45:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA10C271E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VUKVMQ/tdBCg2U0T1ZYJ++Hxjl61NY9T3a/iTMVp5H8=; b=aVQDx/IoG095Wu8qaiiqMieFKG
        fDGI7PXV7fM9jRSMqL+/t/pVbgkPnjwGD/eZBoOqh+NDcdSoyU6Iv8KbPLEWs2PvNr4GTOPj0dkV/
        wZrA1oGDaIUr67tJ7teEAllPfwUCdeRze8GcUUELxi14ko3Jfudw0/dGY+FiUAYowGqdSmGfSEOIs
        B2KbJ8EMkW4I6AhzUox8rUmb92/gErc/rExiQM/CMX9/VzzQxSclLRfA9137+JyKdG5MJQX7eZp3J
        3yY24l9Py8wVd0cmMMSjknS5qhaZNfe10gpCGmq3z7kZrZ4U9Znv5RPIWvcAEwVf8ibFedfnS2P6R
        4iC5wuLQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qA492-008gMg-E8; Fri, 16 Jun 2023 07:45:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4C3CC300208;
        Fri, 16 Jun 2023 09:45:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCAA3245F1E40; Fri, 16 Jun 2023 09:45:18 +0200 (CEST)
Date:   Fri, 16 Jun 2023 09:45:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/cputime: Make IRQ time accounting configurable at
 boot time
Message-ID: <20230616074518.GW4253@hirez.programming.kicks-ass.net>
References: <20230615203745.1259-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615203745.1259-1-bvanassche@acm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 01:37:26PM -0700, Bart Van Assche wrote:
> Some producers of Android devices want IRQ time accounting enabled while
> others want IRQ time accounting disabled. Hence, make IRQ time accounting
> configurable at boot time.

Why would they want this disabled? IRQ time accounting avoids a number
of issues under high irq/softirq pressure.

Disabling this makes no sense.
