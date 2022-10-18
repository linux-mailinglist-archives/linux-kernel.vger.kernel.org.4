Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52976025B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJRHbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJRHbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:31:00 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798F03C8CE;
        Tue, 18 Oct 2022 00:30:58 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 722261D23;
        Tue, 18 Oct 2022 09:30:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1666078255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WzMYkZQlDVdQITrjYiTqieDryDU5cl4+R2pxvS45MzU=;
        b=F7I4Sfccmz6nIRGL9Kq3UnF88c8QEloNI2fTBYVEv+6xzZPBw7/NAnkNk7mD7b3AJRXiym
        cnr5RYGD6F6pH+BbgONYeNraclMyg6kOOQvW9d6zr4vHTmXAM9ZLPFUOvjnvxBdx//kxky
        sYu+gCiqQtDqRhfVu2PEkw8HiaYn1Jckmp8uSpS6QQWZXnFSCuVj2mv5rDa/XZsLtvsEmX
        KfpwEYMmdwEv7Di4fDSeOSjGugFJ+zLDwsMdowAw2nV/3v7bU/ramcxqgw2di0aFTL0UNm
        DiV9sZfoU+YTQbcn3sO6+w2dtpVP15m9p9cF0H5elZBGiL9HNzEMhygXc4zkVQ==
MIME-Version: 1.0
Date:   Tue, 18 Oct 2022 09:30:55 +0200
From:   Michael Walle <michael@walle.cc>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, andy.shevchenko@gmail.com,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH] pinctrl: ocelot: Fix incorrect trigger of the interrupt.
In-Reply-To: <20221018070959.1322606-1-horatiu.vultur@microchip.com>
References: <20221018070959.1322606-1-horatiu.vultur@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <2c88f0a4955202091bbdf6c5db4f18cf@walle.cc>
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

Am 2022-10-18 09:09, schrieb Horatiu Vultur:
> The interrupt controller can detect only link changes. So in case an
> external device generated a level based interrupt, then the interrupt
> controller detected correctly the first edge. But the problem was that
> the interrupt controller was detecting also the edge when the interrupt
> was cleared. So it would generate another interrupt.
> The fix for this is to clear the second interrupt but still check the
> interrupt line status.
> 
> Fixes: c297561bc98a ("pinctrl: ocelot: Fix interrupt controller")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Tested-by: Michael Walle <michael@walle.cc>

-michael
