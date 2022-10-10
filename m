Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D2B5F9A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiJJHyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJJHx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:53:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D841017
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UdMAo/2cLeWulXGi5x8w1TPa1M+NvrF2aDi9zpVB8Aw=; b=DpImG0DLop3FL4zYHKUidqnNry
        SCasPmMHXzdC3sdYZE1N2iT+20kZsrAnJmbeXRAyM9O4pRIVzwYguQ9hKacTu+pZrdgBgPvxkM/hw
        SGMhnLMgadIHgFWevNOc7xEtgu3nOAR6pGFwhAL2sinlZHrCeE6UKPltjWZmRrDXWF+VYtrZnbZ13
        bEG4+aHxHLa905TZS4fyI6yZYCmGvQ4c1xgvUzNPX0PphDsfq9geAmGvOlQIdhmtPxvDaxHvLPiw/
        B7T+8Tpjr+dzB5aTjCGjeVZ/HE5yj7W9rH2332zUL4FDP/fTiIQrNeT4REG0vOPHVuRMgPk0A/gEM
        6R7r6UMg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohnbf-0043Ph-BY; Mon, 10 Oct 2022 07:53:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A5983300422;
        Mon, 10 Oct 2022 09:53:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F8952025C126; Mon, 10 Oct 2022 09:53:42 +0200 (CEST)
Date:   Mon, 10 Oct 2022 09:53:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Li, Xin3" <xin3.li@intel.com>
Cc:     Brian Gerst <brgerst@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Message-ID: <Y0PPhpj2aD3mYFOZ@hirez.programming.kicks-ass.net>
References: <20221006154041.13001-1-xin3.li@intel.com>
 <20221006154041.13001-7-xin3.li@intel.com>
 <CAMzpN2iccL5kNa2UaBXppiLnoNWrpwJd74+uBrB_63N0F5F5Xg@mail.gmail.com>
 <BN6PR1101MB2161E1191DF1BD0135DC3947A85E9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <CAMzpN2i52orTgPqRARoCkuA=c2GEyWXLscrFRgDkb0LoFV01Rw@mail.gmail.com>
 <BN6PR1101MB2161FFEB80E3D3AE06035384A8209@BN6PR1101MB2161.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR1101MB2161FFEB80E3D3AE06035384A8209@BN6PR1101MB2161.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 04:32:34AM +0000, Li, Xin3 wrote:
> > > > There are not that many call sites, so using something like this
> > > > (incorporating Peter Z's suggestion for the exception handler) would
> > > > be better from a code readability perspective vs. a tiny increase in code size.
> > >
> > > The existing approach patches the binary code thus we don't need to check it
> > at runtime.
> > 
> > static_cpu_has() uses alternatives to patch the branch, so there is no runtime
> > check after early boot.
> > 
> 
> Sorry, didn't know it, thanks for point it out.
> 
> If we prefer static_cpu_has, are you asking to replace all alternative macros with it?

No; the only reason to do it here would be to unconfuse that exception
thing. But even there I'm not convinced.

Yes, Brian's code is much easier to read, but code-gen is quite terrible
(also, my binutils can't seem to decode this -- GNU objdump (GNU
Binutils for Debian) 2.38.90.20220713)

