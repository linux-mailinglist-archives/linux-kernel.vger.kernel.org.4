Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C04870019B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240265AbjELHji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239949AbjELHjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:39:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903F9171C
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:39:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29C7865371
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADB6C433D2;
        Fri, 12 May 2023 07:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683877174;
        bh=nDtcWk3EKB1qZfgTY/ci16KXsxriXqq2B/zKkywLwC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HzYhSjT12xFXX0ZJWzzVMKclifXdMN/xfE/4IlklqIO7cfs7Q/YhWmJXvaDL/a2dR
         41dDbnyhP47+wrr8Zc8QNQNjaH/14vu5Poidd8UbeWAuBFbVw/9+gI5VzVZj/6QJMk
         aBUITvWsExO+VsfaaSw0nVF3O7b2SI0ESj4CScoOLKTbHN2Odjgk7RQWR82kIq2jv0
         3NnLZaCbnHkeuvdYm+VBqAqI8SCvMoHSOrWwQOFWAj0Sh0JRa0A7/rCdReWLhI4K/K
         ZLeC5lYPZ+ODUfc6UpL3UzEeOyXNWl+DJ2kjyPCVIAGUxviHwsIfRGWA6Oi2wDVogL
         lt3orx6d6kfsw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pxNNh-0002Qs-IR; Fri, 12 May 2023 09:40:02 +0200
Date:   Fri, 12 May 2023 09:40:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] driver core: Call pm_runtime_put_sync() only after
 device_remove()
Message-ID: <ZF3tUQFTeILXV_VT@hovoldconsulting.com>
References: <20230511073428.10264-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0gNPt=rq+pQtmoGL5nxzDQboOK4d6h7=NoY=LueVhZjAQ@mail.gmail.com>
 <20230511103923.hvibdyo5ges4bab2@pengutronix.de>
 <ZFzWCey825wSlr2v@hovoldconsulting.com>
 <CAJZ5v0jvJT4JkHtO3RCUEzkfawxLCwR=QO2Y2CsL=cYN9s4hXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jvJT4JkHtO3RCUEzkfawxLCwR=QO2Y2CsL=cYN9s4hXw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 04:44:25PM +0200, Rafael J. Wysocki wrote:
> On Thu, May 11, 2023 at 1:48 PM Johan Hovold <johan@kernel.org> wrote:

> > No, this seems like very bad idea and even violates the documentation
> > which clearly states that the usage counter is balanced before calling
> > remove() so that drivers can use pm_runtime_suspend() to put devices
> > into suspended state.
> 
> I missed that, sorry.
> 
> > There's is really no good reason to even try to change as this is in no
> > way a fast path.
> 
> Still, I think that while the "put" part needs to be done before
> device_remove(), the actual state change can be carried out later.
> 
> So something like
> 
>     pm_runtime_put_noidle(dev);
> 
>     device_remove(dev);
> 
>     pm_runtime_suspend(dev);
> 
> would generally work, wouldn't it?

No, as drivers typically disable runtime pm in their remove callbacks,
that pm_runtime_suspend() would amount to a no-op (and calling the
driver pm ops post unbind and the driver having freed its data would
not work either).

Johan
