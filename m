Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61835FA043
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJJOeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJJOeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:34:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB5F6050F;
        Mon, 10 Oct 2022 07:34:18 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MmLws3kFVz67Dqh;
        Mon, 10 Oct 2022 22:32:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 16:34:16 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 10 Oct
 2022 15:34:16 +0100
Date:   Mon, 10 Oct 2022 15:34:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Robert Richter" <rrichter@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Terry Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH 2/2] efi/cper, cxl: Decode CXL Error Log
Message-ID: <20221010153415.00004bc0@huawei.com>
In-Reply-To: <20221007211714.71129-3-Smita.KoralahalliChannabasappa@amd.com>
References: <20221007211714.71129-1-Smita.KoralahalliChannabasappa@amd.com>
        <20221007211714.71129-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2022 21:17:14 +0000
Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> Print the CXL Error Log field as found in CXL Protocol Error Section.
> 
> The CXL RAS Capability structure will be reused by OS First Handling
> and the duplication/appropriate placement will be addressed eventually.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Ah. This clearly answers at least a few comments from my patch one review.
I should have read on!

> ---
>  drivers/firmware/efi/cper_cxl.c | 21 +++++++++++++++++++++
>  include/linux/cxl_err.h         | 21 +++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 include/linux/cxl_err.h
> 
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index e5f48f0de1a4..c3d1d0770aef 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/cper.h>
> +#include <linux/cxl_err.h>
>  #include "cper_cxl.h"
>  
>  #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
> @@ -16,6 +17,7 @@
>  #define PROT_ERR_VALID_SERIAL_NUMBER		BIT_ULL(3)
>  #define PROT_ERR_VALID_CAPABILITY		BIT_ULL(4)
>  #define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
> +#define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
>  
>  static const char * const prot_err_agent_type_strs[] = {
>  	"Restricted CXL Device",
> @@ -84,4 +86,23 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
>  			break;
>  		}
>  	}
> +
> +	if (prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG) {
> +		size_t size = sizeof(*prot_err) + prot_err->dvsec_len;
> +		struct ras_capability_regs *cxl_ras;
> +
> +		pr_info("%s Error log length: 0x%04x\n", pfx, prot_err->err_len);
> +
> +		pr_info("%s CXL Error Log:\n", pfx);
> +		cxl_ras = (struct ras_capability_regs *)((long)prot_err + size);
> +		pr_info("%s cxl_ras_uncor_status: 0x%08x, cxl_ras_uncor_mask: 0x%08x\n",
> +			pfx, cxl_ras->uncor_status, cxl_ras->uncor_mask);
Is it worth splitting these up, so that we get a human readable line with the
individual fields broken out?

> +		pr_info("%s cxl_ras_uncor_severity: 0x%08x\n", pfx,
> +			cxl_ras->uncor_severity);
> +		pr_info("%s cxl_ras_cor_status: 0x%08x, cxl_ras_cor_mask: 0x%08x\n",
> +			pfx, cxl_ras->cor_status, cxl_ras->cor_mask);

Not outputting the cap_control register?  Some of that might be useful.

> +		pr_info("%s Header Log Registers:\n", pfx);
> +		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, cxl_ras->header_log,
> +			       sizeof(cxl_ras->header_log), 0);
> +	}
>  }
> diff --git a/include/linux/cxl_err.h b/include/linux/cxl_err.h
> new file mode 100644
> index 000000000000..c89dbb6c286f
> --- /dev/null
> +++ b/include/linux/cxl_err.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2022 Advanced Micro Devices, Inc.
> + *
> + * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> + */
> +
> +#ifndef LINUX_CXL_ERR_H
> +#define LINUX_CXL_ERR_H
> +
> +struct ras_capability_regs {

CXL r3.0 Spec reference plus prefix it with cxl_ 

Agreed with your comment at the top. Some discussion needed on where to
put this - or whether to delay figuring that out until a later stage.

> +	u32 uncor_status;
> +	u32 uncor_mask;
> +	u32 uncor_severity;
> +	u32 cor_status;
> +	u32 cor_mask;
> +	u32 cap_control;
> +	u32 header_log[16];
> +};
> +
> +#endif //__CXL_ERR_

