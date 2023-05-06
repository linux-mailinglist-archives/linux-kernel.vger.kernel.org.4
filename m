Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C5F6F914D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 12:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjEFKvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 06:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEFKvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 06:51:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F033A85;
        Sat,  6 May 2023 03:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683370273; x=1714906273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PC7zVeIIArZFoNf5Uhrbn2o905hsUevHgo9oAP0rVe0=;
  b=P+VENBCrximPWLp5c6NHYb6+NvrVc2e/7q7/1zj22YxOzdjXR9ZfviDl
   Y1i43Wp4Y839KF+J4RIwYJ6feA5nzcb2FGGDTQAK9w0TrlHqZn2R1YmJG
   2jzWQ3VRsgmoTJLJNyclwvTn5NFzmM/jLfI9EkLcvAonGpQQOO/kvrMWQ
   zLQrvHLy33QxtgU72unFofvGhSGQ7VcLukEeDGOA7zQ8wYvm3mMu4NsIW
   3/d28pudJ8rCBkiX0f0znBNAcoXUrHMDdTvq6Kg9MEhwspqiLYfW1jtOW
   h5YnGZxV9/2XtmjYVNHJr/Tor5edjpYRMLgqsEnWsOsBC0JRR51E7ixxm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="349404137"
X-IronPort-AV: E=Sophos;i="5.99,254,1677571200"; 
   d="scan'208";a="349404137"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 03:51:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="809598352"
X-IronPort-AV: E=Sophos;i="5.99,254,1677571200"; 
   d="scan'208";a="809598352"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 May 2023 03:51:10 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvFVO-0000AT-07;
        Sat, 06 May 2023 10:51:10 +0000
