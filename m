Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5915724BC5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbjFFSvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjFFSvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:51:39 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A9F83;
        Tue,  6 Jun 2023 11:51:38 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3250454a12.2;
        Tue, 06 Jun 2023 11:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686077498; x=1688669498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YYoN+BjvypDqZwnJUA2wNs3qIHtM6mWEZbL6vyyf8sk=;
        b=d4rlQ70qmUGltZIPyCpiSijL34I/olvA0KKx3Hdr8aRjnOEinZN0Byx4K76Y3Bc+4n
         piOrwlnK188L804WcuU1PbVx+CFp+T0782GSBE6DSyZcGtn02n6wSF2dMSvDSG29NA8Y
         GvZ770rxkddEqvAmL1mdsmTzS4YCRY5g+rg1IwwNxi5VRlPr/+0DQdz5iBO6AuPvwuDZ
         uiJhAIeo4c+hy5eSf44gAYZIFzONxDM+WcxsZukBgs37CDYq/afSpNZpRg1qR7UizgvP
         tRaxvpAKNCTMZuWw1OhKbiNwE9Ltl30Hb908UMGzMvhNJIsJnHimKpVi6I571ZoZTIYt
         Jxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686077498; x=1688669498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYoN+BjvypDqZwnJUA2wNs3qIHtM6mWEZbL6vyyf8sk=;
        b=R6WqMx8j4WBNZ6mVKb9zQ70YYqA0O911IRqWdA68CHfo9J0RnM0fRsrXkGxOOOFKFc
         76Vj0W8RXsrJVaMWXiCA/uDEWDYFR2Gugh3BdGN5MEkl/z3nxdmlLhJvEXWWv96WYbhy
         k4rMbXc/BTnilzSmlSNoKEdSSy3ItAlgHwI6f5zzNfXsYxJl6TjBqzO7sAfEhZqzsAFk
         pPVIKpRfIWT4MUGt/01Mlk35jI1D6PCvnhv8hDD9tKubqs1koP+imSAZ1x2WEVhK3jxo
         SKfYx3KsxveN0WyTe6UVYgtmvgtOghE9wXWgXilIKVUNiHV0x2gOpfsvPf8G1jubVzGm
         Ei5A==
X-Gm-Message-State: AC+VfDzFJ08XJHzhrRd9fmypBGAo2zZAQZKPjTps5/yHndG/NMA1TCXp
        d3Ewp57AFHgZspw4c/Db6IM=
X-Google-Smtp-Source: ACHHUZ6ApCnfOC97z64/LMNRaYpxOSh3qgluo+n6oOHo6neOVm5jl6dGkGUNAaFhnF4b2cK3f3M9cw==
X-Received: by 2002:a05:6a20:3944:b0:106:c9b7:c932 with SMTP id r4-20020a056a20394400b00106c9b7c932mr507447pzg.1.1686077498264;
        Tue, 06 Jun 2023 11:51:38 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f59e:5ad5:28cc:2003])
        by smtp.gmail.com with ESMTPSA id a12-20020a1709027d8c00b0019a6cce2060sm8868681plm.57.2023.06.06.11.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 11:51:37 -0700 (PDT)
Date:   Tue, 6 Jun 2023 11:51:34 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: input: touchscreen: Add ilitek 9882T
 touchscreen chip
Message-ID: <ZH+ANlOaPH2nkZPT@google.com>
References: <20230605060524.1178164-1-yangcong5@huaqin.corp-partner.google.com>
 <20230605060524.1178164-2-yangcong5@huaqin.corp-partner.google.com>
 <6818f4b0-4222-c3bb-c55f-bc0d26d7a681@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6818f4b0-4222-c3bb-c55f-bc0d26d7a681@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 12:34:54PM +0200, Krzysztof Kozlowski wrote:
> On 05/06/2023 08:05, Cong Yang wrote:
> > Add an ilitek touch screen chip ili9882t.
> > 
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > ---
> >  .../bindings/input/elan,ekth6915.yaml         | 23 ++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> > index 05e6f2df604c..f0e7ffdce605 100644
> > --- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> > +++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> > @@ -15,11 +15,14 @@ description:
> >  
> >  properties:
> >    compatible:
> > -    items:
> > -      - const: elan,ekth6915
> > +    enum:
> > +      - elan,ekth6915
> > +      - ilitek,ili9882t
> >  
> >    reg:
> > -    const: 0x10
> > +    enum:
> > +      - 0x10
> > +      - 0x41
> >  
> >    interrupts:
> >      maxItems: 1
> > @@ -29,11 +32,13 @@ properties:
> >  
> >    vcc33-supply:
> >      description: The 3.3V supply to the touchscreen.
> > +                 If using ili9882t then this supply will not be needed.
> 
> What does it mean "will not be needed"? Describe the hardware, not your
> drivers.

I do not think it makes sense to merge Ilitek and Elan into a single
binding. The only thing that they have in common is that we are trying
to reuse drivers/hid/i2c-hid/i2c-hid-of-elan.c to handle reset timings
(which is also questionable IMO).

Maybe if we had a single unified binding for HID-over-I2C touchscreens
then combining would make more sense, at least to me...

Thanks.

-- 
Dmitry
