Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C69636B76
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbiKWUoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiKWUoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:44:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614C4B3E;
        Wed, 23 Nov 2022 12:44:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15D83B82479;
        Wed, 23 Nov 2022 20:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1276FC433D6;
        Wed, 23 Nov 2022 20:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669236257;
        bh=blYSzKUNc7T988paAGw1Il7D1vmiMKzkZW2yOWCzzlg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hE7THTRUjsqqpPzD1p2zT+Sgxpmvspx3KLbpcQGOZr2BmnKf70NEIbO7heL7VJx+X
         1M3JcHc209FIGLf4HtLpfNu06csLx46ZQRgpbZTDuamESCHaRw7Fq+gtnX4JdHMKWJ
         Aqt0uZe7C0pRUR4g7/Hbp26I+BhIRaXtT61gvr9QOybqjcFFy3b6+yXi/UzH0c8Ext
         rrworE6PHYCtU6gbWMsyFxfDpue0ay2EMtA4JgFwdBWQybY73Xpy1y6cIjNDC6uzbf
         nGSNXNutBibXCa+eeHNpgSnLi5Zmonjt2vhCvelH4icfgryzAe0zlzYmDXGHLzFQbQ
         RdhpiD65GLmgQ==
Date:   Wed, 23 Nov 2022 20:56:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] iio: adc: stm32: add smart calibration
Message-ID: <20221123205650.3be4ee4e@jic23-huawei>
In-Reply-To: <f7a2a680-4879-b6cf-3546-e890b3c96e32@foss.st.com>
References: <20221115103124.70074-1-olivier.moysan@foss.st.com>
        <f7a2a680-4879-b6cf-3546-e890b3c96e32@foss.st.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 12:04:36 +0100
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 11/15/22 11:31, Olivier Moysan wrote:
> > Refine offset and linear calibration strategy for STM32MP15 and
> > STM32MP13 SoCs:
> > 
> > - offset calibration
> > This calibration depends on factors such as temperature and voltage.
> > As it is not time consuming, it's worth doing it on each ADC
> > start, to get the best accuracy. There is no need to save these data.
> > 
> > - linear calibration
> > This calibration is basically SoC dependent, so it can be done only once.
> > When this calibration has been performed at boot stage, the ADC kernel
> > driver can retrieve the calibration data from the ADC registers.
> > Otherwise, the linear calibration is performed once by the ADC driver.
> > The backup of these data, allows to restore them on successive ADC starts.
> > 
> > Olivier Moysan (3):
> >   iio: adc: stm32-adc: smart calibration support
> >   iio: adc: stm32-adc: improve calibration error log
> >   iio: adc: stm32-adc: add debugfs to read raw calibration result  
> 
> Hi Olivier,
> 
> For the series, you can add my:
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Applied to the togreg branch of iio.git and pushed out as testing to let
0-day have a first look at it.

Thanks,

Jonathan

> 
> Thanks,
> Fabrice
> 
> > 
> >  drivers/iio/adc/stm32-adc-core.h |   1 +
> >  drivers/iio/adc/stm32-adc.c      | 135 ++++++++++++++++++-------------
> >  2 files changed, 78 insertions(+), 58 deletions(-)
> >   

