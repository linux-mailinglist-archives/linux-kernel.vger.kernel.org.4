Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2BF742F51
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjF2VK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjF2VKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:10:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00202D4C;
        Thu, 29 Jun 2023 14:10:43 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CBDD066070D1;
        Thu, 29 Jun 2023 22:10:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688073041;
        bh=JCh8QNgbheBN9vzum2hXOH+Xccw6yemZ2xjeKair+aY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=awtycltug4rEIpIWPHSmCJ0Ar7z77OoWwDGCry2DH+yxVYb/zvGXFn4MY6+0VYWHz
         KsjdF6RlG839AVnwTUXG5EhlfY57qurBilxeD4c48tgwS66/uibtEDaER8NzfwVG5S
         JHXvf7vP2vcIQKryhP7Nc2aPRt+dbb+oXgMTCIsXDUC66CsEfWU9LrVu+nJyGWIw83
         BSZf9ksQr+YcWLUt9cu1rx4wlaf479EvT0yP1Jab0CD+ftjnz/ZU+t4SXMd1MUetTU
         H2jTI5x4AB+Dy+grt0C/nvXBZA132sNpsVnx645CtNY3W9M2+wrzL+iw7ra+tbJehg
         JGugr9zpCYcOQ==
Date:   Thu, 29 Jun 2023 17:10:34 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kernel@collabora.com, Alexandre Mergnat <amergnat@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 5/6] thermal/drivers/mediatek/lvts_thermal: Don't
 leave threshold zeroed
Message-ID: <819b9c10-044c-4a2b-b8f2-6ddd633bbf8d@notapiano>
References: <20230504004852.627049-1-nfraprado@collabora.com>
 <20230504004852.627049-6-nfraprado@collabora.com>
 <5d810151-3a3b-51af-bbc1-0ee45668bcc4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d810151-3a3b-51af-bbc1-0ee45668bcc4@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 11:17:27AM +0200, Daniel Lezcano wrote:
> On 04/05/2023 02:48, Nícolas F. R. A. Prado wrote:
> > The thermal framework might leave the low threshold unset if there
> > aren't any lower trip points. This leaves the register zeroed, which
> > translates to a very high temperature for the low threshold. The
> > interrupt for this threshold is then immediately triggered, and the
> > state machine gets stuck, preventing any other temperature monitoring
> > interrupts to ever trigger.
> > 
> > (The same happens by not setting the Cold or Hot to Normal thresholds
> > when using those)
> > 
> > Set the unused threshold to a valid low value. This value was chosen so
> > that for any valid golden temperature read from the efuse, when the
> > value is converted to raw and back again to milliCelsius, the result
> > doesn't underflow.
> > 
> > Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > ---
> > 
> > Changes in v2:
> > - Added this commit
> > 
> >   drivers/thermal/mediatek/lvts_thermal.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> > index efd1e938e1c2..951a4cb75ef6 100644
> > --- a/drivers/thermal/mediatek/lvts_thermal.c
> > +++ b/drivers/thermal/mediatek/lvts_thermal.c
> > @@ -82,6 +82,8 @@
> >   #define LVTS_HW_SHUTDOWN_MT8195		105000
> >   #define LVTS_HW_SHUTDOWN_MT8192		105000
> > +#define LVTS_MINIUM_THRESHOLD		20000
> 
> MINIMUM
> 
> So if the thermal zone reaches 20°C, the interrupt fires, the set_trips sets
> again 20°C but the interrupt won't fire until the temperature goes above
> 20°C and then crosses the temperature low threshold the way down again?

Well, actually, set_trips won't even be called since from the thermal
framework's perspective we haven't crossed trip points, ie in
__thermal_zone_set_trips():

	/* No need to change trip points */
	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
		return;

But in any case, yes, the interrupt will fire, the temperature will get updated
in the framework, and that's it. It will only fire again when a threshold is
crossed again (either by the temperature rising and falling again below this
minimum, or rising beyond the high treshold).

So basically at most this will cause a spurious interrupt when the temperature
gets low enough. I do get 34-36C on all sensors when idling though, so I doubt
that temperature is even reachable. Besides, we don't really have another option
here if we want working interrupts, the threshold needs to be set to a valid
value, and this is the lowest I've found.

And thanks for all the feedback! I'll prepare a v3 based on your comments.

Thanks,
Nícolas
