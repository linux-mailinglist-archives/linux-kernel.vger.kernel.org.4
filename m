Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB625BA40F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 03:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIPBhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 21:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiIPBhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 21:37:40 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02C04054F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 18:37:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VPupV65_1663292254;
Received: from 30.240.97.224(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPupV65_1663292254)
          by smtp.aliyun-inc.com;
          Fri, 16 Sep 2022 09:37:35 +0800
Message-ID: <891e03e1-1071-d1a4-a40c-fe537105b402@linux.alibaba.com>
Date:   Fri, 16 Sep 2022 09:37:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH V1 2/2] mm/damon/core: remove duplicate check about THP
To:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Cc:     sj@kernel.org, llvm@lists.linux.dev, kbuild-all@lists.01.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220915142237.92529-2-xhao@linux.alibaba.com>
 <202209160528.6z2rUbjZ-lkp@intel.com>
 <20220915152618.a050c7b55bf786c9e2c823ea@linux-foundation.org>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220915152618.a050c7b55bf786c9e2c823ea@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/16 上午6:26, Andrew Morton 写道:
> On Fri, 16 Sep 2022 05:54:56 +0800 kernel test robot <lkp@intel.com> wrote:
>
>> Hi Xin,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on akpm-mm/mm-everything]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Xin-Hao/mm-damon-sysfs-avoid-call-damon_target_has_pid-repeatedly/20220915-230635
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
>> config: hexagon-randconfig-r002-20220915 (https://download.01.org/0day-ci/archive/20220916/202209160528.6z2rUbjZ-lkp@intel.com/config)
>> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/intel-lab-lkp/linux/commit/7902790b04d0eb74686b55218e8ead191ba5c003
>>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>>          git fetch --no-tags linux-review Xin-Hao/mm-damon-sysfs-avoid-call-damon_target_has_pid-repeatedly/20220915-230635
>>          git checkout 7902790b04d0eb74686b55218e8ead191ba5c003
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash mm/damon/
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> mm/damon/vaddr.c:451:7: error: call to undeclared function 'pmd_young'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>>                     if (pmd_young(*pmd) || !page_is_idle(page) ||
>>                         ^
>>     mm/damon/vaddr.c:451:7: note: did you mean 'pte_young'?
>>     arch/hexagon/include/asm/pgtable.h:273:19: note: 'pte_young' declared here
>>     static inline int pte_young(pte_t pte)
>>                       ^
> Thanks.  I guess the arch needn't implement pmd_young() if it doesn't
> implement THP.
>
> I dropped the patch.
Oh, my bad,  thanks.
