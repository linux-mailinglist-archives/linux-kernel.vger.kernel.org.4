Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9160E6D310D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 15:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDANaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 09:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDANaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 09:30:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62D03AB5;
        Sat,  1 Apr 2023 06:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28E2C60909;
        Sat,  1 Apr 2023 13:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2FFC433D2;
        Sat,  1 Apr 2023 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680355808;
        bh=r3oFw2s2cuB7y9FHYeEVs9HnftQHY2aRB2DbWbl2xEc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IPTrFPR4Zjc3mzHt1Bpq0/poqXX6FFL2z3BCXAI2/2t3kdI2KTjen44Ch0kIt5Ih5
         2zN9+KQLucA4Sl7LuKPZFT272RDi6343FWJ/jlkP6zhlAEocb73Jco+kiDYI3mRVoo
         FtYbshnSNLmXPMywFYx5FYVJPv2fcqEB8rmm8Sa/RgQOAdcNibuz1l5zfvt03tEX29
         deKCOJw/6smCr60LbIeobauxqQpvLQCyZzs1YYo9OITjqvAEQ41M4Ty2PWjmTuBwyq
         ROiDkvHt8099DK3dCeZavXJNzdDxU3cHlXSZYo0fQjTHaYyzryTtgIfQAyr5jwnGR4
         34lXRV10N+4Vg==
Date:   Sat, 1 Apr 2023 14:45:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] iio: addac: stx104: Migrate to the regmap API
Message-ID: <20230401144517.4ad446e1@jic23-huawei>
In-Reply-To: <ZCC1bhdHymSBMQOX@fedora>
References: <20230324030916.396569-1-william.gray@linaro.org>
        <20230326164920.1e4575f9@jic23-huawei>
        <ZCC1bhdHymSBMQOX@fedora>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2023 17:13:18 -0400
William Breathitt Gray <william.gray@linaro.org> wrote:

> On Sun, Mar 26, 2023 at 04:49:20PM +0100, Jonathan Cameron wrote:
> > On Thu, 23 Mar 2023 23:09:16 -0400
> > William Breathitt Gray <william.gray@linaro.org> wrote:
> >   
> > > The regmap API supports IO port accessors so we can take advantage of
> > > regmap abstractions rather than handling access to the device registers
> > > directly in the driver.
> > > 
> > > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>  
> > 
> > I would have preferred slightly if you had avoided reording the probe
> > (previously gpio chip was registered before iio device and now it is after)
> > but it make no real difference so I'm not that bothered.
> > 
> > A few other minor comments. Biggest one being that the defines should be
> > prefixed.
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> Hi Jonathan,
> 
> I'll be submitting a v3 soon addressing your comments as well as some
> minor fixes to v2; I'll make the regmap_read_poll_timeout() change as a
> follow-up patch as suggested.
> 
> Regarding the GPIO code reordering in the probe, I decided to move it
> after the iio device registration so that all the IIO-related code is
> grouped together and finished before we deal with GPIO-related stuff.
> Given that all the original gpio chip code is removed anyway in this
> patch, I figure this is a minor enough cleanup to perform here. If you
> aren't too strongly opposed to this change I'll keep it in v3 as it
> avoids the hassle of creating a separate patch for such a trivial
> change.
That's fine, just call it out in the patch description as a 
"While making these changes, also ..." or similar.

Jonathan

> 
> William Breathitt Gray

