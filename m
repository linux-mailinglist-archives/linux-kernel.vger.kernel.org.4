Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470EA6D8CD9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjDFBka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjDFBk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:40:28 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507187EC0;
        Wed,  5 Apr 2023 18:40:27 -0700 (PDT)
Received: from pendragon.ideasonboard.com (fp76f193f3.tkyc206.ap.nuro.jp [118.241.147.243])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E49AE905;
        Thu,  6 Apr 2023 03:40:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680745225;
        bh=3gqmu4KgxgYFuJy5DilzdfPDlIkPg8yygx/h/5xSCu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQr3ojnssfSQ8mE18DBh0lp66rrAFfpo0cDHvOAXYN0qPOHyi4XWJZHt3v7Wf4nDx
         TvxcyCgUh89NxDA5D/BmPG3GXuSddCK9rnWW5xubAtvzJBDM/O6BDZfmfSKmixgWzj
         UlER7+GWwJxVhWmQImI6iiQr/ohFpOrEm9qrQzDE=
Date:   Thu, 6 Apr 2023 04:40:32 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sam@ravnborg.org,
        jani.nikula@intel.com, tzimmermann@suse.de, javierm@redhat.com,
        ville.syrjala@linux.intel.com, r-ravikumar@ti.com,
        lyude@redhat.com, alexander.deucher@amd.com, sjakhade@cadence.com,
        yamonkar@cadence.com, a-bhatia1@ti.com,
        tomi.valkeinen@ideasonboard.com
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/bridge: Add no-hpd property
Message-ID: <20230406014032.GN9915@pendragon.ideasonboard.com>
References: <20230405142440.191939-1-j-choudhary@ti.com>
 <20230405142440.191939-2-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230405142440.191939-2-j-choudhary@ti.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jayesh,

Thank you for the patch.

On Wed, Apr 05, 2023 at 07:54:39PM +0530, Jayesh Choudhary wrote:
> From: Rahul T R <r-ravikumar@ti.com>
> 
> The mhdp bridge can work without its HPD pin hooked up to the connector,
> but the current bridge driver throws an error when hpd line is not
> connected to the connector. For such cases, we need an indication for
> no-hpd, using which we can bypass the hpd detection and instead use the
> auxiliary channels connected to the DP connector to confirm the
> connection.
> So add no-hpd property to the bindings, to disable hpd when not
> connected or unusable.
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  .../devicetree/bindings/display/bridge/cdns,mhdp8546.yaml   | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> index c2b369456e4e..3a6c6d837593 100644
> --- a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> @@ -57,6 +57,12 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  cdns,no-hpd:
> +    type: boolean
> +    description:
> +      Set if the HPD line on the bridge isn't hooked up to anything or is
> +      otherwise unusable.

I'm fine with the non connected part, but concerned with "otherwise
unusable". It's very vague and could thus be abused. Do you have
particular use cases in mind for this ? If so, restricting this to those
use cases, or at least giving examples, would help.

> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>  

-- 
Regards,

Laurent Pinchart
