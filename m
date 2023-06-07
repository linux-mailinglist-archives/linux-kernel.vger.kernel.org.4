Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4694D725542
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbjFGHR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbjFGHRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:17:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA3A198B;
        Wed,  7 Jun 2023 00:17:22 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1DE336606EB0;
        Wed,  7 Jun 2023 08:17:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686122241;
        bh=D80LMK+36KFKk3hvSjD4i/C4Qajq5CzPucr2mCsl7Ms=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q8NXF4L43kBDu2vl4rwJfHwYJfa8ZKCyBCO6AGcZzx8dXBeiaQ6Ohl0hrJGBxYzDQ
         CFRrqR0faSqpFZlhA+sGmVq0htN7ZZf/UFkheeGxYcAiMzQACuOZyZ1qm2N6VIBoed
         +q6JoMdIWmmbS3yWaZ0KIF+Ubm9JHe6xRqBc7sNsq7Gllii8pAgfF8/iwsvxqFHVhQ
         8u6Kgq3oIqGuPJ9pq5rPeXZ90uUYUZ+aDr1QNsXu4m3v/Asfr1hBRpP9OlyjnLQpoq
         Af8aBDhWiY153oNSvAOCiTm0gbo4JePrOr/+r6MVMJdSd1ic6efukvF/drWc1w4DLv
         Te0Lyh1vfBjMA==
Message-ID: <6138a97f-1b8b-f33f-8be5-e2141314dbd7@collabora.com>
Date:   Wed, 7 Jun 2023 09:17:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Tony Lindgren <tony@atomide.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, linux-mediatek@lists.infradead.org
References: <20230602083335.GA181647@google.com>
 <87a5xii33r.fsf@jogness.linutronix.de> <20230603054139.GR14287@atomide.com>
 <20230603063533.GS14287@atomide.com> <20230605061511.GW14287@atomide.com>
 <CAGXv+5Fbx7eTxP0ep6DV+jyronAWxYvu2M-g=MjHGRhjSXUc=w@mail.gmail.com>
 <20230605122447.GY14287@atomide.com>
 <CAGXv+5HwL+R5QpO3pHGQd9qAxu2pCMDjYvdni1HjiC8eEE38mg@mail.gmail.com>
 <20230605131803.GA14287@atomide.com>
 <CAGXv+5GR9TEaNrj4B21H2iukS2kWW=rtoWkoVnWewVsrbcG0Hw@mail.gmail.com>
 <20230606122059.GC14287@atomide.com>
 <CAGXv+5ERwrFgpWBUBTkoawfyyTHU9w=Owiy-2BbCXHwEpZk1tA@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5ERwrFgpWBUBTkoawfyyTHU9w=Owiy-2BbCXHwEpZk1tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/06/23 06:46, Chen-Yu Tsai ha scritto:
> On Tue, Jun 6, 2023 at 8:21 PM Tony Lindgren <tony@atomide.com> wrote:
>>
>> * Chen-Yu Tsai <wenst@chromium.org> [230606 09:17]:
>>> I ended up following 8250_dw's design, which seemed less convoluted.
>>> The original code was waaay too convoluted.
>>
>> OK that looks good to me thanks. Good to hear you got it sorted out.
>>
>> The 8250_dw style runtime PM is a good solution for simple cases. Where
>> it won't work are SoCs where runtime PM calls need to propagate up the
>> bus hierarchy. For example, 8250_omap needs runtime PM calls for the
>> interconnect and power domain to get register access working.
> 
> Good to know. On MediaTek platforms I don't think there are any power
> domains covering the basic peripherals. (Or it's hidden from the kernel.)
> 

On (relatively) new SoCs, basic peripherals are always powered, you're correct.

Cheers,
Angelo

>>> BTW, the Bluetooth breakage seems like a different problem.
>>
>> OK seems like we're good to go then :)
> 
> Yup. After a bit more testing, it seems the Bluetooth problem is more like
> an undervolt issue. If I have WiFi and BT probe at the same time, Bluetooth
> fails. If they probe separately, everything works fine.
> 
> ChenYu


