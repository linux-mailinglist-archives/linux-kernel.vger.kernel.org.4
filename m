Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3401772848C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjFHQEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjFHQDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:03:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6296230F2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686240210; x=1717776210;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kqOhsreBM5uqjYnGz+0mWBDgpXll9fC6YeT1wcamJHc=;
  b=iIvRFG6iIztjfUAM2IyI12PxedNTvUK1IY7FnBSLQPz+SO3XxHjZyxGI
   0h5KL2Nawh74t4vUSp3a29Gfr2LZ5ZxOwZq8q/FyRMsAO5ZjIhx6eH864
   mkVMaw7qh3Eevb0znV3u8LBT6ByU47Oc0ZBxvE098HoSUZvHSvWiYcG5K
   bQuoSWHUIzwwsZxJ4AawH9mRTm4N0uV6lwX7SazGfcIuZCab0T2BbiIPB
   Nl1FCWyqLSuyeiXdBBRrZoNiGzwbfmJ/v4iykma5IkK5dVSQ8EF12rQAf
   IOV9Bs5YagWFOiAapibMqD5Iq292aWh1XlX7yNj71ouB4CnynsHDeT0vn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="336983747"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="336983747"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 09:03:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="884248605"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="884248605"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2023 09:03:26 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7I6e-00080s-0J;
        Thu, 08 Jun 2023 16:03:24 +0000
Date:   Fri, 9 Jun 2023 00:02:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>
Subject: drivers/gpu/drm/drm_edid.c:6150:13: warning: stack frame size (2928)
 exceeds limit (2048) in 'drm_parse_cea_ext'
