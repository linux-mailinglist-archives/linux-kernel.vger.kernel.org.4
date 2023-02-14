Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FD5696CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjBNSbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjBNSbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:31:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EBB2C647;
        Tue, 14 Feb 2023 10:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=txgtixKW7VrUQkrQdJH5MMVOgQ+O3F4VEtjOSuR+WFs=; b=cAF5cDPHDwHYrrTDHykc6PKy2K
        0Vdty9nUVhJMreDBwp0A+QelMEkTj+FQgFHmpBA3jdct4C8BHjDIvcGmb3d1pOQ+z2POFvCGNzopk
        jcStwsIAjRcGUh3x33fJGFLSg0LdDd7duWIsVsyg7zOMQawQeopx2J7GsH6y59pJ+mLur3BH2i06o
        CDXKnY/GEI6lk5pKVNEWkamnZkVLV9BUdazfeew71ouPgPEfwIVZYTZ/hlJIG3yRPtcxNf1Cc0xI7
        ooZO05yGoefN11eQUnn5NN0ywXvPZx5oT2ekRFFaxwO3hchkKxtSp678MrmkDkAkOMM8rC0WBTBpA
        NrIQPKuQ==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pS04u-003BDQ-2H; Tue, 14 Feb 2023 18:30:56 +0000
Message-ID: <8e6977b8-d256-4e51-82b7-e36d6ca259dc@infradead.org>
Date:   Tue, 14 Feb 2023 10:30:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/3] IRQ_DOMAIN: remove all "depends on", use only
 "select"
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Donggeun Kim <dg77.kim@samsung.com>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Peter Rosin <peda@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230213041535.12083-1-rdunlap@infradead.org>
 <b8fb48b9-349d-4723-9b35-6471cb65b6b5@app.fastmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <b8fb48b9-349d-4723-9b35-6471cb65b6b5@app.fastmail.com>
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



On 2/13/23 00:05, Arnd Bergmann wrote:
> On Mon, Feb 13, 2023, at 05:15, Randy Dunlap wrote:
>> IRQ_DOMAIN is a hidden (not user visible) symbol. Users cannot set
>> it directly thru "make *config", so drivers should select it instead
>> of depending on it if they need it.
>> Relying on it being set for a dependency is risky.
>>
>> Consistently using "select" or "depends on" can also help reduce
>> Kconfig circular dependency issues.
>>
>> IRQ_DOMAIN is selected 109 times and is depended on 3 times in
>> current linux-next. Eliminate the uses of "depends on" by
>> converting them to "select".
>>
>>  [PATCH 1/3] extcon: max8997: select IRQ_DOMAIN instead of depending on it
>>  [PATCH 2/3] of: OF_IRQ: select IRQ_DOMAIN instead of depending on it
>>  [PATCH 3/3] rtc: mt6397: select IRQ_DOMAIN instead of depending on it
> 
> From a Kconfig perspective, your reasoning makes a lot of sense.
> 
> Looking at the bigger picture, I wonder if we should just remove the
> option and make it unconditional. It is enabled in ever architecture
> defconfig other than alpha and sparc, and it's selected by a lot of
> very common options such as I2C,  GENERIC_MSI_IRQ, GENERIC_IRQ_CHIP,
> and PCI_HOST_GENERIC. Enabling the option on Alpha grows the kernel
> image from 9010KB to 9023KB, or on m68k Coldfire from 3346KB to
> 3351KB.

Marc, what do you think about this suggestion?

Thanks.
-- 
~Randy
