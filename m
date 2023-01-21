Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E896767BE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjAURhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjAURhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:37:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1970155A6;
        Sat, 21 Jan 2023 09:37:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE905B80816;
        Sat, 21 Jan 2023 17:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E336C433EF;
        Sat, 21 Jan 2023 17:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674322655;
        bh=/b4/ziqFFjwaenJEBEebkWxcGkMNgq9AICcY3Mxw+wY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JJIqDxYu1tV00/cjnaol6mnhTSpWhKxoawu8JX8kmqJ+teBf8uZcD8lvC0nHp6PDN
         KBp2TKcLLkrv1yXhLWxHNBagJ+9hBvdcwvHOQewwfv84Le/lw0/y2CgxAUN4UM05Lh
         UQDI8Eyv2yT/zOt9+ysU3G3iOt297NHrH1aOJ3g1spq9K5M/eIV5kumZSqFkjdfGsP
         qCYA8s6U14xmw/4QacbVBnEh9FvmmElZVkV5aSRk2lEENNk6Xzbe+Z28+XpmZjfFwg
         2yVMo7cVHnEplskUbtckbadi7CBTeTj6Kx1ay5p62Oq4C6lzQG03Kt68PDy5q6AvoI
         L01Vh4myKIMWQ==
Date:   Sat, 21 Jan 2023 17:51:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ktsai@capellamicro.com, lars@metafoo.de,
        Wahaj <wahajaved@protonmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: cm32181: Fix PM support on system with 2
 I2C resources
Message-ID: <20230121175120.526d3d16@jic23-huawei>
In-Reply-To: <3d51f766-bd80-870d-c939-99660526c654@redhat.com>
References: <20230118170422.339619-1-kai.heng.feng@canonical.com>
        <3d51f766-bd80-870d-c939-99660526c654@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 18:07:45 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 1/18/23 18:04, Kai-Heng Feng wrote:
> > Commit c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices
> > with 2 I2C resources") creates a second client for the actual I2C
> > address, but the "struct device" passed to PM ops is the first I2C
> > client that can't talk to the sensor.
> > 
> > That means the I2C transfers in both suspend and resume routines can
> > fail and blocking the whole suspend process.
> > 
> > Instead of using the first client for I2C transfer, use the I2C client
> > stored in the cm32181 private struct so the PM ops can get the correct
> > I2C client to really talk to the sensor device.
> > 
> > Fixes: 68c1b3dd5c48 ("iio: light: cm32181: Add PM support")
> > BugLink: https://bugs.launchpad.net/bugs/1988346
> > Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2152281
> > Tested-by: Wahaj <wahajaved@protonmail.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>  
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Regards,
> 
> Hans
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks

Jonathan

> 
> 
> 
> > ---
> > v2:
> >  - Removed setting drvdata to the dummy client.
> >  - Added bug links.
> >  - Wording.
> > 
> >  drivers/iio/light/cm32181.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> > index 001055d097509..b1674a5bfa368 100644
> > --- a/drivers/iio/light/cm32181.c
> > +++ b/drivers/iio/light/cm32181.c
> > @@ -440,6 +440,8 @@ static int cm32181_probe(struct i2c_client *client)
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> >  
> > +	i2c_set_clientdata(client, indio_dev);
> > +
> >  	/*
> >  	 * Some ACPI systems list 2 I2C resources for the CM3218 sensor, the
> >  	 * SMBus Alert Response Address (ARA, 0x0c) and the actual I2C address.
> > @@ -460,8 +462,6 @@ static int cm32181_probe(struct i2c_client *client)
> >  			return PTR_ERR(client);
> >  	}
> >  
> > -	i2c_set_clientdata(client, indio_dev);
> > -
> >  	cm32181 = iio_priv(indio_dev);
> >  	cm32181->client = client;
> >  	cm32181->dev = dev;
> > @@ -490,7 +490,8 @@ static int cm32181_probe(struct i2c_client *client)
> >  
> >  static int cm32181_suspend(struct device *dev)
> >  {
> > -	struct i2c_client *client = to_i2c_client(dev);
> > +	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> > +	struct i2c_client *client = cm32181->client;
> >  
> >  	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> >  					 CM32181_CMD_ALS_DISABLE);
> > @@ -498,8 +499,8 @@ static int cm32181_suspend(struct device *dev)
> >  
> >  static int cm32181_resume(struct device *dev)
> >  {
> > -	struct i2c_client *client = to_i2c_client(dev);
> >  	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> > +	struct i2c_client *client = cm32181->client;
> >  
> >  	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> >  					 cm32181->conf_regs[CM32181_REG_ADDR_CMD]);  
> 

