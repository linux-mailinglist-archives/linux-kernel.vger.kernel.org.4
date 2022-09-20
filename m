Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866835BD93A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiITBNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiITBMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:12:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B34052E63
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663636311; x=1695172311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j0HdFT5OvtJlg5Ny82ycNOllTWbCkuOEUkQDYVbA3xY=;
  b=gtMOWMPmYmPXFB6WaMvBnG07eAa/+ekYAXd1hcySfAysFZBudhx+tKwf
   +ieTbi+fcboWMqk4+rFM4kt/9qlhUusQ37tUhNxqSaao9koiaSqgZTTAH
   F2ZpYAIqH9kylXGq7/MBI+R9tDpQuBtcMBgjhAANRM23HU6OD7XpJOxiZ
   XsJpfg4ILHokgP5vHIuA/B+qkes3iDqP9x5x5fxDbM2YwA8PXV5+rPg1j
   Zh7mMZxULcFX5HpHzQj+D1amWyF6co9EIWgPP+qXOTS/scIaHskzQZsrs
   bSiylLqG1P/M2F3McUphrHvdYJD7PGWmbFl9jjQYnMHOTjpbn+tqKR0ji
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="298288221"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="298288221"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 18:11:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="687200114"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Sep 2022 18:11:43 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaRnb-0002Ll-00;
        Tue, 20 Sep 2022 01:11:43 +0000
