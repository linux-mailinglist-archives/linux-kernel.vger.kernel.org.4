Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7666B1B20
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCIGJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCIGJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:09:53 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29A28B32A;
        Wed,  8 Mar 2023 22:09:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C5060CE21A4;
        Thu,  9 Mar 2023 06:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4996BC433D2;
        Thu,  9 Mar 2023 06:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678342184;
        bh=5xaZPSrXO3U+lnq1ejULQspngVs5//pV+SuM6vGjaFE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LrcBPL3Mk6HmCfgRzPaHNq2HQ6p3Bz5ey0FyJo+jpb9KviuL08qJcagTF4AtdQ5Wo
         y+cCqUOrozOYIA/jPNLNsYDmDltlUFFHkH0qEasfY/A4kBN+83ry3hRnnbpd5sRGZr
         88jguB2E8ndyl9UqtDuyRSD4WaAOOkgzRqU/1YIWNrzvwCxSKK1CWu30awQhjTjzqP
         T3JEqwL4znnPzb41rBdFFm3p27lE9uu9mkFLUY1ZtbjoBlouq2uZye7s8z/e5zA6eT
         L5I0ZJGarkn2RrPe1CFwH5QOlfl1lXDVRr3H5S/IYvQ2BYmCtshKx5+vM9DSo1Tm+5
         9f/72Vd1Ag+Ng==
Message-ID: <6180156d-109c-2f41-69ee-0a854dc3772e@kernel.org>
Date:   Thu, 9 Mar 2023 07:09:38 +0100
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <a16ac33d-e313-2eeb-007d-20f61d670308@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 04:18, zhuyinbo wrote:
> 
> 在 2023/3/9 上午10:58, zhuyinbo 写道:
>>
>> 在 2023/3/8 下午8:16, kernel test robot 写道:
>>> Hi Yinbo,
>>>
>>> I love your patch! Yet something to improve:
>>>
>>> [auto build test ERROR on clk/clk-next]
>>> [also build test ERROR on robh/for-next linus/master v6.3-rc1 
>>> next-20230308]
>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>> And when submitting patch, we suggest to use '--base' as documented in
>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>
>>> url: 
>>> https://github.com/intel-lab-lkp/linux/commits/Yinbo-Zhu/clk-clk-loongson2-add-clock-controller-driver-support/20230307-195252
>>> base: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git 
>>> clk-next
>>> patch link: 
>>> https://lore.kernel.org/r/20230307115022.12846-2-zhuyinbo%40loongson.cn
>>> patch subject: [PATCH v13 2/2] clk: clk-loongson2: add clock 
>>> controller driver support
>>> config: mips-allyesconfig 
>>> (https://download.01.org/0day-ci/archive/20230308/202303082037.QPfBP64A-lkp@intel.com/config)
>>> compiler: mips-linux-gcc (GCC) 12.1.0
>>> reproduce (this is a W=1 build):
>>>          wget 
>>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>>> -O ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          # 
>>> https://github.com/intel-lab-lkp/linux/commit/391d6fc63ac65f5456e4755c9dd85232a6296285
>>>          git remote add linux-review 
>>> https://github.com/intel-lab-lkp/linux
>>>          git fetch --no-tags linux-review 
>>> Yinbo-Zhu/clk-clk-loongson2-add-clock-controller-driver-support/20230307-195252
>>>          git checkout 391d6fc63ac65f5456e4755c9dd85232a6296285
>>>          # save the config file
>>>          mkdir build_dir && cp config build_dir/.config
>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 
>>> make.cross W=1 O=build_dir ARCH=mips olddefconfig
>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 
>>> make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/
>>>
>>> If you fix the issue, kindly add following tag where applicable
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Link: 
>>> https://lore.kernel.org/oe-kbuild-all/202303082037.QPfBP64A-lkp@intel.com/
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>     drivers/clk/clk-loongson2.c: In function 'loongson2_calc_pll_rate':
>>>>> drivers/clk/clk-loongson2.c:79:15: error: implicit declaration of 
>>>>> function 'readq'; did you mean 'readl'? 
>>>>> [-Werror=implicit-function-declaration]
>>>        79 |         val = readq(loongson2_pll_base + offset);
>>>           |               ^~~~~
>>>           |               readl
>>>     cc1: some warnings being treated as errors
>>
>> The CONFIG_64BIT not enabled in your config file, I will add a depend 
>> on "CONFIG_64BIT" in my clock driver to fix this compile error.
> My clock is for LoongArch platform, The LOONGARCH had select 
> "CONFIG_64BIT", I will add a depend on "LOONGARCH" in my clock driver to 
> fix this compile error.

No. Fix your code instead.

Best regards,
Krzysztof

