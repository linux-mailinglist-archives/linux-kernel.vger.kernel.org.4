Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA926678A3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbjALPKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbjALPJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:09:47 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938EB3D9C5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=D4jgqnora9kE3kwPwvdpDGlpde5C6hZiwjY5njv/96M=; b=lC153J1bomA/3MKOBaQCZhzoZO
        my1Jqh30fqFJSj4WvW5gW4e3Ughqxvk+H4yvy7KsWQVQDQtydwBDuUo32xoeAHX+2QBnEl4hHdtQC
        1Av59nQvNPJZGN3wO8LsAMu2lmtYXMTpFrpOUeXMGISHwWglIy1IDXMbxkQfGYMhb1TXtmhhpx+LQ
        XU0irT5subT9Bw4iPdbZI8Mv4YGUEwx1tSmH4fKTHxaAh7HdeuJDChjOEDuiay6NctmE4gXZ3iKo9
        u3NWYx8pF14y5s2NLz6wD6xVyhvePnxRZtt4EcKswjAQCToEVtl0Y4xDmC+xJHO6KTflAIc5VoGBf
        QhifDAcQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pFz0u-00417y-1h;
        Thu, 12 Jan 2023 14:57:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 877D2300293;
        Thu, 12 Jan 2023 15:57:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6BC622CCC78DB; Thu, 12 Jan 2023 15:57:15 +0100 (CET)
Date:   Thu, 12 Jan 2023 15:57:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, brgerst@gmail.com,
        chang.seok.bae@intel.com, jgross@suse.com
Subject: Re: [PATCH v6 0/5] x86: Enable LKGS instruction
Message-ID: <Y8Afy2J0io8F510i@hirez.programming.kicks-ass.net>
References: <20230112072032.35626-1-xin3.li@intel.com>
 <Y7/5YPxbRE2AWgT0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7/5YPxbRE2AWgT0@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 01:13:20PM +0100, Ingo Molnar wrote:
> 
> * Xin Li <xin3.li@intel.com> wrote:
> 
> > LKGS instruction is introduced with Intel FRED (flexible return and event 
> > delivery) specification. As LKGS is independent of FRED, we enable it as 
> > a standalone CPU feature.
> > 
> > LKGS behaves like the MOV to GS instruction except that it loads the base 
> > address into the IA32_KERNEL_GS_BASE MSR instead of the GS segment’s 
> > descriptor cache, which is exactly what Linux kernel does to load user 
> > level GS base.  Thus, with LKGS, there is no need to SWAPGS away from the 
> > kernel GS base.
> 
> Ok, this looks good to me.
> 
> I've applied the first 4 patches to tip:x86/cpu, as the instruction exists 
> in a public document and these patches are fine stand-alone as well, such 
> as the factoring out of load_gs_index() methods from a high-use low level 
> header into a new header file.
> 
> Planning to apply the final, LKGS enabler patch as well, unless there's any 
> objections from others?

Nah, I think that thing's bike-shedded to near death. Let's just do it.
