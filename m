Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEFB6567B7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 08:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiL0HJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 02:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiL0HJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 02:09:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B841C26EF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672124921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CNSl+0ECi610jkobwQHRDIhZHSbY7C3DN466PQa953c=;
        b=AsOacStTq04VP5gQ9w2NFhMa9MkWVtE55VNc3yePrpVKSDOJLPxG2cXdecBPEIUGlh6za2
        xbcr8XE67YuoQDsUBPzW7wXlFgTXA+E/f/s1JyHXkG7v08ojedkYAjVX+0qxU3iL/fAVMm
        Sg1ggXT6j/Rv0qtPN8SbJQl5ABbzj5k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-436-Z-Mx_oHbOVuN5U_alttd3g-1; Tue, 27 Dec 2022 02:08:39 -0500
X-MC-Unique: Z-Mx_oHbOVuN5U_alttd3g-1
Received: by mail-wm1-f71.google.com with SMTP id q21-20020a7bce95000000b003d236c91639so2991026wmj.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNSl+0ECi610jkobwQHRDIhZHSbY7C3DN466PQa953c=;
        b=3v2aGtlvzxFGHIfWmLr/GUtRrqv/F4bLka8R3jWZ/SgQKl2FeiCXEIFL4ODMS3QaZb
         7vqHwtndw1omL6kriFcqqOPudz98S1TtA9grUMItRhZkTMdxgitkfoHAr+DDufW+GblF
         B9SZ4avk8rgM+IbMVQtBvPd4+FpPDSpuO9y5K3b3K02mDQxvwUMVEGJp2OhgpfHmBurI
         TRCcs08SrTilqGtFpeJrU2zhjfm9o9NSvp7FCoE5QZWVn7EMsJIOCYWvhNDrEtEhBWky
         louWJ4FniT0X50deRJzq+Gl4/34Kn3GfdEgWBH6hZrBXHtZ1s99T7zbQsmN1sFZ2Dofp
         oLhQ==
X-Gm-Message-State: AFqh2kpcNaZpDlA84dzFMzsS+si2IA3oc9j8qUFQMA89NOGeAQCs+DKE
        EU74vPxMbijGmm8NiGqrCDRgJf/JAPcx4KJRQ5ZdPV73gZgNJ2o0QVCqXU00PmCluNAfwlndPwr
        v/GxL3twlFKG8iW5Cv0b2unw0
X-Received: by 2002:a05:600c:218f:b0:3d1:fbf9:3bd4 with SMTP id e15-20020a05600c218f00b003d1fbf93bd4mr14570201wme.10.1672124918372;
        Mon, 26 Dec 2022 23:08:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtc99GCoJhnK8zS6H5TFpyy0SjPSOlEw+pD0N2cOTloIwBCRzZwnIIqKPd/kod61jIX+AMcnw==
X-Received: by 2002:a05:600c:218f:b0:3d1:fbf9:3bd4 with SMTP id e15-20020a05600c218f00b003d1fbf93bd4mr14570189wme.10.1672124918163;
        Mon, 26 Dec 2022 23:08:38 -0800 (PST)
Received: from redhat.com ([2.52.151.85])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c314e00b003d237d60318sm17613983wmo.2.2022.12.26.23.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 23:08:37 -0800 (PST)
Date:   Tue, 27 Dec 2022 02:08:34 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Chen, Jian Jun" <jian.jun.chen@intel.com>
Cc:     Conghui <conghui.chen@intel.com>, wsa@kernel.org,
        asowang@redhat.com, viresh.kumar@linaro.org,
        linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update maintainer list for virtio i2c
Message-ID: <20221227020812-mutt-send-email-mst@kernel.org>
References: <20221214053631.3225164-1-conghui.chen@intel.com>
 <20221214063352-mutt-send-email-mst@kernel.org>
 <3557e69a-0c17-0a24-0706-8b48c350b75a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3557e69a-0c17-0a24-0706-8b48c350b75a@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 12:04:10PM +0800, Chen, Jian Jun wrote:
> 
> On 12/14/2022 19:37, Michael S. Tsirkin wrote:
> > On Wed, Dec 14, 2022 at 01:36:31PM +0800, Conghui wrote:
> > > This updates the maintainer for virtio i2c drvier
> > I got that, but what is going on here exactly?
> > I generally expect a new maintainer to be active in the
> > project for a while first.
> > I don't see contributions or reviews for this driver or
> > for that matter for any virtio or i2c drivers from Jian Jun Chen.
> > It looks like you are no longer interested in maintaining
> > this? In that case pls just send a patch removing yourself.
> > 
> > Jian Jun Chen, if you are interested in reviewing
> > patches please start doing so, you don't need to
> > be listed as a maintainer for this to happen.
> > Once you do this for a while and write some patches,
> > you can become a maintainer, this is not a high bar
> > to clear.
> 
> Hi Michael,
> 
> Yes. I am interested in the virtio I2C maintenance. I have lots of virtio
> experience in ACRN device model development and was involved in the early
> phase virtio I2C discussion in ACRN before Jie/Conghui upstream the virtio
> I2C spec. Sure, I will start to collaborate first.


Excellent, thanks a lot!

> > > Signed-off-by: Conghui <conghui.chen@intel.com>
> > > Acked-by: Jian Jun Chen <jian.jun.chen@intel.com>
> > > ---
> > >   MAINTAINERS | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index a8c8f6b42436..44747f4641a6 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -21920,7 +21920,7 @@ F:	include/uapi/linux/virtio_snd.h
> > >   F:	sound/virtio/*
> > >   VIRTIO I2C DRIVER
> > > -M:	Conghui Chen <conghui.chen@intel.com>
> > > +M:	Jian Jun Chen <jian.jun.chen@intel.com>
> > >   M:	Viresh Kumar <viresh.kumar@linaro.org>
> > >   L:	linux-i2c@vger.kernel.org
> > >   L:	virtualization@lists.linux-foundation.org
> > > -- 
> > > 2.25.1

