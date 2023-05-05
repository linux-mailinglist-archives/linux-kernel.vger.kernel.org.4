Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A9A6F8213
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjEELb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjEELb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:31:26 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC707AB7;
        Fri,  5 May 2023 04:31:25 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 875DC1262;
        Fri,  5 May 2023 13:31:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1683286282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZBGaMOrsnlsgfMUN4JrTCITbu+aH8CMShQUm3tME11A=;
        b=xQA7IvTXhk/s75gZLqCTsh781KYqUBaX6/0/qVy4eMtGtxEuvhm2Twv7maRel3nRMT1MAm
        JA1oXt8wZoC0F7fLsfl4kpQnjetd7n6dvMl9dVpPdOzRCntw5K7S9AD16tjsx+iHyeSa8C
        +5L4VicNP9imIb0d7jmzpBqSGfyPvlMLPk333vo/WJF9op+l2cHzXye08J7/oLhE8T8GJk
        HX7MC6wNQYw8OJ7He1cj2mtyPjr7PRUUqigvPP/8KWHtVjI+ah6wU5qa7/k23frQt0Y31I
        l5BMvFBM3BPkHBLlg4nOJZPqAEsLMWiq6tbwt8n6IEtDFnj5mXCFI+ZHvBzdoA==
MIME-Version: 1.0
Date:   Fri, 05 May 2023 13:31:21 +0200
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Esteban Blanc <eblanc@baylibre.com>, lgirdwood@gmail.com,
        broonie@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com, aseketeli@baylibre.com,
        sterzik@ti.com, u-kumar1@ti.com
Subject: Re: [PATCH v3 2/3] pinctrl: tps6594: add for TPS6594 PMIC
In-Reply-To: <CACRpkdZ8oudy3XfKggZm5srJfOxmRXoFUoiuA3P4i0RTCdc5fQ@mail.gmail.com>
References: <20230414101217.1342891-1-eblanc@baylibre.com>
 <20230414101217.1342891-3-eblanc@baylibre.com>
 <CACRpkdab_26D9BMGeSygy_oa6SFa62ytXcy+Ydi3yPzQO3tU4A@mail.gmail.com>
 <CSCM20VPW7QB.RQD36XO6634I@burritosblues>
 <CACRpkdZ8oudy3XfKggZm5srJfOxmRXoFUoiuA3P4i0RTCdc5fQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <66a8224ffbeede1e8296a2aef60fc73d@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> I noticed that I could override reg_mask_xlate, so I should be able to
>> "just" match on the base address given as argument to perform a
>> different computation depending on whether we are using reg_mask_xlate 
>> in
>> a "direction change" or not, but somehow this feels a bit wrong.
>> 
>> Is this the correct solution?
>> Am I missing something?

No you don't miss anything. This is the actual use case for the base
parameter. If you need your own .xlate you can match on the base address
to do the translation based on wether it is used for .direction, .set
or .get.

I.e.

switch (base) {
case REG_IO_CTRL:
    do_something_with_reg_and_mask;
case REG_DAT:
    do_something_different_with_reg_and_mask;
default:
    error;
}

-michael
