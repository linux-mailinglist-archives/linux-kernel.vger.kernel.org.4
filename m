Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF7B690019
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 06:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBIF6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 00:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBIF6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 00:58:49 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2762B283
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 21:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675922326; x=1707458326;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3fCr1VU7POYvnA/HzyrwicWTSQxecZYLaOfcwmcSfEI=;
  b=eRbgWu598h65I7BQe5G/CaCJTIwfc18J0uPqdRshUk4Kyd6mUGforqPG
   490w2s0Kv/ZWHvrSj6KNfna3JXWbwZfeNOW8Fza+h+pdZnrPuzFiDzWU7
   EqFtRvkksh9gPtkKcy/myEr0P15dXMepimMNJBhETtLXe/m73Zr96METJ
   1uCSCU5I5OkpqZIvGqguDKBC6wuObDRO92YsZET7/4AKwAffkdRJMYR/6
   +W6DYTGjg7Kz7ouOlQuk21gTii3z91o9yeGm3Rz0MsGZRfn3TQo+BOxXz
   VHcIDxSMBbRHOVl7bt/n/aPE/+PZV4i1nwgRAD6DeAYTu53AqKiJMTkFt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="327716872"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="327716872"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 21:56:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776346201"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776346201"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2023 21:56:25 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPzuy-0004rS-1D;
        Thu, 09 Feb 2023 05:56:24 +0000
Date:   Thu, 9 Feb 2023 13:55:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/net/wireless/ath/ath11k/wow.c:661:5: warning: stack frame
 size (1072) exceeds limit (1024) in 'ath11k_wow_op_suspend'
