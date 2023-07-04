Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAE7747A13
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 00:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjGDWQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 18:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjGDWQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 18:16:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDBCE7B;
        Tue,  4 Jul 2023 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688508965; x=1720044965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rrsQpFl+GGNZIUl7w2QPMDePajMI9KYVgmOy7sty/PU=;
  b=RJ/NWK7jYRPOZ7+I3W/EZ0p/AFx36IA+rpXdlEZJOte57ILeGwFY2H2u
   UE7USYo8cOW875vA7F/xVIiiYAVDrkofAopSLVhW2bVZTgATQcKZ8E4v/
   vlhthoFPJ0x0lDCcMDc+lmDfaFpdyIXxVUTJuL7eT8RuOmJtaEBXQ3keO
   pzHbNHREP6H+n46yG6sIyAPfRe2kx+XkcFxh0bCxMnxMzoRKXl/S8ZwWr
   TL9x5PyMx9H9JBn7c633G1RYyHbZftCHnBEGWZ8yDi1fyLt5upfGR2Vt4
   AGYHFUvDLo1V0bpm/Gly3wtnyeXwS2dmpB/CaKZtQXaAqMMecnBzawiJx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="365765373"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="365765373"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 15:16:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="788963010"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="788963010"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jul 2023 15:16:01 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGoJU-000IaV-1z;
        Tue, 04 Jul 2023 22:16:00 +0000
Date:   Wed, 5 Jul 2023 06:15:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Hindborg <nmi@metaspace.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>, gost.dev@samsung.com,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v5 5/5] ublk: enable zoned storage support
Message-ID: <202307050609.y0CCTok8-lkp@intel.com>
References: <20230704165209.514591-6-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704165209.514591-6-nmi@metaspace.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3261ea42710e9665c9151006049411bd23b5411f]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Hindborg/ublk-add-opcode-offsets-for-DRV_IN-DRV_OUT/20230705-005338
base:   3261ea42710e9665c9151006049411bd23b5411f
patch link:    https://lore.kernel.org/r/20230704165209.514591-6-nmi%40metaspace.dk
patch subject: [PATCH v5 5/5] ublk: enable zoned storage support
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230705/202307050609.y0CCTok8-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230705/202307050609.y0CCTok8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307050609.y0CCTok8-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__udivdi3" [drivers/block/ublk_drv.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
