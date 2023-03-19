Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2151D6C03EE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 19:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCSSzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 14:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjCSSzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 14:55:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48E31FE3;
        Sun, 19 Mar 2023 11:55:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i9so8502657wrp.3;
        Sun, 19 Mar 2023 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679252100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T8FuFglnsRTgM0DFJejxa4YeSyCwH93jBqxU8rr/8OI=;
        b=PCodkK3x5ukl2M4K3OGErs9joY41dIBSVutIJPRdvjcJ3PiZ39lPDqawUMepncr5Tt
         ZCyyl9oK4ulMjV+UItVFbLvQmx84kVsUWN1EIWvKmQfeH1gQKCXe0yYf2vewISAES1oM
         hfb85ywP1iPPPkuCSsovZG0jQEqMXNmZUsQ9vjx1y7QuJciGh8/535NBrHj9mBZcnzxd
         e0bnad28cQHTQJYcQxYO+8b5Xen4b0HsHK+TjnduIPwGduyOG3zzey7quU3/6n+C1lfD
         huzOGJdtaBuinUFX5VIW1H9FgE6lHK1QVXn5H7MAuMbkizyBpp0D1O2tJgOUAJKd7lDY
         F6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679252100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8FuFglnsRTgM0DFJejxa4YeSyCwH93jBqxU8rr/8OI=;
        b=U71U+1eTuojLioD/45QkdyU3NENIGTaIhfk7XGHzKWYKma9563wTAQPXyON/OnCW0T
         0/vvL5oBkX6Lo6n87ZFrNdhyAClU02ueB743Fcac7h32aE8aYA0UuPPXCg4Y2SubGoG0
         DeOqpVJOK386WK1XvETdcjhwc8NyB6WRcGj51V6Iae7SakYRkrdJeAc1Ar/CGNH7dSQQ
         8Ro4mjstW6KP2gByaqRRdskEXO4G9R3qBJ0hgnagumoEij0QGQcrQWf9tjYQuYjNPvWC
         QTfXWwoFScCRlU5eWcVLxphX+xVJRve9VfbKJ/BWWwwy/Sgu6EKBqEviupj6bltxdUgL
         D4vQ==
X-Gm-Message-State: AO0yUKXbWOzGnvtZhpw2DZlVDBLoko0CdZzhdR7zy9wOFMhpB+MhKVBH
        26HHahzJFR82/CULVrcRV54=
X-Google-Smtp-Source: AK7set/6qugdrP+lP+37lsKec2suWsOgRB5q7oQUIoTp8ZmqaX7YJXSI6HexDporJ8igGdBY4jRi2w==
X-Received: by 2002:a5d:4985:0:b0:2cf:f140:52e3 with SMTP id r5-20020a5d4985000000b002cff14052e3mr12201175wrq.9.1679252099627;
        Sun, 19 Mar 2023 11:54:59 -0700 (PDT)
Received: from krava (net-93-147-243-166.cust.vodafonedsl.it. [93.147.243.166])
        by smtp.gmail.com with ESMTPSA id c8-20020adfe708000000b002cde626cd96sm7067347wrm.65.2023.03.19.11.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 11:54:59 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 19 Mar 2023 19:54:56 +0100
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, kpsingh@kernel.org
Subject: Re: [PATCH 5/7] ftrace: Store direct called addresses in their ops
Message-ID: <ZBdagJQFA/Z7Phj5@krava>
References: <20230316173811.1223508-1-revest@chromium.org>
 <20230316173811.1223508-6-revest@chromium.org>
 <ZBcqUoUTZSNyIjLx@krava>
 <20230319135443.1d29db2d@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319135443.1d29db2d@rorschach.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 01:54:43PM -0400, Steven Rostedt wrote:
> On Sun, 19 Mar 2023 16:29:22 +0100
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > > +++ b/kernel/trace/ftrace.c
> > > @@ -2582,9 +2582,8 @@ ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
> > >  static void call_direct_funcs(unsigned long ip, unsigned long pip,
> > >  			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > >  {
> > > -	unsigned long addr;
> > > +	unsigned long addr = ops->direct_call;  
> > 
> > nice, should it be read with READ_ONCE ?
> 
> Is there a "read tearing" too?

don't know, saw the comment in __modify_ftrace_direct and got curious
why it's not in here.. feel free to ignore, I'll look it up

jirka

> 
> -- Steve
> 
> > 
> > jirka
> > 
> > >  
> > > -	addr = ftrace_find_rec_direct(ip);
> > >  	if (!addr)
> > >  		return;
> > >  
> > > @@ -5380,6 +5379,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> > >  	ops->func = call_direct_funcs;
> > >  	ops->flags = MULTI_FLAGS;
> > >  	ops->trampoline = FTRACE_REGS_ADDR;
> > > +	ops->direct_call = addr;
> > >  
> > >  	err = register_ftrace_function_nolock(ops);
> > >  
> > > @@ -5454,6 +5454,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> > >  	/* Enable the tmp_ops to have the same functions as the direct ops */
> > >  	ftrace_ops_init(&tmp_ops);
> > >  	tmp_ops.func_hash = ops->func_hash;
> > > +	tmp_ops.direct_call = addr;
> > >  
> > >  	err = register_ftrace_function_nolock(&tmp_ops);
> > >  	if (err)
> > > @@ -5475,6 +5476,8 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> > >  			entry->direct = addr;
> > >  		}
> > >  	}
> > > +	/* Prevent store tearing if a trampoline concurrently accesses the value */
> > > +	WRITE_ONCE(ops->direct_call, addr);
> > >  
> > >  	mutex_unlock(&ftrace_lock);
