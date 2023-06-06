Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51007242EF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbjFFMsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjFFMsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:48:10 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2921E10D9;
        Tue,  6 Jun 2023 05:47:45 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f9a6c18e45so15530691cf.3;
        Tue, 06 Jun 2023 05:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686055599; x=1688647599;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKiZBq4N2uzyc1uP6K/gn6kRYmbs2MnPBrOh0qNFFjQ=;
        b=k/3CYpTYDMXNGlJOl6Vm9Siv7kMMxDjZlTRcNkC2QhX+jqbIUlq3IOMsj2Gm9A1mzc
         1dYq4Re0QPPi3GaghqNM5WaUCBHiu6jq76O0VoKd/IYxcZPXxT2Z4OKVR9b8WkkF+giQ
         jKYV63OJOzqTaGTYSrNrTQLBooeIQQgSERqIpmX8FFG0qAMTCSgsojNChDdxd5qj4dqF
         9GK9LctSx5UKPqV/E/ssgNqEmo9sp28Bo9AHbxV1iHXrpTIIVkxVGPc1jaKuzyflH86w
         ubo+Y7RhC7zmpeFfhjOgy/XgmvUHi6i4vNUnWpVh0me0mL4bR+Ex9WuS5Wu+Q5LTXMR3
         J0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055599; x=1688647599;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cKiZBq4N2uzyc1uP6K/gn6kRYmbs2MnPBrOh0qNFFjQ=;
        b=TYP4j4IRdSDQvAXRf3M/mzmTKZluBhCWTb4fr9BoABaUGA2OBJMW3JEYkoFCbk4fUE
         vOCuRienwmT/N4RWZZcKjqqzU4oUBem7n05vQ6qHD/PU8jyJqEIl219Zk2a1gROMzxxU
         Nd9tgn1G9n+xDaS70o5wIX/4WXpigHIxj4Ns7v37ejUWQn9NTzNg22mk2AxeBR4UZ9ym
         UcOhJCVWkR8epRYj6Ln3f1SDFt+j9uTVZdzhraO6M5+yOZSICAJ4M9V5BpZ150htYOeI
         p8Vdw18NIDX5n7eidsMITIoUgSO2rP+U2EA5Jjlag6KcMnHL3Gg+Ct7keVMuVZH2lzuR
         kN3w==
X-Gm-Message-State: AC+VfDzdGq7ir+f6pIOsiX6xnZkV+fpCLlevxrkqwiYb2R6sOGJakrff
        HNqeiNxoOgvQ3qdESIQ5KA==
X-Google-Smtp-Source: ACHHUZ7MMeHe7IIxBi59pp1HzL7wP2kz34CP+OK4jBeZLb+ItXcgXkd8wFtMZv+gD+NNBPr5K8lLeg==
X-Received: by 2002:ac8:7d8e:0:b0:3f5:3d3d:d1b5 with SMTP id c14-20020ac87d8e000000b003f53d3dd1b5mr1553621qtd.27.1686055599534;
        Tue, 06 Jun 2023 05:46:39 -0700 (PDT)
Received: from serve.minyard.net ([47.189.94.26])
        by smtp.gmail.com with ESMTPSA id g22-20020ac84696000000b003ef189ffa82sm2605273qto.90.2023.06.06.05.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:46:38 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:6303:b09c:2f6b:4f53])
        by serve.minyard.net (Postfix) with ESMTPSA id 4F393180044;
        Tue,  6 Jun 2023 12:46:37 +0000 (UTC)
Date:   Tue, 6 Jun 2023 07:46:36 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] USB: serial: return errors from break handling
Message-ID: <ZH8qrBBwcXH0eP8/@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20230604123505.4661-1-johan@kernel.org>
 <726a6f5f-5338-50a9-3081-7c02194dd7af@suse.com>
 <ZH8a12ZYtA2RzEK_@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH8a12ZYtA2RzEK_@hovoldconsulting.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 01:39:03PM +0200, Johan Hovold wrote:
> On Tue, Jun 06, 2023 at 01:18:19PM +0200, Oliver Neukum wrote:
> > On 04.06.23 14:35, Johan Hovold wrote:
> > > This series starts returning errors from break handling and also uses
> > > that mechanism to report to user space when break signalling is not
> > > supported (e.g. when device or driver support is missing).
> 
> > do you eventually want this to be done for all serial devices?
> > That is does cdc-acm need something like this patch?
> 
> Looks good to me. If this turns out to confuse userspace we may have to
> turn that -ENOTTY into 0 in the tty layer, but we can still use it to
> avoid the unnecessary wait to "disable" the break state.
> 
> > From 16430d9f109f904b2bfbac6e43a939209b6c4bc7 Mon Sep 17 00:00:00 2001
> > From: Oliver Neukum <oneukum@suse.com>
> > Date: Tue, 6 Jun 2023 12:57:00 +0200
> > Subject: [PATCH] usb: cdc-acm: return correct error code on unsupported break
> > 
> > Return -ENOTTY if the device says that it doesn't support break
> > so that the upper layers get error reporting right.

Yeah, when I asked for this, I didn't realize that no devices did this,
I thought it was a one-off with this device.  There is a distinct
possibility that this will break userland.  This sounds like a good
plan.

-corey

> > 
> > Signed-off-by: Oliver Neukum <oneukum@suse.com>
> 
> Acked-by: Johan Hovold <johan@kernel.org>
> 
> > ---
> >  drivers/usb/class/cdc-acm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> > index 11da5fb284d0..7751f5728716 100644
> > --- a/drivers/usb/class/cdc-acm.c
> > +++ b/drivers/usb/class/cdc-acm.c
> > @@ -892,6 +892,9 @@ static int acm_tty_break_ctl(struct tty_struct *tty, int state)
> >  	struct acm *acm = tty->driver_data;
> >  	int retval;
> >  
> > +	if (!(acm->ctrl_caps & USB_CDC_CAP_BRK))
> > +		return -ENOTTY;
> > +
> >  	retval = acm_send_break(acm, state ? 0xffff : 0);
> >  	if (retval < 0)
> >  		dev_dbg(&acm->control->dev,
