Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC287084A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjERPIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjERPIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:08:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6C9C2;
        Thu, 18 May 2023 08:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52EC564FF5;
        Thu, 18 May 2023 15:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08307C433D2;
        Thu, 18 May 2023 15:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684422470;
        bh=S5LxrHUIaUTyAXU/DFJLNgQy/pqLZCXVf3Xe+g9Z0Gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mj3r787E7r8yuMQTlUaHpcUlXBy6asQYYDzcPRrj/Cvkmn/Y4JqnZmUzgLbLVJzIb
         wFxaLTFh/361G1YnLLcQamt8pAX2poK/JTASzvrF20JO7wmnI1uKwh1IVsm8qwRhTu
         QMZncwIraKZ54uatY9Ouydl2YKsKJIXgkiK/giuqXNSyZ5y5Zn3u1NBoaXnOp+gnry
         q5saPfzUVfNK/6JcDJlEX37nRFT5pdNpfte4Jsnj/0/411ENSv9ZsieHTF2q+eVKIF
         QNWBfYnJ4jVeJ6wTLbNykTZfoA4XMopqz9d94QFlQdOgNOVpYxCpTUHGHMxDPW4kJ1
         MWw1HooFiqx1g==
Date:   Thu, 18 May 2023 16:07:40 +0100
From:   Lee Jones <lee@kernel.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, macro@orcam.me.uk,
        baolu.lu@linux.intel.com, yi.l.liu@intel.com, jirislaby@kernel.org,
        rostedt@goodmis.org, revest@chromium.org, gehao@kylinos.cn,
        akpm@linux-foundation.org, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, prabhakar.csengg@gmail.com,
        contact@emersion.fr, alex.williamson@redhat.com,
        akrowiak@linux.ibm.com, mark.rutland@arm.com,
        ye.xingchen@zte.com.cn, ojeda@kernel.org, me@kloenk.de,
        milan@mdaverde.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com
Subject: Re: [PATCH v7 2/6] mfd: tps6594: Add driver for TI TPS6594 PMIC
Message-ID: <20230518150740.GN404509@google.com>
References: <20230511095126.105104-1-jpanis@baylibre.com>
 <20230511095126.105104-3-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511095126.105104-3-jpanis@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023, Julien Panis wrote:

> This patch adds support for TPS6594 PMIC MFD core. It provides
> communication through the I2C and SPI interfaces, and supports
> protocols with embedded CRC data fields for safety applications.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/mfd/Kconfig         |   32 ++
>  drivers/mfd/Makefile        |    3 +
>  drivers/mfd/tps6594-core.c  |  462 ++++++++++++++++
>  drivers/mfd/tps6594-i2c.c   |  244 +++++++++
>  drivers/mfd/tps6594-spi.c   |  129 +++++
>  include/linux/mfd/tps6594.h | 1020 +++++++++++++++++++++++++++++++++++
>  6 files changed, 1890 insertions(+)
>  create mode 100644 drivers/mfd/tps6594-core.c
>  create mode 100644 drivers/mfd/tps6594-i2c.c
>  create mode 100644 drivers/mfd/tps6594-spi.c
>  create mode 100644 include/linux/mfd/tps6594.h

Applied - current being build tested.

Once complete, I'll send out a pull-request for the other maintainers.

-- 
Lee Jones [李琼斯]
