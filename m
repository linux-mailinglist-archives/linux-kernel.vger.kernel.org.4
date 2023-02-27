Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CBF6A3FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 12:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjB0LDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB0LCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:02:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B801921280
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 03:02:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D4E5B80CAE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F9CC433D2;
        Mon, 27 Feb 2023 11:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677495729;
        bh=JQ+Pdw4UHZLkp76kvYxumaMh2sT6PNgLvmRlP2tpT0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bBVMlU8yWfBIsLWjT6+uanNbaxeFV5AvcTvAKKNbvLgi9ZJoV9Sek9FG42TtufHv7
         lFoLrZ9QeAZLVLaZHc2dYkgmUa0is4ZtpsW37Jj8IscDyMDYZUCtPCuUj6qWKfRAD4
         9ItJH4Kx5NYg6cSS+yFnl88iFVe0HMa3vH8uBHlgXVsfcAw/xWxk3mD2Rjqg7mZ+tK
         /U089GkOVc/gAexOVnljDl/iFsG01RyPgs/IBCyJeJNspHpQsujDURuh/TrFqTQ+YN
         Qi59IMd2nr2ryrWRL7nujlM7pnFU5rXDx7AooPyGZ+KzHR6Lrx3aM4tlhuH13NZyWK
         hobsFbnizzJEg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pWbH3-0001Ng-4O; Mon, 27 Feb 2023 12:02:29 +0100
Date:   Mon, 27 Feb 2023 12:02:29 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bingbu Cao <bingbu.cao@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        johan+linaro@kernel.org, hsinyi@chromium.org, maz@kernel.org
Subject: Re: System boot failure related to commit 'irqdomain: Switch to
 per-domain locking'
Message-ID: <Y/yNxQADtJJLFY5W@hovoldconsulting.com>
References: <d2290916-f78c-4b0a-d706-0955ae0aa4ff@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2290916-f78c-4b0a-d706-0955ae0aa4ff@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 06:46:05PM +0800, Bingbu Cao wrote:
> 
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

This commit is not in 6.2.0, so I assume you're using a build of Linus's
master branch (i.e. what will become 6.3-rc1)?

> I really have no idea why it cause my problem, but I see just
> reverting this commit really help me.
> 
> Do you have any idea?

Is there anything suspicious in dmesg (e.g. any new warnings or stack
dumps)?

One issue with the above commit that affects some systems (e.g. using
xen virtualisation) has been reported and fixed already. Could you try
applying the following and see if that helps?

	https://lore.kernel.org/all/20230223083800.31347-1-jgross@suse.com/

Johan
