Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CC862DE69
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbiKQOkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240515AbiKQOjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:39:42 -0500
X-Greylist: delayed 111882 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 06:36:42 PST
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF48B769E2;
        Thu, 17 Nov 2022 06:36:41 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 8AFA938;
        Thu, 17 Nov 2022 15:36:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1668695799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wd2YRTNfBQNX1++Y2Bwm7RHv/EDS3nS8x52+B3H87hw=;
        b=Zivn+W3Zpmt8/8B8sgf72Wvgoy7Cn57+h0tUynkikRvDH2UMnqAGgumu2NwZqhhNteoGeL
        C4BkRXZVZos/kYTj1MAJDw/xM1EYJCITBkugejTLSQzSFIyEhnvVIDb+29ZKckFFGpglsx
        bOuB3NnMUXqAZaZcDupAkyDXDE1TICoomRzTb9qHu89WM69BDiL2dTSjBkIAa0HCJ2aXal
        Ge+RxXU/hXzgQrpb7jFuQ23h90sYPa0pkhm+nY4ufFCWkBfOZVr3OzkXoZM2nhs4e/wOPQ
        DqHypywsqMKVtu+JTXYVS5FPliZf1uRZ7Yo/z7YMHVAm6AWy1lsmFp5o4e0Q0A==
MIME-Version: 1.0
Date:   Thu, 17 Nov 2022 15:36:39 +0100
From:   Michael Walle <michael@walle.cc>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        robert.marko@sartura.hr, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH v2 1/4] gpio: regmap: Always set gpio_chip get_direction
In-Reply-To: <Y3ZDp6skghvMyaKv@fedora>
References: <cover.1668129763.git.william.gray@linaro.org>
 <1805d1ddb5bbce8e86164e66421ddde481cce4f9.1668129763.git.william.gray@linaro.org>
 <Y3DlsTAQMi6kKObJ@smile.fi.intel.com> <Y3DvUaA7YYAsypGv@fedora>
 <cc33aaa342ad60749d2f7c2a6d690733@walle.cc> <Y3ZDp6skghvMyaKv@fedora>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <57381ad0797af76838d81f44344d2085@walle.cc>
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

Am 2022-11-17 15:22, schrieb William Breathitt Gray:

>> Which brings me to the question of "why this change?". The commit
>> message doesn't mention it. Just out of curiosity.
>> 
>> -michael
> 
> Currently, the 104-idi-48 module implements a get_direction() callback
> that is executed in situations such as gpiod_get_direction() which
> aren't necessarily related to sysfs. In this patch series, the
> 104-idi-48 module is migrated to the gpio_regmap API, but loses this
> get_direction() support because it's an input-only configuration. The
> purpose of this patch is to prevent that regression by supporting
> get_direction() for input-only/output-only configurations.

I see, thanks for the explanation.

As said before, I'm fine with the change and apparently we don't care
for sysfs changes ;)

-michael
