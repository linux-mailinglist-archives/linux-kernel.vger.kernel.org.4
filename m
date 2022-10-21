Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED13606F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJUFhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJUFhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:37:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D3C1BE1FC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 22:37:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1974E61DC8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD180C433C1;
        Fri, 21 Oct 2022 05:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666330619;
        bh=C4x6hYFDAWi4DXcimrF67aLQPsZW93Mx96V0amCnWn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QlbKpgGx1qrMgSdaJyivXXf5qor/X961lpc0yRR+woSzH3tCcgiu1gmz/NBYEXQfe
         K4vsmjcCVpegODndBu2vg9R9eT4zstEkXIb1SfoFeTNCPoQOhnVD+4siGARAhiytQw
         tUVK0o7ipMo473nLX2GyW5d8TYlaC0oYKW+aMHhw=
Date:   Fri, 21 Oct 2022 07:37:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luben Tuikov <luben.tuikov@amd.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org,
        rafael@kernel.org, somlo@cmu.edu, mst@redhat.com,
        jaegeuk@kernel.org, chao@kernel.org, hsiangkao@linux.alibaba.com,
        huangjianan@oppo.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, akpm@linux-foundation.org,
        alexander.deucher@amd.com, richard@nod.at, liushixin2@huawei.com
Subject: Re: [PATCH 00/11] fix memory leak while kset_register() fails
Message-ID: <Y1IwLOUGayjT9p6d@kroah.com>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:29:31AM -0400, Luben Tuikov wrote:
> On 2022-10-20 22:20, Yang Yingliang wrote:
> > The previous discussion link:
> > https://lore.kernel.org/lkml/0db486eb-6927-927e-3629-958f8f211194@huawei.com/T/
> 
> The very first discussion on this was here:
> 
> https://www.spinics.net/lists/dri-devel/msg368077.html
> 
> Please use this link, and not the that one up there you which quoted above,
> and whose commit description is taken verbatim from the this link.
> 
> > 
> > kset_register() is currently used in some places without calling
> > kset_put() in error path, because the callers think it should be
> > kset internal thing to do, but the driver core can not know what
> > caller doing with that memory at times. The memory could be freed
> > both in kset_put() and error path of caller, if it is called in
> > kset_register().
> 
> As I explained in the link above, the reason there's
> a memory leak is that one cannot call kset_register() without
> the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
> in this case, i.e. kset_register() fails with -EINVAL.
> 
> Thus, the most common usage is something like this:
> 
> 	kobj_set_name(&kset->kobj, format, ...);
> 	kset->kobj.kset = parent_kset;
> 	kset->kobj.ktype = ktype;
> 	res = kset_register(kset);
> 
> So, what is being leaked, is the memory allocated in kobj_set_name(),
> by the common idiom shown above. This needs to be mentioned in
> the documentation, at least, in case, in the future this is absolved
> in kset_register() redesign, etc.

Based on this, can kset_register() just clean up from itself when an
error happens?  Ideally that would be the case, as the odds of a kset
being embedded in a larger structure is probably slim, but we would have
to search the tree to make sure.

thanks,

greg k-h