Date:   Sat, 6 May 2023 18:50:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     wenjun93 <gwj0511@gmail.com>, miklos@szeredi.hu
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        gwj1235@yeah.net
Subject: Re: [PATCH] overlayfs: clean error handling
Message-ID: <202305061831.o7pAYoBr-lkp@intel.com>
References: <20230506082111.1655980-1-gwj1235@yeah.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506082111.1655980-1-gwj1235@yeah.net>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi wenjun93,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mszeredi-vfs/overlayfs-next]
[also build test WARNING on linus/master v6.3 next-20230505]
[cannot apply to mszeredi-vfs/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/wenjun93/overlayfs-clean-error-handling/20230506-162258
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git overlayfs-next
patch link:    https://lore.kernel.org/r/20230506082111.1655980-1-gwj1235%40yeah.net
patch subject: [PATCH] overlayfs: clean error handling
config: i386-randconfig-a011-20230501 (https://download.01.org/0day-ci/archive/20230506/202305061831.o7pAYoBr-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d5593461bec1095c3008da7403952420e637c01a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review wenjun93/overlayfs-clean-error-handling/20230506-162258
        git checkout d5593461bec1095c3008da7403952420e637c01a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/overlayfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305061831.o7pAYoBr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/overlayfs/super.c:806:4: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                           goto out_dput;
                           ^
   fs/overlayfs/super.c:804:3: note: previous statement is here
                   if (d_really_is_negative(work))
                   ^
   fs/overlayfs/super.c:1197:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out_unlock;
                   ^
   fs/overlayfs/super.c:1195:2: note: previous statement is here
           if (IS_ERR(temp))
           ^
   fs/overlayfs/super.c:1218:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto cleanup_temp;
                   ^
   fs/overlayfs/super.c:1216:2: note: previous statement is here
           if (IS_ERR(whiteout))
           ^
>> fs/overlayfs/super.c:1195:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (IS_ERR(temp))
               ^~~~~~~~~~~~
   fs/overlayfs/super.c:1236:9: note: uninitialized use occurs here
           return err;
                  ^~~
   fs/overlayfs/super.c:1195:2: note: remove the 'if' if its condition is always true
           if (IS_ERR(temp))
           ^~~~~~~~~~~~~~~~~
   fs/overlayfs/super.c:1190:9: note: initialize the variable 'err' to silence this warning
           int err;
                  ^
                   = 0
   fs/overlayfs/super.c:1297:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out;
                   ^
   fs/overlayfs/super.c:1295:2: note: previous statement is here
           if (IS_ERR_OR_NULL(workdir))
           ^
   fs/overlayfs/super.c:1612:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out;
                   ^
   fs/overlayfs/super.c:1610:2: note: previous statement is here
           if (ofs->fs == NULL)
           ^
   fs/overlayfs/super.c:1610:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (ofs->fs == NULL)
               ^~~~~~~~~~~~~~~
   fs/overlayfs/super.c:1719:9: note: uninitialized use occurs here
           return err;
                  ^~~
   fs/overlayfs/super.c:1610:2: note: remove the 'if' if its condition is always true
           if (ofs->fs == NULL)
           ^~~~~~~~~~~~~~~~~~~~
   fs/overlayfs/super.c:1606:9: note: initialize the variable 'err' to silence this warning
           int err;
                  ^
                   = 0
   fs/overlayfs/super.c:1762:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out_err;
                   ^
   fs/overlayfs/super.c:1760:2: note: previous statement is here
           if (!oe)
           ^
   fs/overlayfs/super.c:1906:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out;
                   ^
   fs/overlayfs/super.c:1904:2: note: previous statement is here
           if (WARN_ON(sb->s_user_ns != current_user_ns()))
           ^
   fs/overlayfs/super.c:1913:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out;
                   ^
   fs/overlayfs/super.c:1911:2: note: previous statement is here
           if (!ofs)
           ^
   fs/overlayfs/super.c:1918:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out_err;
                   ^
   fs/overlayfs/super.c:1916:2: note: previous statement is here
           if (!cred)
           ^
   fs/overlayfs/super.c:1942:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out_err;
                   ^
   fs/overlayfs/super.c:1940:2: note: previous statement is here
           if (!splitlower)
           ^
   fs/overlayfs/super.c:1955:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out_err;
                   ^
   fs/overlayfs/super.c:1953:2: note: previous statement is here
           if (!layers)
           ^
   fs/overlayfs/super.c:2012:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out_err;
                   ^
   fs/overlayfs/super.c:2010:2: note: previous statement is here
           if (IS_ERR(oe))
           ^
   fs/overlayfs/super.c:2067:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out_free_oe;
                   ^
   fs/overlayfs/super.c:2065:2: note: previous statement is here
           if (!root_dentry)
           ^
   fs/overlayfs/super.c:1904:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (WARN_ON(sb->s_user_ns != current_user_ns()))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:121:28: note: expanded from macro 'WARN_ON'
   #define WARN_ON(condition) ({                                           \
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/overlayfs/super.c:2084:9: note: uninitialized use occurs here
           return err;
                  ^~~
   fs/overlayfs/super.c:1904:2: note: remove the 'if' if its condition is always true
           if (WARN_ON(sb->s_user_ns != current_user_ns()))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/overlayfs/super.c:1902:9: note: initialize the variable 'err' to silence this warning
           int err;
                  ^
--
>> fs/overlayfs/namei.c:538:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto fail;
                   ^
   fs/overlayfs/namei.c:536:2: note: previous statement is here
           if (index->d_name.len < sizeof(struct ovl_fb)*2)
           ^
   fs/overlayfs/namei.c:544:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto fail;
                   ^
   fs/overlayfs/namei.c:542:2: note: previous statement is here
           if (!fh)
           ^
   fs/overlayfs/namei.c:548:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto fail;
                   ^
   fs/overlayfs/namei.c:546:2: note: previous statement is here
           if (hex2bin(fh->buf, index->d_name.name, len))
           ^
>> fs/overlayfs/namei.c:536:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (index->d_name.len < sizeof(struct ovl_fb)*2)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/overlayfs/namei.c:610:9: note: uninitialized use occurs here
           return err;
                  ^~~
   fs/overlayfs/namei.c:536:2: note: remove the 'if' if its condition is always true
           if (index->d_name.len < sizeof(struct ovl_fb)*2)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/overlayfs/namei.c:531:9: note: initialize the variable 'err' to silence this warning
           int err;
                  ^
                   = 0
   fs/overlayfs/namei.c:912:4: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                           goto out_put_upper;
                           ^
   fs/overlayfs/namei.c:910:3: note: previous statement is here
                   if (!stack)
                   ^
   fs/overlayfs/namei.c:1073:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out_put;
                   ^
   fs/overlayfs/namei.c:1071:2: note: previous statement is here
           if (!oe)
           ^
   fs/overlayfs/namei.c:1120:4: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                           goto out_free_oe;
                           ^
   fs/overlayfs/namei.c:1118:3: note: previous statement is here
                   if (IS_ERR(inode))
                   ^
   7 warnings generated.
--
>> fs/overlayfs/dir.c:120:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   return err;
                   ^
   fs/overlayfs/dir.c:118:2: note: previous statement is here
           if (IS_ERR(whiteout))
           ^
>> fs/overlayfs/dir.c:118:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (IS_ERR(whiteout))
               ^~~~~~~~~~~~~~~~
   fs/overlayfs/dir.c:120:10: note: uninitialized use occurs here
                   return err;
                          ^~~
   fs/overlayfs/dir.c:118:2: note: remove the 'if' if its condition is always true
           if (IS_ERR(whiteout))
           ^~~~~~~~~~~~~~~~~~~~~
   fs/overlayfs/dir.c:114:9: note: initialize the variable 'err' to silence this warning
           int err;
                  ^
                   = 0
   fs/overlayfs/dir.c:181:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out;
                   ^
   fs/overlayfs/dir.c:179:2: note: previous statement is here
           if (newdentry->d_inode)
           ^
   fs/overlayfs/dir.c:179:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (newdentry->d_inode)
               ^~~~~~~~~~~~~~~~~~
   fs/overlayfs/dir.c:220:6: note: uninitialized use occurs here
           if (err) {
               ^~~
   fs/overlayfs/dir.c:179:2: note: remove the 'if' if its condition is always true
           if (newdentry->d_inode)
           ^~~~~~~~~~~~~~~~~~~~~~~
   fs/overlayfs/dir.c:174:9: note: initialize the variable 'err' to silence this warning
           int err;
                  ^
                   = 0
   fs/overlayfs/dir.c:341:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out_unlock;
                   ^
   fs/overlayfs/dir.c:339:2: note: previous statement is here
           if (IS_ERR(newdentry))
           ^
   fs/overlayfs/dir.c:339:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (IS_ERR(newdentry))
               ^~~~~~~~~~~~~~~~~
   fs/overlayfs/dir.c:354:9: note: uninitialized use occurs here
           return err;
                  ^~~
   fs/overlayfs/dir.c:339:2: note: remove the 'if' if its condition is always true
           if (IS_ERR(newdentry))
           ^~~~~~~~~~~~~~~~~~~~~~
   fs/overlayfs/dir.c:329:9: note: initialize the variable 'err' to silence this warning
           int err;
                  ^
                   = 0
   fs/overlayfs/dir.c:399:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out_unlock;
                   ^
   fs/overlayfs/dir.c:397:2: note: previous statement is here
           if (IS_ERR(opaquedir))
           ^
   fs/overlayfs/dir.c:478:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out_unlock;
                   ^
   fs/overlayfs/dir.c:476:2: note: previous statement is here
           if (IS_ERR(upper))
           ^
   fs/overlayfs/dir.c:482:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out_dput;
                   ^
   fs/overlayfs/dir.c:480:2: note: previous statement is here
           if (d_is_negative(upper) || !IS_WHITEOUT(d_inode(upper)))
           ^
   fs/overlayfs/dir.c:487:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out_dput;
                   ^
   fs/overlayfs/dir.c:485:2: note: previous statement is here
           if (IS_ERR(newdentry))
           ^
   fs/overlayfs/dir.c:583:4: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                           goto out_revert_creds;
                           ^
   fs/overlayfs/dir.c:581:3: note: previous statement is here
                   if (!override_cred)
                   ^
   fs/overlayfs/dir.c:638:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out_drop_write;
                   ^
   fs/overlayfs/dir.c:636:2: note: previous statement is here
           if (!inode)
           ^
   fs/overlayfs/dir.c:764:4: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                           goto out;
                           ^
   fs/overlayfs/dir.c:762:3: note: previous statement is here
                   if (IS_ERR(opaquedir))
                   ^
   fs/overlayfs/dir.c:775:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto out_unlock;
                   ^
   fs/overlayfs/dir.c:773:2: note: previous statement is here
           if (IS_ERR(upper))
           ^
   fs/overlayfs/dir.c:762:7: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (IS_ERR(opaquedir))
--
>> fs/overlayfs/readdir.c:769:4: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                           goto out;
                           ^
   fs/overlayfs/readdir.c:767:3: note: previous statement is here
                   if (IS_ERR(cache))
                   ^
>> fs/overlayfs/readdir.c:767:7: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (IS_ERR(cache))
                       ^~~~~~~~~~~~~
   fs/overlayfs/readdir.c:795:9: note: uninitialized use occurs here
           return err;
                  ^~~
   fs/overlayfs/readdir.c:767:3: note: remove the 'if' if its condition is always true
                   if (IS_ERR(cache))
                   ^~~~~~~~~~~~~~~~~~
   fs/overlayfs/readdir.c:740:9: note: initialize the variable 'err' to silence this warning
           int err;
                  ^
                   = 0
   2 warnings generated.
--
>> fs/overlayfs/copy_up.c:513:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto free_name;
                   ^
   fs/overlayfs/copy_up.c:511:2: note: previous statement is here
           if (IS_ERR(temp))
           ^
   fs/overlayfs/copy_up.c:711:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto unlock;
                   ^
   fs/overlayfs/copy_up.c:709:2: note: previous statement is here
           if (lock_rename(c->workdir, c->destdir) != NULL)
           ^
   fs/overlayfs/copy_up.c:722:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto unlock;
                   ^
   fs/overlayfs/copy_up.c:720:2: note: previous statement is here
           if (IS_ERR(temp))
           ^
   fs/overlayfs/copy_up.c:747:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   goto cleanup;
                   ^
   fs/overlayfs/copy_up.c:745:2: note: previous statement is here
           if (IS_ERR(upper))
           ^
>> fs/overlayfs/copy_up.c:709:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (lock_rename(c->workdir, c->destdir) != NULL)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/overlayfs/copy_up.c:763:9: note: uninitialized use occurs here
           return err;
                  ^~~
   fs/overlayfs/copy_up.c:709:2: note: remove the 'if' if its condition is always true
           if (lock_rename(c->workdir, c->destdir) != NULL)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/overlayfs/copy_up.c:700:9: note: initialize the variable 'err' to silence this warning
           int err;
                  ^
                   = 0
   5 warnings generated.
..


vim +/if +806 fs/overlayfs/super.c

e9be9d5e76e348 Miklos Szeredi    2014-10-24  761  
ad204488d3046b Miklos Szeredi    2017-11-10  762  static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
6b8aa129dcbe0e Amir Goldstein    2017-06-21  763  					 const char *name, bool persist)
e9be9d5e76e348 Miklos Szeredi    2014-10-24  764  {
ad204488d3046b Miklos Szeredi    2017-11-10  765  	struct inode *dir =  ofs->workbasedir->d_inode;
08f4c7c86d4cf1 Miklos Szeredi    2020-06-04  766  	struct vfsmount *mnt = ovl_upper_mnt(ofs);
e9be9d5e76e348 Miklos Szeredi    2014-10-24  767  	struct dentry *work;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  768  	int err;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  769  	bool retried = false;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  770  
5955102c9984fa Al Viro           2016-01-22  771  	inode_lock_nested(dir, I_MUTEX_PARENT);
e9be9d5e76e348 Miklos Szeredi    2014-10-24  772  retry:
22f289ce1f8b10 Christian Brauner 2022-04-04  773  	work = ovl_lookup_upper(ofs, name, ofs->workbasedir, strlen(name));
e9be9d5e76e348 Miklos Szeredi    2014-10-24  774  
e9be9d5e76e348 Miklos Szeredi    2014-10-24  775  	if (!IS_ERR(work)) {
c11b9fdd6a612f Miklos Szeredi    2016-09-01  776  		struct iattr attr = {
c11b9fdd6a612f Miklos Szeredi    2016-09-01  777  			.ia_valid = ATTR_MODE,
32a3d848eb91a2 Al Viro           2016-12-04  778  			.ia_mode = S_IFDIR | 0,
c11b9fdd6a612f Miklos Szeredi    2016-09-01  779  		};
e9be9d5e76e348 Miklos Szeredi    2014-10-24  780  
e9be9d5e76e348 Miklos Szeredi    2014-10-24  781  		if (work->d_inode) {
e9be9d5e76e348 Miklos Szeredi    2014-10-24  782  			err = -EEXIST;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  783  			if (retried)
e9be9d5e76e348 Miklos Szeredi    2014-10-24  784  				goto out_dput;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  785  
6b8aa129dcbe0e Amir Goldstein    2017-06-21  786  			if (persist)
6b8aa129dcbe0e Amir Goldstein    2017-06-21  787  				goto out_unlock;
6b8aa129dcbe0e Amir Goldstein    2017-06-21  788  
e9be9d5e76e348 Miklos Szeredi    2014-10-24  789  			retried = true;
576bb263450bbb Christian Brauner 2022-04-04  790  			err = ovl_workdir_cleanup(ofs, dir, mnt, work, 0);
e9be9d5e76e348 Miklos Szeredi    2014-10-24  791  			dput(work);
235ce9ed96bc62 Amir Goldstein    2020-08-30  792  			if (err == -EINVAL) {
235ce9ed96bc62 Amir Goldstein    2020-08-30  793  				work = ERR_PTR(err);
235ce9ed96bc62 Amir Goldstein    2020-08-30  794  				goto out_unlock;
235ce9ed96bc62 Amir Goldstein    2020-08-30  795  			}
e9be9d5e76e348 Miklos Szeredi    2014-10-24  796  			goto retry;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  797  		}
e9be9d5e76e348 Miklos Szeredi    2014-10-24  798  
576bb263450bbb Christian Brauner 2022-04-04  799  		err = ovl_mkdir_real(ofs, dir, &work, attr.ia_mode);
1f5573cfe7a705 Miklos Szeredi    2021-11-04  800  		if (err)
1f5573cfe7a705 Miklos Szeredi    2021-11-04  801  			goto out_dput;
1f5573cfe7a705 Miklos Szeredi    2021-11-04  802  
1f5573cfe7a705 Miklos Szeredi    2021-11-04  803  		/* Weird filesystem returning with hashed negative (kernfs)? */
1f5573cfe7a705 Miklos Szeredi    2021-11-04  804  		if (d_really_is_negative(work))
d5593461bec109 wenjun93          2023-05-06  805  			err = -EINVAL;
1f5573cfe7a705 Miklos Szeredi    2021-11-04 @806  			goto out_dput;
c11b9fdd6a612f Miklos Szeredi    2016-09-01  807  
cb348edb6bef72 Miklos Szeredi    2016-10-04  808  		/*
cb348edb6bef72 Miklos Szeredi    2016-10-04  809  		 * Try to remove POSIX ACL xattrs from workdir.  We are good if:
cb348edb6bef72 Miklos Szeredi    2016-10-04  810  		 *
cb348edb6bef72 Miklos Szeredi    2016-10-04  811  		 * a) success (there was a POSIX ACL xattr and was removed)
cb348edb6bef72 Miklos Szeredi    2016-10-04  812  		 * b) -ENODATA (there was no POSIX ACL xattr)
cb348edb6bef72 Miklos Szeredi    2016-10-04  813  		 * c) -EOPNOTSUPP (POSIX ACL xattrs are not supported)
cb348edb6bef72 Miklos Szeredi    2016-10-04  814  		 *
cb348edb6bef72 Miklos Szeredi    2016-10-04  815  		 * There are various other error values that could effectively
cb348edb6bef72 Miklos Szeredi    2016-10-04  816  		 * mean that the xattr doesn't exist (e.g. -ERANGE is returned
cb348edb6bef72 Miklos Szeredi    2016-10-04  817  		 * if the xattr name is too long), but the set of filesystems
cb348edb6bef72 Miklos Szeredi    2016-10-04  818  		 * allowed as upper are limited to "normal" ones, where checking
cb348edb6bef72 Miklos Szeredi    2016-10-04  819  		 * for the above two errors is sufficient.
cb348edb6bef72 Miklos Szeredi    2016-10-04  820  		 */
31acceb97500dd Christian Brauner 2022-09-22  821  		err = ovl_do_remove_acl(ofs, work, XATTR_NAME_POSIX_ACL_DEFAULT);
e1ff3dd1ae52ce Miklos Szeredi    2016-09-05  822  		if (err && err != -ENODATA && err != -EOPNOTSUPP)
c11b9fdd6a612f Miklos Szeredi    2016-09-01  823  			goto out_dput;
c11b9fdd6a612f Miklos Szeredi    2016-09-01  824  
31acceb97500dd Christian Brauner 2022-09-22  825  		err = ovl_do_remove_acl(ofs, work, XATTR_NAME_POSIX_ACL_ACCESS);
e1ff3dd1ae52ce Miklos Szeredi    2016-09-05  826  		if (err && err != -ENODATA && err != -EOPNOTSUPP)
c11b9fdd6a612f Miklos Szeredi    2016-09-01  827  			goto out_dput;
c11b9fdd6a612f Miklos Szeredi    2016-09-01  828  
c11b9fdd6a612f Miklos Szeredi    2016-09-01  829  		/* Clear any inherited mode bits */
c11b9fdd6a612f Miklos Szeredi    2016-09-01  830  		inode_lock(work->d_inode);
a15506eac96fdb Christian Brauner 2022-04-04  831  		err = ovl_do_notify_change(ofs, work, &attr);
c11b9fdd6a612f Miklos Szeredi    2016-09-01  832  		inode_unlock(work->d_inode);
c11b9fdd6a612f Miklos Szeredi    2016-09-01  833  		if (err)
c11b9fdd6a612f Miklos Szeredi    2016-09-01  834  			goto out_dput;
6b8aa129dcbe0e Amir Goldstein    2017-06-21  835  	} else {
6b8aa129dcbe0e Amir Goldstein    2017-06-21  836  		err = PTR_ERR(work);
6b8aa129dcbe0e Amir Goldstein    2017-06-21  837  		goto out_err;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  838  	}
e9be9d5e76e348 Miklos Szeredi    2014-10-24  839  out_unlock:
6b8aa129dcbe0e Amir Goldstein    2017-06-21  840  	inode_unlock(dir);
e9be9d5e76e348 Miklos Szeredi    2014-10-24  841  	return work;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  842  
e9be9d5e76e348 Miklos Szeredi    2014-10-24  843  out_dput:
e9be9d5e76e348 Miklos Szeredi    2014-10-24  844  	dput(work);
6b8aa129dcbe0e Amir Goldstein    2017-06-21  845  out_err:
1bd0a3aea4357e lijiazi           2019-12-16  846  	pr_warn("failed to create directory %s/%s (errno: %i); mounting read-only\n",
ad204488d3046b Miklos Szeredi    2017-11-10  847  		ofs->config.workdir, name, -err);
6b8aa129dcbe0e Amir Goldstein    2017-06-21  848  	work = NULL;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  849  	goto out_unlock;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  850  }
e9be9d5e76e348 Miklos Szeredi    2014-10-24  851  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
