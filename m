Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BB46EDE43
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjDYIig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjDYIiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:38:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6FC14F61;
        Tue, 25 Apr 2023 01:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682411762; x=1713947762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vFBTtSGo4RJIa5bAoyrilb4W2kFbR/q028Dr+BiFmtQ=;
  b=GdZlrUfR4Xl3Mcp51yLhfH7rsM50BZtaV4BWLa038C03kLoXNZNzWJ69
   hhqVukBIAPE552CZdXUb5k4kZZgLO9tc5SGwM/F/YQ8BhpFycksP96rKV
   F9e+kKM9bRjvGz9kkH9oPl+IQHyM9drYud8we/AYBpEdzLhms2BSX7SWf
   EFHTdjfrnD3HNc66PYqtXhZ+yJ3HYRSbRRZJLXIiqs0/5dD4rLXyN2B/B
   Fz1uJZwJI3gM5KVIYXmB3Gph9NKxJ7ibA+/GV/Emt76wRKmSe9BzHlaeR
   r/EqLvxeRG9LoraSgORlVUDW5FO1eHd6xDmowBjevBx4ALBgLz7NR+/nF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="374646872"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="374646872"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 01:34:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="782754348"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="782754348"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Apr 2023 01:34:27 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prE82-000jDO-0m;
        Tue, 25 Apr 2023 08:34:26 +0000
Date:   Tue, 25 Apr 2023 16:34:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     oe-kbuild-all@lists.linux.dev, bblock@linux.ibm.com,
        acelan.kao@canonical.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata: Defer rescan on suspended device
Message-ID: <202304251654.BnZBfauy-lkp@intel.com>
References: <20230425061746.503145-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425061746.503145-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.3 next-20230424]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kai-Heng-Feng/ata-libata-Defer-rescan-on-suspended-device/20230425-142001
base:   linus/master
patch link:    https://lore.kernel.org/r/20230425061746.503145-1-kai.heng.feng%40canonical.com
patch subject: [PATCH v2] ata: libata: Defer rescan on suspended device
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230425/202304251654.BnZBfauy-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bed073367820f7e00147a8f39ed5f0d9d5eb6c67
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kai-Heng-Feng/ata-libata-Defer-rescan-on-suspended-device/20230425-142001
        git checkout bed073367820f7e00147a8f39ed5f0d9d5eb6c67
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304251654.BnZBfauy-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/ata/libata-eh.c: In function 'ata_eh_revalidate_and_attach':
>> drivers/ata/libata-eh.c:2991:29: error: 'pm_suspend_target_state' undeclared (first use in this function); did you mean 'scsi_target_state'?
    2991 |                         if (pm_suspend_target_state != PM_SUSPEND_ON)
         |                             ^~~~~~~~~~~~~~~~~~~~~~~
         |                             scsi_target_state
   drivers/ata/libata-eh.c:2991:29: note: each undeclared identifier is reported only once for each function it appears in


