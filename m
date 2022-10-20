Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D056068E2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 21:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJTTa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 15:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJTTa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 15:30:56 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F121A6533;
        Thu, 20 Oct 2022 12:30:51 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1olbFY-0005rT-9N; Thu, 20 Oct 2022 21:30:40 +0200
Date:   Thu, 20 Oct 2022 20:30:37 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: mediatek,mt2701-auxadc: new
 32k clock
Message-ID: <Y1Gh3TQOznz3dmSJ@makrotopia.org>
References: <f98ed7f3fc15a0614443a57427d46ce17ec2e0cc.1666190235.git.daniel@makrotopia.org>
 <dbe88fd2f7ea5b2f419dce6ecb48c20e96e2e634.1666190235.git.daniel@makrotopia.org>
 <b33b9d2a-f6d5-b2a7-bcb8-1ed2303c04b4@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b33b9d2a-f6d5-b2a7-bcb8-1ed2303c04b4@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:28:02AM +0200, AngeloGioacchino Del Regno wrote:
> Il 19/10/22 16:38, Daniel Golle ha scritto:
> > Newer MediaTek SoCs need an additional clock to be brought up for
> > AUXADC to work. Add this new optional clock to
> > mediatek,mt2701-auxadc.yaml.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >   .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml          | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> > index 7f79a06e76f596..c2a1813dd54152 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> > @@ -44,10 +44,14 @@ properties:
> >       maxItems: 1
> >     clocks:
> > -    maxItems: 1
> > +    maxItems: 2
> > +    minItems: 1
> >     clock-names:
> > -    const: main
> > +    items:
> > +      - const: main
> > +      - const: 32k
> 
> You're adding this for MT7986, and I don't see any 32KHz ADC clock on that SoC.
> I suppose that your '32k' clock is CLK_INFRA_ADC_FRC_CK, currently parented to
> 'csw_f26m_sel', so that's 26MHz, not 32KHz.
> 
> Since you'll need the same changes for thermal as well, I would consider setting
> "infra_adc_frc" as a parent of "infra_adc_26m", like so:
> 
> 	GATE_INFRA1(CLK_INFRA_ADC_26M_CK, "infra_adc_26m", "infra_adc_frc", 20),
> 	GATE_INFRA1(CLK_INFRA_ADC_FRC_CK, "infra_adc_frc", "csw_f26m_sel", 21),
> 
> ...just because there's apparently no reason to have one of them enabled but not
> the other or, at least, it looks like we *always* need ADC_26M_CK enabled when
> ADC_FRC_CK is enabled.
> 

Yes, this change is for MT7986 and MT7981, immitating the behavior
found in MediaTek's SDK sources. Embedding the dependency into the
clock driver as you have suggested should also be possible as it is
true that you always need them both and a similar change for the
thermal driver would be needed as well.

Unless you were planning to do so already I will send a patch with your
suggested change to drivers/clk/mediatek/clk-mt7986-infracfg.c.
In any case, this series can be dropped then.

Thank you for the review!


Cheers


Daniel


> Regards,
> Angelo
