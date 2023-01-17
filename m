Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C0966DC66
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbjAQLad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbjAQLaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:30:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10A51B548
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4dd1nPHSajeYfo138KPDTbRosWVLWxAJMDJHQavnKFE=; b=a6aKGxvXjkHxURoMeXnOaMqY7T
        JQ6hF/xzb92HYIEgt3cwLktllTNNk0uf/8i5bbNnySPTeuxsX6qpz/UwxLZp7ssM/Me7Rd7UePSoi
        1h5O0FpASKQtBAiJJliEUMPu7ESmw8EhriLJ28cKLTingDGX+rwJCIA+W1U32XJXDma/YhLvEProo
        KslYBSI+iHBVUUouKqpwqUsONdZeKX+M5hvTww6sI/hoPu3pmX/2/tdviLIXhf97GwM88MtqTuUVm
        8ovafHUDnVczSNpbj+BUM22p212dGl6S75mHVEVAsZij5E4QNhuosMnbeSbzHLOX56J0pzF2OZC7A
        whTdMhcw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pHk9l-005upc-23;
        Tue, 17 Jan 2023 11:29:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 064423005C9;
        Tue, 17 Jan 2023 12:29:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 808C2201C94A4; Tue, 17 Jan 2023 12:29:40 +0100 (CET)
Date:   Tue, 17 Jan 2023 12:29:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 6/7] x86/power: Sprinkle some noinstr
Message-ID: <Y8aGpHgSOczqeEHf@hirez.programming.kicks-ass.net>
References: <20230116142533.905102512@infradead.org>
 <20230116143645.888786209@infradead.org>
 <Y8Zq2WaYmxnOjfk8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8Zq2WaYmxnOjfk8@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:31:05AM +0100, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > +	/*
> > +	 * Definitely wrong, but at this point we should have at least enough
> > +	 * to do CALL/RET (consider SKL callthunks) and this avoids having
> > +	 * to deal with the noinstr explosion for now :/
> > +	 */
> > +	instrumentation_begin();
> 
> BTW., readability side note: instrumentation_begin()/end() are the 
> misnomers of the century - they don't signal the start/end of instrumented 
> code areas like the name falsely & naively suggests, but the exact 
> opposite: start/end of *non-*instrumented code areas.

Nope, they do as they say on the tin.

noinstr void foo(void)
{
}

declares the whole function as non-instrumented.

Within such functions, we demark regions where instrumentation is
allowed by:

noinstr void foo(void)
{
	instrumentation_begin();
	/* code that calls non-noinstr functions goes here */
	instrumentation_end();
}

(note the double negative in the comment)