vim +2991 drivers/ata/libata-eh.c

  2927	
  2928	static int ata_eh_revalidate_and_attach(struct ata_link *link,
  2929						struct ata_device **r_failed_dev)
  2930	{
  2931		struct ata_port *ap = link->ap;
  2932		struct ata_eh_context *ehc = &link->eh_context;
  2933		struct ata_device *dev;
  2934		unsigned int new_mask = 0;
  2935		unsigned long flags;
  2936		int rc = 0;
  2937	
  2938		/* For PATA drive side cable detection to work, IDENTIFY must
  2939		 * be done backwards such that PDIAG- is released by the slave
  2940		 * device before the master device is identified.
  2941		 */
  2942		ata_for_each_dev(dev, link, ALL_REVERSE) {
  2943			unsigned int action = ata_eh_dev_action(dev);
  2944			unsigned int readid_flags = 0;
  2945	
  2946			if (ehc->i.flags & ATA_EHI_DID_RESET)
  2947				readid_flags |= ATA_READID_POSTRESET;
  2948	
  2949			if ((action & ATA_EH_REVALIDATE) && ata_dev_enabled(dev)) {
  2950				WARN_ON(dev->class == ATA_DEV_PMP);
  2951	
  2952				/*
  2953				 * The link may be in a deep sleep, wake it up.
  2954				 *
  2955				 * If the link is in deep sleep, ata_phys_link_offline()
  2956				 * will return true, causing the revalidation to fail,
  2957				 * which leads to a (potentially) needless hard reset.
  2958				 *
  2959				 * ata_eh_recover() will later restore the link policy
  2960				 * to ap->target_lpm_policy after revalidation is done.
  2961				 */
  2962				if (link->lpm_policy > ATA_LPM_MAX_POWER) {
  2963					rc = ata_eh_set_lpm(link, ATA_LPM_MAX_POWER,
  2964							    r_failed_dev);
  2965					if (rc)
  2966						goto err;
  2967				}
  2968	
  2969				if (ata_phys_link_offline(ata_dev_phys_link(dev))) {
  2970					rc = -EIO;
  2971					goto err;
  2972				}
  2973	
  2974				ata_eh_about_to_do(link, dev, ATA_EH_REVALIDATE);
  2975				rc = ata_dev_revalidate(dev, ehc->classes[dev->devno],
  2976							readid_flags);
  2977				if (rc)
  2978					goto err;
  2979	
  2980				ata_eh_done(link, dev, ATA_EH_REVALIDATE);
  2981	
  2982				/* Configuration may have changed, reconfigure
  2983				 * transfer mode.
  2984				 */
  2985				ehc->i.flags |= ATA_EHI_SETMODE;
  2986	
  2987				/* Schedule the scsi_rescan_device() here.
  2988				 * Defer the rescan if it's in process of
  2989				 * suspending or resuming.
  2990				 */
> 2991				if (pm_suspend_target_state != PM_SUSPEND_ON)
  2992					ap->pflags |= ATA_PFLAG_DEFER_RESCAN;
  2993				else
  2994					schedule_work(&(ap->scsi_rescan_task));
  2995			} else if (dev->class == ATA_DEV_UNKNOWN &&
  2996				   ehc->tries[dev->devno] &&
  2997				   ata_class_enabled(ehc->classes[dev->devno])) {
  2998				/* Temporarily set dev->class, it will be
  2999				 * permanently set once all configurations are
  3000				 * complete.  This is necessary because new
  3001				 * device configuration is done in two
  3002				 * separate loops.
  3003				 */
  3004				dev->class = ehc->classes[dev->devno];
  3005	
  3006				if (dev->class == ATA_DEV_PMP)
  3007					rc = sata_pmp_attach(dev);
  3008				else
  3009					rc = ata_dev_read_id(dev, &dev->class,
  3010							     readid_flags, dev->id);
  3011	
  3012				/* read_id might have changed class, store and reset */
  3013				ehc->classes[dev->devno] = dev->class;
  3014				dev->class = ATA_DEV_UNKNOWN;
  3015	
  3016				switch (rc) {
  3017				case 0:
  3018					/* clear error info accumulated during probe */
  3019					ata_ering_clear(&dev->ering);
  3020					new_mask |= 1 << dev->devno;
  3021					break;
  3022				case -ENOENT:
  3023					/* IDENTIFY was issued to non-existent
  3024					 * device.  No need to reset.  Just
  3025					 * thaw and ignore the device.
  3026					 */
  3027					ata_eh_thaw_port(ap);
  3028					break;
  3029				default:
  3030					goto err;
  3031				}
  3032			}
  3033		}
  3034	
  3035		/* PDIAG- should have been released, ask cable type if post-reset */
  3036		if ((ehc->i.flags & ATA_EHI_DID_RESET) && ata_is_host_link(link)) {
  3037			if (ap->ops->cable_detect)
  3038				ap->cbl = ap->ops->cable_detect(ap);
  3039			ata_force_cbl(ap);
  3040		}
  3041	
  3042		/* Configure new devices forward such that user doesn't see
  3043		 * device detection messages backwards.
  3044		 */
  3045		ata_for_each_dev(dev, link, ALL) {
  3046			if (!(new_mask & (1 << dev->devno)))
  3047				continue;
  3048	
  3049			dev->class = ehc->classes[dev->devno];
  3050	
  3051			if (dev->class == ATA_DEV_PMP)
  3052				continue;
  3053	
  3054			ehc->i.flags |= ATA_EHI_PRINTINFO;
  3055			rc = ata_dev_configure(dev);
  3056			ehc->i.flags &= ~ATA_EHI_PRINTINFO;
  3057			if (rc) {
  3058				dev->class = ATA_DEV_UNKNOWN;
  3059				goto err;
  3060			}
  3061	
  3062			spin_lock_irqsave(ap->lock, flags);
  3063			ap->pflags |= ATA_PFLAG_SCSI_HOTPLUG;
  3064			spin_unlock_irqrestore(ap->lock, flags);
  3065	
  3066			/* new device discovered, configure xfermode */
  3067			ehc->i.flags |= ATA_EHI_SETMODE;
  3068		}
  3069	
  3070		return 0;
  3071	
  3072	 err:
  3073		*r_failed_dev = dev;
  3074		return rc;
  3075	}
  3076	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
