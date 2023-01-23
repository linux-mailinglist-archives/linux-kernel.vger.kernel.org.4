Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC6567796B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjAWKoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjAWKog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:44:36 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3592512F17;
        Mon, 23 Jan 2023 02:44:33 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 9E6F641;
        Mon, 23 Jan 2023 11:44:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1674470670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DFxG+3+AuEwK9dzCd11bJRVbzf/YkEZyr1PAY32IkjE=;
        b=VdV5rc8IrJMFjBa6mto/mGtQoXEGtCUqj8STBbOoayWmrEWIXIX88kYqpel7XFP2/KZel/
        36ppyAyqN1vpFgVr6YlGgYvLtfh2CpDJrOEkQFva0MEUflK4LsbL014Btz1/LN4I22+jvl
        l3Bkzz2K0VLMFH+8mBXQsLAW9uYsyOePaVgjB+zHj4Xcle7Dlf9gNTqpHgKeAU9GBHBAhL
        nKQFX61FWp9SiyEpdF7Ol8W8WqyZOdg9/R+rcpxDeVVqPp2E53pYMvrq74N9ulW1nkVcmi
        KDdXDCulaWhYCGpaesZFCzQkWH0BBiBPO0NREK33biEnVUjNCwZ6R3PrCIEUwg==
MIME-Version: 1.0
Date:   Mon, 23 Jan 2023 11:44:30 +0100
From:   Michael Walle <michael@walle.cc>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Subject: Re: [PATCH 2/2] spi: spidev: add new mediatek support
In-Reply-To: <CAFGrd9qXL-u4XzG9MLK2zbKoDudhTYpr-gJaZPjbysJ9Fo2gnQ@mail.gmail.com>
References: <20230118-mt8365-spi-support-v1-2-842a21e50494@baylibre.com>
 <20230120082054.610626-1-michael@walle.cc>
 <CAFGrd9qXL-u4XzG9MLK2zbKoDudhTYpr-gJaZPjbysJ9Fo2gnQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <2aa2ff64cfd3b5ccd1342873fffa6cb4@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2023-01-23 10:37, schrieb Alexandre Mergnat:
> Le ven. 20 janv. 2023 à 09:20, Michael Walle <michael@walle.cc> a écrit 
> :
>> 
>> From: Alexandre Mergnat <amergnat@baylibre.com>
>> 
>> > Add the "mediatek,genio" compatible string to support Mediatek
>> > SPI controller on the genio boards.
>> 
>> What is the use case of having the spidev? What if I want to
>> connect a device with a linux driver to it? It seems like you
>> just want to expose the SPI bus on the pin header. There was a
>> similar discussion for a mikrobus connector [1].
>> 
> Yes I want to expose the SPI on the pin header for two reasons:

Then "mediatek,genio" doesn't really describe the hardware, does it?
If you read that linked thread, NXP was also trying exposing the SPI
bus on a pin header. IMHO this is just misusing the userspace spi-dev.

That being said, exposing something on a pinheader (or on a standardized
connector) seems like a common thing and we should be working towards
a good solution. I still think Robs proposal for the mikrobus connector
makes also sense for your case.

-michael
