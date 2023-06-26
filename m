Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165CC73E1A0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjFZOLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjFZOLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:11:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9386B194;
        Mon, 26 Jun 2023 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687788704; x=1719324704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KygZpeRTiodO2Whd/iRJqDkdLnCLMCcUOUpq4IvWVMo=;
  b=bRJKf8eOz7I7H8KSY79Q9nXJ5y9zJ1xvjw4em0eQupLfKtLWGF8AFwNk
   xN4PS5yaUWNgbiQXRB1VOBdRWg5+vuxryu6DLYv7PJ/uXsY3P8ZgxzlLj
   viC4D+F+svaIJFSjPpAlZ1nbMH+MmSA7V6Y1adKdvzteYOWFGaiAcwC/i
   luPkH2lP2j5w72aLvhqpaIY69q7Mg8zFu2CZ8yE7qiYyWY+q+lLQkpVu5
   7qJwQh+uXqwUzCf/ucPZhxc4tNbi7T3KbqrplGMKQSqBJN06xvd/quW1C
   WmFCRJ3LZHZjjY/XVf35SAutcghrtVwYiuTNxgXlT0J6X8ZUwUjkGoXL0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="346032875"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="346032875"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 07:11:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="666317742"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="666317742"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Jun 2023 07:11:10 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDmvt-000Aj3-2c;
        Mon, 26 Jun 2023 14:11:09 +0000
Date:   Mon, 26 Jun 2023 22:10:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     You Kangren <youkangren@vivo.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Adam Guerin <adam.guerin@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        Srinivas Kerekare <srinivas.kerekare@intel.com>,
        "open list:QAT DRIVER" <qat-linux@intel.com>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        netdev@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] crypto: qat - Replace the if statement with min()
Message-ID: <202306262110.NCIrjtZF-lkp@intel.com>
References: <20230626091541.1064-1-youkangren@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626091541.1064-1-youkangren@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi You,

kernel test robot noticed the following build warnings:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on herbert-crypto-2.6/master linus/master v6.4 next-20230626]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/You-Kangren/crypto-qat-Replace-the-if-statement-with-min/20230626-172132
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/20230626091541.1064-1-youkangren%40vivo.com
patch subject: [PATCH] crypto: qat - Replace the if statement with min()
config: i386-randconfig-i001-20230626 (https://download.01.org/0day-ci/archive/20230626/202306262110.NCIrjtZF-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230626/202306262110.NCIrjtZF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306262110.NCIrjtZF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/crypto/intel/qat/qat_common/qat_uclo.c:1989:12: warning: comparison of distinct pointer types ('typeof (words_num) *' (aka 'unsigned int *') and 'typeof (1024) *' (aka 'int *')) [-Wcompare-distinct-pointer-types]
                   cpylen = min(words_num, UWORD_CPYBUF_SIZE);
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:67:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   1 warning generated.


vim +1989 drivers/crypto/intel/qat/qat_common/qat_uclo.c

  1972	
  1973	static void qat_uclo_wr_uimage_raw_page(struct icp_qat_fw_loader_handle *handle,
  1974						struct icp_qat_uclo_encap_page
  1975						*encap_page, unsigned int ae)
  1976	{
  1977		unsigned int uw_physical_addr, uw_relative_addr, i, words_num, cpylen;
  1978		struct icp_qat_uclo_objhandle *obj_handle = handle->obj_handle;
  1979		u64 fill_pat;
  1980	
  1981		/* load the page starting at appropriate ustore address */
  1982		/* get fill-pattern from an image -- they are all the same */
  1983		memcpy(&fill_pat, obj_handle->ae_uimage[0].img_ptr->fill_pattern,
  1984		       sizeof(u64));
  1985		uw_physical_addr = encap_page->beg_addr_p;
  1986		uw_relative_addr = 0;
  1987		words_num = encap_page->micro_words_num;
  1988		while (words_num) {
> 1989			cpylen = min(words_num, UWORD_CPYBUF_SIZE);
  1990	
  1991			/* load the buffer */
  1992			for (i = 0; i < cpylen; i++)
  1993				qat_uclo_fill_uwords(obj_handle, encap_page,
  1994						     &obj_handle->uword_buf[i],
  1995						     uw_physical_addr + i,
  1996						     uw_relative_addr + i, fill_pat);
  1997	
  1998			/* copy the buffer to ustore */
  1999			qat_hal_wr_uwords(handle, (unsigned char)ae,
  2000					  uw_physical_addr, cpylen,
  2001					  obj_handle->uword_buf);
  2002	
  2003			uw_physical_addr += cpylen;
  2004			uw_relative_addr += cpylen;
  2005			words_num -= cpylen;
  2006		}
  2007	}
  2008	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
