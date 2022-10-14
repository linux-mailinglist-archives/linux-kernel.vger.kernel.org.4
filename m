Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857B85FEDFF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 14:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJNM2g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Oct 2022 08:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJNM2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:28:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C0E164BD6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 05:28:30 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-91-9xlD7b7vMy-uSIX3ILrAOQ-1; Fri, 14 Oct 2022 13:28:28 +0100
X-MC-Unique: 9xlD7b7vMy-uSIX3ILrAOQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 14 Oct
 2022 13:28:26 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Fri, 14 Oct 2022 13:28:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Xin Li' <xin3.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>
Subject: RE: [PATCH v3 3/6] x86/gsseg: make asm_load_gs_index() take an u16
Thread-Topic: [PATCH v3 3/6] x86/gsseg: make asm_load_gs_index() take an u16
Thread-Index: AQHY30Gyx3nzbyqdTEiu3El5Q4Xlsa4N0NzA
Date:   Fri, 14 Oct 2022 12:28:25 +0000
Message-ID: <86f60a8edf0e458c86cd84970364cfa2@AcuMS.aculab.com>
References: <20221013200134.1487-1-xin3.li@intel.com>
 <20221013200134.1487-4-xin3.li@intel.com>
In-Reply-To: <20221013200134.1487-4-xin3.li@intel.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Li
> Sent: 13 October 2022 21:02
> 
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> Let gcc know that only the low 16 bits of load_gs_index() argument
> actually matter. It might allow it to create slightly better
> code. However, do not propagate this into the prototypes of functions
> that end up being paravirtualized, to avoid unnecessary changes.

Using u16 will almost always make the code worse.
At some point the value has to be masked and/or extended
to ensure an out of range value doesn't appear in
a register.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

