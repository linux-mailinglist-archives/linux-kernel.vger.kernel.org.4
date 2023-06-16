Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC227337D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbjFPSC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjFPSCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:02:25 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF4130F7;
        Fri, 16 Jun 2023 11:02:19 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 04802156;
        Fri, 16 Jun 2023 20:02:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1686938537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eIHJ2QfFukG4vpUDvtvYpyy2v1OCiVGRJxhVd3mkd+E=;
        b=mVK99UndmKPksUU/pbftjQEF74gtBJxZxs5NgrWNK4snu0k1nM5+WcYVAZFIJxyE0xsir/
        uaWrwkz5Va+mtDs4XSE4ymtbNpVYSn/HlyYgAbMmoa2S0mU5AXyMPpMA8JBjRJ01xzq5Q8
        o7eiYbiYhEdgkVn2G8ENEeGfgAehUu9YNVJh9I0s45eMP+x7F0SdZtCl4qYjMmrMTML2VR
        XfZQ9EX6HVCcBRWSu113ST0SrylYDCpHqox9E7+DyAUCCICb+ATyPdg74/SIPG9SLx2QXU
        /ogZ2p5IWHeRr0C6/pCMQzyDLALjJDOURiqY7tN+xTWgTgjn6atGZoS8XrY0pw==
MIME-Version: 1.0
Date:   Fri, 16 Jun 2023 20:02:16 +0200
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH] gpiolib: Fix irq_domain resource tracking for
 gpiochip_irqchip_add_domain()
In-Reply-To: <ZIxuExRypHsUejFI@smile.fi.intel.com>
References: <20230616-fixes-gpiolib-irq-domain-v1-1-27fe870db961@kernel.org>
 <ZIxuExRypHsUejFI@smile.fi.intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4b55afe91d2a704c0229340c5ea4885e@walle.cc>
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

Am 2023-06-16 16:13, schrieb Andy Shevchenko:
> On Fri, Jun 16, 2023 at 09:30:06AM +0200, Michael Walle wrote:
>> Up until commit 6a45b0e2589f ("gpiolib: Introduce
>> gpiochip_irqchip_add_domain()") all irq_domains were allocated
>> by gpiolib itself and thus gpiolib also takes care of freeing it.
>> 
>> With gpiochip_irqchip_add_domain() a user of gpiolib can associate an
>> irq_domain with the gpio_chip. This irq_domain is not managed by
>> gpiolib and therefore must not be freed by gpiolib.
> 
> With or without below nit-pick
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 
> ...
> 
>>  	/* Remove all IRQ mappings and delete the domain */
>> -	if (gc->irq.domain) {
>> +	if (!gc->irq.domain_is_ext && gc->irq.domain) {
> 
> Looking at this, perhaps positive about allocation?
> 
> 	domain_is_allocated?

I mean all domains are allocated ;)

domain_is_allocated_externally? I'm bad with short and concise
names..

-michael
