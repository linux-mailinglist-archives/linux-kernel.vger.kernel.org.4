Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FE3663BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjAJI76 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Jan 2023 03:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbjAJI7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:59:04 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73EA5F7C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:56:02 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-170-YekVvk-BPaSzqybZP3NNRQ-1; Tue, 10 Jan 2023 08:55:59 +0000
X-MC-Unique: YekVvk-BPaSzqybZP3NNRQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 10 Jan
 2023 08:55:58 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Tue, 10 Jan 2023 08:55:58 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mark Rutland' <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "revest@chromium.org" <revest@chromium.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH 0/8] arm64/ftrace: Add support for
 DYNAMIC_FTRACE_WITH_CALL_OPS
Thread-Topic: [PATCH 0/8] arm64/ftrace: Add support for
 DYNAMIC_FTRACE_WITH_CALL_OPS
Thread-Index: AQHZJDKgXMrizOIIlkyvOnatOuVuDa6XWT2g
Date:   Tue, 10 Jan 2023 08:55:58 +0000
Message-ID: <34e0144b19e149d99719a5ffc834f228@AcuMS.aculab.com>
References: <20230109135828.879136-1-mark.rutland@arm.com>
In-Reply-To: <20230109135828.879136-1-mark.rutland@arm.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland
> Sent: 09 January 2023 13:58
> 
> This series adds a new DYNAMIC_FTRACE_WITH_CALL_OPS mechanism, and
> enables support for this on arm64. This significantly reduces the
> overhead of tracing when a callsite/tracee has a single associated
> tracer, avoids a number of issues that make it undesireably and
> infeasible to use dynamically-allocated trampolines (e.g. branch range
> limitations), and makes it possible to implement support for
> DYNAMIC_FTRACE_WITH_DIRECT_CALLS in future.
> 
> The main idea is to give each ftrace callsite an associated pointer to
> an ftrace_ops. The architecture's ftrace_caller trampoline can recover
> the ops pointer and invoke ops->func from this without needing to use
> ftrace_ops_list_func, which has to iterate through all registered ops.
> 
> To do this, we use -fpatchable-function-entry=M,N, there N NOPs are
> placed before the function entry point...

Doesn't this bump the minimum gcc version up to something like 9.0 ?

How does it interact with the 'CFI stuff' that also uses the same area?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

