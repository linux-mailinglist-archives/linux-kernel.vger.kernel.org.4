Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DCD702519
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjEOGoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbjEOGoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:44:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1FE10F5;
        Sun, 14 May 2023 23:43:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2F7F61FB4;
        Mon, 15 May 2023 06:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD32FC433D2;
        Mon, 15 May 2023 06:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684133035;
        bh=l+AvEyvWw3UkQ8+3IHfInyCURmPhZE64HezEkuOzWU8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Mx+mclncw7Li/xSAud55NZWD05YQ/mg2gZOFh3XVjb4SZGiWrvS5SdNsYRgZGbswI
         ZZSd5Se6QBdLyvpmV+UuZsDM+3kaerrVQjtbDu2V1M9BLI3V24WvSZ3s6guZ9FEPgD
         5tLpaUENhmdiDgVzoeDdwp73m0tl7VDOHvu8eTOpWosf7JnawG075R3tYaxKZk/2PC
         lX/dzKxB/PW+ZJZqAHoS4bdMKU4hs7Fyd+m/CFWw9sj65xiwvfle6SuHwmqAe6m48J
         nfjUYAXgd2eBFIeZ9i/VK+cSpOfRgOVfFwhTHnKRWaECxwXx7M0l4okR2M0/jigwWB
         fGBoOWyOO2Ofw==
Message-ID: <40f4e8a3-bac7-f64f-161d-f863103f3aec@kernel.org>
Date:   Mon, 15 May 2023 08:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] Input: st1232 - add virtual touchscreen and buttons
 handling
Content-Language: en-US
To:     202305140640.VLcvhR5G-lkp@intel.com,
        kernel test robot <lkp@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
References: <20230510-feature-ts_virtobj_patch-v1-3-5ae5e81bc264@wolfvision.net>
 <202305140640.VLcvhR5G-lkp@intel.com>
 <d35b5a67-eeb3-1f0f-c892-4bafcccbf317@wolfvision.net>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <d35b5a67-eeb3-1f0f-c892-4bafcccbf317@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 06:34, Javier Carrasco wrote:
> On 14.05.23 00:38, kernel test robot wrote:
>> Hi Javier,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on ac9a78681b921877518763ba0e89202254349d1b]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Carrasco/Input-ts-virtobj-Add-touchsreen-virtual-object-handling/20230510-215519
>> base:   ac9a78681b921877518763ba0e89202254349d1b
>> patch link:    https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v1-3-5ae5e81bc264%40wolfvision.net
>> patch subject: [PATCH 3/4] Input: st1232 - add virtual touchscreen and buttons handling
>> config: arm-randconfig-m041-20230514 (https://download.01.org/0day-ci/archive/20230514/202305140640.VLcvhR5G-lkp@intel.com/config)
>> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://github.com/intel-lab-lkp/linux/commit/133c0f8c33dc5e70a72e6a7d670e133b6043a7a3
>>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>>         git fetch --no-tags linux-review Javier-Carrasco/Input-ts-virtobj-Add-touchsreen-virtual-object-handling/20230510-215519
>>         git checkout 133c0f8c33dc5e70a72e6a7d670e133b6043a7a3
>>         # save the config file
>>         mkdir build_dir && cp config build_dir/.config
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Link: https://lore.kernel.org/oe-kbuild-all/202305140640.VLcvhR5G-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>    arm-linux-gnueabi-ld: drivers/input/touchscreen/st1232.o: in function `st1232_ts_parse_and_report':
>>>> st1232.c:(.text+0x148): undefined reference to `ts_virtobj_is_button_slot'
>>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x15e): undefined reference to `ts_virtobj_button_press'
>>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x16c): undefined reference to `ts_virtobj_mt_on_touchscreen'
>>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x242): undefined reference to `ts_virtobj_mapped_buttons'
>>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x266): undefined reference to `ts_virtobj_is_button_slot'
>>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x276): undefined reference to `ts_virtobj_button_release'
>>    arm-linux-gnueabi-ld: drivers/input/touchscreen/st1232.o: in function `st1232_ts_probe':
>>>> st1232.c:(.text+0x42c): undefined reference to `ts_virtobj_map_objects'
>>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x43c): undefined reference to `ts_virtobj_mapped_touchscreen'
>>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x44a): undefined reference to `ts_virtobj_get_touchscreen_abs'
>>    arm-linux-gnueabi-ld: st1232.c:(.text+0x520): undefined reference to `ts_virtobj_mapped_buttons'
>>>> arm-linux-gnueabi-ld: st1232.c:(.text+0x542): undefined reference to `ts_virtobj_set_button_caps'
>>
> Apparently there is something wrong about the references from this patch
> to a previous one from the same series ([PATCH 1/4] Input: ts-virtobj -
> Add touchs[c]reen virtual object handling). The "url" link shows all
> patches of this series in the right order though.
> 
> All these functions are declared in the linux/input/ts-virtobj.h header
> and also inline-defined there if ts-virtobj is not selected. If it is
> selected (either y or M), the functions are exported from
> driver/input/touchscreen/ts-virtobj.c. According to the error report,
> ts-virtobj was selected as a module.
> 
> I could build the kernel with the three possible configurations
> (ts-virtobj y/n/M) for x86_64 as well as for arm64 with no errors or
> warnings repeatedly, so I am a bit confused now. I am probably
> missing something, but I do not know what.
> 
> I wonder if the new file where the functions are defined (ts-virtobj.c)
> could not be found by some reason or if the test build does not like the
> way I handled the function declaration/definition. Any hint or advice
> would be more than welcome.

The report is correct. Build driver builtin and your virtual as module.

Best regards,
Krzysztof

