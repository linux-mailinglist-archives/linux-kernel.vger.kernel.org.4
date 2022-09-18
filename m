Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5AD5BBD72
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 12:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiIRKco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 06:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIRKcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 06:32:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BCF1C916
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:32:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85833B80E4C
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 10:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EAEC433D6;
        Sun, 18 Sep 2022 10:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663497158;
        bh=I/231C3xrrcoDPvXTfR4QzqxGeYUu8BpzYz0w9jb7YE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v8ZlC0pPtIIuhPG7vgs+5ZAm//zBSWqtfUBHqiLsnInfHLC/c3i1uOMBcMUdfAETl
         7pmkeGLLpWfXEv13Vs6VnybiwCbfIf9aXdlZONNP/ZagT7SwBS0j9TCHzRUxDaTltV
         sMtDkyZk0fDOzPSPtnewIXQIhT/kPcb1xOtp6Wd8=
Date:   Sun, 18 Sep 2022 12:33:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiho Chu <jiho.chu@samsung.com>
Cc:     arnd@arndb.de, ogabbay@kernel.org, krzysztof.kozlowski@linaro.org,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        yelini.jeong@samsung.com, myungjoo.ham@samsung.com
Subject: Re: [PATCH v2 07/13] trinity: Add sysfs module
Message-ID: <Yybz4j+Uz+aH7uT+@kroah.com>
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
 <CGME20220917072357epcas1p485a1cdcb71cc01274db1c8d00aec197c@epcas1p4.samsung.com>
 <20220917072356.2255620-8-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917072356.2255620-8-jiho.chu@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 04:23:50PM +0900, Jiho Chu wrote:
> This patch includes sysfs interfaces.
> 
> sysfs interface provides NPU's internal statistics, status and control
> attribes.
> 
> The sysfs information provided by the Trinity are:
> - IDU version
> - profiling result
> - allocated debugfs buffer
> 
> The control attributes are including:
> - initialize profile operation
> - NPU control (suspend/resume/stop)
> 
> Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
> Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
> Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  .../ABI/testing/sysfs-driver-trinity          |  55 ++
>  drivers/misc/trinity/Makefile                 |   1 +
>  drivers/misc/trinity/trinity_sysfs.c          | 667 ++++++++++++++++++
>  3 files changed, 723 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-trinity
>  create mode 100644 drivers/misc/trinity/trinity_sysfs.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-trinity b/Documentation/ABI/testing/sysfs-driver-trinity
> new file mode 100644
> index 000000000000..754e6f36a1dc
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-trinity
> @@ -0,0 +1,55 @@
> +What:           /sys/devices/platform/trinity/*.triv2/debug/debugfs_max
> +Date:           July 2022
> +KernelVersion:  5.19-rc8
> +Contact:        Jiho Chu <jiho.chu@samsung.com>
> +Description:    Shows current allocated debugfs entry size.
> +                Note that, Writing max entry size allocates NPU's hardware
> +                memory for debugfs entries.

Why are debugfs things being mentioned in sysfs entries?

That's not needed, nor is it allowed, sorry.

Please put all debugfs stuff in debugfs.

Also, sysfs is "one value per file", you violate that in lots of ways
with this patch.  Please fix all of that, and use the sysfs_emit() calls
instead of snprintf() for your sysfs show calls.

thanks,

greg k-h
