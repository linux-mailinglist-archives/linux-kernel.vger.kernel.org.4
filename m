Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2B7641D74
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 15:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiLDOXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 09:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiLDOXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 09:23:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116D617418;
        Sun,  4 Dec 2022 06:23:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC9A2B80A49;
        Sun,  4 Dec 2022 14:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9EBC433D6;
        Sun,  4 Dec 2022 14:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670163808;
        bh=0jPUnNObV3bkM2t/29uwKFNurRLeu5QoW7vFZFxlKpA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NOajA0zJ41WVM6sdybnbEvWqDT5dhMEmKpL/JL5eG+qWGfyx377FzXvS7sCMmvwtg
         uzu86D5+Fg4bBJrUPu+lfCAQAhWF69b3hUDcl7kbK/SEcwApbiliwU0M2oJjdKMc0K
         gMY/b0S1NWgP9KSJeYIsvGPtpb3z7pq37jewfM0xYjgJyPqyKbv8+xqB3tIu5RLPA1
         bXTt58dbX8Jx/xhk9p1UJCYxdPX1VYwCJKO+iMPMlL4NZMDThiShP81KgzBo52+rdD
         sLFOW4MD0zQSjTTlFYG1OaFgto5AVg3tnSjRQTICkPK7HiCO5doGAAx4qPCH4j7jrD
         BM7ZPjDMfKLrw==
Date:   Sun, 4 Dec 2022 14:36:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Marco Pagani <marpagan@redhat.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: Re: [PATCH] iio: adc: xilinx-ams: fix devm_krealloc() return value
 check
Message-ID: <20221204143613.310ed016@jic23-huawei>
In-Reply-To: <7127c7f4-89b3-31f8-cabc-43f955eded64@amd.com>
References: <20221125113112.219290-1-marpagan@redhat.com>
        <7127c7f4-89b3-31f8-cabc-43f955eded64@amd.com>
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

On Wed, 30 Nov 2022 18:04:26 +0100
Michal Simek <michal.simek@amd.com> wrote:

> On 11/25/22 12:31, Marco Pagani wrote:
> > CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> > 
> > 
> > The clang-analyzer reported a warning: "Value stored to 'ret'
> > is never read".
> > 
> > Fix the return value check if devm_krealloc() fails to resize
> > ams_channels.
> > 
> > Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> > Signed-off-by: Marco Pagani <marpagan@redhat.com>
> > ---
> >   drivers/iio/adc/xilinx-ams.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> > index 5b4bdf3a26bb..a507d2e17079 100644
> > --- a/drivers/iio/adc/xilinx-ams.c
> > +++ b/drivers/iio/adc/xilinx-ams.c
> > @@ -1329,7 +1329,7 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
> > 
> >          dev_channels = devm_krealloc(dev, ams_channels, dev_size, GFP_KERNEL);
> >          if (!dev_channels)
> > -               ret = -ENOMEM;
> > +               return -ENOMEM;
> > 
> >          indio_dev->channels = dev_channels;
> >          indio_dev->num_channels = num_channels;
> > --
> > 2.38.1
> >   
> 
> Acked-by: Michal Simek <michal.simek@amd.com>

Applied to the fixes-togreg branch of iio.git.  Given merge window opening soon
it might be a few weeks before this goes upstream.

Thanks,

Jonathan

> 
> Thanks,
> Michal

