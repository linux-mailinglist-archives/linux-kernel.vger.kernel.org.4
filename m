Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17724626A45
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiKLPhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLPhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:37:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2FF1758F;
        Sat, 12 Nov 2022 07:37:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 871126068A;
        Sat, 12 Nov 2022 15:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94205C433C1;
        Sat, 12 Nov 2022 15:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668267435;
        bh=QflFnRa/zdMTL17M319ygZkJ5mADdj1qWoRO1wd8ejM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=liKvT+yD9NTJ+NGE4LMcQ4EV2XrDkEoB9/cWYTKDDPs4buJfPrqI+RDyNue2lQ461
         3LUWlhHy7R/bJ61QgeI2FlQEaNAFv5Qkz7r+Bqh4ZGj4xasS22GITMcRH208XH6LtC
         jZ6BKjENQy/repG4/yGHkkpTqCKZ4Uhg4v+xUf35HI3/rGScwz+101oQ22sp5ytEsq
         9FOzZi+8L5eRJfSxqa7PjMK2d2807Hb+GdpgXohL/RrUrswoVIiFmksowiUb9H/iqn
         qSGuvUSh0DbteyFuJVWKx+qcoAMcRRQ6R/GLB1H9pTHKwISwT+GRZKhj9ge10BcH1x
         g1HHGQnuMxBWg==
Date:   Sat, 12 Nov 2022 15:49:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hid-sensor-custom: Allow more than one hinge angle
 sensor
Message-ID: <20221112154931.7023bc11@jic23-huawei>
In-Reply-To: <Y2gRzHpH5FwNVBoO@jeknote.loshitsa1.net>
References: <20221105223422.417316-1-jekhor@gmail.com>
        <20221106173643.5b4f2a0b@jic23-huawei>
        <Y2gRzHpH5FwNVBoO@jeknote.loshitsa1.net>
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

On Sun, 6 Nov 2022 21:58:04 +0200
Yauhen Kharuzhy <jekhor@gmail.com> wrote:

> On Sun, Nov 06, 2022 at 05:36:43PM +0000, Jonathan Cameron wrote:
> > On Sun,  6 Nov 2022 00:34:22 +0200
> > Yauhen Kharuzhy <jekhor@gmail.com> wrote:
> >   
> > > Some devices has two sets of accelerometers and the sensor hub exports
> > > two hinge angle 'sensors' based on accelerometer values. To allow more
> > > than one sensor of the same type, use PLATFORM_DEVID_AUTO instead of
> > > PLATFORM_DEVID_NONE when registering platform device for it.
> > > 
> > > Checked on the Lenovo Yoga Book YB1-X91L tablet.
> > > 
> > > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>  
> > 
> > Purely for curiosity sake, but where are the two sets of sensors?
> > Doesn't look like it has two hinges at first glance!  
> 
> It sounds crazy, yes :)
> 
> The Lenovo Yoga Book YB1-X91L looks to be strange device in many ways.
> 
> There are two accelerometers at display side and two at keyboard side (for
> detecting the rotation movement as I understand). For
> some reasons ISH exposed two virtual hinge angle sensors (I guess that
> one for each pair of accelerometers):
> 
> ...
> [    6.230627] Registering platform device 'HID-SENSOR-INT-020b.35.auto'. Parent at 001F:8087:0AC2.0005
> [    6.230658] device: 'HID-SENSOR-INT-020b.35.auto': device_add
> [    6.230705] bus: 'platform': add device HID-SENSOR-INT-020b.35.auto
> [    6.230737] PM: Adding info for platform:HID-SENSOR-INT-020b.35.auto
> ...
> [    6.249248] Registering platform device 'HID-SENSOR-INT-020b.36.auto'. Parent at 001F:8087:8AC2.0006
> [    6.249266] device: 'HID-SENSOR-INT-020b.36.auto': device_add
> [    6.249295] bus: 'platform': add device HID-SENSOR-INT-020b.36.auto
> [    6.249394] PM: Adding info for platform:HID-SENSOR-INT-020b.36.auto
> 
> This is senseless but it is what it is. Moreover, this 'sensor' is always
> returns 360 degrees angle, although display and keyboard 'absolute' angles are
> reported correctly.
> 
> In any way, this patch is generic and will be useful for other custom HID
> sensors if they will be added in the future.

Thanks for the explanation.

Far as I'm concerned patch seems sensible.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/hid/hid-sensor-custom.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> > > index 32c2306e240d6..a6fc89ee1287c 100644
> > > --- a/drivers/hid/hid-sensor-custom.c
> > > +++ b/drivers/hid/hid-sensor-custom.c
> > > @@ -862,7 +862,7 @@ hid_sensor_register_platform_device(struct platform_device *pdev,
> > >  		return ERR_PTR(-ENOMEM);
> > >  
> > >  	custom_pdev = platform_device_register_data(pdev->dev.parent, dev_name,
> > > -						    PLATFORM_DEVID_NONE, hsdev,
> > > +						    PLATFORM_DEVID_AUTO, hsdev,
> > >  						    sizeof(*hsdev));
> > >  	kfree(dev_name);
> > >  	return custom_pdev;  
> >   
> 

