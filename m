Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E94763F981
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiLAVBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiLAVBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:01:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA500B392B;
        Thu,  1 Dec 2022 13:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669928458; x=1701464458;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RwLBuJ7tAQPPAwuukhX/HBcaEjPiFmF8DmRsU1Vz3NA=;
  b=fz2mKMUjU6675MbXiQzbyP0Zbcx6+pc9YU7KhOxIJZs44bOKjhguJ1Q6
   9KmOkP+7pdPWIXphcQD4b5+77Yy0PwirXcjZR3qzWyEN3/+UdQx2W7bqS
   luoIxF1zS3PiP/r8ucUTcKmnJmXmbDtuv/oN7u/MW83tbL7LlF3EKf1wC
   OQAFkwi0OwTooW8tcxHTjP9kS/KBbXfxb9bKxy8Xn6seDneNhvDI4oelc
   3xeZWrW7bdlpqsY1mHAZxgZioDiGJXK0PZv2xz+HhXEvLevF5NUsEJrMd
   rsrBMXvdEuhFkDNhNBNzYpqrXAc0+92Ise7DfRwbQSZFO48MlJycvmZ3J
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="316947735"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="316947735"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 13:00:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="646909977"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="646909977"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.66.184]) ([10.212.66.184])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 13:00:57 -0800
Message-ID: <02f2b2fa-c3b9-21c3-5ee7-53445779f955@intel.com>
Date:   Thu, 1 Dec 2022 14:00:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH V2 10/11] cxl/test: Add specific events
Content-Language: en-US
To:     ira.weiny@intel.com, Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-11-ira.weiny@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221201002719.2596558-11-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/2022 5:27 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Each type of event has different trace point outputs.
> 
> Add mock General Media Event, DRAM event, and Memory Module Event
> records to the mock list of events returned.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> Changes from V1:
> 	Jonathan
> 		use put_unaligned_le16()
> 		fix spacing
> 
> Changes from RFC:
> 	Adjust for struct changes
> 	adjust for unaligned fields
> ---
>   tools/testing/cxl/test/events.c | 73 +++++++++++++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/events.c b/tools/testing/cxl/test/events.c
> index a3d2ec7cc9fe..0bcc485e07da 100644
> --- a/tools/testing/cxl/test/events.c
> +++ b/tools/testing/cxl/test/events.c
> @@ -206,6 +206,66 @@ struct cxl_event_record_raw hardware_replace = {
>   	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
>   };
>   
> +struct cxl_event_gen_media gen_media = {
> +	.hdr = {
> +		.id = UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
> +				0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
> +		.length = sizeof(struct cxl_event_gen_media),
> +		.flags[0] = CXL_EVENT_RECORD_FLAG_PERMANENT,
> +		/* .handle = Set dynamically */
> +		.related_handle = cpu_to_le16(0),
> +	},
> +	.phys_addr = cpu_to_le64(0x2000),
> +	.descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
> +	.type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
> +	.transaction_type = CXL_GMER_TRANS_HOST_WRITE,
> +	/* .validity_flags = <set below> */
> +	.channel = 1,
> +	.rank = 30
> +};
> +
> +struct cxl_event_dram dram = {
> +	.hdr = {
> +		.id = UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
> +				0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
> +		.length = sizeof(struct cxl_event_dram),
> +		.flags[0] = CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
> +		/* .handle = Set dynamically */
> +		.related_handle = cpu_to_le16(0),
> +	},
> +	.phys_addr = cpu_to_le64(0x8000),
> +	.descriptor = CXL_GMER_EVT_DESC_THRESHOLD_EVENT,
> +	.type = CXL_GMER_MEM_EVT_TYPE_INV_ADDR,
> +	.transaction_type = CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,
> +	/* .validity_flags = <set below> */
> +	.channel = 1,
> +	.bank_group = 5,
> +	.bank = 2,
> +	.column = {0xDE, 0xAD},
> +};
> +
> +struct cxl_event_mem_module mem_module = {
> +	.hdr = {
> +		.id = UUID_INIT(0xfe927475, 0xdd59, 0x4339,
> +				0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
> +		.length = sizeof(struct cxl_event_mem_module),
> +		/* .handle = Set dynamically */
> +		.related_handle = cpu_to_le16(0),
> +	},
> +	.event_type = CXL_MMER_TEMP_CHANGE,
> +	.info = {
> +		.health_status = CXL_DHI_HS_PERFORMANCE_DEGRADED,
> +		.media_status = CXL_DHI_MS_ALL_DATA_LOST,
> +		.add_status = (CXL_DHI_AS_CRITICAL << 2) |
> +			      (CXL_DHI_AS_WARNING << 4) |
> +			      (CXL_DHI_AS_WARNING << 5),
> +		.device_temp = { 0xDE, 0xAD},
> +		.dirty_shutdown_cnt = { 0xde, 0xad, 0xbe, 0xef },
> +		.cor_vol_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
> +		.cor_per_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
> +	}
> +};
> +
>   u32 cxl_mock_add_event_logs(struct cxl_dev_state *cxlds)
>   {
>   	struct device *dev = cxlds->dev;
> @@ -223,10 +283,23 @@ u32 cxl_mock_add_event_logs(struct cxl_dev_state *cxlds)
>   		return 0;
>   	}
>   
> +	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
> +			   &gen_media.validity_flags);
> +
> +	put_unaligned_le16(CXL_DER_VALID_CHANNEL | CXL_DER_VALID_BANK_GROUP |
> +			   CXL_DER_VALID_BANK | CXL_DER_VALID_COLUMN,
> +			   &dram.validity_flags);
> +
>   	event_store_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_INFO,
> +			      (struct cxl_event_record_raw *)&gen_media);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_INFO,
> +			      (struct cxl_event_record_raw *)&mem_module);
>   	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
>   
>   	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL,
> +			      (struct cxl_event_record_raw *)&dram);
>   	mes->ev_status |= CXLDEV_EVENT_STATUS_FATAL;
>   
>   	return mes->ev_status;
