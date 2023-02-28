Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2D96A503D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 01:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjB1Apk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 19:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1Apj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:45:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470224235
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:45:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7BB360D57
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FDDC433EF;
        Tue, 28 Feb 2023 00:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677545137;
        bh=fOqNwJ5Z4MwZZ8QQLBVpGC+AbACWby18/GuSIOkDFZY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AaPMhMIQ+qzxg3/CoRT/DcE3GSqjCsIIww/wwVg4q2W3oX4Dd5ZT+UehdoEjju1AA
         lEXop4SxPDenBi8tZO4kQrI8rketANGq2cwJZL6UAwYMem3VAWlDn3tFU8TDoTeuFH
         9sEQ/RdmCPTAHua1SHh5Be9iZdaxovRVBC2oEV85X61mKyhO1b+p8gBogdJ0lRgKS+
         LBMA04JP/li9YPYIZGJPftBsf2i3rw4zLSdfjfT/cIrmmsXjee6icC6ycVdidIB05k
         EPV/0deztFV+OEy4WL+Af0Kdm+S3VBtStgM4Ynoc9zS/N8wvF3Xxi9bR12NNQ4Ggsc
         Z0KzwQrvZ9gyw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pWo7a-00Dhtu-RN;
        Tue, 28 Feb 2023 00:45:34 +0000
MIME-Version: 1.0
Date:   Tue, 28 Feb 2023 00:45:34 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Bingbu Cao <bingbu.cao@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        hsinyi@chromium.org
Subject: Re: System boot failure related to commit 'irqdomain: Switch to
 per-domain locking'
In-Reply-To: <d2290916-f78c-4b0a-d706-0955ae0aa4ff@linux.intel.com>
References: <d2290916-f78c-4b0a-d706-0955ae0aa4ff@linux.intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d595de9168d45bb5e863942ab7a78e3d@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: bingbu.cao@linux.intel.com, linux-kernel@vger.kernel.org, johan+linaro@kernel.org, hsinyi@chromium.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-27 10:46, Bingbu Cao wrote:
> Hi, Johan and Zyngier,
> 
> I am using a Dell XPS laptop(Intel Processor) just update my
> Linux kernel to latest tag 6.2.0, and then I see that the kernel
> cannot boot successfully, it reported:
> --------------------------------------------
> Gave up waiting for root file system device. Common problems:
>  - Boot args (cat /proc/cmdline)
>    - Check rootdelay= (did the system wait long enough?)
>  - Missing modules (cat /proc/modules; ls /dev)
> 
> ALERT! UUID=xxxxxxx does not exist. Dropping to shell!
> --------------------------------------------
> 
> And then it drop into initramfs shell, I try to use 'blkid' to
> get block devices information, but it showed nothing.
> 
> I also tried add 'rootdelay' and 'rootwait' in bootargs, but it did
> not work.
> 
> I am sure that my previous kernel 6.2.0-rc4 work normally, so I
> did some bisect and found the commit below cause the failure on
> my system:
> 
> 9dbb8e3452ab irqdomain: Switch to per-domain locking
> 
> I really have no idea why it cause my problem, but I see just
> reverting this commit really help me.
> 
> Do you have any idea?

Please provide us with a kernel boot log. It is very hard
to figure out what is going on without it. It would also
help if you indicated what sort of device is your root
filesystem on (NVMe, SATA, USB...), as it would narrow the
search for the culprit.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
