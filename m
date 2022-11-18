Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5AA62F05B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241455AbiKRJBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiKRJBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:01:39 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2024D697DD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:01:39 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso7040978wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K6hK8A2rAN4d24KDK5ABoo0V031IyWeiGrh9El3YUPY=;
        b=WMSkKPKVgzPshxJZXoPqCgykFa2Q6jLIDq9gctLfPDbYW+zXN5wTHSIOyT1Eqpzyqy
         /Oa6/hyYWTWoxAgyQ5e54+GfGzjsC6e7lzw0KFQUOy/KhcOef3ixOCdXPvzhKZ1lnY4v
         URbbGTQ+S5yFATOWflB8AcCgi1tBqLVboO42SF/ZJ31z45/vWC4Ul3tJnKZ2HayJSeVT
         +/s4y5x8cNP10J5PiZhhqsDB5LGh/BXwIECwjIm34lqTwr7Lk6d0J3Fu1ouImD0g8LKJ
         3Phczu2ipekrMIa8aVYmFGgO1bN2tCRJ/3YTw2xZwUWvwS4L/DAJkXWcKeTON9p6dRyh
         d1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6hK8A2rAN4d24KDK5ABoo0V031IyWeiGrh9El3YUPY=;
        b=7EP+NsrM+UndS8WwAk9ltwV0k2S9Pr9vF4tkTRPzZqUEAabHbPhUi17pMoGWOp7Mx4
         LJeTAAOx+N1KrmdSfFZ7+Y2H5da3aa57ObD57O5dkLPAkr3ApURS49DapSAmD4n/IB5D
         u+zvuYzdJx7U6YniSaQT6HYqrW90rCLiXX8t7a2/ADl+7ApXg+kg83xy3OdPIe5dOVM1
         UDRdsog1WdiZ7foZYYy25YV0S+A4BM9XeYVV9VrlQbGw+OH35NqSy3qLgh1SlV/8tP71
         FY6ko1yBxe+IpFkbbprUIHFFi1aPl1WOfGTUJr7LodQ/yNRYvlSgHqNoXxSmp0niUwTT
         IR7g==
X-Gm-Message-State: ANoB5pm9iMnbZEsLhwYSdKvlokcLKaTGrs646LxoiacefrXVcwu4gtEf
        TrZcRPwL+Z3sf0VdF2EpCJw=
X-Google-Smtp-Source: AA0mqf69UydmZ4WVQnY3pESaLTvOyJU7cFdL5tejY53onzOZSvxdUOc1AtYvBrSboRJgr+axBmvemQ==
X-Received: by 2002:a05:600c:35cf:b0:3cf:aa11:93a8 with SMTP id r15-20020a05600c35cf00b003cfaa1193a8mr7851714wmq.31.1668762097604;
        Fri, 18 Nov 2022 01:01:37 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm7980034wmf.8.2022.11.18.01.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:01:37 -0800 (PST)
Date:   Fri, 18 Nov 2022 12:01:34 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kieran.bingham@ideasonboard.com
Subject: Re: [PATCH 2/3] vc04_services: mmal-vchiq: Use bool for
 vchiq_mmal_component.in_use
Message-ID: <Y3dJ7mETwKNVH7dU@kadam>
References: <20221117160015.344528-1-umang.jain@ideasonboard.com>
 <20221117160015.344528-3-umang.jain@ideasonboard.com>
 <Y3bQiDw11t4pRokP@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3bQiDw11t4pRokP@lunn.ch>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 01:23:36AM +0100, Andrew Lunn wrote:
> >  struct vchiq_mmal_component {
> > -	u32 in_use:1;
> > +	bool in_use:1;
> >  	bool enabled:1;
> 
> The patch you referenced says:
> 
> +If a structure has many true/false values, consider consolidating them into a
> +bitfield with 1 bit members, or using an appropriate fixed width type, such as
> +u8.
> 
> The code did exactly this, using two bits fields, in one u32. A bool
> probably takes up 4 bytes, maybe 8 bytes, so this change probably
> doubles the storage size for these two fields.

In GCC and Clang bools take a byte, but the C language is vague and
other compilers are free to do it differently.

> Are these fields on the
> hot path, where an extra AND instruction would make a difference?

This patch takes the first u32 for "in_use" and squeezes it into the
same byte as "enabled" so it makes the struct four bytes smaller.  There
is still a 3 byte struct hole between "enabled" and "handle" so we could
add more 62 bool bitfields if we wanted.

In the v2 patch these become:

	bool in_use;
	bool enabled;

One byte each and there is a two byte gap before "handle".

regards,
dan carpenter