Message-ID: <202302091310.Yd4BGcOf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0983f6bf2bfc0789b51ddf7315f644ff4da50acb
commit: 54d9469bc515dc5fcbc20eecbe19cea868b70d68 fortify: Add run-time WARN for cross-field memcpy()
date:   5 months ago
config: powerpc-buildonly-randconfig-r005-20230209 (https://download.01.org/0day-ci/archive/20230209/202302091310.Yd4BGcOf-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db0e6591612b53910a1b366863348bdb9d7d2fb1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=54d9469bc515dc5fcbc20eecbe19cea868b70d68
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 54d9469bc515dc5fcbc20eecbe19cea868b70d68
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/wireless/ath/ath11k/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302091310.Yd4BGcOf-lkp@intel.com

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath11k/wow.c:661:5: warning: stack frame size (1072) exceeds limit (1024) in 'ath11k_wow_op_suspend' [-Wframe-larger-than]
   int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
       ^
   364/1072 (33.96%) spills, 708/1072 (66.04%) variables
   1 warning generated.


vim +/ath11k_wow_op_suspend +661 drivers/net/wireless/ath/ath11k/wow.c

0f84a156aa3b9c Baochen Qiang 2022-05-09  660  
ba9177fcef21fa Carl Huang    2022-03-14 @661  int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
ba9177fcef21fa Carl Huang    2022-03-14  662  			  struct cfg80211_wowlan *wowlan)
ba9177fcef21fa Carl Huang    2022-03-14  663  {
ba9177fcef21fa Carl Huang    2022-03-14  664  	struct ath11k *ar = hw->priv;
ba9177fcef21fa Carl Huang    2022-03-14  665  	int ret;
ba9177fcef21fa Carl Huang    2022-03-14  666  
ba9177fcef21fa Carl Huang    2022-03-14  667  	mutex_lock(&ar->conf_mutex);
ba9177fcef21fa Carl Huang    2022-03-14  668  
90bf5c8d0f7ecd Carl Huang    2022-03-14  669  	ret = ath11k_dp_rx_pktlog_stop(ar->ab, true);
90bf5c8d0f7ecd Carl Huang    2022-03-14  670  	if (ret) {
90bf5c8d0f7ecd Carl Huang    2022-03-14  671  		ath11k_warn(ar->ab,
90bf5c8d0f7ecd Carl Huang    2022-03-14  672  			    "failed to stop dp rx (and timer) pktlog during wow suspend: %d\n",
90bf5c8d0f7ecd Carl Huang    2022-03-14  673  			    ret);
90bf5c8d0f7ecd Carl Huang    2022-03-14  674  		goto exit;
90bf5c8d0f7ecd Carl Huang    2022-03-14  675  	}
90bf5c8d0f7ecd Carl Huang    2022-03-14  676  
ba9177fcef21fa Carl Huang    2022-03-14  677  	ret =  ath11k_wow_cleanup(ar);
ba9177fcef21fa Carl Huang    2022-03-14  678  	if (ret) {
ba9177fcef21fa Carl Huang    2022-03-14  679  		ath11k_warn(ar->ab, "failed to clear wow wakeup events: %d\n",
ba9177fcef21fa Carl Huang    2022-03-14  680  			    ret);
ba9177fcef21fa Carl Huang    2022-03-14  681  		goto exit;
ba9177fcef21fa Carl Huang    2022-03-14  682  	}
ba9177fcef21fa Carl Huang    2022-03-14  683  
ba9177fcef21fa Carl Huang    2022-03-14  684  	ret = ath11k_wow_set_wakeups(ar, wowlan);
ba9177fcef21fa Carl Huang    2022-03-14  685  	if (ret) {
ba9177fcef21fa Carl Huang    2022-03-14  686  		ath11k_warn(ar->ab, "failed to set wow wakeup events: %d\n",
ba9177fcef21fa Carl Huang    2022-03-14  687  			    ret);
ba9177fcef21fa Carl Huang    2022-03-14  688  		goto cleanup;
ba9177fcef21fa Carl Huang    2022-03-14  689  	}
ba9177fcef21fa Carl Huang    2022-03-14  690  
c3c36bfe998b3a Carl Huang    2022-03-14  691  	ret = ath11k_wow_protocol_offload(ar, true);
c3c36bfe998b3a Carl Huang    2022-03-14  692  	if (ret) {
c3c36bfe998b3a Carl Huang    2022-03-14  693  		ath11k_warn(ar->ab, "failed to set wow protocol offload events: %d\n",
c3c36bfe998b3a Carl Huang    2022-03-14  694  			    ret);
c3c36bfe998b3a Carl Huang    2022-03-14  695  		goto cleanup;
c3c36bfe998b3a Carl Huang    2022-03-14  696  	}
c3c36bfe998b3a Carl Huang    2022-03-14  697  
c3c36bfe998b3a Carl Huang    2022-03-14  698  	ath11k_mac_drain_tx(ar);
ba9177fcef21fa Carl Huang    2022-03-14  699  	ret = ath11k_mac_wait_tx_complete(ar);
ba9177fcef21fa Carl Huang    2022-03-14  700  	if (ret) {
ba9177fcef21fa Carl Huang    2022-03-14  701  		ath11k_warn(ar->ab, "failed to wait tx complete: %d\n", ret);
ba9177fcef21fa Carl Huang    2022-03-14  702  		goto cleanup;
ba9177fcef21fa Carl Huang    2022-03-14  703  	}
ba9177fcef21fa Carl Huang    2022-03-14  704  
c417b247ba0421 Carl Huang    2022-03-14  705  	ret = ath11k_wow_set_hw_filter(ar);
c417b247ba0421 Carl Huang    2022-03-14  706  	if (ret) {
c417b247ba0421 Carl Huang    2022-03-14  707  		ath11k_warn(ar->ab, "failed to set hw filter: %d\n",
c417b247ba0421 Carl Huang    2022-03-14  708  			    ret);
c417b247ba0421 Carl Huang    2022-03-14  709  		goto cleanup;
c417b247ba0421 Carl Huang    2022-03-14  710  	}
c417b247ba0421 Carl Huang    2022-03-14  711  
0f84a156aa3b9c Baochen Qiang 2022-05-09  712  	ret = ath11k_wow_set_keepalive(ar,
0f84a156aa3b9c Baochen Qiang 2022-05-09  713  				       WMI_STA_KEEPALIVE_METHOD_NULL_FRAME,
0f84a156aa3b9c Baochen Qiang 2022-05-09  714  				       WMI_STA_KEEPALIVE_INTERVAL_DEFAULT);
0f84a156aa3b9c Baochen Qiang 2022-05-09  715  	if (ret) {
0f84a156aa3b9c Baochen Qiang 2022-05-09  716  		ath11k_warn(ar->ab, "failed to enable wow keepalive: %d\n", ret);
0f84a156aa3b9c Baochen Qiang 2022-05-09  717  		goto cleanup;
0f84a156aa3b9c Baochen Qiang 2022-05-09  718  	}
0f84a156aa3b9c Baochen Qiang 2022-05-09  719  
ba9177fcef21fa Carl Huang    2022-03-14  720  	ret = ath11k_wow_enable(ar->ab);
ba9177fcef21fa Carl Huang    2022-03-14  721  	if (ret) {
ba9177fcef21fa Carl Huang    2022-03-14  722  		ath11k_warn(ar->ab, "failed to start wow: %d\n", ret);
ba9177fcef21fa Carl Huang    2022-03-14  723  		goto cleanup;
ba9177fcef21fa Carl Huang    2022-03-14  724  	}
ba9177fcef21fa Carl Huang    2022-03-14  725  
90bf5c8d0f7ecd Carl Huang    2022-03-14  726  	ret = ath11k_dp_rx_pktlog_stop(ar->ab, false);
90bf5c8d0f7ecd Carl Huang    2022-03-14  727  	if (ret) {
90bf5c8d0f7ecd Carl Huang    2022-03-14  728  		ath11k_warn(ar->ab,
90bf5c8d0f7ecd Carl Huang    2022-03-14  729  			    "failed to stop dp rx pktlog during wow suspend: %d\n",
90bf5c8d0f7ecd Carl Huang    2022-03-14  730  			    ret);
90bf5c8d0f7ecd Carl Huang    2022-03-14  731  		goto cleanup;
90bf5c8d0f7ecd Carl Huang    2022-03-14  732  	}
90bf5c8d0f7ecd Carl Huang    2022-03-14  733  
ba9177fcef21fa Carl Huang    2022-03-14  734  	ath11k_ce_stop_shadow_timers(ar->ab);
ba9177fcef21fa Carl Huang    2022-03-14  735  	ath11k_dp_stop_shadow_timers(ar->ab);
ba9177fcef21fa Carl Huang    2022-03-14  736  
ba9177fcef21fa Carl Huang    2022-03-14  737  	ath11k_hif_irq_disable(ar->ab);
ba9177fcef21fa Carl Huang    2022-03-14  738  	ath11k_hif_ce_irq_disable(ar->ab);
ba9177fcef21fa Carl Huang    2022-03-14  739  
ba9177fcef21fa Carl Huang    2022-03-14  740  	ret = ath11k_hif_suspend(ar->ab);
ba9177fcef21fa Carl Huang    2022-03-14  741  	if (ret) {
ba9177fcef21fa Carl Huang    2022-03-14  742  		ath11k_warn(ar->ab, "failed to suspend hif: %d\n", ret);
ba9177fcef21fa Carl Huang    2022-03-14  743  		goto wakeup;
ba9177fcef21fa Carl Huang    2022-03-14  744  	}
ba9177fcef21fa Carl Huang    2022-03-14  745  
ba9177fcef21fa Carl Huang    2022-03-14  746  	goto exit;
ba9177fcef21fa Carl Huang    2022-03-14  747  
ba9177fcef21fa Carl Huang    2022-03-14  748  wakeup:
ba9177fcef21fa Carl Huang    2022-03-14  749  	ath11k_wow_wakeup(ar->ab);
ba9177fcef21fa Carl Huang    2022-03-14  750  
ba9177fcef21fa Carl Huang    2022-03-14  751  cleanup:
ba9177fcef21fa Carl Huang    2022-03-14  752  	ath11k_wow_cleanup(ar);
ba9177fcef21fa Carl Huang    2022-03-14  753  
ba9177fcef21fa Carl Huang    2022-03-14  754  exit:
ba9177fcef21fa Carl Huang    2022-03-14  755  	mutex_unlock(&ar->conf_mutex);
ba9177fcef21fa Carl Huang    2022-03-14  756  	return ret ? 1 : 0;
ba9177fcef21fa Carl Huang    2022-03-14  757  }
ba9177fcef21fa Carl Huang    2022-03-14  758  

:::::: The code at line 661 was first introduced by commit
:::::: ba9177fcef21fa98406e73c472b5ac2eb4ec5f31 ath11k: Add basic WoW functionalities

:::::: TO: Carl Huang <quic_cjhuang@quicinc.com>
:::::: CC: Kalle Valo <quic_kvalo@quicinc.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
