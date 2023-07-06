Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8E17497CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjGFI4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjGFI4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:56:53 -0400
X-Greylist: delayed 583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Jul 2023 01:56:50 PDT
Received: from pi.fatal.se (andreasfatal-1-pt.tunnel.tserv3.fmt2.ipv6.he.net [IPv6:2001:470:1f04:f16::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E6FF1990
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:56:50 -0700 (PDT)
Received: by pi.fatal.se (Postfix, from userid 1000)
        id 49B302A8D9; Thu,  6 Jul 2023 10:47:06 +0200 (CEST)
Date:   Thu, 6 Jul 2023 10:47:06 +0200
From:   Andreas Henriksson <andreas@fatal.se>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hans =?iso-8859-1?Q?S=F6derlund?= <hans.soderlund@realbit.se>
Subject: Re: [PATCH] ASoC: fsl_sai: Enable MCTL_MCLK_EN bit for master mode
Message-ID: <20230706084706.bzwsbi3zisx5m5rl@fatal.se>
References: <1652963808-14515-1-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5DtpoH0dLDX3=Sv4UUpX_=66VEZPsJUWQNnYviApfMLKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DtpoH0dLDX3=Sv4UUpX_=66VEZPsJUWQNnYviApfMLKQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shengjiu, Fabio,

On Thu, May 19, 2022 at 10:23:06AM -0300, Fabio Estevam wrote:
> Hi Shengjiu,
> 
> On Thu, May 19, 2022 at 9:49 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
> 
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index fa950dde5310..dae16a14f177 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -437,6 +437,12 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
> >                                    FSL_SAI_CR2_DIV_MASK | FSL_SAI_CR2_BYP,
> >                                    savediv / 2 - 1);
> >
> > +       if (sai->soc_data->max_register >= FSL_SAI_MCTL) {
> 
> Isn't it a bit fragile to take this decision based on the number of
> SAI registers in the SoC?
> 
> What about adding a specific field in soc_data for such a purpose?

We've been working on an i.MX8MP where MCLK needs to be input and found
that this enables the MCLK as output despite not having set the
`fsl,sai-mclk-direction-output;` devicetree property in our DT.
Reverting the patch fixes the issues for us.

I have to say that the code comment made me a bit confused, but once
I found the commit message I understood why this code existed.
If this is really i.MX8MM specific maybe mention that in the code
comment and please make the code actually only trigger on i.MX8MM.
It seems to me like these all fulfill the current criteria:
imx7ulp, imx8mq, imx8mm, imx8mp, imx8ulp, imx93

Should I report this in bugzilla.kernel.org ?

Regards,
Andreas Henriksson
