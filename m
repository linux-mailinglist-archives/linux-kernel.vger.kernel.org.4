Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE70A7199BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjFAK3p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jun 2023 06:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjFAK30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:29:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF202170A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:28:51 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-318-0fhv99D0OlqPvimtjd92WA-1; Thu, 01 Jun 2023 11:28:49 +0100
X-MC-Unique: 0fhv99D0OlqPvimtjd92WA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 1 Jun
 2023 11:28:45 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 1 Jun 2023 11:28:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@lst.de>,
        Daniel Gomez <da.gomez@samsung.com>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "Sagi Grimberg" <sagi@grimberg.me>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] nvme: Increase block size variable size to 32-bit
Thread-Topic: [PATCH] nvme: Increase block size variable size to 32-bit
Thread-Index: AQHZk8CokMhanTXaB0ibg7NXJWn+ba91vvfg
Date:   Thu, 1 Jun 2023 10:28:45 +0000
Message-ID: <e203876fc20d4c7b932bbff35e8b5e1e@AcuMS.aculab.com>
References: <CGME20230530154254eucas1p241e57af99e4d4ee0e1a677904c3db68c@eucas1p2.samsung.com>
 <20230530154231.8313-1-da.gomez@samsung.com> <20230531130325.GE27468@lst.de>
In-Reply-To: <20230531130325.GE27468@lst.de>
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

From: Christoph Hellwig
> Sent: 31 May 2023 14:03
> 
> > +	u32 bs = 1 << ns->lba_shift;
> 
> Make that 1 a 1U so that we're not going to run into sign extension
> issues when using up all bits in the u32 :)

Not 'sign extension' but obscure integer shift/conversion issues
that really only affect 1's compliment and sign-overpunch cpu.
I'm not even sure gcc/clang support any non 2's compliment systems.

> Otherwise looks good:

Probably improves the generated code as well.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

