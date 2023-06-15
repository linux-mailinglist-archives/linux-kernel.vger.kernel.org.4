Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403577313AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbjFOJ0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjFOJ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:26:22 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F024199D;
        Thu, 15 Jun 2023 02:26:20 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 0A0529F4;
        Thu, 15 Jun 2023 11:26:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1686821178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lFRE5LEM2FA/2a9hAASkoMN/GS/KTyiR0u3T0AoV1ZU=;
        b=tWKV2EgVXHhD1VksOblafmCiw/KlJDL6TfuepwQIIX74nPKlJQvevTPRp2N8l7DZldc6ve
        lQy9o/8jPlhAzUebuST6PFf+gj2ISMTI2+L4TNU/hQ3qUfZpk4p9hQ2tcENbznNtCTjZoQ
        m5GfuMCl8jKh4DxyKeYoByNDTW4vz1+y9AAmew5I/iPUGkPJoVM4UgundY9HioSR9IVm6I
        Yy6WjM4pkQdYzMNOWXNX2RGjsaNGXl37vFGyiKWq42idWBEBXR5tQL+uc2AEutV7oMx9Ij
        nN7Gv4Wbgd7JNTzGLR6aUSxAEUo6FNjzVuLkNlE5megztEXKKrD/oY5W+nQLDg==
MIME-Version: 1.0
Date:   Thu, 15 Jun 2023 11:26:17 +0200
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jiawen Wu <jiawenwu@trustnetic.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, shreeya.patel@collabora.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: Fix GPIO chip IRQ initialization restriction
In-Reply-To: <CAHp75Vdbq3uHOyrfT-KFYRSj6v+s9GgOQjQ9a8mGn-4HSCpB9Q@mail.gmail.com>
References: <20230607081803.778223-1-jiawenwu@trustnetic.com>
 <CAHp75Vdbq3uHOyrfT-KFYRSj6v+s9GgOQjQ9a8mGn-4HSCpB9Q@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <15e2fc098a1e63317368f4812290ca35@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-06-07 16:12, schrieb Andy Shevchenko:
> +Cc: Michael
> 
> On Wed, Jun 7, 2023 at 11:20 AM Jiawen Wu <jiawenwu@trustnetic.com> 
> wrote:
>> 
>> In case of gpio-regmap, IRQ chip is added by regmap-irq and associated 
>> with
>> GPIO chip by gpiochip_irqchip_add_domain(). The initialization flag 
>> was not
>> added in gpiochip_irqchip_add_domain(), causing gpiochip_to_irq() to 
>> return
>> -EPROBE_DEFER.
> 
> Makes sense to me.
> FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> But it would be nice to hear from Michael about this.

Thanks for bringing this to my attention. In fact, currently
my sl28cpld is broken due to this. So:

Reviewed-by: Michael Walle <michael@walle.cc>
Tested-by: Michael Walle <michael@walle.cc> # on kontron-sl28

>> Fixes: 5467801f1fcb ("gpio: Restrict usage of GPIO chip irq members 
>> before initialization")
>> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

-michael