Date:   Tue, 20 Sep 2022 09:11:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH 2/2] f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE
Message-ID: <202209200942.RO5JnVfI-lkp@intel.com>
References: <20220919160644.2219088-2-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919160644.2219088-2-daeho43@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daeho,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jaegeuk-f2fs/dev-test]
[also build test ERROR on linus/master v6.0-rc6 next-20220919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daeho-Jeong/f2fs-correct-i_size-change-for-atomic-writes/20220920-000935
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
config: i386-randconfig-a006-20220919 (https://download.01.org/0day-ci/archive/20220920/202209200942.RO5JnVfI-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/884660386769b2359529c52ad0afc06684f1ea87
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daeho-Jeong/f2fs-correct-i_size-change-for-atomic-writes/20220920-000935
        git checkout 884660386769b2359529c52ad0afc06684f1ea87
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/f2fs/file.c:4090:7: error: use of undeclared identifier 'F2FS_IOC_START_ATOMIC_REPLACE'
           case F2FS_IOC_START_ATOMIC_REPLACE:
                ^
   1 error generated.


vim +/F2FS_IOC_START_ATOMIC_REPLACE +4090 fs/f2fs/file.c

  4082	
  4083	static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
  4084	{
  4085		switch (cmd) {
  4086		case FS_IOC_GETVERSION:
  4087			return f2fs_ioc_getversion(filp, arg);
  4088		case F2FS_IOC_START_ATOMIC_WRITE:
  4089			return f2fs_ioc_start_atomic_write(filp, false);
> 4090		case F2FS_IOC_START_ATOMIC_REPLACE:
  4091			return f2fs_ioc_start_atomic_write(filp, true);
  4092		case F2FS_IOC_COMMIT_ATOMIC_WRITE:
  4093			return f2fs_ioc_commit_atomic_write(filp);
  4094		case F2FS_IOC_ABORT_ATOMIC_WRITE:
  4095			return f2fs_ioc_abort_atomic_write(filp);
  4096		case F2FS_IOC_START_VOLATILE_WRITE:
  4097		case F2FS_IOC_RELEASE_VOLATILE_WRITE:
  4098			return -EOPNOTSUPP;
  4099		case F2FS_IOC_SHUTDOWN:
  4100			return f2fs_ioc_shutdown(filp, arg);
  4101		case FITRIM:
  4102			return f2fs_ioc_fitrim(filp, arg);
  4103		case FS_IOC_SET_ENCRYPTION_POLICY:
  4104			return f2fs_ioc_set_encryption_policy(filp, arg);
  4105		case FS_IOC_GET_ENCRYPTION_POLICY:
  4106			return f2fs_ioc_get_encryption_policy(filp, arg);
  4107		case FS_IOC_GET_ENCRYPTION_PWSALT:
  4108			return f2fs_ioc_get_encryption_pwsalt(filp, arg);
  4109		case FS_IOC_GET_ENCRYPTION_POLICY_EX:
  4110			return f2fs_ioc_get_encryption_policy_ex(filp, arg);
  4111		case FS_IOC_ADD_ENCRYPTION_KEY:
  4112			return f2fs_ioc_add_encryption_key(filp, arg);
  4113		case FS_IOC_REMOVE_ENCRYPTION_KEY:
  4114			return f2fs_ioc_remove_encryption_key(filp, arg);
  4115		case FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS:
  4116			return f2fs_ioc_remove_encryption_key_all_users(filp, arg);
  4117		case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
  4118			return f2fs_ioc_get_encryption_key_status(filp, arg);
  4119		case FS_IOC_GET_ENCRYPTION_NONCE:
  4120			return f2fs_ioc_get_encryption_nonce(filp, arg);
  4121		case F2FS_IOC_GARBAGE_COLLECT:
  4122			return f2fs_ioc_gc(filp, arg);
  4123		case F2FS_IOC_GARBAGE_COLLECT_RANGE:
  4124			return f2fs_ioc_gc_range(filp, arg);
  4125		case F2FS_IOC_WRITE_CHECKPOINT:
  4126			return f2fs_ioc_write_checkpoint(filp, arg);
  4127		case F2FS_IOC_DEFRAGMENT:
  4128			return f2fs_ioc_defragment(filp, arg);
  4129		case F2FS_IOC_MOVE_RANGE:
  4130			return f2fs_ioc_move_range(filp, arg);
  4131		case F2FS_IOC_FLUSH_DEVICE:
  4132			return f2fs_ioc_flush_device(filp, arg);
  4133		case F2FS_IOC_GET_FEATURES:
  4134			return f2fs_ioc_get_features(filp, arg);
  4135		case F2FS_IOC_GET_PIN_FILE:
  4136			return f2fs_ioc_get_pin_file(filp, arg);
  4137		case F2FS_IOC_SET_PIN_FILE:
  4138			return f2fs_ioc_set_pin_file(filp, arg);
  4139		case F2FS_IOC_PRECACHE_EXTENTS:
  4140			return f2fs_ioc_precache_extents(filp, arg);
  4141		case F2FS_IOC_RESIZE_FS:
  4142			return f2fs_ioc_resize_fs(filp, arg);
  4143		case FS_IOC_ENABLE_VERITY:
  4144			return f2fs_ioc_enable_verity(filp, arg);
  4145		case FS_IOC_MEASURE_VERITY:
  4146			return f2fs_ioc_measure_verity(filp, arg);
  4147		case FS_IOC_READ_VERITY_METADATA:
  4148			return f2fs_ioc_read_verity_metadata(filp, arg);
  4149		case FS_IOC_GETFSLABEL:
  4150			return f2fs_ioc_getfslabel(filp, arg);
  4151		case FS_IOC_SETFSLABEL:
  4152			return f2fs_ioc_setfslabel(filp, arg);
  4153		case F2FS_IOC_GET_COMPRESS_BLOCKS:
  4154			return f2fs_get_compress_blocks(filp, arg);
  4155		case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
  4156			return f2fs_release_compress_blocks(filp, arg);
  4157		case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
  4158			return f2fs_reserve_compress_blocks(filp, arg);
  4159		case F2FS_IOC_SEC_TRIM_FILE:
  4160			return f2fs_sec_trim_file(filp, arg);
  4161		case F2FS_IOC_GET_COMPRESS_OPTION:
  4162			return f2fs_ioc_get_compress_option(filp, arg);
  4163		case F2FS_IOC_SET_COMPRESS_OPTION:
  4164			return f2fs_ioc_set_compress_option(filp, arg);
  4165		case F2FS_IOC_DECOMPRESS_FILE:
  4166			return f2fs_ioc_decompress_file(filp, arg);
  4167		case F2FS_IOC_COMPRESS_FILE:
  4168			return f2fs_ioc_compress_file(filp, arg);
  4169		default:
  4170			return -ENOTTY;
  4171		}
  4172	}
  4173	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
