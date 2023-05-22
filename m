Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AD370C176
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjEVOwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjEVOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:52:01 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEE8B9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:51:59 -0700 (PDT)
Received: from SoMainline.org (82-72-63-87.cable.dynamic.v4.ziggo.nl [82.72.63.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id E12572011F;
        Mon, 22 May 2023 16:51:55 +0200 (CEST)
Date:   Mon, 22 May 2023 16:51:54 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Visionox R66451
 AMOLED DSI panel bindings
Message-ID: <sf4fsrvuvgn42ucrwgqlrgprlr3sofq4wqeeuxryzeubxqs4kz@r4dmwzproti4>
References: <20230516-b4-r66451-panel-driver-v1-0-4210bcbb1649@quicinc.com>
 <20230516-b4-r66451-panel-driver-v1-1-4210bcbb1649@quicinc.com>
 <dzekdzubv6y5evn4j62hnntjdexcdi5ar2wj6hcm3dffx5jei4@h32wgmfalzvl>
 <0d436948-b0b7-0727-0852-51f64aefa43f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d436948-b0b7-0727-0852-51f64aefa43f@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-22 11:05:38, Neil Armstrong wrote:
> On 21/05/2023 12:30, Marijn Suijten wrote:
> > On 2023-05-16 13:20:30, Jessica Zhang wrote:
> >> Document the 1080x2340 Visionox R66451 AMOLED DSI panel bindings
> >>
> >> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> >> ---
> >>   .../bindings/display/panel/visionox,r66451.yaml    | 59 ++++++++++++++++++++++
> >>   1 file changed, 59 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/panel/visionox,r66451.yaml b/Documentation/devicetree/bindings/display/panel/visionox,r66451.yaml
> >> new file mode 100644
> >> index 000000000000..6ba323683921
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/display/panel/visionox,r66451.yaml
> >> @@ -0,0 +1,59 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/display/panel/visionox,r66451.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Visionox R66451 AMOLED DSI Panel
> >> +
> >> +maintainers:
> >> +  - Jessica Zhang <quic_jesszhan@quicinc.com>
> >> +
> >> +allOf:
> >> +  - $ref: panel-common.yaml#
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: visionox,r66451
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +    description: DSI virtual channel
> >> +
> >> +  vddio-supply: true
> >> +  vdd-supply: true
> >> +  port: true
> >> +  reset-gpios: true
> > 
> > Normally for cmd-mode panels there is also a `disp-te` pin which is
> > optionally registered in dsi_host.c as GPIOD_IN, but on **ALL** my Sony
> > phones this breaks vsync (as in: mdp5 stops receiving the interrupt, but
> > we can see disp-te in /proc/interrupts then).
> 
> Describing it as a gpio is wrong, it should be described as a pinctrl state instead.

We defined both in our DTS, what weirdness does it cause when then
requested using GPIOD_IN?  It'd still be beneficial to see the vsync
interrupt raise in /proc/interrupts (but it's just a waste of CPU cycles
OTOH, this is all handled in the MDP hardware after all, so it's not
something I'd like to enable by default).

Anyway, this is what we ended up doing to "fix" the bug (only bias the
pin via pinctrl, omit the disp-te DTS property).  Thanks for confirming!

- Marijn

> 
> Neil

<snip>
