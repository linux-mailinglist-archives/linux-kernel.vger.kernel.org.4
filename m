Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1D872E3E9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjFMNTS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Jun 2023 09:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238917AbjFMNTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:19:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C509FE6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:19:14 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-228-rngPUjIbMZOIePNVh0MRxQ-1; Tue, 13 Jun 2023 14:19:11 +0100
X-MC-Unique: rngPUjIbMZOIePNVh0MRxQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 13 Jun
 2023 14:19:07 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 13 Jun 2023 14:19:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>
Subject: RE: [PATCH v1 1/1] signal: Use %*ph for printing hexdump of a small
 buffer
Thread-Topic: [PATCH v1 1/1] signal: Use %*ph for printing hexdump of a small
 buffer
Thread-Index: AQHZnXm9T9wPdtRS4UqlStR1qGjeqK+It5Rg
Date:   Tue, 13 Jun 2023 13:19:07 +0000
Message-ID: <d2772156abdb4b2388d9b6f701c81adc@AcuMS.aculab.com>
References: <20230612220334.44177-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230612220334.44177-1-andriy.shevchenko@linux.intel.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko
> Sent: 12 June 2023 23:04
> 
> The kernel already has a helper to print a hexdump of a small
> buffer via pointer extension. Use that instead of open coded
> variant.
> 
> In long term it helps to kill pr_cont() or at least narrow down
> its use.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/signal.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index b5370fe5c198..6be2df76f0b4 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1259,18 +1259,17 @@ static void print_fatal_signal(int signr)
>  	pr_info("potentially unexpected fatal signal %d.\n", signr);
> 
>  #if defined(__i386__) && !defined(__arch_um__)
> -	pr_info("code at %08lx: ", regs->ip);
>  	{
> +		unsigned char insn[16];
>  		int i;
> +
>  		for (i = 0; i < 16; i++) {
> -			unsigned char insn;
> -
> -			if (get_user(insn, (unsigned char *)(regs->ip + i)))
> +			if (get_user(insn[i], (unsigned char __user *)(regs->ip + i)))
>  				break;
> -			pr_cont("%02x ", insn);
>  		}

Isn't that just:
		i = 16 - copy_from_user(insn, (unsigned char __user *)regs->ip, 16);
(the 16 should be sizeof (insn))

	David

> +
> +		pr_info("code at %08lx: %*ph\n", regs->ip, i, insn);
>  	}
> -	pr_cont("\n");
>  #endif
>  	preempt_disable();
>  	show_regs(regs);
> --
> 2.40.0.1.gaa8946217a0b

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

