Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E82686BC1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjBAQbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjBAQbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:31:38 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91624CA07;
        Wed,  1 Feb 2023 08:31:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675269094; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cxhzdv/QY1zJFMB4Iwn9etd3UIc4O2WBKtE4jmfY+ugvdOlb2rugenfwTQQPfkzW+n
    htBKGYKDG9of1T81/iz094qswFF0ub2RT4dBgiuDGRrQ8y/ZSlyZ6rr0L4YrR8/Qs7l0
    +R8lgzvb/MpSPnZ8wgZ0KSj/ZHHMgi2vgy/vGjEtJLgn8cFCAMErvMOB41q5NNZNKpx8
    JqiJJhSNHoCK3xAOf0z5te8jXW5PeSnp1s9HvoT9fQffvO7T1x/iG6rnW/f9zz1PRqyr
    SGDIUZi2wKCRvQUtcZdhneAk4gbxJ221NOhzhsA642PhT9QlYDohGz04/nXNwNVRRShc
    ndJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675269094;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=gtu4KRJ6ENsyLwaGzlLhQdeBT0uZ16xoIcwLZ8hHjD8=;
    b=U+NtumFXO7x2kaOSKIJmaAcNvUXr5RgfSmagnuxC/689f4r7VAmQOk1GAyXrWg5o0S
    WDSeTpEEP/h2D6eV6v1ezQqXDWaMoCyFVj0U6LyLntRBsjszfPaT97GTaqPopv4rydS4
    5L4X1mIWKbsL67GP2+M2OFCwkl6+Cx2jEK/VNCfwOMxmZ6cUgLVVFa14u9RHjSnipede
    Z+AOeZYTOkkMrii7AgmMt/EfDHgBZVSPp8sQCb7sytgD487zjeNNU6PT+dK+NRETlwgT
    kisJna7W8NF0YM6sT79L3Kb0e+XeYQTaQUGNhDpYdpW8QaOhoE/DUxYCu/M27riJP/q9
    XWFQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675269094;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=gtu4KRJ6ENsyLwaGzlLhQdeBT0uZ16xoIcwLZ8hHjD8=;
    b=fpUvkcDCOdsbZswxmuJjkfb9Ap9mAUMx1g4r46QturA1iz1N0lk5pn5ejYj4RoPztb
    ULHMAxngkKtlR9BzdENbeXh8SQOeYmUypC8ktHkIW0d2LiHQlC61v1QNcmJcrMYmR+Kh
    TAzqq0EpHj8JlNWR4nddAkns+rjTDV+A/7bDDtP2k+dJsX0ns0DU3YnTiUDD9F0tyKjD
    Yf304wD4wWIvlulI3BO+4bkyWzHmnoc2Nsb3lf1b4rTSQITSCCefT+D7qxHNh8lvArj/
    aUPrJWig8Ysi42BpN2aTpg+86h010+T9WM7ZZdMz+VzenHeCQPNF4Jv+14xQfqDS17FB
    4rvw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267EpF+OQRc4obTF5+XwHE="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.2.2 DYNA|AUTH)
    with ESMTPSA id eee9e2z11GVXUwT
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 1 Feb 2023 17:31:33 +0100 (CET)
Date:   Wed, 1 Feb 2023 17:31:26 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] dt-bindings: pinctrl: qcom: correct gpio-ranges in
 examples
Message-ID: <Y9qT3vNTcuT+njIR@gerhold.net>
References: <20230201153019.269718-1-krzysztof.kozlowski@linaro.org>
 <20230201153019.269718-7-krzysztof.kozlowski@linaro.org>
 <Y9qORcPIuq4IZcL1@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9qORcPIuq4IZcL1@gerhold.net>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 05:07:40PM +0100, Stephan Gerhold wrote:
> On Wed, Feb 01, 2023 at 04:30:19PM +0100, Krzysztof Kozlowski wrote:
> > Correct the number of GPIOs in gpio-ranges to match reality.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> AFAICT the current gpio-ranges do match the number of GPIOs (ngpios) in
> the pinctrl drivers for all/most of the platforms you update below. It
> looks like the special UFS_RESET pins are also exported as GPIOs in
> addition to the real GPIOs. I'm not sure if this is intended or a
> mistake.
> 

It looks like this is on purpose:

---
From 53a5372ce326116f3e3d3f1d701113b2542509f4 Mon Sep 17 00:00:00 2001
From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Tue, 4 Jun 2019 00:19:59 -0700
Subject: [PATCH] pinctrl: qcom: sdm845: Expose ufs_reset as gpio

The ufs_reset pin is expected to be wired to the reset pin of the
primary UFS memory but is pretty much just a general purpose output pinr

Reorder the pins and expose it as gpio 150, so that the UFS driver can
toggle it.
---

And it's used in sdm845-mtp.dts:

&ufs_mem_hc {
	reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
};

So I think this patch (together with the DT ones you sent) should be
dropped because it would prevent using the UFS_RESET as GPIO since it's
no longer included in gpio-ranges.

Thanks,
Stephan
