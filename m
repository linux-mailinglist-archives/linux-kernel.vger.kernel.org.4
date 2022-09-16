Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B445BA370
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 02:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiIPALW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 20:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIPALU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 20:11:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7DF57573
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 17:11:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F37FA6277E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BEBC433C1;
        Fri, 16 Sep 2022 00:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663287078;
        bh=Vy69aml8hU2McMw2JQr1x3Oz7RBNUPYxKERbs9nrDQY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=OLTrcrlk//iYOL/3Cj/mI3AkwBU75vOjylohZ4EOEtPteOkOfto7yS/9SXMt7FpJE
         WjMzBujlqdlR39oRZOwJLgu/MHOIBZqaVFqcaseP5iXjetHW8AIPWC5Udxfi4du+u1
         PTCyR2HlrDa7/051hMx2UeB/i/OflObry62g/u9eCK6nLQuhRg6FPCnJrVW9J7IcUn
         XPouayjNXw43swEHL4Mm0/lBXJmVg8pyXVVOrlMTIQsHMs2sj1Ns8m4m5esNP8++OQ
         XFSarM4KtTv9zMqJVp6iRxU2k5EViSOQylPG/aXwlfnvtjaUZelfutfvpe0d4Ykp+G
         8g52HMWixRPmg==
Date:   Thu, 15 Sep 2022 17:11:16 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Jan Beulich <jbeulich@suse.com>
cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen/privcmd: remove privcmd_ioctl_mmap()
In-Reply-To: <b5c83169-0b92-1ebe-ae5f-fc7bd4e19b99@suse.com>
Message-ID: <alpine.DEB.2.22.394.2209151709420.157835@ubuntu-linux-20-04-desktop>
References: <20220915083944.10097-1-jgross@suse.com> <8137166b-a4c2-aa26-84f9-7b9b2a7e028e@suse.com> <4a95c3d1-d4e8-9b59-8db8-231b59cdb8f5@suse.com> <b5c83169-0b92-1ebe-ae5f-fc7bd4e19b99@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2022, Jan Beulich wrote:
> On 15.09.2022 12:20, Juergen Gross wrote:
> > On 15.09.22 11:32, Jan Beulich wrote:
> >> On 15.09.2022 10:39, Juergen Gross wrote:
> >>> The IOCTL_PRIVCMD_MMAP isn't in use by Xen since at least Xen 4.0.
> >>>
> >>> Remove it from the privcmd driver.
> >>>
> >>> Signed-off-by: Juergen Gross <jgross@suse.com>
> >>
> >> Can we reasonably remove an IOCTL, without being entirely certain that
> >> no users exist outside of xen.git?
> > 
> > This is a valid question. I'm not sure how probable it is that such a user
> > is existing. Are there any Xen tool stacks not using the Xen libraries?
> > 
> > If so, why? Do we want to support those use cases?
> 
> I'm afraid I have no answers to these questions, and hence would generally
> want to be conservative with removal of functionality.

I don't know either, but maybe we could at least mark IOCTL_PRIVCMD_MMAP
as deprecated in include/uapi/xen/privcmd.h ?
