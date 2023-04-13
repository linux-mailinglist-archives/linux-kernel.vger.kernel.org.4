Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B946E0310
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 02:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDMAPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 20:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDMAPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 20:15:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066282100
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:15:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mn5-20020a17090b188500b00246eddf34f6so5707960pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681344903; x=1683936903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ur7pWq3YTZwupZ6RTjyothfqMg5i206ZuFZxJk6Y/I=;
        b=fekDZhA4lBbIEAAXrevCLVrnD0hxBCdiXWLGDnJ/LupciNG57pUvvPOdVZucB1N8P1
         peVBTaAZknhpoXK217eCiyjhtNCKaiOeYLEuYrtoj7pQRyATAnfqgnhOgKb0jBZSpYL8
         CXWYlWInT4yUzGeB2aZW2yvuzaknGlNjyP7s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681344903; x=1683936903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ur7pWq3YTZwupZ6RTjyothfqMg5i206ZuFZxJk6Y/I=;
        b=Nm6Kx7iluQ9/ywsPTIx3M9pFG/eSPlFyau8vd4Kqdbh/SC7FxHs0nvl6LWgC/z+ybl
         nGvp+1lZRpflWNcsphlGkvSvnhLCpdybgZiJTFRF+AdPy+EONdpvuZ2rCqfg04JP95yV
         rtk54K4qsnA5EUYNobIBrzFhpVusPwI39aBPECXcTcil2yzFwljRQXMXh8YciYV9x2Ri
         dPpFlIB4F4YRSBFXFG+3JKfg1Y0SjnvpIDlOp+fB9kaOEwGea8YmuG0FepPSmEoN3W+B
         IcCx0mIIcqTTQYrAJJ9Wr0wJpBlmwCbahXttFdCPYozy6jNSwy5RyPYRtfDi4Ll22Hhc
         9n2g==
X-Gm-Message-State: AAQBX9dMQwLw+8nO0ECo29s7hzwHLgMOk9xzC5VxKMYPOhXZsiO4eRjh
        NwlUA4UOkbw4+A4KUTlK0TR4uw==
X-Google-Smtp-Source: AKy350YoxGMRze3wEaT0ozyp4hV8MB3wRu4HvkTMGjZUxoLtiAQ94b70km38bi/aCBDXSpqg7iVTWw==
X-Received: by 2002:a17:90a:5606:b0:23f:e675:9c4a with SMTP id r6-20020a17090a560600b0023fe6759c4amr4177207pjf.21.1681344903416;
        Wed, 12 Apr 2023 17:15:03 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d67d:c31:eaee:d33e])
        by smtp.gmail.com with ESMTPSA id p15-20020a17090a2d8f00b00246626343aesm2010779pjd.25.2023.04.12.17.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 17:15:03 -0700 (PDT)
Date:   Wed, 12 Apr 2023 17:15:01 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] driver core: Don't require dynamic_debug for
 initcall_debug probe timing
Message-ID: <ZDdJhaZibUC0/nfc@google.com>
References: <20230412225842.3196599-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412225842.3196599-1-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 03:58:42PM -0700, Stephen Boyd wrote:
> Don't require the use of dynamic debug (or modification of the kernel to
> add a #define DEBUG to the top of this file) to get the printk message
> about driver probe timing. This printk is only emitted when
> initcall_debug is enabled on the kernel commandline, and it isn't
> immediately obvious that you have to do something else to debug boot
> timing issues related to driver probe. Add a comment too so it doesn't
> get converted back to pr_debug().
> 
> Fixes: eb7fbc9fb118 ("driver core: Add missing '\n' in log messages")
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/base/dd.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Brian Norris <briannorris@chromium.org>
