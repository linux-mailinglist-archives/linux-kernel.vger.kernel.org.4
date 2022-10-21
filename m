Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23066071E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJUIQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJUIQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:16:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AE41EA573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:16:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A851B82B63
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512F7C433D7;
        Fri, 21 Oct 2022 08:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666340188;
        bh=nDtywa6mieJPfGn7a73ycNgAHcz816CMD4ioaA/ZgqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lO82TxFXbxQ1cn2DOqHCEKyNscPmKusZYKwJGtS1W9wHd/+uOdMexrwxM5m/eoZGP
         ixuN1pMyIVVKVRufxw1DnKqd7DCICC9i7tVNcPFmRr0aUFAthWwsrDgNS/LTSDl6lj
         lH2fmm/4fi6QX2qSDaq/NHngB7BNdQ/cZRRC7bts=
Date:   Fri, 21 Oct 2022 10:16:26 +0200
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
Subject: Re: [PATCH 01/11] kset: fix documentation for kset_register()
Message-ID: <Y1JVWsLs0EQ3dtxM@kroah.com>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <20221021022102.2231464-2-yangyingliang@huawei.com>
 <eb0f1459-7980-4a7b-58f9-652eeccc357e@amd.com>
 <10d887c4-7db0-8958-f661-bd52e6c8b4af@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d887c4-7db0-8958-f661-bd52e6c8b4af@huawei.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:05:18PM +0800, Yang Yingliang wrote:
> 
> On 2022/10/21 13:34, Luben Tuikov wrote:
> > On 2022-10-20 22:20, Yang Yingliang wrote:
> > > kset_register() is currently used in some places without calling
> > > kset_put() in error path, because the callers think it should be
> > > kset internal thing to do, but the driver core can not know what
> > > caller doing with that memory at times. The memory could be freed
> > > both in kset_put() and error path of caller, if it is called in
> > > kset_register().
> > > 
> > > So make the function documentation more explicit about calling
> > > kset_put() in the error path of caller.
> > > 
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > ---
> > >   lib/kobject.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/lib/kobject.c b/lib/kobject.c
> > > index a0b2dbfcfa23..6da04353d974 100644
> > > --- a/lib/kobject.c
> > > +++ b/lib/kobject.c
> > > @@ -834,6 +834,9 @@ EXPORT_SYMBOL_GPL(kobj_sysfs_ops);
> > >   /**
> > >    * kset_register() - Initialize and add a kset.
> > >    * @k: kset.
> > > + *
> > > + * If this function returns an error, kset_put() must be called to
> > > + * properly clean up the memory associated with the object.
> > >    */
> > And I'd continue the sentence, with " ... with the object,
> > for instance the memory for the kset.kobj.name when kobj_set_name(&kset.kobj, format, ...)
> > was called before calling kset_register()."
> kobject_cleanup() not only frees name, but aslo calls ->release() to free
> another resources.

Yes, but it's the kobject of the kset, which does need to have it's name
cleaned up, but that kobject should NOT be freeing any larger structures
that the kset might be embedded in, right?

> > This makes it clear what we want to make sure is freed, in case of an early error
> > from kset_register().
> 
> How about like this:
> 
> If this function returns an error, kset_put() must be called to clean up the name of
> kset object and other memory associated with the object.

Again, I think we can fix this up to not be needed.

thanks,

greg k-h
