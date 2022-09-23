Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEAD5E768A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiIWJMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiIWJMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:12:31 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3356912E40E;
        Fri, 23 Sep 2022 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663924350; x=1695460350;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7crnXgUhmUDKPsinAJs7KiF3E10gRKIRmlXb6HsKEMk=;
  b=KCyofKMh+kqeVk85vpLLqymkQI6OTuMlP9Jc3T7Tbwxly6P7tljFHgAQ
   VWGK3m6jKURR3eOSPX1b5r0MS510xbdieSRHwNY7pOw93pQl3RBBvqz2d
   7kGIAyIB+evUhx0ukmrU1Q5lg4yqG5jVznRGd6knlaspWCmnYsBKnesLK
   TuNm7S3zbW4iDbo/iH2Yj/GIO/hksk2YSCNLSGeloyXYHi6bW19TfkEKS
   grgk6MP0kDhLejxp+D7b9Xhwu8kV8QoBkuHV4yUnCa7B4lAqcGk3qqj+f
   A9+jMcKB6gWkY8AKW2F19hrMs5S4Mi+BfHiBBd140mzlf6ly/r1x0tNhH
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,337,1654552800"; 
   d="scan'208";a="26356784"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 23 Sep 2022 11:12:27 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 23 Sep 2022 11:12:27 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 23 Sep 2022 11:12:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663924347; x=1695460347;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7crnXgUhmUDKPsinAJs7KiF3E10gRKIRmlXb6HsKEMk=;
  b=iglEljJQIWicaxkwaHinrmworcUuswA/tBTawfotF29tbvhDfFp2jOJk
   6oq7cV8iPNsaLAE6eyyJuWChB2QNze4/E7KNlJcAxNd4/1XbX0USsS+s/
   a4VD+Ia77pqhQVPamIFCtTJ3YgcKJlMnsvR29HopT2IdIpDINLuEwqDD+
   X4pR6BUSat4TGt40vnfVkDgznLr0IaMPA+sIW0HPpCYDimBUNkJEEtpyJ
   GVI9upFVq/7fHxGx6FV1XXYFkc5KizIfS98rD03EyVa6R27Y1UHui2qgU
   L6aifLE2aNYkHE9WI4rBZqGF1ZacxJ8DePrFEc17IXDk6mgW6KqBGy4xO
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,337,1654552800"; 
   d="scan'208";a="26356783"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Sep 2022 11:12:27 +0200
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 85D1A280056;
        Fri, 23 Sep 2022 11:12:27 +0200 (CEST)
Message-ID: <b2c30a8cd1ad8c40d16a25e3a4f190cab214dc4c.camel@ew.tq-group.com>
Subject: Re: [PATCH 1/9] Input: synaptics-rmi4 - fix firmware update
 operations with bootloader v8
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Lyude Paul <lyude@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 23 Sep 2022 11:12:25 +0200
In-Reply-To: <3da8a0c9ae4e6d8a1d772498e4d4186bf969fd76.camel@redhat.com>
References: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
         <20220608124808.51402-2-matthias.schiffer@ew.tq-group.com>
         <3da8a0c9ae4e6d8a1d772498e4d4186bf969fd76.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-22 at 16:06 -0400, Lyude Paul wrote:
> Would add a Cc: stable@vger.kernel.org for this
> 
> With that fixed: Reviewed-by: Lyude Paul <lyude@redhat.com>

Thanks for the review!

Should I reroll with the added Cc? In my experience, patches will end
up queued for stable through AUTOSEL anyways as soon as the word "fix"
appears somewhere in the commit message.


> 
> On Wed, 2022-06-08 at 14:48 +0200, Matthias Schiffer wrote:
> > Commit a6977d758fed ("Input: synaptics-rmi4 - support bootloader v8 in
> > f34v7") allowed the F34v7 driver to probe with bootloader v8, but it did
> > not update various other bootloader version checks in the F34 code.
> > 
> > Fixes: a6977d758fed ("Input: synaptics-rmi4 - support bootloader v8 in f34v7")
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  drivers/input/rmi4/rmi_f34.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
> > index e5dca9868f87..3afc94f679ed 100644
> > --- a/drivers/input/rmi4/rmi_f34.c
> > +++ b/drivers/input/rmi4/rmi_f34.c
> > @@ -370,7 +370,7 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
> >  
> >  	f34 = dev_get_drvdata(&data->f34_container->dev);
> >  
> > -	if (f34->bl_version == 7) {
> > +	if (f34->bl_version >= 7) {
> >  		if (data->pdt_props & HAS_BSR) {
> >  			dev_err(dev, "%s: LTS not supported\n", __func__);
> >  			return -ENODEV;
> > @@ -382,7 +382,7 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
> >  	}
> >  
> >  	/* Enter flash mode */
> > -	if (f34->bl_version == 7)
> > +	if (f34->bl_version >= 7)
> >  		ret = rmi_f34v7_start_reflash(f34, fw);
> >  	else
> >  		ret = rmi_f34_enable_flash(f34);
> > @@ -413,7 +413,7 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
> >  	f34 = dev_get_drvdata(&data->f34_container->dev);
> >  
> >  	/* Perform firmware update */
> > -	if (f34->bl_version == 7)
> > +	if (f34->bl_version >= 7)
> >  		ret = rmi_f34v7_do_reflash(f34, fw);
> >  	else
> >  		ret = rmi_f34_update_firmware(f34, fw);

