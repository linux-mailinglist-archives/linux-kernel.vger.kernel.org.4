Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0F05E8267
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiIWTNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiIWTNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A21F115BEB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 12:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663960420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kL1sKvWl7toJq/naTSlRJEPH2yxVO7xF2IQr8yMOBc=;
        b=Ilk1Vurt1NeIvIw5sMdoWxBXa2ZFncxgvk2LiK7xztBP3K7y7/C6zLVTyg5zQ9zMdvnaCI
        IM09aOHQNNoxUmTBfFn2wea/gpYUgBFN4EQQvJZQ8cI7BI9ecrd/dsd529FqmWTTwruX1H
        YMOpRSrTKq30UmMGIms8oZwLcxaQmPk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-8WcRCV6nP12m3PPUG1KmFw-1; Fri, 23 Sep 2022 15:13:39 -0400
X-MC-Unique: 8WcRCV6nP12m3PPUG1KmFw-1
Received: by mail-qv1-f70.google.com with SMTP id lq8-20020a0562145b8800b004ad7229e4e9so490537qvb.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 12:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1kL1sKvWl7toJq/naTSlRJEPH2yxVO7xF2IQr8yMOBc=;
        b=CAhTyxY6tnPdZUtCL40nZP3wZ7t60e4juDVE4uufMb+8yuhC8zMWij7FP8XoHZtH2h
         Nb4m7aFojw4K3Ec+F4B5Qi+UZXLkDvFiqribhkkPj42qlhdF4NTGBS9rVWZz1nz8AxUX
         Qcj/R9jzi9oDxf9xbUigAlPKxTkj0XJxlXcZFxIbtfPY6d6C8Vhn3qHc3GIbishwh4AD
         fIxoEM7agwQLmOCTddVom3T/woKQIyjIQJYTzlq7xNm+Mlt7Ak41E5fCZv73m05DBoJR
         hnC5ACbRT0nkKIvFM+di5cMARkVesiP9y0uysdgmDOVS4NOFpBH9ukXLs+OeJHAgo4DS
         RUjQ==
X-Gm-Message-State: ACrzQf194CiuxWDZSPr0aS1NJtp6yllmdV94gNRnLJOJx84lk0LYHJCz
        wn46br5iulC9NYwTo7jffX2eSQuQTctOJNOA9h2Jy3efxesmaO/wBuVxcEo8R5RwAZWt4+aA9eN
        yT/M3H7b786OLKGLEooOQOMDs
X-Received: by 2002:a05:620a:294a:b0:6ce:9944:f65a with SMTP id n10-20020a05620a294a00b006ce9944f65amr6694294qkp.434.1663960418792;
        Fri, 23 Sep 2022 12:13:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM77DHnyJvaE6za+YOcsEoyOQZgd8Rm22c/EKhemffNRu+daj/GqP44WuMHgeOFroeF2XhsNwQ==
X-Received: by 2002:a05:620a:294a:b0:6ce:9944:f65a with SMTP id n10-20020a05620a294a00b006ce9944f65amr6694280qkp.434.1663960418592;
        Fri, 23 Sep 2022 12:13:38 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c48:e00::feb? ([2600:4040:5c48:e00::feb])
        by smtp.gmail.com with ESMTPSA id y17-20020a37f611000000b006b5cc25535fsm6158496qkj.99.2022.09.23.12.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:13:37 -0700 (PDT)
Message-ID: <e63a16f8c89e33078966ba518576eafb075b5012.camel@redhat.com>
Subject: Re: [PATCH 1/9] Input: synaptics-rmi4 - fix firmware update
 operations with bootloader v8
From:   Lyude Paul <lyude@redhat.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 23 Sep 2022 15:13:36 -0400
In-Reply-To: <b2c30a8cd1ad8c40d16a25e3a4f190cab214dc4c.camel@ew.tq-group.com>
References: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
         <20220608124808.51402-2-matthias.schiffer@ew.tq-group.com>
         <3da8a0c9ae4e6d8a1d772498e4d4186bf969fd76.camel@redhat.com>
         <b2c30a8cd1ad8c40d16a25e3a4f190cab214dc4c.camel@ew.tq-group.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-23 at 11:12 +0200, Matthias Schiffer wrote:
> On Thu, 2022-09-22 at 16:06 -0400, Lyude Paul wrote:
> > Would add a Cc: stable@vger.kernel.org for this
> > 
> > With that fixed: Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
> Thanks for the review!
> 
> Should I reroll with the added Cc? In my experience, patches will end
> up queued for stable through AUTOSEL anyways as soon as the word "fix"
> appears somewhere in the commit message.

Ahhh, totally forgot about this. Nevermind then, it should be fine as-is :)

> 
> 
> > 
> > On Wed, 2022-06-08 at 14:48 +0200, Matthias Schiffer wrote:
> > > Commit a6977d758fed ("Input: synaptics-rmi4 - support bootloader v8 in
> > > f34v7") allowed the F34v7 driver to probe with bootloader v8, but it did
> > > not update various other bootloader version checks in the F34 code.
> > > 
> > > Fixes: a6977d758fed ("Input: synaptics-rmi4 - support bootloader v8 in f34v7")
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > ---
> > >  drivers/input/rmi4/rmi_f34.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
> > > index e5dca9868f87..3afc94f679ed 100644
> > > --- a/drivers/input/rmi4/rmi_f34.c
> > > +++ b/drivers/input/rmi4/rmi_f34.c
> > > @@ -370,7 +370,7 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
> > >  
> > >  	f34 = dev_get_drvdata(&data->f34_container->dev);
> > >  
> > > -	if (f34->bl_version == 7) {
> > > +	if (f34->bl_version >= 7) {
> > >  		if (data->pdt_props & HAS_BSR) {
> > >  			dev_err(dev, "%s: LTS not supported\n", __func__);
> > >  			return -ENODEV;
> > > @@ -382,7 +382,7 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
> > >  	}
> > >  
> > >  	/* Enter flash mode */
> > > -	if (f34->bl_version == 7)
> > > +	if (f34->bl_version >= 7)
> > >  		ret = rmi_f34v7_start_reflash(f34, fw);
> > >  	else
> > >  		ret = rmi_f34_enable_flash(f34);
> > > @@ -413,7 +413,7 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
> > >  	f34 = dev_get_drvdata(&data->f34_container->dev);
> > >  
> > >  	/* Perform firmware update */
> > > -	if (f34->bl_version == 7)
> > > +	if (f34->bl_version >= 7)
> > >  		ret = rmi_f34v7_do_reflash(f34, fw);
> > >  	else
> > >  		ret = rmi_f34_update_firmware(f34, fw);
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

