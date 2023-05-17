Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9ED770636C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjEQI7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjEQI67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:58:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D011421E;
        Wed, 17 May 2023 01:58:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED8D163813;
        Wed, 17 May 2023 08:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E17C4339C;
        Wed, 17 May 2023 08:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684313933;
        bh=d6Gn9SyMUa6cLVI0AcUzi9nyzJT6+ZT/zA/lvG9cPcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xss2kJF8OgUoQYiyulSaRdgFX8j1BEd7MCK+1xl0rhI9Yof8ohqtgZkXD+degKx+d
         kCFy7TWMckHumdZ7wREbGHHNpG4HevcoX+fhgfr/g1nEGh4zo7uItMzVbeBaAbzgR2
         mncgu+XpzjL1Hm1aoUVwn6zhtRLr3k8bfqTdH5Kw=
Date:   Wed, 17 May 2023 10:58:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.4 000/282] 5.4.243-rc1 review
Message-ID: <2023051727-eternity-thaw-a948@gregkh>
References: <20230515161722.146344674@linuxfoundation.org>
 <739bd109-b32d-46f1-b382-e55f34efc11a@roeck-us.net>
 <2023051738-bullfrog-dreamily-79a4@gregkh>
 <2023051744-overthrow-playlist-a0d5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023051744-overthrow-playlist-a0d5@gregkh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 10:26:54AM +0200, Greg Kroah-Hartman wrote:
> On Wed, May 17, 2023 at 10:25:13AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, May 16, 2023 at 08:52:13PM -0700, Guenter Roeck wrote:
> > > On Mon, May 15, 2023 at 06:26:18PM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.4.243 release.
> > > > There are 282 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > Build results:
> > > 	total: 159 pass: 159 fail: 0
> > > Qemu test results:
> > > 	total: 455 pass: 454 fail: 1
> > > Failed tests:
> > > 	arm:sabrelite:multi_v7_defconfig:mtd2:mem256:net,default:imx6dl-sabrelite:rootfs
> > > 
> > > As far as I can see, the second SPI interface fails to instantiate.
> > > 
> > > [   21.491528] spi_imx 2008000.spi: bitbang start failed with -22
> > > 
> > > There are also various new warnings in clock code.
> > > 
> > > [   21.492631] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:986 clk_core_disable+0x124/0x2e4
> > > [   21.497524] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:845 clk_core_unprepare+0x268/0x388
> > > 
> > > The warnings in clock code are gone after reverting all changes introducing
> > > PM support for imx spi code. The boot failure is gone after reverting the
> > > gpio conversion. In total, I reverted the following patches to fix the
> > > boot and warning problems.
> > > 
> > > d6fcaa127cc6 Revert "spi: imx/fsl-lpspi: Convert to GPIO descriptors"
> > > 9783b21b591d Revert "spi: imx: enable runtime pm support"
> > > 4a8bdbf7462b Revert "spi: spi-imx: using pm_runtime_resume_and_get instead of pm_runtime_get_sync"
> > > e6c5f497ff35 Revert "spi: imx: Don't skip cleanup in remove's error path"
> > > d6ea758df74f Revert "spi: imx: fix runtime pm support for !CONFIG_PM"
> > > b9dbd028c970 Revert "spi: imx: fix reference leak in two imx operations"
> > > 
> > > Is this really 5.4 material ?
> > 
> > You are right, this isn't 5.4 material (and really not 5.10 either for
> > some of these changes.)  I'll go drop them all from 5.4.y and 5.10.y and
> > push out -rc2 releases soon.
> 
> I'll leave the 5.10.y changes, they were sane.

And as I just dropped patches, I'll not push out a -rc2, that would
probably not help anyone.

thanks,

greg k-h
