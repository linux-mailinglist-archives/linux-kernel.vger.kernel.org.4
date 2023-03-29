Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090046CED89
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjC2Pwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjC2Pw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:52:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791C14EC8;
        Wed, 29 Mar 2023 08:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680105123; x=1711641123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nrzrnZhDKWcMw663KvKNv8peZE7CfPUyU+hNDlDbRM8=;
  b=WE5p3mJsH822Q+9IvWYkKdWfl8deKMnjIKgaq7JpFzfoMSvKdWe6nIPM
   uWhexrKyecECHbt7eOmgruqZbH+XQtgZOw55nKXjfsKkbqcZGjjdfnrXp
   CmQjePueJ1vUlxAy7l94nohn8qx5mxOpfq1oS9EVOqXXHJcHFJOSFsZWF
   pjifmwak5aW5Hedt1skkbHq+3Qz5X/on4q6umsBIfkegN7srf++HY9N5d
   lZ+BHFaFm/avUkayhV4mPTcg6dAYnjGpRXbIlxoKru5Kby6FJiJmYISZ+
   bs8r5UlKDXHyv5AJUn/ICyAFpuvzBEx/phb7ijG+iARx5rxwpXqdMcsUn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="338419760"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="338419760"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 08:52:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="716924607"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="716924607"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Mar 2023 08:51:59 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phY5e-000Jgi-2h;
        Wed, 29 Mar 2023 15:51:58 +0000
Date:   Wed, 29 Mar 2023 23:51:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     meenakshi.aggarwal@nxp.com, horia.geanta@nxp.com, V.sethi@nxp.com,
        pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Varun Sethi <v.sethi@nxp.com>
Subject: Re: [PATCH v2 1/2] crypto: caam - reduce page 0 regs access to
 minimum
