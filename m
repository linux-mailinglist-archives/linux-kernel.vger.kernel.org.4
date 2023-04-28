Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543E76F1206
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 08:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345420AbjD1G4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 02:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345418AbjD1G4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 02:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8172CA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 23:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682664933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0A2HQZTn/tQgjncBTg/E0npxljNwvoVN3VwvmE8gpxE=;
        b=GEUihSMCn81kfe1xwOxxnDeVNIEEGkTSeMjgm+rOvq8LixWTOyQxGoIV9REm4gHbCQRA/K
        fg4ywDFQ0FFXp23gofOjc7ZEgyXTQCBEl2T2Mv4hFV15+YAsyubPWTsBiimORibG6EA+BG
        W+yxEelZ6yoDV70IiZxv93MjzxiupJo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-Df1whZT5MeSj8gk6Y9krOg-1; Fri, 28 Apr 2023 02:55:27 -0400
X-MC-Unique: Df1whZT5MeSj8gk6Y9krOg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 464AD858F09;
        Fri, 28 Apr 2023 06:55:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.104])
        by smtp.corp.redhat.com (Postfix) with SMTP id 30B17492C13;
        Fri, 28 Apr 2023 06:55:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 28 Apr 2023 08:55:15 +0200 (CEST)
Date:   Fri, 28 Apr 2023 08:55:13 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vernon Lovejoy <vlovejoy@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/show_trace_log_lvl: ensure stack pointer is aligned,
 again
Message-ID: <20230428065513.GA22111@redhat.com>
References: <20230427140054.GA17800@redhat.com>
 <20230428043158.r5omehiaqawcac2y@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428043158.r5omehiaqawcac2y@treble>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27, Josh Poimboeuf wrote:
>
> On Thu, Apr 27, 2023 at 04:00:54PM +0200, Oleg Nesterov wrote:
> > +	stack = PTR_ALIGN(stack, sizeof(long));
> >  	for ( ; stack; stack = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
> >  		const char *stack_name;
>
> Seems reasonable, though 'stack' is already initialized a few lines
> above this, so it would be cleaner to do the PTR_ALIGN then.  Or even
> better, just move it all to the for loop:
>
> 	for (stack = PTR_ALIGN(stack ? : get_stack_pointer(task, regs));
> 	     stack;
> 	     stack = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {

We decided to make the simplest one-liner fix, but I was thinking about

	for ( stack = stack ? : get_stack_pointer(task, regs);
	     (stack = PTR_ALIGN(stack, sizeof(long)));
	      stack = stack_info.next_sp)
	{
		...

to factout out the annoying PTR_ALIGN(). Will it work for you?

Oleg.

