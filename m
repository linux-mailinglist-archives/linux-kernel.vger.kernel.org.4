Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EAF63EFBF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiLALnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiLALnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:43:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 365B099532
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:43:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96209D6E;
        Thu,  1 Dec 2022 03:43:17 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 391693F73D;
        Thu,  1 Dec 2022 03:43:09 -0800 (PST)
Date:   Thu, 1 Dec 2022 11:43:06 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Walbran <qwandor@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 01/12] firmware: arm_ffa: Move constants to header file
Message-ID: <20221201114306.t6pqniscymm2uizx@bogus>
References: <20221116170335.2341003-1-qperret@google.com>
 <20221116170335.2341003-2-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116170335.2341003-2-qperret@google.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 05:03:24PM +0000, Quentin Perret wrote:
> From: Will Deacon <will@kernel.org>
> 
> FF-A function IDs and error codes will be needed in the hypervisor too,
> so move to them to the header file where they can be shared. Rename the
> version constants with an "FFA_" prefix so that they are less likely
> to clash with other code in the tree.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> Co-developed-by: Andrew Walbran <qwandor@google.com>
> Signed-off-by: Andrew Walbran <qwandor@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 101 +++---------------------------
>  include/linux/arm_ffa.h           |  83 ++++++++++++++++++++++++
>  2 files changed, 93 insertions(+), 91 deletions(-)
> 
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index d5e86ef40b89..fa85c64d3ded 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -36,81 +36,6 @@
>  #include "common.h"
>  
>  #define FFA_DRIVER_VERSION	FFA_VERSION_1_0
> -
> -#define FFA_SMC(calling_convention, func_num)				\
> -	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, (calling_convention),	\
> -			   ARM_SMCCC_OWNER_STANDARD, (func_num))
> -
> -#define FFA_SMC_32(func_num)	FFA_SMC(ARM_SMCCC_SMC_32, (func_num))
> -#define FFA_SMC_64(func_num)	FFA_SMC(ARM_SMCCC_SMC_64, (func_num))
> -
> -#define FFA_ERROR			FFA_SMC_32(0x60)
> -#define FFA_SUCCESS			FFA_SMC_32(0x61)
> -#define FFA_INTERRUPT			FFA_SMC_32(0x62)
> -#define FFA_VERSION			FFA_SMC_32(0x63)
> -#define FFA_FEATURES			FFA_SMC_32(0x64)
> -#define FFA_RX_RELEASE			FFA_SMC_32(0x65)
> -#define FFA_RXTX_MAP			FFA_SMC_32(0x66)
> -#define FFA_FN64_RXTX_MAP		FFA_SMC_64(0x66)
> -#define FFA_RXTX_UNMAP			FFA_SMC_32(0x67)
> -#define FFA_PARTITION_INFO_GET		FFA_SMC_32(0x68)
> -#define FFA_ID_GET			FFA_SMC_32(0x69)
> -#define FFA_MSG_POLL			FFA_SMC_32(0x6A)
> -#define FFA_MSG_WAIT			FFA_SMC_32(0x6B)
> -#define FFA_YIELD			FFA_SMC_32(0x6C)
> -#define FFA_RUN				FFA_SMC_32(0x6D)
> -#define FFA_MSG_SEND			FFA_SMC_32(0x6E)
> -#define FFA_MSG_SEND_DIRECT_REQ		FFA_SMC_32(0x6F)
> -#define FFA_FN64_MSG_SEND_DIRECT_REQ	FFA_SMC_64(0x6F)
> -#define FFA_MSG_SEND_DIRECT_RESP	FFA_SMC_32(0x70)
> -#define FFA_FN64_MSG_SEND_DIRECT_RESP	FFA_SMC_64(0x70)
> -#define FFA_MEM_DONATE			FFA_SMC_32(0x71)
> -#define FFA_FN64_MEM_DONATE		FFA_SMC_64(0x71)
> -#define FFA_MEM_LEND			FFA_SMC_32(0x72)
> -#define FFA_FN64_MEM_LEND		FFA_SMC_64(0x72)
> -#define FFA_MEM_SHARE			FFA_SMC_32(0x73)
> -#define FFA_FN64_MEM_SHARE		FFA_SMC_64(0x73)
> -#define FFA_MEM_RETRIEVE_REQ		FFA_SMC_32(0x74)
> -#define FFA_FN64_MEM_RETRIEVE_REQ	FFA_SMC_64(0x74)
> -#define FFA_MEM_RETRIEVE_RESP		FFA_SMC_32(0x75)
> -#define FFA_MEM_RELINQUISH		FFA_SMC_32(0x76)
> -#define FFA_MEM_RECLAIM			FFA_SMC_32(0x77)
> -#define FFA_MEM_OP_PAUSE		FFA_SMC_32(0x78)
> -#define FFA_MEM_OP_RESUME		FFA_SMC_32(0x79)
> -#define FFA_MEM_FRAG_RX			FFA_SMC_32(0x7A)
> -#define FFA_MEM_FRAG_TX			FFA_SMC_32(0x7B)
> -#define FFA_NORMAL_WORLD_RESUME		FFA_SMC_32(0x7C)
> -
> -/*
> - * For some calls it is necessary to use SMC64 to pass or return 64-bit values.
> - * For such calls FFA_FN_NATIVE(name) will choose the appropriate
> - * (native-width) function ID.
> - */
> -#ifdef CONFIG_64BIT
> -#define FFA_FN_NATIVE(name)	FFA_FN64_##name
> -#else
> -#define FFA_FN_NATIVE(name)	FFA_##name
> -#endif
> -
> -/* FFA error codes. */
> -#define FFA_RET_SUCCESS            (0)
> -#define FFA_RET_NOT_SUPPORTED      (-1)
> -#define FFA_RET_INVALID_PARAMETERS (-2)
> -#define FFA_RET_NO_MEMORY          (-3)
> -#define FFA_RET_BUSY               (-4)
> -#define FFA_RET_INTERRUPTED        (-5)
> -#define FFA_RET_DENIED             (-6)
> -#define FFA_RET_RETRY              (-7)
> -#define FFA_RET_ABORTED            (-8)
> -
> -#define MAJOR_VERSION_MASK	GENMASK(30, 16)
> -#define MINOR_VERSION_MASK	GENMASK(15, 0)
> -#define MAJOR_VERSION(x)	((u16)(FIELD_GET(MAJOR_VERSION_MASK, (x))))
> -#define MINOR_VERSION(x)	((u16)(FIELD_GET(MINOR_VERSION_MASK, (x))))
> -#define PACK_VERSION_INFO(major, minor)			\
> -	(FIELD_PREP(MAJOR_VERSION_MASK, (major)) |	\
> -	 FIELD_PREP(MINOR_VERSION_MASK, (minor)))
> -#define FFA_VERSION_1_0		PACK_VERSION_INFO(1, 0)
>  #define FFA_MIN_VERSION		FFA_VERSION_1_0
>  
>  #define SENDER_ID_MASK		GENMASK(31, 16)
> @@ -120,12 +45,6 @@
>  #define PACK_TARGET_INFO(s, r)		\
>  	(FIELD_PREP(SENDER_ID_MASK, (s)) | FIELD_PREP(RECEIVER_ID_MASK, (r)))
>  
> -/*
> - * FF-A specification mentions explicitly about '4K pages'. This should
> - * not be confused with the kernel PAGE_SIZE, which is the translation
> - * granule kernel is configured and may be one among 4K, 16K and 64K.
> - */
> -#define FFA_PAGE_SIZE		SZ_4K
>  /*
>   * Keeping RX TX buffer size as 4K for now
>   * 64K may be preferred to keep it min a page in 64K PAGE_SIZE config
> @@ -178,9 +97,9 @@ static struct ffa_drv_info *drv_info;
>   */
>  static u32 ffa_compatible_version_find(u32 version)
>  {
> -	u16 major = MAJOR_VERSION(version), minor = MINOR_VERSION(version);
> -	u16 drv_major = MAJOR_VERSION(FFA_DRIVER_VERSION);
> -	u16 drv_minor = MINOR_VERSION(FFA_DRIVER_VERSION);
> +	u16 major = FFA_MAJOR_VERSION(version), minor = FFA_MINOR_VERSION(version);
> +	u16 drv_major = FFA_MAJOR_VERSION(FFA_DRIVER_VERSION);
> +	u16 drv_minor = FFA_MINOR_VERSION(FFA_DRIVER_VERSION);
>  
>  	if ((major < drv_major) || (major == drv_major && minor <= drv_minor))
>  		return version;
> @@ -204,16 +123,16 @@ static int ffa_version_check(u32 *version)
>  
>  	if (ver.a0 < FFA_MIN_VERSION) {
>  		pr_err("Incompatible v%d.%d! Earliest supported v%d.%d\n",
> -		       MAJOR_VERSION(ver.a0), MINOR_VERSION(ver.a0),
> -		       MAJOR_VERSION(FFA_MIN_VERSION),
> -		       MINOR_VERSION(FFA_MIN_VERSION));
> +		       FFA_MAJOR_VERSION(ver.a0), FFA_MINOR_VERSION(ver.a0),
> +		       FFA_MAJOR_VERSION(FFA_MIN_VERSION),
> +		       FFA_MINOR_VERSION(FFA_MIN_VERSION));
>  		return -EINVAL;
>  	}
>  
> -	pr_info("Driver version %d.%d\n", MAJOR_VERSION(FFA_DRIVER_VERSION),
> -		MINOR_VERSION(FFA_DRIVER_VERSION));
> -	pr_info("Firmware version %d.%d found\n", MAJOR_VERSION(ver.a0),
> -		MINOR_VERSION(ver.a0));
> +	pr_info("Driver version %d.%d\n", FFA_MAJOR_VERSION(FFA_DRIVER_VERSION),
> +		FFA_MINOR_VERSION(FFA_DRIVER_VERSION));
> +	pr_info("Firmware version %d.%d found\n", FFA_MAJOR_VERSION(ver.a0),
> +		FFA_MINOR_VERSION(ver.a0));
>  	*version = ffa_compatible_version_find(ver.a0);
>  
>  	return 0;
> diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> index 5f02d2e6b9d9..daff44d777fa 100644
> --- a/include/linux/arm_ffa.h
> +++ b/include/linux/arm_ffa.h
> @@ -11,6 +11,89 @@
>  #include <linux/types.h>
>  #include <linux/uuid.h>
>  
> +#define FFA_SMC(calling_convention, func_num)				\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, (calling_convention),	\
> +			   ARM_SMCCC_OWNER_STANDARD, (func_num))
> +
> +#define FFA_SMC_32(func_num)	FFA_SMC(ARM_SMCCC_SMC_32, (func_num))
> +#define FFA_SMC_64(func_num)	FFA_SMC(ARM_SMCCC_SMC_64, (func_num))
> +
> +#define FFA_ERROR			FFA_SMC_32(0x60)
> +#define FFA_SUCCESS			FFA_SMC_32(0x61)
> +#define FFA_INTERRUPT			FFA_SMC_32(0x62)
> +#define FFA_VERSION			FFA_SMC_32(0x63)
> +#define FFA_FEATURES			FFA_SMC_32(0x64)
> +#define FFA_RX_RELEASE			FFA_SMC_32(0x65)
> +#define FFA_RXTX_MAP			FFA_SMC_32(0x66)
> +#define FFA_FN64_RXTX_MAP		FFA_SMC_64(0x66)
> +#define FFA_RXTX_UNMAP			FFA_SMC_32(0x67)
> +#define FFA_PARTITION_INFO_GET		FFA_SMC_32(0x68)
> +#define FFA_ID_GET			FFA_SMC_32(0x69)
> +#define FFA_MSG_POLL			FFA_SMC_32(0x6A)
> +#define FFA_MSG_WAIT			FFA_SMC_32(0x6B)
> +#define FFA_YIELD			FFA_SMC_32(0x6C)
> +#define FFA_RUN				FFA_SMC_32(0x6D)
> +#define FFA_MSG_SEND			FFA_SMC_32(0x6E)
> +#define FFA_MSG_SEND_DIRECT_REQ		FFA_SMC_32(0x6F)
> +#define FFA_FN64_MSG_SEND_DIRECT_REQ	FFA_SMC_64(0x6F)
> +#define FFA_MSG_SEND_DIRECT_RESP	FFA_SMC_32(0x70)
> +#define FFA_FN64_MSG_SEND_DIRECT_RESP	FFA_SMC_64(0x70)
> +#define FFA_MEM_DONATE			FFA_SMC_32(0x71)
> +#define FFA_FN64_MEM_DONATE		FFA_SMC_64(0x71)
> +#define FFA_MEM_LEND			FFA_SMC_32(0x72)
> +#define FFA_FN64_MEM_LEND		FFA_SMC_64(0x72)
> +#define FFA_MEM_SHARE			FFA_SMC_32(0x73)
> +#define FFA_FN64_MEM_SHARE		FFA_SMC_64(0x73)
> +#define FFA_MEM_RETRIEVE_REQ		FFA_SMC_32(0x74)
> +#define FFA_FN64_MEM_RETRIEVE_REQ	FFA_SMC_64(0x74)
> +#define FFA_MEM_RETRIEVE_RESP		FFA_SMC_32(0x75)
> +#define FFA_MEM_RELINQUISH		FFA_SMC_32(0x76)
> +#define FFA_MEM_RECLAIM			FFA_SMC_32(0x77)
> +#define FFA_MEM_OP_PAUSE		FFA_SMC_32(0x78)
> +#define FFA_MEM_OP_RESUME		FFA_SMC_32(0x79)
> +#define FFA_MEM_FRAG_RX			FFA_SMC_32(0x7A)
> +#define FFA_MEM_FRAG_TX			FFA_SMC_32(0x7B)
> +#define FFA_NORMAL_WORLD_RESUME		FFA_SMC_32(0x7C)
> +
> +/*
> + * For some calls it is necessary to use SMC64 to pass or return 64-bit values.
> + * For such calls FFA_FN_NATIVE(name) will choose the appropriate
> + * (native-width) function ID.
> + */
> +#ifdef CONFIG_64BIT
> +#define FFA_FN_NATIVE(name)	FFA_FN64_##name
> +#else
> +#define FFA_FN_NATIVE(name)	FFA_##name
> +#endif
> +
> +/* FFA error codes. */
> +#define FFA_RET_SUCCESS            (0)
> +#define FFA_RET_NOT_SUPPORTED      (-1)
> +#define FFA_RET_INVALID_PARAMETERS (-2)
> +#define FFA_RET_NO_MEMORY          (-3)
> +#define FFA_RET_BUSY               (-4)
> +#define FFA_RET_INTERRUPTED        (-5)
> +#define FFA_RET_DENIED             (-6)
> +#define FFA_RET_RETRY              (-7)
> +#define FFA_RET_ABORTED            (-8)
> +
> +/* FFA version encoding */
> +#define FFA_MAJOR_VERSION_MASK	GENMASK(30, 16)
> +#define FFA_MINOR_VERSION_MASK	GENMASK(15, 0)
> +#define FFA_MAJOR_VERSION(x)	((u16)(FIELD_GET(FFA_MAJOR_VERSION_MASK, (x))))
> +#define FFA_MINOR_VERSION(x)	((u16)(FIELD_GET(FFA_MINOR_VERSION_MASK, (x))))
> +#define FFA_PACK_VERSION_INFO(major, minor)			\
> +	(FIELD_PREP(FFA_MAJOR_VERSION_MASK, (major)) |		\
> +	 FIELD_PREP(FFA_MINOR_VERSION_MASK, (minor)))
> +#define FFA_VERSION_1_0		FFA_PACK_VERSION_INFO(1, 0)
> +
> +/**
> + * FF-A specification mentions explicitly about '4K pages'. This should
> + * not be confused with the kernel PAGE_SIZE, which is the translation
> + * granule kernel is configured and may be one among 4K, 16K and 64K.
> + */
> +#define FFA_PAGE_SIZE		SZ_4K
> +
>  /* FFA Bus/Device/Driver related */
>  struct ffa_device {
>  	int vm_id;
> -- 
> 2.38.1.431.g37b22c650d-goog
> 

-- 
Regards,
Sudeep
