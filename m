Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13ADA68E22C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBGUw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBGUwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:52:25 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B84F3B652;
        Tue,  7 Feb 2023 12:52:24 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id e12-20020a0568301e4c00b0068bc93e7e34so4627792otj.4;
        Tue, 07 Feb 2023 12:52:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcVPFnoRaSoY1gzZkXWhCCA1qymR4MwDuxSfBidY0Gc=;
        b=5UF5YlLyugxA3myDT/Ra1ZntNN09BdeRFCF5pi5LDfjPevsZ0q/6d4gNbaDeODEheZ
         8kBZcVjR7dNB+fCe/zi89N8DGIZXkGpRP5inVTSk8cAZBQqCv6bZycvjwEmc4epiJFRF
         WhnXw5BMV774B+SxPnGR9h6TT87hLVmwwQp9FguWltp53zWlMwK/RKR4DCpmwG9m5KgB
         pa1RUt99udLmesiN1G0Woh7aqhvrTRHW46TGdTQs3y9Ledo6wLVOXJKp2SzLYmMdBYya
         CJpf9GH4HJAHKDY1m2LmhhiapZxBz7oL9BQG1SGlBd1PFAk1VZnJB4GHYZhiepFIhEBP
         n9BQ==
X-Gm-Message-State: AO0yUKU0VoZ41y3pOjg2Ep7hjgQUc08wWReOj8sFUbwSdZUoyg1rFrE1
        uz2U3RuFmAk8JNEkQcJcOQ==
X-Google-Smtp-Source: AK7set85cQER3pOfyCBLnV+ZWaH2+cz2iVzzjg8skSTkYOgkgyYEDrHKGYM6G+GfbIGe9UuBz9KkSg==
X-Received: by 2002:a05:6830:2004:b0:68b:a341:b93b with SMTP id e4-20020a056830200400b0068ba341b93bmr2500643otp.36.1675803143255;
        Tue, 07 Feb 2023 12:52:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bk25-20020a056830369900b0068664355604sm7205144otb.22.2023.02.07.12.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 12:52:22 -0800 (PST)
Received: (nullmailer pid 4134263 invoked by uid 1000);
        Tue, 07 Feb 2023 20:52:21 -0000
Date:   Tue, 7 Feb 2023 14:52:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Hsin-Yi Wang <hsinyi@chromium.org>,
        devicetree@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        Lyude Paul <lyude@redhat.com>, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Xin Ji <xji@analogixsemi.com>,
        Stephen Boyd <swboyd@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v11 7/9] dt-bindings: display: bridge: it6505: Add
 mode-switch support
Message-ID: <20230207205221.GA4121517-robh@kernel.org>
References: <20230204133040.1236799-1-treapking@chromium.org>
 <20230204133040.1236799-8-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204133040.1236799-8-treapking@chromium.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 09:30:38PM +0800, Pin-yen Lin wrote:
> ITE IT6505 can be used in systems to switch the DP traffic between
> two downstreams, which can be USB Type-C DisplayPort alternate mode
> lane or regular DisplayPort output ports.
> 
> Update the binding to accommodate this usage by introducing a
> data-lanes and a mode-switch property on endpoints.
> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 
> ---
> 
> Changes in v11:
> - Updated the description of the endpoints in the bindings
> - Referenced video-interfaces.yaml instead for the endpoints binding
> - Removed duplicated definitions from inherited schema
> 
> Changes in v9:
> - Fixed subject prefix again
> - Changed the naming of the example node for it6505
> 
> Changes in v8:
> - Updated bindings for data-lanes property
> - Fixed subject prefix
> 
> Changes in v7:
> - Fixed issues reported by dt_binding_check.
> - Updated the schema and the example dts for data-lanes.
> - Changed to generic naming for the example dts node.
> 
> Changes in v6:
> - Remove switches node and use endpoints and data-lanes property to
>   describe the connections.
> 
>  .../bindings/display/bridge/ite,it6505.yaml   | 101 +++++++++++++++---
>  1 file changed, 88 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> index b16a9d9127dd..8ae9c5cba22c 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> @@ -75,22 +75,49 @@ properties:
>        port@1:
>          $ref: /schemas/graph.yaml#/$defs/port-base
>          unevaluatedProperties: false
> -        description: Video port for DP output
> +        description:
> +          Video port for DP output. Each endpoint connects to a video output
> +          downstream, and the "data-lanes" property is used to describe the pin
> +          connections. 0, 1, 2, 3 in "data-lanes" maps to TX0, TX1, TX2, TX3,
> +          respectively.
>  
> -        properties:
> -          endpoint:
> -            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +
> +        patternProperties:
> +          "^endpoint@[01]$":
> +            $ref: /schemas/media/video-interfaces.yaml#
>              unevaluatedProperties: false
>  
>              properties:
> +              reg: true
> +
> +              remote-endpoint: true
> +
>                data-lanes:
> -                minItems: 1
> -                uniqueItems: true
> -                items:
> -                  - enum: [ 0, 1 ]
> -                  - const: 1
> -                  - const: 2
> -                  - const: 3
> +                oneOf:
> +                  - items:
> +                      - enum: [0, 1, 2, 3]
> +
> +                  - items:
> +                      - const: 0
> +                      - const: 1
> +
> +                  - items:
> +                      - const: 2
> +                      - const: 3
> +
> +                  - items:
> +                      - const: 0
> +                      - const: 1
> +                      - const: 2
> +                      - const: 3
> +
> +              mode-switch:
> +                type: boolean
> +                description: Register this node as a Type-C mode switch or not.

Existing users put this property in the device's node, not the endpoint. 
That seems more like a property of the device, than the DP link.

You are using fwnode_typec_mux_get(), right?

Rob
