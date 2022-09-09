Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F6A5B3200
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiIIImp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiIIImk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:42:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AAF123EF7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:42:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54F5061F2D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6716AC433D6;
        Fri,  9 Sep 2022 08:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662712954;
        bh=Nus/3lCmuXKaetaxaSMUMHR8XUg2f3tb6j2cw7XFXDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uh/dOzGutvFih1SX9uKEKNbEeKfitRQ2rgzypcaTcHXWliJNLI5GXMKXRkZ0ORp4Z
         420B0a3cLa6ee7/iwNVi/RZYsZwZuyZSpKYsE+66pYmemiaqAAIAnNAa/vC+l09PDf
         +UYc4jPBOS4zaXPu3xD1Df/7ZpWk7HhnpSV2im1k=
Date:   Fri, 9 Sep 2022 10:42:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     D Scott Phillips <scott@os.amperecomputing.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: misc: Allow minors values up to MINORMASK
Message-ID: <Yxr8d3eCoPPldZU5@kroah.com>
References: <20220906195213.2370775-1-scott@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906195213.2370775-1-scott@os.amperecomputing.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 12:52:13PM -0700, D Scott Phillips wrote:
> For per-cpu coresight_tmc devices, we can end up with hundreds of devices
> on large systems that all want a dynamic minor number.  Switch the dynamic
> minors allocator to an ida and add logic to allocate in the ranges [0..127]
> and [256..MINORMASK]. Allocations start from 127 growing downwards and then
> increasing from 256, so device numbering for the first 128 devices should
> be the same as before.
> 
> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
> ---
>  drivers/char/misc.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)

So you are adding more logic to the kernel for no change at all?

Why is this needed?  What changed here except the underlying data
structure being used?

thanks,

greg k-h
