Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68EF679EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjAXQcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjAXQb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:31:59 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921DD59D3;
        Tue, 24 Jan 2023 08:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674577918; x=1706113918;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OvNpWuC+w4Wd0rSZuW0EhaDQzPNd74u6nMFDok7/of0=;
  b=i6ZybJJgQVidlk4AbDZERpoEOu68bDGGmitRnRDAz5wHJHJ3XxUVtcTa
   4m5VOJm6z1cmXl2gQkxrSGv+pzMfZ59VzzQePoemKGGef9s/0NZ67RC5q
   KLNW33JKsS6MztWRFXgJDtAOjMw/K2nXuhU4F4g9FbDRTg38Pn5nMAwUc
   l0qAvjRbnpBpInmvSlisk3KYjgWl1CXGhx8BzxV2ibYx7+EGd/macIsIB
   RZj3CX1eqaZBgxGdbPA96ohTdBJFmnrI7+JDToAZKUhEsp5HKJL6yOiYu
   Uj5ZsLkHBVhNHxMfOTkT7yT04T0MEt9tMDiTImgFKsem5A8FM16LHOnWX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="309907034"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="309907034"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 08:31:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="907560712"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="907560712"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.182.87]) ([10.213.182.87])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 08:31:53 -0800
Message-ID: <83d6db31-c75c-6d0f-0b31-7cd12a6816ae@intel.com>
Date:   Tue, 24 Jan 2023 09:31:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v4] cxl/mbox: Fix Payload Length check for Get Log command
Content-Language: en-US
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230119094934.86067-1-rrichter@amd.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230119094934.86067-1-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/23 2:49 AM, Robert Richter wrote:
> Commit 2aeaf663b85e introduced strict checking for variable length
> payload size validation. The payload length of received data must
> match the size of the requested data by the caller except for the case
> where the min_out value is set.
> 
> The Get Log command does not have a header with a length field set.
> The Log size is determined by the Get Supported Logs command (CXL 3.0,
> 8.2.9.5.1). However, the actual size can be smaller and the number of
> valid bytes in the payload output must be determined reading the
> Payload Length field (CXL 3.0, Table 8-36, Note 2).
> 
> Two issues arise: The command can successfully complete with a payload
> length of zero. And, the valid payload length must then also be
> consumed by the caller.
> 
> Change cxl_xfer_log() to pass the number of payload bytes back to the
> caller to determine the number of log entries. Implement the payload
> handling as a special case where mbox_cmd->size_out is consulted when
> cxl_internal_send_cmd() returns -EIO. A WARN_ONCE() is added to check
> that -EIO is only returned in case of an unexpected output size.
> 
> Logs can be bigger than the maximum payload length and multiple Get
> Log commands can be issued. If the received payload size is smaller
> than the maximum payload size we can assume all valid bytes have been
> fetched. Stop sending further Get Log commands then.
> 
> On that occasion, change debug messages to also report the opcodes of
> supported commands.
> 
> The variable payload commands GET_LSA and SET_LSA are not affected by
> this strict check: SET_LSA cannot be broken because SET_LSA does not
> return an output payload, and GET_LSA never expects short reads.
> 
> Fixes: 2aeaf663b85e ("cxl/mbox: Add variable output size validation for internal commands")
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> v4:
>   * Fixed a build issue.
> v3:
>   * Added comment to the WARN_ONCE(). (Jonathan)
>   * Passing a size pointer to report the payload size back. (Jonathan)
>   * Moved logging of supported opcodes out of this patch for a separate
>     change. (Jonathan)
> 
>   drivers/cxl/core/mbox.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index b03fba212799..a48ade466d6a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -170,6 +170,12 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
>   	out_size = mbox_cmd->size_out;
>   	min_out = mbox_cmd->min_out;
>   	rc = cxlds->mbox_send(cxlds, mbox_cmd);
> +	/*
> +	 * EIO is reserved for a payload size mismatch and mbox_send()
> +	 * may not return this error.
> +	 */
> +	if (WARN_ONCE(rc == -EIO, "Bad return code: -EIO"))
> +		return -ENXIO;
>   	if (rc)
>   		return rc;
>   
> @@ -550,9 +556,9 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>   	return 0;
>   }
>   
> -static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8 *out)
> +static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 *size, u8 *out)
>   {
> -	u32 remaining = size;
> +	u32 remaining = *size;
>   	u32 offset = 0;
>   
>   	while (remaining) {
> @@ -576,6 +582,17 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
>   		};
>   
>   		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +
> +		/*
> +		 * The output payload length that indicates the number
> +		 * of valid bytes can be smaller than the Log buffer
> +		 * size.
> +		 */
> +		if (rc == -EIO && mbox_cmd.size_out < xfer_size) {
> +			offset += mbox_cmd.size_out;
> +			break;
> +		}
> +
>   		if (rc < 0)
>   			return rc;
>   
> @@ -584,6 +601,8 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
>   		offset += xfer_size;
>   	}
>   
> +	*size = offset;
> +
>   	return 0;
>   }
>   
> @@ -694,7 +713,7 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>   			goto out;
>   		}
>   
> -		rc = cxl_xfer_log(cxlds, &uuid, size, log);
> +		rc = cxl_xfer_log(cxlds, &uuid, &size, log);
>   		if (rc) {
>   			kvfree(log);
>   			goto out;
> 
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
