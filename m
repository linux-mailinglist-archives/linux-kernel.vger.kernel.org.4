Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A14712953
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244120AbjEZPXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244098AbjEZPXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:23:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53121BF;
        Fri, 26 May 2023 08:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=FzjfinT/ioSfMfRQf9Wi9HSHANyBVVOUL7KRBB5Z9sE=; b=lneXXqHzx5OFRE2gEMPCZH+aOM
        gqZa67jePQ1cJkeZFqkqAtbDR80Z1z+CwfnV7aTKBMo1GwlG4JF2+IPLvGFEVxiMUD0EHu6oIwKmW
        ETvQh5kdFuU0PfDwXhcmTOOFUTo8KHkv0lTjJWecBDRlK5TYC9YYXQVz7onLmZiw/hrtWm/sMOKp+
        dm1PPGm0+mlFmY33VGIb5QJjtiETxYabkWoTtRYMpkq3oxMfv1D0e5zTJd2pZ2DFDd+VUE2ibYZsD
        +stFryyLEY4S32LhZdlnX3y5qAqkVz3dxBCeemHu6O8WMCBYzZ0euzoyogsE7bKVg9c6k3FuIna1H
        N+STOeuw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q2ZHE-007cib-2Q;
        Fri, 26 May 2023 15:22:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 898113006B1;
        Fri, 26 May 2023 17:22:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 35F4E22163BC0; Fri, 26 May 2023 17:22:44 +0200 (CEST)
Message-ID: <20230526150549.250372621@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 May 2023 17:05:49 +0200
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
        qiang1.zhang@intel.com, rcu@vger.kernel.org, tj@kernel.org,
        tglx@linutronix.de
Subject: [RFC][PATCH 0/2] Lock and Pointer guards
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Yesterday I was annoyed for the lack of RAII lock guards for entirely spurious
reason, but since you sometimes gotta do silly things I spend today creating some.

My initial (failed) attempts tried to combine __cleanup, _Generic and
__auto_type, but the compilers refused. I've also Googled around and found
(among many others) the QEMU and Glib guards. However I don't like them because
they end up relying on function pointers/indirect calls.

Hence the current pile of CPP hackery.. no indirect calls in sight.

I really like how they end up simplifying the code, but perhaps y'all hate them
with a passion?

I'm thinking we'll at least have a good brawl over naming, esp. the void_guard
needs a better name.

Compile and boot tested with x86_64-defconfig.

