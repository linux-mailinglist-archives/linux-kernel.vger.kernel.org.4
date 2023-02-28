Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417496A6089
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjB1UoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjB1UoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:44:05 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD02459FB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:44:04 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 28FD46D5;
        Tue, 28 Feb 2023 21:44:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1677617043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1v6w6DTzkEbKtrSUwNsxP5WAtnW7YNf54tXklMOUDM=;
        b=wRdO30Sk6qRlzSXmrtf4HggMiB91LHLcJdgiNxZpkagN39Hmso7NJTx/df+RhAXG93pE7k
        gcd8XZ5C2p8MocFyLMUP5omGpE3HxJS5ktYgCVPJxAMLIKw85JlK0T55qNlVyv0gyeNXq1
        PJRbugYK6/axJs9rG8ORWbkmeCrbOoIJ0it6Un6X29L7pn2o7MCc3+3F62OTL3pJISO5Lv
        LRz7yveLxyrpGsEEsqqzcRV/CQTssk5VoMvr0MTHiJi2JZ5vFVmEFzwB1Y+PYHmYvhOAf8
        8i2bidRyuFwni+cbhqYX3DRVI2ijaaNeiKNn4c05JCUQWU+K6flyvH5f/L3Fng==
MIME-Version: 1.0
Date:   Tue, 28 Feb 2023 21:44:02 +0100
From:   Michael Walle <michael@walle.cc>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, broonie@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        quarium@gmail.com, jhentges@accesio.com, jay.dolan@accesio.com
Subject: Re: [PATCH 2/3] gpio: gpio-regmap: Expose struct gpio_regmap in
 linux/gpio/regmap.h
In-Reply-To: <5c0354c87d4d2a082cf0c331076d5aad18a93169.1677547393.git.william.gray@linaro.org>
References: <cover.1677547393.git.william.gray@linaro.org>
 <5c0354c87d4d2a082cf0c331076d5aad18a93169.1677547393.git.william.gray@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0e0901de3668baec5ce7cd4836c045a5@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2023-02-28 02:53, schrieb William Breathitt Gray:
> A struct gpio_regmap is passed as a parameter for reg_mask_xlate(), but
> for callbacks to access its members the declaration must be exposed.

That parameter is only an opaque one to call any gpio_regmap_*().

> Move the struct gpio_regmap declaration from drivers/gpio/gpio-regmap.c
> to include/linux/gpio/regmap.h so callbacks can properly interact with
> struct gpio_regmap members.

That struct should be kept private. It seems you only need the
regmap. Either introduce a gpio_regmap_get_regmap() or add the
regmap to a private struct and use gpio_regmap_get_drvdata().

-michael
