Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D1E5F79CE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJGOkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJGOkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:40:19 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51302193FD;
        Fri,  7 Oct 2022 07:40:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a29so7636390lfo.1;
        Fri, 07 Oct 2022 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rRgtCA04zYN6upAR2EQb4vf6WPPb4T6Dsa/7jxZWXrQ=;
        b=f5J8NbrKWC4N0OgVy0zVjfDuM+2Vmm0lzCjnJWNuHihojpyom8Iq9Hl23uV7pdjij2
         XjycbGIC+ewaOSsRawVTRs4/ngZS7gdHvvEMEsHJV2iwPWIndaiPLBa2YlSUZQa0o2LP
         t6Qyfgx4t+u6MZ+e/Jq0cZA/5YqhTssm/7EKd8r6e0JhKsbPcOhZU/bAysCJGc4A1onp
         P3Hgpq7cT5ZFOui02SAmmtE9Fx3xg9TZmlKwEqkWkQlRML0PAT7+mE9UCRnhcG6xUTrX
         ynrepefA7R+TuozlnuFRCVYvBWjg0gayDaT+KYTatsTm589fNul3Dz4YY8Gb7bzyl+rW
         zBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRgtCA04zYN6upAR2EQb4vf6WPPb4T6Dsa/7jxZWXrQ=;
        b=Y4a3fedF3kjZCjOH2ESgQepUbyZOjpBNt6ZEIbpP2RLvg6jS+K1q0JVnzpsjBhkOTN
         wShGd9NZWzUkKTEZWawpX6mV3js7YxqxbooRGxBb3F9BWTUS7WWwcV6hmE13TglVLpGO
         GT4zP6aR6mT4xxsR4tPbSaC4NB0IEF7Z3bCwJ/nd9e3GNMHZO0WPncNomVjnER+TVpVs
         caYbLgV3zpeZfsjVrTS0s/hp1d0N036M+BCCJTAeOB/SN/K3/JN6HyhaJwnLGNV+2WZo
         Ys8uiikv6b2lG6fGRzczpy6qV0MnyV2FLLwqa+ptYX/IKr/EhDZ6fAaYfhVnjThdYwnU
         ZLOQ==
X-Gm-Message-State: ACrzQf377xC0A2pRYbGWhUvVNJr8Y9HDglTUwv6Tc/pk9QgePHNj2p5W
        fL7emGWBXqlfaA15mytPYww=
X-Google-Smtp-Source: AMsMyM7BhTXFno4rSeRBYNOA7UB1/NIeBz/f6DcSzvGJ7ePgDMKVJ4OabiKo4ouwnvyN+qiZBtFNDQ==
X-Received: by 2002:a05:6512:318f:b0:4a2:a0d5:e684 with SMTP id i15-20020a056512318f00b004a2a0d5e684mr1302460lfe.513.1665153614566;
        Fri, 07 Oct 2022 07:40:14 -0700 (PDT)
Received: from pc636 (host-90-235-26-251.mobileonline.telia.com. [90.235.26.251])
        by smtp.gmail.com with ESMTPSA id k11-20020a05651210cb00b00497feee98basm310604lfg.274.2022.10.07.07.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 07:40:13 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 7 Oct 2022 16:40:11 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v7 00/11] rcu: call_rcu() power improvements
Message-ID: <Y0A6S77d6DFgoKzx@pc636>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221006185543.GB4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221006185543.GB4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 11:55:43AM -0700, Paul E. McKenney wrote:
> On Tue, Oct 04, 2022 at 02:41:46AM +0000, Joel Fernandes (Google) wrote:
> > v7 version of RCU lazy patches based on rcu/next branch.
> > 
> > To facilitate easier merge, I dropped tracing and other patches and just
> > implemented the new changes. I will post the tracing patches later along with
> > rcutop as I need to add new tracepoints that Frederic suggested.
> > 
> > Main recent changes:
> > 1. rcu_barrier() wake up only for lazy bypass list.
> > 2. Make all call_rcu() default-lazy and add call_rcu_flush() API.
> > 3. Take care of some callers using call_rcu_flush() API.
> > 4. Several refactorings suggested by Paul/Frederic.
> > 5. New call_rcu() to call_rcu_flush() conversions by Joel/Vlad/Paul.
> > 
> > I am seeing good performance and power with these patches on real ChromeOS x86
> > asymmetric hardware.
> > 
> > Earlier cover letter with lots of details is here:
> > https://lore.kernel.org/all/20220901221720.1105021-1-joel@joelfernandes.org/
> > 
> > List of recent changes:
> >     
> >     [ Frederic Weisbec: Program the lazy timer only if WAKE_NOT, since other
> >       deferral levels wake much earlier so for those it is not needed. ]
> >     
> >     [ Frederic Weisbec: Use flush flags to keep bypass API code clean. ]
> >     
> >     [ Frederic Weisbec: Make rcu_barrier() wake up only if main list empty. ]
> >     
> >     [ Frederic Weisbec: Remove extra 'else if' branch in rcu_nocb_try_bypass(). ]
> >     
> >     [ Joel: Fix issue where I was not resetting lazy_len after moving it to rdp ]
> >     
> >     [ Paul/Thomas/Joel: Make call_rcu() default lazy so users don't mess up. ]
> >     
> >     [ Paul/Frederic : Cosmetic changes, split out wakeup of nocb thread. ]
> >     
> >     [ Vlad/Joel : More call_rcu -> flush conversions ]
> 
> Thank you for your continued work on this!
> 
> I pulled these into an experimental branch, applied Uladzislau's
> Tested-by and ran a quick round of rcutorture.
> 
> From TREE02, TREE03, and TREE09 I got this:
> 
> In file included from kernel/rcu/tree.c:68:
> kernel/rcu/tree.h:449:13: error: ‘wake_nocb_gp’ used but never defined [-Werror]
>   449 | static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
>       |             ^~~~~~~~~~~~
> 
> One could argue that this is not a big deal, except that Linus gets a
> bit tetchy when this sort of thing shows up in mainline.
> 
Sorry. I have not tested TREE02, TREE03 and TREE09 scenarios. My goal
was to check below functionalities:

- call_rcu_flush() does not introduce any delays once it is queued
- call_rcu() does not apply pressure on the RCU-machinery from wake-up point of view
- boot-time is not degraded
- synchronize_rcu() and rcu_barrier() work as expected
- if bypass consists of lazy callbacks the *flush() one has to initiate the offloading

--
Uladzislau Rezki
