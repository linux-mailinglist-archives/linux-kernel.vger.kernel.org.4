Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F416610A11
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJ1GKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ1GKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:10:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFE67D1C8;
        Thu, 27 Oct 2022 23:10:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C63E3B827D5;
        Fri, 28 Oct 2022 06:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE93C433C1;
        Fri, 28 Oct 2022 06:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666937439;
        bh=bCo8sXVXchrf2o28bo48O/daDV+GIQFafX21yGzPoKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kv5ZCao93o4KVTw1pIIWXlsFUCdz4D9OVZBEO5Ms5ib3lGy+a2OhbcyPZl+R3bUBn
         YPzCG1PPzlQdXfWrxgs9KkkygJOcI+R2FKFttC1T7I4d4VE1/IOlnPIg6Y1JNKR2O6
         EpuS/yWVvkOeK1lb9Ym3itLRK+147A0RpGSDNCRk=
Date:   Fri, 28 Oct 2022 08:11:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Reka Norman <rekanorman@chromium.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] xhci: Apply XHCI_RESET_TO_DEFAULT quirk to ADL-N
Message-ID: <Y1tyldAD/nDIoL3d@kroah.com>
References: <20221027053407.421783-1-rekanorman@chromium.org>
 <Y1ohUyZJItFh3xDs@kroah.com>
 <CAEmPcwtZt0RoksByW0OnkNsBiPJ-wHqzR9nuZEwAn3d2m=fyOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEmPcwtZt0RoksByW0OnkNsBiPJ-wHqzR9nuZEwAn3d2m=fyOA@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:56:56AM +1100, Reka Norman wrote:
> On Thu, Oct 27, 2022 at 5:11 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 27, 2022 at 04:34:07PM +1100, Reka Norman wrote:
> > > ADL-N systems have the same issue as ADL-P, where a large boot firmware
> > > delay is seen if USB ports are left in U3 at shutdown. So apply the
> > > XHCI_RESET_TO_DEFAULT quirk to ADL-N as well.
> > >
> > > This patch depends on "xhci: Add quirk to reset host back to default
> > > state at shutdown".
> >
> > What is the git commit id of that change?
> 
> It hasn't been merged in mainline yet, only in the xhci tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/commit/?id=feb0b04b09c82589af65c84398b7d3fefaa7b7ac&head=for-usb-linus
> Should I add the commit id from there? Or add the lore link?

This is in linux-next already as 34cd2db408d5 ("xhci: Add quirk to reset
host back to default state at shutdown") right?

Please use that.

> > And is this needed in stable kernels?  If so, how far back?
> 
> Sorry, I'm not sure how to answer that properly.
> It looks like most ADL-N support was added starting from 5.16.
> The issue it fixes is a ~20s boot delay in the specific case of booting from S5.
> It probably makes sense for it to go wherever the ADL-P patch goes.

Then properly mark it with that information.

thanks,

greg k-h
