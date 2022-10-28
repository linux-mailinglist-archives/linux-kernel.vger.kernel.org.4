Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD0B61197B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiJ1RmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiJ1RmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:42:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028B32303F8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:41:47 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so10477928pjc.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hNe7pE0mhcXWjeA1QJJOqi6qRTPP7vQdPSrMPQVQDUY=;
        b=WWXeTG719aYppZcdSDvyKb0sCpdiMkoobyUAhBjGDiFrEOoFdZ+lI92HvhG1p0+6gO
         9djcyQs65SEWlZYJnUDMepy/Diwtjgot/FgAKaZh2iYAy3K2XXF3M/GotHfnWd+apoZJ
         DxDu1pt/aAkUfPRsohEBwgSLZRq/UICYxWTZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNe7pE0mhcXWjeA1QJJOqi6qRTPP7vQdPSrMPQVQDUY=;
        b=j+DOM6wm3qsZdxBd81l9C1y8f2bFr9rNPmf1oXSYxBsM9vPi34QikbgLxZPiUMy9qz
         HPx7vdhzChCru3ttdUxtaCqdaTgmKzFHym8WiJpC0iyzoGMH0SQKum1FT+nNj/aplGB5
         DMRpxfo1YFHvz2J2e4exKznINoTuNCsKe05m9jPN3y8HRHn1owNdFCYd7KVMRES8LiL8
         vpD5g9SSH9yilBqesYt+JvQ7aJmwmblsOzza/h4Wq2QyTYY8GBBFHMrkOem2gTP1tTjV
         whvEvdUYxB/FkgrVlAFvJdGOipFiH6O4odw0YXeU9jHffjI6POwA9fgfcQ+Bfd4FTHKz
         uSvA==
X-Gm-Message-State: ACrzQf2BXBijlc89yHDd30LokxbShq4LzyQOvZ5IrZX48f+rhqkVpyBi
        eTWEXDM/hUstuwy5LU7ZPcsbzA==
X-Google-Smtp-Source: AMsMyM4QlHu5Uy9cE0OmCJGFr97CA5TgIs12zg9qBbTU2Up4AEsAS8SORs6VAy7ta/YBwY3RcyI3EQ==
X-Received: by 2002:a17:902:d2cf:b0:17f:7b65:862f with SMTP id n15-20020a170902d2cf00b0017f7b65862fmr117613plc.168.1666978906459;
        Fri, 28 Oct 2022 10:41:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902684b00b00186b1bfbe79sm3317208pln.66.2022.10.28.10.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 10:41:45 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:41:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/4] x86/ibt: Implement FineIBT
Message-ID: <202210281041.3BD97D9@keescook>
References: <20221027092812.185993858@infradead.org>
 <20221027092842.634714496@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027092842.634714496@infradead.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:28:14AM +0200, Peter Zijlstra wrote:
> Implement an alternative CFI scheme that merges both the fine-grained
> nature of kCFI but also takes full advantage of the coarse grained
> hardware CFI as provided by IBT.
> 
> To contrast:
> 
>   kCFI is a pure software CFI scheme and relies on being able to read
> text -- specifically the instruction *before* the target symbol, and
> does the hash validation *before* doing the call (otherwise control
> flow is compromised already).
> 
>   FineIBT is a software and hardware hybrid scheme; by ensuring every
> branch target starts with a hash validation it is possible to place
> the hash validation after the branch. This has several advantages:
> 
>    o the (hash) load is avoided; no memop; no RX requirement.
> 
>    o IBT WAIT-FOR-ENDBR state is a speculation stop; by placing
>      the hash validation in the immediate instruction after
>      the branch target there is a minimal speculation window
>      and the whole is a viable defence against SpectreBHB.
> 
>    o Kees feels obliged to mention it is slightly more vulnerable
>      when the attacker can write code.
> 
> Obviously this patch relies on kCFI, but additionally it also relies
> on the padding from the call-depth-tracking patches. It uses this
> padding to place the hash-validation while the call-sites are
> re-written to modify the indirect target to be 16 bytes in front of
> the original target, thus hitting this new preamble.
> 
> Notably, there is no hardware that needs call-depth-tracking (Skylake)
> and supports IBT (Tigerlake and onwards).
> 
> Suggested-by: Joao Moreira (Intel) <joao@overdrivepizza.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
