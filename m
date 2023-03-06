Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BEF6AC3DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjCFOud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjCFOuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:50:22 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D4D2716
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:49:55 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id r5so10738987qtp.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678114190;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CRWs2EFCPuBMPKV81kaTXM8CT+AT1P7bsl0h2Aecgew=;
        b=qc3iLB4VuhZnZ6itNutIAclg/fR/X2D3ZMlruWowvT6We1OxrMRBq4iTOlWiftfrOr
         s8+5x5T7UNgaAcV6r0r16Fghl15tKgjFmdjjOq0vTX8ISy5oo403LT5OOC7t4TIN0oyt
         biKyavNw79axnKL8oS+1PbwgMBtw8At1eq0yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678114190;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRWs2EFCPuBMPKV81kaTXM8CT+AT1P7bsl0h2Aecgew=;
        b=OAryjLe8tZ5BvUM4dcya6RSb3zUkfeKjDokDrX0Eh7JAQjmD8n1sN2o3EwOJTpuX+U
         IWbnR3u68R3krYzkPDuRswpjaZ0xXOK+GEt6fbHDRHwOvNiFUnmQ8wrpbBdRixewm0er
         sR77qx+ImXma/YSEDYhIODZ0RG5dFTtywXJbdYF8jjWuNxtgsf2wVFShYwBYN53XBW5d
         5XQvZ8BIbQXutN1lly1hRcmBNF+6l8R55xe4hlgz9/jVveb3IxFjF1lKTX95Ixz6O+We
         IgnzoPzBbiA1pevzaY57xnxkrJYPfqkqzOobaCXeIcd1p9tl7JBqEnm2UAAqPf0+rBz9
         SGLA==
X-Gm-Message-State: AO0yUKV/yVv47FyhretY4oyUWuPeNCMoL9wVG6eSiLKci58//Vj2gi9Z
        D53EulOTM6NtmwS9e87Qx6YfaQ==
X-Google-Smtp-Source: AK7set9Sw1c226vsFw+2m8ajyGEeRUjI4xT7GzUOBssiEMMvCLSo6OgyjC4l5BQEtTvt73srCs1lvw==
X-Received: by 2002:a05:622a:1443:b0:3bf:d4c3:365d with SMTP id v3-20020a05622a144300b003bfd4c3365dmr18743306qtx.14.1678114189869;
        Mon, 06 Mar 2023 06:49:49 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id w25-20020a05620a129900b0073ba211e765sm7548983qki.19.2023.03.06.06.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:49:48 -0800 (PST)
Date:   Mon, 6 Mar 2023 14:49:48 +0000
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
Message-ID: <20230306144948.GA3280216@google.com>
References: <ZAR//FKO4syzapk6@pc636>
 <D8B84631-860B-41CF-8311-88E220C7254F@joelfernandes.org>
 <20230305180524.GL1301832@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230305180524.GL1301832@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 10:05:24AM -0800, Paul E. McKenney wrote:
> On Sun, Mar 05, 2023 at 07:56:33AM -0500, Joel Fernandes wrote:
> > 
> > 
> > > On Mar 5, 2023, at 6:41 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > > 
> > > ﻿
> > >> 
> > >>>> On Mar 5, 2023, at 5:29 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > >>> 
> > >>> ﻿Hi, All,
> > >>> 
> > >>>> On Wed, Feb 1, 2023 at 10:11 AM Uladzislau Rezki (Sony)
> > >>>> <urezki@gmail.com> wrote:
> > >>>> 
> > >>>> For a single argument invocations a new kfree_rcu_mightsleep()
> > >>>> and kvfree_rcu_mightsleep() macroses are used. This is done in
> > >>>> order to prevent users from calling a single argument from
> > >>>> atomic contexts as "_mightsleep" prefix signals that it can
> > >>>> schedule().
> > >>>> 
> > >>> 
> > >>> Since this commit in -dev branch [1] suggests more users still need
> > >>> conversion, let us drop this single patch for 6.4 and move the rest of
> > >>> the series forward? Let me know if you disagree.
> > >>> https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=9bf5e3a2626ed474d080f695007541b6ecd6e60b
> > >>> 
> > >>> All -- please supply Ack/Review tags for patches 1-12.
> > >> 
> > >> Or put another way, what is the transition plan for these remaining users?
> > >> 
> > >> I am getting on a plane right now but I can research which users are remaining later.
> > >> 
> > > I am not sure. I think we can cover it on the meeting.
> > 
> > Cool, thanks.
> 
> My current plan is as follows:
> 
> 1.	Addition of kvfree_rcu_mightsleep() went into v6.3.
> 
> 2.	After creating branches, I send out the series, including 12/12.
> 	The -rcu tree's "dev" branch continues to have a revert to avoid
> 	breaking -next until we achieve clean -next and clean "dev"
> 	branch.
> 
> 3.	Any conversion patches that get maintainer acks go into v6.4.
> 	Along with a checkpatch error, as Joel notes below.
> 
> 4.	There are periodic checks for new code using the single-argument
> 	forms of kfree_rcu() and kvfree_rcu().	Patches are produced
> 	for them, or responses to the patches introducing them, as
> 	appropriate.  A coccinelle script might be helpful, perhaps
> 	even as part of kernel test robot or similar.
> 
> 5.	The -rcu tree's "dev" branch will revert to unclean from time
> 	to time as maintainers choose to take conversion patches into
> 	their own trees.
> 
> 6.	Once mainline is clean, we push 12/12 into the next merge
> 	window.

Since in theory, mainline could also be after 6.4-rc1, I am assuming next merge
window could also mean 6.5 right? But yes, agreed.

> 7.	We then evaluate whether further cleanups are needed.
> 
> > > My feeling is
> > > that, we introduced "_mightsleep" macros first and after that try to
> > > convert users.
> 
> > One stopgap could be to add a checkpatch error if anyone tries to use old API,
> > and then in the meanwhile convert all users.
> > Though, that requires people listening to checkpatch complaints.
> 
> Every person who listens is that much less hassle.  It doesn't have to
> be perfect.  ;-)

The below checkpatch change can catch at least simple single-arg uses (i.e.
not having compound expressions inside of k[v]free_rcu() args). I will submit
a proper patch to it which we can include in this set.

Thoughts?
---
 scripts/checkpatch.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 78cc595b98ce..fc73786064b3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6362,6 +6362,15 @@ sub process {
 			}
 		}
 
+# check for soon-to-be-deprecated single-argument k[v]free_rcu() API
+		if ($line =~ /\bk[v]?free_rcu\s*\([^(]+\)/) {
+			if ($line =~ /\bk[v]?free_rcu\s*\([^,]+\)/) {
+				ERROR("DEPRECATED_API",
+				      "Single-argument k[v]free_rcu() API is deprecated, please pass an rcu_head object." . $herecurr);
+			}
+		}
+
+
 # check for unnecessary "Out of Memory" messages
 		if ($line =~ /^\+.*\b$logFunctions\s*\(/ &&
 		    $prevline =~ /^[ \+]\s*if\s*\(\s*(\!\s*|NULL\s*==\s*)?($Lval)(\s*==\s*NULL\s*)?\s*\)/ &&
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

