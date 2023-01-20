Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681076748C4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjATBZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjATBZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:25:37 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA01A295C;
        Thu, 19 Jan 2023 17:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674177936; x=1705713936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M4LsMrjiwewko2El9282LT8xvci0f+i1gtrjEfFkacQ=;
  b=NqwpVAxeJR/2ivRrR07oerGNiEQCnoKFA/ARWM1x8Gu3iJQpy6rBMDvX
   8D9r+G3rnmn1LFFpZQ/UYw6aGbEPo60TRI+2LP/bR4vG+rJiwbjNg0VzN
   iyI91lEvOLaPQ/igKJ4Fu9gks3b6Lo/al4jou4rrBfZXF1Tj5D+skjDPP
   UnKm26MqP2eraUAaJWLJ3QXpGyZDp96xJafEqP8QUYJAOJDj7FVG/kQJ4
   Y8VRio/pGeTsw7MVBmUwCPD2bRV+xt7xA8wBE3b2/H8rjm6AVl2ofKjiC
   vOPH302ZP+inA/7izuo284l0wi5umokRjM/ccg00bBNQAaZrjCfPm1XMQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305158448"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="305158448"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 17:25:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="989246930"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="989246930"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jan 2023 17:25:32 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIg9r-00022y-1Z;
        Fri, 20 Jan 2023 01:25:31 +0000
Date:   Fri, 20 Jan 2023 09:24:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Babis Chalios <bchalios@amazon.es>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, amit@kernel.org, graf@amazon.de,
        Jason@zx2c4.com, xmarcalx@amazon.co.uk
Subject: Re: [PATCH 1/2] virtio-rng: implement entropy leak feature
Message-ID: <202301200941.fE9QkyE3-lkp@intel.com>
References: <20230119184349.74072-2-bchalios@amazon.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119184349.74072-2-bchalios@amazon.es>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babis,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.2-rc4 next-20230119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Babis-Chalios/virtio-rng-implement-entropy-leak-feature/20230120-024631
patch link:    https://lore.kernel.org/r/20230119184349.74072-2-bchalios%40amazon.es
patch subject: [PATCH 1/2] virtio-rng: implement entropy leak feature
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20230120/202301200941.fE9QkyE3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/686114cbba5005584d458ad44164b4a4b88135f5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Babis-Chalios/virtio-rng-implement-entropy-leak-feature/20230120-024631
        git checkout 686114cbba5005584d458ad44164b4a4b88135f5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/char/hw_random/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/char/hw_random/virtio-rng.c:59:5: sparse: sparse: symbol 'add_fill_on_leak_request' was not declared. Should it be static?
>> drivers/char/hw_random/virtio-rng.c:73:5: sparse: sparse: symbol 'virtrng_fill_on_leak' was not declared. Should it be static?
>> drivers/char/hw_random/virtio-rng.c:94:5: sparse: sparse: symbol 'add_copy_on_leak_request' was not declared. Should it be static?
>> drivers/char/hw_random/virtio-rng.c:113:5: sparse: sparse: symbol 'virtrng_copy_on_leak' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
