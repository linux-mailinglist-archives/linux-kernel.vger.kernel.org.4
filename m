Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FE368649F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjBAKqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjBAKqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:46:08 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBEC40E1;
        Wed,  1 Feb 2023 02:46:03 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 2D365126A;
        Wed,  1 Feb 2023 11:46:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1675248362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/Nn9vIhP684Dyg+/S9/KC+Ry8ajbwCM27GQszn7uBE=;
        b=FnLre03ttlykqOT5twpuMP6FFFU/GYDMLPiJbQ5x24R+62f9zZOmq2Hyk6bmnNBuzHTQfT
        IZEEqRBz7xQlkCmBWiZEVNeTNOkuDofAWU8loul7jmBGWNDayoA9/BLmZAz5YL7r93SQoT
        yRrLi2QTW0mlVV7Hjo8V5bojgKCJTzdq5rT6GFR3yXtCk6ludx6P5waPGvrPROTxmBHoGD
        ZLK4g8TkisopCQZVl3P5jW97q+ZbA6Xh18Us3SqNelTexKVihoIW7/y/DLKpKl+zeOvxqN
        7agL0pEnv+68qKRhnu34IBbhTqMid7TPcUAJzwT7mN6fNx6sf0N0PX4imDdcRA==
MIME-Version: 1.0
Date:   Wed, 01 Feb 2023 11:46:01 +0100
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     devicetree@vger.kernel.org, hayashi.kunihiko@socionext.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        mhiramat@kernel.org, rafal@milecki.pl, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH 3/4] nvmem: mtk-efuse: replace driver with a generic MMIO
 one
In-Reply-To: <8452b341-8695-05d8-9d03-47c9aeca0ec7@gmail.com>
References: <20230201064717.18410-4-zajec5@gmail.com>
 <20230201084821.1719839-1-michael@walle.cc>
 <8452b341-8695-05d8-9d03-47c9aeca0ec7@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <017a17eb99ac2b2c858d27b65c5dd372@walle.cc>
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

> Before I convert brcm,nvram to NVMEM layout I need some binding & 
> driver
> providing MMIO device access. How to handle that?

I'm not arguing against having the mmio nvmem driver. But I don't
think we should sacrifice possible write access with other drivers. And
I presume write access won't be possible with your generic driver as it
probably isn't just a memcpy_toio().

It is a great fallback for some nvmem peripherals which just maps a
memory region, but doesn't replace a proper driver for an nvmem device.

What bothers me the most isn't the driver change. The driver can be
resurrected once someone will do proper write access, but the generic
"mediatek,efuse" compatible together with the comment above the older
compatible string. These imply that you should use "mediatek,efuse",
but we don't know if all mediatek efuse peripherals will be the
same - esp. for writing which is usually more complex than the reading.

nitpick btw: why not "nvmem-mmio"?

So it's either:
  (1) compatible = "mediatek,mt8173-efuse"
  (2) compatible = "mediatek,mt8173-efuse", "mmio-nvmem"

(1) will be supported any anyway for older dts and you need to add
the specific compatibles to the nvmem-mmio driver - or keep the
driver as is.

With (2) you wouldn't need to do that and the kernel can load the
proper driver if available or fall back to the nvmem-mmio one. I'd
even make that one "default y" so it will be available on future
kernels and boards can already make use of the nvmem device even
if there is no proper driver for them.

I'd prefer (2). Dunno what the dt maintainers agree.

-michael
