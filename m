Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453B26FFF89
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 06:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbjELEJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 00:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjELEJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 00:09:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910FF4690;
        Thu, 11 May 2023 21:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683864580; x=1715400580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fcbUHHCvv27Z7cvBWPO4g48FuQrn51hib5BzUZ0vb0w=;
  b=MumyJsM5ZswYTvuQPKCPX3mSWtNcwEkQS+trNEmRUB2FWDflbQzxQ6pR
   7FFh175G1q+VxoJNWNo+JLrOErXpyTXALQZ8N8sRy9s4KflONWTmjNPE6
   K+UJ0Fwuiu5fYcgQBkOmpK9FS8N1AfDyYihp1c7Cueo+YnSbQCP/xIaFU
   kwNupuPQC5CFqTKAbjpz4mbSqJpi5EEQJ5Lnd93GolVIyp1De0rVAGrZZ
   lnxcjCSVGeM/7yKRT+tUkqeifbevH9J2y6uS1kWP8J5WzAtQ506Is6lUb
   jCOrDLYLCguOTR3OfVsgriplisTg0JGJ9avaqnGhvTlunqsERVxDl2ulA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="414062344"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="414062344"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 21:09:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="694077288"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="694077288"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 May 2023 21:09:36 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxK63-0004UI-0U;
        Fri, 12 May 2023 04:09:35 +0000
