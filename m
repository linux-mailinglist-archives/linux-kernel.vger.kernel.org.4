Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AA068A5DD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjBCWNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjBCWNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:13:05 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB12DB3DC7;
        Fri,  3 Feb 2023 14:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675462295; x=1706998295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ri+6trqWrGO9FpKX3vOAcmBQPzepGLw5hNd4peqwtMI=;
  b=G4ygPJGXGe85Cw0CMZ/cxI/dbIUL6DvmNSQwtqvXklB/KX/P5BRFBcvD
   4msRvO+5auFOg1q7NhCmcMCKWMX7lCzLT8SCtg2OxBrs35murUWK9Sozy
   l+xLu2HmHUYsMFF12v9Zzf6NAzOr30O+D3Qe3HQcyHueaisRyw6zudDz0
   y+X/brWuLjzpeTCol5AjX28ZTlKkyWnNJDI/PbDSkW8ysMnReuQslXqA5
   WVOawazV1x9HBKxAZ0SFxd5od+bJxB9FDzVBc9YApWhYtUxWVWcNP9TgM
   fodzMk0744Fg1OQ13G7zHh792UfOlMTkagYxxbChzpXaL1gMua7dwBHkU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="330158925"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="330158925"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 14:11:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="729401023"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="729401023"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 03 Feb 2023 14:11:18 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pO4H8-0000nF-0g;
        Fri, 03 Feb 2023 22:11:18 +0000
Date:   Sat, 4 Feb 2023 06:10:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, hannes@cmpxchg.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bfoster@redhat.com, willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v9 2/3] cachestat: implement cachestat syscall
Message-ID: <202302040546.JHm5vnYB-lkp@intel.com>
References: <20230203190413.2559707-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203190413.2559707-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nhat,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 1440f576022887004f719883acb094e7e0dd4944]

url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230204-030455
base:   1440f576022887004f719883acb094e7e0dd4944
patch link:    https://lore.kernel.org/r/20230203190413.2559707-3-nphamcs%40gmail.com
patch subject: [PATCH v9 2/3] cachestat: implement cachestat syscall
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20230204/202302040546.JHm5vnYB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/49a57ed71ac2c005231660c85c3f30c4b47d8b7b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230204-030455
        git checkout 49a57ed71ac2c005231660c85c3f30c4b47d8b7b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/filemap.c:4035:6: warning: no previous prototype for 'ksys_cachestat' [-Wmissing-prototypes]
    4035 | long ksys_cachestat(unsigned int fd, loff_t off, size_t len,
         |      ^~~~~~~~~~~~~~


vim +/ksys_cachestat +4035 mm/filemap.c

  4033	
  4034	#ifdef CONFIG_CACHESTAT_SYSCALL
> 4035	long ksys_cachestat(unsigned int fd, loff_t off, size_t len,
  4036			struct cachestat __user *cstat, unsigned int flags)
  4037	{
  4038		struct fd f = fdget(fd);
  4039		struct address_space *mapping;
  4040		struct cachestat cs;
  4041		pgoff_t first_index = off >> PAGE_SHIFT;
  4042		pgoff_t last_index =
  4043			len == 0 ? ULONG_MAX : (off + len - 1) >> PAGE_SHIFT;
  4044	
  4045		if (!f.file)
  4046			return -EBADF;
  4047	
  4048		if (off < 0 || flags != 0) {
  4049			fdput(f);
  4050			return -EINVAL;
  4051		}
  4052	
  4053		memset(&cs, 0, sizeof(struct cachestat));
  4054		mapping = f.file->f_mapping;
  4055		filemap_cachestat(mapping, first_index, last_index, &cs);
  4056		fdput(f);
  4057	
  4058		if (copy_to_user(cstat, &cs, sizeof(struct cachestat)))
  4059			return -EFAULT;
  4060	
  4061		return 0;
  4062	}
  4063	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
