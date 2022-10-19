Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA9A603920
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJSFSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJSFSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:18:11 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9591D6BCC2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:18:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z20so15861925plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5pSGtcsQhGvNDOHggSKbavFxOw2j6uoSZuMDMmhfje8=;
        b=f01fREBOLazcCfEBm619gaCRmBFypfe8/aEcPUL1+Dq2/zS7pgs7N8RcGEXaxY8Ubt
         YQiKtduLpW/klfk6uY7uz3SJ4fTpLaV40XpuoWOKcsx/wCcE10M9ZWB0/WSeX1b8cCQU
         8y281lqIff8nbOcSlZZuqTpIh/FzQ+uvl0ieU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pSGtcsQhGvNDOHggSKbavFxOw2j6uoSZuMDMmhfje8=;
        b=nznRQmv143RZ/IrGei5fCqnm5gn/JeAH83ojb9tdDq/6BQWmtI5t/jbTFvX1jL/3Sv
         i6i7a0cgJyGvheTxzbgxP8muRnRNCk3qrdWT0jae75t2tZKvtZsbkp7lIHMvg8aVWCRl
         wk/rSdxT9SlwuOQ0VcMzrLMOTj7n4RDno/NjkJ+yArC6Q//X+HHHPi9r7gKZpQ7CtutR
         fjUD7e+U5DZhrD/e32bSOFqItTZqnXI1gnoVoJrIZQ/qo6NsABVftFvtXs8yRP5eOg7L
         o5R7U3Mvrb+BA3Q4tKFlaUijBXxBDyrJt2dnikgeC6rGFbn8JssYH2Gi48ecRJCenzJo
         npgw==
X-Gm-Message-State: ACrzQf1HrlQ5Qhr68cL09r2O4DbGaMoE6LjG+tn/nbvEoTSZctkGjg2s
        0krrphj6h5qZrmoRo6cuLKF4UQ==
X-Google-Smtp-Source: AMsMyM4Z2jHXLGCTTwYJ7G+1R9nRFw47VDM/EqjSD1hku6RC/wN6OfPri1ydRr+QyA5SRxyTgJDb0w==
X-Received: by 2002:a17:902:a9c6:b0:178:b2d4:f8b2 with SMTP id b6-20020a170902a9c600b00178b2d4f8b2mr6597068plr.79.1666156690145;
        Tue, 18 Oct 2022 22:18:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k61-20020a17090a4cc300b0020bfd6586c6sm9043098pjh.7.2022.10.18.22.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:18:09 -0700 (PDT)
Date:   Tue, 18 Oct 2022 22:18:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joao Moreira <joao@overdrivepizza.com>, x86@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <202210182217.486CBA50@keescook>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <Y08H8zJ5lQ62jel5@hirez.programming.kicks-ass.net>
 <c561dd8ec384bfc77998a6db6ed824e7@overdrivepizza.com>
 <Y08M4+GxoqvuZ+bq@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y08M4+GxoqvuZ+bq@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:30:27PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 18, 2022 at 01:17:28PM -0700, Joao Moreira wrote:
> > > 
> > > > Tangent: why are these nop instead of 0xcc? These bytes aren't
> > > > executed
> > > > ever are they?
> > > 
> > > Because that's what the compiler gets us through
> > > -fpatchable-function-entry.
> > 
> > Is it useful to get the compiler to emit 0xcc with
> > -fpatchable-function-entry under any circumstance? I can probably change
> > that quickly if needed/useful.
> 
> Having it emit 0xcc for the bytes in front of the symbol might be
> interesting. It would mean a few kernel changes, but nothing too hard.

The world is pretty different with endbr, but I still always need big
nop areas as giant "jump anywhere in here" targets. ;)

-- 
Kees Cook