Date:   Fri, 12 May 2023 12:09:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        martin.petersen@oracle.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-scsi@vger.kernel.org,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/7] ufs: mcq: Add support for clean up mcq resources
Message-ID: <202305121123.KOfhO8tv-lkp@intel.com>
References: <33fe3d5bd6223d0ca1b5002efb7efc7bb90f3495.1683841772.git.quic_nguyenb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33fe3d5bd6223d0ca1b5002efb7efc7bb90f3495.1683841772.git.quic_nguyenb@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jejb-scsi/for-next]
[also build test WARNING on mkp-scsi/for-next linus/master v6.4-rc1 next-20230511]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bao-D-Nguyen/ufs-core-Combine-32-bit-command_desc_base_addr_lo-hi/20230512-060009
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
patch link:    https://lore.kernel.org/r/33fe3d5bd6223d0ca1b5002efb7efc7bb90f3495.1683841772.git.quic_nguyenb%40quicinc.com
patch subject: [PATCH v4 4/7] ufs: mcq: Add support for clean up mcq resources
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20230512/202305121123.KOfhO8tv-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e05a8eb3fd257b04965c2333d4bf0161177ef504
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bao-D-Nguyen/ufs-core-Combine-32-bit-command_desc_base_addr_lo-hi/20230512-060009
        git checkout e05a8eb3fd257b04965c2333d4bf0161177ef504
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/ufs/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305121123.KOfhO8tv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/ufs/core/ufshcd.c:7526:32: warning: variable 'reg' is uninitialized when used here [-Wuninitialized]
           if (!is_mcq_enabled(hba) && !(reg & (1 << tag))) {
                                         ^~~
   drivers/ufs/core/ufshcd.c:7489:9: note: initialize the variable 'reg' to silence this warning
           u32 reg;
                  ^
                   = 0
   1 warning generated.


vim +/reg +7526 drivers/ufs/core/ufshcd.c

  7473	
  7474	/**
  7475	 * ufshcd_abort - scsi host template eh_abort_handler callback
  7476	 * @cmd: SCSI command pointer
  7477	 *
  7478	 * Returns SUCCESS/FAILED
  7479	 */
  7480	static int ufshcd_abort(struct scsi_cmnd *cmd)
  7481	{
  7482		struct Scsi_Host *host = cmd->device->host;
  7483		struct ufs_hba *hba = shost_priv(host);
  7484		int tag = scsi_cmd_to_rq(cmd)->tag;
  7485		struct ufshcd_lrb *lrbp = &hba->lrb[tag];
  7486		unsigned long flags;
  7487		int err = FAILED;
  7488		bool outstanding;
  7489		u32 reg;
  7490	
  7491		WARN_ONCE(tag < 0, "Invalid tag %d\n", tag);
  7492	
  7493		ufshcd_hold(hba, false);
  7494	
  7495		if (!is_mcq_enabled(hba) && !test_bit(tag, &hba->outstanding_reqs)) {
  7496			reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
  7497			/* If command is already aborted/completed, return FAILED. */
  7498			dev_err(hba->dev,
  7499				"%s: cmd at tag %d already completed, outstanding=0x%lx, doorbell=0x%x\n",
  7500				__func__, tag, hba->outstanding_reqs, reg);
  7501			goto release;
  7502		}
  7503	
  7504		/* Print Transfer Request of aborted task */
  7505		dev_info(hba->dev, "%s: Device abort task at tag %d\n", __func__, tag);
  7506	
  7507		/*
  7508		 * Print detailed info about aborted request.
  7509		 * As more than one request might get aborted at the same time,
  7510		 * print full information only for the first aborted request in order
  7511		 * to reduce repeated printouts. For other aborted requests only print
  7512		 * basic details.
  7513		 */
  7514		scsi_print_command(cmd);
  7515		if (!hba->req_abort_count) {
  7516			ufshcd_update_evt_hist(hba, UFS_EVT_ABORT, tag);
  7517			ufshcd_print_evt_hist(hba);
  7518			ufshcd_print_host_state(hba);
  7519			ufshcd_print_pwr_info(hba);
  7520			ufshcd_print_tr(hba, tag, true);
  7521		} else {
  7522			ufshcd_print_tr(hba, tag, false);
  7523		}
  7524		hba->req_abort_count++;
  7525	
> 7526		if (!is_mcq_enabled(hba) && !(reg & (1 << tag))) {
  7527			/* only execute this code in single doorbell mode */
  7528			dev_err(hba->dev,
  7529			"%s: cmd was completed, but without a notifying intr, tag = %d",
  7530			__func__, tag);
  7531			__ufshcd_transfer_req_compl(hba, 1UL << tag);
  7532			goto release;
  7533		}
  7534	
  7535		/*
  7536		 * Task abort to the device W-LUN is illegal. When this command
  7537		 * will fail, due to spec violation, scsi err handling next step
  7538		 * will be to send LU reset which, again, is a spec violation.
  7539		 * To avoid these unnecessary/illegal steps, first we clean up
  7540		 * the lrb taken by this cmd and re-set it in outstanding_reqs,
  7541		 * then queue the eh_work and bail.
  7542		 */
  7543		if (lrbp->lun == UFS_UPIU_UFS_DEVICE_WLUN) {
  7544			ufshcd_update_evt_hist(hba, UFS_EVT_ABORT, lrbp->lun);
  7545	
  7546			spin_lock_irqsave(host->host_lock, flags);
  7547			hba->force_reset = true;
  7548			ufshcd_schedule_eh_work(hba);
  7549			spin_unlock_irqrestore(host->host_lock, flags);
  7550			goto release;
  7551		}
  7552	
  7553		/* Skip task abort in case previous aborts failed and report failure */
  7554		if (lrbp->req_abort_skip) {
  7555			dev_err(hba->dev, "%s: skipping abort\n", __func__);
  7556			ufshcd_set_req_abort_skip(hba, hba->outstanding_reqs);
  7557			goto release;
  7558		}
  7559	
  7560		err = ufshcd_try_to_abort_task(hba, tag);
  7561		if (err) {
  7562			dev_err(hba->dev, "%s: failed with err %d\n", __func__, err);
  7563			ufshcd_set_req_abort_skip(hba, hba->outstanding_reqs);
  7564			err = FAILED;
  7565			goto release;
  7566		}
  7567	
  7568		/*
  7569		 * Clear the corresponding bit from outstanding_reqs since the command
  7570		 * has been aborted successfully.
  7571		 */
  7572		spin_lock_irqsave(&hba->outstanding_lock, flags);
  7573		outstanding = __test_and_clear_bit(tag, &hba->outstanding_reqs);
  7574		spin_unlock_irqrestore(&hba->outstanding_lock, flags);
  7575	
  7576		if (outstanding)
  7577			ufshcd_release_scsi_cmd(hba, lrbp);
  7578	
  7579		err = SUCCESS;
  7580	
  7581	release:
  7582		/* Matches the ufshcd_hold() call at the start of this function. */
  7583		ufshcd_release(hba);
  7584		return err;
  7585	}
  7586	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
