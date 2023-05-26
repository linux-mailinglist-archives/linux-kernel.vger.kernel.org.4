Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D22D71214C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242495AbjEZHjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242451AbjEZHj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:39:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ED6E52
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685086743; x=1716622743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xi7TBBQPejEGgobEw64w8lH8esKp08fZJkFWOZYLoxk=;
  b=C7fEt4aTb7pGSywmCDhT+p3q/lea+rfmittXDb1uS+UNcoiissJ0YL1Z
   cDz4f/f2lhoTUuz48G/tuwLDBv8zh3gMfCAOPsReq/p10Yjrs8lR49Zxy
   OvPPCSVwciNy5wI22dfw92xkestRAjvExPucrffC4nZCCsOnFNhcIDZgj
   axyNB/uyGmWP9WZmMyIbkyGg8b0BWSffHuPK7KxpUSSo8JBdnTD8LFQu+
   kpVz0KhpBo7VdyDGFVAYLsfg80Vt6VfV079O6aFyLQSBFVHBm7H7L7f70
   wzVhQWiDlxkOpMuY8If8sH82RHezuV8eTelMp3FhcrQ+Q5BWnrnYYJB1C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="352984372"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="352984372"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 00:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="682641409"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="682641409"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 00:36:55 -0700
Date:   Fri, 26 May 2023 09:36:53 +0200
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
Message-ID: <20230526073653.GA903183@linux.intel.com>
References: <20230526044519.13441-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526044519.13441-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
Acked-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  drivers/accel/ivpu/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -- a/drivers/accel/ivpu/Kconfig b/drivers/accel/ivpu/Kconfig
> --- a/drivers/accel/ivpu/Kconfig
> +++ b/drivers/accel/ivpu/Kconfig
> @@ -7,6 +7,7 @@ config DRM_ACCEL_IVPU
>  	depends on PCI && PCI_MSI
>  	select FW_LOADER
>  	select SHMEM
> +	select GENERIC_ALLOCATOR
>  	help
>  	  Choose this option if you have a system that has an 14th generation Intel CPU
>  	  or newer. VPU stands for Versatile Processing Unit and it's a CPU-integrated
