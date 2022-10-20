Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6E4605C0F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiJTKT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiJTKS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:18:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635A71DB8A3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:18:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3AC961A91
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174CEC433C1;
        Thu, 20 Oct 2022 10:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666261122;
        bh=daXGkVi3pyOKL0rt2s6fBwZuSOy24RMPnvpbZbHV1y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YEEfKZAr+CuwXAeL0M456TdMlRjOIwNFkl29n8jxHOE/PAzAPEJbcD4CC2yAKaVBE
         vyIEKlMw0G0xUSG3btllCyOq4zDh7/G10S1FPu782gI8SB6SP11tzSTapt6UYAnGfe
         dKHQfDphc2inrpX3hjhtUuEReYJhRI5yDAyLKiqI=
Date:   Thu, 20 Oct 2022 12:18:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>, mark@fasheh.com,
        jlbec@evilplan.org, akpm@linux-foundation.org,
        ocfs2-devel <ocfs2-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ocfs2: possible memory leak in mlog_sys_init()
Message-ID: <Y1Egf2CmSZbtRr3f@kroah.com>
References: <20221018075213.736562-1-yangyingliang@huawei.com>
 <bf27f347-5ced-98e5-f188-659cc2a9736f@linux.alibaba.com>
 <09bb2844-e20a-98e8-c2af-5b6c4795d48e@huawei.com>
 <c7a3bdac-3ed6-e695-5c45-e7007615a4d9@linux.alibaba.com>
 <0db486eb-6927-927e-3629-958f8f211194@huawei.com>
 <1adbbf98-2700-27c8-4aca-9510bca91458@linux.alibaba.com>
 <f6bc6dd3-f7b7-e757-fc36-d1cfbc7305e5@huawei.com>
 <30747fd7-fe79-2ed8-ce63-425a008e3e4f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30747fd7-fe79-2ed8-ce63-425a008e3e4f@linux.alibaba.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:06:48AM +0800, Joseph Qi wrote:
> 
> 
> On 10/19/22 10:57 AM, Yang Yingliang wrote:
> > 
> > On 2022/10/19 10:26, Joseph Qi wrote:
> >>
> >> On 10/18/22 10:28 PM, Yang Yingliang wrote:
> >>> On 2022/10/18 21:39, Joseph Qi wrote:
> >>>> On 10/18/22 6:33 PM, Yang Yingliang wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On 2022/10/18 17:02, Joseph Qi wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> On 10/18/22 3:52 PM, Yang Yingliang wrote:
> >>>>>>> Inject fault while probing module, kset_register() may fail,
> >>>>>>> if it fails, but the refcount of kobject is not decreased to
> >>>>>>> 0, the name allocated in kobject_set_name() is leaked. Fix
> >>>>>>> this by calling kset_put(), so that name can be freed in
> >>>>>>> callback function kobject_cleanup().
> >>>>>>>
> >>>>>>> unreferenced object 0xffff888100da9348 (size 8):
> >>>>>>>      comm "modprobe", pid 257, jiffies 4294701096 (age 33.334s)
> >>>>>>>      hex dump (first 8 bytes):
> >>>>>>>        6c 6f 67 6d 61 73 6b 00                          logmask.
> >>>>>>>      backtrace:
> >>>>>>>        [<00000000306e441c>] __kmalloc_node_track_caller+0x44/0x1b0
> >>>>>>>        [<000000007c491a9e>] kstrdup+0x3a/0x70
> >>>>>>>        [<0000000015719a3b>] kstrdup_const+0x63/0x80
> >>>>>>>        [<0000000084e458ea>] kvasprintf_const+0x149/0x180
> >>>>>>>        [<0000000091302b42>] kobject_set_name_vargs+0x56/0x150
> >>>>>>>        [<000000005f48eeac>] kobject_set_name+0xab/0xe0
> >>>>>>>
> >>>>>>> Fixes: 34980ca8faeb ("Drivers: clean up direct setting of the name of a kset")
> >>>>>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> >>>>>>> ---
> >>>>>>>     fs/ocfs2/cluster/masklog.c | 7 ++++++-
> >>>>>>>     1 file changed, 6 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/fs/ocfs2/cluster/masklog.c b/fs/ocfs2/cluster/masklog.c
> >>>>>>> index 563881ddbf00..7f9ba816d955 100644
> >>>>>>> --- a/fs/ocfs2/cluster/masklog.c
> >>>>>>> +++ b/fs/ocfs2/cluster/masklog.c
> >>>>>>> @@ -156,6 +156,7 @@ static struct kset mlog_kset = {
> >>>>>>>     int mlog_sys_init(struct kset *o2cb_kset)
> >>>>>>>     {
> >>>>>>>         int i = 0;
> >>>>>>> +    int ret;
> >>>>>>>           while (mlog_attrs[i].attr.mode) {
> >>>>>>>             mlog_default_attrs[i] = &mlog_attrs[i].attr;
> >>>>>>> @@ -165,7 +166,11 @@ int mlog_sys_init(struct kset *o2cb_kset)
> >>>>>>>           kobject_set_name(&mlog_kset.kobj, "logmask");
> >>>>>>>         mlog_kset.kobj.kset = o2cb_kset;
> >>>>>>> -    return kset_register(&mlog_kset);
> >>>>>>> +    ret = kset_register(&mlog_kset);
> >>>>>> If register fails, it will call unregister in o2cb_sys_init(), which
> >>>>>> will put kobject.
> >>>>> They are different ksets, the kset unregistered in o2cb_sys_init() is 'o2cb_kset', the
> >>>>> kset used to registered in mlog_sys_init() is 'mlog_kset', and they hold difference
> >>>>> refcounts.
> >>>>> Yes, you are right. I've mixed the two ksets up.
> >>>> In theory, kset_register() may return error because of a NULL kset, so
> >>>> here we may not call kset_put() directly, I'm not sure if a static
> >>>> checker will happy.
> >>>> Though this can't happen since it's already statically allocated...
> >>> kset_register() may fail if kobject_add_internal() return error (can't allocate memory), the name
> >>> "logmask" is dynamically alloctated while ocfs2 is compile as module and insert it (if ocfs2 is
> >>> built in kernel, the name is constant, it won't cause a leak), so the name can be leaked.
> >> What I mean is kset_register() may fail with many reasons, or even
> >> without kset_init().
> >> I wonder if we have to handle this internal kset_register(), but not
> >> leave it to caller. This may benefit other callers as well.
> >>
> >> Something like:
> >> err = kobject_add_internal(&k->kobj);
> >> if (err) {
> >>     kset_put(k);
> >>     return err;
> >> }
> > I had think about this method to fix this, but some kset is allocated dynamically in driver and
> > it's freed in callback function which is called after kset_put() and in error path in driver will free
> > it again, it leads double free in some drivers.
> > 
> I don't think it's good idea that caller has to take care part of the
> internal logic of kset_register() in case of error.
> Hi Greg, what do you think?

I think if you are messing around with raw ksets, you have to handle
them properly :)

For some driver and kobject core functions, once you call register, you
have to call put() to handle an error because the driver core can not
know what you are doing with that memory at times.

But, maybe for ksets this is not needed and the kobject core can
properly clean up from an error here.  Yang, can you please look into
this?  That might make this much simpler.

Either way, the documentation for kset_register() needs to be fixed up
first, so that people have a chance to know what to do here and THEN we
can fix up the callers like this.

Yang, can you do this all as one long series that I can take through the
driver core tree.  No need to scatter it all across a bunch of different
subsystems.

thanks,

greg k-h
