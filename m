Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84CD6AC484
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjCFPMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCFPMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:12:12 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07CF22A1C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 07:12:05 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d7so10784772qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 07:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678115525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qpjRwMBpeQIyYBuVAs6Veb66byuhymu6yZKVw/mFN2g=;
        b=fSJNDRDk4A+hkSZsMhrKhJ0kmPEjlw5YnDGm8tlvtk1jagwZBEC1+kjnf5HsgmkarE
         X4cJFbHzVv5rm97FTIPSV50F11uDFNJorIDPhEBReSxOEiDWeFLJCvBtrVCHoM9qhEsm
         M/if6GQF1kTG3YwEzWXar3xr/ktiKsNy+ohlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678115525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpjRwMBpeQIyYBuVAs6Veb66byuhymu6yZKVw/mFN2g=;
        b=NaHzdjXJtMYCIYTKhIrZuqkZKaBm+m50/2p9WtSkSJY6MZvXCbXQnUTAYhigxzXYr3
         kgCAWJsjjrY98KSsofV3vZugwdUWDq5Q6s7saH+qUPpvvvo0xk9A1qLsLtE8mWxqgb2t
         LXTXuc1nsjG3+2wu/Nyu7tzIiZ+yKNnpmewKxuhqBi/3pAV8kZB6Z8ntW+85Fmm3AYnr
         GK0yDEfrz/CGl8cik/tZfk2NfXbQ1lJwhekofCGZL5y8838/eS5uAcsdsj0KX3NiPUeC
         aIst664cxisXlF28xToF2XrnKZBm17uG+OpBtFXF/u9OHXD64Icevqa2uFMpUSKeVB1k
         Vlsg==
X-Gm-Message-State: AO0yUKWXL+sOTwgDL5vR1WSq9ZAcSKCQKaHQ1zqZDBaJXR04aGEgoU8t
        oP4GcxrVBQOz5H3rX7R9N/jDLwVdA0OW/qYMOr4=
X-Google-Smtp-Source: AK7set97E9vII1jsCN7q8RvIvSNf+febcQOfp6CdZM+ka/pDRW6TLdav8X+QbuxQnGEE07P58jWSjg==
X-Received: by 2002:ac8:5cc5:0:b0:3bf:c849:4971 with SMTP id s5-20020ac85cc5000000b003bfc8494971mr16492535qta.62.1678115524741;
        Mon, 06 Mar 2023 07:12:04 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id i10-20020ac871ca000000b003bfb950f670sm7683092qtp.41.2023.03.06.07.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:12:04 -0800 (PST)
Date:   Mon, 6 Mar 2023 15:12:03 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <20230306151203.GC3280216@google.com>
References: <ZAR//FKO4syzapk6@pc636>
 <D8B84631-860B-41CF-8311-88E220C7254F@joelfernandes.org>
 <20230305180524.GL1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230306144948.GA3280216@google.com>
 <20230306150108.GT1301832@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306150108.GT1301832@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 07:01:08AM -0800, Paul E. McKenney wrote:
[..] 
> > > 7.	We then evaluate whether further cleanups are needed.
> > > 
> > > > > My feeling is
> > > > > that, we introduced "_mightsleep" macros first and after that try to
> > > > > convert users.
> > > 
> > > > One stopgap could be to add a checkpatch error if anyone tries to use old API,
> > > > and then in the meanwhile convert all users.
> > > > Though, that requires people listening to checkpatch complaints.
> > > 
> > > Every person who listens is that much less hassle.  It doesn't have to
> > > be perfect.  ;-)
> > 
> > The below checkpatch change can catch at least simple single-arg uses (i.e.
> > not having compound expressions inside of k[v]free_rcu() args). I will submit
> > a proper patch to it which we can include in this set.
> > 
> > Thoughts?
> > ---
> >  scripts/checkpatch.pl | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 78cc595b98ce..fc73786064b3 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -6362,6 +6362,15 @@ sub process {
> >  			}
> >  		}
> >  
> > +# check for soon-to-be-deprecated single-argument k[v]free_rcu() API
> > +		if ($line =~ /\bk[v]?free_rcu\s*\([^(]+\)/) {
> > +			if ($line =~ /\bk[v]?free_rcu\s*\([^,]+\)/) {
> > +				ERROR("DEPRECATED_API",
> > +				      "Single-argument k[v]free_rcu() API is deprecated, please pass an rcu_head object." . $herecurr);
> 
> Nice!
> 
> But could you please also tell them what to use instead?  Sure, they
> could look it up, but if it tells them directly, they are less likely
> to ignore it.

Sounds good, I will modify the warning to include the API to call and send
out a patch soon.

thanks,

 - Joel

