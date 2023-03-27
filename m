Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BC26CA7C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjC0Ocu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjC0Ocs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:32:48 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B340319B9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:32:41 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-54184571389so174013177b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679927561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oZWYt2A1/xegsDaR9fdcxpuR4sCQsiDX1CHwh3kGLtI=;
        b=aFlzEpm3jS5c8Qt8xlwCGn9pcvUmoRnZQXEwcDzfRk2NX/Ad+4ieeQgIf+Ly12IAJV
         gW3CfuVrLZXDlf3+lzbkpm0IW+sqoIcR/I9vNWRsL4ZCNQLNc3QP4OwqF7ixJNo2+1HM
         ncRWqrVZpHahKE+KObjsVch8rSd0ya95mMao8jpoInJFlOz1UKbNDv8XqapeVq/jvCft
         ZDt23UJUjworIWWsJ76H+FdLBRUDrPfarccUMRBH/Q/EjUAFJMG/i+Yqq0XcTrPRs3rV
         Iyc4HgsncEKgKoS734APuWVIL69jCnwqHNMp6NPYVR+VdFM/Sc1W+OkqsUYSGqSVKDu/
         Nzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679927561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZWYt2A1/xegsDaR9fdcxpuR4sCQsiDX1CHwh3kGLtI=;
        b=QwhGNtkm7OSlXj0ZqrwllE944g/Aw2TK4wDXyn8RGG3Eq/AFB0fo04Lu1kFJcFlohP
         E3/rSBp20tzlcP/ajXfIYKOeeLeme+YLoXTxrDR7rVkcsaxkYlJl5MyfxmUdyPBt0AS6
         vKfwhbAx5EUVAjzid9nyVWyBP+Op+Fxe/81Hf5VpUQJX7PLUMFTzWaZWnaGWYbY9PzbG
         HN1zlEBUdk4cghKHuUFf0pudqeoqtg7qVZZ7xitAO4oeMQ+PzLsewTckP40B8kmLc1Z5
         u84fpXBHY3fAPTv3eoNvtuBL8he18jQYZOY7K7d+DhdAe8KK8F0/cyUtVAfKaP95cT4g
         J8vg==
X-Gm-Message-State: AAQBX9dA0kOCnEEegL7f/12Rau2RI2uW0GOjb3UW/AD4yeFpkFRSZIZW
        UeGDjejrHnb5KJ60IUgQCX9ot116cKxetb0v6iLa9A==
X-Google-Smtp-Source: AKy350YGL//ko0YOoMJn0yEBqBZM1OBbm7i8Gh3XLiKPeHWOd4Tug/7//ICczuY6fpZH922jDtuTVP3l2J/SHPOrcPc=
X-Received: by 2002:a05:690c:3:b0:541:698b:7bdb with SMTP id
 bc3-20020a05690c000300b00541698b7bdbmr4131051ywb.2.1679927560837; Mon, 27 Mar
 2023 07:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230325134410.21092-1-me@dylanvanassche.be> <20230325134410.21092-2-me@dylanvanassche.be>
 <883c3c48-c6e5-556d-431f-e92592b9106a@linaro.org> <b75b92bf64b55ba0ace0fbff65955c838a294dec.camel@dylanvanassche.be>
 <44904ffc-83d4-1137-3479-737a81b31d16@linaro.org> <1f3fb4bd5387c8d69a6eb068fb773b9273081c13.camel@dylanvanassche.be>
In-Reply-To: <1f3fb4bd5387c8d69a6eb068fb773b9273081c13.camel@dylanvanassche.be>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 27 Mar 2023 17:32:30 +0300
Message-ID: <CAA8EJprxn6LSDu3NV8r0pFr1pc+zRydoyOdJ2y6VRN3zZ8a52g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: misc: qcom,fastrpc: add
 qcom,assign-all-memory property
To:     Dylan Van Assche <me@dylanvanassche.be>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 at 17:27, Dylan Van Assche <me@dylanvanassche.be> wrote:
>
> Hi Krzysztof,
>
> On Mon, 2023-03-27 at 14:22 +0200, Krzysztof Kozlowski wrote:
> > On 27/03/2023 13:37, Dylan Van Assche wrote:
> > > Hi Krzysztof,
> > >
> > > On Sun, 2023-03-26 at 10:55 +0200, Krzysztof Kozlowski wrote:
> > > > On 25/03/2023 14:44, Dylan Van Assche wrote:
> > > > > Document the added qcom,assign-all-memory in devicetree
> > > > > bindings.
> > > > >
> > > > > Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 6
> > > > > ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> > > > > b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> > > > > index 1ab9588cdd89..fa5b00534b30 100644
> > > > > --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> > > > > +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> > > > > @@ -57,6 +57,12 @@ properties:
> > > > >        Virtual machine IDs for remote processor.
> > > > >      $ref: "/schemas/types.yaml#/definitions/uint32-array"
> > > > >
> > > > > +  qcom,assign-all-mem:
> > > > > +    description:
> > > > > +      Assign memory to all Virtual machines defined by
> > > > > qcom,vmids.
> > > >
> > > > This (neither commit msg) does not explain why this is needed and
> > > > actually does not sound like hardware-related property.
> > >
> > > This is made a separate property to toggle different behavior in
> > > the
> > > driver if it is needed for some FastRPC nodes.
> >
> > Bindings are not for driver behavior.
> >
> > > Downstream does guard
> > > this with a property 'restrict-access' as well, see [1] for a
> > > random
> > > SDM845 downstream kernel. On SDM845, this property is not present,
> > > thus
> > > the IF block runs. On SDM670, this property is present, then the IF
> > > block is skipped. That's why I opt for this property to have this
> > > behaviour conditionally. I'm not sure how to explain it better
> > > though.
> >
> > Still you described driver... Please come with something more
> > hardware
> > related.
>
> So just updating the description is enough then?
>
> As this is all reverse engineered, I have no access to the
> documentation of FastRPC, so best effort:

Vendor kernels put a lot of controls into DT, despite some of these
controls being related to software or being a platform constant.
Upstream tends to push some of the constraints into the driver data,
leaving only variadic parts in DT.
Could you please check if the property you are proposing is constant
among the devices on a platform or not. If it is a platform
peculiarity, a usual way is to add it to driver data rather than the
DT.

>
> """
> Mark allocated memory region accessible to remote processor.
> This memory region is used by remote processor to communicate
> when no dedicated Fastrpc context bank hardware is available
> for remote processor.
> """
>
> Is this the description that is 'more hardware related'?

-- 
With best wishes
Dmitry
