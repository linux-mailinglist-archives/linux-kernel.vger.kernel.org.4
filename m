Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D2862C2D1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiKPPlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiKPPle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:41:34 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33A8B0F;
        Wed, 16 Nov 2022 07:41:32 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id C72D41263;
        Wed, 16 Nov 2022 16:41:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1668613290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2F78YjxH2a34CI1gMLFIIT7Y5/nrDbaYWsLpgUPqeDg=;
        b=CbmeF8L4TZOd8wwBTDXuAwc0ozrB2Zv1RGjH4S+Nb7sWe9UqRYtNBiRNJaOhoNcNSQWBOd
        AutILcol5Zk+ILXlvps10qv4wdwC62G/+ZQaQa/LnucfBUh/VCdX7xc8FoJkNlZZYcX0Bb
        GAVlaCyFEGm1WPdO9oKHiE1K6cf3lnKm+v8+clHgMl08Exl9VXjV3dz9021qkQSVbO5wKt
        26E7idLhRdz3xXQzE4mojcTgOywD5mcJCss3Q/8Caj/7OH6zYhIM+O+pDqd5XwbgzFfQYi
        PXB9vIUxVim6xdLwjVKSGWEKvZLD2jhlr+nXDUmvLP4UsxieFVIalZ3xRNyYKA==
MIME-Version: 1.0
Date:   Wed, 16 Nov 2022 16:41:30 +0100
From:   Michael Walle <michael@walle.cc>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        robert.marko@sartura.hr, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH v2 1/4] gpio: regmap: Always set gpio_chip get_direction
In-Reply-To: <Y3DvUaA7YYAsypGv@fedora>
References: <cover.1668129763.git.william.gray@linaro.org>
 <1805d1ddb5bbce8e86164e66421ddde481cce4f9.1668129763.git.william.gray@linaro.org>
 <Y3DlsTAQMi6kKObJ@smile.fi.intel.com> <Y3DvUaA7YYAsypGv@fedora>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <cc33aaa342ad60749d2f7c2a6d690733@walle.cc>
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

Am 2022-11-13 14:21, schrieb William Breathitt Gray:
> On Sun, Nov 13, 2022 at 02:40:17PM +0200, Andy Shevchenko wrote:
>> On Thu, Nov 10, 2022 at 08:55:50PM -0500, William Breathitt Gray 
>> wrote:
>> > If you only have reg_dat_base set, then it is input-only; if you only
>> > have reg_set_base set, then it is output-only. Thus, we can always set
>> > gpio_chip get_direction to gpio_regmap_get_direction and return
>> > GPIO_LINE_DIRECTION_IN/GPIO_LINE_DIRECTION_OUT given the respective
>> > register base addresses configuration.
>> 
>> Seems legit to me. Have you checked if we have any gpio-regmap drivers 
>> that
>> have something like this in their configuration already? In such cases 
>> we need
>> to be sure they behave as expected.
>> 
>> From the code perspective:
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I see gpio-sl28cpld has two device types SL28CPLD_GPO (output-only) and
> SL28CPLD_GPI (input-only); gpio-tn48m similarly has two device types
> TN48M_GPO (output-only) and TN48M_GPI (input-only). It doesn't look 
> like
> the change in this patch will cause problems for them, but I'll let
> Michael Walle and Robert Marko comment if they see issues here.

For the sl28cpld driver this shouldn't be a problem. So for that
Acked-by: Michael Walle <michael@walle.cc>

But back when I wrote gpio-regmap the bgpio served as a blue print.
There is the same handling. If you look at gpiolib-sysfs.c there
is a comment about the direction property:

  * MAY BE OMITTED if kernel won't allow direction changes

So from a gpiolib/sysfs POV I'm not sure about this change. Does
get_direction == NULL means setting the direction isn't possible?
OTHO there is a fat "MAY" :)

Which brings me to the question of "why this change?". The commit
message doesn't mention it. Just out of curiosity.

-michael
