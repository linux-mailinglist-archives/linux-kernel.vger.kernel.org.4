Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BB070C295
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbjEVPhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjEVPhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:37:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2BBE0;
        Mon, 22 May 2023 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684769852; x=1716305852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3vkAkGR1H0Odi36ga9DiWtTDEHZIWL7hLa3OCts4M1s=;
  b=NUHcT7Wf3HThgu3+FSjEbbR/KNGg6BeNl2+d6wQSyN5theZJbOz+qZSX
   OZWyTJDD//HXpmU//QeJEVEp/6U2sgfVnsqSCTDTm8V0Tw7gbwZ3pu2Jh
   pd+5K6mBR4Y4DuZgwLeOB8eY+EK0/VTEkU/OHZ+tHApewjtETjkpUjb8L
   s/QWChXKGiAzjhiyPScCEkv8Hvu5pANt5FngOgUWHks1n2s/YBSxZJz8Z
   a3jhKh2weoZBBJtNrROkQuXMVL/rxqpFPY+LS0z00q8pFAOX1dDE6arXv
   uysFcwavJKDbvh4yZCkC5pymiX1yRRUcPr1YPnf19Y/JLmQpdapJ/afgt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="355303533"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="355303533"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 08:37:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="773408587"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="773408587"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 May 2023 08:36:48 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q17aZ-000CxD-1R;
        Mon, 22 May 2023 15:36:47 +0000
Date:   Mon, 22 May 2023 23:35:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     ndesaulniers@google.com, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] certs: buffer stderr from openssl unless error
Message-ID: <202305222321.45ezNpB8-lkp@intel.com>
References: <20230517-genkey-v1-1-b887424da4a8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517-genkey-v1-1-b887424da4a8@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6]

url:    https://github.com/intel-lab-lkp/linux/commits/ndesaulniers-google-com/certs-buffer-stderr-from-openssl-unless-error/20230518-004753
base:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
patch link:    https://lore.kernel.org/r/20230517-genkey-v1-1-b887424da4a8%40google.com
patch subject: [PATCH] certs: buffer stderr from openssl unless error
config: arm-randconfig-r046-20230521 (https://download.01.org/0day-ci/archive/20230522/202305222321.45ezNpB8-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b0fb98227c90adf2536c9ad644a74d5e92961111)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/0e437a41fdb41c84834de6776bf38951b197792a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review ndesaulniers-google-com/certs-buffer-stderr-from-openssl-unless-error/20230518-004753
        git checkout 0e437a41fdb41c84834de6776bf38951b197792a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305222321.45ezNpB8-lkp@intel.com/

All errors (new ones prefixed by >>):

   At main.c:152:
   - SSL error:FFFFFFFF80000002:system library::No such file or directory: ../crypto/bio/bss_file.c:67
   - SSL error:10000080:BIO routines::no such file: ../crypto/bio/bss_file.c:75
>> extract-cert: certs/signing_key.pem: No such file or directory

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
