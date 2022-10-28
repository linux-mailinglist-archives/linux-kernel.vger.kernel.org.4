Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472FC610A07
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ1GEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJ1GEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65621A403C;
        Thu, 27 Oct 2022 23:04:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA1946266D;
        Fri, 28 Oct 2022 06:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E78CC433D7;
        Fri, 28 Oct 2022 06:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666937042;
        bh=nAVbp4YjH1oeasfmzzughsWULtId8p6lv1UC5+hpyA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k56OppqdaWkZdtMCGaOO4UnOKtPMWl/kBCSBjm9kigXO78wZoyD3U4AN4G6rs58GE
         ae5t+yGL4D7oW720YYTG+inHRfm+e2tKiR//pLoo0F5WwI5Xz7W+fK+TEjsrCW50A9
         SPxBkjnKfpSfgLJljMAZyBlGvY/a11z6l6wY6ikk=
Date:   Fri, 28 Oct 2022 08:04:54 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Jim Lin <jilin@nvidia.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] xhci: hub: export symbol on xhci_hub_control
Message-ID: <Y1txBtRZAJ5vpItj@kroah.com>
References: <20221027133127.27592-1-jilin@nvidia.com>
 <20221027133127.27592-2-jilin@nvidia.com>
 <Y1qOhjOXM4sQW+a/@kroah.com>
 <3c3b175d2031b8e440bfdef9b4c23c0272a5f607.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c3b175d2031b8e440bfdef9b4c23c0272a5f607.camel@nvidia.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 05:36:41AM +0000, Jim Lin wrote:
> On Thu, 2022-10-27 at 15:58 +0200, Greg KH wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Thu, Oct 27, 2022 at 09:31:25PM +0800, Jim Lin wrote:
> > > Add EXPORT_SYMBOL_GPL on xhci_hub_control() for other driver module
> > > to invoke and avoid linking error.
> > 
> > What other driver module?
> > 
> > There is no user here :(
> > 
> > confused,
> > 
> 
> In arch/arm/configs/multi_v7_defconfig
> It defines
> CONFIG_USB_XHCI_TEGRA=m
> 
> If I don't add EXPORT_SYMBOL_GPL on xhci_hub_control()
> , I will get compile/linking error like
> 
> ERROR: modpost: "xhci_hub_control" [drivers/usb/host/xhci-tegra.ko]
> undefined!
> 
> if patch
> "[PATCH v5,3/3] xhci: tegra: USB2 pad power controls"
> 
> https://patchwork.kernel.org/project/linux-usb/patch/20221027133127.27592-4-jilin@nvidia.com/
> is added in xhci-tegra.c to invoke xhci_hub_control()
> 
> Should I integrate this patch with [PATCH v5,3/3] as one?

Yes, do not add something that is not needed for that specific commit,
otherwise it causes reviewers to be confused.

thanks,

greg k-h
