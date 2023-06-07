Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582F2726783
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjFGReb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjFGReU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:34:20 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5152B26AB;
        Wed,  7 Jun 2023 10:33:58 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-33b3f679cafso5088075ab.1;
        Wed, 07 Jun 2023 10:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686159236; x=1688751236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifvHsSrfgeIcTvAsIeYExAkFBsAsOW3wN6CFaDak0ak=;
        b=Iv9bSay5LS2kEPuZiwndx4ovET+jzVprAMMcEE74kVKT9vHcwqYdcKp0Pw9eHDlSx+
         FrOWAtlrh7xdsklTvrT1VMxyixW+rziNLA4/idBY2BvE/22YPq5m2J+Gdl9FXbtGETDv
         6nhAY7Z4Wui8uNxQF51FycPv98bfkBiNycWLYQkMKV/NFqGEo7dmCs8p2Tj8LfcBen4K
         UQPBcZ26tKYTpGBJ/cTXW7ffYljHqSHgV/yEji+yZzZiH9fd7MreQDjkC/0wYJj7fE7S
         cs5UAK3jqfr9qzF8gkhrNeeHIoQGO6WeBf5gNfovbq2eIGJ3/wAyrCwMRM6fWVwiot3Y
         eEhA==
X-Gm-Message-State: AC+VfDz55y5D65L9ZO4VLq0gyYCQ79Ghb6+3WuRPye5tv/U4GyYOMLkx
        loP86ibJDtGmX105QpVmTQ==
X-Google-Smtp-Source: ACHHUZ4oOXRGnUSWhKStEGpwOqs79jvUdrL1G7Py5e078ZLrAaLBYtTFxhYdiixTt+hgpUmdJe1eZg==
X-Received: by 2002:a05:6e02:803:b0:33e:5b02:17ce with SMTP id u3-20020a056e02080300b0033e5b0217cemr955193ilm.24.1686159236017;
        Wed, 07 Jun 2023 10:33:56 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b3-20020a05663801a300b004161a1fbb06sm3601911jaq.121.2023.06.07.10.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 10:33:55 -0700 (PDT)
Received: (nullmailer pid 3608594 invoked by uid 1000);
        Wed, 07 Jun 2023 17:33:51 -0000
Date:   Wed, 7 Jun 2023 11:33:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Julien Panis <jpanis@baylibre.com>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, arnd@arndb.de, gregkh@linuxfoundation.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        macro@orcam.me.uk, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
        jirislaby@kernel.org, rostedt@goodmis.org, revest@chromium.org,
        gehao@kylinos.cn, akpm@linux-foundation.org, jgg@ziepe.ca,
        razor@blackwall.org, stephen@networkplumber.org,
        prabhakar.csengg@gmail.com, contact@emersion.fr,
        alex.williamson@redhat.com, akrowiak@linux.ibm.com,
        mark.rutland@arm.com, ye.xingchen@zte.com.cn, ojeda@kernel.org,
        me@kloenk.de, milan@mdaverde.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com
Subject: Re: [PATCH v7 2/6] mfd: tps6594: Add driver for TI TPS6594 PMIC
Message-ID: <20230607173351.GA3605615-robh@kernel.org>
References: <20230511095126.105104-1-jpanis@baylibre.com>
 <20230511095126.105104-3-jpanis@baylibre.com>
 <20230518150740.GN404509@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518150740.GN404509@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 04:07:40PM +0100, Lee Jones wrote:
> On Thu, 11 May 2023, Julien Panis wrote:
> 
> > This patch adds support for TPS6594 PMIC MFD core. It provides
> > communication through the I2C and SPI interfaces, and supports
> > protocols with embedded CRC data fields for safety applications.
> > 
> > Signed-off-by: Julien Panis <jpanis@baylibre.com>
> > Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> > ---
> >  drivers/mfd/Kconfig         |   32 ++
> >  drivers/mfd/Makefile        |    3 +
> >  drivers/mfd/tps6594-core.c  |  462 ++++++++++++++++
> >  drivers/mfd/tps6594-i2c.c   |  244 +++++++++
> >  drivers/mfd/tps6594-spi.c   |  129 +++++
> >  include/linux/mfd/tps6594.h | 1020 +++++++++++++++++++++++++++++++++++
> >  6 files changed, 1890 insertions(+)
> >  create mode 100644 drivers/mfd/tps6594-core.c
> >  create mode 100644 drivers/mfd/tps6594-i2c.c
> >  create mode 100644 drivers/mfd/tps6594-spi.c
> >  create mode 100644 include/linux/mfd/tps6594.h
> 
> Applied - current being build tested.
> 
> Once complete, I'll send out a pull-request for the other maintainers.

Some reason the binding wasn't applied too? The compatible strings are 
now reported as undocumented (make dt_compatible_check).

Rob
