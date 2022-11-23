Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B7E6362F5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbiKWPLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbiKWPLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:11:05 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBAB58BDF;
        Wed, 23 Nov 2022 07:11:04 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id t1so13266053wmi.4;
        Wed, 23 Nov 2022 07:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TYA+sk34MTdokaTmO6Z2RqNJkrS7NKI/SfAHszvjo7s=;
        b=AyjUdBUPSwzq13H1UQf4yKXKkqb1P7vt21u9WG70IroGGxLOVENzduplbXXl99Ouag
         032FFl96sV1zeiCn2unh6UIVmE1Fu2oX5C8F62/h0par3rHBTmzfXdiJ/aLTHdReIa2+
         u6hUjnA4FU/prOhjLEilWfkRyvAY16QkUQiknyyLYd49nee21nQwzyps0WMnUlsdK1kR
         3TbI+1Gccba+/tfKlJ39xX8c24nYJjzCxWAaUuV8ctVc68vQzbHaxqQrT+nw1qHqanxz
         vrEZSQrAmgxr6raSzrsnScnyCFR24c0Z6Cbi82BjJmaywGPikNKoXpSycIl7RCrCX8Rn
         f2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYA+sk34MTdokaTmO6Z2RqNJkrS7NKI/SfAHszvjo7s=;
        b=2sApt12sdUMxPGgHL+gg7HK1nT4LsxDVb4C0p6emXx9Qk3Q4qmaqV4GamGzXC+AUno
         95MTEbTHa/YUnGeqYAux81KVC1317me/o/A5r8gqgRCjj5O0haf5qagUTGwksCINcbFV
         v13VpJe3NpNHnqWU6HuSt7mgUL4nYDWy+Kj+oJlVpEA/cGzghQ/QFv2YxkzOREvcsVdg
         Et3z58jw5YMWE7F5D1Ud+UFhCwRS0ZUHqjCqEIGALmQcPozx7b7HOYQRE9rVocYojYN6
         NmXFWj0EXNklsADwU7inXqishphyvy06vjj6pRt3FszGj65oswa+824z3Jebw7mVdR8/
         X+8w==
X-Gm-Message-State: ANoB5pnzYGo0aeWwWp3tCesyQxYXjaW9DNXCPsM5IVQDQgz8PKVcCxne
        oFNMlItITqtW9ELkE/0w0cVNHC+8VZN0oGhi
X-Google-Smtp-Source: AA0mqf6vaZNTC+bOXSwaYf8dg/zdLGksVSE3FgIWIvtJ5sJRE1WWoQ9xinMoOejLW+T4Zki3NZXW8g==
X-Received: by 2002:a05:600c:3553:b0:3cf:8e62:f748 with SMTP id i19-20020a05600c355300b003cf8e62f748mr23315643wmq.175.1669216263117;
        Wed, 23 Nov 2022 07:11:03 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c210600b003cfe1376f68sm2603785wml.9.2022.11.23.07.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:11:02 -0800 (PST)
Date:   Wed, 23 Nov 2022 18:10:57 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] media: staging: stkwebcam: Restore
 MEDIA_{USB,CAMERA}_SUPPORT dependencies
Message-ID: <Y344AdRANmS3STsd@kadam>
References: <a50fa46075fb760d8409ff6ea2232b2ddb7a102b.1669046259.git.geert+renesas@glider.be>
 <20221123100831.GE39395@tom-ThinkPad-T14s-Gen-2i>
 <CAMuHMdUW8iKFjDj4fPtWfPvyQ1sjGcAy1Kz5j-osz9F4pdA47Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUW8iKFjDj4fPtWfPvyQ1sjGcAy1Kz5j-osz9F4pdA47Q@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:13:31AM +0100, Geert Uytterhoeven wrote:
> Hi Tommaso,
> 
> On Wed, Nov 23, 2022 at 11:08 AM Tommaso Merciai
> <tommaso.merciai@amarulasolutions.com> wrote:
> > On Mon, Nov 21, 2022 at 04:58:33PM +0100, Geert Uytterhoeven wrote:
> > > By moving support for the USB Syntek DC1125 Camera to staging, the
> > > dependencies on MEDIA_USB_SUPPORT and MEDIA_CAMERA_SUPPORT were lost.
> > >
> > > Fixes: 56280c64ecacc971 ("media: stkwebcam: deprecate driver, move to staging")
> >
> > Patch itself looks good but we have some style issue. Applying this
> > patch I got the following warning from checkpatchl:
> >
> > WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 56280c64ecac ("media: stkwebcam: deprecate driver, move to staging")'
> > #10:
> >
> > You have to pass only the first 12 chars of the sha1 commit into Fixes
> > msg:
> >
> > Use:
> >
> >  Fixes: 56280c64ecac ("media: stkwebcam: deprecate driver, move to staging")
> >
> > Instead of:
> >
> >  Fixes: 56280c64ecacc971 ("media: stkwebcam: deprecate driver, move to staging")
> 
> I always use 16 chars, to avoid these becoming ambiguous in a few years.
> 

If we assume hashes are randomly distributed and that people commit
100k patches every year then with 12 character we would have 17
collisions every 1000 years.

regards,
dan carpenter

