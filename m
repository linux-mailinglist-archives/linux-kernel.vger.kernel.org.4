Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D1F7169FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjE3Qne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjE3Qnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:43:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8EB136;
        Tue, 30 May 2023 09:43:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DA3E62A23;
        Tue, 30 May 2023 16:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D53C433D2;
        Tue, 30 May 2023 16:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685465001;
        bh=SX7UeiLhXb5cPPeAxGsmaERjxLzomdFIpLg43h9HsBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7AcSZeaQi2zDTX6sWT3r7dQjqAz2JQpnfNxRlAsfFxKw8suEcMQ6zm45uvqTTHRL
         rup3+qRHi0Hwdh+qrbSwe32RY62oFeyp/DRwSAtklT333grZNQkmZLzHT33ZalbSBP
         kGxedLsRGE9vmPR9NlNFIE86u/xCsT22K5ckVzWQ=
Date:   Tue, 30 May 2023 17:43:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Message-ID: <2023053037-entertain-challenge-5e27@gregkh>
References: <1685421871-25391-1-git-send-email-quic_prashk@quicinc.com>
 <2023053058-baffling-unveiling-e597@gregkh>
 <498a0b96-4c40-cad6-8da7-e9819035ef22@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <498a0b96-4c40-cad6-8da7-e9819035ef22@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 08:56:26PM +0530, Prashanth K wrote:
> 
> 
> On 30-05-23 07:58 pm, Greg Kroah-Hartman wrote:
> > On Tue, May 30, 2023 at 10:14:31AM +0530, Prashanth K wrote:
> > > Currently if we bootup a device without cable connected, then
> > > usb-conn-gpio won't call set_role() since last_role is same as
> > > current role. This happens because during probe last_role gets
> > > initialised to zero.
> > > 
> > > To avoid this, added a new constant in enum usb_role, last_role
> > > is set to USB_ROLE_UNKNOWN before performing initial detection.
> > > 
> > > While at it, also handle default case for the usb_role switch
> > > in cdns3 to avoid build warnings.
> > > 
> > > Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
> > > Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> > 
> > Breaks the build :(
> > 
> > Please be more careful when submitting stuff, especially on v6 of a
> > patch :(
> 
> Hi, sorry for the trouble, I didn't see any issue in while building locally
> nor any warning/errors from test robot. Can you please point me to the error
> report if available. If the build is breaking due to enum value
> USB_ROLE_UNKNOWN unhandled in switch cases of other drivers, then i will
> revert thing back to v1 where i used a macro for USB_ROLE_UNKNOWN in
> usb-conn-gpio driver. Something like this in usb-conn-gpio.c would can help
> us avoid adding default case in other drivers using usb_role.
> 
> #define USB_ROLE_UNKNWON (USB_ROLE_NONE - 1)

Just fix up the drivers that need it at the same time:

  CC [M]  drivers/usb/roles/intel-xhci-usb-role-switch.o
drivers/usb/roles/intel-xhci-usb-role-switch.c: In function ‘intel_xhci_usb_set_role’:
drivers/usb/roles/intel-xhci-usb-role-switch.c:84:9: error: enumeration value ‘USB_ROLE_UNKNOWN’ not handled in switch [-Werror=switch]
   84 |         switch (role) {
      |         ^~~~~~
cc1: all warnings being treated as errors

thanks,

greg k-h
