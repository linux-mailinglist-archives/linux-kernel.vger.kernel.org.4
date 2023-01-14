Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA2866A925
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 05:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjANENs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 23:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjANENn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 23:13:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E706A9E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 20:13:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FA70B822C0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 04:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F40EC433EF;
        Sat, 14 Jan 2023 04:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673669619;
        bh=rDUUQRNZS3av5hs/mcvGAWdmXs7ftndncmP3Hclnl2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ViHxZIuHwugxSwoXZ+MpoOLvlz1n9U1vCYlVZQRDMXcMlUj2MskgeGNLyqBD4BpQT
         l9yBHLG9Q+M9V+DVQTgns+tcKybQGtdOrZqEDwvhcCa6yl2TTKhrMWBc+rfBxReoyr
         5LqKzEz5uO4v6jq0I3FrLJlRQPfjoHOK3lj6+Q3LOOI6+iopOcBBm7V+Nd7wGZrVa1
         85XpqrWKc76QX98pKK5u680vaLZQyVvDg+Du5qQcSsLPmqSkwQXa8+3+eo9moE61DY
         nUJxNPoggdGqLp+Vl/GyOSTF2apP1mi9hIYdtQnpv3cSvbRnOm0zm2LfQp9ElUVKZv
         juYF2YyX7d0Pw==
Date:   Sat, 14 Jan 2023 12:13:33 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     kernel test robot <lkp@intel.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        LKML <linux-kernel@vger.kernel.org>,
        oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/2] erofs: cleanup erofs_iget()
Message-ID: <Y8Ir7ditI6TPcuwI@debian>
Mail-Followup-To: kernel test robot <lkp@intel.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>, LKML <linux-kernel@vger.kernel.org>,
        oe-kbuild-all@lists.linux.dev
References: <20230114015812.96836-1-hsiangkao@linux.alibaba.com>
 <202301141147.AYezdBCD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202301141147.AYezdBCD-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 11:59:41AM +0800, kernel test robot wrote:
> Hi Gao,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on xiang-erofs/dev-test]
> [also build test WARNING on xiang-erofs/dev xiang-erofs/fixes linus/master v6.2-rc3 next-20230113]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Gao-Xiang/erofs-remove-linux-buffer_head-h-dependency/20230114-100018
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
> patch link:    https://lore.kernel.org/r/20230114015812.96836-1-hsiangkao%40linux.alibaba.com
> patch subject: [PATCH v2 1/2] erofs: cleanup erofs_iget()
> config: ia64-allyesconfig
> compiler: ia64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/ede350f68141cc6bdc88c627e0f8f992f1b26307
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Gao-Xiang/erofs-remove-linux-buffer_head-h-dependency/20230114-100018
>         git checkout ede350f68141cc6bdc88c627e0f8f992f1b26307
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash fs/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    fs/erofs/inode.c: In function 'erofs_squash_ino':
> >> fs/erofs/inode.c:319:28: warning: right shift count >= width of type [-Wshift-count-overflow]
>      319 |                 ino ^= nid >> sizeof(ino_t) * 8;
>          |                            ^~

Okay, I think I have to stick to v1 since v2 causes a
compile warning.

Thanks,
Gao Xiang
