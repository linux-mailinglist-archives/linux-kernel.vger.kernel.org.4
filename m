Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748985F0F65
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiI3P73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiI3P70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:59:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D146C1739E6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:59:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66BDA623A1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A68BC433D6;
        Fri, 30 Sep 2022 15:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664553564;
        bh=oiMIJH/YyE90Kaik4KiVIajjTIr2/v8irSkheGdEvcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6VJGl/3uY+4RZD/9CcUG+zHtX+GYmeAeTjfqTQpLN3U3AD3SzvH6w6MkvcQ4LhUM
         rcRd6vhiK12MB8p8Yj2SFvbG9y4Pk+xe6G5e/YWA9xzLsoI1tjAP3Oy8JbvharVyxn
         DUGCrGaBon+uZsopwNDjtwOseNl3DXY2ya+ZcnEhlZY0silUmDRj+kfbuFsAv73TA4
         DhCrUH9FmMZq7VVLGQZiFKezUvQQann7TwyOTvcJfXPQQvsQmR9C+hQIvDh5c1J4/P
         IfDzCX+1nwGT1dbEtbQYOi4ryaTM/eYAN2KzrDBJ74dhcO/U78sDHKnMNiaQVkzFfN
         +B0VD29TJGz2w==
Date:   Fri, 30 Sep 2022 09:59:21 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Christoph Hellwig <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] nvme: Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls for
 nvme devices
Message-ID: <YzcSWfgGDR5QXbr6@kbusch-mbp.dhcp.thefacebook.com>
References: <1663908549-118490-1-git-send-email-mikelley@microsoft.com>
 <20220927072101.GC16285@lst.de>
 <BYAPR21MB168828B36AA2022585AC7AA6D7569@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB168828B36AA2022585AC7AA6D7569@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 03:47:48PM +0000, Michael Kelley (LINUX) wrote:
> From: Christoph Hellwig <hch@lst.de> Sent: Tuesday, September 27, 2022 12:21 AM
> > To: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > Cc: kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-
> > nvme@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 1/1] nvme: Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls for
> > nvme devices
> > 
> > Thanks,
> > 
> > applied to 6.0.
> 
> Christoph -- where did this get applied?  I'm not seeing it in either the linux
> or linux-next trees.  

The path for nvme patches to upstream goes through the nvme tree[1] -> block
tree [2], then linux mainline. The pull request from block to mainline
containing your patch was sent earlier today[3], and we typically see those
merged within a few hours.

[1] http://git.infradead.org/nvme.git
[2] https://git.kernel.dk/cgit/linux-block/
[3] https://lore.kernel.org/linux-block/e5c2a0e5-1a04-50b1-78f0-08d998a8d4e7@kernel.dk/T/#u
