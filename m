Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E4C682910
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjAaJkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjAaJkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:40:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835582D76
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TEMzv2O8BYSGCOG0+HTjK/rsBEzpwSVr8/h4IJVt9VU=; b=Vl9DrjCUeKAjshZoY+VFjv/exa
        KONhmY/KvnY72jQ45ZWE5XjZpQ3Rgz4eAdWnOOVULOOmZbeTf8U+cyt1dgm8ZVfyQh9kdbsYSOwU/
        xEv+4aQEZ202+Hah2rKHKhdMEVFCdCf529erkupx8oLxZWtjnmK3lqf9vaQob170rmm6qudvYzjiv
        q4IqoH5Gmbx5IG4O/elwfaTGbaHGGjwd/nKGX6lMa4IPIFnX3te5WozAwdMoCgLOrm9ya9zpg53rH
        JKA7jKEDace6azx28pWEY3P2sRl194EgvF7pP7nAEpzxrpyvINEgky1HjD0bRiDpjxKa1VGrS4uYv
        cSh5T+bg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMn7E-00BCAX-MV; Tue, 31 Jan 2023 09:39:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C6763002BF;
        Tue, 31 Jan 2023 10:39:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C6FB23CB3344; Tue, 31 Jan 2023 10:39:48 +0100 (CET)
Date:   Tue, 31 Jan 2023 10:39:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] x86/tdx: Do not corrupt frame-pointer in
 __tdx_hypercall()
Message-ID: <Y9jh5Gi/dH09ajQD@hirez.programming.kicks-ass.net>
References: <20230130135354.27674-1-kirill.shutemov@linux.intel.com>
 <Y9jShNfS/d8LGu8w@hirez.programming.kicks-ass.net>
 <20230131083901.ssg5huno2lhrbmzg@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131083901.ssg5huno2lhrbmzg@box.shutemov.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 11:39:01AM +0300, Kirill A. Shutemov wrote:
> On Tue, Jan 31, 2023 at 09:34:12AM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 30, 2023 at 04:53:54PM +0300, Kirill A. Shutemov wrote:
> > > If compiled with CONFIG_FRAME_POINTER=y, objtool in not happy that
> > > __tdx_hypercall() messes up RBP.
> > > 
> > >   objtool: __tdx_hypercall+0x7f: return with modified stack frame
> > > 
> > > Rework the function to store TDX_HCALL_ flags on stack instead of RBP.
> > 
> > Also, on IRC you mentioned that per TDX spec, BP is a valid argument
> > register too and you were going to raise this and get it fixed, TDX
> > hypercalls must not use BP to pass data.
> 
> I've raised the question yesterday. No progress so far. It will take time
> to get it into the public spec.

Sure, just making sure it's not forgotten about. Thanks!
