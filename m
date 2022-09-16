Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B835BB373
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiIPUXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiIPUWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:22:49 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B31BB681
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 13:22:32 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-12c8312131fso3527410fac.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 13:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=v3BrS7Rz7kntccbyOzfd8KjEMV3TmXJaISmlDbTWi/4=;
        b=JgNDW+QU38DrEfW7FoPqv3j2012h3r5vknZDyH2M6qOB5QKkp7X7IeFL20vhhLSg+V
         WYGqGj2iummbw8X8zr3e+dCtOeHUydM3wB2U+bsRkydl4SmVBdPgWMyM1q/zBRWwZ2xj
         O8JIVtDdfd0oTLXpGLpF1fKLfh66nz7V7rv49l5Kp7+UeLIkuEwWTt0S7wrc0P0yphxU
         yOCcu1+xKA+RL9tDgMhtG4oNY2K3odFVqYgMW7gaMSs8OYGVNuaCpxTQuUhJ/gWA4HI3
         jmTYqCbcWq8muUJdP4ZfB52xPTGGv540hMGpNwbfzrmaPWMamCdYsZsF+w9/2KC8sFn3
         DNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=v3BrS7Rz7kntccbyOzfd8KjEMV3TmXJaISmlDbTWi/4=;
        b=cHk9W9EwiMecQPpXxXLsdLwDL5QmemROBHsFXoWvlI29kuI/G1zbqfX4HfYJ/vxqtP
         5u7RtP4LLyD4SrAD7qn8XBveYdXdt+an5vnCQDDNG3Vm+nztQrI+IlbDRcACc2YFTN63
         9SOwA9yHgi2ojZRIb13b/pR2mYmCzbnIQYB4Y8YI4JmKpOtdXq3qrn+bU6oa7j82pQZk
         lZrIXxcJQN+2OGw8DgeDZFT14FbHev8CBqsFoRieGfqvVZDvFeeFpcvH668VGvfi620p
         fL3ywGNVwXMrgsS/lP7hdxmb6a8AtWEeMGkP9njwN2rah0pxwEWxXJNljs9G5kNipq24
         x+xg==
X-Gm-Message-State: ACrzQf3XjUyTNqdLWBaYlaxciF5Lba190iN9BE03odRigF/cwIS64dIf
        xJclByObOMGFseWxHsqM/zmCLz0MFQfTQqi7V6I2FQ==
X-Google-Smtp-Source: AMsMyM48YcqFU24mts0RzS7kZXVz+phYvgRYnHKHAMvVrdiTKy3XEQdJUtL++HMR4OJA7LkgZuCcjeBdIlkbF8R7pQU=
X-Received: by 2002:a05:6870:95a4:b0:12a:fc0c:b748 with SMTP id
 k36-20020a05687095a400b0012afc0cb748mr3808019oao.182.1663359748395; Fri, 16
 Sep 2022 13:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220914142256.28775-1-ansuelsmth@gmail.com> <20220914142256.28775-3-ansuelsmth@gmail.com>
 <20220916191715.GA1079300-robh@kernel.org> <6324d1be.050a0220.9d842.7b47@mx.google.com>
 <CAA8EJprEQOsm4TxGWJYZo04D1PagT3QmhDdYQkEid-KSP-tpTw@mail.gmail.com> <6324d8e1.170a0220.aba35.ba4f@mx.google.com>
In-Reply-To: <6324d8e1.170a0220.aba35.ba4f@mx.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 16 Sep 2022 23:22:17 +0300
Message-ID: <CAA8EJpowLvkuiYupqS0WEhnMR8q=R1YUUFgdFVCAx1PXyoo1xw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] dt-bindings: arm: msm: Convert kpss-acc driver
 Documentation to yaml
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Marc Herbert <marc.herbert@intel.com>,
        James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sept 2022 at 23:13, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> On Fri, Sep 16, 2022 at 11:06:35PM +0300, Dmitry Baryshkov wrote:
> > On Fri, 16 Sept 2022 at 22:43, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > >
> > > On Fri, Sep 16, 2022 at 02:17:15PM -0500, Rob Herring wrote:
> > > > On Wed, Sep 14, 2022 at 04:22:53PM +0200, Christian Marangi wrote:
> > > > > Convert kpss-acc driver Documentation to yaml.
> > > > > The original Documentation was wrong all along. Fix it while we are
> > > > > converting it.
> > > > > The example was wrong as kpss-acc-v2 should only expose the regs but we
> > > > > don't have any driver that expose additional clocks. The kpss-acc driver
> > > > > is only specific to v1. For this exact reason, limit all the additional
> > > > > bindings (clocks, clock-names, clock-output-names and #clock-cells) to
> > > > > v1 and also flag that these bindings should NOT be used for v2.
> > > >
> > > > Odd that a clock controller has no clocks, but okay.
> > > >
> > >
> > > As said in the commit v2 is only used for regs. v2 it's only used in
> > > arch/arm/mach-qcom/platsmp.c to setup stuff cpu hotplug and bringup.
> > >
> > > Should we split the 2 driver? To me the acc naming seems to be just
> > > recycled for v2 and it's not really a clk controller.
> > >
> > > So keeping v2 in arm/msm/qcom,kpss-acc-v2.yaml and v1 moved to clock?
> >
> > I suspect that qcom,kpss-acc-v2 is misnamed as the "clock-controller".
> > According to msm-3.10, these regions are used by the Krait core
> > regulators.
> >
>
> Well we need to understand how to handle this... change the compatible
> it's a nono for sure. In platsmp.c they are used for cpu power control
> so could be that they are actually used to regulators. I would honestly
> move v1 to clock and leave v2 to arm/msm but I'm not cetain on what name
> to assign to the 2 yaml.
>
> What do you think?

This is fine for me. If somebody gets better understanding of
underlying hardware and works on actually using these blocks, he will
update the bindings.

My only suggestion would be to rename kpss-acc-v2 nodes to
'power-controller@address' and document them so.

-- 
With best wishes
Dmitry
