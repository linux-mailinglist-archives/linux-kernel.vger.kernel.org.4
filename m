Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C45713C09
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 20:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjE1S7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 14:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjE1S7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 14:59:34 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 28 May 2023 11:59:32 PDT
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F145B90
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Mvnq6GLOTTGF3D7gWr44xLsL9av+ARP5UpYLZ3q1nQo=;
  b=Cm/opXqEGw2dkC9K3AL8zHtoU2E/oIMkSR9nSLaKypQ/7I4hAY2wqIum
   52gI7aU47i4g+di4Xs3MoUkvy+xPlqiKM+SvwPOm6uoeW8mPzhtJXfR7l
   2G8V/M1fcc18Dx5mBFRFiEQ/F+lcnn1s6I5rg2mF8elL//9PqLYvtBGB0
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.00,198,1681164000"; 
   d="scan'208";a="110065371"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 20:58:28 +0200
Date:   Sun, 28 May 2023 20:58:27 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
cc:     Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel@vger.kernel.org
Subject: drivers/dma/idxd/device.c:774:8-26: WARNING: dma_alloc_coherent used
 in (fwd)
Message-ID: <alpine.DEB.2.22.394.2305282056200.2875@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The warning suggests that the memset in idxd_device_evl_setup may not be
needed.  There is a possibility of allocation via function pointer,
though, in dma_alloc_attrs, so I don't know what the possibilities are
in this case.

julia

---------- Forwarded message ----------
Date: Mon, 29 May 2023 01:34:17 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/dma/idxd/device.c:774:8-26: WARNING: dma_alloc_coherent used in

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Dave Jiang <dave.jiang@intel.com>
CC: Vinod Koul <vkoul@kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7877cb91f1081754a1487c144d85dc0d2e2e7fc4
commit: 244da66cda359227d80ccb41dbcb99da40eae186 dmaengine: idxd: setup event log configuration
date:   7 weeks ago
:::::: branch date: 6 hours ago
:::::: commit date: 7 weeks ago
config: x86_64-randconfig-c022-20230528 (https://download.01.org/0day-ci/archive/20230529/202305290109.qddh20pB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202305290109.qddh20pB-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/dma/idxd/device.c:774:8-26: WARNING: dma_alloc_coherent used in
   	 /*
>> 	 * Address needs to be page aligned. However, dma_alloc_coherent() provides
>> 	 * at minimal page size aligned address. No manual alignment required.
   	 */
>> 	 addr   already zeroes out memory, so memset is not needed

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
