Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A971716DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjE3Tq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjE3Tq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:46:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BD4D9;
        Tue, 30 May 2023 12:46:55 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 459F56606E64;
        Tue, 30 May 2023 20:46:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685476014;
        bh=uuTnSILXVf1Z1lF8zz/SUkYOonCje3HPQu+Vt2KjcSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+WUKYl5YEGoFVtSrWHrdUVw+b4VDr1eengMK7E4zEmSxWSrqDtrZfeuM5Qhdl1jL
         qNXdD3P7KiBha5m8XuRaCsowQgxtz8dpWOVcgsSqFK6c39CjvxEXN6nbZGOuDtf3w0
         hLQrsqWy2cMhepVQ6VlXODTrLJCKAxXPv/NyIGDXHLCwNf3HXr8vxT8PyYrQ2l4peB
         Rt3wiDxICVu2ZiHl0aRG9zCL9TyKLJUDCWoWVKCXRXwiXODSp/ccpllC3YBh8AOnGd
         H4nKIGT3AguTwt5gOX5B4WpucTjHNnZE4UjQBXLibiufCTGw74rDgq9e7ATzwYg+cl
         JcD3cuzSBDV5A==
Date:   Tue, 30 May 2023 15:46:48 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Bailon <abailon@baylibre.com>, kernel@collabora.com,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3] thermal/drivers/mediatek/lvts_thermal: Fixes to the
 interrupt handling
Message-ID: <8a38a0da-3a4f-4e39-9f9e-42682edfd9bf@notapiano>
References: <20230428195347.3832687-1-nfraprado@collabora.com>
 <20230502103344.GA3388518@google.com>
 <87b0f5cd-67a8-fbd5-5ca7-a286b543d796@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87b0f5cd-67a8-fbd5-5ca7-a286b543d796@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 02:27:36PM +0200, Daniel Lezcano wrote:
> 
> Hi,
> 
> On 02/05/2023 12:33, Chen-Yu Tsai wrote:
> > On Fri, Apr 28, 2023 at 03:53:44PM -0400, Nícolas F. R. A. Prado wrote:
> > > 
> > > Fixes in the interrupt handling of the LVTS thermal driver noticed while
> > > testing it on the Spherion Chromebook (mt8192-asurada-spherion) with the
> > > MT8192 support series [1].
> > > 
> > > These are standalone fixes and don't depend on anything else.
> > > 
> > > [1] https://lore.kernel.org/all/20230307163413.143334-1-bchihi@baylibre.com/
> > > 
> > > Thanks,
> > > Nícolas
> > > 
> > > 
> > > Nícolas F. R. A. Prado (3):
> > >    thermal/drivers/mediatek/lvts_thermal: Handle IRQ on all controllers
> > >    thermal/drivers/mediatek/lvts_thermal: Honor sensors in immediate mode
> > >    thermal/drivers/mediatek/lvts_thermal: Disable undesired interrupts
> > 
> > This series seems to have solved all interrupt storm issue I ran into, so
> > 
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> I gave a try on a mt8195 board and I don't see any interrupt firing when
> crossing the temperature thresholds.
> 
> Did I miss something ?

No, indeed interrupts seem to be completely disabled on mt8195, even after
setting the controllers to filtered mode (a requirement to get interrupts). I
haven't investigated that further yet. This series was validated on mt8192,
which did have working interrupts, but they were being triggered too often.

Also note that I've sent a v2 with even more fixes:
https://lore.kernel.org/all/20230504004852.627049-1-nfraprado@collabora.com/

Thanks,
Nícolas
