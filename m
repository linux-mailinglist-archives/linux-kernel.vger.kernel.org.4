Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9099B623E71
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiKJJSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKJJSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:18:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2AF6474;
        Thu, 10 Nov 2022 01:18:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45CD860ADC;
        Thu, 10 Nov 2022 09:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343FEC433D6;
        Thu, 10 Nov 2022 09:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668071929;
        bh=raFns3M7wQFWcuY6eMZCQb4VQqr3DS8sTQ9I4vqxgeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZsuUDlkJFIcil5G1yQ+R4ps0XCdPhzHIPHQZlc+sN9ME06hiFHwkcHK6s0ZAnCALp
         07eJPOx2a2eeFTL/8HSJDjTkoDX1XwxOqbE8aoQF25zSFho/G3xhT9TzpewjNIwzZw
         VFOgyg/MPp+2IcdsCfAERl07O5w6oKa2mE0LMjps=
Date:   Thu, 10 Nov 2022 10:18:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lduncan@suse.com, cleech@redhat.com,
        michael.christie@oracle.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, rafael@kernel.org
Subject: Re: [PATCH] drivers: base: transport_class: fix possible memory leak
Message-ID: <Y2zB9ndClm2EfReK@kroah.com>
References: <20221110034809.17258-1-yangyingliang@huawei.com>
 <Y2yzwB0IuaVS3AVq@kroah.com>
 <d509e930-779b-866e-9b1f-d58db6abfc43@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d509e930-779b-866e-9b1f-d58db6abfc43@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 04:44:16PM +0800, Yang Yingliang wrote:
> Hi Greg,
> 
> On 2022/11/10 16:18, Greg KH wrote:
> > On Thu, Nov 10, 2022 at 11:48:09AM +0800, Yang Yingliang wrote:
> > > Current some drivers(like iscsi) call transport_register_device()
> > > failed, they don't call transport_destroy_device() to release the
> > > memory allocated in transport_setup_device(), because they don't
> > > know what was done, it should be internal thing to release the
> > > resource in register function. So fix this leak by calling destroy
> > > function inside register function.
> > > 
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > ---
> > >   include/linux/transport_class.h | 9 ++++++++-
> > >   1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/transport_class.h b/include/linux/transport_class.h
> > > index 63076fb835e3..f4835250bbfc 100644
> > > --- a/include/linux/transport_class.h
> > > +++ b/include/linux/transport_class.h
> > > @@ -70,8 +70,15 @@ void transport_destroy_device(struct device *);
> > >   static inline int
> > >   transport_register_device(struct device *dev)
> > >   {
> > > +	int ret;
> > > +
> > >   	transport_setup_device(dev);
> > > -	return transport_add_device(dev);
> > > +	ret = transport_add_device(dev);
> > > +	if (ret) {
> > > +		transport_destroy_device(dev);
> > > +	}
> > Please use scripts/checkpatch.pl on your patches before sending them out
> Sure, of course. :)
> > so you don't get grumpy maintainers asking you to use
> > scripts/checkpatch.pl on your patches :)
> I sent a fix patch to iscsi system earlier:
> https://patchwork.kernel.org/project/linux-scsi/patch/20221109092421.3111613-1-yangyingliang@huawei.com/
> 
> Mike give his point in the mail, so I send a new patch keep iscsi
> maintainers Cced.

That's fine, but the code you wrote here should look different as it
does not follow our coding style rules.  That is the point I was trying
to make.

thanks,

greg k-h
