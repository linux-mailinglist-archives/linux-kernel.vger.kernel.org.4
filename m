Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300CF6BB7B6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjCOP1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjCOP1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:27:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D674F22C9F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K5ZrtxAQhAg4taBIjn5Ggqft0vr/AgFW0+J9EI0A4Iw=; b=pr2EXFWcfmlInLFnmMlP9TMUSh
        mFPaikx4ZU2hoTYIBSvcDksRp+NzoLTJNzmhIdUkRyzSGZEcc4+C4JrAxVfn86ARELhqWdbQ2Z6TP
        ATM7eiYiuvm0YUuXxWGaHGL7CyDHMb7X0yMBVYmNKewESvfX7PZapme8+GulcCwgO+kQyVpyTJ3lF
        T7dWy9Bv4yRCIE+5nRy6TN8xPnaDC284scJeNmWQbVfly+l1OFB3WCNopAQc+AF2/GW/fOimrQ8Wa
        sih2vP/PTJPDtahcUTz+zDLs5uHASs3f1MvJXKSBUmgfiqr8eWjlgNlC+Bl3tn6OoTCdGxq/pEpJM
        RHYfSnQg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcT0n-00DwgJ-U1; Wed, 15 Mar 2023 15:25:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25023300237;
        Wed, 15 Mar 2023 16:25:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D42B20FF20AC; Wed, 15 Mar 2023 16:25:53 +0100 (CET)
Date:   Wed, 15 Mar 2023 16:25:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, Hillf Danton <hdanton@sina.com>,
        kernel test robot <yujie.liu@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] sched/fair: Introduce SIS_SHORT to wake up short
 task on current CPU
Message-ID: <20230315152552.GF2006103@hirez.programming.kicks-ass.net>
References: <cover.1677069490.git.yu.c.chen@intel.com>
 <373e6886e274f198608fa1b5f1c254e32b43845d.1677069490.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <373e6886e274f198608fa1b5f1c254e32b43845d.1677069490.git.yu.c.chen@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 10:09:55PM +0800, Chen Yu wrote:

> will-it-scale
> =============
> case			load		baseline	compare%
> context_switch1		224 groups	1.00		+946.68%
> 
> There is a huge improvement in fast context switch test case, especially
> when the number of groups equals the CPUs.
> 
> netperf
> =======
> case            	load    	baseline(std%)	compare%( std%)
> TCP_RR          	56-threads	 1.00 (  1.12)	 -0.05 (  0.97)
> TCP_RR          	112-threads	 1.00 (  0.50)	 +0.31 (  0.35)
> TCP_RR          	168-threads	 1.00 (  3.46)	 +5.50 (  2.08)
> TCP_RR          	224-threads	 1.00 (  2.52)	+665.38 (  3.38)
> TCP_RR          	280-threads	 1.00 ( 38.59)	+22.12 ( 11.36)
> TCP_RR          	336-threads	 1.00 ( 15.88)	 -0.00 ( 19.96)
> TCP_RR          	392-threads	 1.00 ( 27.22)	 +0.26 ( 24.26)
> TCP_RR          	448-threads	 1.00 ( 37.88)	 +0.04 ( 27.87)
> UDP_RR          	56-threads	 1.00 (  2.39)	 -0.36 (  8.33)
> UDP_RR          	112-threads	 1.00 ( 22.62)	 -0.65 ( 24.66)
> UDP_RR          	168-threads	 1.00 ( 15.72)	 +3.97 (  5.02)
> UDP_RR          	224-threads	 1.00 ( 15.90)	+134.98 ( 28.59)
> UDP_RR          	280-threads	 1.00 ( 32.43)	 +0.26 ( 29.68)
> UDP_RR          	336-threads	 1.00 ( 39.21)	 -0.05 ( 39.71)
> UDP_RR          	392-threads	 1.00 ( 31.76)	 -0.22 ( 32.00)
> UDP_RR          	448-threads	 1.00 ( 44.90)	 +0.06 ( 31.83)
> 
> There is significant 600+% improvement for TCP_RR and 100+% for UDP_RR
> when the number of threads equals the CPUs.
> 
> tbench
> ======
> case            	load    	baseline(std%)	compare%( std%)
> loopback        	56-threads	 1.00 (  0.15)	 +0.88 (  0.08)
> loopback        	112-threads	 1.00 (  0.06)	 -0.41 (  0.52)
> loopback        	168-threads	 1.00 (  0.17)	+45.42 ( 39.54)
> loopback        	224-threads	 1.00 ( 36.93)	+24.10 (  0.06)
> loopback        	280-threads	 1.00 (  0.04)	 -0.04 (  0.04)
> loopback        	336-threads	 1.00 (  0.06)	 -0.16 (  0.14)
> loopback        	392-threads	 1.00 (  0.05)	 +0.06 (  0.02)
> loopback        	448-threads	 1.00 (  0.07)	 -0.02 (  0.07)
> 
> There is no noticeable impact on tbench. Although there is run-to-run variance
> in 168/224 threads case, with or without this patch applied.

So there is a very narrow, but significant, win at 4x overload.
What about 3x/5x overload, they only have very marginal gains.

So these patches are briliant if you run at exactly 4x overload, and
very meh otherwise.

Why do we care about 4x overload?
