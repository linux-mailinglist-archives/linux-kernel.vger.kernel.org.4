Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D32F719704
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjFAJdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjFAJdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:33:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB69AA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:33:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D5C264290
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528C2C433D2;
        Thu,  1 Jun 2023 09:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685612020;
        bh=FbISwwZyQ9hntnqdSS4jFuij2bzfWzgJBzsrXpq9if8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ClM6HpOCQMQpDcY/EjiV5L0IggnjCll0g9DiKNZJvX+F+05qUjYoQ8tZ6v0QQHx7+
         JOB1bwM3FScJ/J6OBAZ5Uyp76kpGy0GXYIE4ibOyWulMgqsU101qeIU4SGw+va9kHQ
         MFq/B7mFgfwi9JxXxL6Fl0LcOWClRM+bHiDccA7c=
Date:   Thu, 1 Jun 2023 10:33:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v4 1/4] devres: Provide krealloc_array
Message-ID: <2023060104-removal-map-b194@gregkh>
References: <20230509094942.396150-1-james.clark@arm.com>
 <20230509094942.396150-2-james.clark@arm.com>
 <2023051340-sinuous-darkroom-2497@gregkh>
 <89ad5070-db72-7bf1-5d86-a89fea54e789@arm.com>
 <2023051530-immunize-pony-49ef@gregkh>
 <46bb773c-31a8-c57a-0cde-39c27d0a6e36@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46bb773c-31a8-c57a-0cde-39c27d0a6e36@arm.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 11:44:55PM +0100, Suzuki K Poulose wrote:
> (Removed irrelevant recipients), +Cc: coresight ml
> 
> Hi Greg,
> 
> On 15/05/2023 12:55, Greg KH wrote:
> > On Mon, May 15, 2023 at 08:55:33AM +0100, James Clark wrote:
> > > 
> > > 
> > > On 13/05/2023 12:04, Greg KH wrote:
> > > > On Tue, May 09, 2023 at 10:49:38AM +0100, James Clark wrote:
> > > > > There is no krealloc_array equivalent in devres. Users would have to
> > > > > do their own multiplication overflow check so provide one.
> > > > > 
> > > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > Signed-off-by: James Clark <james.clark@arm.com>
> > > > > ---
> > > > >   Documentation/driver-api/driver-model/devres.rst |  1 +
> > > > >   include/linux/device.h                           | 11 +++++++++++
> > > > >   2 files changed, 12 insertions(+)
> 
> ...
> 
> > > Maybe something could be done with some macro magic, but it would
> > > probably end up being worse than just copying them and would affect the
> > > real ones as well. So yeah I can't think of any easy gains either.
> > 
> > Ok, that's good.  Given a lack of objections from others, I'll just take
> > this through my driver core tree in a few days.
> 
> Apologies for hijacking the thread. We have a series for CoreSight[1]
> that depends on this series, which I see that, is queued in your
> driver-core-next.
> 
> I would like to queue [1] for the next version (as there are other
> work that depend on this, e.g., [2]). Do you have any
> recommendations/comments on the proposal ? Are you able to share a
> stable branch which can be merged to coresight/next and queue the
> series ontop ? (PS: I haven't queued anything for coresight/next yet).

You can pull from my driver-core-next branch just fine and assume it
will be stable.  So just pull in that one commit and all should be good
in the future.

thanks,

greg k-h
