Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429076AC97C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjCFRMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjCFRMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:12:05 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AD065441;
        Mon,  6 Mar 2023 09:11:33 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bi9so13740358lfb.2;
        Mon, 06 Mar 2023 09:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678122609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mnci6hzTT/Kxs2TgRZtbA/kjwc3ZEmc+C4mmuZyVD20=;
        b=Nk4bk9vb79H+xsdXq4aetbpBf78nNwlE0hkZ9lcf8TPU7FQhzaAu4yw/H+p2R7blLu
         6cRCLxlS8Pcb0Y+YC5gayxgSvR2zz/WGz5dsYXZEKf+Xh0Oato45fSlZvYdAb0VDPjgF
         5YeTNo0XkbWqufw2MjQgohQ1KRhiEn7NFaU0+5a8aO/UjE3nJ8LdkJjE1rXzh0KRZLpN
         ghNvR61YD1TKt5i2UuyWnkdn+lFDjg9pBY0jDHmWJzAyVqbOwklsOFzGvXd4FV9+MgyT
         HlqqxJm53Sd92jh0lqIaTR4/+BRTCMDanHV/FzhLVBuHt9qe6Mawdt6OoIwMMfZ02QJl
         AuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678122609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnci6hzTT/Kxs2TgRZtbA/kjwc3ZEmc+C4mmuZyVD20=;
        b=w10Aj1CN73UeiyhbPPsuauBZdBi/0pb8Hu8a+UJ3lpzUYKBBTkr0rL24P+ZM/7OFtV
         CmrbboxY10E8oGHkASXBzW+O4x1G93iL830XR+E1dAnP0BFzm+Ep2QV3Q1TQZAqSEcMm
         +URCe0F6ZvLPuzr6gwo99eIi175a562mZfjSyUG1bzHgi7nID5Xd/xe8/DYEgUDY8EpR
         HMstR6dUJ7UlaI1fSQieEmPal8vx5JpP3zGnO3sR0MyO4nZe5e3sEj1HnS4tetbalb0v
         pgwwZidOZtxCFHCjQmi9cA2u9ssG3dnBd0NjJQofhGEBkopuFK9wENa3urb+GTEETQNL
         THBw==
X-Gm-Message-State: AO0yUKUTQvl+RBy4ZEsuL0Y7Ab/HMBx0lYfxTAEgoJXcH/0hirViwH0c
        inj8TG9U+rZBWLCLMXcBjxc=
X-Google-Smtp-Source: AK7set8+//AghdJircJKNVSk89rs5jbzv3fVFyT2PfMX8fyiycBlYszOOEWZfBzUwjU5CyVxCGVY3g==
X-Received: by 2002:ac2:483a:0:b0:4df:51a7:a92 with SMTP id 26-20020ac2483a000000b004df51a70a92mr3120832lft.11.1678122609345;
        Mon, 06 Mar 2023 09:10:09 -0800 (PST)
Received: from pc636 (host-90-235-0-207.mobileonline.telia.com. [90.235.0.207])
        by smtp.gmail.com with ESMTPSA id n19-20020ac242d3000000b004dc4bb914c7sm1691550lfl.201.2023.03.06.09.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 09:10:09 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 6 Mar 2023 18:10:06 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
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
Message-ID: <ZAYebhiXJAct1vUS@pc636>
References: <ZAR//FKO4syzapk6@pc636>
 <D8B84631-860B-41CF-8311-88E220C7254F@joelfernandes.org>
 <20230305180524.GL1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230306144948.GA3280216@google.com>
 <20230306150108.GT1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230306151203.GC3280216@google.com>
 <ZAYYBEnIZEfUhBYW@pc636>
 <20230306165501.GX1301832@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306165501.GX1301832@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 08:55:01AM -0800, Paul E. McKenney wrote:
> On Mon, Mar 06, 2023 at 05:42:44PM +0100, Uladzislau Rezki wrote:
> > On Mon, Mar 06, 2023 at 03:12:03PM +0000, Joel Fernandes wrote:
> > > On Mon, Mar 06, 2023 at 07:01:08AM -0800, Paul E. McKenney wrote:
> > > [..] 
> > > > > > 7.	We then evaluate whether further cleanups are needed.
> > > > > > 
> > > > > > > > My feeling is
> > > > > > > > that, we introduced "_mightsleep" macros first and after that try to
> > > > > > > > convert users.
> > > > > > 
> > > > > > > One stopgap could be to add a checkpatch error if anyone tries to use old API,
> > > > > > > and then in the meanwhile convert all users.
> > > > > > > Though, that requires people listening to checkpatch complaints.
> > > > > > 
> > > > > > Every person who listens is that much less hassle.  It doesn't have to
> > > > > > be perfect.  ;-)
> > > > > 
> > > > > The below checkpatch change can catch at least simple single-arg uses (i.e.
> > > > > not having compound expressions inside of k[v]free_rcu() args). I will submit
> > > > > a proper patch to it which we can include in this set.
> > > > > 
> > > > > Thoughts?
> > > > > ---
> > > > >  scripts/checkpatch.pl | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > > 
> > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > > index 78cc595b98ce..fc73786064b3 100755
> > > > > --- a/scripts/checkpatch.pl
> > > > > +++ b/scripts/checkpatch.pl
> > > > > @@ -6362,6 +6362,15 @@ sub process {
> > > > >  			}
> > > > >  		}
> > > > >  
> > > > > +# check for soon-to-be-deprecated single-argument k[v]free_rcu() API
> > > > > +		if ($line =~ /\bk[v]?free_rcu\s*\([^(]+\)/) {
> > > > > +			if ($line =~ /\bk[v]?free_rcu\s*\([^,]+\)/) {
> > > > > +				ERROR("DEPRECATED_API",
> > > > > +				      "Single-argument k[v]free_rcu() API is deprecated, please pass an rcu_head object." . $herecurr);
> > > > 
> > > > Nice!
> > > > 
> > > > But could you please also tell them what to use instead?  Sure, they
> > > > could look it up, but if it tells them directly, they are less likely
> > > > to ignore it.
> > > 
> > > Sounds good, I will modify the warning to include the API to call and send
> > > out a patch soon.
> > > 
> > Maybe compile warnings? Or is it too aggressive?
> 
> That is an excellent option if people ignore the checkpatch.pl warnings,
> thus forcing us to delay past v6.5.  So Murphy would argue that we will
> in fact take your good advice at some point.  ;-)
> 
OK. On this step it sounds like a bit aggressive. checkpatch.pl should
be fine as a light reminder :)

--
Uladzislau Rezki
