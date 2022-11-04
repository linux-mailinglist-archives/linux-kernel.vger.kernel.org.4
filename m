Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D9461A60B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiKDXm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiKDXmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:42:54 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229863F05C;
        Fri,  4 Nov 2022 16:42:53 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-13b23e29e36so7147807fac.8;
        Fri, 04 Nov 2022 16:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ArliHFRLMrUBzxNAEsi7DOHZyQivpHrE5EgeeYgXH9M=;
        b=pQB+qY7yzZ+C3zrAdAY6GzZMyoXLno/McNqMGfcwzqeEn5xoi1tnJ5ut1RQJRiZK4x
         FBh0KbFgRhQfm4tpo/4stYw4BVd8QAJYighxZAuxWkUjxFjxsw1EU4DbMDK0xvOOO+oi
         LrHiiwrmRSvJ6HA1MyEjLvZK95/Y/IXEVAv5esO1MTmyrqEq/76lgrJPgd4+lK/OdgqB
         797iizC1+MjlsTzbxQYqU1nLqTk7VIxLe4x0ejJ1XvGo2lK2D7l9g2hd31GC4nmT4eMv
         9an/UQUV24j7Ysk230P36NCxDxUSNRkD8Ew4zL+PxSvPmH1jjxIoTHF4O6ZLKRElBbO4
         A19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArliHFRLMrUBzxNAEsi7DOHZyQivpHrE5EgeeYgXH9M=;
        b=LIMRRVrHPmPjvQncG9WDQkepkgj+jPDqeBIQUIL4fhXdpZBlEuCiWMENvCpldx0wAy
         d34OUHcnWXC3cA52Jg3ceg3aG9WFrza6uWFeUBttQOgV/yE2abZWfMyI1l7tYu3Kmu04
         BwF2gUZkVGwMHTE5UCCX5szyoiR2QgfP5uqh+S5A1GK2rJy5m8OVD5PMxHrH9rTne1R/
         Wi2gwi/ImowXB0MNvaTPXfHWd+2keKWR+j/TdKAfmcplfY4qQyZMA1kj1BSG6yRvLKMi
         FQc75fNuOtIwpNmH/tgVK8PCau7+rmlX7s7tE21+5g+tDJck7dsec4hwXw7jHlBQD8PT
         bSyA==
X-Gm-Message-State: ACrzQf0WklcvrQdSIkzzCuM0wFrSCdJOUZkBxkkWvmhnjqj4UsrUTQj/
        s8pVd6NXJy6Mny18UCjwraI9UrCOCZU=
X-Google-Smtp-Source: AMsMyM5WyeJBLnwZYkuNd371eDdZNScFOWOCgmoYRrcZBluVnOZmC0nzSp/b8Hl3QpM57vqv3tiqEw==
X-Received: by 2002:a05:6870:c185:b0:137:5188:d2d7 with SMTP id h5-20020a056870c18500b001375188d2d7mr33491084oad.296.1667605372492;
        Fri, 04 Nov 2022 16:42:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c12-20020a056830000c00b0066c39c99ae5sm300516otp.25.2022.11.04.16.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 16:42:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 4 Nov 2022 16:42:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v2 1/1] hwmon: (pmbus) Add regulator supply into macro
Message-ID: <20221104234250.GB2443898@roeck-us.net>
References: <cover.1645437439.git.sylv@sylv.io>
 <58f2ff7b90233fad3d7ae2e9d66d5192e2c1ac01.1645437439.git.sylv@sylv.io>
 <20220222165104.GA255067@roeck-us.net>
 <Y2WShmSmnEjpgVEE@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2WShmSmnEjpgVEE@hatter.bewilderbeest.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 03:30:30PM -0700, Zev Weiss wrote:
> On Tue, Feb 22, 2022 at 08:51:04AM PST, Guenter Roeck wrote:
> > On Mon, Feb 21, 2022 at 12:09:56PM +0100, Marcello Sylvester Bauer wrote:
> > > Add regulator supply into PWBUS_REGULATOR macro. This makes it optional
> > > to define a vin-supply in DT. Not defining a supply will add a dummy
> > > regulator supply instead and only cause the following debug output:
> > > 
> > > ```
> > > Looking up vin-supply property in node [...] failed
> > > ```
> > > 
> > > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > 
> > Applied to hwmon-next. That should give it some time to mature,
> > and we can pull or modify it if it causes any problems.
> > 
> 
> Wish I'd caught this sooner, but unfortunately I've just discovered that
> this does in fact cause breakage on my systems -- having regulator-dummy set
> as a supply on my PMBus regulators (instead of having them as their own
> top-level regulators without an upstream supply) leads to enable-count
> underflow errors when disabling them:
> 
>     # echo 0 > /sys/bus/platform/devices/efuse01/state
>     [  906.094477] regulator-dummy: Underflow of regulator enable count
>     [  906.100563] Failed to disable vout: -EINVAL
>     [  136.992676] reg-userspace-consumer efuse01: Failed to configure state: -22
> 
> A simple revert solves the problem for me, but since I'm honestly a little
> unclear on the intent of the patch itself I'm not sure what a revert might
> break and hence I don't know if that's necessarily the right fix.  Marcello
> (or others), any thoughts?

Revert now, ask questions later. I'll send a patch.

Guenter

> 
> 
> Thanks,
> Zev
> 
