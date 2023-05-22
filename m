Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637B170C30F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbjEVQMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjEVQMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:12:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978D7B6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Kof4Ubyf4S7Z31yQZ2w4xYy+/GOvsdXgqUlhiAJQaw=; b=q4+StTJbdXWKDwrNRlP/N5Kss5
        dQHUNe9SdQL+zR+DuM1TeJh/aEr+MJHta6JbLORfgkaiP8MWcI4zqYRT2LmCop/Kl6n58S4b7oiHc
        q+td9BM+L2mn6ez/DeF8GmxqaslCzI7C6+GfQmpUnQ+t/ojoMp7FDGQzZNlx6E02t7Rv3AIDU6NCc
        SPlSkxu9C8b0xgnurLe1VjuQXBUnn+3gMzDMF28ic5yCPA0+HaXag3/shZMOwOT9+o0JDvlzrO72w
        N6rzWKkOyYnzYaeQ+LuKU0unzoxYLMcZCs23FrxNY6eU8XHR3T794GFV9TRQ9CU7zxbGmY/d1ILTA
        WbMI2rHw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q188f-0024R2-10;
        Mon, 22 May 2023 16:12:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 297B9300338;
        Mon, 22 May 2023 18:11:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01C0A243487CE; Mon, 22 May 2023 18:11:58 +0200 (CEST)
Date:   Mon, 22 May 2023 18:11:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, paulmck@kernel.org,
        rui.zhang@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        bin.gao@intel.com
Subject: Re: [PATCH RFC] x86/tsc: Make recalibration default on for
 TSC_KNOWN_FREQ cases
Message-ID: <20230522161158.GA3330346@hirez.programming.kicks-ass.net>
References: <20230522033018.1276836-1-feng.tang@intel.com>
 <87h6s4ye9b.ffs@tglx>
 <ZGssENXFKmOk/zL7@feng-clx>
 <87zg5wwppa.ffs@tglx>
 <ZGtnUQJy+1Nrazhy@feng-clx>
 <87pm6swi7z.ffs@tglx>
 <ZGuIL6tyzzZP3kyR@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGuIL6tyzzZP3kyR@feng-clx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 11:20:15PM +0800, Feng Tang wrote:

> And I don't understand the commit log: "On Intel GOLDMONT Atom SoC
> TSC is the only reliable clocksource. We mark TSC reliable to avoid
> watchdog on it."
> 
> Clearly the Denventon I found today has both HPET and ACPI_PM timer:
> 
>   [root@dnv0 ~]# grep .  /sys/devices/system/clocksource/clocksource0/*
>   /sys/devices/system/clocksource/clocksource0/available_clocksource:tsc hpet acpi_pm
>   /sys/devices/system/clocksource/clocksource0/current_clocksource:tsc
>   
> The lscpu info is:
>   
>   Architecture:                    x86_64
>   CPU op-mode(s):                  32-bit, 64-bit
>   Address sizes:                   39 bits physical, 48 bits virtual
>   Byte Order:                      Little Endian
>   CPU(s):                          12
>   On-line CPU(s) list:             0-11
>   Vendor ID:                       GenuineIntel
>   BIOS Vendor ID:                  Intel(R) Corporation
>   Model name:                      Intel(R) Atom(TM) CPU C3850 @ 2.10GHz
>   BIOS Model name:                 Intel(R) Atom(TM) CPU C3850 @ 2.10GHz  CPU @ 2.1GHz
>   BIOS CPU family:                 43
>   CPU family:                      6
>   Model:                           95
>   Thread(s) per core:              1
>   Core(s) per socket:              12
>   Socket(s):                       1
>   Stepping:                        1
> 
> Maybe this cpu model (0x5F) has been used by some type of platforms
> which has met the false alarm watchdog issue.

It has them; but they are not *reliable*.



