Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BC1612405
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJ2Owr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJ2Owo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:52:44 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CE2640C;
        Sat, 29 Oct 2022 07:52:43 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-13bef14ea06so9362296fac.3;
        Sat, 29 Oct 2022 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwnCAiei1whE+Be7EoJMLh4TL6YCuvqKCJBzgqzGqOc=;
        b=eFE1tYG+WmHIhwxjpqC8OAG0cBEHvsJraLzPuHakg0hPooD/nGNhGQHVU//kzoEcNs
         TO/3ZhQR0N2Bh5luyXh7FfsgDStYQ6K2Yxv5LQzXsgjdpUn50y4qvQmlhO+N4t7EJwgV
         amMo9YMxEAL89rNwB13nOXMZgGaBQuFd/cfk8LKu+FukGiDR3pz401z3SMVrqvY8pN/T
         azpf1Lakpv3ArNP1/gF61vpYvIeFqQudUpP1Mh706W2IuSRp3LugfYtcxYvUXxNdZkWS
         pPch2jmQTPuRGVSx4xvMcVvaYt3aSgyNdZQEWvQ78EJkvFLclCqzkgRMLucp7YNCeITx
         QQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwnCAiei1whE+Be7EoJMLh4TL6YCuvqKCJBzgqzGqOc=;
        b=VaYmEfPUaev2MTzzEA9pVocLqwfVIVFPQiMKSRQAxRg3IWWwatVzqeZGSuv8d6MtHv
         iODjY/PdYNYrkuq83DCVjbR9r45JsA9kkpTL7E/rA2OpLRkBS77flcX4/gZjI63Xl7mh
         PF8KWYeWCa6qvTazjBXNKqOJEDEZgeg0FQEgZQz8pR2O/jas4hifWZAn4mLu5QyTDIsd
         4wpSYLxRbrQlqTuskpxeZ64MYki3tq7CRIscZ1cLLaeaAEblrObRXG3BPTfh0gGz6eqr
         LBnbpLVH/kozEBJjhn/94CD7ckngJNiG0IAfdcfFUR+51UKn2is8jGLcp62mog6GItRY
         Y80g==
X-Gm-Message-State: ACrzQf3QZDhw2T8/JAydV8kAt7NBuAF6TACMjusC4+n5wxRm/Ko8GQH3
        YuQ9WwrYOJMJDTFUJ5pO4Ls=
X-Google-Smtp-Source: AMsMyM4R6nB9g+5TpuFK/Quhv8UgAR4fbog4Ou/8bXvQI2EioWAaHA8yrPLGi8p6yn7a5Em4gs5vGQ==
X-Received: by 2002:a05:6870:350e:b0:13c:37cd:dc32 with SMTP id k14-20020a056870350e00b0013c37cddc32mr9821144oah.185.1667055163211;
        Sat, 29 Oct 2022 07:52:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d13-20020a056870e24d00b0013b1301ce42sm723920oac.47.2022.10.29.07.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 07:52:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 29 Oct 2022 07:52:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-usb@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [RFC][PATCH v2 20/31] timers: usb: Use del_timer_shutdown()
 before freeing timer
Message-ID: <20221029145241.GA3296895@roeck-us.net>
References: <20221027150525.753064657@goodmis.org>
 <20221027150928.983388020@goodmis.org>
 <4e61935b-b06b-1f2d-6c2b-79bdfd569cd6@roeck-us.net>
 <20221028140129.040d9acc@gandalf.local.home>
 <20221028141007.05f5c490@gandalf.local.home>
 <20221028195959.GA1073367@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028195959.GA1073367@roeck-us.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 01:00:02PM -0700, Guenter Roeck wrote:
> On Fri, Oct 28, 2022 at 02:10:07PM -0400, Steven Rostedt wrote:
> > On Fri, 28 Oct 2022 14:01:29 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > @@ -813,6 +839,14 @@ void destroy_timer_on_stack(struct timer_list *timer)
> > >  }
> > >  EXPORT_SYMBOL_GPL(destroy_timer_on_stack);
> > >  
> > > +static struct timer_base *lock_timer_base(struct timer_list *timer,
> > > +					  unsigned long *flags);
> > > +
> > > +void __timer_reinit_debug_objects(struct timer_list *timer)
> > > +{
> > > +	return;
> > > +}
> > > +
> > >  #else
> > >  static inline void debug_timer_init(struct timer_list *timer) { }
> > >  static inline void debug_timer_activate(struct timer_list *timer) { }
> > 
> > Bah, the above chunk was leftover from some debugging.
> > 
> 
> I'll test again with the following changes on top of your published
> patch series. I hope this is the current status, but I may have lost
> something.
> 

With the diffs I sent earlier applied, the warning still seen is

WARNING: CPU: 0 PID: 9 at lib/debugobjects.c:502 debug_print_object+0xd0/0x100
ODEBUG: free active (active state 0) object type: timer_list hint: neigh_timer_handler+0x0/0x480

That happens with almost every test, so I may have missed some others
in the noise.

Guenter
