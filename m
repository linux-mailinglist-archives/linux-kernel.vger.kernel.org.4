Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514605B986B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIOKBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiIOKAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:00:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF96686B5C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663235891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mGvd9tOaiGgoI73BcMUDvU/wRhCgiH1mvFcKV3hzfHg=;
        b=Jvli+ZQLSwvgDXZNCbbEaVZ9+IWAt94NHnM3XX7F9eXWN97fy+L6uKlmaFf6g4OZFT7pQk
        v8o1hbGF7ud2scEA+cP0yWWMtoIMFDQ4GacuMxK2LZwnwmz2LkozWh05fcVHMjplMPobny
        jL2tJZcM6792fiwFFnkPmMXJCj1YFCM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-425-PsPsOSgQPjOqK51tJTNDTQ-1; Thu, 15 Sep 2022 05:58:08 -0400
X-MC-Unique: PsPsOSgQPjOqK51tJTNDTQ-1
Received: by mail-wr1-f71.google.com with SMTP id h2-20020adfa4c2000000b00228db7822cbso4592049wrb.19
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=mGvd9tOaiGgoI73BcMUDvU/wRhCgiH1mvFcKV3hzfHg=;
        b=BBG2UDYEIIb0IbsrGXOtuhGHc+PIch/q6P99LHmOPo1/9hH8slIWDCQYNasPoAjwQ7
         0DQ18SCcHLgZx+FWUwusHBjwmSzGCdTP2wh0cIOY+fdLLTXgyKDmOsYlcenolNnBZEXl
         x3SqiPiF9KBHTC6oHrZoI+jQSsxnLyJL+YcBS2Bc611IN8eSrOuXmIxlyGgNlL9LyasY
         Xb7fiHHbZS6NEKWZ14LYUUC/7vtQN39XxyeFRTOJmoKbNwNH/yzeXcxFD6unrymnDHEP
         +2wu0U+IY+yO19Q1UxGAjZpF/kl716XuzLWnuy5UzU71bj8PB1X0q6QSkh+VKPAAqqO7
         fDQw==
X-Gm-Message-State: ACgBeo0NbZRjWZsrJDXy8sY0KG5ooDNfoJ5Fk7gFnu/RbKG7Mvs8oqij
        SCn1r6WAEmspifkpoM6r5o84aCrjajJTshtMwFf68VF0+ZuWde5M94FqzAAaiQ1vBP66FkzMULx
        Dul+kbr07dfI/YxEQTh9nxC7b
X-Received: by 2002:a5d:628e:0:b0:228:6961:aa6f with SMTP id k14-20020a5d628e000000b002286961aa6fmr25454714wru.36.1663235887421;
        Thu, 15 Sep 2022 02:58:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR77khIjrZ/VrrFBgy3PGrRTawhQua93lXo36YchQhSYV3T98xPVo5WMrU0DOdJgVSarD/WWxA==
X-Received: by 2002:a5d:628e:0:b0:228:6961:aa6f with SMTP id k14-20020a5d628e000000b002286961aa6fmr25454693wru.36.1663235887053;
        Thu, 15 Sep 2022 02:58:07 -0700 (PDT)
Received: from gerbillo.redhat.com ([212.2.180.165])
        by smtp.gmail.com with ESMTPSA id z4-20020a05600c0a0400b003a540fef440sm2731476wmp.1.2022.09.15.02.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 02:58:06 -0700 (PDT)
Message-ID: <3f25f8fa3ba1aa13ac0779ca48020ab63405c7c7.camel@redhat.com>
Subject: Re: [PATCH 1/3] net: davicom: dm9000: switch to using gpiod API
From:   Paolo Abeni <pabeni@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 15 Sep 2022 11:58:05 +0200
In-Reply-To: <YxnawswbdbTtx9WQ@lunn.ch>
References: <20220906204922.3789922-1-dmitry.torokhov@gmail.com>
         <CACRpkdaUK7SQ9BoR0C2=8XeKWCsjbwd-KdowN5ee_BU+Jhzeqw@mail.gmail.com>
         <YxnawswbdbTtx9WQ@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-08 at 14:06 +0200, Andrew Lunn wrote:
> On Wed, Sep 07, 2022 at 11:45:48PM +0200, Linus Walleij wrote:
> > On Tue, Sep 6, 2022 at 10:49 PM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > 
> > > This patch switches the driver away from legacy gpio/of_gpio API to
> > > gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> > > make private to gpiolib.
> > > 
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > I think net patches need [PATCH net-next] in the subject to get
> > applied.
> 
> Correct.
> 
> https://docs.kernel.org/process/maintainer-netdev.html
> 
> For the odd drive by patch, the Maintainers often do accept patches
> without it. So wait and see.

Due to a series of unfortunate coincidences the netdev backlog has
grown unusually long. Since the patches LGMT I'm going to apply them to
net-next without asking a repost.

@Dmitry: next time, please add the relevant tag, thanks!

Paolo

