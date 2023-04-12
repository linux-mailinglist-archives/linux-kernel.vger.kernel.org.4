Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554D96DF9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjDLP1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjDLP1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:27:19 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F612FA;
        Wed, 12 Apr 2023 08:27:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w11so11772576plp.13;
        Wed, 12 Apr 2023 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681313236; x=1683905236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ZzLhw5r59w752+4gsnm5gNIBG3OWAxPR3Xh7ehPlJs=;
        b=Bw/qF1kdIzRP+TAtzg9UFqbZ8CAeUCiVfG871IF4BpjUf8CIMjDSu4/wDEMAfUTv43
         GlqruwD+y+T3aXkxgzhMFJUp4fSQnz9EP2L2kzaxclKfTpm+QIteqhCcAsPq+5RkS8Ha
         xnjO2bPApUeNt3aVTqnrnNz0/JgpbzFUIsAdeC4/G3cmWSkoCtArFZ+2kTWriuNBNnvE
         qjLNzPqXWrjtwvdg5qh2ZSETRG+IywmKrdHjancd28RDC7QPgGa2tyGzkfxBBx4UrV61
         P1vXRLx52MWwciYfqu/+1Vy32zLbtbB2hknvz8/yyzJMJBKHx+RFZ3CpTtnFDLivLmck
         oJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681313236; x=1683905236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZzLhw5r59w752+4gsnm5gNIBG3OWAxPR3Xh7ehPlJs=;
        b=dMh2Af+73GuKCOdJGcLhWMN/n1qpLYDG7KxLrthU2AH/Gf63VnqKSjbctiAB4wKFiX
         e79zam8p973aBg2R+m+8zREvhDppPN6F8muhUH2h2tUIRElFPMsjvv0Grq/dQ0+IV5xI
         NSpqpufK3j7qklsho+4fKJJUWuNWQ/x3l3De5K3VJQ7i6gEW8aOSJvUloIHbbehJ+eJN
         dycjWi9lVT104E1oXtnUrhOPvnTfV9ckIXqJu26oH0FLTomh3arcPVZV2L6g50olWUwb
         /M8+D64v9dZonrF6hwNw3nvOl9sZUz3+M+P58yaS+RZiQWh372MCdBe4s56pjtWNCmnm
         yvLg==
X-Gm-Message-State: AAQBX9cijclb0+z4063REOeNbCMSc+bepKSYY00WtgwOE/83ftfthkAX
        g6P78NWuB45J2k0VuXkN6/U=
X-Google-Smtp-Source: AKy350YUSRIsw+uPXbzHk3vsNg0yWOTUwjEnGDvPeDUnIplgLl7SPP4EQ9PW+H+635Sp/MCIYaXPFA==
X-Received: by 2002:a17:90b:3841:b0:246:63c8:6abf with SMTP id nl1-20020a17090b384100b0024663c86abfmr20106507pjb.20.1681313236031;
        Wed, 12 Apr 2023 08:27:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090abf8c00b002465ff5d829sm1632719pjs.13.2023.04.12.08.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:27:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 12 Apr 2023 08:27:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     robh+dt@kernel.org, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/5] hwmon: (pmbus/acbel-fsg032) Add Acbel power supply
Message-ID: <b32aacbb-9f5c-4db9-bd93-d3f96aa1e6a9@roeck-us.net>
References: <20230412052305.1369521-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412052305.1369521-1-lakshmiy@us.ibm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 12:23:00AM -0500, Lakshmi Yadlapati wrote:
> Adding new acbel,fsg032 driver and documentation updates.
> 
> Changes since V5:
> Add symlink from manufacturer serial number to ccin since ccin is not
> available in acbel-fsg032 power supply driver.

Sorry, I fail to understand this change, and I am not inclined
to accept it. There is no "as required by hwmon".

Guenter

> 
> Lakshmi Yadlapati (5):
>   dt-bindings: vendor-prefixes: Add prefix for acbel
>   dt-bindings: trivial-devices: Add acbel,fsg032
>   hwmon: (pmbus/acbel-fsg032) Add Acbel power supply
>   docs: hwmon: Add documentaion for acbel-fsg032 PSU
>   ARM: dts: aspeed: p10bmc: Change power supply info
> 
>  .../devicetree/bindings/trivial-devices.yaml  |  2 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  Documentation/hwmon/acbel-fsg032.rst          | 80 ++++++++++++++++
>  Documentation/hwmon/index.rst                 |  1 +
>  arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts  | 12 +--
>  drivers/hwmon/pmbus/Kconfig                   |  9 ++
>  drivers/hwmon/pmbus/Makefile                  |  1 +
>  drivers/hwmon/pmbus/acbel-fsg032.c            | 95 +++++++++++++++++++
>  8 files changed, 196 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/hwmon/acbel-fsg032.rst
>  create mode 100644 drivers/hwmon/pmbus/acbel-fsg032.c
> 
> -- 
> 2.37.2
> 
