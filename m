Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA286BBE30
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjCOU4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCOU4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:56:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7CB8C511
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:55:55 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id bj12so3480826pfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1678913754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=imHwkZmtdo+G134HfW8QY38rrBjXWKOKW5gZ2oqTMOo=;
        b=2DEuKMxEcucR8xRm9szIy8+Xb1gbAp2c6IGg+rD17Ly6BfsFupQILKWw+ykZpsku33
         5mQ6bMNCECBn29e7TFsdmwSGFGJBqCNCu95Ii4fTD8fCy0XW9SCx9a5IMf7x7tVoEYyI
         B5vuS06JWS4rm0giy0vAGIdJiq3oCmqtdXU67tFegwAcZltwhiXqhNVnald6I4yM/iwV
         4RxuXGCoie8WLfgOu+ywzJ6hk3QjAqC09W/E/ratfzKVhfH4XJYb/hsaFZEUKAJC2Vz6
         e1Hbw16zn7+n+vE71oe+s5rHmxqhYHHbL1lLiJh2sD1kBczzYJSXVJqVi1KIfkmewks+
         4izA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678913754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imHwkZmtdo+G134HfW8QY38rrBjXWKOKW5gZ2oqTMOo=;
        b=u/v8yXHxhVJJfHBlcImMJwWOdV1t2HVmjyrrykHfSMAfuuaZqfQ3DG8yizrq0oui7T
         lPSwWgVz97qE7/SNPEyFKFJ9NUbPP/jASU19FZlY3rF3vs26le9ugNZZy8kssc7Fn2aJ
         kZ8sqZvrRf9UTbJck356Ug/N2O6XUVN4Rv5lbpP1g8zc61J4VJwC4KYfZGTiT+8BOgLK
         wI0wBallk5RYMYhHnS6H1G4oSHlVCc+alVQAyKgd8k0o2KCbxU6Cv4X+JyeMwPZUPgab
         P8VvEZVkPvUiU9vASn8Dw8TadO4pDedS0GKGO+Mm5NZupUgqnFzz7kunmS1zar3sbMg4
         l16w==
X-Gm-Message-State: AO0yUKVv0Y7DGJWt5J0HUgBQNehuK7p1bdugyfqOnK2Mb/ojYaBfjjm+
        deQ+zmXZvHqVu60ib/nbzAIhbQ==
X-Google-Smtp-Source: AK7set+eU6Dd3+B8Lg5NkIP+nmrpJkcMcp/O2LFm6PFmwU+7nTVpYZWQ2rQLS1P1G5i3dYAUVnMzRg==
X-Received: by 2002:aa7:9813:0:b0:625:d630:4e1b with SMTP id e19-20020aa79813000000b00625d6304e1bmr774222pfl.31.1678913754626;
        Wed, 15 Mar 2023 13:55:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id n3-20020aa78a43000000b00625d5635617sm627735pfa.67.2023.03.15.13.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 13:55:54 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pcYA2-009CD4-Cw; Thu, 16 Mar 2023 07:55:50 +1100
Date:   Thu, 16 Mar 2023 07:55:50 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, linux-mm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yebin10@huawei.com
Subject: Re: [PATCH 4/4] pcpcntr: remove percpu_counter_sum_all()
Message-ID: <20230315205550.GS360264@dread.disaster.area>
References: <20230315084938.2544737-5-david@fromorbit.com>
 <202303160333.XqIRz3JU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303160333.XqIRz3JU-lkp@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 03:22:31AM +0800, kernel test robot wrote:
> Hi Dave,
> 
> Thank you for the patch! Yet something to improve:

No, ithere is nothing wrong with my patch series, this is something
for _you_ to improve.

> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.3-rc2 next-20230315]
> [cannot apply to dennis-percpu/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Chinner/cpumask-introduce-for_each_cpu_or/20230315-165202
> patch link:    https://lore.kernel.org/r/20230315084938.2544737-5-david%40fromorbit.com
> patch subject: [PATCH 4/4] pcpcntr: remove percpu_counter_sum_all()
> config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20230316/202303160333.XqIRz3JU-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/8360dcb55f1eb08fe7a1f457f3b99bef8e306c8b
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Dave-Chinner/cpumask-introduce-for_each_cpu_or/20230315-165202
>         git checkout 8360dcb55f1eb08fe7a1f457f3b99bef8e306c8b
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=i386 olddefconfig
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hwmon/ fs/xfs/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303160333.XqIRz3JU-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/string.h:5,
>                     from include/linux/uuid.h:11,
>                     from fs/xfs/xfs_linux.h:10,
>                     from fs/xfs/xfs.h:22,
>                     from fs/xfs/xfs_super.c:7:
>    fs/xfs/xfs_super.c: In function 'xfs_destroy_percpu_counters':
> >> fs/xfs/xfs_super.c:1079:16: error: implicit declaration of function 'percpu_counter_sum_all'; did you mean 'percpu_counter_sum'? [-Werror=implicit-function-declaration]
>     1079 |                percpu_counter_sum_all(&mp->m_delalloc_blks) == 0);
>          |                ^~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler.h:77:45: note: in definition of macro 'likely'
>       77 | # define likely(x)      __builtin_expect(!!(x), 1)
>          |                                             ^
>    fs/xfs/xfs_super.c:1078:9: note: in expansion of macro 'ASSERT'
>     1078 |         ASSERT(xfs_is_shutdown(mp) ||
>          |         ^~~~~~
>    cc1: some warnings being treated as errors
> 
> 
> vim +1079 fs/xfs/xfs_super.c
> 
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1070  
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1071  static void
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1072  xfs_destroy_percpu_counters(
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1073  	struct xfs_mount	*mp)
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1074  {
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1075  	percpu_counter_destroy(&mp->m_icount);
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1076  	percpu_counter_destroy(&mp->m_ifree);
> 8757c38f2cf6e5 Ian Kent        2019-11-04  1077  	percpu_counter_destroy(&mp->m_fdblocks);
> 75c8c50fa16a23 Dave Chinner    2021-08-18  1078  	ASSERT(xfs_is_shutdown(mp) ||
> c35278f526edf1 Ye Bin          2023-03-14 @1079  	       percpu_counter_sum_all(&mp->m_delalloc_blks) == 0);

This change has not been committed to any tree that I am aware of.
It was only posted to the XFS list yesterday, and I effectively
NACK'd it and wrote this patchset instead to fix the issue.

IOWs, if -anyone- has actually committed this change to add
percpu_counter_sum_all() to XFS, they've done the wrong thing.
Hence this build failure is a robot issue, not a problem with my
patch series.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