Message-ID: <202306082341.ZzRYSSEX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f63595ebd82f56a2dd36ca013dd7f5ff2e2416a
commit: e1e7bc481d49c3e3ada11029ce0d9b85a0a539d7 drm/edid: convert to device specific logging
date:   8 months ago
config: riscv-randconfig-r012-20230608 (https://download.01.org/0day-ci/archive/20230608/202306082341.ZzRYSSEX-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e1e7bc481d49c3e3ada11029ce0d9b85a0a539d7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e1e7bc481d49c3e3ada11029ce0d9b85a0a539d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/ fs/f2fs/ kernel/bpf/ lib/zstd/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306082341.ZzRYSSEX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_edid.c:6150:13: warning: stack frame size (2928) exceeds limit (2048) in 'drm_parse_cea_ext' [-Wframe-larger-than]
   static void drm_parse_cea_ext(struct drm_connector *connector,
               ^
   1 warning generated.


vim +/drm_parse_cea_ext +6150 drivers/gpu/drm/drm_edid.c

2869f599c0d8c9 Philipp Zabel 2022-01-23  6149  
1cea146a806ae1 Ville Syrjälä 2016-09-28 @6150  static void drm_parse_cea_ext(struct drm_connector *connector,
e42192b4c345a8 Jani Nikula   2022-05-11  6151  			      const struct drm_edid *drm_edid)
1cea146a806ae1 Ville Syrjälä 2016-09-28  6152  {
1cea146a806ae1 Ville Syrjälä 2016-09-28  6153  	struct drm_display_info *info = &connector->display_info;
8db73897698ccb Jani Nikula   2022-05-05  6154  	struct drm_edid_iter edid_iter;
dfc0312596561a Jani Nikula   2022-05-03  6155  	const struct cea_db *db;
dfc0312596561a Jani Nikula   2022-05-03  6156  	struct cea_db_iter iter;
1cea146a806ae1 Ville Syrjälä 2016-09-28  6157  	const u8 *edid_ext;
1cea146a806ae1 Ville Syrjälä 2016-09-28  6158  
bbded689680f0f Jani Nikula   2022-05-09  6159  	drm_edid_iter_begin(drm_edid, &edid_iter);
8db73897698ccb Jani Nikula   2022-05-05  6160  	drm_edid_iter_for_each(edid_ext, &edid_iter) {
8db73897698ccb Jani Nikula   2022-05-05  6161  		if (edid_ext[0] != CEA_EXT)
8db73897698ccb Jani Nikula   2022-05-05  6162  			continue;
1cea146a806ae1 Ville Syrjälä 2016-09-28  6163  
8db73897698ccb Jani Nikula   2022-05-05  6164  		if (!info->cea_rev)
1cea146a806ae1 Ville Syrjälä 2016-09-28  6165  			info->cea_rev = edid_ext[1];
1cea146a806ae1 Ville Syrjälä 2016-09-28  6166  
8db73897698ccb Jani Nikula   2022-05-05  6167  		if (info->cea_rev != edid_ext[1])
e1e7bc481d49c3 Jani Nikula   2022-10-24  6168  			drm_dbg_kms(connector->dev,
e1e7bc481d49c3 Jani Nikula   2022-10-24  6169  				    "[CONNECTOR:%d:%s] CEA extension version mismatch %u != %u\n",
e1e7bc481d49c3 Jani Nikula   2022-10-24  6170  				    connector->base.id, connector->name,
8db73897698ccb Jani Nikula   2022-05-05  6171  				    info->cea_rev, edid_ext[1]);
7344bad7fb6daa Jani Nikula   2022-03-23  6172  
8db73897698ccb Jani Nikula   2022-05-05  6173  		/* The existence of a CTA extension should imply RGB support */
8db73897698ccb Jani Nikula   2022-05-05  6174  		info->color_formats = DRM_COLOR_FORMAT_RGB444;
1cea146a806ae1 Ville Syrjälä 2016-09-28  6175  		if (edid_ext[3] & EDID_CEA_YCRCB444)
c03d0b52ff71d5 Maxime Ripard 2022-01-20  6176  			info->color_formats |= DRM_COLOR_FORMAT_YCBCR444;
1cea146a806ae1 Ville Syrjälä 2016-09-28  6177  		if (edid_ext[3] & EDID_CEA_YCRCB422)
c03d0b52ff71d5 Maxime Ripard 2022-01-20  6178  			info->color_formats |= DRM_COLOR_FORMAT_YCBCR422;
7344bad7fb6daa Jani Nikula   2022-03-23  6179  	}
8db73897698ccb Jani Nikula   2022-05-05  6180  	drm_edid_iter_end(&edid_iter);
1cea146a806ae1 Ville Syrjälä 2016-09-28  6181  
5e87b2e5171621 Jani Nikula   2022-05-09  6182  	cea_db_iter_edid_begin(drm_edid, &iter);
dfc0312596561a Jani Nikula   2022-05-03  6183  	cea_db_iter_for_each(db, &iter) {
dfc0312596561a Jani Nikula   2022-05-03  6184  		/* FIXME: convert parsers to use struct cea_db */
dfc0312596561a Jani Nikula   2022-05-03  6185  		const u8 *data = (const u8 *)db;
1cea146a806ae1 Ville Syrjälä 2016-09-28  6186  
23ebf8b9eab915 Ville Syrjälä 2016-09-28  6187  		if (cea_db_is_hdmi_vsdb(db))
dfc0312596561a Jani Nikula   2022-05-03  6188  			drm_parse_hdmi_vsdb_video(connector, data);
be982415fc2e95 Jani Nikula   2022-05-09  6189  		else if (cea_db_is_hdmi_forum_vsdb(db) ||
115fcf5899f7e0 Lee Shawn C   2022-05-03  6190  			 cea_db_is_hdmi_forum_scdb(db))
dfc0312596561a Jani Nikula   2022-05-03  6191  			drm_parse_hdmi_forum_scds(connector, data);
be982415fc2e95 Jani Nikula   2022-05-09  6192  		else if (cea_db_is_microsoft_vsdb(db))
dfc0312596561a Jani Nikula   2022-05-03  6193  			drm_parse_microsoft_vsdb(connector, data);
be982415fc2e95 Jani Nikula   2022-05-09  6194  		else if (cea_db_is_y420cmdb(db))
dfc0312596561a Jani Nikula   2022-05-03  6195  			drm_parse_y420cmdb_bitmap(connector, data);
be982415fc2e95 Jani Nikula   2022-05-09  6196  		else if (cea_db_is_vcdb(db))
dfc0312596561a Jani Nikula   2022-05-03  6197  			drm_parse_vcdb(connector, data);
be982415fc2e95 Jani Nikula   2022-05-09  6198  		else if (cea_db_is_hdmi_hdr_metadata_block(db))
dfc0312596561a Jani Nikula   2022-05-03  6199  			drm_parse_hdr_metadata_block(connector, data);
1cea146a806ae1 Ville Syrjälä 2016-09-28  6200  	}
dfc0312596561a Jani Nikula   2022-05-03  6201  	cea_db_iter_end(&iter);
d0c94692e0a360 Mario Kleiner 2014-03-27  6202  }
d0c94692e0a360 Mario Kleiner 2014-03-27  6203  

:::::: The code at line 6150 was first introduced by commit
:::::: 1cea146a806ae1f34cb1b5e3206ff63a2bb90782 drm/edid: Reduce the number of times we parse the CEA extension block

:::::: TO: Ville Syrjälä <ville.syrjala@linux.intel.com>
:::::: CC: Daniel Vetter <daniel.vetter@ffwll.ch>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
