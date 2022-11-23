Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC286636679
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbiKWRDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238417AbiKWRDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:03:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8726B11C20
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:03:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E259B821D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84193C433B5;
        Wed, 23 Nov 2022 17:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669223019;
        bh=m9XRdTo1RKmcs2mxaIv6FBSHv+6lgqotVqiNHoXrWdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KIsPk3EyOIxwWCYLSnt73pV3xqGkyYI625biqcGf6DZOEwcTFpFfPyetoe4qgcmD0
         9B/nQKKjGeOJznrCyFEEO1diQUnxBXnB1OS6/fbbMC/f2cbaKCEMACyE0zoK8+mYM0
         XcAVCDy9AP+95u/VmUv7e9UOtIlbvf+lsM1MqifC9asQqh36Bv2oEQstSSVEA3Z1G0
         NqWF28lvWXIWqsmuGepb4eM5KYVoRaDd8iFOwPKPYOCW3rWm7zxwikrcM5o1uVt5Kk
         V4K7KnlBJ+4e8mcPyqzJPxAZzmnpbtrI1trv1tOMUNdDliSVXHqCoY1aC08XKiGU7F
         voULg1tMcGajA==
Date:   Wed, 23 Nov 2022 09:03:37 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: objtool warning for next-20221118
Message-ID: <20221123170337.keacggyvn4ykbtsw@treble>
References: <20221121040736.GA3738360@paulmck-ThinkPad-P17-Gen-1>
 <Y3thrQxfcvZSXFlr@hirez.programming.kicks-ass.net>
 <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <20221122051605.4hcbslwxez2trdvt@treble>
 <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
 <20221123012350.kelmmadh65lyswqz@treble>
 <Y33gAiFP2IpVdxJu@hirez.programming.kicks-ass.net>
 <2255c45f-d8ba-3f32-9d99-737ad3040dd7@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2255c45f-d8ba-3f32-9d99-737ad3040dd7@citrix.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:52:09AM +0000, Andrew Cooper wrote:
> > Well, if you return from arch_cpu_idle_dead() you're back in the idle
> > loop -- exactly where you would be if you were to bootstrap the whole
> > CPU -- provided you have it remember the whole state (easier with a
> > vCPU).

play_dead() really needs sane semantics.  Not only does it introduce a
surprise to the offlining code in do_idle(), it also skips the entire
hotplug state machine.  Not sure if that introduces any bugs, but at the
very least it's subtle and surprising.

> > But maybe I'm missing something, lets add Xen folks on.
> 
> Calling VCPUOP_down on oneself always succeeds, but all it does is
> deschedule the vCPU.
> 
> It can be undone at a later point by a different vcpu issuing VCPUOP_up
> against the previously-downed CPU, at which point the vCPU gets rescheduled.
> 
> This is why the VCPUOP_down hypercall returns normally.  All state
> really is intact.
> 
> As for what Linux does, this is how xen_pv_cpu_up() currently behaves. 
> If you want to make Xen behave more everything else, then bug a BUG()
> after VCPUOP_down, and adjust xen_pv_cpu_up() to skip its initialised
> check and always use VCPUOP_initialise to bring the vCPU back online.

Or we could do what sev_es_play_dead() does and just call start_cpu0()
after the hypercall returns?

Though, start_cpu0() seems very suspect, it just uses the stack of the
idle task of whatever CPU happened to be last brought up via cpu_up().
Which means we now have two idle tasks sharing the same stack?  How is
start_cpu0() not broken???

-- 
Josh
