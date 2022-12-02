Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E90640E77
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiLBT3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiLBT3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:29:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC181EC80E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:29:45 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670009384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hjDSkUH0p+tY8l0rmcBtgIY2pcEuGoRGi40mhKIE2SY=;
        b=A5CdhnpmJv/Ucs9jhukCRT+TAIyOTXmaZcx6PSknpfwM+sSpNPYNnL0qRLW0FtsTije5KV
        5+vWHvDKGhvQQa/uzr5M3EDrb6JXGspPD24X+renn3XJG0ORpO49wN2prqIn2yW7drr87I
        m9pq03/E2far2fZXin9hVgO8kIK7n2G6sC1iulfPlYfCqPKhkoJb4TD6Z8NBX9/1j1IvpO
        YHsMVN7BmcOSyr0XivT8q2j1Pspq7ZdCs9yHWq0h8KHj7bFknllCQS+LsWXrmdDXinUgDU
        eyi1I/GKNRLM9i07mg9hG6Ic061BFxd7O7UK9f/hNJUbrhs1/TI8I9xb+MkYbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670009384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hjDSkUH0p+tY8l0rmcBtgIY2pcEuGoRGi40mhKIE2SY=;
        b=4kpqtHHvDB36JlGi87jNK4zrXZFvAPiqkx8/E5xlj9ik9rXQELs2YO8fy1UiTeGafbvSmI
        iMUyUvCVJBjPT6AA==
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: Re: [Patch V1 6/7] x86/microcode/intel: Print old and new rev
 during early boot
In-Reply-To: <20221129210832.107850-7-ashok.raj@intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-7-ashok.raj@intel.com>
Date:   Fri, 02 Dec 2022 20:29:44 +0100
Message-ID: <87y1rpob87.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29 2022 at 13:08, Ashok Raj wrote:
> Make early loading message to match late loading messages. Print
> both old and new revisions.
>
> This is helpful to know what the BIOS loaded revision is before an early
> update.
>
> microcode: early update: 0x2b000041 -> 0x2b000070 date = 2000-01-01
>
> Store the early BIOS revision and change the print format to match
> late loading message from microcode/core.c

Cache the early BIOS revision before the microcode update and change
print_ucode_info() so it prints both the old and the new revision in the
same format as $function().

>   */
>  static void
> -print_ucode_info(unsigned int new_rev, unsigned int date)
> +print_ucode_info(int old_rev, int new_rev, unsigned int date)

Oh. Forgot to mention that before. Can you please get rid of this
pointless line break after 'static void' ?

>  {
> -	pr_info_once("microcode updated early to revision 0x%x, date = %04x-%02x-%02x\n",
> -		     new_rev,
> +	pr_info_once("early update: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
> +		     old_rev, new_rev,
>  		     date & 0xffff,
>  		     date >> 24,
>  		     (date >> 16) & 0xff);

And while at it also consolidate these arguments into a single or at max.
two lines?

Should happen in the first patch which touches this function.

Other than that, the code is fine.

Thanks,

        tglx
