Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7451C603904
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJSFAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJSFAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:00:16 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A7F1FF97
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:00:11 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id b5so15227140pgb.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7KlOOoo8kFDTx7VjKoH6+Vu0ogQNhNleK4mkk2uZlM=;
        b=Rm57BG1ObCu+WcWIIGa9fmS/6ytUc0FvSPJ/WRP79SFKRTFRFVgHZYyzZ1V9LpX1KQ
         USCkoxi5bEduel3kJl3d40HDL6dPUNswT4xTdn3S6oOGtTyuYo7B5Ze7qYop0Akqf2Ut
         BTiiNm3S5y7ZjthnBSt6XiNKAwc7VLl9FEufs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7KlOOoo8kFDTx7VjKoH6+Vu0ogQNhNleK4mkk2uZlM=;
        b=5g9Asfm3LXVUwZ5JAgTZjr9iXRM4nFYdaMvi/AdswwnCoj5frGAM6Y1XvlKRr8uF+e
         dkmcQ+Qlugvz8SOuS1JtwsyxBZ3AmZBXEazBtsJ2uV6N6kwRmFmtd5etRx8jKbePDTgt
         lpqEjdG+fBrPZxvzFGdhEmpKAXbXVgf7Qera6g43X6zeDDZ8mSMRQMEczaEErb4JM0LO
         CD7AvvpySubV8z4BCRNmmv7x6jTWee35WHA0ULsdZSucj9QIMct6PJreTGnOXlGPD1rI
         xBNPT/eOxsBYda/RgHM7teIIYwBlp2mjN8r+yRdiVCXUPk/UxY4gDq0+sO/xtGDHarlE
         /0qw==
X-Gm-Message-State: ACrzQf2dKJWIGDo7DtOVCorbPEstym1V/9ZoXdFzvSZjpHOElumlUv/J
        NwI/M0SXY4FVcF6y7iXGiUfIMQ==
X-Google-Smtp-Source: AMsMyM6mZ6u6COS/UGFoCm5x+zEApDBBbUOJgIi4/citaTjkaghXnnApMLhLQra63vV/Hv9TYCOpgg==
X-Received: by 2002:a05:6a00:1907:b0:557:e83b:1671 with SMTP id y7-20020a056a00190700b00557e83b1671mr6494585pfi.65.1666155610773;
        Tue, 18 Oct 2022 22:00:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u125-20020a627983000000b005615c8a660csm10226516pfc.65.2022.10.18.22.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:00:09 -0700 (PDT)
Date:   Tue, 18 Oct 2022 22:00:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <202210182157.CF5F4403@keescook>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <Y08G73HOddpS40ny@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y08G73HOddpS40ny@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:05:03PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 18, 2022 at 11:09:13AM -0700, Kees Cook wrote:
> > I still think it's worth noting it does technically weaken the
> > "attacker-controlled executable memory content injection" attack
> > requirements, too. While an attacker needs to make sure they place an
> > ENDBR at the start of their injected code, they no longer need to also
> > learn and inject the CFI hash too, as the malicious code can just not
> > do the check at all. The difference in protection currently isn't much.
> 
> Hmm, true; although I do feel that the moment attackers can write code
> we might be having worse problems.

Totally agreed! :) But this is why I've wanted to keep a bright line
between "kernel area", "modules area" and "everything else", in the
hopes that we can use other things like PKS to block the "everything
else" area, but one thing at a time.

> 
> > It's not a very difficult requirement to get attacker-controlled bytes
> > into executable memory, as there are already existing APIs that provide
> > this to varying degrees of reachability, utility, and discoverability --
> > for example, BPF JIT when constant blinding isn't enabled (the unfortunate
> > default). 
> 
> BPF has another problem in that the current control transfer to BPF
> progs is nocfi. At the very least we can have them have a hash, no?

Yup, it's on the list.

-- 
Kees Cook
