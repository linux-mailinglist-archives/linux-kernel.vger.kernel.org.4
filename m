Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3716661ED18
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiKGIlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiKGIlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:41:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668BE1570D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 00:41:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 225FBB80E2D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633EFC433C1;
        Mon,  7 Nov 2022 08:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667810464;
        bh=vPUGMuhh4vwQGB7vfUji7HjpKe37cpDybwv17Ul9VtQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YYuq9IMfO07xQLYKc2hx3hnNFfrUJ/+/sleJ97Dle7Ns8hhjLRcK63ToCi8CgoDf3
         /Bw11E/uMCl/DLpOl80Dpp7QYahrHRqkKntfbvN+MfOkVkyLuaPr+HAJlW40/90oQ1
         dYRXlDGnPVrGiwx/tJc8B0H22yIVD6ZnUDBfeiiJC9tZGHsiqlFT8wmcUDjLN+m3wO
         lQVRfcU1xF0bxwnG6Lhq5qbR1zXf5QQoqePpzqXWOl7dH3m7VHMrt8oV9c+rim3Fio
         9fWydxw8xC6s/4IB3Uf+ehCneK07TV7im9D8ZGtWwrP1ITNSJhanMHq/2iDvcrCSWi
         jDPBPSXy3NY6w==
Message-ID: <1937d7b5-89f4-0cb2-957a-bda2dcbbdb37@kernel.org>
Date:   Mon, 7 Nov 2022 10:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: ld.lld: error: undefined symbol: gpmc_omap_onenand_set_timings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <202211050325.XVtPvMvy-lkp@intel.com>
 <402e120a-044e-12ac-7d10-cf8b3b5a1404@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <402e120a-044e-12ac-7d10-cf8b3b5a1404@kernel.org>
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



On 04/11/2022 21:36, Krzysztof Kozlowski wrote:
> On 04/11/2022 15:29, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   ee6050c8af96bba2f81e8b0793a1fc2f998fcd20
>> commit: 854fd9209b20837ab48c2e6714e5e44dd8ea33a2 memory: omap-gpmc: Allow building as a module
>> date:   6 months ago
>> config: arm-buildonly-randconfig-r004-20221104
>> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 2bbafe04fe785a9469bea5a3737f8d7d3ce4aca2)
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # install arm cross compiling tool for clang build
>>         # apt-get install binutils-arm-linux-gnueabi
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=854fd9209b20837ab48c2e6714e5e44dd8ea33a2
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout 854fd9209b20837ab48c2e6714e5e44dd8ea33a2
>>         # save the config file
>>         mkdir build_dir && cp config build_dir/.config
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
> 
> +Cc Miquel,
> 
> Hm, I am pretty sure we already fixed it... but it seems not. I think
> this needs dependency in MTD_ONENAND_OMAP2 - one is module, second
> cannot be built-in.

We fixed MTD_NAND_OMAP2 but missed this MTD_ONENAND_OMAP2.

I'll send out a patch soon.

cheers,
-roger
