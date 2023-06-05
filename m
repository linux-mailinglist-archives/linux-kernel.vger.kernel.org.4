Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706C4721F4F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjFEHQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjFEHQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:16:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555021BD;
        Mon,  5 Jun 2023 00:15:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 211BA60F19;
        Mon,  5 Jun 2023 07:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC8CC433EF;
        Mon,  5 Jun 2023 07:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685949312;
        bh=RV1uSWYECRF6po/E+w6yWpCHTfpG9zLcmT+80L61Dp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HtOtJiV5bbausUrO3yqE5B5ePbLaipOSV60pQ7DMAmGts71BW2BZnaNt2GDJZ3vMg
         JqD39VkYSSH5Qypp/+nEjZxdf9IfW2aTFp/4L89ESCYjz0gw34ydjp6nSoZpNukv+s
         Kx1gx1dqWbHW24bYOjS0t8JF/9eCcwbNUQpC0PP8DGp90nH9J6AaDnBIppPeM6H30C
         koIYRScxM9U+YmgAFTMLfGpXGvij9UG0WZLohVN+612rV5TeM2IWGhgmj+krM52YDX
         8Kt9rrZSrzqA30kmd08ZN97pobyijFWBHHfzBgzsm3RdLdYGd1zemVjV77+aKtzQwL
         542Nw1ZqwNkkQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q64R6-00077O-OC; Mon, 05 Jun 2023 09:15:29 +0200
Date:   Mon, 5 Jun 2023 09:15:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     Craig Shelley <craig@microtron.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: Break doesn't work on a CP2105
Message-ID: <ZH2LkKE83kHrIRWH@hovoldconsulting.com>
References: <ZEmDs0ASdnEAnpsL@minyard.net>
 <ZGtZKCvo71woGf9T@hovoldconsulting.com>
 <ZGtlnWGSc31Wdhxa@mail.minyard.net>
 <ZHnmSwGyOaSMbPBB@hovoldconsulting.com>
 <ZHodALMLTWk72Vvm@mail.minyard.net>
 <ZHyAzHVAu3DVgJG_@hovoldconsulting.com>
 <ZHzv/wbwtaLVpfaP@mail.minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHzv/wbwtaLVpfaP@mail.minyard.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2023 at 03:11:43PM -0500, Corey Minyard wrote:
> On Sun, Jun 04, 2023 at 02:17:16PM +0200, Johan Hovold wrote:

> > I just verified break signalling on the first port of my CP2105 using a
> > logic analyser and everything seems to work as expected.
> > 
> > There's also no mention of any issue with break in the errata.
> > 
> > Could you check which firmware revision you have by enabling debugging
> > and reconnecting the device?

> [    4.253869] usb 2-1.2: new full-speed USB device number 3 using ehci-pci
> [    4.342570] usb 2-1.2: New USB device found, idVendor=10c4, idProduct=ea70, bcdDevice= 1.00
> [    4.350939] usb 2-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=5
> [    4.358259] usb 2-1.2: Product: CP2105 Dual USB to UART Bridge Controller
> [    4.365052] usb 2-1.2: Manufacturer: Silicon Labs
> [    4.369765] usb 2-1.2: SerialNumber: 01070456
> [    4.374925] cp210x 2-1.2:1.0: cp210x converter detected
> [    4.381086] cp210x 2-1.2:1.0: cp210x_get_fw_version - 1.18.1
> [    4.386915] usb 2-1.2: cp210x converter now attached to ttyUSB0
> [    4.393529] cp210x 2-1.2:1.1: cp210x converter detected
> [    4.399835] cp210x 2-1.2:1.1: cp210x_get_fw_version - 1.18.1
> [    4.405657] usb 2-1.2: cp210x converter now attached to ttyUSB1

So we have the same firmware revision.
 
> This is an embedded reference board, I guess there is some probability
> that this is just broken on this board, though I'm not quite sure how.

Is the port accessible somehow so that you could hook up a scope or
logic analyser? Or is that what you did already when you mentioned
seeing garbage sent after 2.5 seconds?

That last bit seems to match the behaviour I see with the second, SCI
port, where the last character sent is resent when trying to signal a
break.

Johan
