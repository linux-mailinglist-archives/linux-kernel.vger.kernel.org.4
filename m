Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD010669656
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbjAMMDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjAMMCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:02:11 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A17F82F88;
        Fri, 13 Jan 2023 03:53:58 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ntfrf65VRz67RRb;
        Fri, 13 Jan 2023 19:51:14 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 11:53:55 +0000
Date:   Fri, 13 Jan 2023 11:53:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/mbox: Fix Payload Length check for Get Log
 command
Message-ID: <20230113115354.00003d5a@Huawei.com>
In-Reply-To: <20230104202954.1163366-1-rrichter@amd.com>
References: <20230104202954.1163366-1-rrichter@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Wed, 4 Jan 2023 21:29:54 +0100
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
> The variable payload commands GET_LSA and SET_LSA could be also
> affected by this strict check, but SET_LSA cannot be broken because
> SET_LSA does not return an output payload, and GET_LSA never expects
> short reads.
> 
> Fixes: 2aeaf663b85e ("cxl/mbox: Add variable output size validation for internal commands")
> Signed-off-by: Robert Richter <rrichter@amd.com>
Hi Robert, a few comments inline.

Thanks,

Jonathan

> ---
>  drivers/cxl/core/mbox.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index b03fba212799..e93df0d39022 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -170,6 +170,8 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
>  	out_size = mbox_cmd->size_out;
>  	min_out = mbox_cmd->min_out;
>  	rc = cxlds->mbox_send(cxlds, mbox_cmd);
> +	if (WARN_ONCE(rc == -EIO, "Bad return code: -EIO"))

This is unusual. Why the WARN_ONCE?  How can an error code
be bad?  It may well panic.  Fine to have a dev_err() or similar
but this seems excessive.


> +		return -ENXIO;
>  	if (rc)
>  		return rc;
>  
> @@ -576,6 +578,17 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
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
> @@ -584,7 +597,7 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
>  		offset += xfer_size;
>  	}
>  
> -	return 0;
> +	return offset;
>  }
>  
>  /**
> @@ -608,13 +621,11 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
>  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
>  		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>  
> -		if (!cmd) {
> -			dev_dbg(cxlds->dev,
> -				"Opcode 0x%04x unsupported by driver", opcode);
> -			continue;
> -		}
> +		if (cmd)
> +			set_bit(cmd->info.id, cxlds->enabled_cmds);
>  
> -		set_bit(cmd->info.id, cxlds->enabled_cmds);
> +		dev_dbg(cxlds->dev, "Opcode 0x%04x %ssupported by driver",
> +			opcode, cmd ? "" : "un");

Unrelated change so doesn't belong in this patch.   I'd also split the
dev_dbg into two paths both to reduce modification and because people
might grep for "unsupported by driver"


>  	}
>  }
>  
> @@ -695,11 +706,12 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  		}
>  
>  		rc = cxl_xfer_log(cxlds, &uuid, size, log);
> -		if (rc) {
> +		if (rc < 0) {

Feels like passing in size as a pointer that is then updated might be cleaner.

>  			kvfree(log);
>  			goto out;
>  		}
>  
> +		size = (u32)rc;
>  		cxl_walk_cel(cxlds, size, log);
>  		kvfree(log);
>  

