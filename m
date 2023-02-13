Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA40693ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBMHMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBMHMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:12:46 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876D0C172
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676272365; x=1707808365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oDApUliXcaJviTBYjIi5M5cuBczUHP+iwTF6Q32uhFk=;
  b=hHeHsC+nhrraboR161YvhnRvXXPl4oCpWWe4Ws9ZCRRFTyazc3bJr6kN
   WVF3L6WrM4b2SkFEEHXRkS0p4Jy3K2z6vgtvN4lgIteekADGu9hu3XMtO
   jFXi8fX8AquXHDAyo+5gf7Rg7HbcIVY9ygvVv5blGcpX+5ebrgz5XNoPe
   bckwZ8mVX1CFTSFtbJ8UyVsgyJDFV5KhVECxRW3Ft2/cWcF1WN0v5b4gu
   0S6t5mBMOATvxQHJTK1mByz86+49Rkfv1k9cDN7PewJQAdlcgE2YPh1km
   MDDOJfzj45Ksnk+sYQN5T45LTi+MG7hBwX10SowrT59PIlbQFb5IxYqV4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="332134584"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="332134584"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 23:12:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="997597947"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="997597947"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 23:12:43 -0800
Date:   Mon, 13 Feb 2023 08:12:41 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     ogabbay@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        kelbaz@habana.ai, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] habanalabs: change unused extern decl of hdev to forward
 decl of hl_device
Message-ID: <20230213071241.GA2799422@linux.intel.com>
References: <20230208155450.1941608-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230208155450.1941608-1-trix@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 07:54:50AM -0800, Tom Rix wrote:
> Building with clang W=2 has several similar warnings
> drivers/accel/habanalabs/common/decoder.c:46:51: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
> static void dec_error_intr_work(struct hl_device *hdev, u32 base_addr, u32 core_id)
>                                                   ^
> drivers/accel/habanalabs/common/security.h:13:26: note: previous declaration is here
> extern struct hl_device *hdev;
>                          ^
> 
> There is no global definition of hdev, so the extern is not needed.
> Searched with
> grep -r '^struct' . | grep hl_dev
> 
> Change to an forward decl to resolve these issues
> drivers/accel/habanalabs/common/mmu/../security.h:133:40: error: ‘struct hl_device’ declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>   133 |         bool (*skip_block_hook)(struct hl_device *hdev,
>       |                                        ^~~~~~~~~
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  drivers/accel/habanalabs/common/security.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/habanalabs/common/security.h b/drivers/accel/habanalabs/common/security.h
> index 234b4a6ed8bc..d7a3b3e82ea4 100644
> --- a/drivers/accel/habanalabs/common/security.h
> +++ b/drivers/accel/habanalabs/common/security.h
> @@ -10,7 +10,7 @@
>  
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  
> -extern struct hl_device *hdev;
> +struct hl_device;
>  
>  /* special blocks */
>  #define HL_MAX_NUM_OF_GLBL_ERR_CAUSE		10
> -- 
> 2.26.3
> 
