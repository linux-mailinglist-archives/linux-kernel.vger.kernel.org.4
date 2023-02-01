Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AF9686EA5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjBATHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBATHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:07:40 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5638D11666;
        Wed,  1 Feb 2023 11:07:39 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso4238427pju.0;
        Wed, 01 Feb 2023 11:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sYuj6nuz7v0sjXdD2o8WMzkHE18hez9OL5tgTnqXQAk=;
        b=nMcK9Esu/goIpRGLlr+yK1/bMm4tJnvviLs2MEWvrY6c40nNTaOyHINW1KU3h0z+8O
         bDgyMPqH66qdR1CvqO/2Z9mVj+HqGKPxLTm6UglhB4k+24/mgsgsGZ4Pq0xRb6HLzv7v
         IOpifSSyZazk9dY5+uMgIfdl9C+L+TL8m38vAs84I5TO/KHVH68wSWJF70maxUzr9448
         GJySraFT9WpsyUy4I+b16eyDEmOfuTKiQCilG/e1TAsH7CF14SgIc+AzaxabCA7/4+Rs
         b5Ic9mikaOrXoH5HEe6Y2LcAp7lDvKvQ7geUPGHbcwr7xqjtExfXApn+G+ZmmDiiSNQK
         uQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYuj6nuz7v0sjXdD2o8WMzkHE18hez9OL5tgTnqXQAk=;
        b=1r7run5v6+4X38XC/4RjVNBODmAAGWvZ9nnlC2Dgofp+jVXurAW0ggsFFYcQhBAs31
         LhmGffDFLfiJlbOL7dWDnghjQ+nntZ28Z5e/uZndM846jQ7WrssLjRwWZft5zv0weS/p
         oH7RjxGyTFLNHCs4+dFlvDBeI54l/J5DtKOk6R0+dUhAyETwG6zWo5b8tMY9Z0vDtGWl
         tFmtbxwrPlstQJtwzysCJ2rtJsA4ZLYQvNPT5HDoJ1oZDnapp9sxdsfSBxm6chDN3pMa
         v2vdX2fhMaQzrNzv1hTwJk82hIF0GU9OfGs6tFk+24XqK1qgJQCVjQgPZqCwTuqqVzk/
         FJag==
X-Gm-Message-State: AO0yUKW4DOLttnj4+3FWskKsqFw+qM7PQ/+7tw19SPHXm9dYFVGfaBH2
        66t9VrTubwtxpQvJLvrO6A4=
X-Google-Smtp-Source: AK7set+ED2oLNbgFQ9PfGXKYC/HceWqgT7wYL1GIEEu8YXSNzIaMczza1J93jht+jIhBWlGe2Sk3Rg==
X-Received: by 2002:a17:903:246:b0:198:a715:d26d with SMTP id j6-20020a170903024600b00198a715d26dmr4962789plh.8.1675278458735;
        Wed, 01 Feb 2023 11:07:38 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:ce3a:44de:62b3:7a4b])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b00198bc9ba510sm342625pli.71.2023.02.01.11.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 11:07:37 -0800 (PST)
Date:   Wed, 1 Feb 2023 11:07:35 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] gpiolib: remove gpio_set_debounce
Message-ID: <Y9q4d50lSdPn8myb@google.com>
References: <20230127101149.3475929-1-arnd@kernel.org>
 <20230127101149.3475929-5-arnd@kernel.org>
 <Y9n8P1rP+cYyoNIH@google.com>
 <Y9qwJtOaKrgB5n+T@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9qwJtOaKrgB5n+T@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 08:32:06PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 31, 2023 at 09:44:31PM -0800, Dmitry Torokhov wrote:
> > On Fri, Jan 27, 2023 at 11:11:46AM +0100, Arnd Bergmann wrote:
> 
> ...
> 
> > > -	return !gpio_get_value(ts->gpio_pendown);
> > > +	return !gpiod_get_value(ts->gpio_pendown);
> > 
> > No, we can not blindly do that without checking annotations on GPIOs.
> 
> But this is easy to fix, i.e. use raw API, no?

I'd rather not (I hope I can make this driver respect declared polarity
at some point), so for debounce we could do:

	gpiod_set_debounce(gpio_to_gpiod(), ...);

in ads7846 for now, and get rid of gpio_set_debounce() as a publc API.

Thanks.

-- 
Dmitry
