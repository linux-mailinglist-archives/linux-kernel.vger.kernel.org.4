Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2542772AFEF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 03:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjFKBiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 21:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFKBiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 21:38:09 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2545F9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 18:38:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VknHnDH_1686447481;
Received: from 30.213.168.230(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VknHnDH_1686447481)
          by smtp.aliyun-inc.com;
          Sun, 11 Jun 2023 09:38:03 +0800
Message-ID: <58aa95c5-f66a-0768-2e7d-aa2270852d8e@linux.alibaba.com>
Date:   Sun, 11 Jun 2023 09:38:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] mm: compaction: skip memory hole rapidly when isolating
 migratable pages
To:     kernel test robot <lkp@intel.com>, akpm@linux-foundation.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        mgorman@techsingularity.net, vbabka@suse.cz, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <8cc668b77c8eb2fa78058b3d81386ebed9c5a9cd.1686294549.git.baolin.wang@linux.alibaba.com>
 <202306092250.cp65gzkn-lkp@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <202306092250.cp65gzkn-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/2023 10:48 PM, kernel test robot wrote:
> Hi Baolin,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/mm-compaction-skip-memory-hole-rapidly-when-isolating-migratable-pages/20230609-174659
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/8cc668b77c8eb2fa78058b3d81386ebed9c5a9cd.1686294549.git.baolin.wang%40linux.alibaba.com
> patch subject: [PATCH] mm: compaction: skip memory hole rapidly when isolating migratable pages
> config: arm-randconfig-r025-20230609 (https://download.01.org/0day-ci/archive/20230609/202306092250.cp65gzkn-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=1 build):
>          mkdir -p ~/bin
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install arm cross compiling tool for clang build
>          # apt-get install binutils-arm-linux-gnueabi
>          git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
>          git fetch akpm-mm mm-everything
>          git checkout akpm-mm/mm-everything
>          b4 shazam https://lore.kernel.org/r/8cc668b77c8eb2fa78058b3d81386ebed9c5a9cd.1686294549.git.baolin.wang@linux.alibaba.com
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306092250.cp65gzkn-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> mm/compaction.c:235:27: error: call to undeclared function 'pfn_to_section_nr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>             unsigned long start_nr = pfn_to_section_nr(start_pfn);
>                                      ^
>>> mm/compaction.c:237:6: error: call to undeclared function 'online_section_nr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>             if (online_section_nr(start_nr))
>                 ^
>>> mm/compaction.c:240:19: error: call to undeclared function 'next_online_section_nr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>             next_online_nr = next_online_section_nr(start_nr);
>                              ^
>>> mm/compaction.c:242:10: error: call to undeclared function 'section_nr_to_pfn'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                     return section_nr_to_pfn(next_online_nr);
>                            ^
>     4 errors generated.

Thanks for report. I should provide a dummy function if CONFIG_SPARSEMEM 
is not selected.
