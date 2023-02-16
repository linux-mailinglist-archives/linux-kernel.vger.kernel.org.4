Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40AB6997D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjBPOtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjBPOti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:49:38 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7265C7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676558976; x=1708094976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DzfxCkLUfTFD8XJxb1li1g7wOfsHJQXhG/FPU/fVBSU=;
  b=cHtHD2biHVHmVWnjUEFfQ1I3HhvbO7SpZcrs5j7mxqxlgG+TsX5TZV6l
   Rpq95y/TXIgmbVUt381gc1Jlk54S3Qk04V+lDrb6CVrZUdNBX+exxEZRM
   fnLMPrCb4gESpDzwkDZWZNRMAJAV+CkhrxR7EyeZSTZfImK1xqrbMsnHH
   xB+5/6TxkfuhwmGk9cEs6qFmnCq3wR77wF5s3w92s3Ys1YXjrJjNkPUER
   TquaI1Fz0Eas76V3Y+8zNQ1nrOJwhja6zxT/dll1Tt+qj9nCHnYrH+ojn
   TmWp5X09HAsOHlmLpJztotvZEmSHqgYti9TC6cmkt2iwszaLxlvbifgll
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="396377182"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="396377182"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 06:49:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="663476638"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="663476638"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 16 Feb 2023 06:49:34 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSfZg-000AIj-0h;
        Thu, 16 Feb 2023 14:49:28 +0000
Date:   Thu, 16 Feb 2023 22:48:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shreenidhi Shedi <yesshedi@gmail.com>, dhowells@redhat.com,
        dwmw2@infradead.org, gregkh@linuxfoundation.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH v3 2/6] sign-file: move file signing logic to its own
 function
Message-ID: <202302162229.XFMtVABh-lkp@intel.com>
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
[also build test WARNING on v6.2-rc8 next-20230216]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shreenidhi-Shedi/sign-file-move-file-signing-logic-to-its-own-function/20230214-030302
patch link:    https://lore.kernel.org/r/20230213190034.57097-2-sshedi%40vmware.com
patch subject: [PATCH v3 2/6] sign-file: move file signing logic to its own function
config: riscv-randconfig-r042-20230213 (https://download.01.org/0day-ci/archive/20230216/202302162229.XFMtVABh-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1dfab8ead8d3f9c0c04eeeaf7c436a2878f2158e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shreenidhi-Shedi/sign-file-move-file-signing-logic-to-its-own-function/20230214-030302
        git checkout 1dfab8ead8d3f9c0c04eeeaf7c436a2878f2158e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302162229.XFMtVABh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/sign-file.c:318:5: warning: no previous prototype for 'sign_file' [-Wmissing-prototypes]
     318 | int sign_file(int argc, char **argv, struct cmd_opts *opts)
         |     ^~~~~~~~~
   scripts/sign-file.c: In function 'sign_file':
   scripts/sign-file.c:333:13: warning: unused variable 'i' [-Wunused-variable]
     333 |         int i, n;
         |             ^
--
>> scripts/sign-file.c:318:5: warning: no previous prototype for 'sign_file' [-Wmissing-prototypes]
     318 | int sign_file(int argc, char **argv, struct cmd_opts *opts)
         |     ^~~~~~~~~
   scripts/sign-file.c: In function 'sign_file':
   scripts/sign-file.c:333:13: warning: unused variable 'i' [-Wunused-variable]
     333 |         int i, n;
         |             ^


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
   333		int i, n;
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
