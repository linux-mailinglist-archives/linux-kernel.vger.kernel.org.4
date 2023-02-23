Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741976A0B67
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjBWOAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjBWOAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:00:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4E54DE08;
        Thu, 23 Feb 2023 06:00:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73C48B81992;
        Thu, 23 Feb 2023 14:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC2AC433EF;
        Thu, 23 Feb 2023 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677160822;
        bh=JnA0YflYHHHl3vV15cKiJ6n+ufwJedvbYA4DWUnOZqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XRq6tlF45FvNHoYoDknCzE78dgTRXSSI6wfHMArqK6s2Uteh4Tvl8OoaICbWURBvi
         syjmUsjjtQ8vWErRn/WRROQldKaI7h/JH/73InbgpIAOtMRpffOepREMruKi4ykqGU
         y22U4d/dD4gUIEmbSSaVgmNqIxMOnNURgkZ0q/ylp5rRb82RFFfEsAEajVGhNRkcB1
         LE5WOBJ0etEPGmFQQlcgTCHk8sxJpbd2UlT22SixTNVxrhE/9ruFk20wpfeW20CUXw
         Io06oD2hUqgK1Z+vI4Z0415pVQOlZMSJ4JzzRGrVlSQlULCIDeHGoqkbYuUm+kYaYX
         49j89g3DoO9Lw==
Date:   Thu, 23 Feb 2023 14:00:15 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Okan Sahin <okan.sahin@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <Y/dxb+PTm4ry3Bss@google.com>
References: <20230221103926.49597-1-okan.sahin@analog.com>
 <20230221103926.49597-6-okan.sahin@analog.com>
 <Y/S1ftKmV92TL8VO@smile.fi.intel.com>
 <Y/Y1p/4Mc1Oy4dWl@google.com>
 <Y/Y/Tv9CxgRkNESv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/Y/Tv9CxgRkNESv@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023, Andy Shevchenko wrote:

> On Wed, Feb 22, 2023 at 03:32:55PM +0000, Lee Jones wrote:
> > On Tue, 21 Feb 2023, Andy Shevchenko wrote:
> > > On Tue, Feb 21, 2023 at 01:39:13PM +0300, Okan Sahin wrote:
> 
> ...
> 
> > > > +#ifndef __MAX77541_MFD_H__
> > > > +#define __MAX77541_MFD_H__
> > > 
> > > Can we go towards consistency in this?
> > > Seems to me the most used patter so far is
> > > 
> > > #ifndef __LINUX_MFD_MAX77541_H
> > 
> > Drop the LINUX_ part please.
> 
> Wouldn't be better to get rid of its usage at once?
> Perhaps after v6.3-rc1 is out.

Patches always welcome.

-- 
Lee Jones [李琼斯]
