Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AEE6C2921
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 05:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCUE0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 00:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUE0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 00:26:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602BD25B89;
        Mon, 20 Mar 2023 21:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA98161956;
        Tue, 21 Mar 2023 04:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD53C433EF;
        Tue, 21 Mar 2023 04:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679372804;
        bh=gFv2aJXUNwQ6ce5qb8/S45PJIP1goGD7SztFmscEBK4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZCQ3QoI8+QJQc3XlXdyZ5dh78y+QsEnWOJq3FJxxT+AYDI8yAcLPIgHDexL3QYmog
         jbcz0K6urVz2e5uVwyAE2HcqpJb5zWKxHCAhSpwmHwAr4rl+mfb2VgeBlwBa6YZg3l
         6qNpgIcCgrwPQ367VOpkVwVDKBeLfzD2wIBVieqIsbbeMVKHOMeddR/MCzCkcdd1nN
         TmreiErhxzI2QWthem3VKjPOOmaR8rd4l5b5CuxRC0aTlx35coaxPAElChpyf+aYlS
         iXq+PVl2ejh21v/rKLYAAbDCq8oj7vddR7CZt35lVdvgi/6evNaXZTb+UAjghHuikm
         tW0n1XMLERNYg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EB8F91540395; Mon, 20 Mar 2023 21:26:43 -0700 (PDT)
Date:   Mon, 20 Mar 2023 21:26:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     "dave@stgolabs.net" <dave@stgolabs.net>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
Message-ID: <72ba8619-88cb-4bf4-8232-18d8a1b6b5bf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2bbaa13a-bfcc-45b7-acce-8da59a2a0c32@paulmck-laptop>
 <20230317055006.46365-1-qiuxu.zhuo@intel.com>
 <d93c68a1-5c36-4e48-ab41-c424d903d30d@paulmck-laptop>
 <IA1PR11MB61710BAF452AE6E687D8F3CE89819@IA1PR11MB6171.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB61710BAF452AE6E687D8F3CE89819@IA1PR11MB6171.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 01:21:21AM +0000, Zhuo, Qiuxu wrote:
> > From: Paul E. McKenney <paulmck@kernel.org>
> > Sent: Tuesday, March 21, 2023 4:41 AM
> > [...]
> > >
> > > Fixes: e6e78b004fa7 ("rcuperf: Add kfree_rcu() performance Tests")
> > > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > 
> > Much better!
> > 
> > Except that someone glancing at this patch would be hard pressed to see
> > what changed.
> 
> Indeed.
> 
> > So could you please split this into two patches, the first of which does
> > nothing but move code, and the second of which makes the actual change?
> 
> OK. 
> Will split this patch into two patches in the v3.
> 
> > The commit log for the first patch needs to clearly state that the it is code-
> > motion-only, with no change in behavior.
> 
> OK.
> Thanks so much for your suggestions ;-) 

Looking forward to seeing the next version!

							Thanx, Paul
