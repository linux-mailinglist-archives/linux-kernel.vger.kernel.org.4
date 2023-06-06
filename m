Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1A4724241
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbjFFMfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjFFMfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:35:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77FD10CA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686054937; x=1717590937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tA7wwf/t/7qt0yTKz623VV7kJiNe41UtCjTEvJ+qhiQ=;
  b=Bmm2wDpxx1QM+Fzvvzf9kFAj36oo2rqdi8If4hN1oFRvBguPh9xxkyX+
   QpHFHhai4BmpHLhXbfyRql7YZG9NyRy83Pb2p17YEUqzVmd9hPcpr+tBZ
   VRoykhAes+/ANe+c7ppRj37yWKR7RN52kLwA8ztOsH5PrM0TiQ8lL9a4V
   VBungVwlsAvAN4rvNFtPmIyESxjqwCwbtQkf/OchORkoBVZgLSaXw6zJr
   jH3oVVfxVSRw0gnfwDcA//Sf8wMDljRt42ROMJ/QlKDKXjrQ/aYjE1HFn
   mF2ez/pBXQNnsAevDy6Kwp7jrctluNM/jfqULouvbjdtO+TsCbKjabbYP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="346254611"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="346254611"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 05:35:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="833208288"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="833208288"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 05:35:33 -0700
Date:   Tue, 6 Jun 2023 14:35:32 +0200
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
        Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH] accel/ivpu: ivpu_ipc needs GENERIC_ALLOCATOR
Message-ID: <20230606123532.GA324119@linux.intel.com>
References: <20230526044519.13441-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526044519.13441-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 09:45:19PM -0700, Randy Dunlap wrote:
> Drivers that use the gen_pool*() family of functions should
> select GENERIC_ALLOCATOR to prevent build errors like these:
> 
> ld: drivers/accel/ivpu/ivpu_ipc.o: in function `gen_pool_free':
> include/linux/genalloc.h:172: undefined reference to `gen_pool_free_owner'
> ld: drivers/accel/ivpu/ivpu_ipc.o: in function `gen_pool_alloc_algo':
> include/linux/genalloc.h:138: undefined reference to `gen_pool_alloc_algo_owner'
> ld: drivers/accel/ivpu/ivpu_ipc.o: in function `gen_pool_free':
> include/linux/genalloc.h:172: undefined reference to `gen_pool_free_owner'
> ld: drivers/accel/ivpu/ivpu_ipc.o: in function `ivpu_ipc_init':
> drivers/accel/ivpu/ivpu_ipc.c:441: undefined reference to `devm_gen_pool_create'
> ld: drivers/accel/ivpu/ivpu_ipc.o: in function `gen_pool_add_virt':
> include/linux/genalloc.h:104: undefined reference to `gen_pool_add_owner'
> 
> Fixes: 5d7422cfb498 ("accel/ivpu: Add IPC driver and JSM messages")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202305221206.1TaugDKP-lkp@intel.com/
> Cc: Oded Gabbay <ogabbay@kernel.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> Cc: Krystian Pradzynski <krystian.pradzynski@linux.intel.com>
> Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Applied to drm-misc-fixes

Thanks
Stanislaw

