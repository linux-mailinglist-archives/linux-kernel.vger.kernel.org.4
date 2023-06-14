Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E142718211
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbjEaNho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbjEaNhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:37:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6761F13D;
        Wed, 31 May 2023 06:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685540251; x=1717076251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4j+SR6j6Y91MTRtLsgAmtEiec0cpzY168prO2t2ffXI=;
  b=QwiOrhxXqu8xzIkBlfyR1A4WYFd0Zlhe2q+F1oe/KDJVD4A1Js4SnhGp
   0sneh+JEp/EW7Py/XTnxmneL3TLE3lJjknty80kmnLqYxIWc7/BPav+GX
   yPxKCxDdCMtdxNLjNMJQF6ZmgUUxTxys7imWPJ51zVOwGcVsvWcIdbR8f
   VDFORMg90Oh2y74i8vVuwQ3G8cIQyrVc8C9ZOaLaZYFSKpu8qAuF+OkkX
   0hmn4dMk4x7ZnlMkZUA9H55tIXeSnAbCU/ZnMaX1GO1Nz2HxfczxHbYMN
   +BUivC13agqRZmlw/e9aO6dzqC30ZPpf+DojIB8DD3zMD8+LHx+RHipsi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="421005390"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="421005390"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 06:37:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="736673988"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="736673988"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 31 May 2023 06:37:25 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4M0y-0001Mx-1R;
        Wed, 31 May 2023 13:37:24 +0000
Date:   Wed, 31 May 2023 21:36:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Breno Leitao <leitao@debian.org>, dsahern@kernel.org,
        willemdebruijn.kernel@gmail.com,
        Remi Denis-Courmont <courmisch@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, leit@fb.com,
        axboe@kernel.dk, asml.silence@gmail.com,
        linux-kernel@vger.kernel.org, dccp@vger.kernel.org,
        linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
        linux-sctp@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: ioctl: Use kernel memory on protocol
 ioctl callbacks
Message-ID: <202305312111.1m4i6rKU-lkp@intel.com>
References: <20230530175403.2434218-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530175403.2434218-1-leitao@debian.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Breno,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Breno-Leitao/net-ioctl-Use-kernel-memory-on-protocol-ioctl-callbacks/20230531-015554
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230530175403.2434218-1-leitao%40debian.org
patch subject: [PATCH net-next v4] net: ioctl: Use kernel memory on protocol ioctl callbacks
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20230531/202305312111.1m4i6rKU-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f97a3206f5ae59ecb0c7105225c5230b343c6c54
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Breno-Leitao/net-ioctl-Use-kernel-memory-on-protocol-ioctl-callbacks/20230531-015554
        git checkout f97a3206f5ae59ecb0c7105225c5230b343c6c54
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305312111.1m4i6rKU-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: net/core/sock.o: in function `sk_ioctl':
>> sock.c:(.text+0xc7e): undefined reference to `ip6mr_sk_ioctl'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
