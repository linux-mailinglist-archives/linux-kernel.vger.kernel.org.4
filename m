Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E262E6D136E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjC3XnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjC3Xm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:42:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C955258;
        Thu, 30 Mar 2023 16:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680219777; x=1711755777;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CFJSYS3L7IITfkuAPvL450Q/OlTcyxe+FFkcSS4PzzA=;
  b=iNOFH7+hRUlKHPBNl8tbninly5RKZS/vzQUndfyx1ifUbDTqZQPqdPeH
   OTEQNN+UVmnQRP19BSyQcrC30bvYuC5Efm1qp3EYxrpLyHjvGcJ70u2Hw
   XJwh+mcyFCDeH/0A8KLf9ReYvXCXt1E3qpnV8qg/qoUuCzshrqQ1WRAgi
   ZHOdPaJx8f2pfG5FNb45GC5YPn+egXppB43y46z6+NbpvLW/ku9Vu6VSv
   XTSF6tDs4vNNxkaJOs40ooYQnhuzUAVnGbCtiE5ks0krWxsEe1nlXm0Xq
   558Wu13NEXkER1Sy88to47O9CEmWCZr+cB4v+ZdOAV+OSf9qlQOR4nhBG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="329836695"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="329836695"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 16:42:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="808835638"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="808835638"
Received: from mwest-mobl.amr.corp.intel.com (HELO [10.212.117.86]) ([10.212.117.86])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 16:42:56 -0700
Message-ID: <627a4359-cac4-bef9-9033-ea782f47cbc7@intel.com>
Date:   Thu, 30 Mar 2023 16:42:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v10 6/6] tools/testing/cxl: Mock support for Get Poison
 List
Content-Language: en-US
To:     alison.schofield@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <cover.1679448904.git.alison.schofield@intel.com>
 <bac0ec2f8afdb0c28790b1595af49ac6fada0672.1679448904.git.alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <bac0ec2f8afdb0c28790b1595af49ac6fada0672.1679448904.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/23 7:12 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Make mock memdevs support the Get Poison List mailbox command.
> Return a fake poison error record when the get poison list command
> is issued.
> 
> This supports testing the kernel tracing and cxl list capabilities
> for media errors.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   tools/testing/cxl/test/mem.c | 42 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 9263b04d35f7..2fa9c18d4c2c 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -7,6 +7,7 @@
>   #include <linux/delay.h>
>   #include <linux/sizes.h>
>   #include <linux/bits.h>
> +#include <asm/unaligned.h>
>   #include <cxlmem.h>
>   
>   #include "trace.h"
> @@ -40,6 +41,10 @@ static struct cxl_cel_entry mock_cel[] = {
>   		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
>   		.effect = cpu_to_le16(0),
>   	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
> +		.effect = cpu_to_le16(0),
> +	},
>   };
>   
>   /* See CXL 2.0 Table 181 Get Health Info Output Payload */
> @@ -471,6 +476,8 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   			cpu_to_le64(DEV_SIZE / CXL_CAPACITY_MULTIPLIER),
>   	};
>   
> +	put_unaligned_le24(CXL_POISON_LIST_MAX, id.poison_list_max_mer);
> +
>   	if (cmd->size_out < sizeof(id))
>   		return -EINVAL;
>   
> @@ -888,6 +895,34 @@ static int mock_health_info(struct cxl_dev_state *cxlds,
>   	return 0;
>   }
>   
> +static int mock_get_poison(struct cxl_dev_state *cxlds,
> +			   struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_poison_payload_in *pi = cmd->payload_in;
> +
> +	/* Mock one poison record at pi.offset for 64 bytes */
> +	struct {
> +		struct cxl_mbox_poison_payload_out po;
> +		struct cxl_poison_record record;
> +	} __packed mock_plist = {
> +		.po = {
> +			.count = cpu_to_le16(1),
> +		},
> +		.record = {
> +			.length = cpu_to_le32(1),
> +			.address = cpu_to_le64(le64_to_cpu(pi->offset) +
> +					       CXL_POISON_SOURCE_INJECTED),
> +		},
> +	};
> +
> +	if (cmd->size_out < sizeof(mock_plist))
> +		return -EINVAL;
> +
> +	memcpy(cmd->payload_out, &mock_plist, sizeof(mock_plist));
> +	cmd->size_out = sizeof(mock_plist);
> +	return 0;
> +}
> +
>   static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   {
>   	struct device *dev = cxlds->dev;
> @@ -942,6 +977,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>   	case CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE:
>   		rc = mock_passphrase_secure_erase(cxlds, cmd);
>   		break;
> +	case CXL_MBOX_OP_GET_POISON:
> +		rc = mock_get_poison(cxlds, cmd);
> +		break;
>   	default:
>   		break;
>   	}
> @@ -1010,6 +1048,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   	if (rc)
>   		return rc;
>   
> +	rc = cxl_poison_state_init(cxlds);
> +	if (rc)
> +		return rc;
> +
>   	rc = cxl_dev_state_identify(cxlds);
>   	if (rc)
>   		return rc;
