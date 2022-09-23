Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AE25E792B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiIWLN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiIWLN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:13:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31C81332E4;
        Fri, 23 Sep 2022 04:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zfgAtGE1lzX9cKdfzAVSb8jixMZFgP1pDMu4gWZzZHk=; b=Aceuu38oHTVA5CFZWx2oP+KXGT
        XezfqgfXSkFakEfdz/3LwuygiHo3V15hhuBPQS170VUkaHE1bG5ZV1PzU9o/DFGvmJinwV1eNl3Oq
        rGbsOzCebKqKL3lGJXLzQrJIvbvRLYnkBVPHZVFzy4WrnqOlZZnpcQOoYmUD87Bd1/O3tMq+/O0EK
        1IQ1HZ4YRymL+zTfhr3XCU/r50Hd/OH9ggDqL/+pLY3i1QbagUDCd+gabWy2DsQypRiaWsw1LqXPY
        W49KwuoTl+mh0gomtmls5Z/eytm5BcFPp2Ely9KrdoGMO+EoiMpKESbjx6l6eWfUPjP3RWwGdmefr
        C3j9c/5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obgcL-00FCci-AK; Fri, 23 Sep 2022 11:13:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5FB7B3001FD;
        Fri, 23 Sep 2022 13:13:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 222612BC047C3; Fri, 23 Sep 2022 13:13:12 +0200 (CEST)
Date:   Fri, 23 Sep 2022 13:13:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v4 03/25] rseq: Extend struct rseq with numa node id
Message-ID: <Yy2UyL7vtQqWqKyI@hirez.programming.kicks-ass.net>
References: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
 <20220922105941.237830-4-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922105941.237830-4-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 06:59:18AM -0400, Mathieu Desnoyers wrote:
> diff --git a/include/trace/events/rseq.h b/include/trace/events/rseq.h
> index a04a64bc1a00..6bd442697354 100644
> --- a/include/trace/events/rseq.h
> +++ b/include/trace/events/rseq.h
> @@ -16,13 +16,15 @@ TRACE_EVENT(rseq_update,
>  
>  	TP_STRUCT__entry(
>  		__field(s32, cpu_id)
> +		__field(s32, node_id)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->cpu_id = raw_smp_processor_id();
> +		__entry->node_id = cpu_to_node(raw_smp_processor_id());

Very minor nit: perhaps:

		_entry->node_id = cpu_to_node(__entry->cpu_id);

just in case it does a reload and finds a different value.

>  	),
