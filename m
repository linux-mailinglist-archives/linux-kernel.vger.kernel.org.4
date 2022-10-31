Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C63C613663
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiJaMc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJaMc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:32:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8793A233
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BMhVKbLp+sehk8C9+cVZrrqhIEVJybTY+mdwywXc03A=; b=VoEoHEoVW9bQ9bSrKh3moc5bhC
        /Stw4dCOlVz2qSiGFBBfmb+K0vjy38MgTrl/F8d2M3fXHwKTgFmPM0YbhT/0kue7UHhEwyUQSibRh
        5HBKwIHycEi2oRyYGOLH2sotxzhHAZQU4rRRu+gk8sn9eOXjxXRpu4493LjOMprG2NuNqk5E4xTpa
        dF1cZuSf23fvUn4CU6qKVfDOhHRpb45qgLmV9bwaAOjLFq1c5HG+PEuJGjK1Iq+AiIAriFx90lxW7
        y5/oiIILCTNliJz4KS6wWbrJsa5TxBmURM7i78iirZaRV+B4ij/ZejJolvi9VYP8ZHywsOyHzEO8j
        SQnKJNmA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opTy4-007rxL-Of; Mon, 31 Oct 2022 12:32:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D198300282;
        Mon, 31 Oct 2022 13:32:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 487FD200C62BD; Mon, 31 Oct 2022 13:32:40 +0100 (CET)
Date:   Mon, 31 Oct 2022 13:32:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        tony.luck@intel.com, pawan.kumar.gupta@linux.intel.com,
        pbonzini@redhat.com, chenyi.qiang@intel.com,
        jithu.joseph@intel.com, alexs@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: fix undefined behavior in bit shift for
 intel_detect_tlb
Message-ID: <Y1/AaJOcgIc/INtv@hirez.programming.kicks-ass.net>
References: <20221031114340.4185587-1-cuigaosheng1@huawei.com>
 <Y1/AAegYuyZPxH04@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1/AAegYuyZPxH04@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 01:30:57PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 31, 2022 at 07:43:40PM +0800, Gaosheng Cui wrote:
> > Shifting signed 32-bit value by 31 bits is undefined, so changing
> > significant bit to unsigned. The UBSAN warning calltrace like below:
> > 
> > UBSAN: shift-out-of-bounds in arch/x86/kernel/cpu/intel.c:948:21
> > left shift of 1 by 31 places cannot be represented in type 'int'
> 
> Is it really? Shouldn't -fstrict-overflow define this case?

-fno-strict-overflow that is, which implies -fwrapv which ensures 2s
complement, at which point shifting signed numbers is fully defined.
