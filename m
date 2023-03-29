Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9204F6CD147
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjC2EyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjC2EyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:54:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2BC3AA2;
        Tue, 28 Mar 2023 21:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E23861A55;
        Wed, 29 Mar 2023 04:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181D5C433D2;
        Wed, 29 Mar 2023 04:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680065654;
        bh=LIS7zJz90cEjLNZjPPsW13H2Bm79KhPrHCbBLaDIygk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EIBb9vmTKbNd8JZraTMtu9YRJzCkLv0giiCVXRHmhRjOXXk0JlcpeI6eb+rB1wmpa
         aU+a5QBLzaoffHAg+/W+h9eHEy3QMvMtlZcoNiKpl7p+YNBrFI9fgh0G3Y+0Ex+mAZ
         3MvN0053bWgFGyccsEoedcqYD0de68QK5LHRVwlo=
Date:   Wed, 29 Mar 2023 06:54:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: allow mmc to block wait_for_device_probe()
Message-ID: <ZCPEcxueuGUaRNOP@kroah.com>
References: <20230328223740.69446-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328223740.69446-1-dennis@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 03:37:40PM -0700, Dennis Zhou wrote:
> I've been hitting a failed data device lookup when using dm-verity and a
> root device on an emmc partition. This is because there is a race where
> dm-verity is looking for a data device, but the partitions on the emmc
> device haven't been probed yet.
> 
> Initially I looked at solving this by changing devt_from_devname() to
> look for partitions, but it seems there is legacy reasons and issues due
> to dm.
> 
> MMC uses 2 levels of probing. The first to handle initializing the
> host and the second to iterate attached devices. The second is done by
> a workqueue item. However, this paradigm makes wait_for_device_probe()
> useless as a barrier for when we can assume attached devices have been
> probed.
> 
> This patch fixes this by exposing 2 methods inc/dec_probe_count() to
> allow device drivers that do asynchronous probing to delay waiters on
> wait_for_device_probe() so that when they are released, they can assume
> attached devices have been probed.

Please no.  For 2 reasons:
  - the api names you picked here do not make much sense from a global
    namespace standpoint.  Always try to do "noun/verb" as well, so if
    we really wanted to do this it would be "driver_probe_incrememt()"
    or something like that.
 - drivers and subsystems should not be messing around with the probe
   count as it's a hack in the first place to get around other issues.
   Please let's not make it worse and make a formal api for it and allow
   anyone to mess with it.

Why can't you just use normal deferred probing for this?

thanks,

greg k-h
