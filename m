Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86316606F0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjAFTLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjAFTLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:11:20 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1D965AF8
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 11:11:19 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gq18so2228367pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 11:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8D3UMgiXLWkn97zxdcVsZ26wy/4Qk/KB4lcp4wb6CBg=;
        b=A4AqfUS5XUfLmvuEwP4oYqK2ebk4628oLq8T74ED9gI/jsApNxIUxodGWGQb0A3cXM
         eRO1DyGJJK2WjsworIDKJ7ufOGIEkbe6lybdBjsrvWkehXq870VUkEVa00BSjANutHiW
         oTJs0pI9PQf+0H6roXuPbQzeUkKXk4cteN3qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8D3UMgiXLWkn97zxdcVsZ26wy/4Qk/KB4lcp4wb6CBg=;
        b=54B3uLxxJAtKCYXXEhD6wzN0z3exgkJSa168l75nielOzDPWvjTcwqFs/rREK7ePNt
         tLaoKrftILtVIk3a88ToImKtlqiXov/0jL0VK05f3BuQ0R9ma6Bf5F599LyX8NIuu9tH
         aOFdR2YBVGGiSvwuiQRN2gsR3t44sfAi8rZboI47Yi5IkXfv1MZdXKAJ/JFfLa3TY18E
         ChbwicRS5+vZgghLZgq8BTCdv8HGfY8d0dJneuPZdcsADRtjNRPNLgETKItfbjWWvF3L
         4xdSE/4FAVHENRW9ZHdenV73vAWkIwbCP0BkGDviNCmCg8emeGuAH8Pqb3vnfxJfiQ4e
         +fqA==
X-Gm-Message-State: AFqh2koTh55lj4h23sjnPQcgSK7RFmgDrJVbK17lWkwHOFOuNAR+8bzt
        fJ190kXrWJOz58cpLz6jDHCrSFNPv6ibJrf2
X-Google-Smtp-Source: AMrXdXvYyR1F/thrOSPadqoE90Q0LDkthAlS9+yTY4mnVKRYpyTjuE3IUhd/bTftBN8cldUyhmW4Dw==
X-Received: by 2002:a05:6a21:7893:b0:af:1a39:553d with SMTP id bf19-20020a056a21789300b000af1a39553dmr86781422pzc.14.1673032279194;
        Fri, 06 Jan 2023 11:11:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z188-20020a6265c5000000b0055f209690c0sm688639pfb.50.2023.01.06.11.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 11:11:18 -0800 (PST)
Date:   Fri, 6 Jan 2023 11:11:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsprintf: fix possible NULL pointer deref in vsnprintf()
Message-ID: <202301061107.C56365E@keescook>
References: <1f4d159e-5382-3c75-bd5e-42337ecd8c28@omp.ru>
 <Y7hDGoCbWG2ZYdlV@alley>
 <20230106121457.05edbbdf@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106121457.05edbbdf@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 12:14:57PM -0500, Steven Rostedt wrote:
> On Fri, 6 Jan 2023 16:49:46 +0100
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > > Index: linux/lib/vsprintf.c
> > > ===================================================================
> > > --- linux.orig/lib/vsprintf.c
> > > +++ linux/lib/vsprintf.c
> > > @@ -2738,6 +2738,15 @@ int vsnprintf(char *buf, size_t size, co
> > >  	if (WARN_ON_ONCE(size > INT_MAX))
> > >  		return 0;
> > >  
> > > +	/*
> > > +	 * C99 allows @buf to be NULL when @size is 0. We treat such NULL as if
> > > +	 * @buf pointed to 0-sized buffer, so we can both avoid a NULL pointer
> > > +	 * dereference and still return # of characters that would be written
> > > +	 * if @buf pointed to a valid buffer...
> > > +	 */
> > > +	if (!buf)
> > > +		size = 0;  
> > 
> > It makes sense except that it would hide bugs. It should print a
> > warning, for example:
> 
> I agree. This is a bug, and should not be quietly ignored.

Yup.

> 
> > 
> > 	char *err_msg;
> > 
> > 	err_msg = check_pointer_msg(buf);
> > 	if (err_msg) {
> > 		WARN_ONCE(1, "Invalid buffer passed to vsnprintf(). Trying to continue with 0 length limit\n");
> > 		size = 0;
> > 	}
> 
> 	if (WARN_ONCE(err_msg, "Invalid buffer passed to vsnprintf(). Trying to continue with 0 length limit\n"))
> 		size = 0;

Also good. Please CC me for an Ack when this is a full patch. :)

-Kees

-- 
Kees Cook
