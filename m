Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D990D63F5BB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLAQxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiLAQxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:53:05 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A0289310
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:53:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so2638918pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 08:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfXu45xdfTyVLVkfj9ZZQsbbr7ecm2c21plsrP1SZFA=;
        b=En2kIJ9mdNILFPY+fiqHUP8koejjvpiaXqpsgU1tFRsaUtYAXsBxPrGuDeB1ZgOEzn
         63QllEyYhZWrTMMzhjfdVXGqPj+RYhgnY07raNt1VGnjk3RNBiCpli+1qteGrPJgvzdd
         38eb4KvxHzw79QQ3LXkfXZRseZd6pGafDV2No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfXu45xdfTyVLVkfj9ZZQsbbr7ecm2c21plsrP1SZFA=;
        b=xxtjicnMrqAS6AKnQ/S6Ramipk4q9gxOY+qsmkZ1iRpoQA2DieRJVGjrsf7lry7P+S
         ys2g0Om7Ikzx3aK46mGloft0XKD1WxBmDBvkKNsYNCUQiE0AvV2o/BlVJJpgYii2NHrX
         ScdSjTKKrp6eZslBoPIFDhznpNpFbW4LVFX5N1THCQKD5X4HYviTWXVFe4ShseZhGOKd
         s3IYGrx0kU/qBdnlqCq/24H6Yf5uqzGS7XdBK3iv4opitHJmVtXhNBOHFMlaCc1t1314
         l6BFLa1j3B/KxJas9bN5iw74ZH78i1OYCJPtLkPrB+L6Q3c3UY/cmqqJuw6AbNMY3WxX
         U5Ow==
X-Gm-Message-State: ANoB5pkMR4xaOdqQVg90SZkYxkEQP4026VenkQ2ua0w0gLyNA32SkVej
        uFVYhtzYZXvYTsyg3nxs2+tPUA==
X-Google-Smtp-Source: AA0mqf5FATOadw2oQcUmoM1RyvfoRAFkgyzWE9k33ts6EqZ2ZronOD6oVFdPtMBhtyUGlg91iPdMow==
X-Received: by 2002:a17:903:491:b0:185:46a5:1c73 with SMTP id jj17-20020a170903049100b0018546a51c73mr51085424plb.157.1669913584065;
        Thu, 01 Dec 2022 08:53:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090341cb00b001896af10ca7sm3902020ple.134.2022.12.01.08.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 08:53:03 -0800 (PST)
Date:   Thu, 1 Dec 2022 08:53:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <202212010852.6D4B542@keescook>
References: <20221201234121.8925fdf83115747ac4ac116a@kernel.org>
 <166991263326.311919.16890937584677289681.stgit@devnote3>
 <202212010838.B0B109DA@keescook>
 <20221201114848.13a87aca@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201114848.13a87aca@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 11:48:48AM -0500, Steven Rostedt wrote:
> On Thu, 1 Dec 2022 08:39:28 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Fri, Dec 02, 2022 at 01:37:13AM +0900, Masami Hiramatsu (Google) wrote:
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Since the function error injection framework in the fault injection
> > > subsystem can change the function code flow forcibly, it may cause
> > > unexpected behavior (but that is the purpose of this feature).
> > > To identify this in the kernel oops message, add a new taint flag
> > > for this, and set it if it is (and similar things in BPF) used.  
> > 
> > Why is hooking through BPF considered to be "fault injection" here?
> > 
> 
> Have you not been reading this thread?

I skimmed it -- trying to catch up from turkey week. If this was already
covered, then please ignore me. It just wasn't obvious from the commit
log why it was included.

-- 
Kees Cook
