Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606A55E99C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiIZGoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiIZGof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:44:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B562FB
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:44:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A99960ABA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D78C433D6;
        Mon, 26 Sep 2022 06:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664174670;
        bh=Qw/WUCw4zPmr8hfqOYYDyEiNaTMxoMtF2IxYIaV1Lqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3+6kv4iRcMKlUWjgfsYVxrcJznUCrUlOOVCHNFI45hW/YjtgiFTJPnjgYjYDjbjJ
         ojsK8E9kU2dyet5wlQFuW+M9l4EPzFkEKsPJV2OsaqHTvTG65Z8FzyG++udOUPINXz
         qot2hednsLt8ywwauuEjvPLe5xfO0LtDsypTTuV4=
Date:   Mon, 26 Sep 2022 08:44:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     duoming@zju.edu.cn
Cc:     johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [PATCH V9] devcoredump: add context check in dev_coredumpm
Message-ID: <YzFKTM7wI6NDkPiR@kroah.com>
References: <20220926061609.44153-1-duoming@zju.edu.cn>
 <YzFGblnZdDPWAW7E@kroah.com>
 <66a140d1.f7b7e.1837884be23.Coremail.duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66a140d1.f7b7e.1837884be23.Coremail.duoming@zju.edu.cn>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 02:38:28PM +0800, duoming@zju.edu.cn wrote:
> Hello,
> 
> On Mon, 26 Sep 2022 08:27:58 +0200 Greg KH wrote:
> 
> > On Mon, Sep 26, 2022 at 02:16:09PM +0800, Duoming Zhou wrote:
> > > The dev_coredumpm(), dev_coredumpv() and dev_coredumpsg() could not
> > > be used in atomic context, because they call kvasprintf_const() and
> > > kstrdup() with GFP_KERNEL parameter. The process is shown below:
> > > 
> > > dev_coredumpv(.., gfp_t gfp)
> > >   dev_coredumpm(.., gfp_t gfp)
> > >     dev_set_name
> > >       kobject_set_name_vargs
> > >         kvasprintf_const(GFP_KERNEL, ...); //may sleep
> > >           kstrdup(s, GFP_KERNEL); //may sleep
> > > 
> > > This patch adds context check in dev_coredumpm() in order to show
> > > dev_coredumpm() and its callers could not be used in atomic context.
> > > 
> > > What's more, this change can allow the api to evolve and will not
> > > influence the users that call this api.
> > > 
> > > Fixes: 833c95456a70 ("device coredump: add new device coredump class")
> > > Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> > > ---
> > > Changes in v9:
> > >   - Add context check in dev_coredumpm().
> > > 
> > >  drivers/base/devcoredump.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> > > index f4d794d6bb8..806ee872f5f 100644
> > > --- a/drivers/base/devcoredump.c
> > > +++ b/drivers/base/devcoredump.c
> > > @@ -255,6 +255,9 @@ void dev_coredumpm(struct device *dev, struct module *owner,
> > >  	struct devcd_entry *devcd;
> > >  	struct device *existing;
> > >  
> > > +	if (!gfpflags_normal_context(gfp))
> > > +		goto free;
> > 
> > Wait, this just broke things for no good reason if a caller happened to
> > have set a GFP flag that we do not like at the moment.
> > 
> > What code now does not work that previously did work with this change?
> 
> I found that all users in the kernel call the dev_coredumpv(), dev_coredumpm() and
> dev_coredumpsg() with "GFP_KERNEL". So this change will not influence the existing users.

Great, so there is no need for this, and it does not "fix" any commit.

confused,

greg k-h
