Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73B66BBB71
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjCORxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjCORxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:53:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4378B457;
        Wed, 15 Mar 2023 10:53:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F496B81E9C;
        Wed, 15 Mar 2023 17:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7F4C433EF;
        Wed, 15 Mar 2023 17:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678902784;
        bh=SSI6OsMk+hcBcDh6ztCIf0vVPs05ho51S/3qhZyQj3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjvUS+qSEQN2X8Spj4a3Iit7ZU2b0uZ0CegWEggrPc/ReoVgxFVmb8dHAWv6OzsXX
         7omdtxQus/u+XpIGuCcJjTk714L0/6XcjQEQvRUyheGcrM8LiY3Zgwe0E4K9HiRoyi
         AOE2Cv7e1x53SKx6zoBWmOP0/O2mFdIG+kPhXFCqHwk4PUuAzo5rbTwDviuqu4iRZK
         gf6aQtzNZ9DEtjqB5wvSMKP5LCkBMaxzC+lKkwu7I2S1oAGuim9ugPVAVMRsdWCBx5
         sCEPmtmaO8KPXnz3ymTW//BUmeu+hHJlyZouwVcFoc/XqB0ydf1LuSRz65NVEurIR6
         P8mXTYdigf7Lg==
Date:   Wed, 15 Mar 2023 17:52:57 +0000
From:   Lee Jones <lee@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <20230315175257.GJ9667@google.com>
References: <20230307112835.81886-1-okan.sahin@analog.com>
 <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230315175223.GI9667@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023, Lee Jones wrote:

> On Tue, 07 Mar 2023, Okan Sahin wrote:
>
> > MFD driver for MAX77541/MAX77540 to enable its sub
> > devices.
> >
> > The MAX77541 is a multi-function devices. It includes
> > buck converter and ADC.
> >
> > The MAX77540 is a high-efficiency buck converter
> > with two 3A switching phases.
> >
> > They have same regmap except for ADC part of MAX77541.
> >
> > Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> > ---
> >  drivers/mfd/Kconfig          |  13 ++
> >  drivers/mfd/Makefile         |   1 +
> >  drivers/mfd/max77541.c       | 224 +++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/max77541.h |  97 +++++++++++++++
> >  4 files changed, 335 insertions(+)
> >  create mode 100644 drivers/mfd/max77541.c
> >  create mode 100644 include/linux/mfd/max77541.h
>
> FYI: I'm not re-reviewing this since you've chosen to ignore some of my
> previous review comments.  Issues highlighted by review comments don't
> just go away on resubmission.

... and the subject is malformed.

--
Lee Jones [李琼斯]
