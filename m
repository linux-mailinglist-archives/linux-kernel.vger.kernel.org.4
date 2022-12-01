Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2194263F575
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiLAQj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiLAQjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:39:47 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D5EBB7D2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:39:30 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so2598101pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 08:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8tTkfl7b38uC2WDz4yKrjD8Z9Ib6oZTawq2Wea8T5PA=;
        b=lcEPbMdKdFt38HwwgaWulaeQeLiD6eYpcMAEPqcuGZrdr5CbZ+TTIaq/YZ8EbPmLWO
         i9yjejt8UDI7SYb7sMp6/rBviiGAxo7HXDWmLy+usxx+tHysd3j2ew2Xtz6krPpdlY/c
         9nywz2AFdfmTNWpiqcEO03qQAGRsKKrQjwwGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tTkfl7b38uC2WDz4yKrjD8Z9Ib6oZTawq2Wea8T5PA=;
        b=Xkl2wj0o3c3GWXVUFF4RpPlhq2yxBfIrQNgfQhZTbBjTQqZeLvTaIjj27Xtx7bErKQ
         Pz0LkvjLIs1ecMSxMnYHJp+9rzVhIapzrGepOejdNYlJ/CCRMsTIy6YU19z5EmBtqCzr
         OisPtHxcFORonuM83IDz89+tsKncdfE+N5bf82SAn+ZYG+7JOJV9GgFSfuDWaDXds5V2
         8v+GzSCUbIFwtr92GRDURn4UN5iF6wlYHwUoOesrzgsyYklhjRh5YV2CKYr1PzZbs7++
         Pxxqi3SCBzFyX5uiLgvjgNsdgeXdHszZtyE02VtccGXwb35Dm88zKnnIBf29rU07/xE4
         o/zw==
X-Gm-Message-State: ANoB5pkDDo0ZJ83K2i0R1H3wcCHr+Q8h91vfROZ9/mt5aAfyotSVE/Rr
        n//DKb8Ozrn4EiIkP5zelOHxQCf11tbmNA==
X-Google-Smtp-Source: AA0mqf4f7gCUcsmkqpUQfrgl82A7UuVZBERQ+axZ0hQO6SEqhkozoWE3FDVjTR0AxNotqoG8ct6R6w==
X-Received: by 2002:a17:902:e74d:b0:186:887b:baa2 with SMTP id p13-20020a170902e74d00b00186887bbaa2mr62209107plf.27.1669912769708;
        Thu, 01 Dec 2022 08:39:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z15-20020a655a4f000000b0046faefad8a1sm2759204pgs.79.2022.12.01.08.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 08:39:29 -0800 (PST)
Date:   Thu, 1 Dec 2022 08:39:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
Subject: Re: [RFC PATCH] panic: Add new taint flag for fault injection
Message-ID: <202212010838.B0B109DA@keescook>
References: <20221201234121.8925fdf83115747ac4ac116a@kernel.org>
 <166991263326.311919.16890937584677289681.stgit@devnote3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166991263326.311919.16890937584677289681.stgit@devnote3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 01:37:13AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the function error injection framework in the fault injection
> subsystem can change the function code flow forcibly, it may cause
> unexpected behavior (but that is the purpose of this feature).
> To identify this in the kernel oops message, add a new taint flag
> for this, and set it if it is (and similar things in BPF) used.

Why is hooking through BPF considered to be "fault injection" here?

-- 
Kees Cook
