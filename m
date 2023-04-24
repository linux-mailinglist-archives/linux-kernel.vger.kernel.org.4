Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393646EA2F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 07:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjDUFFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 01:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDUFFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 01:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76BA30DF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 22:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 685C364DAF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5445EC433EF;
        Fri, 21 Apr 2023 05:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682053500;
        bh=UHCTZ4kDpkUYHNfhYhRYIYeovcY56hwy7QCLZ/BHRmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RKZVw14Vld5k6lO22Tvv12c5r+qTz+ti/yRl01DEw3XkcFw6v/5FaNKrJVsuQ9jBw
         g8DhOVrePP7UJqd9Pk9eySbVwls9egEFaxg8kR/LVJOBZScN32SrUImFiPd6BMIqxO
         WYCrBTtcZ70RTmbTVETMNAA3d2k5o1nTiP9A10i0=
Date:   Fri, 21 Apr 2023 07:03:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org
Subject: Re: [PATCH 02/22] greybus: Use alloc_ordered_workqueue() to create
 ordered workqueues
Message-ID: <ZEIZFjfAA0MyuCLT@kroah.com>
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-3-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421025046.4008499-3-tj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 04:50:26PM -1000, Tejun Heo wrote:
> BACKGROUND
> ==========
> 
> When multiple work items are queued to a workqueue, their execution order
> doesn't match the queueing order. They may get executed in any order and
> simultaneously. When fully serialized execution - one by one in the queueing
> order - is needed, an ordered workqueue should be used which can be created
> with alloc_ordered_workqueue().
> 
> However, alloc_ordered_workqueue() was a later addition. Before it, an
> ordered workqueue could be obtained by creating an UNBOUND workqueue with
> @max_active==1. This originally was an implementation side-effect which was
> broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
> ordered"). Because there were users that depended on the ordered execution,
> 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
> made workqueue allocation path to implicitly promote UNBOUND workqueues w/
> @max_active==1 to ordered workqueues.
> 
> While this has worked okay, overloading the UNBOUND allocation interface
> this way creates other issues. It's difficult to tell whether a given
> workqueue actually needs to be ordered and users that legitimately want a
> min concurrency level wq unexpectedly gets an ordered one instead. With
> planned UNBOUND workqueue updates to improve execution locality and more
> prevalence of chiplet designs which can benefit from such improvements, this
> isn't a state we wanna be in forever.
> 
> This patch series audits all callsites that create an UNBOUND workqueue w/
> @max_active==1 and converts them to alloc_ordered_workqueue() as necessary.
> 
> WHAT TO LOOK FOR
> ================
> 
> The conversions are from
> 
>   alloc_workqueue(WQ_UNBOUND | flags, 1, args..)
> 
> to
> 
>   alloc_ordered_workqueue(flags, args...)
> 
> which don't cause any functional changes. If you know that fully ordered
> execution is not ncessary, please let me know. I'll drop the conversion and
> instead add a comment noting the fact to reduce confusion while conversion
> is in progress.
> 
> If you aren't fully sure, it's completely fine to let the conversion
> through. The behavior will stay exactly the same and we can always
> reconsider later.
> 
> As there are follow-up workqueue core changes, I'd really appreciate if the
> patch can be routed through the workqueue tree w/ your acks. Thanks.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: greybus-dev@lists.linaro.org

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

