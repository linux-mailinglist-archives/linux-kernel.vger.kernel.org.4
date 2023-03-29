Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF026CEEDA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjC2QJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjC2QJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:09:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E982B5B81;
        Wed, 29 Mar 2023 09:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81054B82371;
        Wed, 29 Mar 2023 16:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FA9C4339B;
        Wed, 29 Mar 2023 16:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680106081;
        bh=enJerK8BV7TZcY8hMulDr/MyR3IQQzJAjpyRyNFFxhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHYPFeccmSp7OVMJy6eS/srYMyeAsSwJIF+hYqDCY7yjvT/T8dihBnPwVB9uy231m
         SNfiI4re5lYCyFHWzblb0eqL+5qTvbgDUCgwwNl+WAsz/mqD3TTbuB6cm3NgRAnoRH
         dy3bsTFgrobDT3RtmnZ9QHwJENdrUQXhW/t/tpEwTge74oZ5lzzDqQMeASNKFaaxo0
         CHkolqcKbXrKfNmlWOIWV8mVNWPZKAt1gvHXcj22tSW2cLQTfHNxBzj7MwWE7AyADP
         Vk4WFBNzn7Tw088XEbmNN8HEMedIPn09Wa7lILbBT5aGLKwPD61A9AhPga1wsEs3yv
         YUMFNtbv/7Blg==
Date:   Wed, 29 Mar 2023 18:07:58 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/4] rcu/nocb: Protect lazy shrinker against concurrent
 (de-)offloading
Message-ID: <ZCRiXrQQRNy2aJAS@lothringen>
References: <20230322194456.2331527-1-frederic@kernel.org>
 <20230322194456.2331527-2-frederic@kernel.org>
 <c614c542-f2b5-4b39-bbc4-ae5f0a125c81@paulmck-laptop>
 <ZB4fhA1BafN7h2N3@localhost.localdomain>
 <ae1cb391-aeed-4587-8d9d-50909c918fb1@paulmck-laptop>
 <ZCCknqnceazfyzvr@localhost.localdomain>
 <dd853e13-ffcd-4579-adad-80b014e906ef@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd853e13-ffcd-4579-adad-80b014e906ef@paulmck-laptop>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 02:45:18PM -0700, Paul E. McKenney wrote:
> On Sun, Mar 26, 2023 at 10:01:34PM +0200, Frederic Weisbecker wrote:
> > > > > >  	/* Snapshot count of all CPUs */
> > > > > >  	for_each_possible_cpu(cpu) {
> > > > > >  		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > > > > > -		int _count = READ_ONCE(rdp->lazy_len);
> > > > > > +		int _count;
> > > > > > +
> > > > > > +		if (!rcu_rdp_is_offloaded(rdp))
> > > > > > +			continue;
> > > > > 
> > > > > If the CPU is offloaded, isn't ->lazy_len guaranteed to be zero?
> > > > > 
> > > > > Or can it contain garbage after a de-offloading operation?
> > > > 
> > > > If it's deoffloaded, ->lazy_len is indeed (supposed to be) guaranteed to be zero.
> > > > Bypass is flushed and disabled atomically early on de-offloading and the
> > > > flush resets ->lazy_len.
> > > 
> > > Whew!  At the moment, I don't feel strongly about whether or not
> > > the following code should (1) read the value, (2) warn on non-zero,
> > > (3) assume zero without reading, or (4) some other option that is not
> > > occurring to me.  Your choice!
> > 
> > (2) looks like a good idea!
> 
> Sounds good to me!

So since we now iterate rcu_nocb_mask after the patchset, there is no more
deoffloaded rdp to check. Meanwhile I put a WARN in the new series making
sure that an rdp in rcu_nocb_mask is also offloaded (heh!)
