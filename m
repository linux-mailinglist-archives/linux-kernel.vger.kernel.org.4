Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F08658870
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 02:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiL2BmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 20:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiL2Bl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 20:41:58 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9DCB912757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 17:41:57 -0800 (PST)
Received: (qmail 291561 invoked by uid 1000); 28 Dec 2022 20:41:56 -0500
Date:   Wed, 28 Dec 2022 20:41:56 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Oliver Neukum <oneukum@suse.com>, srinivas.kandagatla@linaro.org,
        mathias.nyman@intel.com, perex@perex.cz, broonie@kernel.org,
        lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com, tiwai@suse.com,
        robh+dt@kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [RFC PATCH 06/14] usb: core: hcd: Introduce USB HCD APIs for
 interrupter management
Message-ID: <Y6zwZOquZOTZfnvP@rowland.harvard.edu>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-7-quic_wcheng@quicinc.com>
 <Y6ca8IKLK9g497Qv@rowland.harvard.edu>
 <e1203849-01b4-b196-36f3-76d58dd7c724@quicinc.com>
 <bf1011a8-c746-c465-f161-f0293409d922@suse.com>
 <Y6xd1c3s2XPpOqfi@rowland.harvard.edu>
 <559030ff-112b-e0a8-b278-72f909724496@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <559030ff-112b-e0a8-b278-72f909724496@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 12:31:16PM -0800, Wesley Cheng wrote:
> Hi Alan,
> 
> On 12/28/2022 7:16 AM, Alan Stern wrote:
> > On Wed, Dec 28, 2022 at 09:59:03AM +0100, Oliver Neukum wrote:
> > > 
> > > 
> > > On 27.12.22 22:07, Wesley Cheng wrote:
> > > 
> > > > 
> > > > Hmmm...maybe I should change the name of the API then to avoid the confusion.  Yes, usb_hcd_flush_endpoint() does ensure that URBs submitted to the EP are stopped.  However, with this offloading concept, we aren't actually submitting URBs from the main processor, so the ep->urb_list will be empty.
> > > > 
> > > > This means the usb_hcd_flush_endpoint() API won't actually do anything.  What we need is to ensure that we send a XHCI stop ep command to the controller.
> > > 
> > > That is a concept specific to XHCI, yet you are adding a generic
> > > API. The namin should reflect that. usb_quiesce_endpoint() ?
> > 
> > Or even xhci_send_stop_ep_cmd(), which is what the routine is intended
> > to do.
> > 
> 
> Just to clarify, you're talking about renaming the API that was added in the
> XHCI driver, correct?

To be precise, we're talking about renaming your usb_hcd_stop_endpoint() 
function, although similar arguments probably apply to your 
usb_free_interrupter(), usb_set_interrupter(), and 
usb_hcd_get_transfer_resource() routines.

You wrote earlier:

	The XHCI driver is the one that maintains the list of 
	interrupters that are available, so the locking was placed in 
	the XHCI driver versus adding it in the core hcd layer.

The "stop ep" functionality and other interrupter management things you 
want to add seem a lot like this locking stuff.  Since you decided to 
put the locking in the xhci-hcd driver instead of the core HCD layer, it 
would be logical to do the same with the "stop ep" and other routines.  
Which means there shouldn't be any need to make changes to hcd.c or 
include/linux/usb/hcd.h.

Alan Stern
