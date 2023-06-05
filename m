Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FB2722598
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjFEMZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFEMZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:25:10 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD341A7;
        Mon,  5 Jun 2023 05:25:08 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f6bafd4782so34780101cf.0;
        Mon, 05 Jun 2023 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685967908; x=1688559908;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWoI4j/J12uFbaQI3enaMn8JG4Xk/p7mtOQ+4FLvZfg=;
        b=eyxf+zdznYV5eQHt+d2PjAQ+QdNSDwZuVm/lVyPWFmTOc9b3sTSjflVZzLs4DiYsaV
         xk0Ax6nDo1BYCYvf5qOgepT2CWBTzC8Ew56C1IGvcFSiZRMNGbPU6/Zjf7FxwrHxFC40
         c0Elc+PIj1jJRpBnBJDGpZ0KELN5doMGtuTQ+ovUIhJWakIEyXMW+cyzIg1pnDAV6YUb
         z2bh8Kw1wsieBeAqTag/q/DKtmuUEYpNllMraDUK1ZvT077kygb7jeGZL9qy9LuUBbKJ
         /flusz/AzsTcZsD9TvfQnnuj7h/p9AMYJBBIzifQ1ubyEbEhqsTue3kEyg+t5GXwRewh
         yuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685967908; x=1688559908;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QWoI4j/J12uFbaQI3enaMn8JG4Xk/p7mtOQ+4FLvZfg=;
        b=hXJkTsZdVawL0hs/SHfx6ZHCYZeFbkl69vASqckSpT9H5OkzHKKyvMxw79lqL7waag
         mWULQvXwrSqEdl2Cq32wPCjsOtXLi/pgwHPxmEaG0xLREiAwXIE3w8fQkEmhoF9ihQJV
         XWfR8RnkPHk/lmnUA5i9EpqqZBHjT02dT00Jjuhg1lrCOjYI6uVOZhOGjHiQXWMsly8T
         XvJmMILVZ5wShFYHtA5lOsKeWIiuAZVaHNL+0+DfxmUeLcKHTmJNctm2G11QbIAELKqw
         vSfPAWKJ1meazGN0nivhapwJJ+htjEonNx44sYImBuA14bXKE8Ggfw82SxsQdho62r9f
         LSsQ==
X-Gm-Message-State: AC+VfDxfrlUi+LZlp4ZgKE+6Z+cjJGFgfVQaFZPz3iByCnLi4cTuVGm0
        FjGKXMVGXjjzRAIZqgbRjg==
X-Google-Smtp-Source: ACHHUZ75tRg5inYgWDGQrhI+6vv2Cbb5TnsnaGgz1Eu4ftC56iSre1STyrMYFpczH5VsWiUydLr0Uw==
X-Received: by 2002:a05:622a:1104:b0:3f6:9cb8:f3d2 with SMTP id e4-20020a05622a110400b003f69cb8f3d2mr8442001qty.53.1685967907609;
        Mon, 05 Jun 2023 05:25:07 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id jt23-20020a05622aa01700b003f6be76a5c1sm4703678qtb.6.2023.06.05.05.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 05:25:06 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:40d3:18db:d1d3:341e])
        by serve.minyard.net (Postfix) with ESMTPSA id A53D61800BB;
        Mon,  5 Jun 2023 12:25:05 +0000 (UTC)
Date:   Mon, 5 Jun 2023 07:25:04 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Craig Shelley <craig@microtron.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: Break doesn't work on a CP2105
Message-ID: <ZH3UIMe4DyCicPYQ@mail.minyard.net>
Reply-To: minyard@acm.org
References: <ZEmDs0ASdnEAnpsL@minyard.net>
 <ZGtZKCvo71woGf9T@hovoldconsulting.com>
 <ZGtlnWGSc31Wdhxa@mail.minyard.net>
 <ZHnmSwGyOaSMbPBB@hovoldconsulting.com>
 <ZHodALMLTWk72Vvm@mail.minyard.net>
 <ZHyAzHVAu3DVgJG_@hovoldconsulting.com>
 <ZHzv/wbwtaLVpfaP@mail.minyard.net>
 <ZH2LkKE83kHrIRWH@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH2LkKE83kHrIRWH@hovoldconsulting.com>
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

On Mon, Jun 05, 2023 at 09:15:28AM +0200, Johan Hovold wrote:
> On Sun, Jun 04, 2023 at 03:11:43PM -0500, Corey Minyard wrote:
> > On Sun, Jun 04, 2023 at 02:17:16PM +0200, Johan Hovold wrote:
> 
> > > I just verified break signalling on the first port of my CP2105 using a
> > > logic analyser and everything seems to work as expected.
> > > 
> > > There's also no mention of any issue with break in the errata.
> > > 
> > > Could you check which firmware revision you have by enabling debugging
> > > and reconnecting the device?
> 
> > [    4.253869] usb 2-1.2: new full-speed USB device number 3 using ehci-pci
> > [    4.342570] usb 2-1.2: New USB device found, idVendor=10c4, idProduct=ea70, bcdDevice= 1.00
> > [    4.350939] usb 2-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=5
> > [    4.358259] usb 2-1.2: Product: CP2105 Dual USB to UART Bridge Controller
> > [    4.365052] usb 2-1.2: Manufacturer: Silicon Labs
> > [    4.369765] usb 2-1.2: SerialNumber: 01070456
> > [    4.374925] cp210x 2-1.2:1.0: cp210x converter detected
> > [    4.381086] cp210x 2-1.2:1.0: cp210x_get_fw_version - 1.18.1
> > [    4.386915] usb 2-1.2: cp210x converter now attached to ttyUSB0
> > [    4.393529] cp210x 2-1.2:1.1: cp210x converter detected
> > [    4.399835] cp210x 2-1.2:1.1: cp210x_get_fw_version - 1.18.1
> > [    4.405657] usb 2-1.2: cp210x converter now attached to ttyUSB1
> 
> So we have the same firmware revision.
>  
> > This is an embedded reference board, I guess there is some probability
> > that this is just broken on this board, though I'm not quite sure how.
> 
> Is the port accessible somehow so that you could hook up a scope or
> logic analyser? Or is that what you did already when you mentioned
> seeing garbage sent after 2.5 seconds?

I didn't hook up a scope, but I did set the baud to a really low rate
and send a character that was all zeros and got a break on the other
end.  It wasn't garbage I was seeing after 2.5 seconds, it was basically
a small number of 0 bits, it appeared.

I have a scope that I can capture with, but this is all embedded onto a
board.  I looked at the schematic and there are some resistors that I
could hook to, perhaps.  I'll see what I can do, but I don't have
surface mount stuff to be able to attach easily.

Thank you,

-corey

> 
> That last bit seems to match the behaviour I see with the second, SCI
> port, where the last character sent is resent when trying to signal a
> break.
> 
> Johan
