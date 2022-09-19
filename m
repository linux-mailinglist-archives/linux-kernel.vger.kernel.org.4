Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358325BC52E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiISJTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiISJTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:19:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDB1F9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663579166; x=1695115166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z/aXU/JBZiYjJEqHq803y2o3WL0yCXJJFORZbtOxYCU=;
  b=gjEfWP0JkY07OllZQL333R0s/RimaA4bCNQXW8QXbpHNr225X4v+dqMj
   OJ3KZO4wEDCwrAkKMNw8OsaVd/JdlW3R4VQYo8c4rrY/Dkf/MgvSQ6qAF
   09mICMEbhqH9vNwnoZFkEjnNdqYjePWwtXnkQ77ZOW+25eTZVGI9V68Ma
   nZM1SVH6Qsy4xscM6oWfwCKNut4cxoMYG5MHxg+FBYiVDKy8QjzZ8BOlT
   Le9DxfVe/3QIwAymsGVkUNtvK79f2zGSaByRWNzCNkETBNez1f79OlWfw
   5SuO8AxW+mEqL9r9XrHLlk2lBiZR6bITyeHa8pGMpbWSsrilJ3qm44FFb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="363308112"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="363308112"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 02:19:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="947137928"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Sep 2022 02:19:23 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaCvz-0001sT-0v;
        Mon, 19 Sep 2022 09:19:23 +0000
Date:   Mon, 19 Sep 2022 17:18:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hyunwoo Kim <imv4bel@gmail.com>, lkundrak@v3.sk
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, imv4bel@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux@dominikbrodowski.net
Subject: Re: [PATCH v3] char: pcmcia: scr24x_cs: Fix use-after-free in
 scr24x_fops
Message-ID: <202209191730.mhZmYKD3-lkp@intel.com>
References: <20220919040854.GA302968@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919040854.GA302968@ubuntu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hyunwoo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on linus/master v6.0-rc6 next-20220916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hyunwoo-Kim/char-pcmcia-scr24x_cs-Fix-use-after-free-in-scr24x_fops/20220919-121035
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git ceecbbddbf549fe0b7ffa3804a6e255b3360030f
config: hexagon-randconfig-r041-20220919 (https://download.01.org/0day-ci/archive/20220919/202209191730.mhZmYKD3-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/823ffd6f522e65ce9730fe5bc2ea59221adee881
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hyunwoo-Kim/char-pcmcia-scr24x_cs-Fix-use-after-free-in-scr24x_fops/20220919-121035
        git checkout 823ffd6f522e65ce9730fe5bc2ea59221adee881
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/char/pcmcia/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/char/pcmcia/scr24x_cs.c:107:12: warning: variable 'dev' is uninitialized when used here [-Wuninitialized]
           kref_get(&dev->refcnt);
                     ^~~
   drivers/char/pcmcia/scr24x_cs.c:93:24: note: initialize the variable 'dev' to silence this warning
           struct scr24x_dev *dev;
                                 ^
                                  = NULL
   1 warning generated.


vim +/dev +107 drivers/char/pcmcia/scr24x_cs.c

f2ed287bcc9073 Lubomir Rintel 2016-10-25   90  
f2ed287bcc9073 Lubomir Rintel 2016-10-25   91  static int scr24x_open(struct inode *inode, struct file *filp)
f2ed287bcc9073 Lubomir Rintel 2016-10-25   92  {
823ffd6f522e65 Hyunwoo Kim    2022-09-18   93  	struct scr24x_dev *dev;
823ffd6f522e65 Hyunwoo Kim    2022-09-18   94  	struct pcmcia_device *link;
823ffd6f522e65 Hyunwoo Kim    2022-09-18   95  	int minor = iminor(inode);
823ffd6f522e65 Hyunwoo Kim    2022-09-18   96  
823ffd6f522e65 Hyunwoo Kim    2022-09-18   97  	if (minor >= SCR24X_DEVS)
823ffd6f522e65 Hyunwoo Kim    2022-09-18   98  		return -ENODEV;
823ffd6f522e65 Hyunwoo Kim    2022-09-18   99  
823ffd6f522e65 Hyunwoo Kim    2022-09-18  100  	mutex_lock(&remove_mutex);
823ffd6f522e65 Hyunwoo Kim    2022-09-18  101  	link = dev_table[minor];
823ffd6f522e65 Hyunwoo Kim    2022-09-18  102  	if (link == NULL) {
823ffd6f522e65 Hyunwoo Kim    2022-09-18  103  		mutex_unlock(&remove_mutex);
823ffd6f522e65 Hyunwoo Kim    2022-09-18  104  		return -ENODEV;
823ffd6f522e65 Hyunwoo Kim    2022-09-18  105  	}
f2ed287bcc9073 Lubomir Rintel 2016-10-25  106  
f2ed287bcc9073 Lubomir Rintel 2016-10-25 @107  	kref_get(&dev->refcnt);
f2ed287bcc9073 Lubomir Rintel 2016-10-25  108  	filp->private_data = dev;
823ffd6f522e65 Hyunwoo Kim    2022-09-18  109  	mutex_unlock(&remove_mutex);
f2ed287bcc9073 Lubomir Rintel 2016-10-25  110  
c5bf68fe0c86a5 Kirill Smelkov 2019-03-26  111  	return stream_open(inode, filp);
f2ed287bcc9073 Lubomir Rintel 2016-10-25  112  }
f2ed287bcc9073 Lubomir Rintel 2016-10-25  113  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
