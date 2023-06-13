Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F5572E3D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241375AbjFMNOH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Jun 2023 09:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbjFMNOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:14:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A5F10E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:14:00 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-243-RHC9QOAiM16LchjskEkjgg-1; Tue, 13 Jun 2023 14:13:58 +0100
X-MC-Unique: RHC9QOAiM16LchjskEkjgg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 13 Jun
 2023 14:13:54 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 13 Jun 2023 14:13:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alasdair Kergon <agk@redhat.com>
Subject: RE: [PATCH v1 1/1] dm integrity: Use %*ph for printing hexdump of a
 small buffer
Thread-Topic: [PATCH v1 1/1] dm integrity: Use %*ph for printing hexdump of a
 small buffer
Thread-Index: AQHZnXeLSrJRda3jvkm5aLqRk0NSF6+Ithrw
Date:   Tue, 13 Jun 2023 13:13:54 +0000
Message-ID: <516b13b634374885891ac1e808d37ce3@AcuMS.aculab.com>
References: <20230612214751.9662-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230612214751.9662-1-andriy.shevchenko@linux.intel.com>
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
> Sent: 12 June 2023 22:48
> 
> The kernel already has a helper to print a hexdump of a small
> buffer via pointer extension. Use that instead of open coded
> variant.
> 
> In long term it helps to kill pr_cont() or at least narrow down
> its use.
> 
> Note, the format is slightly changed, i.e. the colon is not printed
> before the buffer dump and the trailing space is always printed.
> These are not a problem since it's a debug message. Also the IV dump
> is limited by 64 bytes which seems fine.
...
> +#define DEBUG_bytes(bytes, len, msg, ...)	printk(KERN_DEBUG msg " %*ph\n", ##__VA_ARGS__, len,
> bytes)

Using:
	printf(KERN_DEBUG msg "%s%*ph\n", ##__VA_ARGS__, len ? ": " : "", len, bytes)
would add back the optional ':'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

