Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A2672026C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjFBMxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjFBMxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:53:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680F1180;
        Fri,  2 Jun 2023 05:53:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0370C64EC2;
        Fri,  2 Jun 2023 12:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F407C433D2;
        Fri,  2 Jun 2023 12:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685710401;
        bh=ZV3TXb4k3/oksLoC4wMufxc1DqE6EYIOcySR9DR8FeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oR8aJMD0ZbgcO8098hioibDz0XaQQvUdvPPf0+iatNwkwlmlnMHQyKNi82bTde7NZ
         VkFAE4/2M90yaw8yKbtbXI7NbEuJsFWMRFQmHvnWUFkgc3TUh34YaJt7rUqyr67p+1
         8oYUaEoDY7lLG8N2ToKrQrv+yyENjindJF16fazmqsHxuo44FfMiziKzRpXdH9bQ1u
         nwGV2Vo6YlvJPxhNKonKbAr5GPJdmWm152t1O7A9vaB2oF42xsrxmCUDG+RLsZLJii
         8SRw5yUXnvwc0+NhTti8FyJ5BRUCQeHrYF60o/983LmO9v8oZasnXRUGyykqplZS1C
         TvmAnl5aSRipw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q54Hb-00050s-36; Fri, 02 Jun 2023 14:53:31 +0200
Date:   Fri, 2 Jun 2023 14:53:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     Craig Shelley <craig@microtron.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: Break doesn't work on a CP2105
Message-ID: <ZHnmSwGyOaSMbPBB@hovoldconsulting.com>
References: <ZEmDs0ASdnEAnpsL@minyard.net>
 <ZGtZKCvo71woGf9T@hovoldconsulting.com>
 <ZGtlnWGSc31Wdhxa@mail.minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGtlnWGSc31Wdhxa@mail.minyard.net>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 07:52:45AM -0500, Corey Minyard wrote:
> On Mon, May 22, 2023 at 01:59:36PM +0200, Johan Hovold wrote:

> > I just verified that break works on the first port of my cp2105 but not
> > on the second one (I seem to receive the last characters sent instead).
> > 
> > Apparently this is expected as the datasheet (AN571) says the following
> > about the SET_BREAK command:
> > 
> > 	This command is not supported on the second CP2105 interface.
> > 
> > Which port are you seeing this behaviour with?
> 
> I'm guessing this is it.  From the schematic I think this is the
> TXD_ECI pin, though I'm not 100% sure.  I'd have to dig through the
> device tree and SOC manual to be sure which port is which.

It should be the second SCI interface which do not support break.

> Would it be possible to return an error in this situation instead of it
> silently not working?  Just to avoid others having the same issue.

I just posted a patch series which does that. The USB serial drivers do
not currently return any errors related to break signalling even though
this has been possible since 2008.

The same mechanism can be used to report that break signalling is not
supported by a device or driver, but the USB serial drivers would be the
first tty drivers that actually do this. If it turns out to cause any
trouble we can still use this series to avoid the unnecessary wait.

Care to give the series a try?

	https://lore.kernel.org/lkml/20230602124642.19076-1-johan@kernel.org

Johan
