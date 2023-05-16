Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DE6704BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjEPLGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjEPLF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7516A69
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12034637DD
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E050DC433D2;
        Tue, 16 May 2023 11:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684234943;
        bh=t7FUbmszHOiSynp4eWcee6aa0ZPkc5hy3XpDJUTIt9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FjQkQ/176/JsQs7294dTtu6jXCDb+fJV8W0/VBIYPEz8+UB+doz12DcN7y+37ixLz
         XkEVf3/yR4zWBrH8wnViMveP8H36C7qVzbeuWr0PD4ZmERJXVmLVdnCVB4VeWi62+Y
         e/KsGSJcYwGWi/ZIHLhN5fqQ2Az3SG9K0XOFZw3I=
Date:   Tue, 16 May 2023 13:02:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ekaterina Esina <eesina@astralinux.ru>
Cc:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, Richard Yeh <rcy@google.com>,
        John Joseph <jnjoseph@google.com>,
        Simon Que <sque@chromium.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10] staging: gasket: interrupt: Clean interrupt_data
 after free
Message-ID: <2023051640-trustless-gluten-a7b8@gregkh>
References: <20230515122950.100564-1-eesina@astralinux.ru>
 <2023051546-churn-obstinate-20af@gregkh>
 <ba0ad96d-6515-66e3-e140-cd7c3999577e@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba0ad96d-6515-66e3-e140-cd7c3999577e@astralinux.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 01:44:06PM +0300, Ekaterina Esina wrote:
> 
> 
> On 15.05.2023 16:02, Greg Kroah-Hartman wrote:
> > On Mon, May 15, 2023 at 03:29:50PM +0300, Esina Ekaterina wrote:
> > > Add interrupt_data = NULL after kfree(interrupt_data) in
> > > gasket_interrupt_init. It is needed to avoid double free
> > > in gasket_interrupt_cleanup, there is a check for NULL
> > > before kfree(interrupt_data).
> > > 
> > > Found by Astra Linux on behalf of Linux Verification Center
> > > (linuxtesting.org) with SVACE.
> > > 
> > > Fixes: 9a69f5087ccc ("drivers/staging: Gasket driver framework + Apex driver")
> > > Signed-off-by: Esina Ekaterina <eesina@astralinux.ru>
> > > ---
> > >   drivers/staging/gasket/gasket_interrupt.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
> > > index 864342acfd86..48b664b9134a 100644
> > > --- a/drivers/staging/gasket/gasket_interrupt.c
> > > +++ b/drivers/staging/gasket/gasket_interrupt.c
> > > @@ -337,6 +337,7 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev)
> > >   			sizeof(*interrupt_data->eventfd_ctxs), GFP_KERNEL);
> > >   	if (!interrupt_data->eventfd_ctxs) {
> > >   		kfree(interrupt_data);
> > > +		interrupt_data = NULL;
> > >   		return -ENOMEM;
> > >   	}
> > > @@ -346,6 +347,7 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev)
> > >   	if (!interrupt_data->interrupt_counts) {
> > >   		kfree(interrupt_data->eventfd_ctxs);
> > >   		kfree(interrupt_data);
> > > +		interrupt_data = NULL;
> > >   		return -ENOMEM;
> > >   	}
> > > -- 
> > > 2.40.1
> > 
> > Also, your tool is wrong, this is not a correct fix at all.
> > 
> > How did you test it?  Why is your tool spitting out incorrect code?  Why
> > are you not verifying it's output before asking others to do so?
> > 
> > Please don't do this anymore, it's wasteful on our side, right?  Please
> > take the time to review existing changes for problems, that would be
> > more useful overall to everyone.
> > 
> > thanks,
> > 
> > greg k-h
> 
> I apologize, there is a mistake. It should've been
> gasket_dev->interrupt_data = NULL istead of interrupt_data = NULL

Which implies that your tools are broken, right?  Please do better
testing before sending anymore patches.

greg k-h
