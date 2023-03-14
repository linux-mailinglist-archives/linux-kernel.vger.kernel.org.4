Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBEA6B8B84
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCNGtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCNGts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:49:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578A650F9D;
        Mon, 13 Mar 2023 23:49:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFE1E61570;
        Tue, 14 Mar 2023 06:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7B5C433D2;
        Tue, 14 Mar 2023 06:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678776586;
        bh=vCpyz//zBAiE3DDnV70snQunPQySkUISt26QGR58L2M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dJ2wjyyy+fGA/jE3q8gu9NJHiF5dAQ8LMCFKH33kpSxe5bNyMgoYDOOjjUQeIMCu+
         clyABbuIb70AHUF9IMC1ljHMsysbzoUsGvPz7t5bhxRqpOpYnvcMFu0tiTPCsipwAu
         EMIZ9pSdS+Q+t0Gnk1P6i4WaR+47PbzPiIdlL78qXbXnaY6eMik1L0JHGrrvnKllT1
         duz7m8/9vWRg6KnND0LIiTfkcEpzdUhhRLeDLNYcirGTB7wBlv1oa4+6om0tg6EMNK
         rbm9loBWx3NwaCbJY7YY7SlpvDhp/JCgHF68lIkI8HwI5WjRM7BKdhuSGgxx1kfGLq
         79/CKe1G4vSiQ==
Message-ID: <6ff60914-0c39-9916-2e3a-a906b4cdef0d@kernel.org>
Date:   Tue, 14 Mar 2023 07:49:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v13 2/2] clk: clk-loongson2: add clock controller driver
 support
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinbo <zhuyinbo@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
References: <20230307115022.12846-2-zhuyinbo@loongson.cn>
 <202303082037.QPfBP64A-lkp@intel.com>
 <b94ee1d2-b224-f9d5-3f3c-0096634f4c93@loongson.cn>
 <ec1fb4d134181a1b1859bcb884dcd494.sboyd@kernel.org>
 <c03e47f7-bb26-0114-b300-357634b0e581@kernel.org>
 <61eee19400e9a45ce9543bfd92a27eaa.sboyd@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <61eee19400e9a45ce9543bfd92a27eaa.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 19:20, Stephen Boyd wrote:
>>>> The CONFIG_64BIT not enabled in your config file, I will add a depend on 
>>>> "CONFIG_64BIT" in my clock driver to fix this compile error.
>>>
>>> Do you need to use readq() here? Can you read two 32-bit registers with
>>> readl() and put them together for a 64-bit number?
>>
>> If the platform supports 64-bit reads and these are actually one
>> register, then readq makes sense - code is more readable, smaller, more
>> efficient.
>>
> 
> Please read the section in Documentation/driver-api/device-io.rst about
> hi_lo_readq() and <linux/io-64-nonatomic-lo-hi.h>. We shouldn't need to
> restrict the driver to CONFIG_64BIT. Instead, include one of these
> header files to get the IO access primitives.

These primitives are for 32bit access. Quoting: "on 32-bit
architectures". What's the point of them if the code *will never* run on
32-bit? It will be a fake choice of linux/io-64-nonatomic-lo-hi.h or
linux/io-64-nonatomic-hi-lo.h misleading users to think this was tested
on 32-bit.

Best regards,
Krzysztof

