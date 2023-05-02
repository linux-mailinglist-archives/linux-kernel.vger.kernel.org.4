Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC5A6F3F67
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjEBIoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjEBIoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:44:17 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745264486;
        Tue,  2 May 2023 01:44:15 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 3BF0ED25;
        Tue,  2 May 2023 10:44:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1683017053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VaEv1wD3UWoz0LdA32gdXEvV6OHqxDk7aEeS7MPNyZI=;
        b=Se9EaTU9dO7IEOs/1En7eSlJSeFCteWDtgc3rftUul2kXQl7MaNST0LIGP3x4lmbfqlUCF
        6KzcwFlJi0/j8RuYkw2hr0XlWzJUq7HYHxXorzLHkwMBqYhtyI1igPYLlPtCDKxRNhW6ae
        +x+bb9e3JnPKtnXmjxvSdmY227VaPH3iXaJYgwHui+yvgoqy2lQpBoGjZMI5y66Q+tGodT
        rQTXC7N+owoPruL8zBOOHNm8OHYU+gRjNX8AKyOaiqPyj85zfQ0jxQQxfXd1/Y+Javp1OJ
        v0sb4LkphGA4jS4KVcsmrQ45oZ79davQz4MJ+HDFMe2qfuLZewyPrfYONGVrcQ==
From:   Michael Walle <michael@walle.cc>
To:     okan.sahin@analog.com
Cc:     brgl@bgdev.pl, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 2/2] gpio: ds4520: Add ADI DS4520 GPIO Expander Support
Date:   Tue,  2 May 2023 10:44:06 +0200
Message-Id: <20230502084406.3529645-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230501230517.4491-3-okan.sahin@analog.com>
References: <20230501230517.4491-3-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Please include any former reviewers in new versions.]

> The DS4520 is a 9-bit nonvolatile (NV) I/O expander.
> It offers users a digitally programmable alternative
> to hardware jumpers and mechanical switches that are
> being used to control digital logic node.

Ok, what I just noticed is that this is an open-drain output buffer
with an optional pull-up, that should really go into the commit
message.

Also the commit message is misleading "it offers users a digitally
programmable alternative to hardware jumpers". While the hardware is
capable of that, this driver doesn't make use of it.

> +	config.reg_dat_base = base + IO_STATUS0;
> +	config.reg_set_base = base + PULLUP0;
> +	config.reg_dir_out_base = base + IO_CONTROL0;

Given the above, I don't think this is correct. You pull the line low if
the line is in input mode (?). The line will be pulled low if the
corresponding bit in IO_CONTROL is zero. A one means, the pin is
floating. With open-drain buffers there are usually an external pull-ups,
so I'd treat the internal pull-up as optional and it is not necessary to
switch the actual line state.

In that case the following should be sufficient:
	config.reg_dat_base = base + IO_STATUS0;
	config.reg_set_base = base + IO_CONTROL0;

I'm not sure about the direction though. Technically speaking there is
no direction register. I'm not familiar with how open drain output are
modeled in linux. I'd expect the above is enough. Bartosz/Linus/Andy?

To enable the optional pull-up, you should refer to .set_config.
(You don't need to disable the pull-up if you pull the line low).

Regarding the SEE bit and wear out: The SEE bit seem to be shadowed by the
EEPROM, so if someone is setting the SEE bit it will be persisent. Changing
direction or output value will result in an EEPROM write and might wear out
the EEPROM. I'd like to hear others opinion on that. The worst case write
cycles are 50000. Fail the probe if the SEE bit is set seems not ideal.
Just ignoring that problem for now (or at least warn the user)?

-michael
