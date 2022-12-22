Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3B56548A4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 23:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbiLVWkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 17:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbiLVWj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 17:39:58 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2CB2A264
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:39:47 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vm8so1312622ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GxWSGy5iPaiw7MEacI+Gai7opEjaW9K8jMS508awnwk=;
        b=n42M/zVFItZBhWdr9DtPpt8AZd/lLNCZGo0cdXL0gNd+iBBA4VijjzKvu8mNhRZA1O
         lrN7y7OGrEz7F8SLCJTecma1d4SRhlerXY18scj6UDajrDqeIrud/larhPCa/6zzOzsy
         oRAhw1xMqaPJAZO30Vpv0ywzgQ5e6VD2ZUyHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxWSGy5iPaiw7MEacI+Gai7opEjaW9K8jMS508awnwk=;
        b=TuD0gQbiOX1JSQca59QOa7GB1RgBDcuDgtse2SRN0SydkCB5cJ7Sj4NBg6kQ/S42mE
         LBqKaU6s7LPlK2z+RA4tRbcfnEoHtvTz8RuE8yp1umUH1cHs8avJ5JXarY6gpJBR9V0+
         Dqacp+XxkRXkwQuEGS8ckjfcD4y3dVZrbZiGpieG7binfIkSEwGwYvr+uHty/CWxJeTg
         kr5rwJvl9pKFYptSwR+sQ11z/P3VeAn8m9Svx500rQXOn7LTKPeytNsNeAeAye0YX6j6
         oN82EC9SiB4rtUCJS7s104EWEWYTmJ1nkiHLaMRhC++iVJZUMtLkErM5c6nc++mv2H2T
         7Stw==
X-Gm-Message-State: AFqh2kpTL758+OM1JozhQ3HaQhJ6pogdAVkgll2rNltXc282Ky+Rhmu4
        XKsnHiJTFq7F+j4aPZazB2UY+vUNjNch17kcvAQ=
X-Google-Smtp-Source: AMrXdXtQZwy2h2h7q82xxrXe8gwzYVEG0vmIbMW4aRRqoSdAkXFIfDg0+o75+69LnkpcrBd1NtWM6g==
X-Received: by 2002:a17:906:9c96:b0:7c1:1c5:c7cd with SMTP id fj22-20020a1709069c9600b007c101c5c7cdmr5952930ejc.5.1671748785436;
        Thu, 22 Dec 2022 14:39:45 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id ku22-20020a170907789600b007c10d47e748sm695923ejc.36.2022.12.22.14.39.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 14:39:43 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id o5so3060614wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:39:43 -0800 (PST)
X-Received: by 2002:a5d:6449:0:b0:242:1f80:6cd9 with SMTP id
 d9-20020a5d6449000000b002421f806cd9mr294465wrw.405.1671748782971; Thu, 22 Dec
 2022 14:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20221215224552.1232449-1-elder@linaro.org> <Y5vDXm4oo2cn3etX@google.com>
In-Reply-To: <Y5vDXm4oo2cn3etX@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 22 Dec 2022 14:39:29 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XsUXCzjKbLvOd7M-CPQi13pf9dvpvLwLQnsoL0m-5xCQ@mail.gmail.com>
Message-ID: <CAD=FV=XsUXCzjKbLvOd7M-CPQi13pf9dvpvLwLQnsoL0m-5xCQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: enable IPA in sc7280-herobrine-lte-sku.dtsi
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alex Elder <elder@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, agross@kernel.org,
        quic_sibis@quicinc.com, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 15, 2022 at 5:01 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Thu, Dec 15, 2022 at 04:45:52PM -0600, Alex Elder wrote:
>
> > Subject: arm64: dts: qcom: sc7280: enable IPA in sc7280-herobrine-lte-sku.dtsi
>
> nit: that sounds as if IPA wasn't enabled previously. It would be
> clearer to say something like: "sc7280: only enable IPA for boards
> with a modem".
>
> > IPA is only needed on a platform if it includes a modem, and not all
> > SC7280 SoC variants do.  The file "sc7280-herobrine-lte-sku.dtsi" is
> > used to encapsulate definitions related to Chrome OS SC7280 devices
> > where a modem is present, and that's the proper place for the IPA
> > node to be enabled.
> >
> > Currently IPA is enabled in "sc7280-idp.dtsi", which is included by
> > DTS files for Qualcomm reference platforms (all of which include the
> > modem).  That also includes "sc7280-herobrine-lte-sku.dtsi", so
> > enabling IPA there would make it unnecessary for "sc7280-idp.dtsi"
> > to enable it.
> >
> > The only other place IPA is enabled is "sc7280-qcard.dtsi".
> > That file is included only by "sc7280-herobrine.dtsi", which
> > is (eventually) included only by these top-level DTS files:
> >   sc7280-herobrine-crd.dts
> >   sc7280-herobrine-herobrine-r1.dts
> >   sc7280-herobrine-evoker.dts
> >   sc7280-herobrine-evoker-lte.dts
> >   sc7280-herobrine-villager-r0.dts
> >   sc7280-herobrine-villager-r1.dts
> >   sc7280-herobrine-villager-r1-lte.dts
> > All of but two of these include "sc7280-herobrine-lte-sku.dtsi", and
> > for those cases, enabling IPA there means there is no need for it to
> > be enabled in "sc7280-qcard.dtsi".
> >
> > The two remaining cases will no longer enable IPA as a result of
> > this change:
> >   sc7280-herobrine-evoker.dts
> >   sc7280-herobrine-villager-r1.dts
> > Both of these have "lte" counterparts, and are meant to represent
> > board variants that do *not* have a modem.
> >
> > This is exactly the desired configuration.
> >
> > Signed-off-by: Alex Elder <elder@linaro.org>
> > Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
> > Tested-by: Sibi Sankar <quic_sibis@quicinc.com>
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

I'd agree that the subject like proposed by Matthias sounds better. In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
