Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C550719503
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjFAIE6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jun 2023 04:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjFAIEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:04:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196A197
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:04:48 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-12-ZZ_0crTpOS2e4R0wAwNCcQ-1; Thu, 01 Jun 2023 09:04:46 +0100
X-MC-Unique: ZZ_0crTpOS2e4R0wAwNCcQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 1 Jun
 2023 09:04:43 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 1 Jun 2023 09:04:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Preble, Adam C'" <adam.c.preble@intel.com>,
        Pavel Machek <pavel@ucw.cz>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: How do I force an IBT trap in a demo kernel module?
Thread-Topic: How do I force an IBT trap in a demo kernel module?
Thread-Index: AdmNrJN/HBQNXQy0RfSVuasMlQAruQAaPVaQALWt3oAAybiRcAAStlQg
Date:   Thu, 1 Jun 2023 08:04:43 +0000
Message-ID: <8ee1b8453e614b5b930d13c2f3747221@AcuMS.aculab.com>
References: <PH7PR11MB65237A81D8258BB1E10969A9A9409@PH7PR11MB6523.namprd11.prod.outlook.com>
 <82034ea784e44c5b929f519ceac6c4e0@AcuMS.aculab.com>
 <ZHKG4xQ8vma7lfRQ@localhost>
 <BL3PR11MB6507CA789CD5BD5A7A5EA526A9489@BL3PR11MB6507.namprd11.prod.outlook.com>
In-Reply-To: <BL3PR11MB6507CA789CD5BD5A7A5EA526A9489@BL3PR11MB6507.namprd11.prod.outlook.com>
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

From: Preble, Adam C
> Sent: 01 June 2023 00:02
> 
> It looked to me like I was getting the indirect jump just fine with what I already was doing. Sure, I
> made the instruction pointer volatile and static, but nothing changed just from that.

This ought to compile to code that does what you want..

void func(void) {}

void (*func_ptr)(void) = func;

void test(void)
{
	void (*ptr)(void) = (void *)func_ptr + 4;

	ptr();
}

See https://godbolt.org/z/o8cedv3d4 but that doesn't have the option
that generated the endbra.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

