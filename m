Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B43607DF4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJURvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiJURvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:51:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D909E27A8B0;
        Fri, 21 Oct 2022 10:51:34 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g27so8667892edf.11;
        Fri, 21 Oct 2022 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M+qMJPAM206ZG6jYEK+iUaPybJ0KFz78NGtqUoA8D+U=;
        b=bP9kOz8ej/KJdTJ/XSiLo3b4LP/0qf0w0sPT/cSQdU+OAb1hzczmv2/o33AQvhO0yU
         aJLFxH6TEecQ96KazLJT5FO6rbjXJY8qszAcVZUaKvJ48ZX1+e7UDv9gx1xyAp7BDFvl
         RIlTSZWzm6ENSodbKtjbENFw/Uraaopu/OqxssuXc+HLKBNncF/QezSzmhDgXSoQ+1LU
         c57u2ucUtCGHhAOf2vnKU4udYy+DvuKsGXqXbCsXIkplCQoJkTd7iG5+Jxk1hoj4vW+j
         RlO/tyYUVOHkC8YMk+D5PxdRt9xtecaMeTgLg5xN6G7O3WhQnMmS/gGqbDnU/gzQ604j
         TD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+qMJPAM206ZG6jYEK+iUaPybJ0KFz78NGtqUoA8D+U=;
        b=RkB3VlUuADrVASJsOi3HseOmUjMYbck9J6LCcxFrxcAHWCNEKSr13UURNRsR4YgJq5
         1T7npc0InvvBqRZnRBkIv/H9/RKPrexjF6BBmcpuQ8Nwmy/01zySQt/WjBdndNYce6MH
         y6qoxQXpHG9XoqRCP+OJ643hIkdU8991bT/55cFH6DMMl3aARSDe2zRefdOL/YI/uQw0
         gYZpMcFNNB5T1/HeVNrw/dVd82MFj75PkKy2e7cQUU+NIWVwByWYiHUMKGwUrCuXG0Nd
         syD29SnUsDbnuKiWi3SBsB31nA8WQLVD/XEJMm7IUmxXAOXUA4xayPR89AZ4HqVJ3Ckq
         ySpg==
X-Gm-Message-State: ACrzQf2ZVjNVPrAzaS2PLt7dfO/LE6br4N2KleC+FMoLtufABCye7i0l
        vT9rLU8sD+cGc2cLPVouNFUtV45jxYbsUXZJVyU=
X-Google-Smtp-Source: AMsMyM6ktbMcrfCvZxkur7W3cDXLJp3CgHJCOYKaEc2Q0deyPHl+Dvz0KOoDB8gu7z1Mc5qRUjPN+aUMI0A+JEGFIsg=
X-Received: by 2002:a05:6402:90e:b0:443:ec4b:2b03 with SMTP id
 g14-20020a056402090e00b00443ec4b2b03mr18258335edz.71.1666374693053; Fri, 21
 Oct 2022 10:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221021165000.1865615-1-martin.blumenstingl@googlemail.com>
 <20221021165000.1865615-2-martin.blumenstingl@googlemail.com> <20221021171127.GB1888515@roeck-us.net>
In-Reply-To: <20221021171127.GB1888515@roeck-us.net>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 21 Oct 2022 19:51:21 +0200
Message-ID: <CAFBinCDRA-Xw_Y9PkL2vmCqW3A1vCWeRB2EDEJQgQ+qKMn9dYw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] hwmon: (jc42) Convert register access and caching
 to regmap/regcache
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Fri, Oct 21, 2022 at 7:11 PM Guenter Roeck <linux@roeck-us.net> wrote:
[...]
> > @@ -368,17 +361,14 @@ static int jc42_write(struct device *dev, enum hwmon_sensor_types type,
> >               }
> >               data->config = (data->config & ~JC42_CFG_HYST_MASK) |
> >                               (hyst << JC42_CFG_HYST_SHIFT);
> > -             ret = i2c_smbus_write_word_swapped(data->client,
> > -                                                JC42_REG_CONFIG,
> > -                                                data->config);
> > +             ret = regmap_write(data->regmap, JC42_REG_CONFIG,
> > +                                data->config);
> >               break;
>
> This code sequence still requires a mutex since another thread could modify
> the upper limit (and/or the hysteresis) while the hysteresis is in the process
> of being written. Worst case there could be a mismatch between the value in
> data->config and the value actually written into the chip. Granted, that is
> unlikely to happen, but the race still exists.
Thanks for spotting this - this is indeed a potential issue.
Do you also want me to add locking for the data->config access (read)
in jc42_read()? Without a lock there in theory jc42_write() may have
already updated data->config with a new value while hardware still has
the old value. So in the end the read output may show a hysteresis
which was not programmed to the registers at that time.


Best regards,
Martin
