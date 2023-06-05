Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ED4722C4E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjFEQPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjFEQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:15:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1777394
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 09:15:27 -0700 (PDT)
Date:   Mon, 5 Jun 2023 18:15:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685981725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fHaMvgZhrAPu22usTTbVNANfgGEX1/mM2dnPtZmN1wU=;
        b=Df+n/msmnDJUBqJDGGm0SKPBdenv91YdFi91zsnBRPnbkFotCIUSYWBu9eZXP/4fdte6a3
        GTG5nbpGq5rYHY3w53vefF38ToS5c0aqpGdRSAj2V+A7COcjD+XS8mZBPMNiTgBT3RIDdi
        29rEB785Ejr7LEMARm8ZR45lXIn12BPH+2CGhaAoy0STVgcsAzP1eLBQcsbRXbGWbVNhC2
        j+byqBg5QXcXkQYG5564aG8u0j5K2ePgbzSolJ5Eitlxc+LSfncnlugeb+LXWK7tx/nwlk
        G5ICMeaKkS/qZsgfuk44wvrQizLmjXpTuHmZgDCQMRDSRHPXogH/llWUiIadsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685981725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fHaMvgZhrAPu22usTTbVNANfgGEX1/mM2dnPtZmN1wU=;
        b=cGbi25nf0LmIl9JjvDzsE4gDGNQGO7/F839FxPJVkBglk3s1M6bvUbY0Yk24xvpUvAwhSs
        AqRtC8xPbyhTB9BA==
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
Message-ID: <20230605161523.QGDVZaXZ@linutronix.de>
References: <Y++UzubyNavLKFDP@linutronix.de>
 <20230525165244.GV83892@hirez.programming.kicks-ass.net>
 <20230526080543.GF38236@hirez.programming.kicks-ass.net>
 <20230526151335.oPeFiIdq@linutronix.de>
 <20230601091234.GW83892@hirez.programming.kicks-ass.net>
 <20230602082503.GA624418@hirez.programming.kicks-ass.net>
 <20230602103731.GA630648@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230602103731.GA630648@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-02 12:37:31 [+0200], Peter Zijlstra wrote:
> I'll stick this in front -- see what happens ;-)

Tested this with the previous one. All good.

Sebastian
