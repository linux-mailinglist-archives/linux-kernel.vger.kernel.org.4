Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8D46FFEDA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 04:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbjELCVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 22:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjELCVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 22:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB625E58
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 19:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683858065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S2ASvXOHh//KO9isgRlvw058BiPsYFCZ13CsWljUXCc=;
        b=Fy0VI96iBeqw5FiI/EJAm3XL0PwfQzZaac7PX6Bc7zK2byhEOrwlyAj24QHvMLoY1nsSpW
        3Rj0r/lfTOHoUUESRmSwJlSgM/IoBUL0OPUhx6/qR3oIzottljsC0S7d3+oNEF17KDNQOO
        76szQ3/pBn0xadqno7MPJ4UUdwB+xjk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-BU2L4NjVMHO2Z5E5ny88wQ-1; Thu, 11 May 2023 22:21:03 -0400
X-MC-Unique: BU2L4NjVMHO2Z5E5ny88wQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f4f80a5dd4so1045251cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 19:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683858062; x=1686450062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2ASvXOHh//KO9isgRlvw058BiPsYFCZ13CsWljUXCc=;
        b=kx56eOZAQR25+UgWThcbpZkI4B5YJ3ncLLcX50ICuNo9pWFRX/KFer+lNYd1XncI1U
         EfU/VnJiSBiCVppCbcbWVHufdqZNjBEVQ5IEOnrL3bbFuTaV6a6o5TGO7lV7VncCZ3tC
         Mg4NzFaY3HSGJLk8Jdm8xGFiKfjp5/DEGzbDxtU7M8kPKDVvqF0TmejOt65om3gLExTV
         RPCX8QSonA0xzc5mbyzGEKvmYEl1+km5B6Mw17k9S7Mdgey7fovYTWW5I++5njqQl2JO
         nwKqIk+hX22KjL+q4Ubg/gMMWT5V7z85pT9iLEErNFpFE6pOduhU6QwACGGc4n5DUG92
         PEeA==
X-Gm-Message-State: AC+VfDwIynT/kwNYGdg6uY05xSiTAQAbqTp/SW4ULrfNnntqh9phDfW2
        s15tJW9QSkijy1HuoltVM2JIG5L5jJqHYZfWVOS488jHDvRFca+vqsNMMZBS0m2LsSj7L8WExFI
        WLzxe3Tpy7SyVmB8tV0Xi2w9S
X-Received: by 2002:ac8:5f8c:0:b0:3f3:69ea:274d with SMTP id j12-20020ac85f8c000000b003f369ea274dmr37963350qta.45.1683858062733;
        Thu, 11 May 2023 19:21:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5h9im6TSSFHfcaLq7bYhakNAfyf+yFqLviD20jBFS9fCqbB5UvXh3OkOYI11U6Ho5kn0bb9Q==
X-Received: by 2002:ac8:5f8c:0:b0:3f3:69ea:274d with SMTP id j12-20020ac85f8c000000b003f369ea274dmr37963339qta.45.1683858062342;
        Thu, 11 May 2023 19:21:02 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::3e])
        by smtp.gmail.com with ESMTPSA id f10-20020a05622a114a00b003f4e1cf23easm1240158qty.73.2023.05.11.19.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 19:21:02 -0700 (PDT)
Date:   Thu, 11 May 2023 19:20:59 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Josh Poimboeuf' <jpoimboe@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vernon Lovejoy <vlovejoy@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/show_trace_log_lvl: ensure stack pointer is aligned,
 again
Message-ID: <20230512022059.ltlzs7irvbvoj2cl@treble>
References: <20230427140054.GA17800@redhat.com>
 <20230428043158.r5omehiaqawcac2y@treble>
 <20230428065513.GA22111@redhat.com>
 <20230428235747.b5smutdttv5eeopi@treble>
 <aa8537d81dc747a097e9e30491b5081b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa8537d81dc747a097e9e30491b5081b@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 30, 2023 at 11:59:17AM +0000, David Laight wrote:
> From: Josh Poimboeuf
> > Sent: 29 April 2023 00:58
> > 
> > On Fri, Apr 28, 2023 at 08:55:13AM +0200, Oleg Nesterov wrote:
> > > On 04/27, Josh Poimboeuf wrote:
> > > >
> > > > On Thu, Apr 27, 2023 at 04:00:54PM +0200, Oleg Nesterov wrote:
> > > > > +	stack = PTR_ALIGN(stack, sizeof(long));
> > > > >  	for ( ; stack; stack = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
> > > > >  		const char *stack_name;
> > > >
> > > > Seems reasonable, though 'stack' is already initialized a few lines
> > > > above this, so it would be cleaner to do the PTR_ALIGN then.  Or even
> > > > better, just move it all to the for loop:
> > > >
> > > > 	for (stack = PTR_ALIGN(stack ? : get_stack_pointer(task, regs));
> > > > 	     stack;
> > > > 	     stack = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
> > >
> > > We decided to make the simplest one-liner fix, but I was thinking about
> > >
> > > 	for ( stack = stack ? : get_stack_pointer(task, regs);
> > > 	     (stack = PTR_ALIGN(stack, sizeof(long)));
> > > 	      stack = stack_info.next_sp)
> > > 	{
> > > 		...
> > >
> > > to factout out the annoying PTR_ALIGN(). Will it work for you?
> > 
> > I'd rather not, that's a little *too* clever, IMO.
> 
> I'd leave the initialisation outside the loop and move
> the PTR_ALIGN() into the loop so that the 'for' fits on one line:
> 	if (!stack)
> 		stack = get_stack_pointer(task, regs);
> 	for (; stack; stack = stack_info.next_sp) {
> 		const char ...
> 		stack = PTR_ALIGN(stack, sizeof(long));

I do like that better, except... put the initialization in the 'for':

	for (stack = stack ? : get_stack_pointer(task, regs);
	     stack;
	     stack = stack_info.next_sp) {
		const char ...
		stack = PTR_ALIGN(stack, sizeof(long));

A multi-line 'for' is fine, it's better to put the initialization in the
conventional spot.

-- 
Josh

