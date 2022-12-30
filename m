Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119406597FB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 13:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbiL3MGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 07:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiL3MGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 07:06:04 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51346D8A;
        Fri, 30 Dec 2022 04:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1672401955;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=EwBEUtWQM+CIXSqRF+omnXUkb+ypVnL3yjnzwSrntUs=;
    b=FuLbBcknLwS9BsNPXPu7AnkJVkRJDpZBWdIpjR2Cd9PREzRZJRA153ksJ6Kd4I2Mt4
    e1T/PYVrPRmE5a0Uc2EjwQ3Ox1OklSzbjMY0cLP8kz1TUCYKJJD8U5De1J54m+sOBgH2
    mtWjfyiimfvju5Jy/DO2wKLt7UB290Mx3w8fCWByUXbbSKrb0zBmHa3gle/vWuyVLeXI
    Aw50xM7/GwubXhtI/MP/UoGRTG+7UnNyvyyNbyKv/1V0wYTw37HjcNzcrqfkyr0ghc7R
    UMP7PprTgS4xJpzqgWVKgv0wH/yMRnPUbH9VzoojsDFNBAxb2lGf2NqEy6kfETH11HtX
    UzdQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWwfOntQ=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id Yce349yBUC5qYxl
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 30 Dec 2022 13:05:52 +0100 (CET)
Date:   Fri, 30 Dec 2022 13:05:51 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] phy: qcom-usb-hs: Add qcom,dp-manual-pullup logic
Message-ID: <Y67UH0xfTPH0GN+S@gerhold.net>
References: <20221229183410.683584-1-bryan.odonoghue@linaro.org>
 <20221229183410.683584-3-bryan.odonoghue@linaro.org>
 <Y63uSgMdP4m6nvhL@gerhold.net>
 <Y64AfHcUw192Pyr6@gerhold.net>
 <6061938c-b830-2fe0-2f4d-368e34c33676@linaro.org>
 <Y64CaOzWZXERrvkz@gerhold.net>
 <cdcef656-1ae7-fe8a-a4dd-3547d6395b33@linaro.org>
 <Y64Jgu2o6aJV4ggk@gerhold.net>
 <da671da3-61f5-ce4d-05aa-76f3f6ae12cf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da671da3-61f5-ce4d-05aa-76f3f6ae12cf@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 11:38:04PM +0000, Bryan O'Donoghue wrote:
> On 29/12/2022 21:41, Stephan Gerhold wrote:
> > That is still good enough to replace qcom,dp-manual-pullup though.
> 
> But there's no requirement to tie USB_IN_x high if VBUS is not connected to
> it.
> 

I've yet to find any device where USB_IN is not connected in a usable way.

But as I said I leave it up to you - it would be nice to have a proper
solution for devices where VBUS state cannot be determined at all. Those
devices should be rare though so if &pm8916_usbin works in your case
maybe the time would be better invested into other open problems right
now. :)

Thanks,
Stephan
