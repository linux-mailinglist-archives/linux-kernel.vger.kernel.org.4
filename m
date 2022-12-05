Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC01642463
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiLEIVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiLEIVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:21:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85CB15A1B;
        Mon,  5 Dec 2022 00:21:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93818B80D6E;
        Mon,  5 Dec 2022 08:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39CFC433D6;
        Mon,  5 Dec 2022 08:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670228467;
        bh=6bUk7Vf1YChgzBZzifSrrRpGQ7Qo/DtcZjbeaisDxs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e4KwMkaaJQu3Nk7MP1VIsHN0NLaXpWEkKLmZvR6XIB2yXQ/WR7qg8hk8b10NUSlRf
         Q3Ei6K2BqYL2/AawbTaE05zVagDFrY17U8E/AAEKUKWOFtS76xcxCfG211ZFn0JSt2
         gzTBMfdPRNGY86Q0vy2FYG7QFpyigbc41bbKKnJE=
Date:   Mon, 5 Dec 2022 09:21:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Artur Bujdoso <artur.bujdoso@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
Subject: Re: [RFC PATCH v1 2/2] usb: host: add xhci-exynos to support Exynos
 SOCs
Message-ID: <Y42p7+KbEIv5Nw7E@kroah.com>
References: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
 <CGME20221201021942epcas2p2429ed37e1f6146b6e1a5bef23141b3f7@epcas2p2.samsung.com>
 <1669860811-171746-3-git-send-email-dh10.jung@samsung.com>
 <Y4hgnxGMEuizJumr@kroah.com>
 <20221205033034.GE54922@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205033034.GE54922@ubuntu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 12:30:34PM +0900, Jung Daehwan wrote:
> On Thu, Dec 01, 2022 at 09:06:55AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Dec 01, 2022 at 11:13:31AM +0900, Daehwan Jung wrote:
> > > This driver works with xhci platform driver. It needs to override
> > > functions of xhci_plat_hc_driver. Wakelocks are used for sleep/wakeup
> > > scenario of system.
> > 
> > So this means that no other platform xhci driver can be supported in the
> > same system at the same time.
> > 
> > Which kind of makes sense as that's not anything a normal system would
> > have, BUT it feels very odd.  This whole idea of "override the platform
> > driver" feels fragile, why not make these just real platform drivers and
> > have the xhci platform code be a library that the other ones can use?
> > That way you have more control overall, right?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Currently It seems there are 2 ways to excute own function.
> 1. xhci_plat_priv
> -> This is hard to use it if the driver invokes xhci platform driver from
> dwc3_host_init(usb/dwc/host.c). I can't pass driver data during probe.
> 2. xhci_driver_overrides
> -> This is only useful if I has own xhci driver.
> 
> That's why I wanted to extend overriding concept of xhci platform driver.
> If some code is better to be directly in xhci platform driver than xhci-exynos,
> I will modify it.

Again, please restructure this so that there is no need to "override"
anything and instead, you use the xhci-platform code from your driver
instead.

thanks,

greg k-h
