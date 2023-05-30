Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8A4715A85
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjE3Jo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjE3Jox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:44:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF1B93;
        Tue, 30 May 2023 02:44:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4BF8625E7;
        Tue, 30 May 2023 09:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AD6C433EF;
        Tue, 30 May 2023 09:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685439891;
        bh=sd0NR5+IWWwfFPPUGkzsCyqw3K/x2mgiKhFa7WH6Cs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JM3UjGQf0wvmSGS1JsRRGMTCnGA8QxfRcmVrUfhvW/WNWqe5efz8z1oMOYipXgV8f
         AtLTslE+SWRvVO3HFCWxO2xi8t5IYMSvr0IOGQyvNxQuhxqeQ3xd1L8j+pGPMuczeO
         IZRNUw/myMh4JC6qxYBeMoR+Ed2aHB+38COrQ02U=
Date:   Tue, 30 May 2023 10:44:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] usb: typec: intel_pmc_mux: Expose IOM port status to
 debugfs
Message-ID: <2023053013-playhouse-dad-1444@gregkh>
References: <20230524104754.4154013-1-rajat.khandelwal@linux.intel.com>
 <2023052917-juicy-calamity-4b35@gregkh>
 <0367a134-cb04-8a1c-bb46-bb5553df6f8a@linux.intel.com>
 <2023053049-dexterous-flatware-df04@gregkh>
 <2da06c06-6617-bd02-f20a-a5ea7f9ae0b4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2da06c06-6617-bd02-f20a-a5ea7f9ae0b4@linux.intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:06:15PM +0530, Rajat Khandelwal wrote:
> Hi,
> 
> On 5/30/2023 2:57 PM, Greg KH wrote:
> > On Tue, May 30, 2023 at 02:45:03PM +0530, Rajat Khandelwal wrote:
> > > Hi,
> > > 
> > > On 5/29/2023 7:48 PM, Greg KH wrote:
> > > > On Wed, May 24, 2023 at 04:17:54PM +0530, Rajat Khandelwal wrote:
> > > > > IOM status has a crucial role during debugging to check the
> > > > > current state of the type-C port.
> > > > > There are ways to fetch the status, but all those require the
> > > > > IOM port status offset, which could change with platform.
> > > > > 
> > > > > Make a debugfs directory for intel_pmc_mux and expose the status
> > > > > under it per port basis.
> > > > > 
> > > > > Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> > > > > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > Does not apply to my tree :(
> > > I have pushed the patch on top of the Linus's tree.
> > > Had a quick check with the USB Linux tree and seems like its a lot
> > > behind?
> > What branch did you use?
> > 
> > Please use the usb-next branch of
> > git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git, which as
> > of right now, is at 6.4-rc4 + a bunch of USB-specific patches.
> 
> I see. There is one commit additional in the usb-next tree:
> ef0a3642b320 usb: typec: intel_pmc_mux: Convert to platform remove callback returning void

One?  I count a lot more:

$ git log --oneline main..usb-next | wc -l
143

> Anyways, do you want me to re-work the patch for the usb-next branch?

Given that I can not take the patch as-is, it's up to you to rebase it
if you wish to have it accepted.

Isn't this all covered in the Intel kernel developer training class?

thanks,

greg k-h
