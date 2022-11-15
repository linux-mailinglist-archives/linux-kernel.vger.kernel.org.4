Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373676295DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbiKOKbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiKOKbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:31:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B7922B26;
        Tue, 15 Nov 2022 02:31:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7D94615E3;
        Tue, 15 Nov 2022 10:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ED3C433D7;
        Tue, 15 Nov 2022 10:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668508267;
        bh=x0Azh44FGWo5bT/KSP1vVjZOfHzwPtcFPt6cWW/bsfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmlS6ClKlBO4E0igkgvzWISuPbWpPBo4G/o3w/UO8AU8ja1v5bIkhwN5Zm8ofO5Hr
         vbXROjK/tQDjyCDdyq6DPFkRaOwnC+mD9mYhm59FTN4r2c1g2U7z60hIjb1IxQUehc
         2J2lnyetrzQuPNY5DUqblI5uxrwEpwXhxyKWT+y4=
Date:   Tue, 15 Nov 2022 11:30:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] blkdev: make struct block_device_operations.devnode()
 take a const *
Message-ID: <Y3NqY1xWTy7WzbHK@kroah.com>
References: <20221109144843.679668-1-gregkh@linuxfoundation.org>
 <Y3NYI04dFGgtQke9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3NYI04dFGgtQke9@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 01:13:07AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 09, 2022 at 03:48:43PM +0100, Greg Kroah-Hartman wrote:
> > The devnode() callback in struct block_device_operations should not be
> > modifying the device that is passed into it, so mark it as a const * and
> > propagate the function signature changes out into the one subsystem that
> > actually uses this callback.
> 
> Yes.  In fact it really shouldn't exist at all.  I wonder if we can
> do another attempt at dropping pktcdvd?

I'll gladly send a patch to delete it.  Who objected last time?  Let me
dig in the archives...
