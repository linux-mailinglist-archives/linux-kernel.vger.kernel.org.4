Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F11F6D7FA3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjDEOf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbjDEOfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:35:52 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABFC5BA2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=O9qsVtudALGLwqSWlwx8JyfCo7w9dKtcJnZOpk30+nw=; b=DlpY8ALDzRkY0Vd0u7yzQs9LBV
        DC4fFC4CeukD3NGMmBYbSYKvhL5vs6+gluzjxdbJJYS8qkqMVf2e6l1kJL5FVuguQlSobqOfKsZv8
        ZjU/b6w3IHbk+oRtP6KcNUUh/BMoqx0TqGhk+4Y5H56ai4OrRRO5iZOlhTiRh4BPsNNjiiU/VrsHI
        O/Er5z6QZnS4d9njvu5hZQvhH7R7fPGcaAXPy225LYBFmJrjsqz4QDm4I9pvjchaI4opd6K1nHL0Q
        DA9ztU9XQBYB1xUfPP+OeyQv9FDIHGq6lxXk4mQKtUVXjZD3P9FI/wyBfVoXMBqdS2Kx57PMDna8M
        ZM1qSofQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pk4EU-0005ur-Gg; Wed, 05 Apr 2023 16:35:30 +0200
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pk4EU-0009WK-50; Wed, 05 Apr 2023 16:35:30 +0200
Message-ID: <f57b8e3d-4382-015e-743b-8663c55d9f84@metafoo.de>
Date:   Wed, 5 Apr 2023 07:35:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: iio: ad7192: Pending IRQ on SDO/RDY causing retrigger of
 interrupt handler and missing every sample
Content-Language: en-US
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <noname.nuno@gmail.com>,
        Fabrizio Lamarque <fl.scratchpad@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
References: <CAPJMGm4GaSjD6bdqMwCr2EVZGenWzT-nCCf3BMRaD1TSfAabpA@mail.gmail.com>
 <6d58a58cd7e8a7cbb91b2658e9a85b44b34b64dc.camel@gmail.com>
 <CAPJMGm5WxnmtyW2DnZe4rSUFJ-KtKGmNsf7pStcaK=4suBHWuw@mail.gmail.com>
 <3c5f31cf533ef26ea586e2d18b31995541a95411.camel@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <3c5f31cf533ef26ea586e2d18b31995541a95411.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26866/Wed Apr  5 09:23:41 2023)
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 06:49, Nuno Sá wrote:
> [...]
> I just tested the patch, but, at least on the platform I'm working on
> (I.MX6), it does not
> solve the issue.
> Whereas the thread describes the very same issue I am experiencing, I
> am not sure
> IRQ_DISABLE_UNLAZY would have any impact. By reading CPU registers I see
> I was expecting to have. AFAIU, the lazy approach would be the responsible for
> this behavior because when you call disable_irq() it does not really mask the
> IRQ in HW. Just marks it as disabled and if another IRQ event comes set's it to
> PENDING and only then masks at HW level... If we "unlazy" the IRQ, we should
> mask the IRQ right away so I would expect not to have any pending IRQ...
>
>> the IRQ line disabled at the hardware level, but when the IRQ flag of
>> the processor
>> is set (and this happens even if the interrupt is masked in HW), the
>> interrupt is immediately
>> triggered anyway.
>> (I see GPIOx_IMR cleared, so interrupt is masked, but GPIOx_ISR set. As soon
>> as
>> enable_irq() is called the interrupt is triggered. Just by clearing
>> GPIOx_ISR before
>> enable_irq() solves the issue. I might share a few debug printk).

This sounds to me that the GPIO driver should implement an 
`irq_enable()` callback where it clears the pending bits before 
unmasking. This is consistent with what other GPIO IRQ drivers do.

