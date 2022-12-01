Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BE263F18E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiLAN00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiLAN0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:26:23 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F142A895F;
        Thu,  1 Dec 2022 05:26:22 -0800 (PST)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NNGwd4xxqz67yhg;
        Thu,  1 Dec 2022 21:23:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 14:26:20 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 13:26:19 +0000
Date:   Thu, 1 Dec 2022 13:26:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 03/11] cxl/mem: Implement Clear Event Records command
Message-ID: <20221201132618.00006602@Huawei.com>
In-Reply-To: <20221201002719.2596558-4-ira.weiny@intel.com>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
        <20221201002719.2596558-4-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Wed, 30 Nov 2022 16:27:11 -0800
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL rev 3.0 section 8.2.9.2.3 defines the Clear Event Records mailbox
> command.  After an event record is read it needs to be cleared from the
> event log.
> 
> Implement cxl_clear_event_record() to clear all record retrieved from
> the device.
> 
> Each record is cleared explicitly.  A clear all bit is specified but
> events could arrive between a get and any final clear all operation.
> This means events would be missed.
> Therefore each event is cleared specifically.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
I think there is a type issue on the min_t() calculation with that addressed
this looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes from V1:
> 	Clear Event Record allows for u8 handles while Get Event Record
> 	allows for u16 records to be returned.  Based on Jonathan's
> 	feedback; allow for all event records to be handled in this
> 	clear.  Which means a double loop with potentially multiple
> 	Clear Event payloads being sent to clear all events sent.
> 
> Changes from RFC:
> 	Jonathan
> 		Clean up init of payload and use return code.
> 		Also report any error to clear the event.
> 		s/v3.0/rev 3.0
> ---
>  drivers/cxl/core/mbox.c      | 61 +++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxlmem.h         | 14 +++++++++
>  include/uapi/linux/cxl_mem.h |  1 +
>  3 files changed, 69 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 70b681027a3d..076a3df0ba38 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -52,6 +52,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  #endif
>  	CXL_CMD(GET_SUPPORTED_LOGS, 0, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
>  	CXL_CMD(GET_EVENT_RECORD, 1, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_CMD(CLEAR_EVENT_RECORD, CXL_VARIABLE_PAYLOAD, 0, 0),
>  	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
>  	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
>  	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> @@ -708,6 +709,42 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> +static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
> +				  enum cxl_event_log_type log,
> +				  struct cxl_get_event_payload *get_pl,
> +				  u16 total)
> +{
> +	struct cxl_mbox_clear_event_payload payload = {
> +		.event_log = log,
> +	};
> +	int cnt;
> +
> +	/*
> +	 * Clear Event Records uses u8 for the handle cnt while Get Event
> +	 * Record can return up to 0xffff records.
> +	 */
> +	for (cnt = 0; cnt < total; /* cnt incremented internally */) {
> +		u8 nr_recs = min_t(u8, (total - cnt),
> +				   CXL_CLEAR_EVENT_MAX_HANDLES);

I might be half asleep but isn't this assuming that (total - cnt)
fits in an u8?  Shouldn't this be min_t(u16, ..) 
Also, maybe u16 cnt would be simpler.

Hmm.  This is safe but only because of how you call it alongside
handling of a particular Get event records response (which must
have fitted in the mailbox and has a longer header).

Looking at this function in isolation, I think the mailbox could be
small enough that we might not fit 255 records + the header.
Perhaps we need a comment to say that, or at minimum a check and error
return if it won't fit?

> +		int i, rc;
> +
> +		for (i = 0; i < nr_recs; i++, cnt++) {
> +			payload.handle[i] = get_pl->records[cnt].hdr.handle;
> +			dev_dbg(cxlds->dev, "Event log '%s': Clearning %u\n",
> +				cxl_event_log_type_str(log),
> +				le16_to_cpu(payload.handle[i]));
> +		}
> +		payload.nr_recs = nr_recs;
> +
> +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_CLEAR_EVENT_RECORD,
> +				       &payload, sizeof(payload), NULL, 0);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
>  static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
>  				    enum cxl_event_log_type type)
>  {
> @@ -732,13 +769,22 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
This feels miss named now but I can't immediately think of better naming so on that
basis fine to leave it as is if you don't have a better idea!.

>  		}
>  
>  		nr_rec = le16_to_cpu(payload->record_count);
> -		if (trace_cxl_generic_event_enabled()) {
> +		if (nr_rec > 0) {
>  			int i;
>  
> -			for (i = 0; i < nr_rec; i++)
> -				trace_cxl_generic_event(dev_name(cxlds->dev),
> -							type,
> -							&payload->records[i]);
> +			if (trace_cxl_generic_event_enabled()) {
> +				for (i = 0; i < nr_rec; i++)
> +					trace_cxl_generic_event(dev_name(cxlds->dev),
> +								type,
> +								&payload->records[i]);
> +			}
> +
> +			rc = cxl_clear_event_record(cxlds, type, payload, nr_rec);
> +			if (rc) {
> +				dev_err(cxlds->dev, "Event log '%s': Failed to clear events : %d",
> +					cxl_event_log_type_str(type), rc);
> +				return;
> +			}
>  		}

