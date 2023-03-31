Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712956D248E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjCaP7x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 11:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjCaP7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:59:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EC711163
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:59:49 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-120-C4-P87iaN1WtnBYIDX4e1A-1; Fri, 31 Mar 2023 16:59:46 +0100
X-MC-Unique: C4-P87iaN1WtnBYIDX4e1A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 31 Mar
 2023 16:59:44 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 31 Mar 2023 16:59:44 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Kirill A. Shutemov'" <kirill@shutemov.name>,
        Tom Lendacky <thomas.lendacky@amd.com>
CC:     'Wu Zongyong' <wuzongyong@linux.alibaba.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wutu.xq2@linux.alibaba.com" <wutu.xq2@linux.alibaba.com>
Subject: RE: [RFC PATCH] x86/insn: support decode MOVSXD instruction for MMIO
Thread-Topic: [RFC PATCH] x86/insn: support decode MOVSXD instruction for MMIO
Thread-Index: AQHZY3fogCXZ9lyaeEGX/VkAF56JI68Uk4WggABviA2AAAb3EA==
Date:   Fri, 31 Mar 2023 15:59:44 +0000
Message-ID: <a6a150f332b44914ac286550b63feab0@AcuMS.aculab.com>
References: <1655f5dc49ab77f94e350ecbdc93e8d9b31acf61.1680058548.git.wuzongyong@linux.alibaba.com>
 <20230330123951.b5vujv67c7q3dhay@box.shutemov.name>
 <20230331022414.GB435@L-PF27918B-1352.localdomain>
 <94c3f7ba1caa45f7ba503cde6e0c79d2@AcuMS.aculab.com>
 <20230331100620.mkqg72vwhmlliunn@box.shutemov.name>
 <2220e2f1-2c91-e054-c107-a761fdfe7ffb@amd.com>
 <20230331140916.ofb7ecrjpg7shaav@box>
 <e9c3019f-936f-8bcc-d20f-16220993ff1c@amd.com>
 <20230331152508.s7phgif3iozbbpqn@box>
In-Reply-To: <20230331152508.s7phgif3iozbbpqn@box>
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

From: Kirill A. Shutemov
> Sent: 31 March 2023 16:25
...
> > No, SEV doesn't support userspace MMIO.
> 
> But where do you filter out userspace MMIO? AFAICS, it goes straight from
> from #VC to insn_decode_mmio(). Hm?

Probably by making vm_iomap_memory() fail.

Otherwise MOVSXD is the least of your problems.
You'd need to worry about all the AVX opcodes as well.

Although you might even find kernel code that is using
kernel_fpu_begin/end() to wrap mmio copies that use the
big AVX512 registers.
When each PCIe read takes about 1us (measured into our fpga)
increasing the TLP to 64 bytes (from 8) makes a massive
difference to buffer reads.
(Mostly we try to get the fpga to do writes instead.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

