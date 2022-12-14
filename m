Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D38564C828
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbiLNLiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLNLij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:38:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C56B101EA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671017872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xbb/OYb347XWt0aChq9WW/A++3VBOQvZVK9Cr0CpKIU=;
        b=fnYFrtlD2KM89R7dQsQecr5VwkrbotjkfV6/lnkl+5ztwv1AIP3q4i4PFClt8lUh13i+RJ
        hT190SbNrFXEFGVBAuXypsJko1Jf2gQOUVV+ovkVXYRwuEH6O15cgMsH95566d5nntVbId
        EF6loVpT+9V3KcDCTuyLlxLL0Cxe4bU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-480-I4V8OfhpPHqnwS5s_K5SWg-1; Wed, 14 Dec 2022 06:37:49 -0500
X-MC-Unique: I4V8OfhpPHqnwS5s_K5SWg-1
Received: by mail-wm1-f70.google.com with SMTP id p14-20020a05600c204e00b003cf4cce4da5so4090069wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xbb/OYb347XWt0aChq9WW/A++3VBOQvZVK9Cr0CpKIU=;
        b=U4vt+fc98BdvLyy4VzFOL5yPnOM0OVrfwE2aFnHmGl9REu3/hVL+BLS5EvyCXJHVM/
         jRCjqD9M6YqizWdDXUwL/zA50+h5Cz/DqDmABM4P5AfpLc2MmEzTvkbHIel698Lg1B8+
         pb0OOf1pxFR/CU74TePf155nm3kakMUp+UHmyHvUpnC8UmPSKO5sp4Z8mcYl7ClVlliA
         S9ISZYAIYg18CpkXdJNJ1WBwVol8fgRB1O7iMBCNCaDPvfdhHWcxnAyehJVUceDdwN12
         LNTLwQXZdvgK1LgG/EV0F/DZ8DFmp4xmNzuAFIqzwbr9Ycg7hxcOU7sDvM0Lv4hHOnx6
         trrg==
X-Gm-Message-State: ANoB5plwLQByxxEoL5XIurbrzJYEwOagNBY7ZumNT+n/CGFc/jY3Vy+D
        Om5l0bfroMPfK//metF8LBufP3F2HNeMhxKOrFZKf/UltBfnS34MGms7KlaLIvmfBnbJO/3xJIH
        x2qrdXV589GQjSPzjLRRkZUIJ
X-Received: by 2002:a05:600c:1e8c:b0:3d2:381f:2db5 with SMTP id be12-20020a05600c1e8c00b003d2381f2db5mr2852485wmb.22.1671017868267;
        Wed, 14 Dec 2022 03:37:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7+/bU1un/JpJM4ymOe9NfhDvrRwq4OTL101Vo082S4gqBPPhwQb2YjlTNDwe3J9cq8jj9gYA==
X-Received: by 2002:a05:600c:1e8c:b0:3d2:381f:2db5 with SMTP id be12-20020a05600c1e8c00b003d2381f2db5mr2852461wmb.22.1671017868013;
        Wed, 14 Dec 2022 03:37:48 -0800 (PST)
Received: from redhat.com (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c4ecc00b003cf9bf5208esm2429840wmq.19.2022.12.14.03.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 03:37:47 -0800 (PST)
Date:   Wed, 14 Dec 2022 06:37:44 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Conghui <conghui.chen@intel.com>
Cc:     wsa@kernel.org, asowang@redhat.com, viresh.kumar@linaro.org,
        linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Jian Jun Chen <jian.jun.chen@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Update maintainer list for virtio i2c
Message-ID: <20221214063352-mutt-send-email-mst@kernel.org>
References: <20221214053631.3225164-1-conghui.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214053631.3225164-1-conghui.chen@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 01:36:31PM +0800, Conghui wrote:
> This updates the maintainer for virtio i2c drvier

I got that, but what is going on here exactly?
I generally expect a new maintainer to be active in the
project for a while first.
I don't see contributions or reviews for this driver or
for that matter for any virtio or i2c drivers from Jian Jun Chen.
It looks like you are no longer interested in maintaining
this? In that case pls just send a patch removing yourself.

Jian Jun Chen, if you are interested in reviewing
patches please start doing so, you don't need to
be listed as a maintainer for this to happen.
Once you do this for a while and write some patches,
you can become a maintainer, this is not a high bar
to clear.

> Signed-off-by: Conghui <conghui.chen@intel.com>
> Acked-by: Jian Jun Chen <jian.jun.chen@intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a8c8f6b42436..44747f4641a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21920,7 +21920,7 @@ F:	include/uapi/linux/virtio_snd.h
>  F:	sound/virtio/*
>  
>  VIRTIO I2C DRIVER
> -M:	Conghui Chen <conghui.chen@intel.com>
> +M:	Jian Jun Chen <jian.jun.chen@intel.com>
>  M:	Viresh Kumar <viresh.kumar@linaro.org>
>  L:	linux-i2c@vger.kernel.org
>  L:	virtualization@lists.linux-foundation.org
> -- 
> 2.25.1

