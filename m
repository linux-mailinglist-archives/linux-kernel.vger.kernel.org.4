Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4B16DF00F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDLJLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjDLJLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:11:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2733DA9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kKoJwXlhArXuG3T+T6H/sNM7MQOlvhRBun0jHnQGmmU=; b=adOZUmuEHIzETlCIOJpQxYwllc
        NMPWxvoAG2vBKJynoqdApqtwzzgnq+ReqliBNCbe9ASskRoodp69ilogD2P+CnK4btFxWBmVjKkaM
        88lDrFqekqa1Vd8ks5SLnA8CJmFjqN/PqMw/Fw0bDBm2zygv6ostJoAqn+joEoBx/merYc0LPJiDo
        IZZojhruFjoGkQOQ7naXIZo3+gJgL7oF1oNfcCTnoQ3xhAIohCG2h9AyexmUK/uF22NHUuH7H3jge
        lPy+EYqWkS1Ta6LxLt/aLY0E1pNfqvZuTfdqUouKwmUMGx+gdKYTztuvSrFQenKQNgIVcc+pjH2Lb
        +Lb64LxA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmWV3-006j2J-2V; Wed, 12 Apr 2023 09:10:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52120300274;
        Wed, 12 Apr 2023 11:10:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B6B025E5A392; Wed, 12 Apr 2023 11:10:43 +0200 (CEST)
Date:   Wed, 12 Apr 2023 11:10:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, Olivier Dion <odion@efficios.com>,
        michael.christie@oracle.com
Subject: Re: [RFC PATCH v4] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230412091043.GC4253@hirez.programming.kicks-ass.net>
References: <20230410150150.2179062-1-mathieu.desnoyers@efficios.com>
 <20230411045225.GA3509@ziqianlu-desk2>
 <20230411131221.GA7356@ziqianlu-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411131221.GA7356@ziqianlu-desk2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 09:12:21PM +0800, Aaron Lu wrote:

> Forget about this "v4 is better than v2 and v3" part, my later test
> showed the contention can also rise to around 18% for v4.

So while I can reproduce the initial regression on a HSW-EX system
(4*18*2) and get lovely things like:

  34.47%--schedule_hrtimeout_range_clock
          schedule
          |
          --34.42%--__schedule
                    |
                    |--31.86%--_raw_spin_lock
                    |          |
                    |           --31.65%--native_queued_spin_lock_slowpath
	            |
                    --0.72%--dequeue_task_fair
                             |
                             --0.60%--dequeue_entity

On a --threads=144 run; it is completely gone when I use v4:

  6.92%--__schedule
         |
         |--2.16%--dequeue_task_fair
         |          |
         |           --1.69%--dequeue_entity
         |                     |
         |                     |--0.61%--update_load_avg
         |                     |
         |                      --0.54%--update_curr
         |
         |--1.30%--pick_next_task_fair
         |          |
         |           --0.54%--set_next_entity
         |
         |--0.77%--psi_task_switch
         |
         --0.69%--switch_mm_irqs_off


:-(
