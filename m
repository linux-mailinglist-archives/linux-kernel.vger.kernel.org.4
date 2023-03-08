Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C406AFB15
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCHA2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCHA2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:28:49 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2B2968F4;
        Tue,  7 Mar 2023 16:28:44 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1767a208b30so15192327fac.2;
        Tue, 07 Mar 2023 16:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678235323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Z8MWeIzOL2NSe+eXgUZNrGgoSCOxaDj1NniKwarPGg=;
        b=l3B1r89lfd1uirBLw+vjF+ooedd5iWuRQjKkL9pXSx7YM8sQ46ZEcevqwcNYjVp8UT
         26lxQfdXyVAXhf9UbvdNHY1n+z5OQIXRq7IO3zZKdN8/x/0U4BhIqIcSZOCR/wL9yrkW
         9u9wUhZtsbdUXXaEx7zD3rgA7RnTNu7TP/HxBYgVc+hVzQPXMg5DyAyErvM5VNSevqRP
         TUqlM9t1U3JDEsmVf1ZqAtgDmLOCb/t2VEiaDm+ekVXGQZIegdZI76qbTO/AizCAaC/y
         3Snn4nZHBFH/UQethxQWHBAn5+GGqUDq0q64L/oICV5767BzH3v07L0pdODFmn2GFswU
         4oog==
X-Gm-Message-State: AO0yUKWWCYYd5tjrgXO/Y27awDDQ0BNQmnfi4JSFkJHnPgz5sPq8asak
        OaT+WnT7IFdn7mu1PiACrQ==
X-Google-Smtp-Source: AK7set8z7WL4Pj8aQSImXn4LYOIvg29D0qOLXTnCMATeozbAUq7ddyS+TF1G8QaEVomIScXh56tpuQ==
X-Received: by 2002:a05:6870:e38e:b0:171:d1e4:f9da with SMTP id x14-20020a056870e38e00b00171d1e4f9damr8424206oad.2.1678235323686;
        Tue, 07 Mar 2023 16:28:43 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v42-20020a056870956a00b001762d1bf6a9sm5659756oal.45.2023.03.07.16.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 16:28:43 -0800 (PST)
Received: (nullmailer pid 534577 invoked by uid 1000);
        Wed, 08 Mar 2023 00:28:42 -0000
Date:   Tue, 7 Mar 2023 18:28:42 -0600
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
Subject: Re: [PATCH v2 02/21] of: Update of_device_get_modalias()
Message-ID: <20230308002842.GA533766-robh@kernel.org>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
 <20230307165359.225361-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307165359.225361-3-miquel.raynal@bootlin.com>
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

On Tue, Mar 07, 2023 at 05:53:40PM +0100, Miquel Raynal wrote:
> This function only needs a "struct device_node" to work, but for
> convenience the author (and only user) of this helper did use a "struct
> device" and put it in device.c.
> 
> Let's convert this helper to take a "struct device node" instead. This
> change asks for two additional changes: renaming it "of_modalias()"
> to fit the current naming, and moving it outside of device.c which will
> be done in a follow-up commit.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/of/device.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
