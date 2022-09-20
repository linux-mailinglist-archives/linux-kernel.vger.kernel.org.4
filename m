Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066435BE8D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiITOZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiITOZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:25:18 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C39226;
        Tue, 20 Sep 2022 07:25:10 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 874C11251;
        Tue, 20 Sep 2022 16:25:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1663683906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gwSU9hw6TvimqBoWZiboEIRnW6xJeUix7UR4c0rVKcQ=;
        b=BmXPhfhgoZGgy9qAIMm8clSotCFCpQOxKoXDeZxtsvC1SFZmUUgHZFf4ohld/OPBO07w5m
        rzJXrnMWLYGK4IN0LQl92J43cjZTRBHSqMGkDgzIYyEh8ViyjEnuB0fkBL24MPYt8QXqs7
        q4R2XQCd9YnRzCc6Rrt1EiQtcMfpquitQOsM9U05fv3X+0ZCsOgqeVZH1N3n6Z7okp8iQ/
        5FJ5L7ffz5oZeJiwi8xkibyhvEraA3h+l/rHuW6rLBm1Hx0lhY/gpnIH0YQOAsULi2WKOE
        7T37+9pLPyYv//28rzovXYrOwp9y66ObTxan+CYncIJhXgf54orMa695Tt2r9w==
MIME-Version: 1.0
Date:   Tue, 20 Sep 2022 16:25:06 +0200
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
        andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pinctrl: ocelot: Fix interrupt controller
In-Reply-To: <faa173ddc1d55d2e3931246453e5e953@walle.cc>
References: <20220909145942.844102-1-horatiu.vultur@microchip.com>
 <20220920120642.690340-1-michael@walle.cc>
 <CACRpkdb70zawWDSxUM=hJYkOEbG5a5guZWBytqUmRG2FZLiXsQ@mail.gmail.com>
 <faa173ddc1d55d2e3931246453e5e953@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <8ec019b32b7221237ccf84fabf07e63d@walle.cc>
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

Am 2022-09-20 14:34, schrieb Michael Walle:
> Am 2022-09-20 14:28, schrieb Linus Walleij:

>> Just checking: since these drivers obviously must pass pass
>> IRQF_SHARED, have you also made sure that each driver also
>> will properly return IRQ_HANDLED if the interrupt was for them
>> (triggered by "their" hardware) but IRQ_NONE if the interrupt was
>> not for them (triggered by something else)?
> 
> Thanks, I'll check it.

The gpy driver seems to handle that correctly. The micrel one introduced
a regression some time ago. I've send a fix in the meantime [1], but it
doesn't help for the multiple interrupts here.

-michael

[1] 
https://lore.kernel.org/netdev/20220920141619.808117-1-michael@walle.cc/
