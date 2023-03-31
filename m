Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5806D1AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjCaIuM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 04:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjCaIuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:50:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50743E053
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:49:55 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-80-JFvASr4sPtGH8Goypuzf7g-1; Fri, 31 Mar 2023 09:49:51 +0100
X-MC-Unique: JFvASr4sPtGH8Goypuzf7g-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 31 Mar
 2023 09:49:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 31 Mar 2023 09:49:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Wu Zongyong' <wuzongyong@linux.alibaba.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wutu.xq2@linux.alibaba.com" <wutu.xq2@linux.alibaba.com>
Subject: RE: [RFC PATCH] x86/insn: support decode MOVSXD instruction for MMIO
Thread-Topic: [RFC PATCH] x86/insn: support decode MOVSXD instruction for MMIO
Thread-Index: AQHZY3fogCXZ9lyaeEGX/VkAF56JI68Uk4Wg
Date:   Fri, 31 Mar 2023 08:49:48 +0000
Message-ID: <94c3f7ba1caa45f7ba503cde6e0c79d2@AcuMS.aculab.com>
References: <1655f5dc49ab77f94e350ecbdc93e8d9b31acf61.1680058548.git.wuzongyong@linux.alibaba.com>
 <20230330123951.b5vujv67c7q3dhay@box.shutemov.name>
 <20230331022414.GB435@L-PF27918B-1352.localdomain>
In-Reply-To: <20230331022414.GB435@L-PF27918B-1352.localdomain>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu Zongyong
> Sent: 31 March 2023 03:24
> 
> On Thu, Mar 30, 2023 at 03:39:51PM +0300, kirill.shutemov@linux.intel.com wrote:
> > On Wed, Mar 29, 2023 at 10:59:37AM +0800, Wu Zongyong wrote:
> > > It seems MOVSXD which opcode is 0x63 is not handled, support
> > > to decode it in insn_decode_mmio().
> >
> > Do you have a particular user in mind?
> To be honest, I don't find a specific user which uses the MOVSXD.
> 
> But both Intel and AMD's instructions reference contains MOVSXD and lots
> of MOVSXD instructions occur when I "objdump -S vmlinux", so I think it
> may be useful to support it in insn_decode_mmio().
> 
> Are there some special consideration about this instruction?

It is a sign-extending memory read (32bit to 64bit).
You pretty much never want to do that to a device register.
Also kernel code should be using readl() (etc) which do
unsigned reads.
So they should never happen for mmio.

Of course, if you mmap() PCIe space directly into a program's
address space anything might happen ...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

