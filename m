Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C0E7150C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 22:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjE2U6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 16:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE2U6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 16:58:30 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D6CD9
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 13:58:28 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 26E1D3EC4E;
        Mon, 29 May 2023 22:58:25 +0200 (CEST)
Date:   Mon, 29 May 2023 22:58:23 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Caleb Connolly <caleb@connolly.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH RFC 06/10] drm/panel/samsung-sofef01: Add panel driver
 for Sony Xperia 5 / 10 II
Message-ID: <bz7kqcdxnrbt2lzaykgxnviusrksu5txng3ngietj6rb3mhmsx@qwbann5px44w>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-6-541c341d6bee@somainline.org>
 <f34cd6a8-6d6d-9dcf-b681-56439416c4b4@linaro.org>
 <gzhxxdh235nsbjbns37thi33rpk546ynkihihjiam46pkngkud@opwtr2swvdau>
 <CAA8EJppniEh3cFpi=AdK-i=KZcd=tzpPru0W4Vq9LJjJL8q=qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJppniEh3cFpi=AdK-i=KZcd=tzpPru0W4Vq9LJjJL8q=qQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-23 01:56:46, Dmitry Baryshkov wrote:
> On Tue, 23 May 2023 at 01:32, Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> >
> > On 2023-05-22 04:19:45, Dmitry Baryshkov wrote:
> > > On 22/05/2023 00:23, Marijn Suijten wrote:
> > > > This SOFEF01-M Display-IC driver supports two modes with different
> > > > compatibles to differentiate between slightly different physical sizes
> > > > (panels) found on the Xperia 5 (6.1") and 10 II (6.0").
> > > >
> > > > It is currently also used to hardcode significantly higher fake porches
> > > > for the Xperia 5, which are unused in transfers due to this being a
> > > > command-mode panel but do have an effect on the clock rates set by
> > > > dsi_host.c.  Without higher clock rates this panel fails to achieve
> > > > 60fps and has significant tearing artifacts, while the same calculated
> > > > clock rate works perfectly fine on the Xperia 10 II.
> >
> > <snip>
> >
> > > > +/* Sony Xperia 5 (kumano bahamut) */
> > > > +static const struct drm_display_mode samsung_sofef01_m_bahamut_mode = {
> > > > +   /*
> > > > +    * WARNING: These massive porches are wrong/useless for CMDmode
> > > > +    * (and not defined in downstream DTS) but necessary to bump dsi
> > > > +    * clocks higher, so that we can achieve proper 60fps without tearing.
> > > > +    */
> > > > +   .clock = (1080 + 156 + 8 + 8) * (2520 + 2393 + 8 + 8) * 60 / 1000,
> > > > +   .hdisplay = 1080,
> > > > +   .hsync_start = 1080 + 156,
> > > > +   .hsync_end = 1080 + 156 + 8,
> > > > +   .htotal = 1080 + 156 + 8 + 8,
> > > > +   .vdisplay = 2520,
> > > > +   .vsync_start = 2520 + 2393,
> > > > +   .vsync_end = 2520 + 2393 + 8,
> > > > +   .vtotal = 2520 + 2393 + 8 + 8,
> > > > +   .width_mm = 61,
> > > > +   .height_mm = 142,
> > > > +};
> > > > +
> > > > +/* Sony Xperia 10 II (seine pdx201) */
> > > > +static const struct drm_display_mode samsung_sofef01_m_pdx201_mode = {
> > > > +   .clock = (1080 + 8 + 8 + 8) * (2520 + 8 + 8 + 8) * 60 / 1000,
> > > > +   .hdisplay = 1080,
> > > > +   .hsync_start = 1080 + 8,
> > > > +   .hsync_end = 1080 + 8 + 8,
> > > > +   .htotal = 1080 + 8 + 8 + 8,
> > > > +   .vdisplay = 2520,
> > > > +   .vsync_start = 2520 + 8,
> > > > +   .vsync_end = 2520 + 8 + 8,
> > > > +   .vtotal = 2520 + 8 + 8 + 8,
> > > > +   .width_mm = 60,
> > > > +   .height_mm = 139,
> > > > +};
> > > > +
> > > > +static const struct of_device_id samsung_sofef01_m_of_match[] = {
> > > > +   { .compatible = "samsung,sofef01-m-bahamut", .data = &samsung_sofef01_m_bahamut_mode },
> > > > +   { .compatible = "samsung,sofef01-m-pdx201", .data = &samsung_sofef01_m_pdx201_mode },
> > >
> > > Are there really two panels? Can we use one mode for both usecases?
> >
> > See the commit description where I explained exactly this: the panels
> > have different dimensions (6.1" vs 6.0", hence different DPI) and I also
> > abuse this to hack in higher clock rates via fake porches.
> >
> > I just ended up on a scary website that supposedly contains the panel
> > names:
> >
> > - Xperia 5 (bahamut, 6.1"): AMB609TC01
> > - Xperia 10 II (pdx201, 6.0"): AMS597UT01
> 
> Great! From the patch description it was not obvious if those are two
> different panels or a single panel with slight difference in the glass
> cover. With these names in place (well, with two distinct names in
> place) it makes sense.

For completeness: keep the current single file but embed these panel
names as suffix (eg. `samsung,sofef-01-m-am[bs]...`) to the compatible
(and document these more explicitly elsewhere)?

- Marijn

> 
> -- 
> With best wishes
> Dmitry
