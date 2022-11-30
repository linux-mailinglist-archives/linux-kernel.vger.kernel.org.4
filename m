Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B1863CC96
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiK3ApX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiK3ApT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:45:19 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356AE6DFEF;
        Tue, 29 Nov 2022 16:45:19 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id m204so17198431oib.6;
        Tue, 29 Nov 2022 16:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkp8DbvjvFYX60bdCB1aPl/nyh8CuvJUTer76i3Ow+g=;
        b=Y6OOXKc9/CdrgfBQva+5V8gIJV+tmgfM09yl/znLqSdTtSva/hElWProolA2cTrKoj
         Uf6q/j7u97xkc5ij3ilcPCvOfl1Uoqtzmv+6HCw/cbbjfGBSOXyxnM4kXtGpSHxJ5Fmu
         iq5k0aDOykLV9HrrSq51uLRuHRUZoxIti4avUtY0oQF9DmVAy8XzewoMqbDhe5cHdyXG
         o6lqu64vucX8ElX0GnfoZ3a2+v6ptqZJAI+xqMCKLKHZ1jAtJRuKisM8tcXcxTwGBhOZ
         5f1t7jeaGwhPq5gi3W7N6gc5aMN3QiXxbO+mdkFdr2dof144gwgEE+iTmViVvfVPQHN2
         iQuw==
X-Gm-Message-State: ANoB5plrL7mCvaEeGWfpW8akiQ/zue3P5rpeBxlTxl0fM6s3VNpmqcEo
        sGhZJI5OJfESIHOw60PCYw==
X-Google-Smtp-Source: AA0mqf494FbbhWWY2FgA9I5hXIffKfBR434zz9Q+fxsy2WaeSOtOylTB8YkzE5uIqIBdKq+OcaLOkw==
X-Received: by 2002:a54:451a:0:b0:35b:3f80:32e8 with SMTP id l26-20020a54451a000000b0035b3f8032e8mr17963598oil.177.1669769118441;
        Tue, 29 Nov 2022 16:45:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i22-20020a056830011600b006619483182csm152394otp.18.2022.11.29.16.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 16:45:18 -0800 (PST)
Received: (nullmailer pid 604336 invoked by uid 1000);
        Wed, 30 Nov 2022 00:45:17 -0000
Date:   Tue, 29 Nov 2022 18:45:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v4 03/20] of: property: make #.*-cells optional for
 simple props
Message-ID: <166976911579.604253.5395868954946458991.robh@kernel.org>
References: <20221123180151.2160033-1-michael@walle.cc>
 <20221123180151.2160033-4-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123180151.2160033-4-michael@walle.cc>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Nov 2022 19:01:34 +0100, Michael Walle wrote:
> Sometimes, future bindings for phandles will get additional arguments.
> Thus the target node of the phandle will need a new #.*-cells property.
> To be backwards compatible, this needs to be optional.
> 
> Prepare the DEFINE_SIMPLE_PROPS() to handle the cells name as optional.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> changes since v3:
>  - new patch
> 
>  drivers/of/property.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
