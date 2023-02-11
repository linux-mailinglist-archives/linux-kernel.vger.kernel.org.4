Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4DD692F5A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 09:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBKIWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 03:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKIWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 03:22:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6EA32CEE;
        Sat, 11 Feb 2023 00:22:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3728CB826F4;
        Sat, 11 Feb 2023 08:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1353C433EF;
        Sat, 11 Feb 2023 08:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676103730;
        bh=VjfrVywhWVOc5qMWdRaXTWEa/MMiNLZ2RP3B/Cr/ZZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fY5aqVl7vQVZVnOp8lIDN6/ocu+bSewgkrQ1/o8JvR+ABBIE4ATjlGRbOppoqfe2m
         uNIam/wqV7edBftZniiRcpOwAziS3EW0z1Vy63mgrq9UIT59efM+eFHQlyTN1SDbO7
         v7tCd/aFQbOMdIIp/r0H/u3MzTgKfarQ9g/MsxoFj1VK90uXVRz5f2gUjK9Uma6CIr
         AjsAtPXMP3hAJbGS6rlT76QWLp1uYuImishE2ChQ9MCzY70ZpdJYhT5/kmYgoqR9Pq
         g+TgK1+mgIjch+xX+nyEQYJJrluWG/zMVYANVdOBEq5T91MKpszKlnoM/h0RHVPm2w
         WeBO0sYvHhDLA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pQl9q-0007GT-3R; Sat, 11 Feb 2023 09:22:54 +0100
Date:   Sat, 11 Feb 2023 09:22:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 16/22] dt-bindings: rtc: qcom-pm8xxx: add nvmem-cell
 offset
Message-ID: <Y+dQXlABqc/uzIXc@hovoldconsulting.com>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
 <20230202155448.6715-17-johan+linaro@kernel.org>
 <Y+bJqIpgZ0fbzL2b@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+bJqIpgZ0fbzL2b@mail.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 11:48:08PM +0100, Alexandre Belloni wrote:
> On 02/02/2023 16:54:42+0100, Johan Hovold wrote:
> > On many Qualcomm platforms the PMIC RTC control and time registers are
> > read-only so that the RTC time can not be updated. Instead an offset
> > needs be stored in some machine-specific non-volatile memory, which a
> > driver can take into account.
> > 
> > Add an 'offset' nvmem cell which can be used to store a 32-bit offset
> > from the Unix epoch so that the RTC time can be updated on such
> > platforms.
> > 
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  .../devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml     | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
> > index 21c8ea08ff0a..b95a69cc9ae0 100644
> > --- a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
> > +++ b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
> > @@ -40,6 +40,16 @@ properties:
> >      description:
> >        Indicates that the setting of RTC time is allowed by the host CPU.
> >  
> > +  nvmem-cells:
> > +    items:
> > +      - description:
> > +          four-byte nvmem cell holding a little-endian offset from the Unix
> > +          epoch representing the time when the RTC timer was last reset
> > +
> > +  nvmem-cell-names:
> > +    items:
> > +      - const: offset
> > +
> >    wakeup-source: true
> 
> The patch doesn't apply because this part of the context is not
> upstream. Can you rebase?

Ah, sorry about that. That's because of commit 51b3802e7960
("dt-bindings: rtc: qcom-pm8xxx: allow 'wakeup-source' property") which
is now in Linus's tree (and your rtc-fixes branch).

Do you still want me to rebase or do you prefer to handle the conflict
some other way?

Johan
