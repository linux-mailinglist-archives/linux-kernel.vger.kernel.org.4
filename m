Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A3262484A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiKJRYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiKJRYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:24:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0F81005B;
        Thu, 10 Nov 2022 09:24:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABA2E61CF4;
        Thu, 10 Nov 2022 17:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4F5C433C1;
        Thu, 10 Nov 2022 17:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668101040;
        bh=T4QCGypIEAjaJ/cxOBxbPjDEdgaOT0ycDi0aSrOak30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYLDaMBzBBFGtQa9hLlEb5iTdnNDlrOWfRJZU5lRE37LQeykPj1XIfgVYWXcmUZ3p
         ru05iAsCY7Mp9n963aBOmPecGBaEk2HtbuA+3AU3eNdUNuax4MS/0t1dpYHpLeOFPU
         ANX2JHUXyqpR8N2qSCvq3ICTAKhp1EIIwQKgyES4=
Date:   Thu, 10 Nov 2022 18:23:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] blkdev: make struct block_device_operations.devnode()
 take a const *
Message-ID: <Y20zrWkBPS/EyrSE@kroah.com>
References: <20221109144843.679668-1-gregkh@linuxfoundation.org>
 <f249f608-d9cf-7ba9-5050-dfc97e543d55@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f249f608-d9cf-7ba9-5050-dfc97e543d55@kernel.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 12:41:09PM -0700, Jens Axboe wrote:
> On 11/9/22 7:48 AM, Greg Kroah-Hartman wrote:
> > The devnode() callback in struct block_device_operations should not be
> > modifying the device that is passed into it, so mark it as a const * and
> > propagate the function signature changes out into the one subsystem that
> > actually uses this callback.
> > 
> > Cc: linux-block@vger.kernel.org
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > 
> > Jens, I have some dependent kobject/driver core changes that require
> > this change in the works.  Can I take this through the driver core tree
> > for 6.2-rc1?
> 
> Yeah go ahead, you can add my:
> 
> Acked-by: Jens Axboe <axboe@kernel.dk>

Thanks!
