Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BB473325C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243724AbjFPNj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjFPNjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:39:25 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE872D76;
        Fri, 16 Jun 2023 06:39:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b3c578c602so4864025ad.2;
        Fri, 16 Jun 2023 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686922762; x=1689514762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9wf0p/mJ/JTjbPEDo1M5gAN//dPRqP/MSvd3I7Rd/g=;
        b=H3+MocatYu8B8b/8V0+jB/MlLouBljTo61iUcRjTzTn+NTEqerFdmmwTAZpvy9iUnX
         4WP5KBtFZ8GEuUsxhhRdNlALu00IHK1yTOti1oZqDCYpIERBAQgSz8EhuqftIgcPGYPX
         3oePWllNJA8wqotvNPFhLDCt7CR1wSxBI8e/8EQvK7o3b7NcgU4vLWWv6PnNXCLNRnuq
         JbzqjJauLZlbp1ZeyxepmO7le9bS/1TYLIW7HmBPKpvdHosPLNhZ+V6lthvBFSxaJqVz
         GwVx09aZgkMSTdroVv3J6JmeRDlx74405AKh30/a+kTVrmOkW5aFKlTVbl6XfF5kXfhJ
         +PFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686922762; x=1689514762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9wf0p/mJ/JTjbPEDo1M5gAN//dPRqP/MSvd3I7Rd/g=;
        b=SwDPKmboJ5eRxqAYr3c3G65sQufc5sk2fv6MKJ1MWKeQjuoTUVNbBUtQvzO6VavdMd
         cQy+trKs7geG3FJbB47CLxxd6Emn1xdLKBrmTc9XxN+jWPK9m3KYOLFEKTxRXzmKfUx3
         aVIBgCdK9S6EzaehsNyphfYj9b5sIRMKw8ePbLJ3jQyKF10/7vOc787oK4DxJCRUFDCF
         nXVvbzzLuD5Brz5BM9R07rcR0fECyNIarTSMTga8gV/NpImQI0a77XpsDopxsrbRg12a
         Crihbux6MJi/GTgwh/k3w2O9V7hoHt5pVc4IZFPComwsM2Ki4PJZ2bMJuj8l8UjkXJ9J
         Lnzg==
X-Gm-Message-State: AC+VfDxyolU7c/1Iz+MztA6YZMPHEAOSyPYrkjUltqoV0KziRuCkypZa
        LLNI47D6msLGHeqQ7895KQM=
X-Google-Smtp-Source: ACHHUZ7EiE+4XcjpS4qH4GIBJdDtbnzosK8GTDHFMl0liXmIYcpxk5jfOF9TOaf9H2LCU8K/mgVCEg==
X-Received: by 2002:a17:903:2796:b0:1b2:5ee9:aa73 with SMTP id jw22-20020a170903279600b001b25ee9aa73mr1439407plb.62.1686922762167;
        Fri, 16 Jun 2023 06:39:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902b60a00b001ae6e270d8bsm15773546pls.131.2023.06.16.06.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 06:39:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 16 Jun 2023 06:39:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, yi.l.liu@intel.com, jgg@ziepe.ca,
        razor@blackwall.org, stephen@networkplumber.org,
        prabhakar.csengg@gmail.com, contact@emersion.fr, macro@orcam.me.uk,
        dsahern@kernel.org, alex.williamson@redhat.com,
        akrowiak@linux.ibm.com, mark.rutland@arm.com,
        ye.xingchen@zte.com.cn, ojeda@kernel.org, keescook@chromium.org,
        me@kloenk.de, mhiramat@kernel.org, milan@mdaverde.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com
Subject: Re: [PATCH v6 6/6] samples: Add userspace example for TI TPS6594 PFSM
Message-ID: <613d608c-8c11-497c-81ef-e061d7ab69ab@roeck-us.net>
References: <20230406075622.8990-1-jpanis@baylibre.com>
 <20230406075622.8990-7-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406075622.8990-7-jpanis@baylibre.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 09:56:22AM +0200, Julien Panis wrote:
> This patch adds an example showing how to use PFSM devices
> from a userspace application. The PMIC is armed to be triggered
> by a RTC alarm to execute state transition.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
>  samples/Kconfig            |   6 ++
>  samples/Makefile           |   1 +
>  samples/pfsm/.gitignore    |   2 +
>  samples/pfsm/Makefile      |   4 ++
>  samples/pfsm/pfsm-wakeup.c | 125 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 138 insertions(+)
>  create mode 100644 samples/pfsm/.gitignore
>  create mode 100644 samples/pfsm/Makefile
>  create mode 100644 samples/pfsm/pfsm-wakeup.c
> 
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 30ef8bd48ba3..f23aa60a74cf 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -253,6 +253,12 @@ config SAMPLE_INTEL_MEI
>  	help
>  	  Build a sample program to work with mei device.
>  
> +config SAMPLE_TPS6594_PFSM
> +	bool "Build example program working with TPS6594 PFSM driver"
> +	depends on HEADERS_INSTALL

This also needs to depend on CC_CAN_LINK to avoid errors such as

Building arm:allmodconfig ... failed
--------------
Error log:
samples/pfsm/pfsm-wakeup.c:12:10: fatal error: fcntl.h: No such file or directory
   12 | #include <fcntl.h>

seen when building images with kernel toolchains.

Guenter
