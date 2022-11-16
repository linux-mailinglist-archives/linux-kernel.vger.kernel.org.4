Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B7562C08A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiKPOIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiKPOGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:06:50 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F9D4FF9D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:01:43 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 1627C3F308;
        Wed, 16 Nov 2022 15:01:41 +0100 (CET)
Date:   Wed, 16 Nov 2022 15:01:39 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] docs: dt: writing-schema: Document usage of CHECK_DTBS
 make flag
Message-ID: <20221116140139.gjfsgekz4t4pxekz@SoMainline.org>
References: <20221102214300.309347-1-nfraprado@collabora.com>
 <20221116135504.mdmgm6ce2cynt5yt@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221116135504.mdmgm6ce2cynt5yt@SoMainline.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Konrad and Dmitry whom I discussed this with before.

On 2022-11-16 14:55:04, Marijn Suijten wrote:
> Hi Nícolas,
> 
> On 2022-11-02 17:43:00, Nícolas F. R. A. Prado wrote:
> > It is possible to run checks on a Devicetree by passing the CHECK_DTBS
> > flag when building. This is a useful shortcut to the dtbs_check make
> > target since it avoids checking unrelated Devicetrees, which can take
> > some time and is unnecessary if no bindings were modified. Document it.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > ---
> > 
> >  Documentation/devicetree/bindings/writing-schema.rst | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
> > index 4a381d20f2b4..55ad556472b4 100644
> > --- a/Documentation/devicetree/bindings/writing-schema.rst
> > +++ b/Documentation/devicetree/bindings/writing-schema.rst
> > @@ -167,6 +167,13 @@ setting the ``DT_SCHEMA_FILES`` variable to a specific schema file or pattern.
> >      make dt_binding_check DT_SCHEMA_FILES=/gpio/
> >      make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
> >  
> > +Note that ``make dtbs_check`` will validate every DT source file that is
> > +enabled. When making changes to a DT but not to the bindings, a possible
> > +shortcut to validate only the DT in question is to explicitly build it with
> > +the ``CHECK_DTBS`` flag enabled. For example::
> > +
> > +    make CHECK_DTBS=y mediatek/mt8192-evb.dtb
> 
> I have a bit of trouble getting this to work on a _clean_ out directory
> (perhaps this should have been reported at the original patch, I had
> always been using Dmitry's version [1] which didn't suffer from this
> problem).
> 
> Consider running with the following:
> 
>     rm out -r
>     make ARCH=arm64 O=out defconfig
>     make ARCH=arm64 O=out CHECK_DTBS=y qcom/sm8450-sony-xperia-nagara-pdx223.dtb
> 
> After compiling preliminaries, it exits with:
> 
>     make[3]: *** No rule to make target 'arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dtb'.  Stop.
>     make[2]: *** [../scripts/Makefile.build:500: arch/arm64/boot/dts/qcom] Error 2
>     make[1]: *** [/kernel/Makefile:1460: qcom/sm8450-sony-xperia-nagara-pdx223.dtb] Error 2
>     make[1]: Leaving directory '/kernel/out'
>     make: *** [Makefile:231: __sub-make] Error 2
> 
> However, if I lint all DTBs first by running `dtbs_check`, it seems the
> schema preliminaries are built:
> 
>       LINT    Documentation/devicetree/bindings
>       CHKDT   Documentation/devicetree/bindings/processed-schema.json
>     ... bunch of warnings
>       SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> 
> And here I ctrl+c the build so that it doesn't run DTC_CHK over every
> dts.  If I now re-run the original command on my .dtb of choice, it
> completes successfully with the warnings that I expect.  Is the logic
> behind `CHECK_DTBS=y` simply missing a step to make sure SCHEMA is built
> and up-to-date?
> 
> Aside from not working in a clean output directly, could this imply
> schema changes (edits in Documentation/devicetree/bindings) _are not_
> propagated when running with `CHECK_DTBS=y?
> 
> At the same time running this command twice results in no output the
> second time around, supposedly because the dtb has "already been built".
> Is that also something we can improve?
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20220623144357.297252-1-dmitry.baryshkov@linaro.org/
> 
> Thanks!
> - Marijn
> 
