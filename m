Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B09B63957B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 11:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiKZKoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 05:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiKZKmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 05:42:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838AC13F76
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 02:42:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07578B818C8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E699C433D6;
        Sat, 26 Nov 2022 10:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669459361;
        bh=yyFhvQRD1XJcG+mwk4JDo+k8f8pDCakIApIixiAvYOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JiroKL60J3RELTZlGACY2Y/g5c1LiLkO8UbrgryNi2dJxhCpfCU0b37jNKSWI55nk
         TF3NEyy/DkP8hRJowTeZVKapSaTTLNcgU7XzeNztmVLiLTn7xOtj/9lPGvucj4XMyp
         1Wrn3grTQLw0Ln1ZGiqlIBOP52+YEjZqiV0FaWcQ=
Date:   Sat, 26 Nov 2022 11:25:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: fix potential null-ptr-deref in
 kernfs_path_from_node_locked()
Message-ID: <Y4HpqJUINYTDLTrr@kroah.com>
References: <20221123020419.1867-1-thunder.leizhen@huawei.com>
 <Y35Qgw4Q8XYD5Did@slm.duckdns.org>
 <ba083b44-93d5-37c4-380c-8e0249b2333c@huawei.com>
 <ba46adff-3604-9ccf-b1c5-83411f6652d9@huawei.com>
 <55041efe-7443-d576-287b-49d1221fced2@huawei.com>
 <164f759d-23b8-0a68-e68e-2f0a46318e94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164f759d-23b8-0a68-e68e-2f0a46318e94@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 05:49:50PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/11/24 10:52, Leizhen (ThunderTown) wrote:
> > 
> > 
> > On 2022/11/24 10:28, Leizhen (ThunderTown) wrote:
> >>
> >>
> >> On 2022/11/24 10:24, Leizhen (ThunderTown) wrote:
> >>>
> >>>
> >>> On 2022/11/24 0:55, Tejun Heo wrote:
> >>>> On Wed, Nov 23, 2022 at 10:04:19AM +0800, Zhen Lei wrote:
> >>>>> Ensure that the 'buf' is not empty before strlcpy() uses it.
> >>>>>
> >>>>> Commit bbe70e4e4211 ("fs: kernfs: Fix possible null-pointer dereferences
> >>>>> in kernfs_path_from_node_locked()") first noticed this, but it didn't
> >>>>> fix it completely.
> >>>>>
> >>>>> Fixes: 9f6df573a404 ("kernfs: Add API to generate relative kernfs path")
> >>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>>>
> >>>> I think the right thing to do is removing that if. It makes no sense to call
> >>>> that function with NULL buf and the fact that nobody reported crashes on
> >>>> NULL buf indicates that we in fact never do.
> 
> kernfs_path_from_node
>     -->kernfs_path_from_node_locked
> 
> EXPORT_SYMBOL_GPL(kernfs_path_from_node)
> 
> I've rethought it. The export APIs need to do null pointer check, right?

No, callers should get this right.  Are there any in-tree ones that do
not?

thanks,

greg k-h
