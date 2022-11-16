Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD80962C377
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiKPQI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiKPQIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:08:52 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3ACFD32;
        Wed, 16 Nov 2022 08:08:50 -0800 (PST)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NC7Fr5fk3z6HJG7;
        Thu, 17 Nov 2022 00:06:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:08:49 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 16:08:48 +0000
Date:   Wed, 16 Nov 2022 16:08:47 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 10/11] cxl/test: Add specific events
Message-ID: <20221116160847.00004ed7@Huawei.com>
In-Reply-To: <20221110185758.879472-11-ira.weiny@intel.com>
References: <20221110185758.879472-1-ira.weiny@intel.com>
        <20221110185758.879472-11-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Thu, 10 Nov 2022 10:57:57 -0800
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Each type of event has different trace point outputs.
> 
> Add mock General Media Event, DRAM event, and Memory Module Event
> records to the mock list of events returned.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
A few trivial things inline. Otherwise

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes from RFC:
> 	Adjust for struct changes
> 	adjust for unaligned fields
> ---
>  tools/testing/cxl/test/events.c | 70 +++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/events.c b/tools/testing/cxl/test/events.c
> index a4816f230bb5..8693f3fb9cbb 100644
> --- a/tools/testing/cxl/test/events.c
> +++ b/tools/testing/cxl/test/events.c
> @@ -186,6 +186,70 @@ struct cxl_event_record_raw hardware_replace = {
>  	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
>  };
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
> +	.validity_flags = { CXL_GMER_VALID_CHANNEL |
> +			    CXL_GMER_VALID_RANK, 0 },
put_unaligned_le16()

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
> +	.validity_flags = { CXL_DER_VALID_CHANNEL |
> +			    CXL_DER_VALID_BANK_GROUP |
> +			    CXL_DER_VALID_BANK |
> +			    CXL_DER_VALID_COLUMN, 0 },

put_unaligned_le16() etc

> +	.channel = 1,
> +	.bank_group = 5,
> +	.bank = 2,
> +	.column = { 0xDE, 0xAD},
spacing

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
>  u32 cxl_mock_add_event_logs(struct cxl_dev_state *cxlds)
>  {
>  	struct device *dev = cxlds->dev;
> @@ -204,9 +268,15 @@ u32 cxl_mock_add_event_logs(struct cxl_dev_state *cxlds)
>  	}
>  
>  	event_store_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_INFO,
> +			      (struct cxl_event_record_raw *)&gen_media);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_INFO,
> +			      (struct cxl_event_record_raw *)&mem_module);
>  	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
>  
>  	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL,
> +			      (struct cxl_event_record_raw *)&dram);
>  	mes->ev_status |= CXLDEV_EVENT_STATUS_FATAL;
>  
>  	return mes->ev_status;

