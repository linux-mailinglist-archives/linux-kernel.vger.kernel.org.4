Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE9368E44F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 00:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBGXQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 18:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBGXQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 18:16:47 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01926F6;
        Tue,  7 Feb 2023 15:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675811806; x=1707347806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=STI6p7MWc4YADHC7iNdmUKpnTsVLSGk6u5h6DbhqFKA=;
  b=kSJUV6rwGwGhAFS2JFI5RWhSZN2VtcOxNziFSYBWNZfE37DTuYDFM2wQ
   X9040yObYMTmv4MwI+jVkG52WU0chMtQFhzfamAiaZAyihiAkgT/7dore
   4xTuPnKfc0rLY3s7cGDprMnbCVApoacczZmDezOjaI6iyUo78vQpdPVuL
   695SuFFPOZPOqI6TPnxLkRXKptnQMn5KV7xJhfPPmdvEGJhSZzCQfPfJa
   Lae2Hdf9+8ORTH2sd21tWxjJR8+F5+SyxcDJvtAMGmkziN+akGV5043mC
   C+dHfrt41J1pGk004JAmOT7+E6OT+TwIdXUm+elKKwaM/31KoxsX7T4Wn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="415875354"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="415875354"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 15:16:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="790978634"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="790978634"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Feb 2023 15:16:39 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPXCZ-0003yH-0G;
        Tue, 07 Feb 2023 23:16:39 +0000
Date:   Wed, 8 Feb 2023 07:16:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Evan Green <evan@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, Conor Dooley <conor@kernel.org>,
        vineetg@rivosinc.com, heiko@sntech.de, slewis@rivosinc.com,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Dao Lu <daolu@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/6] RISC-V: Add a syscall for HW probing
Message-ID: <202302080600.xT7BtKan-lkp@intel.com>
References: <20230206201455.1790329-3-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206201455.1790329-3-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes robh/for-next soc/for-next linus/master v6.2-rc7 next-20230207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Evan-Green/RISC-V-Move-struct-riscv_cpuinfo-to-new-header/20230207-041746
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20230206201455.1790329-3-evan%40rivosinc.com
patch subject: [PATCH v2 2/6] RISC-V: Add a syscall for HW probing
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/4a91a9ca5d81029b702e6e74c8f2015cf50af0ae
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Evan-Green/RISC-V-Move-struct-riscv_cpuinfo-to-new-header/20230207-041746
        git checkout 4a91a9ca5d81029b702e6e74c8f2015cf50af0ae
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/riscv/hwprobe.rst:33: WARNING: Field list ends without a blank line; unexpected unindent.

vim +33 Documentation/riscv/hwprobe.rst

    31	
    32	* :RISCV_HWPROBE_KEY_MVENDORID:: Contains the value of :mvendorid:, as per the
  > 33	  ISA specifications.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
