Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551D768F8E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjBHUeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjBHUeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:34:19 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4623A45F5F;
        Wed,  8 Feb 2023 12:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675888457; x=1707424457;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EiLV5C5hfZ7ru6mtuvilAQxOS5kBtr8bSCq1tGwpMAs=;
  b=C172EDYZxGWa9DenWYibXPK/ot9znWAMqykeVfiYTE+GBo2LEL07zBnp
   euwazPc6cPJ8Y7YzcRW85gnMtlmkIXV9Ys7QhDkZMHHBSxO1OXxyoiJWE
   aP/t7MF+VyDoiwc4nIi/RyQuCu9izH1dpgb0hRxn/HYvBdpdhQpnEDfuk
   p5YBFRHejd0zcJdSzi5BssbKBDetYH7KLv23sjAj8JK9Yv5mJRvpS6qdK
   3yQrvvFT0EPqvFSzcqn+IpvGc6C7kvrfEnFDRWMbE0yoqYBVxgsbbJpeH
   lNH8boPxLcEMEruk7qPtmmOia4ic01AdBjwAhcmyVuhXgVCcecGueR6jb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="313553162"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="313553162"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 12:34:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="660773062"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="660773062"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Feb 2023 12:34:13 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPr8u-0004dK-1O;
        Wed, 08 Feb 2023 20:34:12 +0000
Date:   Thu, 9 Feb 2023 04:33:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/media/v4l2-core/v4l2-vp9.c:1834:1: warning: the frame size
 of 1420 bytes is larger than 1024 bytes
Message-ID: <202302090432.XljBsk1B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0983f6bf2bfc0789b51ddf7315f644ff4da50acb
commit: f25709c4ff151fbc7dc2e0b7cf5962767a093f68 media: rkvdec: Add the VP9 backend
date:   1 year, 3 months ago
config: csky-buildonly-randconfig-r002-20230209 (https://download.01.org/0day-ci/archive/20230209/202302090432.XljBsk1B-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f25709c4ff151fbc7dc2e0b7cf5962767a093f68
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f25709c4ff151fbc7dc2e0b7cf5962767a093f68
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash drivers/media/v4l2-core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302090432.XljBsk1B-lkp@intel.com

All warnings (new ones prefixed by >>):

   drivers/media/v4l2-core/v4l2-vp9.c: In function 'v4l2_vp9_adapt_noncoef_probs':
>> drivers/media/v4l2-core/v4l2-vp9.c:1834:1: warning: the frame size of 1420 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1834 | }
         | ^


vim +1834 drivers/media/v4l2-core/v4l2-vp9.c

