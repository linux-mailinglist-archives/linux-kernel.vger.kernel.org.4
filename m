Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA4A6CA108
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjC0KOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjC0KOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:14:47 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BC212F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:14:46 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R8Apo2028398;
        Mon, 27 Mar 2023 05:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=lB4wPvCSPW/RRZ/pdUUluaD+fYp3twNkFPxciT+tSrg=;
 b=PRSK8QpjMTP7rMU5a241DPeTMmySZaxOGqFFjlpJnA/c5wVtzXh/1zsfy5gCVYjT8yQp
 po4XVqNEgjWNRwtteUqZ7iZr20H1o272L33aiy5EaesEJvocPklobcbXq+WZWR7bI/fY
 zr/r5wZCDHmuqG+gnNsmsqnKDsuDSQja481KOqYqVb2bTTHtIkBa69kFymiI+T+XYfwq
 jbh9p8CUxIT8ET3olZ7b3SIHvD77ewARjDNeKo6/j8N+y9RQ2YOM/SxAN2OpsDQLY8E4
 Nwv34YMUisJVbbZE8uJtB0SDC9eRLwzwIeGN7idYhF0ljtUYsfEGx5Js4VGDAjQWiKI4 Tg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3phxc2j9dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 05:14:31 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 27 Mar
 2023 05:14:29 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 27 Mar 2023 05:14:29 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4A7C4B06;
        Mon, 27 Mar 2023 10:14:29 +0000 (UTC)
Date:   Mon, 27 Mar 2023 10:14:29 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] ASoC: wm8903: implement DMIC support
Message-ID: <20230327101429.GT68926@ediswmail.ad.cirrus.com>
References: <20230325083643.7575-1-clamor95@gmail.com>
 <20230325083643.7575-2-clamor95@gmail.com>
 <20230327083208.GQ68926@ediswmail.ad.cirrus.com>
 <CAPVz0n1AaTzdwmfkxaUX5peAiQ2K73aoqKfLUy1jwEE6__uG2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n1AaTzdwmfkxaUX5peAiQ2K73aoqKfLUy1jwEE6__uG2w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: f3V4cmNTfEwP3xVtN6uAgmK1las7Or1l
X-Proofpoint-ORIG-GUID: f3V4cmNTfEwP3xVtN6uAgmK1las7Or1l
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:37:05AM +0300, Svyatoslav Ryhel wrote:
> пн, 27 бер. 2023 р. о 11:32 Charles Keepax <ckeepax@opensource.cirrus.com> пише:
> >
> > On Sat, Mar 25, 2023 at 10:36:43AM +0200, Svyatoslav Ryhel wrote:
> > > Add DMIC input and routing.
> > >
> > > Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF300T
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  sound/soc/codecs/wm8903.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
> > > index 41346e5ec5ad..9c2f0aadcff3 100644
> > > --- a/sound/soc/codecs/wm8903.c
> > > +++ b/sound/soc/codecs/wm8903.c
> > > @@ -9,7 +9,6 @@
> > >   *
> > >   * TODO:
> > >   *  - TDM mode configuration.
> > > - *  - Digital microphone support.
> > >   */
> > >
> > >  #include <linux/module.h>
> > > @@ -816,6 +815,7 @@ SND_SOC_DAPM_INPUT("IN2L"),
> > >  SND_SOC_DAPM_INPUT("IN2R"),
> > >  SND_SOC_DAPM_INPUT("IN3L"),
> > >  SND_SOC_DAPM_INPUT("IN3R"),
> > > +SND_SOC_DAPM_INPUT("DMIC"),
> > >  SND_SOC_DAPM_INPUT("DMICDAT"),
> >
> > There is already a datapath for the DMIC here, DMICDAT. Are you
> > sure you don't just need to set the "Left/Right ADC Input" muxes
> > correctly through the ALSA controls?
> >
> 
> I will check once more, but so far I was not able to set the mic to
> work with DMICDAT. Only with this patch.
> 

The two should be basically equivalent when the controls are set
right, your patch has:

DMIC -> ADCL

The current code has

DMIC -> Left ADC Input -> ADCL

The only difference is that Left ADC Input sets the ADC_DIG_MIC
bit, but the datasheet clearly indicates that should be
necessary for digital mics to work. Does your system definitely
have DMICs? Without that bit set the decimator should still be
connected to the analogue front end.

Thanks,
Charles
