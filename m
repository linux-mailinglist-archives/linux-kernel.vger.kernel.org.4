Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4E36F6E86
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjEDPCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjEDPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:02:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EB740F2;
        Thu,  4 May 2023 08:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J9lcuz0U78xiVesYVTRvv8JVCKEh3ZCKl4adkGMz7q8=; b=A3tkeyDTbxVkt6nED1FtXwR7g1
        zZTYBRWgzTAAp9BZC1qV19RLdqwHus5AQdNJk4QDytJqfu0d3fusfZd6tmpLHnup1qMzIq1UrlO3r
        jA6uWCDheYZh0N1afd4u6dydMh83H4G0C7c0LyDOr1Qr40sZHIjHkJkow0b886Qh4GbbmeqrET+yC
        BKxh99Ux1Z2HW5bHnTcfrJMEd9lz//bcPqHa45Sgaoqw9q3Kc56na7ZITUjHj87fDXB5OTA+CPbNJ
        Z7SX69si5EG372gxmdBynOePTt2mscU8e3Oeylz4MD/j1jNX9ZkD6PiiSxjMnfY1tl6QpLBO6zlfn
        g1uP3SFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1puaSJ-00AhL6-Rb; Thu, 04 May 2023 15:01:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 00C7B3003CF;
        Thu,  4 May 2023 17:01:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D677D2407F43F; Thu,  4 May 2023 17:01:13 +0200 (CEST)
Date:   Thu, 4 May 2023 17:01:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with
 smp_call_function*()
Message-ID: <20230504150113.GB1744142@hirez.programming.kicks-ass.net>
References: <20230406075718.68672-1-leobras@redhat.com>
 <20230406095519.GG386572@hirez.programming.kicks-ass.net>
 <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com>
 <20230503145900.GC1689514@hirez.programming.kicks-ass.net>
 <xhsmh7ctojoia.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh7ctojoia.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 12:59:41PM +0100, Valentin Schneider wrote:

> With that said, I suppose this could still be helpful for e.g. osnoise to
> hook into and point the finger at which CPU/context sent the problematic
> IPI. Or more generally, as Leonardo suggested, to measure CSD IPI delivery
> times.
> 
> One thing though is that trace_ipi_send_cpu*() is not used solely for
> CSD's, cf. irq_work_raise() or smp_send_reschedule(). We might want to
> split that into e.g. trace_csd_queue_cpu*() + trace_ipi_send*().
> 
> Something like so...
> 

Yeah, looks about right I suppose.. it generates more events, but given
we need the csd that's inevitable.
