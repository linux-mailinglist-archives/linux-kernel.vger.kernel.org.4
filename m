Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7CE646000
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiLGRTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiLGRTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:19:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F2E25C3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=/6JZSRS9WqUUzoOCsR3hETjpo4+jNfZhfqWS+l+0x1E=; b=VX5NqIPey/HiCekSafTXvem2PE
        pVPncXaA/tu32oIquf9G4n/7xqNpn/jH9s7pJdE7Hzdj7bABksGkKuUoKBit2UFQ+uND8MyoZK1cW
        55qaSLTTVtMhSC1NqmYRFlbbRB5Kx9eRJmp9RsgrIB7fxQineogK1o1Iu3QNEZ5rDTIQmBu4HbMUk
        1TDn6UVTkr29eWqQOVimGqn6tiCn/ymb0AmHOObk7LLvLT9T+3hGrfWAbeN03u1901vU4MXOV5m9O
        By5y0cVsrpnUh1fk8kkFXhiGL82pLan9GO9i4q65hQ+XPOPtWlHeTXo7wo6EVLkj+dFYkvGdLiLyD
        M9fSgE2Q==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2y4j-007GRx-Up; Wed, 07 Dec 2022 17:19:18 +0000
Message-ID: <41a5931e-3543-6a3d-ca85-2dd8ad581f2e@infradead.org>
Date:   Wed, 7 Dec 2022 09:19:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] mux: remove the Kconfig question for the subsystem
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Peter Rosin <peda@axentia.se>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+55aFyJkpSa6rwZ-5xTihfGiNC_T0oL6txrodYBEo2-0O=p7g@mail.gmail.com>
 <1499156564-29458-1-git-send-email-peda@axentia.se>
 <053d7bf2-9bf3-a71c-5713-7cce19413c37@infradead.org>
 <a546f2db-371e-4d2f-a0ee-c71fcae8c548@app.fastmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <a546f2db-371e-4d2f-a0ee-c71fcae8c548@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/22 00:41, Arnd Bergmann wrote:
> On Tue, Dec 6, 2022, at 23:20, Randy Dunlap wrote:
>> On 7/4/17 01:22, Peter Rosin wrote:
>>> The MULTIPLEXER question in the Kconfig might be confusing and is
>>> of dubious value. Remove it. This makes consumers responsible for
>>> selecting MULTIPLEXER, which they already do.
>>>
>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>
>>
>> How does a user enable any of the 4 drivers in drivers/mux/Kconfig unless
>> some other totally unrelated driver has just happened to select MULTIPLEXER
>> so that the mux driver menu is visible to them?
> 
> We have this mechanism for a few subsystems, LEDS_CLASS/NEW_LEDS and
> CRYPTO being more common examples.
> 
> The idea clearly is that there is no need for the subsystem if no
> drivers call into it. This works if every single driver calling
> \(devm_\|\)mux_control_get also results in 'select MULTIPLEXER'
> in Kconfig, and none of them ever uses 'depends on MULTIPLEXER'.
> I think this is used correctly most of the time in mainline:
> git grep '\<\(mux/consumer.h\|MULTIPLEXER\)\>' indicates that
> PHY_J721E_WIZ and MTD_PHYSMAP_BT1_ROM may not actually need it,
> but that is fairly harmless.

Yes, sure.

> For the other subsystems I mentioned, there are occasionally 
> problems with missing 'select' that tend to be a pain to find,
> compared to subsystems consistently using 'depends on', which
> show up as link failures in randconfig builds.

I find that various drivers mixing the use of "select" and
"depends on" is problematic.

However, there was no answer for the original question:
How does a user enable the 4 Kconfig symbols in drivers/mux/Kconfig
if some other random driver has not selected MULTIPLEXER?

I.e.:

config MUX_ADG792A
	tristate "Analog Devices ADG792A/ADG792G Multiplexers"

config MUX_ADGS1408
	tristate "Analog Devices ADGS1408/ADGS1409 Multiplexers"

config MUX_GPIO
	tristate "GPIO-controlled Multiplexer"

config MUX_MMIO
	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"

OK, MUX_MMIO is selected from some other drivers, but if that is not done,
how can the first 3 be enabled by a user?

thanks.

-- 
~Randy