Message-ID: <202303292311.eRQf8n1I-lkp@intel.com>
References: <20230322061716.3195841-2-meenakshi.aggarwal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230322061716.3195841-2-meenakshi.aggarwal@nxp.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on herbert-crypto-2.6/master linus/master v6.3-rc4 next-20230329]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/meenakshi-aggarwal-nxp-com/crypto-caam-OP-TEE-firmware-support/20230322-151746
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/20230322061716.3195841-2-meenakshi.aggarwal%40nxp.com
patch subject: [PATCH v2 1/2] crypto: caam - reduce page 0 regs access to minimum
config: powerpc-randconfig-s051-20230329 (https://download.01.org/0day-ci/archive/20230329/202303292311.eRQf8n1I-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/627d651dccbe8862582b68f0ceab5c40460dd281
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review meenakshi-aggarwal-nxp-com/crypto-caam-OP-TEE-firmware-support/20230322-151746
        git checkout 627d651dccbe8862582b68f0ceab5c40460dd281
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/crypto/caam/ drivers/media/i2c/ drivers/phy/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303292311.eRQf8n1I-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/crypto/caam/debugfs.c:58:30: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void *data @@     got unsigned long long [noderef] __iomem * @@
   drivers/crypto/caam/debugfs.c:58:30: sparse:     expected void *data
   drivers/crypto/caam/debugfs.c:58:30: sparse:     got unsigned long long [noderef] __iomem *
   drivers/crypto/caam/debugfs.c:60:30: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void *data @@     got unsigned long long [noderef] __iomem * @@
   drivers/crypto/caam/debugfs.c:60:30: sparse:     expected void *data
   drivers/crypto/caam/debugfs.c:60:30: sparse:     got unsigned long long [noderef] __iomem *
   drivers/crypto/caam/debugfs.c:62:30: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void *data @@     got unsigned long long [noderef] __iomem * @@
   drivers/crypto/caam/debugfs.c:62:30: sparse:     expected void *data
   drivers/crypto/caam/debugfs.c:62:30: sparse:     got unsigned long long [noderef] __iomem *
   drivers/crypto/caam/debugfs.c:64:30: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void *data @@     got unsigned long long [noderef] __iomem * @@
   drivers/crypto/caam/debugfs.c:64:30: sparse:     expected void *data
   drivers/crypto/caam/debugfs.c:64:30: sparse:     got unsigned long long [noderef] __iomem *
   drivers/crypto/caam/debugfs.c:66:30: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void *data @@     got unsigned long long [noderef] __iomem * @@
   drivers/crypto/caam/debugfs.c:66:30: sparse:     expected void *data
   drivers/crypto/caam/debugfs.c:66:30: sparse:     got unsigned long long [noderef] __iomem *
   drivers/crypto/caam/debugfs.c:68:30: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void *data @@     got unsigned long long [noderef] __iomem * @@
   drivers/crypto/caam/debugfs.c:68:30: sparse:     expected void *data
   drivers/crypto/caam/debugfs.c:68:30: sparse:     got unsigned long long [noderef] __iomem *
   drivers/crypto/caam/debugfs.c:70:30: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void *data @@     got unsigned long long [noderef] __iomem * @@
   drivers/crypto/caam/debugfs.c:70:30: sparse:     expected void *data
   drivers/crypto/caam/debugfs.c:70:30: sparse:     got unsigned long long [noderef] __iomem *
   drivers/crypto/caam/debugfs.c:74:30: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void *data @@     got unsigned long long [noderef] __iomem * @@
   drivers/crypto/caam/debugfs.c:74:30: sparse:     expected void *data
   drivers/crypto/caam/debugfs.c:74:30: sparse:     got unsigned long long [noderef] __iomem *
>> drivers/crypto/caam/debugfs.c:76:30: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void *data @@     got unsigned int [noderef] __iomem * @@
   drivers/crypto/caam/debugfs.c:76:30: sparse:     expected void *data
   drivers/crypto/caam/debugfs.c:76:30: sparse:     got unsigned int [noderef] __iomem *
   drivers/crypto/caam/debugfs.c:78:30: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void *data @@     got unsigned int [noderef] __iomem * @@
   drivers/crypto/caam/debugfs.c:78:30: sparse:     expected void *data
   drivers/crypto/caam/debugfs.c:78:30: sparse:     got unsigned int [noderef] __iomem *

vim +58 drivers/crypto/caam/debugfs.c

abd9875497ba47 Horia Geantă 2020-08-06  44  
627d651dccbe88 Horia GeantA 2023-03-22  45  void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
627d651dccbe88 Horia GeantA 2023-03-22  46  		       struct caam_perfmon __iomem *perfmon,
627d651dccbe88 Horia GeantA 2023-03-22  47  		       struct dentry *root)
abd9875497ba47 Horia Geantă 2020-08-06  48  {
abd9875497ba47 Horia Geantă 2020-08-06  49  	/*
abd9875497ba47 Horia Geantă 2020-08-06  50  	 * FIXME: needs better naming distinction, as some amalgamation of
abd9875497ba47 Horia Geantă 2020-08-06  51  	 * "caam" and nprop->full_name. The OF name isn't distinctive,
abd9875497ba47 Horia Geantă 2020-08-06  52  	 * but does separate instances
abd9875497ba47 Horia Geantă 2020-08-06  53  	 */
abd9875497ba47 Horia Geantă 2020-08-06  54  
abd9875497ba47 Horia Geantă 2020-08-06  55  	ctrlpriv->ctl = debugfs_create_dir("ctl", root);
abd9875497ba47 Horia Geantă 2020-08-06  56  
abd9875497ba47 Horia Geantă 2020-08-06  57  	debugfs_create_file("rq_dequeued", 0444, ctrlpriv->ctl,
abd9875497ba47 Horia Geantă 2020-08-06 @58  			    &perfmon->req_dequeued, &caam_fops_u64_ro);
abd9875497ba47 Horia Geantă 2020-08-06  59  	debugfs_create_file("ob_rq_encrypted", 0444, ctrlpriv->ctl,
abd9875497ba47 Horia Geantă 2020-08-06  60  			    &perfmon->ob_enc_req, &caam_fops_u64_ro);
abd9875497ba47 Horia Geantă 2020-08-06  61  	debugfs_create_file("ib_rq_decrypted", 0444, ctrlpriv->ctl,
abd9875497ba47 Horia Geantă 2020-08-06  62  			    &perfmon->ib_dec_req, &caam_fops_u64_ro);
abd9875497ba47 Horia Geantă 2020-08-06  63  	debugfs_create_file("ob_bytes_encrypted", 0444, ctrlpriv->ctl,
abd9875497ba47 Horia Geantă 2020-08-06  64  			    &perfmon->ob_enc_bytes, &caam_fops_u64_ro);
abd9875497ba47 Horia Geantă 2020-08-06  65  	debugfs_create_file("ob_bytes_protected", 0444, ctrlpriv->ctl,
abd9875497ba47 Horia Geantă 2020-08-06  66  			    &perfmon->ob_prot_bytes, &caam_fops_u64_ro);
abd9875497ba47 Horia Geantă 2020-08-06  67  	debugfs_create_file("ib_bytes_decrypted", 0444, ctrlpriv->ctl,
abd9875497ba47 Horia Geantă 2020-08-06  68  			    &perfmon->ib_dec_bytes, &caam_fops_u64_ro);
abd9875497ba47 Horia Geantă 2020-08-06  69  	debugfs_create_file("ib_bytes_validated", 0444, ctrlpriv->ctl,
abd9875497ba47 Horia Geantă 2020-08-06  70  			    &perfmon->ib_valid_bytes, &caam_fops_u64_ro);
abd9875497ba47 Horia Geantă 2020-08-06  71  
abd9875497ba47 Horia Geantă 2020-08-06  72  	/* Controller level - global status values */
abd9875497ba47 Horia Geantă 2020-08-06  73  	debugfs_create_file("fault_addr", 0444, ctrlpriv->ctl,
abd9875497ba47 Horia Geantă 2020-08-06  74  			    &perfmon->faultaddr, &caam_fops_u32_ro);
abd9875497ba47 Horia Geantă 2020-08-06  75  	debugfs_create_file("fault_detail", 0444, ctrlpriv->ctl,
abd9875497ba47 Horia Geantă 2020-08-06 @76  			    &perfmon->faultdetail, &caam_fops_u32_ro);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
