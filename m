Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55447219A6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 22:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjFDULv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDULt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 16:11:49 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91456BD;
        Sun,  4 Jun 2023 13:11:47 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6261a25e9b6so35160216d6.0;
        Sun, 04 Jun 2023 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685909506; x=1688501506;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3EDFvKUzYSUh/h5wzvGG2N7/ZQahbS0m6rxVyrGrqU=;
        b=IDoMciNH8f1I843x2aVxm+/422tkCA46ZKLKBMptut5pakNhbvcXJyDdW+ACj6/rxt
         GjjIEF0Qubj5WGEdh5B4LWqhVXo5oNUJMXUxcGNY/+fSvG/e+r9rcVh+DeJfYnPg62pP
         3FvwQqznII+hGK6SYd+dlaip2ddwNT4Y2srPiVjK2wPJu0zfLcsvRYARu4KHrbZPcCVB
         QpiCgP8OAN0ckvjmJKTR7QZcaPgdPzXp9GwfaRwQ4LvHxvfAecRqjILL1804X4FklWZt
         CgGfpGnu8OsDbPNIin4YDEuCQfW3XVKsq0k4aziCRcze9a3l5uKBMw8Ofx5JsVtr77AH
         5bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685909506; x=1688501506;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V3EDFvKUzYSUh/h5wzvGG2N7/ZQahbS0m6rxVyrGrqU=;
        b=XC+mxS96nEvGVUNsGgMsHJmIhAggM5hCvUoUsDotlAT0yx359/GYy8z8n/gUDPNwns
         mPQte5o9kkIJ2/W80dTgq2aDYLfPPk+5kqUkqzNa/fF89idMfQB5Ggmz8E/RDTbqU8t4
         xBg2h+GU3uTbvDLAf+/PifJdSD4h97+plUX0S0Dtb0FGXwZwOAXK4rc76Gpbum/Njz8G
         1CAwyjfM99q1s9FEMRvJrt5gm7T9akbtNgBxec2jFOliMCdBlhnz64WjxKP5x43xMb/s
         UEyQcd+8J2xIAABEMviCq9mP1LTvTxF7pvocALBvZAIczKr8fFDFJTabnMDYUgXuKunr
         kC4w==
X-Gm-Message-State: AC+VfDyzZ6kXxdFQZ+celZSkfIvLCkUFwYXaDdw3YhX5jOVyo9LHWz4I
        HxlIXhUfAIpfIaVXXTNugvltVdrfLw==
X-Google-Smtp-Source: ACHHUZ6KUBceOq83W12Chk+0PZ8J0HIVPf6Ln1cAmLkQI3vjoiikGgsobm7l0glPNrxAtfJWaECBbA==
X-Received: by 2002:a05:6214:628:b0:625:aa1a:b6d9 with SMTP id a8-20020a056214062800b00625aa1ab6d9mr4565003qvx.59.1685909506607;
        Sun, 04 Jun 2023 13:11:46 -0700 (PDT)
Received: from serve.minyard.net ([47.189.94.26])
        by smtp.gmail.com with ESMTPSA id t11-20020a056214154b00b00626117620aasm3495811qvw.105.2023.06.04.13.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 13:11:45 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:40d3:18db:d1d3:341e])
        by serve.minyard.net (Postfix) with ESMTPSA id B603D1800C3;
        Sun,  4 Jun 2023 20:11:44 +0000 (UTC)
Date:   Sun, 4 Jun 2023 15:11:43 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Craig Shelley <craig@microtron.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: Break doesn't work on a CP2105
Message-ID: <ZHzv/wbwtaLVpfaP@mail.minyard.net>
Reply-To: minyard@acm.org
References: <ZEmDs0ASdnEAnpsL@minyard.net>
 <ZGtZKCvo71woGf9T@hovoldconsulting.com>
 <ZGtlnWGSc31Wdhxa@mail.minyard.net>
 <ZHnmSwGyOaSMbPBB@hovoldconsulting.com>
 <ZHodALMLTWk72Vvm@mail.minyard.net>
 <ZHyAzHVAu3DVgJG_@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHyAzHVAu3DVgJG_@hovoldconsulting.com>
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

On Sun, Jun 04, 2023 at 02:17:16PM +0200, Johan Hovold wrote:
> On Fri, Jun 02, 2023 at 11:46:56AM -0500, Corey Minyard wrote:
> > On Fri, Jun 02, 2023 at 02:53:31PM +0200, Johan Hovold wrote:
> 
> > > I just posted a patch series which does that. The USB serial drivers do
> > > not currently return any errors related to break signalling even though
> > > this has been possible since 2008.
> > > 
> > > The same mechanism can be used to report that break signalling is not
> > > supported by a device or driver, but the USB serial drivers would be the
> > > first tty drivers that actually do this. If it turns out to cause any
> > > trouble we can still use this series to avoid the unnecessary wait.
> > > 
> > > Care to give the series a try?
> > > 
> > > 	https://lore.kernel.org/lkml/20230602124642.19076-1-johan@kernel.org
> > 
> > I have tested this series.  I can verify that one of the CP2105 ports
> > (ttyUSB0) does not return an error on sending the break, and the other
> > (ttyUSB1) does.  This is the only USB serial device on the system.
> 
> Thanks for testing.
> 
> > However, the device hooked to the remote console (ttyUSB0), the one not
> > returning an error on sending a break, still doesn't send a break.  So
> > my problem isn't fixed :-(.
> > 
> > # ls -l /dev/serial/by-path
> > total 0
> > lrwxrwxrwx 1 root root 13 Jun  2 15:28 pci-0000:00:1d.0-usb-0:1.1:1.0-port0 -> ../../ttyUSB0
> > lrwxrwxrwx 1 root root 13 Jun  2 15:28 pci-0000:00:1d.0-usb-0:1.1:1.1-port0 -> ../../ttyUSB1
> 
> Ok, at least that matches what you found in schematics about this being
> the ECI (and thus first) port.
> 
> I just verified break signalling on the first port of my CP2105 using a
> logic analyser and everything seems to work as expected.
> 
> There's also no mention of any issue with break in the errata.
> 
> Could you check which firmware revision you have by enabling debugging
> and reconnecting the device?
> 
> For example:
> 
> 	echo func cp210x_get_fw_version +p > /sys/kernel/debug/dynamic_debug/control

I couldn't get that to work (didn't try too hard), so I just stuck in a dev_info():

[    4.253869] usb 2-1.2: new full-speed USB device number 3 using ehci-pci
[    4.342570] usb 2-1.2: New USB device found, idVendor=10c4, idProduct=ea70, bcdDevice= 1.00
[    4.350939] usb 2-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=5
[    4.358259] usb 2-1.2: Product: CP2105 Dual USB to UART Bridge Controller
[    4.365052] usb 2-1.2: Manufacturer: Silicon Labs
[    4.369765] usb 2-1.2: SerialNumber: 01070456
[    4.374925] cp210x 2-1.2:1.0: cp210x converter detected
[    4.381086] cp210x 2-1.2:1.0: cp210x_get_fw_version - 1.18.1
[    4.386915] usb 2-1.2: cp210x converter now attached to ttyUSB0
[    4.393529] cp210x 2-1.2:1.1: cp210x converter detected
[    4.399835] cp210x 2-1.2:1.1: cp210x_get_fw_version - 1.18.1
[    4.405657] usb 2-1.2: cp210x converter now attached to ttyUSB1

This is an embedded reference board, I guess there is some probability
that this is just broken on this board, though I'm not quite sure how.

Thanks for working on this.

-corey
