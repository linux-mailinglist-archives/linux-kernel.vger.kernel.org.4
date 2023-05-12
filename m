Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA80700645
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbjELLEq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 12 May 2023 07:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240961AbjELLEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:04:32 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2154106CF
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:04:30 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-202-mviBPJlMNOCjVoE72WOORg-1; Fri, 12 May 2023 12:04:27 +0100
X-MC-Unique: mviBPJlMNOCjVoE72WOORg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 12 May
 2023 12:04:26 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 12 May 2023 12:04:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'zhangfei' <zhang_fei_0403@163.com>,
        "ajones@ventanamicro.com" <ajones@ventanamicro.com>
CC:     "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "zhangfei@nj.iscas.ac.cn" <zhangfei@nj.iscas.ac.cn>
Subject: RE: [PATCH v2 2/2] RISC-V: lib: Optimize memset performance
Thread-Topic: [PATCH v2 2/2] RISC-V: lib: Optimize memset performance
Thread-Index: AQHZhK8G+w9eb+3RiUuWNqEpHdcgA69WcTzQ
Date:   Fri, 12 May 2023 11:04:26 +0000
Message-ID: <8e75a8de06124379a916e0169a895f82@AcuMS.aculab.com>
References: <20230511-0b91da227b91eee76f98c6b0@orel>
 <20230512085124.3204-1-zhang_fei_0403@163.com>
In-Reply-To: <20230512085124.3204-1-zhang_fei_0403@163.com>
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
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangfei
> Sent: 12 May 2023 09:51
...
> 2.Storing parallelism and reducing jumps will compensate for the cost of redundant
> stores. Based on the current multiple test results, regardless of which bytes I
> modify to check, its performance is better than byte by byte storage.
> 
> 3.From the above experiment, for the detection of 2, 6, 8, 11, and 14, its overall
> performance is the best.

I'm surprised the RISC-V cpu support parallel stores.
Typical x86 desktop cpu can only do single store (and two loads) every clock.
Clearly doing writes offset from both ends of the buffer does
reduce the number of control instructions relative to the stores.

Since memory writes can easily be queued I'd expect that your
'aim' would be one write every clock.
Achieving that requires knowledge of which instructions can execute in
parallel and the delays associated with correctly predicted branches.
That will very much depend on which RISV-V cpu you have.
Since any loop is at least two instructions (addi+blt) you almost
certainly need at least two writes per iteration.

I do think you are missing a trick though.
IIRC some RISC-V cpu properly support misaligned writes.
In that case, for long enough memset you can do something like:
	end = start + length;
	*(u64 *)start = 0
	start = (start + 24) & ~15;
	do {
		*(u64 *)(start - 16) = 0;
		*(u64 *)(start - 8) = 0;
		start += 16;
	} while (start < end);
	*(u64 *)(end - 16) = 0;
	*(u64 *)(end - 8) = 0;

> Because I am not a chip designer, I find it difficult to answer specific energy
> consumption costs. Do you have any suggestions and how to conduct testing in this
> regard? I think although storage has increased, there has been a corresponding
> reduction in jumps and the use of pipelines.

Energy use will pretty much depend on the number of clocks.
Anything else will be 2nd order noise.

What does make a difference is that increasing the code size
evicts other code from the I-cache.
This has a knock-on effect on overall system performance.
So while massively unrolling a loop will improve a benchmark
(especially if it is run 'hot-cache') there can be negative
effects on overall system performance.
The code size here probably won't have a measurable effect but
unroll to many kb and the effect can get pronounced.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

