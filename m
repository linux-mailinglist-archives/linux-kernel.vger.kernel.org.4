Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E9E6DDDE8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjDKO2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjDKO2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:28:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD0755A9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:27:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a66316bd84so143335ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681223268; x=1683815268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WcxTN/I3dHS8MG4kvF+8dJSNaZcNBe+oGBwRF41LI5c=;
        b=d3aA60iHTaSaMr2sJYz/jIybo2VgIva+ZK/AjJWDCEdMKmGIgBKXplnEsqkkIByxGm
         xeaghHbRReoRggIwfGwlG4R3+78B4G0IWa7V1L6fJuJbllAiQZzBdwmIw3cmYEVWAHzQ
         XWCjhmLnG3qU+ygP9QQ10Lhn1hqmjidKarFaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681223268; x=1683815268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcxTN/I3dHS8MG4kvF+8dJSNaZcNBe+oGBwRF41LI5c=;
        b=zpphgBR2XZX7YYlrm3pW3q/iyi/dlMbkjzAc3DMxbJRp7HbVUy1R5Jwh1qIz9DUhG7
         a23AB4QLHbOImv/F/KRl6IFI3D211BpWtb2bt0zVlYzsfuPyo5HWAP9s1XJRTVgDOX2s
         45BZJr1j9gTkQ8WtqSc9Nrjzc7M86b8Zq7IdDMgQ8J5jvH6m1zkMiik5AcEFOZMpKPsN
         aolwYuI22qW8sN1iXgauZIHyxmajysyLhEOK14FDPG8whxnoaGZ9Pvs20Ha/vdK3XIE7
         eq1oI8Ls/VKwKQfSkPQrw1RETXT0UtCy2kKydNpuWOP+L4vgsGL+K6mBPRr78S2FJc2/
         yAIA==
X-Gm-Message-State: AAQBX9cZvGwxjVkgOtWgWLDa/l/jKamfYA63yGIhrkPdVU8sNg+ufNsc
        GhW51u9tpbdfnzFpHC0ZhmWwXA==
X-Google-Smtp-Source: AKy350agucuElItRP/qbpyW6Aqq5lEIlNv9kGHSzwUuiNXj9UU15fbcpvk8qwPfxGjn08WiOeVyE3w==
X-Received: by 2002:aa7:9a42:0:b0:626:1523:b10d with SMTP id x2-20020aa79a42000000b006261523b10dmr12410714pfj.4.1681223268105;
        Tue, 11 Apr 2023 07:27:48 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id u4-20020a62ed04000000b006363690ddddsm4876681pfh.10.2023.04.11.07.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:27:47 -0700 (PDT)
Date:   Tue, 11 Apr 2023 23:27:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_buf: add seq_buf_printk() helper
Message-ID: <20230411142743.GC25053@google.com>
References: <20230411025556.751349-1-senozhatsky@chromium.org>
 <ZDVPJnx9tjetdm9K@alley>
 <20230411101033.1868494e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411101033.1868494e@gandalf.local.home>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/11 10:10), Steven Rostedt wrote:
[..]
> seq_buf came from trace_seq to become more generic. trace_seq is also part
> of the libtraceevent library, and there we have:
> 
>   trace_seq_do_printf()
> 
>  https://www.trace-cmd.org/Documentation/libtraceevent/libtraceevent-tseq.html
> 
> That is to differentiate the trace_seq_printf() function. And does what
> this function is doing (dumping the buffer).
> 
> Perhaps we should use the precedence of that function and have:
> 
>   seq_buf_do_printk()

OK, I'll rename the helper to seq_buf_do_printk().

> > We should rather use strnchr(). It seems that the trailing '\0' is
> > not guaranteed. For example, seq_buf_putc() just adds the given
> > character at the end.
> 
> I think we should add a seq_buf_terminate() that adds the '\0' to the
> buffer. There's one for user space (trace_seq_terminate()).
> 
> It's a nop if it already has the '\0'.
> 
> I think we should add that first, and then we can use that when entering
> this function.

Sounds good. This also should address Petr's concern.
