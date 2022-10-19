Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B46052C0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiJSWEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiJSWD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:03:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3BF1BE936;
        Wed, 19 Oct 2022 15:03:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id q9so43207790ejd.0;
        Wed, 19 Oct 2022 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XtHG5hK716DqSXJDEcEPWfMkqPJ9JT1lrZYAk1aDGAc=;
        b=n7NTRR6F1yO3y6tvoS5o+dzNIbd5bWNbAATlKtj5YQ9T0UyZKxSOzQAqlEmBCLjEdM
         dTjO9a9iOQUeWg343epbYqyKdk7XIfi9RkQn8ywTdJNSPPO9SjK4qzO64JSfVExW5leB
         SyH5fGjkEY7MnuRX/TlKn2ZfKhkkTIGwdL2rnM2rb7CQ4KHad9Fa2g/kfL4UaCWWvdu8
         D9cwOXZT98AgaN/Nqda8yoi4qaxDRDfZRGu5ud08D5eUtTzA3hOZD7TtEYSzTbZTxA0Y
         1GttO62rmg3yDrFh9x6htZX+LyoXZWEolOiLTW6FfFbFFCaJFddWx0wuNr30c5CW3ROZ
         4AdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XtHG5hK716DqSXJDEcEPWfMkqPJ9JT1lrZYAk1aDGAc=;
        b=0TF77Pzs2jgooJbHX4VGZ15TixtM0W4tKIQkb3ctXhSgHyjUch3xkRlb6Skal7Mu5I
         B7koqPyic6HGSp2XFjILu3gejR3egcnBJ11QbMC62GLdvyg+nGhAkeVTg9bIsZOlJUiq
         DYqzKbw3RDSxEpCGXUIaeaW6ou9dfgqGzal1lA6HmhuJRp9axaiCwOalqsF4EKbh9glW
         3GgOkWp24qr8jNk1O73Ck73Wo3cLbB3aAqll1aClBuuta5morepNroHeGGPS/n2QawZZ
         0xO7LdxaAa8x6fhuHzLyzy5+mGg9NkljYdSEfxXBSikhpia+TkWU/YCdTdrbhV7iMfSH
         wUWg==
X-Gm-Message-State: ACrzQf2z/seXtqk4NOcdM77q0pnM2V5MXhQmrGtgKFkeKH31b3ORcqVu
        2p5BQMTUDZs4arVXvTEM5D3N8RCjz8oXbUbI5S39XipXo6c=
X-Google-Smtp-Source: AMsMyM6T1hKb8SWZQEjuaVPwPmoTNAF1hmp7xL/0tGVcVJCQ1ReCkUWW+Thghz9JOmkej5oIRnCxdYHvFfPhD9ubtzE=
X-Received: by 2002:a17:907:7f92:b0:78d:ed9c:d86f with SMTP id
 qk18-20020a1709077f9200b0078ded9cd86fmr8529786ejc.251.1666217037000; Wed, 19
 Oct 2022 15:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221019214108.220319-1-martin.blumenstingl@googlemail.com> <0d1b4fed-7ded-88fc-3c37-4f859fc505c1@roeck-us.net>
In-Reply-To: <0d1b4fed-7ded-88fc-3c37-4f859fc505c1@roeck-us.net>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 20 Oct 2022 00:03:45 +0200
Message-ID: <CAFBinCAutvvNzSD7HXfMzLOg-NZ3ubifjtHzC9yURe=BZJQEiA@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (jc42) Restore the min/max/critical temperatures
 on resume
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thank you for the quick feedback!

On Wed, Oct 19, 2022 at 11:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
[...]
> > +     if (data->valid || data->temp[t_min])
>
> This contradicts "with applying the previous values by only configuring
> them if they are known valid". It explicitly applies the values if they
> are marked as not valid, and it also applies the values if they are 0
> (I don't really see the value of doing that).
>
> Sorry, I don't understand the logic. Did you mean to use "&&" instead
> of "||" ?
My understanding is that that:
1) data->valid = true is only set in jc42_update_device() (which is
only called when reading back the values from the registers)
2) jc42_write() can write values without setting data->value = true
In other words: if jc42_read() is never called but jc42_write() is
then we still have some setting to apply while data->valid is false.
Whether that's possible in reality is something that I'm not sure
about.

If your suggestion is to simplify this to use data->valid only then I
can do that.
It would be great if you could also comment on whether
jc42_update_device() should be called from jc42_suspend() to give the
driver the chance to at least read the data once (and set data->valid)
if this has not happened before.


Best regards,
Martin