3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1757  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1758  /* 8.4.4 Non coefficient probability adaptation process */
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1759  void v4l2_vp9_adapt_noncoef_probs(struct v4l2_vp9_frame_context *probs,
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1760  				  struct v4l2_vp9_frame_symbol_counts *counts,
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1761  				  u8 reference_mode, u8 interpolation_filter, u8 tx_mode,
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1762  				  u32 flags)
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1763  {
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1764  	unsigned int i, j;
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1765  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1766  	for (i = 0; i < ARRAY_SIZE(probs->is_inter); i++)
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1767  		probs->is_inter[i] = adapt_prob(probs->is_inter[i], (*counts->intra_inter)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1768  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1769  	for (i = 0; i < ARRAY_SIZE(probs->comp_mode); i++)
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1770  		probs->comp_mode[i] = adapt_prob(probs->comp_mode[i], (*counts->comp)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1771  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1772  	for (i = 0; i < ARRAY_SIZE(probs->comp_ref); i++)
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1773  		probs->comp_ref[i] = adapt_prob(probs->comp_ref[i], (*counts->comp_ref)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1774  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1775  	if (reference_mode != V4L2_VP9_REFERENCE_MODE_COMPOUND_REFERENCE)
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1776  		for (i = 0; i < ARRAY_SIZE(probs->single_ref); i++)
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1777  			for (j = 0; j < ARRAY_SIZE(probs->single_ref[0]); j++)
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1778  				probs->single_ref[i][j] = adapt_prob(probs->single_ref[i][j],
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1779  								     (*counts->single_ref)[i][j]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1780  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1781  	for (i = 0; i < ARRAY_SIZE(probs->inter_mode); i++)
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1782  		adapt_probs_variant_c(probs->inter_mode[i], (*counts->mv_mode)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1783  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1784  	for (i = 0; i < ARRAY_SIZE(probs->y_mode); i++)
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1785  		adapt_probs_variant_d(probs->y_mode[i], (*counts->y_mode)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1786  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1787  	for (i = 0; i < ARRAY_SIZE(probs->uv_mode); i++)
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1788  		adapt_probs_variant_d(probs->uv_mode[i], (*counts->uv_mode)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1789  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1790  	for (i = 0; i < ARRAY_SIZE(probs->partition); i++)
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1791  		adapt_probs_variant_e(probs->partition[i], (*counts->partition)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1792  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1793  	for (i = 0; i < ARRAY_SIZE(probs->skip); i++)
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1794  		probs->skip[i] = adapt_prob(probs->skip[i], (*counts->skip)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1795  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1796  	if (interpolation_filter == V4L2_VP9_INTERP_FILTER_SWITCHABLE)
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1797  		for (i = 0; i < ARRAY_SIZE(probs->interp_filter); i++)
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1798  			adapt_probs_variant_f(probs->interp_filter[i], (*counts->filter)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1799  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1800  	if (tx_mode == V4L2_VP9_TX_MODE_SELECT)
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1801  		for (i = 0; i < ARRAY_SIZE(probs->tx8); i++) {
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1802  			adapt_probs_variant_b(probs->tx8[i], (*counts->tx8p)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1803  			adapt_probs_variant_f(probs->tx16[i], (*counts->tx16p)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1804  			adapt_probs_variant_e(probs->tx32[i], (*counts->tx32p)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1805  		}
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1806  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1807  	adapt_probs_variant_e(probs->mv.joint, *counts->mv_joint);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1808  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1809  	for (i = 0; i < ARRAY_SIZE(probs->mv.sign); i++) {
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1810  		probs->mv.sign[i] = adapt_prob(probs->mv.sign[i], (*counts->sign)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1811  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1812  		adapt_probs_variant_g(probs->mv.classes[i], (*counts->classes)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1813  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1814  		probs->mv.class0_bit[i] = adapt_prob(probs->mv.class0_bit[i], (*counts->class0)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1815  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1816  		for (j = 0; j < ARRAY_SIZE(probs->mv.bits[0]); j++)
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1817  			probs->mv.bits[i][j] = adapt_prob(probs->mv.bits[i][j],
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1818  							  (*counts->bits)[i][j]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1819  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1820  		for (j = 0; j < ARRAY_SIZE(probs->mv.class0_fr[0]); j++)
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1821  			adapt_probs_variant_e(probs->mv.class0_fr[i][j],
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1822  					      (*counts->class0_fp)[i][j]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1823  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1824  		adapt_probs_variant_e(probs->mv.fr[i], (*counts->fp)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1825  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1826  		if (!(flags & V4L2_VP9_FRAME_FLAG_ALLOW_HIGH_PREC_MV))
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1827  			continue;
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1828  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1829  		probs->mv.class0_hp[i] = adapt_prob(probs->mv.class0_hp[i],
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1830  						    (*counts->class0_hp)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1831  
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1832  		probs->mv.hp[i] = adapt_prob(probs->mv.hp[i], (*counts->hp)[i]);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1833  	}
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16 @1834  }
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1835  EXPORT_SYMBOL_GPL(v4l2_vp9_adapt_noncoef_probs);
3e3b1fb0e5d95c0 Andrzej Pietrasiewicz 2021-11-16  1836  

:::::: The code at line 1834 was first introduced by commit
:::::: 3e3b1fb0e5d95c0cd7278717185ca3fb00f5d771 media: Add VP9 v4l2 library

:::::: TO: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
:::::: CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
