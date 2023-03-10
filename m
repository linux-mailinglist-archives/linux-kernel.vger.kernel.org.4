Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E6B6B33D0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCJBsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCJBsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:48:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3695BAC;
        Thu,  9 Mar 2023 17:47:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A62B5B82168;
        Fri, 10 Mar 2023 01:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475F9C433EF;
        Fri, 10 Mar 2023 01:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678412875;
        bh=oitd4xYPDLaZ26iTmZ1QB2D+PfMEhhPrOxGOwJG1DJw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dM+cTHXEuF0zZMQJ5v6TB5ytChtDjF9EQbpi0oajh2EYyIFnchAsoiJ/G4QXs/E1M
         rsqlCHuU98WB6VM7MwhzWz1I+gnnECscXicM0J/IhX0JJLG2SSB7colqYU6OA+O13Y
         Bmz3T/szNtVeN7IUv1AQYh8Fq0v72n4MSY7LYcy3B5wVch0GZEjEmeMlM5uy6hQQHX
         Qe4dot2hfESyVPBaEAdWXKg3DetWRKGsTA9tQ9rqo6XnYeaOmUu1TNX2RPxX8AtplM
         cHgHQtxCxZNLfPuZz7yOWXtXKb27SAUjzAiTvQfx19Kf0gGeqw8QaDu3b9lR14GxK7
         42kxZdVQUr86g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C80AC1548D6E; Thu,  9 Mar 2023 17:47:54 -0800 (PST)
Date:   Thu, 9 Mar 2023 17:47:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     qiuxu.zhuo@intel.com, frederic@kernel.org, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <a6f9d56a-3f5f-4057-9a35-a697a96df0f2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1a4b1362-defb-4464-9217-32e6d3d4a8d2@paulmck-laptop>
 <6e38d7d7-9991-b0a6-2855-0c8838cce142@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e38d7d7-9991-b0a6-2855-0c8838cce142@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 09:11:54AM +0900, Akira Yokosawa wrote:
> Hi,
> 
> Let me chime in this interesting thread.
> 
> On Thu, 9 Mar 2023 13:53:39 -0800, Paul E. McKenney wrote:
> > On Thu, Mar 09, 2023 at 03:17:09PM +0000, Zhuo, Qiuxu wrote:
> >> > From: Paul E. McKenney <paulmck@kernel.org>
> >> > [...]
> >> > >
> >> > > a's standard deviation is ~0.4.
> >> > > b's standard deviation is ~0.5.
> >> > >
> >> > > a's average 9.0 is at the upbound of the standard deviation of b's [8.0, 9].
> >> > > So, the measurements should be statistically significant to some degree.
> >> > 
> >> > That single standard deviation means that you have 68% confidence that the
> >> > difference is real.  This is not far above the 50% leval of random noise.
> >> > 95% is the lowest level that is normally considered to be statistically
> >> > significant.
> >> 
> >> 95% means there is no overlap between two standard deviations of a
> >> and two standard deviations of b.
> >> 
> >> This relies on either much less noise during testing or a big enough 
> >> difference between a and b. 
> 
> Appended is a histogram comparing 2 data sets.
> 
> As you see, the one with v2 patch is far from normal distribution.
> I think there is at least two peaks.
> The one at the right around 9.7 seems not affected by the patch.
> In such a case, average and standard deviation of all the data don't
> tell much.
> 
> It is hard to say anything for sure with such small set of samples.
> And the shape of the plot is likely to be highly dependent on machine
> setups.
> 
> Hope this helps.

Thank you, Akira!  Definitely an abnormal distribution!  ;-)

							Thanx, Paul
