Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B840861DE1A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 21:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiKEUzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 16:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiKEUzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 16:55:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECF8E097
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 13:55:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1088C60B92
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 20:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D08C433D6;
        Sat,  5 Nov 2022 20:54:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ngpdoQqf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667681644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i7VzbHs3BM65bfeje5J/vcPyhiPEz9B6um2ZY1Qg0CY=;
        b=ngpdoQqfSX6MNYGUji9kC1NBLZQAZtE8ptWolbRaV2PE7nBQD9BLrEoNhbt6FrYjGI33p8
        Qg+qOVCAhyRFXzML7v0FR2sd6aR/CObgEkqTm9L5ykJgab/bCdDTM4VOv/v/xTcVLA/KTW
        q9UfOCmJuV5DNoiHgGR3xdkte6DAnqY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id eb30089a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 5 Nov 2022 20:54:04 +0000 (UTC)
Date:   Sat, 5 Nov 2022 21:54:01 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de
Subject: Re: [PATCH 11/13] x86_64: Remove pointless set_64bit() usage
Message-ID: <Y2bNaRrb/1BSWdQr@zx2c4.com>
References: <20221022111403.531902164@infradead.org>
 <20221022114425.168036718@infradead.org>
 <Y2QR/BRHjjYUNszh@dev-arch.thelio-3990X>
 <CAFULd4bkn3i0ds1ywhxAZBQH+1O-zbPWscUqjoEcv4xvnxOnSw@mail.gmail.com>
 <Y2QYHZsZNs33NXZB@dev-arch.thelio-3990X>
 <CAHk-=wjCBOwSWec+=h08q3Gbr4UjSfX46GrQjzHZLFokziS7nA@mail.gmail.com>
 <Y2U3WdU61FvYlpUh@hirez.programming.kicks-ass.net>
 <CAHk-=wggJFQJmWtvsFVt69hzRXW3zD5+9q-1Laz=NoZQ8Fy9Ag@mail.gmail.com>
 <Y2ZlS3SHeAPOkVmN@zx2c4.com>
 <Y2Z9yzmtYtmYi5rx@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2Z9yzmtYtmYi5rx@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 04:14:19PM +0100, Peter Zijlstra wrote:
> Also:
> 
> $ ./align
> 16, 16
> 
> ---
> 
> #include <stdio.h>
> 
> int main(int argx, char **argv)
> {
> 	__int128 a;
> 
> 	printf("%d, %d\n", sizeof(a), __alignof(a));
> 	return 0;
> }

zx2c4@thinkpad /tmp $ x86_64-linux-musl-gcc -O2 a.c -static && qemu-x86_64 ./a.out
16, 16
zx2c4@thinkpad /tmp $ aarch64-linux-musl-gcc -O2 a.c -static && qemu-aarch64 ./a.out
16, 16
zx2c4@thinkpad /tmp $ powerpc64le-linux-musl-gcc -O2 a.c -static && qemu-ppc64le ./a.out
16, 16
zx2c4@thinkpad /tmp $ s390x-linux-musl-gcc -O2 a.c -static && qemu-s390x ./a.out
16, 8
zx2c4@thinkpad /tmp $ riscv64-linux-musl-gcc -O2 a.c -static && qemu-riscv64 ./a.out
16, 16

Er, yea, you're right. Looks like of these, it's just s390x, so
whatever.

Jason
