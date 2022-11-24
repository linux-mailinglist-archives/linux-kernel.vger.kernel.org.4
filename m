Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F27637E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiKXRjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKXRji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:39:38 -0500
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983E913C70E;
        Thu, 24 Nov 2022 09:39:35 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id y6so1595695iof.9;
        Thu, 24 Nov 2022 09:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IoktBuMa4PVRuI5/Wo0/xDwZpz9ewe3rcWXZGPg/Ou4=;
        b=lxxDemYldA3/BlTdBq8ImA2315Wfm6AMAOUoV62gqdhYcR+pk2B5gH0y9LZQuUBJ4e
         AL3HDZt6YciS2tlkfqijB7ksqXYbhC3DDk6PeGluJkWnfHGktwU/e883n7ABGQlFbT2O
         DlQjLWxYFLgmQ7j3LO34fHlRXs5Lhiq1r1zK4JEdVX0WF3ecs3m2F1fOVXw5h2czjFhH
         F9lf7Hh5oTF1bxUxPFZ1plenrfcFSRkL7Z6hp0mHVrrQbMHYIpDzW+SMI4loVEvis3Pt
         wrggO3FucKwwpUKsae0RjB9INhb5NxH/2wIuei4FUGz1Xj75mvGG7gRy3UWWruZQw0j5
         98GA==
X-Gm-Message-State: ANoB5pn0+OkzmKPX14mykJc3Ayd/T8ztvfsVcZLbS0J+olpfl1QXimXX
        TFX14n9UALZJX4RkPSKQ0g==
X-Google-Smtp-Source: AA0mqf6u4sFD+aGrlSoj75GanwIIheHbWEuFFhr8HAzTVS6PxR/piCFthw25bzyO3jj4ay7YIeMfaw==
X-Received: by 2002:a02:6309:0:b0:375:4dbf:6ca4 with SMTP id j9-20020a026309000000b003754dbf6ca4mr6392316jac.315.1669311574693;
        Thu, 24 Nov 2022 09:39:34 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id g6-20020a02a086000000b003754033c6aesm593628jah.155.2022.11.24.09.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:39:34 -0800 (PST)
Received: (nullmailer pid 4182342 invoked by uid 1000);
        Thu, 24 Nov 2022 17:39:27 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org,
        ", Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-acpi@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev,
        Robert Foss <robert.foss@linaro.org>,
        Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Benson Leung <bleung@chromium.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>, Lyude Paul <lyude@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Xin Ji <xji@analogixsemi.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
In-Reply-To: <20221124102056.393220-4-treapking@chromium.org>
References: <20221124102056.393220-1-treapking@chromium.org>
 <20221124102056.393220-4-treapking@chromium.org>
Message-Id: <166930150025.3946612.5757271936642172776.robh@kernel.org>
Subject: Re: [PATCH v6 3/7] dt-bindings: drm/bridge: anx7625: Add mode-switch support
Date:   Thu, 24 Nov 2022 11:39:27 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Nov 2022 18:20:52 +0800, Pin-yen Lin wrote:
> Analogix 7625 can be used in systems to switch the DP traffic between
> two downstreams, which can be USB Type-C DisplayPort alternate mode
> lane or regular DisplayPort output ports.
> 
> Update the binding to accommodate this usage by introducing a
> data-lanes and a mode-switch property on endpoints.
> 
> Also include the link to the product brief in the bindings.
> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 
> ---
> 
> Changes in v6:
> - Remove switches node and use endpoints and data-lanes property to
>   describe the connections.
> 
>  .../display/bridge/analogix,anx7625.yaml      | 73 ++++++++++++++++++-
>  1 file changed, 71 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml:218:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/display/bridge/analogix,anx7625.example.dts'
Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml:218:1: found character '\t' that cannot start any token
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/display/bridge/analogix,anx7625.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml:218:1: found character '\t' that cannot start any token
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml: ignoring, error parsing file
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221124102056.393220-4-treapking@chromium.org

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

