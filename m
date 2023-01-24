Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C868267944E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjAXJep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAXJen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:34:43 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF166E8D;
        Tue, 24 Jan 2023 01:34:41 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1MCG2c5Rz6J7Jr;
        Tue, 24 Jan 2023 17:30:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 09:34:37 +0000
Date:   Tue, 24 Jan 2023 09:34:41 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] cxl/mbox: Fix Payload Length check for Get Log
 command
Message-ID: <20230124093441.00000741@Huawei.com>
In-Reply-To: <20230119094934.86067-1-rrichter@amd.com>
References: <20230119094934.86067-1-rrichter@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
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

On Thu, 19 Jan 2023 10:49:34 +0100
Robert Richter <rrichter@amd.com> wrote:

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
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v4:
>  * Fixed a build issue.
> v3:
>  * Added comment to the WARN_ONCE(). (Jonathan)
>  * Passing a size pointer to report the payload size back. (Jonathan)
>  * Moved logging of supported opcodes out of this patch for a separate
>    change. (Jonathan)
> 
>  drivers/cxl/core/mbox.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index b03fba212799..a48ade466d6a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -170,6 +170,12 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
>  	out_size = mbox_cmd->size_out;
>  	min_out = mbox_cmd->min_out;
>  	rc = cxlds->mbox_send(cxlds, mbox_cmd);
> +	/*
> +	 * EIO is reserved for a payload size mismatch and mbox_send()
> +	 * may not return this error.
> +	 */
> +	if (WARN_ONCE(rc == -EIO, "Bad return code: -EIO"))
> +		return -ENXIO;
>  	if (rc)
>  		return rc;
>  
> @@ -550,9 +556,9 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>  	return 0;
>  }
>  
> -static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8 *out)
> +static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 *size, u8 *out)
>  {
> -	u32 remaining = size;
> +	u32 remaining = *size;
>  	u32 offset = 0;
>  
>  	while (remaining) {
> @@ -576,6 +582,17 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
>  		};
>  
>  		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
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
>  		if (rc < 0)
>  			return rc;
>  
> @@ -584,6 +601,8 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
>  		offset += xfer_size;
>  	}
>  
> +	*size = offset;
> +
>  	return 0;
>  }
>  
> @@ -694,7 +713,7 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  			goto out;
>  		}
>  
> -		rc = cxl_xfer_log(cxlds, &uuid, size, log);
> +		rc = cxl_xfer_log(cxlds, &uuid, &size, log);
>  		if (rc) {
>  			kvfree(log);
>  			goto out;
> 
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2

