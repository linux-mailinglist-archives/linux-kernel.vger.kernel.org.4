Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2767161F2C7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiKGMT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiKGMTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:19:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A7B104
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:19:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ACE060FF9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAC2C433D6;
        Mon,  7 Nov 2022 12:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667823563;
        bh=NXLWfK7l78W38zCNhwmd9CoegE5mNTMF1ivRn/nZnGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l9TgRhJZUITnhn+2+zgPBEJ5nsuQg/Vdk7kW7gjbRmvM3YDDPigKqW8Syf7aJ2vT9
         IcOLXrVjZgTl2codzemM2F7DSpY+dlQkvBly8NYJnm4NGqAUtDfUj2O1HF61HtDx/9
         bJFIZsNL7UehilVW/ZR7nXSqJ2SH5gqdSxSYAYy0=
Date:   Mon, 7 Nov 2022 13:19:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>, stable@kernel.org,
        Aishwarya TCV <Aishwarya.TCV@arm.com>,
        Cristian Marussi <Cristian.Marussi@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.10] coresight: cti: Fix hang in cti_disable_hw()
Message-ID: <Y2j3yKkzkZFXKjDh@kroah.com>
References: <20221102112003.2318583-1-james.clark@arm.com>
 <Y2jLvmF0GZ6yHY0m@kroah.com>
 <4d44d2c8-a8ec-1729-d3cc-9ae8beb48045@arm.com>
 <Y2jVXdX1Mx5eXAiB@kroah.com>
 <99b25aab-ba87-b875-9f5f-c7dd9444b8c8@arm.com>
 <Y2jc4f+iEfA9qAQA@kroah.com>
 <5cf4b3b9-9c0d-8e30-3159-d63c7f5b9648@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf4b3b9-9c0d-8e30-3159-d63c7f5b9648@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 11:15:35AM +0000, Suzuki K Poulose wrote:
> Hi Greg,
> 
> On 07/11/2022 10:24, Greg Kroah-Hartman wrote:
> > On Mon, Nov 07, 2022 at 09:59:24AM +0000, Suzuki K Poulose wrote:
> > > On 07/11/2022 09:52, Greg Kroah-Hartman wrote:
> > > > On Mon, Nov 07, 2022 at 09:23:26AM +0000, Suzuki K Poulose wrote:
> > > > > On 07/11/2022 09:11, Greg Kroah-Hartman wrote:
> > > > > > On Wed, Nov 02, 2022 at 11:20:03AM +0000, James Clark wrote:
> > > > > > > commit 6746eae4bbaddcc16b40efb33dab79210828b3ce upstream.
> > > > > > 
> > > > > > Isn't this commit 665c157e0204176023860b51a46528ba0ba62c33 instead?
> > > > > 
> > > > > This was reverted in commit d76308f03ee1 and pushed in later
> > > > > with fixups as 6746eae4bbadd.
> > > > 
> > > > So which should be applied?
> > > 
> > > Sorry, this particular post is a backport for v5.10 stable branch.
> > > 
> > > > 
> > > > confused,
> > > 
> > > Now I am too. What is expected here ? My understanding is, we
> > > should stick the "upstream" commit that is getting backported
> > > at the beginning of the commit description. In that sense,
> > > the commit id in this patch looks correct to me. Please let
> > > me know if this is not the case.
> > > 
> > > As such, this is only for 5.10.x branch. The rest are taken
> > > care of.
> > > 
> > > Please let us know if we are something missing.
> > 
> > We already have commit 665c157e0204176023860b51a46528ba0ba62c33 queued
> > up in the 5.10 stable queue.  Is that not correct?  It has the same
> 
> We pushed the fix as part of the coresight fixes for 6.1 [0], as
> 
> commit: 6746eae4bbad "coresight: cti: Fix hang in cti_disable_hw()"
> 
> 
> But, the version in there, produced a build warning with "unused
> variable" (with CONFIG_WERROR) [1] and thus was reverted in [2],
> 
> commit: d76308f03ee1: Revert "coresight: cti: Fix hang in cti_disable_hw()"
> 
> 
> Later, we sent you the corrected fix separately [3], which was queued as
> commit "6746eae4bbadd".
> 
> 6746eae4bbad coresight: cti: Fix hang in cti_disable_hw()
> 
> So, in effect, here is what we have in the tree :
> 
> $ git log --oneline | grep "cti: Fix"
> 6746eae4bbad coresight: cti: Fix hang in cti_disable_hw()
> d76308f03ee1 Revert "coresight: cti: Fix hang in cti_disable_hw()"
> 665c157e0204 coresight: cti: Fix hang in cti_disable_hw()
> 
> > subject line as this one.
> 
> I understand the "same" subject line has caused this confusion. Will
> modify it in the future avoid this confusion.
> 
> So, kindly drop "665c157e0204" from the queue for 5.10, it would fail to
> apply there anyway so does the correct "6746eae4bbad". This backport
> is appropriate for 5.10 branch, with the correct version.

Ok, I dropped 665c157e0204 from the queue, but note that it _was_
backported there properly.  But only there, which is odd, Sasha's
scripts might not have caught up.

I'll queue this one up now instead.

thanks,

greg k-h
