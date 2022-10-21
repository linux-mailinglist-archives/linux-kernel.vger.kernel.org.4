Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B769607279
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJUIgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiJUIg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:36:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CF83B9A1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:36:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E113761DFB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57E2C433D6;
        Fri, 21 Oct 2022 08:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666341367;
        bh=VYkxOdyqZTRP94uFOMrKlhrYPkv6+oVeaJOCigiokeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0LHArjuO/emmogeedg4sidpH81EIC1oFajIQk20rr9Km/Y0ewObOQB0i43jXid6V8
         MEWVl4mxIE2auEWLdOFh5S0zN7a5cdswL8kZv1F5sHrcBCX+9z8wc+kpjX8Czr8S07
         DVGuTf4yxBxOxcpimxvN26SCCFuV+ZffgRv7I1WQ=
Date:   Fri, 21 Oct 2022 10:36:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Luben Tuikov <luben.tuikov@amd.com>, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org,
        rafael@kernel.org, somlo@cmu.edu, mst@redhat.com,
        jaegeuk@kernel.org, chao@kernel.org, hsiangkao@linux.alibaba.com,
        huangjianan@oppo.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, akpm@linux-foundation.org,
        alexander.deucher@amd.com, richard@nod.at, liushixin2@huawei.com
Subject: Re: [PATCH 00/11] fix memory leak while kset_register() fails
Message-ID: <Y1JZ9IUPL6jZIQ8E@kroah.com>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com>
 <Y1IwLOUGayjT9p6d@kroah.com>
 <0591e66f-731a-5f81-fc9d-3a6d80516c65@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0591e66f-731a-5f81-fc9d-3a6d80516c65@huawei.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:24:23PM +0800, Yang Yingliang wrote:
> 
> On 2022/10/21 13:37, Greg KH wrote:
> > On Fri, Oct 21, 2022 at 01:29:31AM -0400, Luben Tuikov wrote:
> > > On 2022-10-20 22:20, Yang Yingliang wrote:
> > > > The previous discussion link:
> > > > https://lore.kernel.org/lkml/0db486eb-6927-927e-3629-958f8f211194@huawei.com/T/
> > > The very first discussion on this was here:
> > > 
> > > https://www.spinics.net/lists/dri-devel/msg368077.html
> > > 
> > > Please use this link, and not the that one up there you which quoted above,
> > > and whose commit description is taken verbatim from the this link.
> > > 
> > > > kset_register() is currently used in some places without calling
> > > > kset_put() in error path, because the callers think it should be
> > > > kset internal thing to do, but the driver core can not know what
> > > > caller doing with that memory at times. The memory could be freed
> > > > both in kset_put() and error path of caller, if it is called in
> > > > kset_register().
> > > As I explained in the link above, the reason there's
> > > a memory leak is that one cannot call kset_register() without
> > > the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
> > > in this case, i.e. kset_register() fails with -EINVAL.
> > > 
> > > Thus, the most common usage is something like this:
> > > 
> > > 	kobj_set_name(&kset->kobj, format, ...);
> > > 	kset->kobj.kset = parent_kset;
> > > 	kset->kobj.ktype = ktype;
> > > 	res = kset_register(kset);
> > > 
> > > So, what is being leaked, is the memory allocated in kobj_set_name(),
> > > by the common idiom shown above. This needs to be mentioned in
> > > the documentation, at least, in case, in the future this is absolved
> > > in kset_register() redesign, etc.
> > Based on this, can kset_register() just clean up from itself when an
> > error happens?  Ideally that would be the case, as the odds of a kset
> > being embedded in a larger structure is probably slim, but we would have
> > to search the tree to make sure.
> I have search the whole tree, the kset used in bus_register() - patch #3,
> kset_create_and_add() - patch #4
> __class_register() - patch #5,  fw_cfg_build_symlink() - patch #6 and
> amdgpu_discovery.c - patch #10
> is embedded in a larger structure. In these cases, we can not call
> kset_put() in error path in kset_register()

Yes you can as the kobject in the kset should NOT be controling the
lifespan of those larger objects.

If it is, please point out the call chain here as I don't think that
should be possible.

Note all of this is a mess because the kobject name stuff was added much
later, after the driver model had been created and running for a while.
We missed this error path when adding the dynamic kobject name logic,
thank for looking into this.

If you could test the patch posted with your error injection systems,
that could make this all much simpler to solve.

thanks,

greg k-h
