Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D455FAA61
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 03:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJKBx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 21:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJKBxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 21:53:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE0B81685
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 18:53:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mmf256JJvz4x1F;
        Tue, 11 Oct 2022 12:53:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1665453198;
        bh=ZRpvMeqSZ6mEQLCN7LBkT+rGRLX8drffLmLVKs0WcW8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qlxMOjI4fJq61i7BToI7Q7bibIKUACaqlUPmUoMwgWisLqa8hC7DtklzaoUS3bHfZ
         a1q8aExMewr/OpH7YRXjWheatl5SKwJlvJDRJarguT30LFCpS8IVbcTRuEI2nnkywp
         Xac3clZsCki6nmrFxX+mAFGhpanqGfOS5P06HZcEBd8UsPrj1jBvVqcZ0Ff3GGdRkb
         WXDix2auzLaT+xxAuuN2mar59dtS3WDDDBSEw/qnW7uMlR20rOK0UGYRCymnjgiNoD
         UB2PD3T7jK/QY11d0oczIesCCNg4EHng/3zhQl64agLkCqHpss1CXVgItbprEdwjpM
         0SCbYpPq0FpOA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, ajd@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        christophe.leroy@csgroup.eu, cuigaosheng1@huawei.com,
        david@redhat.com, farosas@linux.ibm.com, geoff@infradead.org,
        gustavoars@kernel.org, haren@linux.ibm.com, hbathini@linux.ibm.com,
        joel@jms.id.au, lihuafei1@huawei.com, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, linuxppc-dev@lists.ozlabs.org,
        lukas.bulwahn@gmail.com, mikey@neuling.org, nathan@kernel.org,
        nathanl@linux.ibm.com, nicholas@linux.ibm.com, npiggin@gmail.com,
        pali@kernel.org, paul@paul-moore.com, rmclure@linux.ibm.com,
        ruscur@russell.cc, windhl@126.com,
        wsa+renesas@sang-engineering.com, ye.xingchen@zte.com.cn,
        yuanjilin@cdjrlc.com, zhengyongjun3@huawei.com
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-1 tag
In-Reply-To: <Y0R6fcvgGA858TQA@zx2c4.com>
References: <87edvhntv0.fsf@mpe.ellerman.id.au> <Y0RxpSFyn9m68zIb@zx2c4.com>
 <Y0R6fcvgGA858TQA@zx2c4.com>
Date:   Tue, 11 Oct 2022 12:53:17 +1100
Message-ID: <874jwbnn1u.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:
> On Mon, Oct 10, 2022 at 01:25:25PM -0600, Jason A. Donenfeld wrote:
>> Hi Michael,
>> 
>> On Sun, Oct 09, 2022 at 10:01:39PM +1100, Michael Ellerman wrote:
>> > powerpc updates for 6.1
>> > 
>> >  - Remove our now never-true definitions for pgd_huge() and p4d_leaf().
>> > 
>> >  - Add pte_needs_flush() and huge_pmd_needs_flush() for 64-bit.
>> > 
>> >  - Add support for syscall wrappers.
>> > 
>> >  - Add support for KFENCE on 64-bit.
>> > 
>> >  - Update 64-bit HV KVM to use the new guest state entry/exit accounting API.
>> > 
>> >  - Support execute-only memory when using the Radix MMU (P9 or later).
>> > 
>> >  - Implement CONFIG_PARAVIRT_TIME_ACCOUNTING for pseries guests.
>> > 
>> >  - Updates to our linker script to move more data into read-only sections.
>> > 
>> >  - Allow the VDSO to be randomised on 32-bit.
>> > 
>> >  - Many other small features and fixes.
>> 
>> FYI, something in here broke the wireguard test suite, which runs the
>> iperf3 networking utility. The full log is here [1], but the relevant part
>> is: 
>> 
>> [+] NS1: iperf3 -Z -t 3 -c 192.168.241.2
>> Connecting to host 192.168.241.2, port 5201
>> iperf3: error - failed to read /dev/urandom: Bad address
>> 
>> I'll see if I can narrow it down a bit more and bisect. But just FYI, in
>> case you have an intuition.
>
> Huh. From iov_iter.c:
>
> static int copyout(void __user *to, const void *from, size_t n)
> {
>         size_t before = n;
>         if (should_fail_usercopy())
>                 return n;
>         if (access_ok(to, n)) {
>                 instrument_copy_to_user(to, from, n);
>                 n = raw_copy_to_user(to, from, n);
>                 if (n == before)
>                         pr_err("SARU n still %zu pointer is %lx\n", n, (unsigned long)to);
>         }
>         return n;
> }
>
> I added the pr_err() there to catch the failure:
> [    3.443506] SARU n still 64 pointer is b78db000
>
> Also I managed to extract the failing portion of iperf3 into something
> smaller:
>
>         int temp;
>         char *x;
>         ssize_t l;
>         FILE *f;
>         char template[] = "/blah-XXXXXX";
>
>         temp = mkstemp(template);
>         if (temp < 0)
>                 panic("mkstemp");
>         if (unlink(template) < 0)
>                 panic("unlink");
>         if (ftruncate(temp, 0x20000) < 0)
>                 panic("ftruncate");
>         x = mmap(NULL, 0x20000, PROT_READ|PROT_WRITE, MAP_PRIVATE, temp, 0);
>         if (x == MAP_FAILED)
>                 panic("mmap");
>         f = fopen("/dev/urandom", "rb");
>         if (!f)
>                 panic("fopen");
>         setbuf(f, NULL);
>         if (fread(x, 1, 0x20000, f) != 0x20000)
>                 panic("fread");

Does that fail for you reliably?

It succeeds for me running under qemu ppce500, though I'm not using your
kernel config yet.

cheers
