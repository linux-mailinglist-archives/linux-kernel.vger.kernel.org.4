Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465B3712E9C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242853AbjEZVBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjEZVBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:01:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5907719C;
        Fri, 26 May 2023 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=urvfHsJBOS8zyeLyl+UdJT8Nl0X+FyS97M0e5Nc2t34=; b=nMUfxulQfyDRFhMgPquBzy1JMU
        7OITUm6XBSHDal5ty4OzC+zkpOof2p0Exb/t6YKVC/OylO9uWEcykEdgS5R4KjvddxsOLJSSk3/sI
        20YmYkOhdP3+uKSAjKK509Nxl+SAUjL8AB/HtnWV6yD4o4/9dXoINaa15zo9O4IQZHdKXdX/s8hga
        kTH/FrvlpQrK1ePCQNDgRykI/bsR+q0NLWc/PYlUtf1TG97P4phZb0r6O8trCLHehDEr5KTgvd2kO
        y7q5ldrzn68zsAGwag8ee8jftSV19rdL5hj596WQuecBK6ZJoMojx0WM3fDtWz5YmYr3I6Kmbk08A
        L495JIMw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q2eYG-007hpR-2z;
        Fri, 26 May 2023 21:00:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 06CB23002F0;
        Fri, 26 May 2023 23:00:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AF53F205BBDB2; Fri, 26 May 2023 23:00:41 +0200 (CEST)
Message-ID: <20230526205204.861311518@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 May 2023 22:52:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, ojeda@kernel.org,
        ndesaulniers@google.com, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Subject: [PATCH v2 0/2] Lock and Pointer guards
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By popular demand, a new and improved version :-)

New since -v1 ( https://lkml.kernel.org/r/20230526150549.250372621@infradead.org )

 - much improved interface for lock guards: guard() and scoped () { }
   as suggested by Linus.
 - moved the ';' for the 'last' additional guard members into the definition
   as suggested by Kees.
 - put __cleanup in the right place with the suggested comment
   as suggested by Kees and Miguel
 - renamed the definition macros DEFINE_LOCK_GUARD_[012] to indicate
   the number of arguments the lock function takes
 - added comments to guards.h
 - renamed pretty much all guard types

Again compile and boot tested x86_64-defconfig


