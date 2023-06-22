Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50752739DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjFVJt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjFVJtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:49:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2035E3C3D;
        Thu, 22 Jun 2023 02:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x38p0gWD91YX2y+SHRO0boRbxDQ/68lnOxCdXK758wM=; b=Ef8ZoPyWi8golq3xJ11Gi7qZj1
        GRdhe8lrHWSiYuAriORJh6ygndefQMRS1hl24dEbLYT0FxdGJ8NzfZe3hIQufebq36SUN74rflOko
        uakxPor+ru5YOVzWDlGCGi6YK67VV4tIJsy6/KNaUnqYIrypufHAWtbDwKHhA3lCH7n9BmwEpIjME
        lPvIsmdIWc5Vz28QlF0kLuFqJqj5mUUsz09CH0xcp76WePpW1FgpehzQcOjs1clyyKoL59EmapJ9K
        AGAY48sK9JhEGZpg+hyZUeuAURrbpjYFga7F8iRkjh1CS+W+w4JCu1h7U6gt+CZ5rOdGySSK4Xg0e
        WpmIBjqg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qCGlq-0018g0-1K;
        Thu, 22 Jun 2023 09:38:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 793E3300338;
        Thu, 22 Jun 2023 11:38:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 448342425A86B; Thu, 22 Jun 2023 11:38:28 +0200 (CEST)
Date:   Thu, 22 Jun 2023 11:38:28 +0200
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
Message-ID: <20230622093828.GE4253@hirez.programming.kicks-ass.net>
References: <20230622003603.1188364-1-longman@redhat.com>
 <20230622003603.1188364-3-longman@redhat.com>
 <20230622054633.ulrurzzvzjijvdhn@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622054633.ulrurzzvzjijvdhn@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:46:33PM -0700, Josh Poimboeuf wrote:
> On Wed, Jun 21, 2023 at 08:36:02PM -0400, Waiman Long wrote:
> > When intel_idle_ibrs() is called, it modifies the SPEC_CTRL MSR to
> > 0 in order disable IBRS. However, the new MSR value isn't reflected
> > in x86_spec_ctrl_current which is at odd with the other code that
> > keep track of its state in that percpu variable. Fix that by updating
> > x86_spec_ctrl_current percpu value to always match the content of the
> > SPEC_CTRL MSR.
> 
> Is this fixing an actual bug or is there some other reason for doing
> this?
> 
> > 
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > ---
> >  drivers/idle/intel_idle.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> > index aa2d19db2b1d..07fa23707b3c 100644
> > --- a/drivers/idle/intel_idle.c
> > +++ b/drivers/idle/intel_idle.c
> > @@ -181,13 +181,17 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
> >  	u64 spec_ctrl = spec_ctrl_current();
> >  	int ret;
> >  
> > -	if (smt_active)
> > +	if (smt_active) {
> > +		__this_cpu_write(x86_spec_ctrl_current, 0);
> >  		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
> > +	}
> >  
> >  	ret = __intel_idle(dev, drv, index);
> >  
> > -	if (smt_active)
> > +	if (smt_active) {
> >  		native_wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
> > +		__this_cpu_write(x86_spec_ctrl_current, spec_ctrl);
> > +	}
> 
> More candidates for update_spec_ctrl()?

Both this and the play_dead case can't use update_spec_ctrl() because
RCU isn't there anymore and all that is noinstr. Additionally, both
sites rely on preemption being off already, where update_spec_ctrl()
can't do that.

That said, I suppose one could write it like so:

static __always_inline __update_spec_ctrl(u64 val)
{
	__this_cpu_write(x86_spec_ctrl_current, val);
	native_wrmsrl(MSR_IA32_SPEC_CTRL, val);
}

static void update_spec_ctrl(u64 val)
{
	preempt_disable();
	__update_spec_ctrl(val);
	preempt_enable();
}

And then you can use __update_spec_ctrl(). But that would need a wee
audit of using native_wrmsrl() in all places, probably ok, IIRC Xen
wasn't using our IBRS stuff anyway.
