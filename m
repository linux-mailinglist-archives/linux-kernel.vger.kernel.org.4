Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A23745CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjGCNSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGCNSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:18:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D332DD;
        Mon,  3 Jul 2023 06:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688390286; x=1719926286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q9red++a7t+gy/PBtG/dUUL+ASrJIW9QtWFKUQBt+m8=;
  b=JyyDsVN/CiXJXoKynbdFXQiV6I+zobgWqhWo0liwVz/edO9aR6UeAAue
   vbmdywr1j/LX5Sbhb/F7n7opHDivOdXlK4Z7fwT10lGU67ffx5XOpsfHI
   pi2rCwTF8HTro0CkirdTyqlgc5YFmKA2vr9oHLjeTPy12NwLtLuTa1Fgq
   hQZGJMwULa+TLbd/i9Lr/XKXpmZlbLcuw0vl5KN0O8jwQKQIcz+G+WsuS
   DQYls128ZkjC9nUCqn5suYD6ILXNBExd3XJfa2GEaB8h266iKFQCOIvlG
   zdGyLdzf0+AAmzfRbVa68nwNmSqNJerCh8u+RGW1wxstPefLa7l9Hc4XP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="342472288"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="342472288"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 06:18:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="788524789"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="788524789"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jul 2023 06:18:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qGJRJ-001s1d-0Y;
        Mon, 03 Jul 2023 16:18:01 +0300
Date:   Mon, 3 Jul 2023 16:18:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     You Kangren <youkangren@vivo.com>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Adam Guerin <adam.guerin@intel.com>,
        Srinivas Kerekare <srinivas.kerekare@intel.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        "open list:QAT DRIVER" <qat-linux@intel.com>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v3] crypto: qat - Replace the if statement with min()
Message-ID: <ZKLKiJKs7NDXeM7V@smile.fi.intel.com>
References: <20230703123739.28142-1-youkangren@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703123739.28142-1-youkangren@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 08:37:36PM +0800, You Kangren wrote:
> mark UWORD_CPYBUF_SIZE with U suffix to make the type the same with
> words_num and replace the if statement with min()

Makes code shorter,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: You Kangren <youkangren@vivo.com>
> ---
>  drivers/crypto/intel/qat/qat_common/qat_uclo.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/crypto/intel/qat/qat_common/qat_uclo.c b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
> index ce837bcc1cab..bad65f154777 100644
> --- a/drivers/crypto/intel/qat/qat_common/qat_uclo.c
> +++ b/drivers/crypto/intel/qat/qat_common/qat_uclo.c
> @@ -5,13 +5,14 @@
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/pci_ids.h>
> +#include <linux/minmax.h>
>  #include "adf_accel_devices.h"
>  #include "adf_common_drv.h"
>  #include "icp_qat_uclo.h"
>  #include "icp_qat_hal.h"
>  #include "icp_qat_fw_loader_handle.h"
>  
> -#define UWORD_CPYBUF_SIZE 1024
> +#define UWORD_CPYBUF_SIZE 1024U
>  #define INVLD_UWORD 0xffffffffffull
>  #define PID_MINOR_REV 0xf
>  #define PID_MAJOR_REV (0xf << 4)
> @@ -1986,10 +1987,7 @@ static void qat_uclo_wr_uimage_raw_page(struct icp_qat_fw_loader_handle *handle,
>  	uw_relative_addr = 0;
>  	words_num = encap_page->micro_words_num;
>  	while (words_num) {
> -		if (words_num < UWORD_CPYBUF_SIZE)
> -			cpylen = words_num;
> -		else
> -			cpylen = UWORD_CPYBUF_SIZE;
> +		cpylen = min(words_num, UWORD_CPYBUF_SIZE);
>  
>  		/* load the buffer */
>  		for (i = 0; i < cpylen; i++)
> -- 
> 2.39.0
> 

-- 
With Best Regards,
Andy Shevchenko


