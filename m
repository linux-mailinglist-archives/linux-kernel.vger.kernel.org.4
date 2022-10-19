Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0936047A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiJSNmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbiJSNls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:41:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C142A24F1C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666186150; x=1697722150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yZj4UEN+B3a8Kk2/d9hYXrDFIOMBCx70PYm2jCFaBRc=;
  b=WulgZ8xHUtDdj/GVgZ53Cqvc4oa2tJVFOUcSx3dYVDoseoCLIw24kaXR
   oEpXjim1jn9HW74cakHm0BqKNf3Wlynb2mLF4D17BlyPHYuc5Qd7e8zqd
   pOIyBGOx4iKUZKBoI/fVDNlGpDnQj18I8gyd7Df4tw1cpJYqat40LYUMy
   7Ymc4wPEJFanHhuGva5VjWGUSj7Zfvts6SBqn5CE3/byeeC5yfqvv+OsB
   30A8wsBFMmzl24ibJbGdf3jkH+Xl6vB5t+7HPvfYAtXz+HSsrQZ4e3IJS
   qu7yTXZWmlQkkk3StE8nTdTZad9HOnvcYpp083zNvdjsl1ExVDRkHoEq1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="370626276"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="370626276"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 06:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="580339685"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="580339685"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 19 Oct 2022 06:27:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ol96q-009sMy-0G;
        Wed, 19 Oct 2022 16:27:48 +0300
Date:   Wed, 19 Oct 2022 16:27:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Shuo Liu <shuo.a.liu@intel.com>, linux-kernel@vger.kernel.org
Cc:     Fei Li <fei1.li@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/1] virt: acrn: Mark the uuid field as unused
Message-ID: <Y0/7U6yCuoIlKWyQ@smile.fi.intel.com>
References: <20220831122356.65544-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831122356.65544-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 03:23:56PM +0300, Andy Shevchenko wrote:
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

Rafael, I think I have addressed all your concerns.
Anything else should I do?

> Link: https://github.com/projectacrn/acrn-hypervisor/commit/da0d24326ed6
> Link: https://github.com/projectacrn/acrn-hypervisor/commit/bb0327e70097
> Fixes: 5b06931d7f8b ("sample/acrn: Introduce a sample of HSM ioctl interface usage")
> Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3: converted to Link tags (Rafael), explained what was wrong (Rafael)
> v2: added tag (Fei)
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
>   * @vm_flag:		Flag of the VM creating. Pass to hypervisor directly.
>   * @ioreq_buf:		Service VM GPA of I/O request buffer. Pass to
>   *			hypervisor directly.
> @@ -198,7 +197,7 @@ struct acrn_vm_creation {
>  	__u16	reserved0;
>  	__u16	vcpu_num;
>  	__u16	reserved1;
> -	guid_t	uuid;
> +	__u8	uuid[16];
>  	__u64	vm_flag;
>  	__u64	ioreq_buf;
>  	__u64	cpu_affinity;
> diff --git a/samples/acrn/vm-sample.c b/samples/acrn/vm-sample.c
> index b2dad47a77a0..7abd68b20153 100644
> --- a/samples/acrn/vm-sample.c
> +++ b/samples/acrn/vm-sample.c
> @@ -29,8 +29,6 @@ static struct acrn_io_request *io_req_buf = (struct acrn_io_request *)io_request
>  
>  __u16 vcpu_num;
>  __u16 vmid;
> -/* POST_STANDARD_VM_UUID1, refer to https://github.com/projectacrn/acrn-hypervisor/blob/master/hypervisor/include/common/vm_uuids.h */
> -guid_t vm_uuid = GUID_INIT(0x385479d2, 0xd625, 0xe811, 0x86, 0x4e, 0xcb, 0x7a, 0x18, 0xb3, 0x46, 0x43);
>  
>  int hsm_fd;
>  int is_running = 1;
> @@ -63,7 +61,6 @@ int main(int argc, char **argv)
>  	}
>  	hsm_fd = open("/dev/acrn_hsm", O_RDWR|O_CLOEXEC);
>  
> -	memcpy(&create_vm.uuid, &vm_uuid, 16);
>  	create_vm.ioreq_buf = (__u64)io_req_buf;
>  	ret = ioctl(hsm_fd, ACRN_IOCTL_CREATE_VM, &create_vm);
>  	printf("Created VM! [%d]\n", ret);
> -- 
> 2.35.1
> 

-- 
With Best Regards,
Andy Shevchenko


