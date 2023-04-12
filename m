Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DC26DFFE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjDLUbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjDLUbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:31:50 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751FA1BD1;
        Wed, 12 Apr 2023 13:31:49 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 86034203C2;
        Wed, 12 Apr 2023 22:31:47 +0200 (CEST)
Date:   Wed, 12 Apr 2023 22:31:46 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 5/5] dt-bindings: iio: adc: Require generic `channel`
 name for channel nodes
Message-ID: <c653un4emxud34gpo5np7jtnhsym5thpivjwcgpm2vsft2q2qj@s66thxonibjc>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>, 
        Jonathan Cameron <jic23@kernel.org>, phone-devel@vger.kernel.org, 
        ~postmarketos/upstreaming@lists.sr.ht, 
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
        Martin Botka <martin.botka@somainline.org>, Jami Kettunen <jami.kettunen@somainline.org>, 
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Andy Gross <agross@kernel.org>, 
        Bjorn Andersson <andersson@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
        linux-arm-msm@vger.kernel.org
References: <20230410202917.247666-1-marijn.suijten@somainline.org>
 <20230410202917.247666-6-marijn.suijten@somainline.org>
 <20230412212756.0b4b69f3@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412212756.0b4b69f3@jic23-huawei>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-12 21:27:56, Jonathan Cameron wrote:
> On Mon, 10 Apr 2023 22:29:17 +0200
> Marijn Suijten <marijn.suijten@somainline.org> wrote:
> 
> > As discussed in [1] it is more convenient to use a generic `channel`
> > node name for ADC channels while storing a friendly - board-specific
> > instead of PMIC-specific - name in the label, if/when desired to
> > overwrite the channel description already contained (but previously
> > unused) in the driver [2].
> > 
> > The same `channel` node name pattern has also been set in
> > iio/adc/adc.yaml, but this generic binding is not inherited as base for
> > qcom,spmi-vadc bindings due to not having any other generic elements in
> > common, besides the node name rule and reg property.
> > 
> > Replace the .* name pattern with the `channel` literal, but leave the
> > label property optional for bindings to choose to fall back a channel
> > label hardcoded in the driver [2] instead.
> > 
> > [1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
> > [2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/
> > 
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> 
> There are various ways we could pick up this patch set...
> a) Binding changes via individual subsystem trees,
> b) All in on go.
> 
> I think it's late to guarantee to land the changes from (a) in the coming merge window
> so if someone else is willing to do (b) then
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Otherwise we can do (a) early in next cycle.  Feel free to poke me if we are doing (b)
> and I seem to have forgotten to pick up this patch!

Thanks!  I hope we don't get many conflicts (+ new bindings adhering to
the old(er) formats) otherwise I'll resend if we do (a).  Around what
time would be good, rc2?

[..]

- Marijn
