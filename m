Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F3469617F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjBNKyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjBNKyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:54:09 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0567698
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676372048; x=1707908048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dFNkB5YIb1s+P+PykOrfO28sjd2iKw1dFkV4JbtauQA=;
  b=fkjJ4bLNQJ000CzJ0D1Y8ohTvRF2jEuA5qCanUEA5bt8duQacDzOANjg
   O4qOblcHzHqW3Alwhy1CJBAAzA3bbn81SkO8RNrkUAWQkU5islWaGN5SC
   cVjHWBYe86Lf48GKvrnX+f6dVlykga0jXPYVL/mr/CDAnzhbcbwODRpPZ
   l0VBL9zOEaXRvGae5mvu3/KheejxXd8HlN3ttqDUQshmlWxPUoCAiKFQE
   9AWug2+KB0RJ3DwE1VTVTUKHf1ZEdTKcB9Z1aYCNjdbfeyGxsJw3AwLAu
   238Ejga0HzlpYzJo7kHxt75vRhBeMs2xFAP/vCH7ncr+jMpjijIRnqe5t
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="417351869"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="417351869"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 02:54:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="778278095"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="778278095"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 14 Feb 2023 02:54:04 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRswm-0008Q8-18;
        Tue, 14 Feb 2023 10:54:04 +0000
Date:   Tue, 14 Feb 2023 18:53:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shreenidhi Shedi <yesshedi@gmail.com>, dhowells@redhat.com,
        dwmw2@infradead.org, gregkh@linuxfoundation.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH v3 2/6] sign-file: move file signing logic to its own
 function
Message-ID: <202302141805.tULq9MiK-lkp@intel.com>
References: <20230213190034.57097-2-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213190034.57097-2-sshedi@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shreenidhi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.2-rc8 next-20230214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shreenidhi-Shedi/sign-file-move-file-signing-logic-to-its-own-function/20230214-030302
patch link:    https://lore.kernel.org/r/20230213190034.57097-2-sshedi%40vmware.com
patch subject: [PATCH v3 2/6] sign-file: move file signing logic to its own function
config: x86_64-randconfig-a003-20230213 (https://download.01.org/0day-ci/archive/20230214/202302141805.tULq9MiK-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1dfab8ead8d3f9c0c04eeeaf7c436a2878f2158e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shreenidhi-Shedi/sign-file-move-file-signing-logic-to-its-own-function/20230214-030302
        git checkout 1dfab8ead8d3f9c0c04eeeaf7c436a2878f2158e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302141805.tULq9MiK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   scripts/sign-file.c:333:6: warning: unused variable 'i' [-Wunused-variable]
           int i, n;
               ^
>> scripts/sign-file.c:318:5: warning: no previous prototype for function 'sign_file' [-Wmissing-prototypes]
   int sign_file(int argc, char **argv, struct cmd_opts *opts)
       ^
   scripts/sign-file.c:318:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int sign_file(int argc, char **argv, struct cmd_opts *opts)
   ^
   static 
   2 warnings generated.
--
   scripts/sign-file.c:333:6: warning: unused variable 'i' [-Wunused-variable]
           int i, n;
               ^
>> scripts/sign-file.c:318:5: warning: no previous prototype for function 'sign_file' [-Wmissing-prototypes]
   int sign_file(int argc, char **argv, struct cmd_opts *opts)
       ^
   scripts/sign-file.c:318:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int sign_file(int argc, char **argv, struct cmd_opts *opts)
   ^
   static 
   2 warnings generated.


vim +/sign_file +318 scripts/sign-file.c

   317	
 > 318	int sign_file(int argc, char **argv, struct cmd_opts *opts)
   319	{
   320		struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
   321		unsigned char buf[4096] = {0};
   322		unsigned long module_size, sig_size;
   323		unsigned int use_signed_attrs;
   324		const EVP_MD *digest_algo;
   325		EVP_PKEY *private_key;
   326	#ifndef USE_PKCS7
   327		CMS_ContentInfo *cms = NULL;
   328	#else
   329		PKCS7 *pkcs7 = NULL;
   330	#endif
   331		X509 *x509;
   332		BIO *bd, *bm;
 > 333		int i, n;
   334	
   335		char *hash_algo = opts->hash_algo;
   336		char *dest_name = opts->dest_name;
   337		char *private_key_name = opts->private_key_name;
   338		char *raw_sig_name = opts->raw_sig_name;
   339		char *x509_name = opts->x509_name;
   340		char *module_name = opts->module_name;
   341		bool save_sig = opts->save_sig;
   342		bool replace_orig = opts->replace_orig;
   343		bool raw_sig = opts->raw_sig;
   344		bool sign_only = opts->sign_only;
   345	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
