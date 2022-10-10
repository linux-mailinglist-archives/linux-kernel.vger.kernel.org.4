Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EC65FA428
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJJTZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJJTZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:25:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B1A1EED5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:25:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4A61CCE112F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8805EC433B5;
        Mon, 10 Oct 2022 19:25:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ls1X9Stp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665429935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u1dau1ILq4K1SLnMV7OfJT4Jf3QTq6a9M8PPwHLNsEw=;
        b=Ls1X9StpbNO6Y5c59ai+kQ7fG+JCCnVXI9pmnNhJ+Io0XoT7MV+JA5+oasLz63JrfLli0F
        ptFNxcuDQnHTpSufmIMkxiagGnHWOsXPXV9ulqRtSgLTxHjd7EmIRZkH+TVTrpW7Vmgs7i
        m13L0jWi3bWALMhvFPi9kqeBMj9RdVw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0121947c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 10 Oct 2022 19:25:34 +0000 (UTC)
Date:   Mon, 10 Oct 2022 13:25:25 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
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
Message-ID: <Y0RxpSFyn9m68zIb@zx2c4.com>
References: <87edvhntv0.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87edvhntv0.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Sun, Oct 09, 2022 at 10:01:39PM +1100, Michael Ellerman wrote:
> powerpc updates for 6.1
> 
>  - Remove our now never-true definitions for pgd_huge() and p4d_leaf().
> 
>  - Add pte_needs_flush() and huge_pmd_needs_flush() for 64-bit.
> 
>  - Add support for syscall wrappers.
> 
>  - Add support for KFENCE on 64-bit.
> 
>  - Update 64-bit HV KVM to use the new guest state entry/exit accounting API.
> 
>  - Support execute-only memory when using the Radix MMU (P9 or later).
> 
>  - Implement CONFIG_PARAVIRT_TIME_ACCOUNTING for pseries guests.
> 
>  - Updates to our linker script to move more data into read-only sections.
> 
>  - Allow the VDSO to be randomised on 32-bit.
> 
>  - Many other small features and fixes.

FYI, something in here broke the wireguard test suite, which runs the
iperf3 networking utility. The full log is here [1], but the relevant part
is: 

[+] NS1: iperf3 -Z -t 3 -c 192.168.241.2
Connecting to host 192.168.241.2, port 5201
iperf3: error - failed to read /dev/urandom: Bad address

I'll see if I can narrow it down a bit more and bisect. But just FYI, in
case you have an intuition.

Jason


[1] https://build.wireguard.com/linux/4de65c5830233e7a4adf2e679510089ec4e210c7/powerpc.log
