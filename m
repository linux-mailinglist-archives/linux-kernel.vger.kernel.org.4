Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEC17216CF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjFDMRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjFDMRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:17:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8432DA;
        Sun,  4 Jun 2023 05:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7904561C54;
        Sun,  4 Jun 2023 12:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5645C433D2;
        Sun,  4 Jun 2023 12:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685881021;
        bh=/1HqXi4TSfWej43agQT+61s1sRoWQcpHBT+TRBBJJwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gQS7nn5bpR6TCVKUjWsJyJRYDOQN9n2zuN0jpExVeP22UmfXhVyhVx45fc8YAkS8n
         QQeKJkXe+nQ+vcVQPE6/fjuHkUDDUOtU8YDzX3vYI8JR5rupssU/w008zzU7GEYkLM
         AKdQmcGbupKccfqEGF9PhKhSPxtG7u3Odqra69Gma71MfErM/iva1pkYgtGMuhHA68
         KSkapGRJ5q4Qjv8+40XRC+oOqFR20GOv6Zs8kSnYGgcXekRWJiLu3hhVHo0XOBQs4r
         83KpT1WE1TFzT7xc0wqRFtL5kAtyr0B1Qx+Ero01vXIFph2doaBD3g+g9iX9Iyl+7i
         OKgQaCKZ/J6nw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q5mfc-00008R-30; Sun, 04 Jun 2023 14:17:16 +0200
Date:   Sun, 4 Jun 2023 14:17:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     Craig Shelley <craig@microtron.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: Break doesn't work on a CP2105
Message-ID: <ZHyAzHVAu3DVgJG_@hovoldconsulting.com>
References: <ZEmDs0ASdnEAnpsL@minyard.net>
 <ZGtZKCvo71woGf9T@hovoldconsulting.com>
 <ZGtlnWGSc31Wdhxa@mail.minyard.net>
 <ZHnmSwGyOaSMbPBB@hovoldconsulting.com>
 <ZHodALMLTWk72Vvm@mail.minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHodALMLTWk72Vvm@mail.minyard.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 11:46:56AM -0500, Corey Minyard wrote:
> On Fri, Jun 02, 2023 at 02:53:31PM +0200, Johan Hovold wrote:

> > I just posted a patch series which does that. The USB serial drivers do
> > not currently return any errors related to break signalling even though
> > this has been possible since 2008.
> > 
> > The same mechanism can be used to report that break signalling is not
> > supported by a device or driver, but the USB serial drivers would be the
> > first tty drivers that actually do this. If it turns out to cause any
> > trouble we can still use this series to avoid the unnecessary wait.
> > 
> > Care to give the series a try?
> > 
> > 	https://lore.kernel.org/lkml/20230602124642.19076-1-johan@kernel.org
> 
> I have tested this series.  I can verify that one of the CP2105 ports
> (ttyUSB0) does not return an error on sending the break, and the other
> (ttyUSB1) does.  This is the only USB serial device on the system.

Thanks for testing.

> However, the device hooked to the remote console (ttyUSB0), the one not
> returning an error on sending a break, still doesn't send a break.  So
> my problem isn't fixed :-(.
> 
> # ls -l /dev/serial/by-path
> total 0
> lrwxrwxrwx 1 root root 13 Jun  2 15:28 pci-0000:00:1d.0-usb-0:1.1:1.0-port0 -> ../../ttyUSB0
> lrwxrwxrwx 1 root root 13 Jun  2 15:28 pci-0000:00:1d.0-usb-0:1.1:1.1-port0 -> ../../ttyUSB1

Ok, at least that matches what you found in schematics about this being
the ECI (and thus first) port.

I just verified break signalling on the first port of my CP2105 using a
logic analyser and everything seems to work as expected.

There's also no mention of any issue with break in the errata.

Could you check which firmware revision you have by enabling debugging
and reconnecting the device?

For example:

	echo func cp210x_get_fw_version +p > /sys/kernel/debug/dynamic_debug/control

Johan
