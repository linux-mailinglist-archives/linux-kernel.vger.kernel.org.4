Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF84C71FBC1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjFBIVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjFBIVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:21:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49486198;
        Fri,  2 Jun 2023 01:21:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D23E9644C3;
        Fri,  2 Jun 2023 08:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D73C433EF;
        Fri,  2 Jun 2023 08:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685694106;
        bh=d06PJuVSxob5MNWnuvAfNiLm/H/DP8lybGq+f6bIRIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6ipDXp/Am8PzDws5Oc+S4hirU0asEA6JiGOVRF8Q7+nIVhDtKeN6ww56KQlaqYvu
         uA7LZZfw9IIaSfKvkginodpkqw3ZyZwfOXIgnT2nFYdAbcuKD8VlPdSO4gUnbtFmpu
         VWgX3FJBETrhUVbmh/iyhqdpYr/nqxOeDQ02LP2Lo8xHgZWH2kwn5q+/gMffmyF6en
         Bn4WtClrn2nBOrM5R1wDErDyE+An0wpIIFaZ/HqGJkuKNsjmrZ+n/bnPnlGxy3EDuS
         DGDUhAWgE9JWbl/7HSRuJ3eAWHuoQRGK7SkGd1wKsDv5Fj85YujhbCt19wJN3we2bx
         IEDzGNHifsQww==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q502l-0001Fx-AV; Fri, 02 Jun 2023 10:21:55 +0200
Date:   Fri, 2 Jun 2023 10:21:55 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] Bluetooth: fix use-bdaddr-property quirk
Message-ID: <ZHmmowyw_ulrQXJd@hovoldconsulting.com>
References: <20230531090424.3187-1-johan+linaro@kernel.org>
 <20230531090424.3187-3-johan+linaro@kernel.org>
 <CGME20230601220156eucas1p21caabcf02509fce7eb26f973704980f9@eucas1p2.samsung.com>
 <ecef83c8-497f-4011-607b-a63c24764867@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecef83c8-497f-4011-607b-a63c24764867@samsung.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 12:01:55AM +0200, Marek Szyprowski wrote:
> On 31.05.2023 11:04, Johan Hovold wrote:
> > Devices that lack persistent storage for the device address can indicate
> > this by setting the HCI_QUIRK_INVALID_BDADDR which causes the controller
> > to be marked as unconfigured until user space has set a valid address.
> >
> > The related HCI_QUIRK_USE_BDADDR_PROPERTY was later added to similarly
> > indicate that the device lacks a valid address but that one may be
> > specified in the devicetree.
> >
> > As is clear from commit 7a0e5b15ca45 ("Bluetooth: Add quirk for reading
> > BD_ADDR from fwnode property") that added and documented this quirk and
> > commits like de79a9df1692 ("Bluetooth: btqcomsmd: use
> > HCI_QUIRK_USE_BDADDR_PROPERTY"), the device address of controllers with
> > this flag should be treated as invalid until user space has had a chance
> > to configure the controller in case the devicetree property is missing.
> >
> > As it does not make sense to allow controllers with invalid addresses,
> > restore the original semantics, which also makes sure that the
> > implementation is consistent (e.g. get_missing_options() indicates that
> > the address must be set) and matches the documentation (including
> > comments in the code, such as, "In case any of them is set, the
> > controller has to start up as unconfigured.").
> >
> > Fixes: e668eb1e1578 ("Bluetooth: hci_core: Don't stop BT if the BD address missing in dts")
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> This patch has been recently merged to linux-next as commit 6ac517d8cf8b 
> ("Bluetooth: fix use-bdaddr-property quirk"). Unfortunately it breaks 
> bluetooth operation on my Raspberry Pi 3b+, 4b+ and Khadas VIM3 based 
> test systems.
> 
> Before this patch on Raspberry Pi 4b+:
> 
> root@target:~# dmesg | grep hci0
> [   14.459292] Bluetooth: hci0: BCM: chip id 107
> [   14.464283] Bluetooth: hci0: BCM: features 0x2f
> [   14.470632] Bluetooth: hci0: BCM4345C0
> [   14.474483] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0000
> [   14.487275] Bluetooth: hci0: BCM4345C0 'brcm/BCM4345C0.hcd' Patch
> [   15.347542] Bluetooth: hci0: BCM: features 0x2f
> [   15.354588] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+-0159
> [   15.361076] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0290
> root@target:~# hcitool dev
> Devices:
>          hci0    DC:A6:32:12:38:D1

Thanks for the report and sorry about the breakage.

Turns out that the Broadcom driver has so far been setting the
HCI_QUIRK_USE_BDADDR_PROPERTY also for devices such as yours which
already have a valid address.

I've sent a fix for the Broadcom driver here:

	https://lore.kernel.org/lkml/20230602081912.4708-1-johan+linaro@kernel.org

which should address this. Could you give it a try?

Johan
