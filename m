Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BB360F4AA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiJ0KNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiJ0KNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:13:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DABC12791C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ujmvw+TZR5k4uN3HoiTdwWd48LImUMTszRZtFiaHkwM=; b=ejJYmTDqpc2QFxATe5idMUsCi0
        s0DaAVktP9XDrv10JRqJXpEU8DF0NXIh+5Hh7TFqb3UKmI8vZHAENIe0+rlnABnmdsiTEOBUyqmSo
        XAGQC9b4ltYk/2iXbC0+roivF8FDPM7mw2/Akm0TZRCB1UbPnwTi+HTPXw4Jqf58X1neH6/XpnmYA
        dY96tvBZ82dikRUKk8c0Xc0fFlUrLlJaECJpBYLHUnr63rfImTF0W5rmIsLammfflZPFLxjhsGbbF
        sgt5/g+WJ/9Ckg6R+5ruiSwqcpVd7nqRWh1GMAI9VLCy9U3mgRMKiGGKaKMT45Ld5F+NNnibtB4Rt
        ZvdGUFUQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onztA-0007C6-D6; Thu, 27 Oct 2022 10:13:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 344BD30041D;
        Thu, 27 Oct 2022 12:13:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D3F32C450484; Thu, 27 Oct 2022 12:13:23 +0200 (CEST)
Date:   Thu, 27 Oct 2022 12:13:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Seth Jenkins <sethjenkins@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [tip:x86/mm] [x86/mm] 1248fb6a82:
 Kernel_panic-not_syncing:kasan_populate_pmd:Failed_to_allocate_page
Message-ID: <Y1pZwwuRfYmh8A4L@hirez.programming.kicks-ass.net>
References: <202210241508.2e203c3d-yujie.liu@intel.com>
 <Y1e7kgKweck6S954@hirez.programming.kicks-ass.net>
 <278cc353-6289-19e8-f7a9-0acd70bc8e11@gmail.com>
 <Y1pXJheAg+sMj7eG@yujie-X299>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1pXJheAg+sMj7eG@yujie-X299>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 06:02:14PM +0800, Yujie Liu wrote:
> Thanks for posting the fix. The issue is resolved after applying the fix.
> 
>   Tested-by: Yujie Liu <yujie.liu@intel.com>

Excellent; I'll talk to Dave if we want to ammend the original commit or
stuff this on top but we'll get it sorted.

Thanks!
