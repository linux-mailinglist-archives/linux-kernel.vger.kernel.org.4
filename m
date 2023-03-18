Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3376BFC6D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 20:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCRTao convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 18 Mar 2023 15:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCRTam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 15:30:42 -0400
X-Greylist: delayed 453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Mar 2023 12:30:38 PDT
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83A4126C2;
        Sat, 18 Mar 2023 12:30:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 69E743F5E2;
        Sat, 18 Mar 2023 20:23:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_FAIL,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3A7BtjkLRbWz; Sat, 18 Mar 2023 20:23:02 +0100 (CET)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 827B33F5C8;
        Sat, 18 Mar 2023 20:23:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 9F8388EA6E;
        Sat, 18 Mar 2023 19:22:56 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AqFeWma4NS-3; Sat, 18 Mar 2023 19:22:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 744628EA68;
        Sat, 18 Mar 2023 19:22:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VpF76MdvOTDk; Sat, 18 Mar 2023 19:22:50 +0000 (UTC)
Received: from dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id E7AB28EA63;
        Sat, 18 Mar 2023 19:22:49 +0000 (UTC)
Date:   Sat, 18 Mar 2023 20:22:53 +0100
From:   Patrik =?iso-8859-1?Q?Dahlstr=F6m?= <risca@dalakolonin.se>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hns@goldelico.com
Subject: Re: [PATCH] iio: adc: palmas_gpadc: fix NULL dereference on rmmod
Message-ID: <20230318192253.GB3605556@dalakolonin.se>
References: <20230313205029.1881745-1-risca@dalakolonin.se>
 <20230318163033.161d6fd5@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230318163033.161d6fd5@jic23-huawei>
Content-Transfer-Encoding: 8BIT
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 04:30:33PM +0000, Jonathan Cameron wrote:
> On Mon, 13 Mar 2023 21:50:29 +0100
> Patrik Dahlström <risca@dalakolonin.se> wrote:
> 
> > Calling dev_to_iio_dev() on a platform device pointer is undefined and
> > will make adc NULL.
> > 
> > Signed-off-by: Patrik Dahlström <risca@dalakolonin.se>
> 
> Hi Patrik,
> 
> Looks good so applied to the fixes-togreg branch of iio.git.
> 
> Whilst we are here, this would be a trivial driver to take fully device
> managed.  The only slightly messy bit is that it would need
> a devm_add_action_or_reset() + custom callback to handle the
> device_wakeup_enable().
> 
> On the off chance you can test it I'll send a patch in a few mins.
> Note that will depend on this one going up stream first and that
> I haven't done more than build test it.
I got the patch and it looks good, but it will take a few days before I
have the time to test it.

I have some more patches coming for this driver to configure the adc
thresholds from userspace, employing the iio channel event subsystem, but
they need a bit more work. In particular, to ensure backwards compatibility
with the adc_wakeupX_data platform data. However, I don't see this platform
data being used by anyone.
How important is it to retain support for adc_wakeupX_data?
> 
> Thanks,
> 
> Jonathan

Thank you for going the extra mile :)
> 
> 
> > ---
> >  drivers/iio/adc/palmas_gpadc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> > index 61e80bf3d05e..6db6f3bc768a 100644
> > --- a/drivers/iio/adc/palmas_gpadc.c
> > +++ b/drivers/iio/adc/palmas_gpadc.c
> > @@ -638,7 +638,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
> >  
> >  static int palmas_gpadc_remove(struct platform_device *pdev)
> >  {
> > -	struct iio_dev *indio_dev = dev_to_iio_dev(&pdev->dev);
> > +	struct iio_dev *indio_dev = dev_get_drvdata(&pdev->dev);
> >  	struct palmas_gpadc *adc = iio_priv(indio_dev);
> >  
> >  	if (adc->wakeup1_enable || adc->wakeup2_enable)
> 
