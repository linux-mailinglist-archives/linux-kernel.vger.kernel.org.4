Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2559E6E3288
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDOQsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjDOQsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:48:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFEE49DD;
        Sat, 15 Apr 2023 09:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E1DB6118B;
        Sat, 15 Apr 2023 16:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB10C433D2;
        Sat, 15 Apr 2023 16:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681577292;
        bh=XgxGW/VG1ZWpaRm19HFYT5p/Z/LdvDSX050Y+KzJav8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AM1eRDmnk30Q7/FQ3XKm13pt01fak+33jT/tEG1SxfYq8i6tKjQ4+DRcI3TN2+oLR
         xF0R1Kkm7Uz4/yTSbc/8k4IMTsaTDK2M9mZ86+HPE1TJEJj+aE0YhcHmxf+ORUrWIo
         NCpQNpuLVGcjaPwXvVlPz4X02HbqCC83U+Kv8FS28okXzlDhzn7m7on9VLuqSC+coI
         4ZKBR2iPh72jr4cAN7zc+XlM7q1yp1DO8IWGa8IWxwXQUMkc1ghBHXJhiKIAP9Jjwo
         tEaiBBtOBt0pxf5cEgKN/V14Ea8rcqy/tZTmQwdFJqQ6qUyummDg4KAgA1FsIkUjqr
         RG6YZecihQRKA==
Date:   Sat, 15 Apr 2023 17:48:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH 1/3] iio: core: add IIO_VAL_INT_MICRO
Message-ID: <20230415174813.14149d79@jic23-huawei>
In-Reply-To: <6b0e2cd2-b419-8474-c53c-81449b8f6325@gmail.com>
References: <cover.1681301472.git.mazziesaccount@gmail.com>
        <d31f2ebf08837337d3bbc6a00fd4b5eb3c86a04e.1681301472.git.mazziesaccount@gmail.com>
        <20230412213208.49912897@jic23-huawei>
        <6b0e2cd2-b419-8474-c53c-81449b8f6325@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 08:48:08 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Jonathan,
> 
> On 4/12/23 23:32, Jonathan Cameron wrote:
> > On Wed, 12 Apr 2023 15:27:14 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> There are a few cases like light sensor integration times, where values
> >> returned from *_available() and read_raw() are smaller than 1 and often
> >> in the units of micro. (Like micro second scale integration times,
> >> always smaller than 1 second). Currently those are often handled using
> >> IIO_VAL_INT_PLUS_MICRO, which requires drivers to initialize the integer
> >> part to zero. Furthermore, using IIO_VAL_INT_PLUS_MICRO in iio lists
> >> requires one to always allocate the 'dummy' integer part too.
> >>
> >> Introduce IIO_VAL_INT_MICRO which allows omitting the always zero integer.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> > Hi Matti,
> > 
> > I'm not keen on adding yet another case just to avoid having to
> > have the integer part for IIO_VAL_INT_PLUS_MICRO.
> > Seems like the wrong trade off of maintainability vs ease of use.  
> 
> I see your point. I would still argue that adding the IIO_VAL_INT_MICRO 
> was not really an intrusive change and I'd expect the maintenance effort 
> should not be increased that much.

Little things add up. :(

> 
> While the inconvenience for users in read_raw (initializing the *val = 
> 0) is minor (meaning the benefit of adding IIO_VAL_INT_MICRO is also 
> minor in this regard), iio_lists are stronger reason to consider this. 
> With IIO_VAL_INT_MICRO the iio-list memory footprint will be halved. In 
> my opinion, this benefit would exceed the cost of maintenance effort 
> increase - sure thing it's easy for me to say as I am not the maintainer 
> ;) (And as I wrote, this series was cooked in a hurry - I had no time to 
> go through existing drivers to see how many could benefit from the new 
> IIO_VAL_INT_MICRO. I may do this later when I get some pretty urgent 
> things off my shoulders - assuming you're not opposing this change so 
> strongly that this is out of the question no matter how many existing 
> users could benefit from IIO_VAL_INT_MICRO).
> 
> Anyways, if this is your final stance, then I need to rework the 
> integration time list allocations in the gts helper, but I am most 
> likely not able to do this until a week or two from now - meaning it 
> might be better to revert the bu27034 and iio-gts-helpers until this 
> gets fixed. (I reserve the right to do this during some night if I can't 
> get sleep though.)

I don't think I'll be convinced on this for a couple of reasons:
1) It will inevitably lead to IIO_VAL_INT_NANO etc
2) There are other places this matters such as consumer drivers that
   have to cope with a bunch of possible return types from accessing
   read_raw and write_raw via the in kernel interfaces.
   For example see drivers/iio/afe/iio-rescale.c 

That might feel like it doesn't matter for your device (which is true)
we would want wide use and that means a bunch of special casing
in the more generic consumer drivers and potentially even in the
specific ones that are scattered in various other kernel subsystems.

Hence please rework this to add the annoying 0s.

Thanks,

Jonathan


> 
> Yours,
> 	-- Matti
> 
> > Jonathan
> >   
> >> ---
> >>   drivers/iio/industrialio-core.c | 4 ++++
> >>   include/linux/iio/types.h       | 1 +
> >>   2 files changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> >> index c117f50d0cf3..c5ae965e9961 100644
> >> --- a/drivers/iio/industrialio-core.c
> >> +++ b/drivers/iio/industrialio-core.c
> >> @@ -628,6 +628,8 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
> >>   	switch (type) {
> >>   	case IIO_VAL_INT:
> >>   		return sysfs_emit_at(buf, offset, "%d", vals[0]);
> >> +	case IIO_VAL_INT_MICRO:
> >> +		return sysfs_emit_at(buf, offset, "0.%06u", vals[0]);
> >>   	case IIO_VAL_INT_PLUS_MICRO_DB:
> >>   		scale_db = true;
> >>   		fallthrough;
> >> @@ -758,6 +760,7 @@ static ssize_t iio_format_list(char *buf, const int *vals, int type, int length,
> >>   
> >>   	switch (type) {
> >>   	case IIO_VAL_INT:
> >> +	case IIO_VAL_INT_MICRO:
> >>   		stride = 1;
> >>   		break;
> >>   	default:
> >> @@ -952,6 +955,7 @@ static ssize_t iio_write_channel_info(struct device *dev,
> >>   		case IIO_VAL_INT_PLUS_MICRO_DB:
> >>   			scale_db = true;
> >>   			fallthrough;
> >> +		case IIO_VAL_INT_MICRO:
> >>   		case IIO_VAL_INT_PLUS_MICRO:
> >>   			fract_mult = 100000;
> >>   			break;
> >> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> >> index 82faa98c719a..b4e316172c7f 100644
> >> --- a/include/linux/iio/types.h
> >> +++ b/include/linux/iio/types.h
> >> @@ -30,6 +30,7 @@ enum iio_event_info {
> >>   #define IIO_VAL_FRACTIONAL 10
> >>   #define IIO_VAL_FRACTIONAL_LOG2 11
> >>   #define IIO_VAL_CHAR 12
> >> +#define IIO_VAL_INT_MICRO 13 /* val is micro <units>. Integer part is 0 */
> >>   
> >>   enum iio_available_type {
> >>   	IIO_AVAIL_LIST,  
> >   
> 

