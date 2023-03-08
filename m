Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6AE6AFB0B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCHAZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCHAZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:25:18 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF19158B47;
        Tue,  7 Mar 2023 16:25:16 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id w25-20020a4ae9f9000000b0052513fb2e09so2315223ooc.13;
        Tue, 07 Mar 2023 16:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678235116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkMiZFhDMe7gTqyXPI9DMSeEKw9wuSKwJWI3wDBGvUM=;
        b=aOCrRjngNKwLlZ6jD/K4hvk2T1Rf1F1zw+wnM9ykchOn7J43zY6cWyJsM0j6WcMzLQ
         0BY7ecRtOvH5wj4CPqIKVCFo0Xkz0CXSnCsIO0vAgt41mnnoHu3V5J6ZCWPDI7OitMdm
         LUbbN+cykaEZsau9oHt3u3SNAexjh7MQHR6AHLoO9YiDT0zoPY95OTEhTZ2Dc8QJFrSX
         3vSB/BGVpjOuVrRD4udCkdqaASUkSuElaKwv9fGFMO1F5Ym2ffqhd2pJEqnBe8gWSmBG
         91/nbtV5BUYaU6aLKcBGhT9U1qNDhoZTgcOAy+AfgkgiftjUh12AbAtnCPieCgoxuslF
         nb1w==
X-Gm-Message-State: AO0yUKUHml6/mR5EwwUkQQeSSTJlKFtInkHibSAP05nE7YJePVX17Vb8
        BTCoRXUNBKcmHLtlLtTqBA==
X-Google-Smtp-Source: AK7set+dOBo7kBxGS737rJQccpzwQVLe+umV44fm6V2TZYav/uuJjYVfDdRFP1kt8xbRtT4Js2AE+A==
X-Received: by 2002:a4a:95c6:0:b0:525:129c:6165 with SMTP id p6-20020a4a95c6000000b00525129c6165mr7606141ooi.6.1678235116185;
        Tue, 07 Mar 2023 16:25:16 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zh10-20020a0568716b8a00b0017243edbe5bsm5618635oab.58.2023.03.07.16.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 16:25:15 -0800 (PST)
Received: (nullmailer pid 530930 invoked by uid 1000);
        Wed, 08 Mar 2023 00:25:15 -0000
Date:   Tue, 7 Mar 2023 18:25:15 -0600
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
Subject: Re: [PATCH v2 05/21] of: Move the request module helper logic to
 module.c
Message-ID: <20230308002515.GC513330-robh@kernel.org>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
 <20230307165359.225361-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307165359.225361-6-miquel.raynal@bootlin.com>
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

On Tue, Mar 07, 2023 at 05:53:43PM +0100, Miquel Raynal wrote:
> Depending on device.c for pure OF handling is considered
> backwards. Let's extract the content of of_device_request_module() to
> have the real logic under module.c.
> 
> The next step will be to convert users of of_device_request_module() to
> use the new helper.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/of/device.c | 25 ++-----------------------
>  drivers/of/module.c | 30 ++++++++++++++++++++++++++++++
>  include/linux/of.h  |  6 ++++++
>  3 files changed, 38 insertions(+), 23 deletions(-)

Other than the licensing inherited,

Reviewed-by: Rob Herring <robh@kernel.org>
