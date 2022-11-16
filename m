Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFD562BC98
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKPLxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiKPLwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:52:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE3E45EDA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:42:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAC31B81CF8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 11:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC92BC43470;
        Wed, 16 Nov 2022 11:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668598939;
        bh=9eMkKHxHguP0USa1SZGodEQEk/UP3sUe8VUBTS3NJ2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vBTGVzfUtUW0US1GVjN/jUvNNmNHLPz4cYJuPHf6jd1+Xkcf55ckMErcbd2o2M7qk
         Eug1EQOG7XGolWNlyda4U7hTe3vLoyFlOadoQq3yG6M3K5C2EQI5bTzLNQdJNmGJ9u
         x1CeR+IzqAQXaAXl85qE1UaC3k8cJWadkJ8Z1X1w=
Date:   Wed, 16 Nov 2022 12:42:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Fei Li <fei1.li@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/1] virt: acrn: Mark the uuid field as unused
Message-ID: <Y3TMmDXEbGyDQrLF@kroah.com>
References: <20221116092254.66234-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116092254.66234-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 11:22:54AM +0200, Andy Shevchenko wrote:
> After the commits for userspace (see Link tags below) the uuid field is
> not being used in the ACRN code. Update kernel to reflect these changes.
> I.e. we do the following:
> - adding a comment explaining that it's not used anymore
> - replacing the specific type by a raw buffer
> - updating the example code accordingly
> 
> The advertised field confused users and actually never been used. So
> the wrong part here is that kernel puts something which userspace never
> used and hence this may confuse a reader of this code.
> 
> Link: https://github.com/projectacrn/acrn-hypervisor/commit/da0d24326ed6
> Link: https://github.com/projectacrn/acrn-hypervisor/commit/bb0327e70097
> Fixes: 5b06931d7f8b ("sample/acrn: Introduce a sample of HSM ioctl interface usage")
> Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> ---
> v4: added tag (Rafael), Cc'ed to Greg (missing in the previous version
>     by some reason)
> v3: converted to Link tags (Rafael), explained what was wrong (Rafael)
> v2: added tag (Fei)
> 
>  include/uapi/linux/acrn.h | 5 ++---
>  samples/acrn/vm-sample.c  | 3 ---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
> index ccf47ed92500..04fa83647ae5 100644
> --- a/include/uapi/linux/acrn.h
> +++ b/include/uapi/linux/acrn.h
> @@ -12,7 +12,6 @@
>  #define _UAPI_ACRN_H
>  
>  #include <linux/types.h>
> -#include <linux/uuid.h>
>  
>  #define ACRN_IO_REQUEST_MAX		16
>  
> @@ -186,7 +185,7 @@ struct acrn_ioreq_notify {
>   * @reserved0:		Reserved and must be 0
>   * @vcpu_num:		Number of vCPU in the VM. Return from hypervisor.
>   * @reserved1:		Reserved and must be 0
> - * @uuid:		UUID of the VM. Pass to hypervisor directly.
> + * @uuid:		Reserved (used to be UUID of the VM)

If it's reserved, then don't you need to check for 0?

>   * @vm_flag:		Flag of the VM creating. Pass to hypervisor directly.
>   * @ioreq_buf:		Service VM GPA of I/O request buffer. Pass to
>   *			hypervisor directly.
> @@ -198,7 +197,7 @@ struct acrn_vm_creation {
>  	__u16	reserved0;
>  	__u16	vcpu_num;
>  	__u16	reserved1;
> -	guid_t	uuid;
> +	__u8	uuid[16];

You just changed the type here, so what is that going to break in
userspace that depended on this being of a structure type and now it's
an array?

And no other kernel changes needed?  Shouldn't you warn if this field is
set?

thanks,

greg k-h
