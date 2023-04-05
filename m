Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D619B6D7A08
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbjDEKmW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Apr 2023 06:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237481AbjDEKmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:42:19 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2CD4C02
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 03:42:08 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-71-Q9nGlsy1NBeW-8bllFn16w-1; Wed, 05 Apr 2023 11:42:06 +0100
X-MC-Unique: Q9nGlsy1NBeW-8bllFn16w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 5 Apr
 2023 11:42:03 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 5 Apr 2023 11:42:03 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Triplett' <josh@joshtriplett.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] prctl: Add PR_GET_AUXV to copy auxv to userspace
Thread-Topic: [PATCH v2] prctl: Add PR_GET_AUXV to copy auxv to userspace
Thread-Index: AQHZZvF0xTrvFiiVXUaEsGS9R+Yyu68chzVQ
Date:   Wed, 5 Apr 2023 10:42:03 +0000
Message-ID: <795caad1048c4ac2b831b321f9efe9d6@AcuMS.aculab.com>
References: <d81864a7f7f43bca6afa2a09fc2e850e4050ab42.1680611394.git.josh@joshtriplett.org>
In-Reply-To: <d81864a7f7f43bca6afa2a09fc2e850e4050ab42.1680611394.git.josh@joshtriplett.org>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Triplett
> Sent: 04 April 2023 13:32
> 
> If a library wants to get information from auxv (for instance,
> AT_HWCAP/AT_HWCAP2), it has a few options, none of them perfectly
> reliable or ideal:
> 
> - Be main or the pre-main startup code, and grub through the stack above
>   main. Doesn't work for a library.
> - Call libc getauxval. Not ideal for libraries that are trying to be
>   libc-independent and/or don't otherwise require anything from other
>   libraries.
> - Open and read /proc/self/auxv. Doesn't work for libraries that may run
>   in arbitrarily constrained environments that may not have /proc
>   mounted (e.g. libraries that might be used by an init program or a
>   container setup tool).
> - Assume you're on the main thread and still on the original stack, and
>   try to walk the stack upwards, hoping to find auxv. Extremely bad
>   idea.
> - Ask the caller to pass auxv in for you. Not ideal for a user-friendly
>   library, and then your caller may have the same problem.
> 
> Add a prctl that copies current->mm->saved_auxv to a userspace buffer.
...
> +static int prctl_get_auxv(void __user *addr, unsigned long len)
> +{
> +	struct mm_struct *mm = current->mm;
> +	unsigned long size = min_t(unsigned long, sizeof(mm->saved_auxv), len);

Don't use min_t() fix the types.
min_t() is a horrid abomination that is massively overused.

It would be better to have a min_unchecked() that just skips the
type test.

Or accept my patches that allows allow min/max against
compile-time constants between 0 and MAX_INT.
After all, the only reason for the type check is to try
to avoid negative values becoming large positive ones
due to integer promotions.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

