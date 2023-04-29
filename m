Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0576F241A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 12:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjD2KJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 06:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjD2KJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 06:09:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C625A10CF
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 03:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682762925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T3bg2ohOSOsYYtj0PI4ta8OXxZkRLa3UxaZN4X++P3M=;
        b=cFV8V/n8khF4SHrvfAAyaWjLP04+t2cW8BQlCQH0LB5kvf6is1TAJuD2P025CihF9OgOdL
        DCuUOshsqCDxmLCm57I2Hy2FnqQZBHqU3pSJ0ht3iagdmkp2GMdPZJNx+HiPmpKG5js0WY
        xjZe6FBY1ktdYoDhodl4gLVU5MIkEEQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-Ps_EXnSZP7W6JBvCVqGcdQ-1; Sat, 29 Apr 2023 06:08:41 -0400
X-MC-Unique: Ps_EXnSZP7W6JBvCVqGcdQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9CF0101A531;
        Sat, 29 Apr 2023 10:08:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.26])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6ED6FC15BA0;
        Sat, 29 Apr 2023 10:08:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 29 Apr 2023 12:08:29 +0200 (CEST)
Date:   Sat, 29 Apr 2023 12:08:27 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vernon Lovejoy <vlovejoy@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/show_trace_log_lvl: ensure stack pointer is aligned,
 again
Message-ID: <20230429100826.GA9879@redhat.com>
References: <20230427140054.GA17800@redhat.com>
 <20230428043158.r5omehiaqawcac2y@treble>
 <20230428065513.GA22111@redhat.com>
 <20230428235747.b5smutdttv5eeopi@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428235747.b5smutdttv5eeopi@treble>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28, Josh Poimboeuf wrote:
>
> On Fri, Apr 28, 2023 at 08:55:13AM +0200, Oleg Nesterov wrote:
> >
> > We decided to make the simplest one-liner fix, but I was thinking about
> >
> > 	for ( stack = stack ?: get_stack_pointer(task, regs);
> > 	     (stack = PTR_ALIGN(stack, sizeof(long)));
> > 	      stack = stack_info.next_sp)
> > 	{
> > 		...
> >
> > to factout out the annoying PTR_ALIGN(). Will it work for you?
>
> I'd rather not, that's a little *too* clever, IMO.

To me

	for (stack = PTR_ALIGN(stack ?: get_stack_pointer(task, regs), sizeof(long));
	     stack;
	     stack = PTR_ALIGN(stack_info.next_sp, sizeof(long)))

certainly looks less readable (and more "clever" ;) but I won't argue with
maintainer. Please see V2.

Oleg.

