Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8301E6B1B9D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjCIGha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCIGh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:37:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BE42B9C0;
        Wed,  8 Mar 2023 22:37:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B28F260A75;
        Thu,  9 Mar 2023 06:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41827C433D2;
        Thu,  9 Mar 2023 06:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678343845;
        bh=RBBE41VWOhEkgOfDrb/0jzbup8THu+1nIa/pbGcAMpg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=suHrLRaFNcZ0Fu9pkHROmGnCJypaZIYJHKJl5/SI4OXZz5oEJZnUQ+Wa9f3MD1ZJe
         W81ythQik74PEy6UDX6zDn7C40Dc3dIScJrOyC9kPhvnkxc4bsaNt064XQo/5GP9gb
         ib7Qj0qGpQAI/seX7jNEtUKGABUDKOZbELukES/rKnq81an6+lDOUsfqxQR4idy5lw
         yhgnBmLSdJLuDZG32SuR7Tdvs+pueqPI6KNC8Zf7Kh5MWwwuabMBZ/f9lj0EKo8UhU
         St7LDZKzd5HR4CHYWuzAESSnMzaQfkSo5RMsF1B1ciUSeTKX19eTJ+tGpm8pivSwau
         Ckf7Gx+0KaNyQ==
Message-ID: <35ecc535-7ee5-f45d-39a4-ac3044535f6a@kernel.org>
Date:   Thu, 9 Mar 2023 07:37:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v13 2/2] clk: clk-loongson2: add clock controller driver
 support
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>, kernel test robot <lkp@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
References: <20230307115022.12846-2-zhuyinbo@loongson.cn>
 <202303082037.QPfBP64A-lkp@intel.com>
 <b94ee1d2-b224-f9d5-3f3c-0096634f4c93@loongson.cn>
 <a16ac33d-e313-2eeb-007d-20f61d670308@loongson.cn>
 <6180156d-109c-2f41-69ee-0a854dc3772e@kernel.org>
 <e51a23e5-ad69-d415-860f-3a9ab38bfbe9@loongson.cn>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <e51a23e5-ad69-d415-860f-3a9ab38bfbe9@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 07:27, zhuyinbo wrote:
> 
> 在 2023/3/9 下午2:09, Krzysztof Kozlowski 写道:
>> On 09/03/2023 04:18, zhuyinbo wrote:
>>> 在 2023/3/9 上午10:58, zhuyinbo 写道:
>>>> 在 2023/3/8 下午8:16, kernel test robot 写道:
>>>>> Hi Yinbo,
>>>>>
>>>>> I love your patch! Yet something to improve:
>>>>>
>>>>> [auto build test ERROR on clk/clk-next]
>>>>> [also build test ERROR on robh/for-next linus/master v6.3-rc1
>>>>> next-20230308]
>>>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>>>> And when submitting patch, we suggest to use '--base' as documented in
>>>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>>>
>>>>> url:
>>>>> https://github.com/intel-lab-lkp/linux/commits/Yinbo-Zhu/clk-clk-loongson2-add-clock-controller-driver-support/20230307-195252
>>>>> base: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
>>>>> clk-next
>>>>> patch link:
>>>>> https://lore.kernel.org/r/20230307115022.12846-2-zhuyinbo%40loongson.cn
>>>>> patch subject: [PATCH v13 2/2] clk: clk-loongson2: add clock
>>>>> controller driver support
>>>>> config: mips-allyesconfig
>>>>> (https://download.01.org/0day-ci/archive/20230308/202303082037.QPfBP64A-lkp@intel.com/config)
>>>>> compiler: mips-linux-gcc (GCC) 12.1.0
>>>>> reproduce (this is a W=1 build):
>>>>>           wget
>>>>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>>>>> -O ~/bin/make.cross
>>>>>           chmod +x ~/bin/make.cross
>>>>>           #
>>>>> https://github.com/intel-lab-lkp/linux/commit/391d6fc63ac65f5456e4755c9dd85232a6296285
>>>>>           git remote add linux-review
>>>>> https://github.com/intel-lab-lkp/linux
>>>>>           git fetch --no-tags linux-review
>>>>> Yinbo-Zhu/clk-clk-loongson2-add-clock-controller-driver-support/20230307-195252
>>>>>           git checkout 391d6fc63ac65f5456e4755c9dd85232a6296285
>>>>>           # save the config file
>>>>>           mkdir build_dir && cp config build_dir/.config
>>>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
>>>>> make.cross W=1 O=build_dir ARCH=mips olddefconfig
>>>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
>>>>> make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/
>>>>>
>>>>> If you fix the issue, kindly add following tag where applicable
>>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>>> | Link:
>>>>> https://lore.kernel.org/oe-kbuild-all/202303082037.QPfBP64A-lkp@intel.com/
>>>>>
>>>>> All errors (new ones prefixed by >>):
>>>>>
>>>>>      drivers/clk/clk-loongson2.c: In function 'loongson2_calc_pll_rate':
>>>>>>> drivers/clk/clk-loongson2.c:79:15: error: implicit declaration of
>>>>>>> function 'readq'; did you mean 'readl'?
>>>>>>> [-Werror=implicit-function-declaration]
>>>>>         79 |         val = readq(loongson2_pll_base + offset);
>>>>>            |               ^~~~~
>>>>>            |               readl
>>>>>      cc1: some warnings being treated as errors
>>>> The CONFIG_64BIT not enabled in your config file, I will add a depend
>>>> on "CONFIG_64BIT" in my clock driver to fix this compile error.
>>> My clock is for LoongArch platform, The LOONGARCH had select
>>> "CONFIG_64BIT", I will add a depend on "LOONGARCH" in my clock driver to
>>> fix this compile error.
>> No. Fix your code instead.
> 
> but the readq that ask CONFIG_64BIT is enabled,  definition in 
> include/asm-generic/io.h
> 
> so need enable CONFIG_64BIT for my clk driver.

Ah, you are right, the error was not about the cast but missing readq.
Yeah, you should depend on 64BIT. Not on Loongarch because the code
should compile test on other archs.

Best regards,
Krzysztof

