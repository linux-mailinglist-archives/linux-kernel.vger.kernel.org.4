Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E11686640
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjBAMvx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Feb 2023 07:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjBAMvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:51:51 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CA4410AE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:51:49 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-315-EUqCJtIWNAG0cMue-ssItw-1; Wed, 01 Feb 2023 12:51:47 +0000
X-MC-Unique: EUqCJtIWNAG0cMue-ssItw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Wed, 1 Feb
 2023 12:51:46 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Wed, 1 Feb 2023 12:51:46 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?iso-8859-1?Q?=27Thomas_Wei=DFschuh=27?= <linux@weissschuh.net>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/8] objtool: reduce maximum memory usage
Thread-Topic: [PATCH v2 0/8] objtool: reduce maximum memory usage
Thread-Index: AQHZNSfK1Pp9dgy34k2krggntueDJq66C5XQ
Date:   Wed, 1 Feb 2023 12:51:46 +0000
Message-ID: <093273245f624bcab3fac9d391f6d249@AcuMS.aculab.com>
References: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
 <20230129214339.76hyytrllggbvuat@t-8ch.de>
 <20230131000356.5u2siglndnjyarql@treble>
 <20230131035442.yzq4opasci7azt2j@t-8ch.de>
In-Reply-To: <20230131035442.yzq4opasci7azt2j@t-8ch.de>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh.
> Sent: 31 January 2023 03:55
...
> I have another half-finished series that replaces the doubly-linked
> list_heads used by elf.h with a custom singly-linked list.
> This would save a few pointers per struct.
> 
> Do you think this is worth it?

If you allocate the structures in blocks of (say) 256 you
can use an array of pointers to the blocks and then a
32bit index instead of a 64bit pointer.

For real space-saving you might decide that the index can
never exceed 2^^24 and use a bitfield!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

