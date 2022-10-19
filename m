Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F9060391C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJSFPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJSFPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:15:03 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D6233858
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:15:01 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id b2so15882749plc.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2MDTOj7x55gi8T/5qGxJNdcvudsMBqVqaN52jivhMBc=;
        b=Nubc/N1WRcDHtWF9V6+h+4CPl5kouEUj4EcmfnZWlxwW4e1BlEmfiLrSadFlLs+reM
         2fqDm5Jm1Qi157SpJ2/88LV5UiISnGmQGwrCn4oP+HnUMAU/+VovrF+9pBsNfSdB8ml1
         duxb/A7vMs5uQ1rV9vnIbizTUVMqSOLE6nlhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MDTOj7x55gi8T/5qGxJNdcvudsMBqVqaN52jivhMBc=;
        b=Sbtdo3FuRfdwMiYzeexAR5mwiOkgfllcbl6CkqLBWBHbGWZEpeTlgy+BwGlosk34Bk
         Pw7WsEf1344/IJAevePtRlD0Wz6A2ErbR9VJB/dR6bisgK+RXDhsB7R7AnAwJgIQcDTc
         Nlv8kODJr25MsphC8/VlDL8eZVAEJPxLrTM0AfaRbDBlgzwVath9QPGZXGPtFEIqkB/c
         57do3VEsfLtlL9ry4NLs/Nx83+Z6WKtQsFyA5mYKktw3ADLjx3AFRpsxl++ULd7jaLwv
         0BmveJ0UGUxVwZvLSlgWBqkM+bOPq9GkbL+F/0w8Hzjps2mRg48EeztOLo+Bs9yjO9WR
         N86g==
X-Gm-Message-State: ACrzQf3KwPfQo6cNwevR9q148pyyAm2LJ0nxCtazplPs/3nUGhbGQjSq
        MH0YWk7RJ9AC6D7YgtP5HPOm1Q==
X-Google-Smtp-Source: AMsMyM7Xi5W1uehLbIxbs1T6YqB95QnOK0f9z9Zo1GDqOH5j3jJVj8isKdQZQkU6sOwZf+hERBRPKw==
X-Received: by 2002:a17:90b:3912:b0:20d:4151:1b65 with SMTP id ob18-20020a17090b391200b0020d41511b65mr43880234pjb.233.1666156501455;
        Tue, 18 Oct 2022 22:15:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p65-20020a625b44000000b0053e4296e1d3sm10197153pfb.198.2022.10.18.22.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:15:00 -0700 (PDT)
Date:   Tue, 18 Oct 2022 22:14:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <202210182206.8B707407@keescook>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <Y08E9DgGD0lPB85O@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y08E9DgGD0lPB85O@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 09:56:36PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 18, 2022 at 11:09:13AM -0700, Kees Cook wrote:
> > > +config FINEIBT
> > > +	def_bool y
> > > +	depends on X86_KERNEL_IBT && CFI_CLANG
> > > +	select CALL_PADDING
> > 
> > To that end, can we please make this a prompted choice?
> 
> How about something like so instead?

/me throws a party :)

I can imagine the case where someone will want a CONFIG to choose the
default, but yes, I love it. Thank you!

For example:

enum cfi_mode {
	CFI_OFF = 0,
	CFI_KCFI = 1,
	CFI_FINEIBT = 2,
};

#define CFI_DEFAULT	CONFIG_CFI_MODE


choice
	prompt "CFI mode" if expert
	default CFI_MODE_FINEIBT

	config CFI_MODE_FINEIBT
		bool "FineIBT"
        config CFI_MODE_KCFI
		bool "kCFI"
	config CFI_MODE_OFF
		bool "CFI disabled"
endchoice

config CFI_MODE
	int
	default "0" if CFI_MODE_OFF
	default "1" if CFI_MODE_KCFI
	default "2"


-- 
Kees Cook
