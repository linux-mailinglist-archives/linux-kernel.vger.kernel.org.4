Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4D164072D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiLBMvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiLBMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:51:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C72CA7A0;
        Fri,  2 Dec 2022 04:51:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C853EB82162;
        Fri,  2 Dec 2022 12:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0E5C433D6;
        Fri,  2 Dec 2022 12:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669985468;
        bh=N8iaXOkKMk2SIfbdKoOvU4dUqWAClTiQ1M1kpcY5fRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGINdKTPKXiGv6UTf0X8Qw+ztPj3cqJDc7ewQSCHgZN+TpOy/EsAsvFnTdcex3S4F
         L1YLM39fspk34rrak5QgmWiM2LPzi2rfMveQw/CoNRQAbLqMnUC8SRldMmdikyNFGU
         jT4x0NFBnRvLsvIvxOSXJjeNDGMCwAWBUTx5yG78=
Date:   Fri, 2 Dec 2022 13:51:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daehwan Jung <dh10.jung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
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
Message-ID: <Y4n0uNqTUmGpdS6P@kroah.com>
References: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
 <CGME20221201021942epcas2p2429ed37e1f6146b6e1a5bef23141b3f7@epcas2p2.samsung.com>
 <1669860811-171746-3-git-send-email-dh10.jung@samsung.com>
 <Y4hgnxGMEuizJumr@kroah.com>
 <c524cba6-4438-461a-ab05-9325fe09f832@app.fastmail.com>
 <ec0ce90c-b165-d84f-340d-4973b65609b3@linux.intel.com>
 <f633b0f3-9fdb-8beb-7edf-7967c7c0c3d5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f633b0f3-9fdb-8beb-7edf-7967c7c0c3d5@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 01:23:56PM +0100, Krzysztof Kozlowski wrote:
> On 02/12/2022 13:22, Mathias Nyman wrote:
> > On 1.12.2022 11.01, Arnd Bergmann wrote:
> >> On Thu, Dec 1, 2022, at 09:06, Greg Kroah-Hartman wrote:
> >>> On Thu, Dec 01, 2022 at 11:13:31AM +0900, Daehwan Jung wrote:
> >>>> This driver works with xhci platform driver. It needs to override
> >>>> functions of xhci_plat_hc_driver. Wakelocks are used for sleep/wakeup
> >>>> scenario of system.
> >>>
> >>> So this means that no other platform xhci driver can be supported in the
> >>> same system at the same time.
> >>>
> >>> Which kind of makes sense as that's not anything a normal system would
> >>> have, BUT it feels very odd.  This whole idea of "override the platform
> >>> driver" feels fragile, why not make these just real platform drivers and
> >>> have the xhci platform code be a library that the other ones can use?
> >>> That way you have more control overall, right?
> > 
> > Agree that overriding the generic platform driver xhci_hc_platform_driver
> > from this exynos driver is odd.
> > 
> > But I don't understand how this works.
> > Where are the hcds created and added when this xhci-exonys driver binds to
> > the device? all this driver does in probe is the overriding?
> > 
> > Am I missing something here?
> 
> Because it is not a driver for Exynos... it's a driver for wakelocks for
> their specific Android use-cases which the manufacturer ships for their
> Android devices. Due to Google GKI, they try to squeeze into upstream.

GKI has nothing to do with this, this is Samsung not understanding how
to properly submit code upstream.  Odd that it comes down to them only
as this same driver is used by _many_ OEMs who have good teams that know
how to upstream code properly.  All the blame shouldn't be on Samsung
right now (see Google's last attempt at getting USB hooks accepted for
this same hardware IP block...)

thanks,

greg k-h
