Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015906E8DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbjDTJYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjDTJX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:23:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C134EFF;
        Thu, 20 Apr 2023 02:23:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79BCD63A01;
        Thu, 20 Apr 2023 09:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880B3C4339B;
        Thu, 20 Apr 2023 09:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681982612;
        bh=nomTSTTYYYLRkOIxRyndbUCcA+Q9IBcbf4z+oPwN1uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ei3UTBtssQ82a3RRFDPLZyWOym96LPJSS6aknrvBC8ymotX9moko7WDz2n4DJ7MNO
         inEhwC6QHwmxxiVEcgEOrP4dQmu9TLQrgEey+MnTHkOiNLQGY+hCG9tdRp6Y5+j42N
         VTIa4ak8SB195kGA6OSQnwoBNtCHLnzBow8WlM00=
Date:   Thu, 20 Apr 2023 11:23:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, tonywwang@zhaoxin.com,
        weitaowang@zhaoxin.com
Subject: Re: [PATCH] =?utf-8?B?VUhDSe+8mmFkanVz?= =?utf-8?Q?t?= zhaoxin UHCI
 controllers OverCurrent bit value
Message-ID: <ZEEEkjpn_Wsf2hCG@kroah.com>
References: <20230420111445.5028-1-WeitaoWang-oc@zhaoxin.com>
 <ZEDyWC7GsbcEn7UK@kroah.com>
 <6a43e6aa-5609-ecd5-b040-010763a686ee@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a43e6aa-5609-ecd5-b040-010763a686ee@zhaoxin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 01:14:46AM +0800, WeitaoWang-oc@zhaoxin.com wrote:
> On 2023/4/20 16:05, Greg KH wrote:
> > On Thu, Apr 20, 2023 at 07:14:45PM +0800, Weitao Wang wrote:
> > > Over Current condition is not standardized in the UHCI spec.
> > > Zhaoxin UHCI controllers report OverCurrent bit active off.
> > > Intel controllers report it active on, so we'll adjust the bit value.
> > > 
> > > Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
> > 
> > Note, your Subject: line has odd characters in it, can you rewrite it to
> > just use ascii?  I think it's the '：' character which should be ':',
> > right?Yes,you are right. it's my typo mistake. I'll rewrite this patch. Thanks!
> 
> > > ---
> > >   drivers/usb/host/uhci-pci.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/usb/host/uhci-pci.c b/drivers/usb/host/uhci-pci.c
> > > index 3592f757fe05..177e3c2aa287 100644
> > > --- a/drivers/usb/host/uhci-pci.c
> > > +++ b/drivers/usb/host/uhci-pci.c
> > > @@ -126,6 +126,10 @@ static int uhci_pci_init(struct usb_hcd *hcd)
> > >   	if (to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_VIA)
> > >   		uhci->oc_low = 1;
> > > +	/* ZHAOXIN controllers report OverCurrent bit active off. */
> > > +	if (to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_ZHAOXIN)
> > > +		uhci->oc_low = 1;
> > > +
> > 
> > This should also go to the stable kernels, right?
> > 
> > But a new UHCI controller?  And this affects all of them?
> All UHCI controller of zhaoxin have this issue, And Hope this
> patch go to stable kernel.Could I resubmit this patch with
> modify subject typo mistake?

Yes, please do so and add the needed cc: stable as is documented
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

thanks,

greg k-h
