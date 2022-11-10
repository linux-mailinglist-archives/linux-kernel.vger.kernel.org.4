Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F98623EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiKJJex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiKJJev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:34:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9F760E88
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:34:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7DD960B89
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00617C433D6;
        Thu, 10 Nov 2022 09:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668072888;
        bh=rm+YM349AGgKvf8j+km7LK7pGzq8lNCsF5sAXrJZVts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WCvjBU0WyQhxo5Y6m2D0a6NWAyPOM80ZdDgXcTadCfabpsuAmjdSTELy5WDwTsYPy
         oqihwvkY3YYbwBx5+dkli5vLhXXb+pJVafMaqq/xg86r+RqJ1i9GSq+f3aKrfeB49m
         RqL3X8SYr1Jjc8rER/hk76j5dLHOqqb2lFFUenVc=
Date:   Thu, 10 Nov 2022 10:34:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] driver core: remove devm_device_remove_groups()
Message-ID: <Y2zFtWcytaIRWNqu@kroah.com>
References: <20221109140711.105222-1-gregkh@linuxfoundation.org>
 <CAJZ5v0gv6L9Q+Nu3U0JAWqJk4MPt7kGVGiOAKuX5FcF=znyfTA@mail.gmail.com>
 <Y2wXYxrr/qed/j//@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2wXYxrr/qed/j//@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 01:10:59PM -0800, Dmitry Torokhov wrote:
> On Wed, Nov 09, 2022 at 03:11:47PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Nov 9, 2022 at 3:07 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > There is no in-kernel user of this function, so it is not needed anymore
> > > and can be removed.
> > >
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > For both patches in the series:
> > 
> > Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> 
> I find it really weird to have an asymmetric core API...

I'm working on fixing up that asymmetric-ness.  We have only one user of
devm_device_add_groups() and only a handful of devm_device_add_group()
left in the tree.

But it turns out that no one ever called these functions anyway, so they
aren't needed even if we did keep the "add" functions.  So they should
be dropped no matter what.

thanks,

greg k-h
