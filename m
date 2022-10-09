Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1935F8C7B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 19:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJIRMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 13:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJIRMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 13:12:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759EB1EAF3;
        Sun,  9 Oct 2022 10:12:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0CC460C48;
        Sun,  9 Oct 2022 17:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F06C433D6;
        Sun,  9 Oct 2022 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665335536;
        bh=goN3N8DxcViakFP9J3bBDQBw8Ir5SZd+brsHGBMJHlk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O9zYFGj5pRa2a/WBdW77Vt7ax/qFtaIN8hXZ5cW6aqCQlDUOEWZxpPHb+8yn5sJms
         qdmdNMXA9h1CxAi+cGYitVhUYHVZ+qISkCE3K1OaY/jcJ9IemklIT7ktxUJtJZ730H
         JrQjPKvvL2WtzwQLU2qQbi/N4ro67Qy++hSr85zbaDgGwrtrsTm+OfnPav1+srqxMH
         mBxmJjUWH9nlQqWLA1povQAnpmOnj/ROzxRy4LmM3Qg3kydubPiYCwYCL/gF6Mz9ao
         VygftJ/3rbFKalToC1A8PIXLgEk/a3pTlPDfC17NpD6WP2RibxWJQoxoRK8BFxlol7
         rWYzh7uFPdveQ==
Date:   Sun, 9 Oct 2022 18:12:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        lars@metafoo.de, llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajat.khandelwal@intel.com
Subject: Re: [PATCH v4] iio: pressure: mpl115: Implementing low power mode
 by shutdown gpio
Message-ID: <20221009181237.24396d70@jic23-huawei>
In-Reply-To: <202210031811.6QYhq6PG-lkp@intel.com>
References: <20221004053801.2774719-1-rajat.khandelwal@linux.intel.com>
        <202210031811.6QYhq6PG-lkp@intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2022 18:17:57 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Rajat,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on jic23-iio/togreg]
> [also build test ERROR on linus/master v6.0 next-20220930]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Rajat-Khandelwal/iio-pressure-mpl115-Implementing-low-power-mode-by-shutdown-gpio/20221003-133904
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: x86_64-randconfig-a005-20221003
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/284b52f6eb0616aeb44203d7114c4fb1e80b785d
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Rajat-Khandelwal/iio-pressure-mpl115-Implementing-low-power-mode-by-shutdown-gpio/20221003-133904
>         git checkout 284b52f6eb0616aeb44203d7114c4fb1e80b785d
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "mpl115_dev_pm_ops" [drivers/iio/pressure/mpl115_spi.ko] undefined!  
> 

You have probably figured this out, but you need the
EXPORT_NS_RUNTIME_DEV_PM_OPS()  

with appropriate namespace set.

Thanks,
Jonathan
