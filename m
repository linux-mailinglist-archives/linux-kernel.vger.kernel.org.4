Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCC8619A25
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiKDOgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiKDOep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:34:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1D83134A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:32:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sc25so13671775ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zPb3Ch5cQKo79npejowVrWhaxOj2flVSGSghaJJIM+U=;
        b=dxtrk433iz23cbIBt75tV4gk15B1zGxQLL7jAwlCmvFRrRA8zIaKb1GO5l5owsD0oW
         2km7HkCuXNWJFwFUBLl1swFXyGN5fQwIt/sK4B3tG18jBkFheLjAvGXAKH0BYcPpO+gr
         Q0hCfupY+PK7atfKqUKcXj18iOcd0/8IYVX/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPb3Ch5cQKo79npejowVrWhaxOj2flVSGSghaJJIM+U=;
        b=vfb5U3Yc9DGrHz+v8TBtOEFwwAfgxz+z0Y4N/JPXp0F8nY2DMS0Sim3gaQli+w0hTQ
         c62Meee6NW6X32Hbly37O2JscktAiGKU0O2t/jdWpGwv9oSSnbZW7DYw4rIioJbRWX4F
         1dbh8B9JLl2CDsKHIpOEyRYqkmFrffzDcJoPvbtBIjkV3qLWTLR+S6baOYm3w3oCyXgL
         UyQPWQ6Yi6pCxzVaXNO0xC9izl+1f8dFKQ4a+C63eHzLnydx35D6SRqbnv72NGnNPzlY
         46PhKfmxjBPeRHLXUGGAFO+8VpxjsDI488E2pAiUVE4+9cwkFL79k6lwyVlgFa48MuS2
         LeQA==
X-Gm-Message-State: ACrzQf0Cb35eUlwXFUThbXVAKoszUxltWgI178oFmCC0iQmm1r2Qo6/G
        yP+vbuL0Q7akARF7NYUDQRW2AaqmsD0eW4BH
X-Google-Smtp-Source: AMsMyM48bKdj5ntL22XBdtOMNcXQLzM1l9X0sUkqZnnz+ZH4WUVdUPcACUgS+Kn47kF6zE/UMh3Rmw==
X-Received: by 2002:a17:906:14d2:b0:7ad:be76:956f with SMTP id y18-20020a17090614d200b007adbe76956fmr30793043ejc.197.1667572353535;
        Fri, 04 Nov 2022 07:32:33 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id ec35-20020a0564020d6300b00458dc7e8ecasm2003666edb.72.2022.11.04.07.32.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 07:32:29 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id bk15so7266009wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:32:28 -0700 (PDT)
X-Received: by 2002:adf:d1ec:0:b0:236:880f:2adf with SMTP id
 g12-20020adfd1ec000000b00236880f2adfmr22994810wrd.617.1667572348631; Fri, 04
 Nov 2022 07:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221104061941.2739938-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20221104141515.v10.3.I3ac715e729f6f9b5a3e3001b155df4f9d14e6186@changeid>
 <139c06eb-14b8-10b5-80b7-ba8ec8579846@somainline.org> <CAD=FV=VwP_s5y0MVNLs+WGD_=nJtJe7h=n+Xu4Ky5RvgdkAw9Q@mail.gmail.com>
 <b6e8da04-f5bf-8e27-e4b7-3854d4168a08@somainline.org>
In-Reply-To: <b6e8da04-f5bf-8e27-e4b7-3854d4168a08@somainline.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 4 Nov 2022 07:32:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xsd6Do_RGN-F_Ef0uxBOqERNGUjme9nCE6Xu49kTOzcw@mail.gmail.com>
Message-ID: <CAD=FV=Xsd6Do_RGN-F_Ef0uxBOqERNGUjme9nCE6Xu49kTOzcw@mail.gmail.com>
Subject: Re: [PATCH v10 3/4] arm64: dts: qcom: sc7280: Add touchscreen and
 touchpad support for evoker
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 4, 2022 at 7:28 AM Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
>
> On 04/11/2022 15:25, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Nov 4, 2022 at 2:35 AM Konrad Dybcio
> > <konrad.dybcio@somainline.org> wrote:
> >>
> >> On 04/11/2022 07:19, Sheng-Liang Pan wrote:
> >>> Change touchpad and touchscreen node for evoker
> >>> Touchpad: SA461D-1011
> >>> Touchscreen: GT7986U
> >> What's the reasoning? Were they changed post r0? Is r0 support
> >> effectively dropped?
> >>
> >> The changes look ok, but I feel like this needs more of a comment in the
> >> commit msg.
> > As I understand it r0's toucscreen/touchpad were not right to start
> > with. We are moving towards getting things upstream sooner and that
> > means that hardware hasn't always been fully tested out.
> >
> > I certainly wouldn't object to a better commit message here, but in
> > this case there are no real world users (yet) and thus nobody is
> > really affected by this churn. ...so IMO if the series needs to be
> > spun for some other reason then the commit message could be updated,
> > but I wouldn't object to it landing as-is either.
>
> If there are no real (read: not-an-internal-devboard) devices using it,
> then I
>
> agree, it's fine to merge as-is.

I can confirm that. There are no evoker devices in the wild.

-Doug
