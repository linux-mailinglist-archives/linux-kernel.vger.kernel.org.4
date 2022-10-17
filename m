Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A873601681
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJQSk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiJQSkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:40:23 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68788733C2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:40:21 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 29HIdeAM1523530
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 17 Oct 2022 11:39:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 29HIdeAM1523530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022100601; t=1666031982;
        bh=ayWKj5OxbMwLJRpGCYUSRaH2lEGi5P4bc0Ya3yQKFtg=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=INPdfgatmwg8qvs2Gg+KQrvuaYhulauPFLqUQrSJgqhSYYuLzbkWhu/MRfMtbjM4+
         2I/Y1jHScAMfRk+JeBe+jufSEkkoPGAQfs8wgxn1fL9rtg6oenc4zdix7vIKBLMr5X
         6PAHD9AZZvt5GqMJuC08UeytQlvcGkVTeYfIuGAjUfqfUhauLrTigexCQS4eMdCE+J
         OLrViVV8uz6kg0qExhgft0mYpky44ONixmNbLcRKLxTOuUdCI3avsnTA/oSa4Qlt2R
         CpSZ5uv+I2GdPfwiLyjYXrjtxPyvDb0hMMNnAVHR+zTFX5cPRAgjgfVBXLuixoysv/
         jUDJsguTGIXRg==
Date:   Mon, 17 Oct 2022 11:39:40 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Xin Li'" <xin3.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>
Subject: RE: [PATCH v3 3/6] x86/gsseg: make asm_load_gs_index() take an u16
User-Agent: K-9 Mail for Android
In-Reply-To: <bdf3f750103f4b64a697191d1edb8ad0@AcuMS.aculab.com>
References: <20221013200134.1487-1-xin3.li@intel.com> <20221013200134.1487-4-xin3.li@intel.com> <86f60a8edf0e458c86cd84970364cfa2@AcuMS.aculab.com> <1FCB6543-A666-4423-986B-4CDA1B4DD016@zytor.com> <bdf3f750103f4b64a697191d1edb8ad0@AcuMS.aculab.com>
Message-ID: <B75B19B9-1560-4002-9E76-D7C4D605EFB0@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 17, 2022 12:49:41 AM PDT, David Laight <David=2ELaight@ACULAB=2E=
COM> wrote:
>From: H=2E Peter Anvin
>> Sent: 15 October 2022 03:41
>>=20
>> On October 14, 2022 5:28:25 AM PDT, David Laight <David=2ELaight@ACULAB=
=2ECOM> wrote:
>> >From: Xin Li
>> >> Sent: 13 October 2022 21:02
>> >>
>> >> From: "H=2E Peter Anvin (Intel)" <hpa@zytor=2Ecom>
>> >>
>> >> Let gcc know that only the low 16 bits of load_gs_index() argument
>> >> actually matter=2E It might allow it to create slightly better
>> >> code=2E However, do not propagate this into the prototypes of functi=
ons
>> >> that end up being paravirtualized, to avoid unnecessary changes=2E
>> >
>> >Using u16 will almost always make the code worse=2E
>> >At some point the value has to be masked and/or extended
>> >to ensure an out of range value doesn't appear in
>> >a register=2E
>> >
>> >	David
>>=20
>> Is that a general statement or are you actually invoking it in this cas=
e?
>> This is about it being a narrowing input, *removing* such constraints=
=2E
>
>It is a general statement=2E
>You suggested you might get better code=2E
>If fact you'll probably get worse code=2E
>It might not matter here, but =2E=2E=2E
>
>Most modern calling conventions use cpu register to pass arguments
>and results=2E
>So the compiler is required to ensure that u16 values are in range
>in either the caller or called code (or both)=2E
>Just because the domain of a value is small doesn't mean that
>the best type isn't 'int' or 'unsigned int'=2E
>
>Additionally (except on x86) any arithmetic on sub-32bit values
>requires additional instructions to mask the result=2E
>
>Even on x86-64 if you index an array with an 'int' the compiler
>has to generate code to sign extend the value to 64 bits=2E
>You get better code for 'signed long' or unsigned types=2E
>This is probably true for all 64bit architectures=2E
>
>Since (most) cpu have both sign extending an zero extending
>loads from memory, it can make sense to use u8 and u16 to
>reduce the size of structures=2E
>But for function arguments and function locals it almost
>always makes the code worse=2E
>
>	David
>
>-
>Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
>Registration No: 1397386 (Wales)
>

Ok=2E You are plain incorrect in this case for two reasons:

1=2E The x86-64 calling convention makes it up to the receiver (callee for=
 arguments, caller for returns) to do such masking of values=2E

2=2E The consumer of the values here does not need any masking or extensio=
ns=2E

So this is simply telling the compiler what the programmer knows=2E
