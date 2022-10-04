Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC225F440A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJDNRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJDNRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:17:11 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0149A40E00;
        Tue,  4 Oct 2022 06:17:07 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 23DD72D9;
        Tue,  4 Oct 2022 15:17:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1664889426;
        bh=f1RHm/OBzxHqpuDxQR9wiXt9MAc/9sUP+yL/aI5Rouw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tu2q72DURGA8c9qN/0N10mEcsZeFqdEGTh9q1tHkA7N7ApKAakihpD6tuK0C5Yew2
         n5I5swKCKOzS0grki1Q4Tdy3x3pNWtOQJmkR92856x6nBJf1s34DJW8CAm1GD34Z9x
         nv5mbiOKVUy4fC65/t60jKosn9MsqQR/uVuCW+4M=
Date:   Tue, 4 Oct 2022 16:17:03 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Dillon Min <dillon.minfei@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: panel: use
 spi-peripheral-props.yaml
Message-ID: <YzwyT28hf7daYqa1@pendragon.ideasonboard.com>
References: <20221004120907.72767-1-krzysztof.kozlowski@linaro.org>
 <YzwvDEKAzbqjSYjT@pendragon.ideasonboard.com>
 <64a355f2-e9a1-dcca-cb86-48805acae8d5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64a355f2-e9a1-dcca-cb86-48805acae8d5@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Oct 04, 2022 at 03:10:29PM +0200, Krzysztof Kozlowski wrote:
> On 04/10/2022 15:03, Laurent Pinchart wrote:
> > On Tue, Oct 04, 2022 at 02:09:07PM +0200, Krzysztof Kozlowski wrote:
> >> For devices connectable by SPI bus (e.g. already using
> >> "spi-max-frequency" property), reference the "spi-peripheral-props.yaml"
> >> schema to allow using all SPI device properties, even these which device
> >> bindings author did not tried yet.
> > 
> > Isn't this done implicitly by spi-controller.yaml ? SPI devices that are
> > children of an SPI controller should match the patternProperties
> > "^.*@[0-9a-f]+$" in that file, which has a $ref: spi-peripheral-props.yaml.
> > Is there something I'm missing ?
> 
> You are correct about one side of this - SPI controller bindings.
> However these schemas here have clear: additional/unevaluatedProperties:
> false, thus when they find DTS like:
> panel@xxx {
>   compatible = "one of these spi panels";
>   ...
>   spi-cs-high;
>   spi-rx-delay-us = <50>;
>   ... and some more from specific controllers
> }
> 
> you will get errors, because the panel schema does not allow them.
> 
> The bindings were done (some time ago) in such way, that they require
> that both SPI controller and SPI device reference spi-props.

You're absolutely right that additionalProperties needs to be replaced
by unevaluatedProperties. Can the additions of $ref be dropped, or is
that needed too ?

-- 
Regards,

Laurent Pinchart
