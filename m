Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB9D6EF3D4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbjDZLyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240581AbjDZLyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:54:36 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEE05B9A;
        Wed, 26 Apr 2023 04:53:48 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 7EC50D27;
        Wed, 26 Apr 2023 13:53:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1682509983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RGgieoJu2M0mWFk816sGTOLEYpz179EmxMrNMNHPmVs=;
        b=FJ73v2j09tV5wSSysU854ogO76xRRAlxU4aMTuFnoTdmNaR3BzbHZqcncONGr7tz9DsLbL
        ztZm4oTI+ZOfH0Qk6k9FZf/9sMS4GLBVCwh7vekTd5q1gn4zhjRQFhqxb7gZwQvceqL4Ox
        eugvqzb/Z6vVbrCJVhXCk75vSJf31YIUlrttLhrj7Cn0OL0lDMMq0IZdNVMBo4PYw1aukN
        mf2huzqw9jP90/Xabywro7N7VYyyxhqX9KDDBpMgRdC6+CiSdLLcWXEnS9vwYOiYwccmAy
        bc0MYlfVptdwJZgwbG0FXvTujcqQJWv/z7w3Qi3JRlrZOpLAPrqCwQ4Pwev3bg==
MIME-Version: 1.0
Date:   Wed, 26 Apr 2023 13:53:03 +0200
From:   Michael Walle <michael@walle.cc>
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     andy.shevchenko@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
In-Reply-To: <MN2PR03MB5168689A20C8D6C67F119BB7E7659@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230327130010.8342-1-okan.sahin@analog.com>
 <20230327130010.8342-3-okan.sahin@analog.com>
 <CACRpkda5G5b+At5s1WFudpQBQ6LDQxhE3fZj7eBhkZ=thvnQhg@mail.gmail.com>
 <MN2PR03MB51682210CADA6E33FB99052CE7939@MN2PR03MB5168.namprd03.prod.outlook.com>
 <CACRpkdZJA0DyzgLxm9HFeHO03rqNUff=avuV=VrGuJkkOg6wNQ@mail.gmail.com>
 <25e1fda4b6df2d10444d7eca3cd0e387@walle.cc>
 <CACRpkdYKEid8-0-7sBECNgSyW3kMRCsv3DeBVUzxo4z6p+Grnw@mail.gmail.com>
 <ZDBivYlwJ6zgaFTg@surfacebook>
 <MN2PR03MB516879DCD6600827AEE2BDC9E7949@MN2PR03MB5168.namprd03.prod.outlook.com>
 <a3ca3e705b5b8668cd511fc15681c75f@walle.cc>
 <MN2PR03MB5168D7940E322DFC0A1A3148E7679@MN2PR03MB5168.namprd03.prod.outlook.com>
 <1ff70a97dfbcaddd69029001ce99bb69@walle.cc>
 <MN2PR03MB5168689A20C8D6C67F119BB7E7659@MN2PR03MB5168.namprd03.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d4a6a640c373b6d939e147691efa596c@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I think I understand what you are trying to say so far. I did not have 
> too much
> experience related to gpio. I will set pull_up register in .set_config
> However, I did not understand where its parameters come from.
> set_config(struct gpio_chip *chip, unsigned int offset,
> 	      unsigned long config)
> It might be trivial question, but Where does config come from?

Others have to answer that one as I don't have that much experience 
either.

> At the end, I should rewrite the code using regmap_gpio, right? So if I 
> rewrite
> code using regmap_gpio, how can I replace set_config(...)?

You'd have to add a .set_config to gpio_regmap_config and then in

gpio_regmap_register():
   gpio->set_config = config->set_config;

I don't think it makes sense to have a default implementation in 
gpio-regmap,
the variances between "simple" gpio controllers might be too broad.

-michael
