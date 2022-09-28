Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E0A5EDDA6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiI1N1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiI1N1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:27:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CACA1D12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:27:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z13-20020a7bc7cd000000b003b5054c6f9bso1246456wmk.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DnC6S+K0/VbM17qCQCLucty5V6KtRHnqqwh3CWVJLG4=;
        b=VgcMn06bI5M98yNrpL0TQVb9EzjLek7ha7a+Xn4CExuufd+xsLy4u0Ae7WB6SPKJbU
         /8EcZXSeAGlwUCY9/n/VtrAkOarb9SjMys9CbRnlnnLg0RiwgMnpcDoOeN769Bz8f86z
         hbyi0ueXOz7rNxSMxIRm1b25/VTjb2XSbTfhGBIJWVcO82mQBsmhDW/jU+szDpO/fWUX
         JzD6jvkbDTaR511965Vh256Ae1jmkvhXADxIZphpxYXfiRvc4KoyWK8F9D69L8M/WqzS
         qLMpWJfW30PlU/qB0ZsRWE6R4QkaVMMcBJKN3WBJqLCSjD30V6GJXC8dzNUVDuKDen3z
         wFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DnC6S+K0/VbM17qCQCLucty5V6KtRHnqqwh3CWVJLG4=;
        b=PAyq0dB8ExN9jO7+bE8glbLt9MeM1kFL+FctLc2KcDw8tunmmJypBj605Fjup7WXhO
         pzYmliGy5reKRsUR9asYPcNQNRKkXBzOAe8VN7mvawgLzQfUBYiF/9sZ6HtlIRRtxy35
         z61zqRrDjyPenHjrfGSurItyyC3rBBf8W2eSp5staS4T344loVU6Bf+vG9AE0SO3cgEP
         GRdUyF9EipiYhHV2kAvJsHb/ivdtSz+oLGLOTXIQ4c11WQ/4rttj3X9Zk3v+xXyeKFBU
         W7kwCH+TPuNoKeqGOh9tTKnc9EGsJIk8bOraUYl2FiUy/JiICKqJa8BQ456qseNEpYyP
         MDhg==
X-Gm-Message-State: ACrzQf0a27aaHk260FU8T7HySjwThpZ2NzhXbDzaLBPfhT2RngKEIeK2
        VfbRiBFTEkRR3XjnGz9zEA==
X-Google-Smtp-Source: AMsMyM6i5LpgBXWSgN5aE+33p9R/Rg/1HjqqOk8XPidBE9cE6KC1cysyGt6oVShkDGkILocsZMc7pg==
X-Received: by 2002:a05:600c:a04:b0:3b4:f20e:63f4 with SMTP id z4-20020a05600c0a0400b003b4f20e63f4mr6854132wmp.201.1664371664906;
        Wed, 28 Sep 2022 06:27:44 -0700 (PDT)
Received: from octinomon ([2a00:23c8:2f02:3b01:3ea1:40:8650:189])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d4e8b000000b00228de58ae2bsm4221093wru.12.2022.09.28.06.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 06:27:44 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:27:42 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] comedi: Convert snprintf() to scnprintf()
Message-ID: <YzRLzkltH1nwroNc@octinomon>
References: <YzHxcb5VzWeSNKo0@fedora>
 <YzKS/3z2cQsFFfxD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzKS/3z2cQsFFfxD@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 08:06:55AM +0200, Greg KH wrote:
> On Mon, Sep 26, 2022 at 07:37:37PM +0100, Jules Irenge wrote:
> > Coccinnelle reports a warning
> > Warning: Use scnprintf or sprintf
> > Adding to that, there has been a slow migration from snprintf to scnprintf.
> > This LWN article explains the rationale for this change
> > https: //lwn.net/Articles/69419/
> > Ie. snprintf() returns what *would* be the resulting length,
> > while scnprintf() returns the actual length.
> > 
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > ---
> >  drivers/comedi/comedi_fops.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> > index 55a0cae04b8d..e8a0142d5894 100644
> > --- a/drivers/comedi/comedi_fops.c
> > +++ b/drivers/comedi/comedi_fops.c
> > @@ -396,7 +396,7 @@ static ssize_t max_read_buffer_kb_show(struct device *csdev,
> >  	mutex_unlock(&dev->mutex);
> >  
> >  	comedi_dev_put(dev);
> > -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> > +	return scnprintf(buf, PAGE_SIZE, "%u\n", size);
> 
> Ick, no, you should use sysfs_emit() if you really want to change these
> functions to "do the right thing".
> 
> thanks,
> 
> greg k-h

Thanks for feedback. 

I just sent a different version.

I will appreciate any more feedback.

Thanks,

Jules
