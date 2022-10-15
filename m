Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188385FF80F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 04:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJOCm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 22:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJOCmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 22:42:24 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CA76CD33
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 19:42:23 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 29F2fUY61015456
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 14 Oct 2022 19:41:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 29F2fUY61015456
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022100601; t=1665801694;
        bh=zy2Dinix+O5oevVDTCLZtmhUim/7pTHY5oNWDsDD/ok=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=OdqiZfxCGVrsUOaj+Rqkw9uyOL6SPzXeTgofQzL+vg350sMn82Dv6FNMDwfF6s5co
         xAXPh4cQ9RnMmBFfRe1E2ZulmYOx6DmiLcsE6eJ2HojZ/aV21H29geYeqNDjjfsGfO
         OBam8w4JNftYywGXHeDGa9t7cSQvJYe9jptFfgFcM/0zF1jqYtlUdkeJOxlTodkUDM
         szpF7UUSS3TBdOZIhBlQws2GHsoboh6+e27W3fbEg1XPefK3kfZ533O4EMdqmRqc4V
         WDu4CoervSmTOHhwK1NRYVFGKPA7IX7n6f8f/ynjmEHEXRDY7YjhS++El2yU5HzoFp
         q9E7vp0wA9lfA==
Date:   Fri, 14 Oct 2022 19:41:29 -0700
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
In-Reply-To: <86f60a8edf0e458c86cd84970364cfa2@AcuMS.aculab.com>
References: <20221013200134.1487-1-xin3.li@intel.com> <20221013200134.1487-4-xin3.li@intel.com> <86f60a8edf0e458c86cd84970364cfa2@AcuMS.aculab.com>
Message-ID: <1FCB6543-A666-4423-986B-4CDA1B4DD016@zytor.com>
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

On October 14, 2022 5:28:25 AM PDT, David Laight <David=2ELaight@ACULAB=2EC=
OM> wrote:
>From: Xin Li
>> Sent: 13 October 2022 21:02
>>=20
>> From: "H=2E Peter Anvin (Intel)" <hpa@zytor=2Ecom>
>>=20
>> Let gcc know that only the low 16 bits of load_gs_index() argument
>> actually matter=2E It might allow it to create slightly better
>> code=2E However, do not propagate this into the prototypes of functions
>> that end up being paravirtualized, to avoid unnecessary changes=2E
>
>Using u16 will almost always make the code worse=2E
>At some point the value has to be masked and/or extended
>to ensure an out of range value doesn't appear in
>a register=2E
>
>	David
>
>-
>Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
>Registration No: 1397386 (Wales)
>
>

Is that a general statement or are you actually invoking it in this case? =
This is about it being a narrowing input, *removing* such constraints=2E
