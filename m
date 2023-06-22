Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EF473A182
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjFVNJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjFVNJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:09:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B061184;
        Thu, 22 Jun 2023 06:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2zCCsXt8qID/DdF3cBDXlV31CIdncIkhmxoQrF1JRGc=; b=TCCpJR6KWGFvtxkQtM+b991Z8P
        eeAvMZlTANe5Ky5lst9+TDctBDkehwl9HH2xGSmyshxZQuGQ02tQxKjr0TTNzjUmGIee9YXwyhH2r
        7oufY07dQGR7G5c9yyyYGKtajyiSgFuRcgP9CiNbx3pa7OQ8MCvZGBky4s49qchL20eOH5VwTjqyn
        2P9OGK1WGakDG5XcXaHED5WpDHiB35mBateBZBz1uOY5Vb5eixdnydOrhgEmop1I6Ovqlt68hdc0r
        QJQC2imOcCT6KsdVcXq72kaZ/DXgJc+osWKJjKtGYM6SyAVfaWlot7Oh17Nu4k8JESTfBZ6kegB/+
        8HJKLw0g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qCK3T-001BjD-1w;
        Thu, 22 Jun 2023 13:08:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 217913002F0;
        Thu, 22 Jun 2023 15:08:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFA0B2482940E; Thu, 22 Jun 2023 15:08:53 +0200 (CEST)
Date:   Thu, 22 Jun 2023 15:08:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v3 2/3] intel_idle: Sync up the SPEC_CTRL MSR value to
 x86_spec_ctrl_current
Message-ID: <20230622130853.GP4253@hirez.programming.kicks-ass.net>
References: <20230622003603.1188364-1-longman@redhat.com>
 <20230622003603.1188364-3-longman@redhat.com>
 <20230622054633.ulrurzzvzjijvdhn@treble>
 <20230622093828.GE4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622093828.GE4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 11:38:28AM +0200, Peter Zijlstra wrote:

> Both this and the play_dead case can't use update_spec_ctrl() because
> RCU isn't there anymore and all that is noinstr. Additionally, both
> sites rely on preemption being off already, where update_spec_ctrl()
> can't do that.

Oh, I might be wrong about the preemption thing; it doesn't make sense
to do wrmsr with preemption on, so it could be simpler.

> That said, I suppose one could write it like so:
> 
> static __always_inline __update_spec_ctrl(u64 val)
> {
> 	__this_cpu_write(x86_spec_ctrl_current, val);
> 	native_wrmsrl(MSR_IA32_SPEC_CTRL, val);
> }
> 
> static void update_spec_ctrl(u64 val)
> {
> 	preempt_disable();
> 	__update_spec_ctrl(val);
> 	preempt_enable();
> }
> 
> And then you can use __update_spec_ctrl(). But that would need a wee
> audit of using native_wrmsrl() in all places, probably ok, IIRC Xen
> wasn't using our IBRS stuff anyway.
