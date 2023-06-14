Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C9972F9E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbjFNJ5n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Jun 2023 05:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjFNJ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:57:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A4DC2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:57:40 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-318-cYKJ_jYvN-aJa4XviMzn4A-1; Wed, 14 Jun 2023 10:57:37 +0100
X-MC-Unique: cYKJ_jYvN-aJa4XviMzn4A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 14 Jun
 2023 10:57:33 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 14 Jun 2023 10:57:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH] tracing: Add a debug_trace_printk() function
Thread-Topic: [PATCH] tracing: Add a debug_trace_printk() function
Thread-Index: AQHZnYZXodJCXa8lT0+2rDQCqxMQQa+KDaeA
Date:   Wed, 14 Jun 2023 09:57:33 +0000
Message-ID: <e2f3ce97329d488d8ecd4fea5fbdb4f6@AcuMS.aculab.com>
References: <20230612193337.0fb0d3ca@gandalf.local.home>
In-Reply-To: <20230612193337.0fb0d3ca@gandalf.local.home>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt
> Sent: 13 June 2023 00:34
> 
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> While doing some tracing and kernel debugging, I found that some of my
> trace_printk()s were being lost in the noise of the other code that was
> being traced. Having a way to write trace_printk() not in the top level
> trace buffer would have been useful.
> 
> There was also a time I needed to debug ftrace itself, where
> trace_printk() did not hit the paths that were being debugged. But because
> the trace that was being debugged, was going into the top level ring
> buffer, it was causing issues for seeing what is to be traced.
> 
> To solve both of the above, add a debug_trace_printk() that can be used
> just like trace_printk() except that it goes into a "debug" instance
> buffer instead. This can be used at boot up as well.
...
> +#ifdef CONFIG_FTRACE_DEBUG_PRINT
> +	debug_trace = trace_array_get_by_name("debug");
> +	if (WARN_ON(!debug_trace))
> +		return;
> +	trace_array_init_printk(debug_trace);
> +#endif

I was wondering if that could be done whenever the "debug"
trace_array is created?
(perhaps only if trace_prink() has been used?)
Since (AFAICT) it could be created at any time??

So you wouldn't really need an extra kernel knob?
(Except to get the boot time trace diverted.)
The trace could go to the global buffer if the debug one
isn't created.

OTOH I'm missing what trace_array_init_prink() does?
It seems to just call alloc_percpu_trace_buffer() with
no arguments.

It looks like alloc_percpu_trace_buffer() is called if there
are any trace_printk() formats in the main kernel.
Hopefully they aren't just in modules??

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

