Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B535D652630
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiLTS1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiLTS1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:27:34 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B911DA77;
        Tue, 20 Dec 2022 10:27:33 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so17334908pje.5;
        Tue, 20 Dec 2022 10:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue71Sm65axNrCgD942I0Cs8ltFCR+b4KhQL9sG46Wuc=;
        b=eNPQkGHHS40PEuqaFz0jy8oj0l0rtkJQ3VMkBrT3Ms+QkeIvbjNJcHDj2vUxOtgors
         KpLNEQlAk/GfjiCr8GjdidTJVtGPfZczIGWbmzlzTREtyiT3xe4sMfstbP1p8p5mtAle
         rq7grfkIHkXQjsReZYeIvkGOgPnbmMQLorjDnTA339B4aH1guCtlo7hJSqzLAtag3Lq/
         MK5mwyGfyUi8sZ/ki1iMeN7oS6ODBKET8BiGB1dFHnsBtfbQTpNrV9xgOGSdIY8RhZHH
         5ILRPemnJMQpyebfPkL6VyUi7UW9C/AP2xKqAfJKv2qnfBotlFCTE98ojOuBs6jTGxA/
         EFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ue71Sm65axNrCgD942I0Cs8ltFCR+b4KhQL9sG46Wuc=;
        b=cBgPEuBCNK97EFc5Tn9VVUQg7SBHTz4WqOQdRMPm3r5mnE3wiFL78Fx9qX4xyOIVKy
         PTyythi9fYwadbeuGrQ3pVJcheUQ2MG/EvsDtIcSIdFi3xkpMuUclSN37HdLBKvSZYvg
         iB4B8kirO9L9FulakgVqGw6v8YEEsKnkQBed8348KYlsJfKpvTTVTPXlmYaK1GIj0kti
         /aCvkPGQ3ince5V9pEewXNWhvbBL6jcNL+5oFlfdwBkDNb7cgysUs0AYgeqbPjmuw/ES
         8qqFutjpl03W2k2Nv17rY5FcvvkmWO3ZsfprHHnIrKrvkDjyoSY6y0HwRHnQTuMj8tZd
         mf9Q==
X-Gm-Message-State: ANoB5pk/ik8IwssU99j+QQMXurTUWjKjnnK0xWNWBiCUO+zLAHdmMSjc
        Qby+9UHWXB03H6d+/pQIkMQ=
X-Google-Smtp-Source: AA0mqf55dfKKurRcDmvOc9m9YPf9T/PJICcdWQHgf8jKGdeqxIsmDDQNXf4PEeO16ZzckpDCS0E3uw==
X-Received: by 2002:a05:6a20:4414:b0:af:7b32:4deb with SMTP id ce20-20020a056a20441400b000af7b324debmr42901341pzb.4.1671560852341;
        Tue, 20 Dec 2022 10:27:32 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:7206:404e:4820:d175])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902e74800b0018f6900a183sm9737384plf.140.2022.12.20.10.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 10:27:31 -0800 (PST)
Date:   Tue, 20 Dec 2022 10:27:28 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] gpiolib: of: stop exporting of_gpio_named_count()
Message-ID: <Y6H+kFR+vilCh8HH@google.com>
References: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
 <20221219192016.1396950-2-dmitry.torokhov@gmail.com>
 <Y6G9sOYhThlE3dGu@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6G9sOYhThlE3dGu@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 03:50:40PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 19, 2022 at 11:20:13AM -0800, Dmitry Torokhov wrote:
> > The only user of this function is gpiolib-of.c so move it there.
> 
> It's one liner used a single file, can we kill it completely?

It is being called from a couple of places there and documents how
exactly we are counting GPIOs, so I would prefer to leave this helper as
is.

Thanks.

-- 
Dmitry
