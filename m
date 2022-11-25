Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D57E63898F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKYMTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKYMTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:19:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7EE1928F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:19:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88AA7622C1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 12:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DE8C433B5;
        Fri, 25 Nov 2022 12:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669378748;
        bh=mZOp0vsvzRrNngwKyz7HgmROJmugzd6BQQN4kzDGk24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G5wlKNylGWwR6ccZnV/INSMAmpV0EY9BkrXiiJe/AQR0G5sNqfMBGGACQyjqJUA91
         WQQJpKRH91kDEgfcIP8P1MnpMeDgzSLbZ1m3fc/5nqmVx0NrTQw0WCIm2PQPLCG26Z
         bsYrl4UMvlHkFGB41Lqgs2Z/Dy9okY7qAotKMH1vvBDGSx2LTUaF3I0ieN7VTwWHx2
         i1Nw+hxV+2g6R0dw44LxzAs+X8zw2uppIAi+zggmEC4W8zMX8dt1Qc7ZcrQtiuCYSw
         zqJ6lKysbpar/wNHQoF2+hoBADLgTFJe/JEu5P+dHV8n+OwVcGTsc48biZoyqRl6tM
         P8Cq6ZRKhRidA==
Date:   Fri, 25 Nov 2022 12:18:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        kuninori.morimoto.gx@renesas.com,
        angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
        chunxu.li@mediatek.com, ajye_huang@compal.corp-partner.google.com,
        allen-kh.cheng@mediatek.com, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 1/3] ASoC: hdmi-codec: Add event handler for hdmi TX
Message-ID: <Y4Cysgk5Gic5ae9B@sirena.org.uk>
References: <20221125094413.4940-1-jiaxin.yu@mediatek.com>
 <20221125094413.4940-2-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kNT+QONpsQiODP63"
Content-Disposition: inline
In-Reply-To: <20221125094413.4940-2-jiaxin.yu@mediatek.com>
X-Cookie: Time and tide wait for no man.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kNT+QONpsQiODP63
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 25, 2022 at 05:44:11PM +0800, Jiaxin Yu wrote:

> +	/*
> +	 * PCM trigger callback.
> +	 * Mandatory
> +	 */
> +	int (*trigger)(struct device *dev, int cmd);
> +

Making this mandatory would break all existing users, though...

> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		if (hcp->hcd.ops->trigger)
> +			hcp->hcd.ops->trigger(component->dev->parent, SNDRV_PCM_TRIGGER_START);

...it's not actually mandatory so it's just the comment that's wrong.
I'm a little unclear why this is being implemented as a DAPM operation
rather than having the driver forward the PCM trigger op if it's needed?
Or alternatively if a DAPM callback is needed why not provide one
directly rather than hooking into the trigger function - that's going to
be called out of sequence with the rest of DAPM and be potentially
confusing given the very different environments that trigger and DAPM
operations run in.  A quick glance at the it6505 driver suggests it'd be
happier with a DAPM callback.

--kNT+QONpsQiODP63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOAsrEACgkQJNaLcl1U
h9CCdgf+JzEvQcOa+cudwzO1Ok98aky4qGZCuKQnnWtkrCayv8eiu7wd7w5G9dpU
VciYfLQ8bgQ3UOImbANerH2+FJhMtldcF8Vn5FJCG1eXpJGMRbWrjguA15/n88uT
bQ2wEInMii6ecKtSyULg3ie9tuLseZfS3jJHOwJeYFANRmaef0UUAQyPkHnnVsj8
luaShk6424tDgSWY1es5RVtOOzPH/JpBXK1DKuCEBI7DFYuAJtmqgXXIZvfwNPHe
sCV/N6DVZNU152PRSiyAX3Y8/x3NzYiSs6BXexv10OlCq44sCPYZ+HdbgY7qQL4y
w7JwiNOcmvN0sbAhK0jjSKmJ3/spKw==
=ReC2
-----END PGP SIGNATURE-----

--kNT+QONpsQiODP63--
