Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B1E661503
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 13:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjAHMY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 07:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAHMY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 07:24:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932B6260C;
        Sun,  8 Jan 2023 04:24:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43BB7B801C1;
        Sun,  8 Jan 2023 12:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B993C433D2;
        Sun,  8 Jan 2023 12:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673180693;
        bh=AvraLn3xLafT3m5CE80rVhLQyL81EEEpzfFaGD5yBRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZMuNsyRtv7Gqxt0eye/RxHGYBSeo3EPmfRCx6OlfS4Lgfe43gMvAQFXJsOvNZ735i
         VlH8GuMQz/CdWJgtPwkTWPT5H6BBcMq5yOz0xDb8hn9iX0txZoVQ9zLiW0sCeMntqb
         XuWifnTZiKSCkZjeg975F8Ll6WFGzPZn9G3QZWsiVueDy94SNmsIQglYcXTTGmnHls
         yWeV9rNWsWbdjEGeJtCeOSGmf+os3d/Km7ynSZ0/SkJxPxxmj9Fty4Lw8R9IsSCflq
         uo/FDstStlpaXRF5RZT7E3UZva3UDbHzaT78gejLCt1/rWl7qM2TyLJJe69pxZSpPf
         KKvDK4DYY58BA==
Date:   Sun, 8 Jan 2023 12:38:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iio: pressure: bmp280: Add support for new
 sensor BMP580
Message-ID: <20230108123820.7d917571@jic23-huawei>
In-Reply-To: <1efee3367f555ffe21895f68f2bdea64a38ba22a.camel@gmail.com>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
        <c053976f56c3810915ca2ead6c358b5997b782e5.1672062380.git.ang.iglesiasg@gmail.com>
        <20221230184535.6f684337@jic23-huawei>
        <1efee3367f555ffe21895f68f2bdea64a38ba22a.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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


> > > +static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64,
> > > 128 };
> > > +static const int bmp580_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32,
> > > 64, 128 };  
> > 
> > Up to you, but you could take advantage of the fact this array matches the
> > bmp380 one.
> > It is arguable that the code is clearer with it not being reused though so
> > your choice.  
> 
> Hum yes, I could reuse the array for the BMP380, maybe a should use a more
> generic name for that array to avoid confusion? Something like
> bmp280_iir_filter_coeffs_avail, refering to the driver name instead of the
> concrete sensor?

Don't worry about the naming. Anything clever just tends to cause
problems as more parts are added.  Just stick to the name of the first part
that used it.  We've made the mistake of trying for generic names in the
past and it bites back!


Jonathan

