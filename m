Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3337E661509
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 13:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjAHM1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 07:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAHM1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 07:27:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ED85FF6;
        Sun,  8 Jan 2023 04:27:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CCFDB803F1;
        Sun,  8 Jan 2023 12:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE89CC433D2;
        Sun,  8 Jan 2023 12:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673180858;
        bh=SysmkJ2JIR01nOEshO/fIKEwvXowTeVYSoVagST5Cpg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B0OmM6FuLJMP+S/U9VXdgGJwlah8jcdY+zNTEKHLZZ3bD6krzhav+Y3/kI2vHtFa6
         qVvE7K+r9Uj/GyL1/QcxXUAj+7QkY9/gQ4Hlvo/+vEG6QZM9BxiRy5MwzcZE0q8PDF
         I6GMStTpDkCbfgLZxfjpY/6whUoxtyit9d/KdcxuoZRPj4WUN/QFFS4Kv9E33OYAdZ
         iggZdHjxPBGvD4yQipewfC7QH41fft4i1HwN4M6h7iZw92bqzM0sUz11ts7QY3aqLF
         PeyqLyGjs9aDslKSBcI45ghzlN3tliOsi4pzP4i7HNI5eWU/pBDwGxN1Nk/A0pW1zX
         f39ZNtbjKcrUw==
Date:   Sun, 8 Jan 2023 12:41:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iio: pressure: bmp280: Add enumeration to handle
 chip variants
Message-ID: <20230108124105.1cdc5627@jic23-huawei>
In-Reply-To: <e13c4e3962923994c853b115a5606633387991db.camel@gmail.com>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
        <f0368a3f460707417110dffdb0166824da20af15.1672062380.git.ang.iglesiasg@gmail.com>
        <Y6tlpP2SgsgoVBrK@smile.fi.intel.com>
        <e13c4e3962923994c853b115a5606633387991db.camel@gmail.com>
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

On Sun, 01 Jan 2023 12:04:40 +0100
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> On Tue, 2022-12-27 at 23:37 +0200, Andy Shevchenko wrote:
> > On Mon, Dec 26, 2022 at 03:29:20PM +0100, Angel Iglesias wrote:  
> > > Adds enumeration to improve handling the different supported sensors
> > > on driver initialization. This avoid collisions if different variants
> > > share the same device idetifier on ID register.  
> > 
> > As per v1, use pointers in the ID tables.
> >   
> 
> Taking your suggestion and Jonathan's remarks into account seems to me like the
> best approach here is using chip_info pointer for each driver as the pointer set
> on the id tables.

Yes.

> As in the i2c and spi drivers, the enum is used to fetch the
> correct regmap configuration, and later in the shared probe, the chip_info. The
> logical follow-up would be adding the regmap configuration to the chip_info,
> right?

Makes sense.

> Or is there a better solution I'm not seeing right now?

If I'm understanding what you have above, then this is exactly what we would
want to do here.

Thanks,

Jonathan

> 
> Thanks for your time,
> Angel

