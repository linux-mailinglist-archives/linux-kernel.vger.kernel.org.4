Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FE86A2F6F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 13:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBZMlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 07:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZMlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 07:41:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADEB113D2;
        Sun, 26 Feb 2023 04:41:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E824060B5B;
        Sun, 26 Feb 2023 12:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F15C433EF;
        Sun, 26 Feb 2023 12:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677415290;
        bh=U+H3sMXx4UzLJyBE2yHjou3cJfrlQRuUZ9rlEx2Vofs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YXq1DQGwN7b8EWlm+DB/TTANmDYW97G3YJbpXjwwjnUuftihRX95VzzkF/iBfav26
         daaWqCLaO79hNL5VxW61sK8b74OCDMw6v3+d0eYJnikd1YHe10fUJ+0pFtetCz0U6X
         viKZ8yCokO8KVPecQMJ0EldZA4LSKrn6XJq7onIl5EwlxnizsyoDL5iUv6C0rF4HA0
         NrhREl8ibuffp5DuDJ7kcY2P4Z6sWDTh66roxxReWsy/Z1zJGkZ4Nr5rawTJMxt2pn
         FMRiH4zmcr92bQf/Y3MrmblvTamwFYizk/IB1RXFjaNSlKfztJfJibsIEb4nB4tvoI
         L6+dWPch5wukw==
Date:   Sun, 26 Feb 2023 12:55:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>, lars@metafoo.de,
        Kevin Tsai <ktsai@capellamicro.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: light: cm32181: Unregister second I2C client if
 present
Message-ID: <20230226125555.32fe6a96@jic23-huawei>
In-Reply-To: <031354f0-be2f-fe59-4ca9-b8196e5e87fa@redhat.com>
References: <20230223020059.2013993-1-kai.heng.feng@canonical.com>
        <031354f0-be2f-fe59-4ca9-b8196e5e87fa@redhat.com>
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

On Thu, 23 Feb 2023 09:41:29 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 2/23/23 03:00, Kai-Heng Feng wrote:
> > If a second dummy client that talks to the actual I2C address was
> > created in probe(), there should be a proper cleanup on driver and
> > device removal to avoid leakage.
> > 
> > So unregister the dummy client via another callback.
> > 
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Suggested-by: Hans de Goede <hdegoede@redhat.com>
> > Fixes: c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices with 2 I2C resources")
> > Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2152281
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>  
> 
> Thanks this patch looks good to me now, and you
> already added my Reviewed-by, so from my POV this
> is ready for merging now.
> 
Applied to the fixes-togreg branch of iio.git and marked for stable inclusion.

Thanks,

Jonathan

> Regards,
> 
> Hans
> 
> > ---
> > v4:
> >  - Remove logging kmalloc failures.
> > 
> > v3:
> >  - Use devm_add_action_or_reset() in a correct place.
> >  - Wording.
> > 
> > v2:
> >  - Use devm_add_action_or_reset() instead of remove() callback to avoid
> >    race.
> > 
> >  drivers/iio/light/cm32181.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> > index b1674a5bfa368..d4a34a3bf00d9 100644
> > --- a/drivers/iio/light/cm32181.c
> > +++ b/drivers/iio/light/cm32181.c
> > @@ -429,6 +429,14 @@ static const struct iio_info cm32181_info = {
> >  	.attrs			= &cm32181_attribute_group,
> >  };
> >  
> > +static void cm32181_unregister_dummy_client(void *data)
> > +{
> > +	struct i2c_client *client = data;
> > +
> > +	/* Unregister the dummy client */
> > +	i2c_unregister_device(client);
> > +}
> > +
> >  static int cm32181_probe(struct i2c_client *client)
> >  {
> >  	struct device *dev = &client->dev;
> > @@ -460,6 +468,10 @@ static int cm32181_probe(struct i2c_client *client)
> >  		client = i2c_acpi_new_device(dev, 1, &board_info);
> >  		if (IS_ERR(client))
> >  			return PTR_ERR(client);
> > +
> > +		ret = devm_add_action_or_reset(dev, cm32181_unregister_dummy_client, client);
> > +		if (ret)
> > +			return ret;
> >  	}
> >  
> >  	cm32181 = iio_priv(indio_dev);  
> 

