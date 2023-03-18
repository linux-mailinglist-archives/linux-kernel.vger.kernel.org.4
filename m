Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A216BFB8A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 17:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCRQ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 12:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCRQ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 12:28:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B3D2333D;
        Sat, 18 Mar 2023 09:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA5D260EC3;
        Sat, 18 Mar 2023 16:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1699C433EF;
        Sat, 18 Mar 2023 16:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679156934;
        bh=6u+K4+K5Z74SQQmluznTbauRm8INr+Z3QXBoXsZzHmA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hyCF1CoZ0amuXKk21MGVPfZL4EahjCfww0pWejX3fmSSXENLO9m9UqRIi/URQxzDN
         UqiFuQoqOqNJI5J2LS6b9iw7u798gby89vPRCvFBy8pG/Q4K0U3b4NoV4npiPItWmh
         Q/Hgit38vrQ6HdjuJbsMc5OW5wb/q1J81SIr3lFkOhSmrwz/nCdNnVHWBBUVrDP8nA
         GQsvlB2Rek7UClcy60rJdD3JG1rUExymT0Yw2uY4jiFs3GkfWPMAXgykAeoHUx7daQ
         j457owuSlLxKIX/ZY56EAyOg8TCqRHAcETWDdgisZA1LamVPXcOdwyAKhoRubqTwRZ
         f8Trx4+StfG/A==
Date:   Sat, 18 Mar 2023 16:43:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] iio: dac: cio-dac: Migrate to the regmap API
Message-ID: <20230318164347.1e96325c@jic23-huawei>
In-Reply-To: <ZAzQ6LyfllSjN16j@fedora>
References: <20230311140218.74920-1-william.gray@linaro.org>
        <20230311185719.7af38a8a@jic23-huawei>
        <ZAzQ6LyfllSjN16j@fedora>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Sat, 11 Mar 2023 14:05:12 -0500
William Breathitt Gray <william.gray@linaro.org> wrote:

> On Sat, Mar 11, 2023 at 06:57:19PM +0000, Jonathan Cameron wrote:
> > On Sat, 11 Mar 2023 09:02:18 -0500
> > William Breathitt Gray <william.gray@linaro.org> wrote:  
> > > diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
> > > index 791dd999cf29..759833a6bd29 100644
> > > --- a/drivers/iio/dac/cio-dac.c
> > > +++ b/drivers/iio/dac/cio-dac.c
> > > @@ -6,16 +6,15 @@
> > >   * This driver supports the following Measurement Computing devices: CIO-DAC16,
> > >   * CIO-DAC06, and PC104-DAC06.
> > >   */
> > > -#include <linux/bitops.h>
> > > +#include <linux/bits.h>  
> > 
> > I'm not immediately spotting why this change is part of the regmap
> > conversion.
> > 
> > It may well make sense, but if unrelated, should probably be in a different patch.  
> 
> No you're right, this is an unrelated cleanup that I should probably
> have pulled out to its own dedicated patch. If there is a need for a v3,
> I'll split this off and submit it separately.
> 
Not other comments, so meh. I've had my moan :)

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to see if it can find anything we missed.

Thanks,

Jonathan

> William Breathitt Gray

