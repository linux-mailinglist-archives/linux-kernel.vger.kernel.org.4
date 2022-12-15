Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B0864DFDB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiLORkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiLORkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:40:49 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6279A11C0E;
        Thu, 15 Dec 2022 09:40:48 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1441d7d40c6so152231fac.8;
        Thu, 15 Dec 2022 09:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOGeJCS8aseFoPpUkMU2Y4kwt5b3YZhRZvuAq9SJfKA=;
        b=nQfBcdq4P4kJOFZbn3Xs8Wdi8qfKjljPBeoP/rdg94nEpEAQ4i1BJz7GAAnVKnD0Iy
         OZrsVZPxc2DC+Y5+mjUVVJ9QpG6jH0PxbXOxlsM/Iuoto8ujw+4k7gKJnFHq9BQuCk8m
         zTJXihtqAeRlGNKNabx5boIaSWhh1C2UgSj5NBUf9qZ/yPQh4Kzt7Q8BAnq0bl9aR29n
         6FnV/SXRh+ueH/jHCCnlCi3jDtpk+pG3goHaJykPQmChTexo0YqTsXZ3J0mpyJGAUx74
         uS3Yfi3ujovNmAX55+NpHb1xsbqSN5G3wTGIRlTpsZ/fGaAfEjvyvQT2RILD+qOLH9hC
         lPiw==
X-Gm-Message-State: ANoB5plvtpTpM9FJTJ0jqaldxgmPNDJXTUgICYyhyuscnwghKQutQYeo
        oIriOh5xxXGqU9M4opLuCind8o4A4Q==
X-Google-Smtp-Source: AA0mqf5h6CDTjYTwJacILJW30d37epd29oSWO8w00AjAR8sBcTn2iUkKrX0wxIRE86d0fVPdqaeslA==
X-Received: by 2002:a05:6871:4387:b0:144:ae30:1bb7 with SMTP id lv7-20020a056871438700b00144ae301bb7mr15094587oab.48.1671126047572;
        Thu, 15 Dec 2022 09:40:47 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r22-20020a056870581600b00143c7a9bdb0sm4263731oap.27.2022.12.15.09.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 09:40:47 -0800 (PST)
Received: (nullmailer pid 260537 invoked by uid 1000);
        Thu, 15 Dec 2022 17:40:46 -0000
Date:   Thu, 15 Dec 2022 11:40:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Linus Walleij <linusw@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lukasz Majewski <lukma@denx.de>,
        Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>
Subject: Re: [PATCH] of: fdt: Honor CONFIG_CMDLINE* even without /chosen node
Message-ID: <167112600086.259523.16908827852183615525.robh@kernel.org>
References: <11af73e05bad75e4ef49067515e3214f6d944b3d.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11af73e05bad75e4ef49067515e3214f6d944b3d.camel@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Dec 2022 00:58:17 +0100, Alexander Sverdlin wrote:
> I do not read a strict requirement on /chosen node in either ePAPR or in
> Documentation/devicetree. Help text for CONFIG_CMDLINE and
> CONFIG_CMDLINE_EXTEND doesn't make their behavior explicitly dependent on
> the presence of /chosen or the presense of /chosen/bootargs.
> 
> However the early check for /chosen and bailing out in
> early_init_dt_scan_chosen() skips CONFIG_CMDLINE handling which is not
> really related to /chosen node or the particular method of passing cmdline
> from bootloader.
> 
> This leads to counterintuitive combinations (assuming
> CONFIG_CMDLINE_EXTEND=y):
> 
> a) bootargs="foo", CONFIG_CMDLINE="bar" => cmdline=="foo bar"
> b) /chosen missing, CONFIG_CMDLINE="bar" => cmdline==""
> c) bootargs="", CONFIG_CMDLINE="bar" => cmdline==" bar"
> 
> Move CONFIG_CMDLINE handling outside of early_init_dt_scan_chosen() so that
> cases b and c above result in the same cmdline.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
>  drivers/of/fdt.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 

Applied, thanks!
