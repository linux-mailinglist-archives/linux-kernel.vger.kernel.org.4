Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975D360391D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJSFQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJSFQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:16:18 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6CE6B161
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:16:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 204so16166301pfx.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bHl5yz5KELxFLhGYEcz6NENY01rE2kq0FjYZnXuaOQ=;
        b=GuEyMpGNMGaIG+3A0ffUQs9xzZu0PthDhsn2tiFHdsG8X+vqZ2IfAnMMGzJC3qiM+t
         iYc+h7EGW7Uu5cd28B1+Oc4B0bUxoU+QTC/gXV4fMlvWDNRJgIriPMvONBRqZQQikfqL
         0zgHJN29NyoL6sbLfsrgxUGLoRL1VFZgMaN2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bHl5yz5KELxFLhGYEcz6NENY01rE2kq0FjYZnXuaOQ=;
        b=8QzN7mQC1YLsH9xtR1F3FTCnWb1CwnfvM55xCuOpnQjJszRyG6zMo8h9CyL+QxdlKf
         BFzxRd65+Eij2lz2Znlx9+p0o3b9ssMWX84lKi+Tq0psMSzUxvTeXZR/muZnPT2GCE0l
         vDk9MnM376UKY+ZCK0cFCtdhc1/ldO16ZvMJeqpxJj0w7KusxPkPjGRciuOYB+R8Kaor
         U+PCauujyv/EsD6rQl1pcbIVWuseYTN6F8nCH3NCd991JBY7oy1X/3cCkp7P66rLruiz
         JYW3va4TzTYimiMLo3SMaq6AdxuT8I8xt1Bv0y9r1LULCH6wQZQ1HhFPa9YUzrgGcufT
         yIUw==
X-Gm-Message-State: ACrzQf1QMpTOivni74Lwe0BbhkHL+7AoSDPhcHo3yZFPXd/h888x34PP
        q5WNRXeS26lE3vJDIUL1ldmCwQ==
X-Google-Smtp-Source: AMsMyM5pbCkia/EbzBVwmRlPbE92L8xknI3pwSiTbSGEF206Juk96rMmEdLfFKYBH+V0w/47sJeUmw==
X-Received: by 2002:a05:6a00:b84:b0:565:caea:38bc with SMTP id g4-20020a056a000b8400b00565caea38bcmr6910674pfj.80.1666156577333;
        Tue, 18 Oct 2022 22:16:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903120800b0016c09a0ef87sm9801049plh.255.2022.10.18.22.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:16:16 -0700 (PDT)
Date:   Tue, 18 Oct 2022 22:16:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <202210182215.19844E9F21@keescook>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <Y08H8zJ5lQ62jel5@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y08H8zJ5lQ62jel5@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:09:23PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 18, 2022 at 11:09:13AM -0700, Kees Cook wrote:
> 
> > > +#ifdef CONFIG_FINEIBT
> > > +/*
> > > + * kCFI						FineIBT
> > > + *
> > > + * __cfi_\func:					__cfi_\func:
> > > + *	movl   $0x12345678,%eax			     endbr64			// 4
> > 
> > kCFI emits endbr64 here first too ...
> > 
> > > + *	nop					     subl   $0x12345678,%r10d   // 7
> > > + *	nop					     jz     1f			// 2
> > > + *	nop					     ud2			// 2
> > > + *	nop					1:   nop			// 1
> > > + *	nop
> > > + *	nop
> > > + *	nop
> > > + *	nop
> > > + *	nop
> > > + *	nop
> > > + *	nop
> 
> It does not; it does emit ENDBR at the start of the regular symbol
> though:

Oh duh, sorry, yes.

-- 
Kees Cook
