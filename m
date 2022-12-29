Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97BE659243
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 22:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiL2Vll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 16:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiL2Vli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 16:41:38 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7F310046;
        Thu, 29 Dec 2022 13:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1672350091;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=FCYu/+2jwjS7Uakcb1o/IFHjx95os9NV5cCdt0qqmk8=;
    b=KHZEnWSD93VHbRpn+w8cWpmVwvFEi0phNEmA+U/yDBBm/sFOOw9waFX5bRGoUBykfJ
    ZYy018apK3SS3Vv75pqE5DPIBwwuexceGl1dT9EM0qFuR3rD3x0xR1FoJLvFe5wDRHDX
    KWwki68lyyzmD+w2h3WsFXDbsE4D01P9TGyzVekZHg7SBuBUkLd3BY2QvwkMpgBPWhUR
    k0tsy4hDeBCzondU4TAfqAgLji187irI5e1jAHFcpenKmspGKb0r3OTdFdCP30WGQiWP
    lHX3HstFw5DcblnKS6JqpLhH4MiKfQf96qIb3WnTzqF2irDAi5dHaED0tpgrUsdXsb63
    XDPw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWyvDI"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id Yce349yBTLfTXsA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 29 Dec 2022 22:41:29 +0100 (CET)
Date:   Thu, 29 Dec 2022 22:41:22 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] phy: qcom-usb-hs: Add qcom,dp-manual-pullup logic
Message-ID: <Y64Jgu2o6aJV4ggk@gerhold.net>
References: <20221229183410.683584-1-bryan.odonoghue@linaro.org>
 <20221229183410.683584-3-bryan.odonoghue@linaro.org>
 <Y63uSgMdP4m6nvhL@gerhold.net>
 <Y64AfHcUw192Pyr6@gerhold.net>
 <6061938c-b830-2fe0-2f4d-368e34c33676@linaro.org>
 <Y64CaOzWZXERrvkz@gerhold.net>
 <cdcef656-1ae7-fe8a-a4dd-3547d6395b33@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdcef656-1ae7-fe8a-a4dd-3547d6395b33@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 09:20:03PM +0000, Bryan O'Donoghue wrote:
> On 29/12/2022 21:11, Stephan Gerhold wrote:
> > Then it doesn't seem to be a particularly complete schematic. 😄
> > PM8916 definitely has USB_IN pads (pad # N13, P13). 😄
> 
> Let me check again.
> 
> No sorry USB_IN_0 and USB_IN_1 are connected to +5V in my schematic, I did
> check USB_IN I just forgot why it wasn't usable... +5v not VBUS is what its
> connected to.
> 

That is still good enough to replace qcom,dp-manual-pullup though.

If you have +5V connected to USB_IN then &pm8916_usbin should report
active VBUS permanently. Set it as extcon for &usb and &usb_hs_phy and
you should have VBUSVLDEXT "pulled-up" like in your patch here, without
any driver changes. :-)

It's a bit of a hack of course, which probably deserves a comment in the
device tree. But since it should not make any functional difference
compared to this patch the approach might be easier than getting this
patch finalized & accepted.

I leave that up to you :)

Stephan
