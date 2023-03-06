Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDD06AC889
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjCFQqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjCFQoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:44:17 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017B7211F1;
        Mon,  6 Mar 2023 08:43:54 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j11so13529843lfg.13;
        Mon, 06 Mar 2023 08:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678120967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r1y1Fy1II9jhZHy6+cU0A+dbl30RpS+U0aqrOuGev7E=;
        b=mIShshvXBYDNT8Q6N6W2W1tpYmV29OAQkAu+vsxXu+Cde65nVmjWJc72CFID5S4XO4
         H/G5fVlnWICpsS0XyyM4ctwj7WSHasfymoadqRzxWHH08TT8IUly/CIXRNVsQdft2NZc
         lK2ufL+0VlNJrKsvnG/0L0tcHLDq7DUQ/rMQlEHzSmdTpYrh3k88u3zS8g/R7+J24K21
         EkjffQOLQdSK8fGvAEuDfmIiKSH0yIXUgYetCbO7PA6JJAl30BBL1I+Rx/s/QHG8Vxlr
         EjmCOF/BYx9dTg0mhnFQZ5P5gEmIU32VLrl4Yl6YwgYkMKZcf00+OkU9UvtxLCoLvQrF
         mmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678120967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1y1Fy1II9jhZHy6+cU0A+dbl30RpS+U0aqrOuGev7E=;
        b=hNCkoquuod1SJ/I+gIbA/Lg7pStJHZWWZ1PjsWdUdtOwsX6Wvu/XDEVKuiAiVpWyD1
         HUltpV8e1Ld96tjIpIokeyvlC9kI59+ow6Ow6EbUK9ZhXCcJEwoVle+EJrsEbN/7dBek
         eWAgw1tO/SovKXmNvBcQerRKegzf/zgxrurf6OT54HIQdUKvg27a9ECyy8d3iNqGVDfz
         Av56o5+EJfMkmhLMyAhjc8HouvESGGw4RUnNTsX6F15RGvmsjUWzafKrwYFLHePw5YwB
         1IaULl635uAkbbaM2YlQbRM7JZP34jJuEEecQhZpL3+xT97c9JAaa6vpzxbp9PhO94rH
         sxIQ==
X-Gm-Message-State: AO0yUKVmBkpWdbQnhBDDqrj8yxjxZtutDCfqtRuRnnQQrVukUr71lKod
        rZJI0yTb3GgxY1j0xd1HHUs=
X-Google-Smtp-Source: AK7set9q1hLEvgV7NyO1HycRE2hlOYu5c0aCA4hrPyP4aCEtha9NAk09vBSoyHkHGPDq5y++C1I/9A==
X-Received: by 2002:ac2:43aa:0:b0:4b5:6042:d136 with SMTP id t10-20020ac243aa000000b004b56042d136mr3168541lfl.22.1678120967409;
        Mon, 06 Mar 2023 08:42:47 -0800 (PST)
Received: from pc636 (host-90-235-0-207.mobileonline.telia.com. [90.235.0.207])
        by smtp.gmail.com with ESMTPSA id d12-20020ac24c8c000000b004cc7026d95asm1692181lfl.259.2023.03.06.08.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 08:42:47 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 6 Mar 2023 17:42:44 +0100
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 13/13] rcu/kvfree: Eliminate k[v]free_rcu() single
 argument macro
Message-ID: <ZAYYBEnIZEfUhBYW@pc636>
References: <ZAR//FKO4syzapk6@pc636>
 <D8B84631-860B-41CF-8311-88E220C7254F@joelfernandes.org>
 <20230305180524.GL1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230306144948.GA3280216@google.com>
 <20230306150108.GT1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230306151203.GC3280216@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306151203.GC3280216@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 03:12:03PM +0000, Joel Fernandes wrote:
> On Mon, Mar 06, 2023 at 07:01:08AM -0800, Paul E. McKenney wrote:
> [..] 
> > > > 7.	We then evaluate whether further cleanups are needed.
> > > > 
> > > > > > My feeling is
> > > > > > that, we introduced "_mightsleep" macros first and after that try to
> > > > > > convert users.
> > > > 
> > > > > One stopgap could be to add a checkpatch error if anyone tries to use old API,
> > > > > and then in the meanwhile convert all users.
> > > > > Though, that requires people listening to checkpatch complaints.
> > > > 
> > > > Every person who listens is that much less hassle.  It doesn't have to
> > > > be perfect.  ;-)
> > > 
> > > The below checkpatch change can catch at least simple single-arg uses (i.e.
> > > not having compound expressions inside of k[v]free_rcu() args). I will submit
> > > a proper patch to it which we can include in this set.
> > > 
> > > Thoughts?
> > > ---
> > >  scripts/checkpatch.pl | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 78cc595b98ce..fc73786064b3 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -6362,6 +6362,15 @@ sub process {
> > >  			}
> > >  		}
> > >  
> > > +# check for soon-to-be-deprecated single-argument k[v]free_rcu() API
> > > +		if ($line =~ /\bk[v]?free_rcu\s*\([^(]+\)/) {
> > > +			if ($line =~ /\bk[v]?free_rcu\s*\([^,]+\)/) {
> > > +				ERROR("DEPRECATED_API",
> > > +				      "Single-argument k[v]free_rcu() API is deprecated, please pass an rcu_head object." . $herecurr);
> > 
> > Nice!
> > 
> > But could you please also tell them what to use instead?  Sure, they
> > could look it up, but if it tells them directly, they are less likely
> > to ignore it.
> 
> Sounds good, I will modify the warning to include the API to call and send
> out a patch soon.
> 
Maybe compile warnings? Or is it too aggressive?

Thanks!

--
Uladzislau Rezki
