Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0FD62E1F2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbiKQQd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240512AbiKQQdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:33:04 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7452C82204;
        Thu, 17 Nov 2022 08:30:31 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id A7DE984;
        Thu, 17 Nov 2022 17:30:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1668702629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bRUKljahZwvTGsaOsNNcvH3faXTDENWxWJxvCIKAQJo=;
        b=1RrZUfw1mQ6RN4Z60F1UKGjIiA9GiZd1LypTS3hZ2rKxxjtDe+ilhbZdi5fjMlnDIkooRd
        Iiim0xa0HCZSfR2aykoYVmFZgtCGHSTJ36Bez/14p0Lkl5Pw5T4SszUTT83JFZFXf2HShu
        w92/VQslLqsW+I6SepLf9FTIEIdvV5OZ4HEsZv0OavL8NSLeyL9inaU0nGhk2hCuiTXEfO
        6Ci8JfOPPUbzQwUaCxEsR57RqjSEc4RAIU+64HYfzgjOAKqPJmwGtSGr1uWQSelmd6+kdI
        MBN7SB9Tg/9AsQHl5WUg8OKaOKoc12SDNKqzNNVSRxzrQp7rG/sK7WNDGgKbaw==
MIME-Version: 1.0
Date:   Thu, 17 Nov 2022 17:30:29 +0100
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] gpio: i8255: Migrate to regmap API
In-Reply-To: <Y3ZflHI6CYfaGIbn@sirena.org.uk>
References: <cover.1668129763.git.william.gray@linaro.org>
 <61327a67cc308af413471a69a4810b2785e53e8e.1668129763.git.william.gray@linaro.org>
 <5123090e11da67e57fb00984445ece2f@walle.cc> <Y3ZflHI6CYfaGIbn@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <bbe25d96e892e8cfd3f0da5d6755be22@walle.cc>
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

Am 2022-11-17 17:21, schrieb Mark Brown:
> On Thu, Nov 17, 2022 at 05:18:55PM +0100, Michael Walle wrote:
>> Am 2022-11-11 02:55, schrieb William Breathitt Gray:
> 
>> > +	gpio_config.parent = config->parent;
>> > +	gpio_config.regmap = config->map;
> 
>> I'd propose to add a new config flag to indicate that accesses to
>> the device will be fast:
> 
>> gpio_config.regmap_has_fast_io = true;
> 
>> which will then set gpio->can_sleep = false.
> 
> It's probably useful to provide a query function in the regmap
> API for generic regmap users like this.

Now I'm confused. Last time, I've proposed that, there was push
back from you:
https://lore.kernel.org/linux-gpio/20210430151908.GC5981@sirena.org.uk/

That being said, I'd prefer to have such a query API :)

-michael

