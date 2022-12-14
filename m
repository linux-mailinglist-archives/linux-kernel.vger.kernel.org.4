Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C265A64D188
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiLNU4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiLNU4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:56:01 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CDF1CFFE;
        Wed, 14 Dec 2022 12:55:59 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id DE4203F353;
        Wed, 14 Dec 2022 21:55:57 +0100 (CET)
Date:   Wed, 14 Dec 2022 21:55:56 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] arm64: dts: qcom: Use labels with generic node names
 for ADC channels
Message-ID: <20221214205556.jdbcv3e4fkvm7f3y@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209215308.1781047-1-marijn.suijten@somainline.org>
 <3d5b29f3-8d8d-93a7-a485-5261e2d8891d@linaro.org>
 <20221210165434.3hhen5mgtvflghks@SoMainline.org>
 <0bc1eba8-bc26-0bdb-16bf-78160c27c57b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bc1eba8-bc26-0bdb-16bf-78160c27c57b@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-12 09:48:26, Krzysztof Kozlowski wrote:
> On 10/12/2022 17:54, Marijn Suijten wrote:
> > On 2022-12-10 12:02:03, Krzysztof Kozlowski wrote:
> >> On 09/12/2022 22:53, Marijn Suijten wrote:
> >>> As discussed in [1] the DT should use labels to describe ADC
> >>> channels, with generic node names, since the IIO drivers now
> >>> moved to the fwnode API where node names include the `@xx`
> >>> address suffix.
> >>> 
> >>> Especially for the ADC5 driver that uses extend_name - which
> >>> cannot be removed for compatibility reasons - this results in
> >>> sysfs files with the @xx name that wasn't previously present, and
> >>> leads to an unpleasant file-browsing experience.
> >>> 
> >>> Also remove all the unused channel labels in pm660.dtsi.
> >>> 
> >>> [1]:
> >>> https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
> >>>
> >>>
> >>> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> >> 
> >> The talk was in context of bindings, not about changing all
> >> existing users thus affecting DTS.
> > 
> > And as a consequence, DTS.  The already-merged transition from OF to 
> > fwnode resulted in `@xx` to be included in the ADC channel name - and
> > in the case of ADC5 even in sysfs filenames - so this seems like a 
> > necessary change to make.
> > 
> > At the very least I would have changed the bindings submitted or 
> > co-authored /by myself/ since I initially decided to rely on this
> > (now obviously) wrong behaviour, and should have used labels from the
> > get go.
> > 
> >> What's more, to me "skin-temp-thermistor" is quite generic name,
> >> maybe "thermistor" would be more and reflects the purpose of the
> >> node, so it was more or less fine.
> > 
> > Are you suggesting to not use "adc-chan", but "thermistor" as node
> > name (and still use skin_temp as label)?
> 
> No, I am just saying that some of the names were correct, so the
> reasoning in commit msg is not entirely accurate.

The commit msg doesn't state that any of these names was wrong, rather
that the label property should be used to convey a name to the driver.

If you think multiple /node names/ are acceptable, please discuss in
that direction.  Do we use a predetermined set of names (adc-chan@xx,
thermistor@xx, ...) or do you have another suggestion?

> > Or to keep the fully-written-out "thermistor" word in the label?
> 
> No, I don't refer to labels. Labels don't matter, they are being removed
> entirely during DTS build.

Ugh, I knew this was becoming a problem, even in an earlier IIO
discussions with Jonathan it was sometimes hard to keep apart:

I am /not/ referring to DTS labels, but to the `label =` node
attribute/property, which is read by the driver (which isn't removed,
how else would the driver fish this value out at runtime...).

After all none of this patch has any DTS labels, in fact a bunch of
unused ones in pm660 have been removed... but this patch /does add/ the
`label =` property to many nodes.

> >> Anyway I am against such changes without expressing it in the
> >> bindings.
> > 
> > As expressed in [1] I suggested and am all for locking this change
> > in via bindings, and you are right to expect that to have gone paired
> > with this patch.
> 
> Yes, I expect such changes to have both binding and DTS change together.
> 
> > 
> > I'll submit that as the leading patch to this in v2, with the
> > wildcard pattern changed to adc-chan (or something else pending the
> > discussion above), and should I then also require the label property
> > via `label: true`?
> 
> I don't think label is required.

My commit message explains why the ADC5/VADC driver should really
receive a label property instead of using the node name.

- Marijn
