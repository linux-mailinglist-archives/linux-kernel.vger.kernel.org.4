Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660895BA2B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiIOW00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIOW0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:26:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAABF78
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 15:26:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D0E0626FE
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 22:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E62C433C1;
        Thu, 15 Sep 2022 22:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663280779;
        bh=d4vL/tXKkJFtndx0mZJrG5LoXYIPxtE461UfMDX6pB0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oYcAaEhpBBcSkwoR4W8yxlv9F6KnYjjuuapBrXS7fSUGFAPZ4wvLogvzf76ucrCs/
         /hSm99d239AXq9qRigYC7D70fYVmxsP4TuSvVC6QQVcRDAL8mRkNaBbfQkosjcmdOU
         CKH9QR6sJiFKHunw5ZSVaApBVOivmcssWRDuRj/Y=
Date:   Thu, 15 Sep 2022 15:26:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Xin Hao <xhao@linux.alibaba.com>, sj@kernel.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 2/2] mm/damon/core: remove duplicate check about THP
Message-Id: <20220915152618.a050c7b55bf786c9e2c823ea@linux-foundation.org>
In-Reply-To: <202209160528.6z2rUbjZ-lkp@intel.com>
References: <20220915142237.92529-2-xhao@linux.alibaba.com>
        <202209160528.6z2rUbjZ-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2022 05:54:56 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi Xin,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Xin-Hao/mm-damon-sysfs-avoid-call-damon_target_has_pid-repeatedly/20220915-230635
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> config: hexagon-randconfig-r002-20220915 (https://download.01.org/0day-ci/archive/20220916/202209160528.6z2rUbjZ-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/7902790b04d0eb74686b55218e8ead191ba5c003
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Xin-Hao/mm-damon-sysfs-avoid-call-damon_target_has_pid-repeatedly/20220915-230635
>         git checkout 7902790b04d0eb74686b55218e8ead191ba5c003
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash mm/damon/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> mm/damon/vaddr.c:451:7: error: call to undeclared function 'pmd_young'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                    if (pmd_young(*pmd) || !page_is_idle(page) ||
>                        ^
>    mm/damon/vaddr.c:451:7: note: did you mean 'pte_young'?
>    arch/hexagon/include/asm/pgtable.h:273:19: note: 'pte_young' declared here
>    static inline int pte_young(pte_t pte)
>                      ^

Thanks.  I guess the arch needn't implement pmd_young() if it doesn't
implement THP.

I dropped the patch.
