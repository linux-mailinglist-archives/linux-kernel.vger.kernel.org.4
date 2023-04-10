Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D937B6DCE51
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjDJX4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDJX4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:56:04 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798141BD5;
        Mon, 10 Apr 2023 16:56:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a52667955dso5042115ad.1;
        Mon, 10 Apr 2023 16:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681170963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2OpXlqzpmnFG/nDOpeg6txvRV3JVswtLjF2PngTclDc=;
        b=WJZ/6zORpYihd7YptekAcTimtUmsc0G0ClUjxCBdBBjGyJUH9Jj9ZcQIDm4by9Z58I
         n9chiJIUyO9RxCqG1BfLyWSUJ7R8tUhVl9pe/1bYfv2MbQ6V2J6vG+rZb9INFC2e+Jxy
         fdZfQQPk0jkOEfq5F1rGtBn20HIyH20LpIHAhANVdyhXU6Jzma2Q5vLCRUegqx0pfz0U
         o8j6YM/ZR+MkD16PuIIYBpSOc00ItGzIht0hGJK/bDOIbmk7qOWi8ktdSMakr29L15rI
         GWGgswrQUhD4W9fuUryTby3HdcERJ5427ufIs52RoIeQ2TVT4hqhKYADhB1apYmEwiTG
         buKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681170963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OpXlqzpmnFG/nDOpeg6txvRV3JVswtLjF2PngTclDc=;
        b=L5YR3gYX868feWJZnEMqXtYWHmbW96BErewQkvtTjTXamZYjxdQOMwNOMK7HzajEf/
         8UmV9CtdwE/1vNsCWbTi/rxFd3wpe4SOrny4z1rZvwOWWWbaQGfRwt+6f22Sy3W0+5Ny
         8GpoV0RSfV8LokCfl2QVZJdDaTMTUZR3DFTe303pt9h7QnEQ+WcDbXflkyqoE8JaETI7
         fNVoJ8rlfZ0PoDnsFmBKDHvT/ZM2iUj8QpRQLIulq8Iq/RXSo0QOyPRCGr08KtKnp8Z9
         /nJ6mBe1NIJfoTClO0VP+4YVXdQMJjFSZnubNqEMIRlT4yDrnT4Dz0/frYx7u9P4OMPA
         uYtw==
X-Gm-Message-State: AAQBX9caV0bzTwm7FOvy0Sut0hxz+tMwaI+six2BjPrqUP3MsfITiS8V
        r2qn/I9sjKVPDFJ4QNCuOI4=
X-Google-Smtp-Source: AKy350atjFoFFhaNs76KuqdJ4a7hnCSFrOxySPxDLGpukPZ1g7TQ0C5BPwR3Zr5btOt7rv7IizVyiQ==
X-Received: by 2002:a62:170c:0:b0:625:13f3:9409 with SMTP id 12-20020a62170c000000b0062513f39409mr14132019pfx.26.1681170962827;
        Mon, 10 Apr 2023 16:56:02 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:36c8:91ca:9ae1:e7f])
        by smtp.gmail.com with ESMTPSA id x10-20020a62fb0a000000b006259beddb63sm8325625pfm.44.2023.04.10.16.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:56:02 -0700 (PDT)
Date:   Mon, 10 Apr 2023 16:55:59 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jeff LaBundy <jeff@labundy.com>,
        Maxime Ripard <mripard@kernel.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alistair Francis <alistair@alistair23.me>,
        Jean Delvare <jdelvare@suse.de>,
        Job Noorman <job@noorman.info>,
        Chris Morgan <macromorgan@hotmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH] input: touchscreen: edt-ft5x06: select REGMAP_I2C
Message-ID: <ZDSiD3skPqT98KsO@google.com>
References: <ZDRBExF1xmxalMZc@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDRBExF1xmxalMZc@makrotopia.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 06:02:11PM +0100, Daniel Golle wrote:
> After starting to use regmap API to access registers the edt-ft5x06
> driver depends on symbols provided by REGMAP_I2C:
> 
> edt-ft5x06.o: in function `edt_ft5x06_ts_probe':
> edt-ft5x06.c:1154: undefined reference to `__regmap_init_i2c'
> edt-ft5x06.o: in function `edt_ft5x06_ts_identify':
> edt-ft5x06.c:897: undefined reference to `__regmap_init_i2c'
> 
> Make sure support for I2C regmap is actually selected by adding this
> dependency to Kconfig.
> 
> Fixes: 9dfd9708ffba ("Input: edt-ft5x06 - convert to use regmap API")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Applied, thank you.

-- 
Dmitry
