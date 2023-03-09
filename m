Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB876B1927
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 03:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjCICWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 21:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCICWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 21:22:03 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0CEC70BB;
        Wed,  8 Mar 2023 18:22:02 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-17638494edbso874875fac.10;
        Wed, 08 Mar 2023 18:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678328521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq9scOTrmtXuKVvVKQXEq5jBdB9obSnJgHrqb9SS0/0=;
        b=642AsthpG45O7zmsBmMU+cimhdPUcXKACdDK3yeBSHdQrRPnoYVbrtoM6xxo+G8Ut8
         uDf0efVeyVIwMP0QHi27JaievjhuzDXYkTzm+rMO7aihr4SZQW8XO+WmSlomaRdFpOvJ
         GrnTCdHOkIqbNfgP3ocCzwInHdJkqsS4HCnkTQIeONmsHn5TlMpgtnAVpyOuHqiyHgKT
         /ETwrPlf6H2T4kDOqNTT7jftd/AnkkAiQCVCysGhoenJK9oDk9IjsjA+Rrrmd6Z+Gbgk
         UMZsVNFqLQSyGbfeMQisXtk4ilV2LZgGMvAUTvMjzrltJ18Ncw2vWkn+a0pFb9mglE/B
         Pdew==
X-Gm-Message-State: AO0yUKUFO4mlkvJU9pSLlD65jvmdWAY3BHOyklLn5wdNq1etMdEuG6+5
        AMEZAjxLnR6NrAnfyJwY6w==
X-Google-Smtp-Source: AK7set9dCQKcTwwBqDU9M+LgC8dK+M+MpCK4LfyF59mfETL4i8dpAsIyUdPCD61IZHvSUXMg+ZBFgQ==
X-Received: by 2002:a05:6870:1602:b0:172:90cc:7756 with SMTP id b2-20020a056870160200b0017290cc7756mr12152479oae.25.1678328521314;
        Wed, 08 Mar 2023 18:22:01 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v43-20020a4a976e000000b00517fc5fdf5bsm6823674ooi.17.2023.03.08.18.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 18:22:00 -0800 (PST)
Received: (nullmailer pid 235368 invoked by uid 1000);
        Thu, 09 Mar 2023 02:22:00 -0000
Date:   Wed, 8 Mar 2023 20:22:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 04/20] of: Move of_modalias() to module.c
Message-ID: <20230309022200.GA198379-robh@kernel.org>
References: <20230308153200.682248-1-miquel.raynal@bootlin.com>
 <20230308153200.682248-5-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308153200.682248-5-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 04:31:44PM +0100, Miquel Raynal wrote:
> Create a specific .c file for OF related module handling.
> Move of_modalias() inside as a first step.
> 
> The helper is exposed through of.h even though it is only used by core
> files because the users from device.c will soon be split into an OF-only
> helper in module.c as well as a device-oriented inline helper in
> of_device.h. Putting this helper in of_private.h would require to
> include of_private.h from of_device.h, which is not acceptable.
> 
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/of/Makefile |  2 +-
>  drivers/of/device.c | 37 -------------------------------------
>  drivers/of/module.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h  |  9 +++++++++
>  4 files changed, 54 insertions(+), 38 deletions(-)
>  create mode 100644 drivers/of/module.c

Reviewed-by: Rob Herring <robh@kernel.org>
