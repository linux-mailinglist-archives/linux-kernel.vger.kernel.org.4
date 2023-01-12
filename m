Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7D2667EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjALTXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239964AbjALTWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:22:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0058178AB;
        Thu, 12 Jan 2023 11:10:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F132B82018;
        Thu, 12 Jan 2023 19:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2D7C433D2;
        Thu, 12 Jan 2023 19:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673550643;
        bh=wsRZ5b8Hncv/sjW+FA6nhhHPjnkIIFUD6E+cajEKTX0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Zdy/g2iPZ67TF1wrBtvg8m0PwRcMDlpHljIO+QYfNPhcVZkgzwaLty2cIJU3b+/M5
         rtYnLBOXWX9YvxA8Ko0v9YAaAe4+mWI9qqBDuMWn/m4OMwhwE+LDjSYl6HlQqjJbas
         CXdSDH7GfGqlTK2CZjyIjx1mAqi4J9X0+Q432YsBW2DYkA4FesONL7VwilbdiEt2iX
         OjxpN3jx3kBbd5sR2ufFYlTfiW5FsI3WBsoPxoivAfFRrfAVH4UZkRUMfSsXN+PNrl
         VLgPZM0R9YD7khxT8xEXO8iQ66u+yAHG9MBHxI+BbxlvlTowFdfjxJgdsBZPunL5kJ
         jN01SrHNAkxFg==
Message-ID: <40b90d7309246484afa09b2d2b2e23e7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230112135224.3837820-1-quic_bjorande@quicinc.com>
References: <20230112135224.3837820-1-quic_bjorande@quicinc.com>
Subject: Re: [PATCH] clk: qcom: gdsc: Disable HW control until supported
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Date:   Thu, 12 Jan 2023 11:10:40 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2023-01-12 05:52:24)
> Software normally uses the SW_COLLAPSE bit to collapse a GDSC, but in
> some scenarios it's beneficial to let the hardware perform this without
> software intervention.
>=20
> This is done by configuring the GDSC in "hardware control" state, in
> which case the SW_COLLAPSE bit is ignored and some hardware signal is
> relies upon instead.
>=20
> The GDSCs are modelled as power-domains in Linux and as such it's
> reasonable to assume that the device drivers intend for the hardware
> block to be accessible when their power domain is active.
>=20
> But in the current implementation, any GDSC that is marked to support
> hardware control, gets hardware control unconditionally while the
> client driver requests it to be active. It's therefor conceivable that
> the hardware collapses a GDSC while Linux is accessing resources
> depending on it.

Why would software want the GDSC to be enabled and accessing resources
while the hardware signals that it isn't required? It sounds like
hardware control isn't complete?

>=20
> There are ongoing discussions about how to properly expose this control

Any link? When we implemented hardware clk gating years ago the design
was to have software override hardware control when the clk was enabled
in software and let the hardware control go into effect when the clk was
disabled in software. Hopefully with power domains this could be
implemented in a better way by connecting hardware mode to some
performance state so that enabling the power domain goes to software
mode and then transitioning to a performance state switches to hardware
control mode.

> to the client drivers, but until conclusion in that discussion is
> reached, the safer option would be to keep the GDSC in software control
> mode.
>=20
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/clk/qcom/gdsc.c | 48 ++++++-----------------------------------
>  1 file changed, 7 insertions(+), 41 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 9e4d6ce891aa..6d3b36a52a48 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -439,6 +398,13 @@ static int gdsc_init(struct gdsc *sc)
>                 on =3D true;
>         }
> =20
> +       /* Disable HW trigger mode until propertly supported */
> +       if (sc->flags & HW_CTRL) {
> +               ret =3D gdsc_hwctrl(sc, false);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +

Is it a problem for all hardware controlled gdscs? Or just some of them?
Should we backport this to stable kernels? I seem to recall that
hardware mode was required for some drivers like camera and video? Are
they going to keep working if we simply knock out the hardware control
mode here?
