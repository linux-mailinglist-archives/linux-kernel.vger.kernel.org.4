Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6261762C399
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiKPQKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiKPQKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:10:12 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5E14C279;
        Wed, 16 Nov 2022 08:10:11 -0800 (PST)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NC7Dn50JNz687hk;
        Thu, 17 Nov 2022 00:05:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:10:09 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 16:10:08 +0000
Date:   Wed, 16 Nov 2022 16:10:08 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 11/11] cxl/test: Simulate event log overflow
Message-ID: <20221116161008.00004f71@Huawei.com>
In-Reply-To: <20221110185758.879472-12-ira.weiny@intel.com>
References: <20221110185758.879472-1-ira.weiny@intel.com>
        <20221110185758.879472-12-ira.weiny@intel.com>
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

On Thu, 10 Nov 2022 10:57:58 -0800
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Log overflow is marked by a separate trace message.
> 
> Simulate a log with lots of messages and flag overflow until it is
> drained a bit.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Looks fine to me

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> Changes from RFC
> 	Adjust for new struct changes
> ---
>  tools/testing/cxl/test/events.c | 37 +++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/events.c b/tools/testing/cxl/test/events.c
> index 8693f3fb9cbb..5ce257114f4e 100644
> --- a/tools/testing/cxl/test/events.c
> +++ b/tools/testing/cxl/test/events.c
> @@ -69,11 +69,21 @@ static void event_store_add_event(struct mock_event_store *mes,
>  	log->nr_events++;
>  }
>  
> +static u16 log_overflow(struct mock_event_log *log)
> +{
> +	int cnt = log_rec_left(log) - 5;
> +
> +	if (cnt < 0)
> +		return 0;
> +	return cnt;
> +}
> +
>  int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>  {
>  	struct cxl_get_event_payload *pl;
>  	struct mock_event_log *log;
>  	u8 log_type;
> +	u16 nr_overflow;
>  
>  	/* Valid request? */
>  	if (cmd->size_in != sizeof(log_type))
> @@ -95,6 +105,20 @@ int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>  	if (log_rec_left(log) > 1)
>  		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
>  
> +	nr_overflow = log_overflow(log);
> +	if (nr_overflow) {
> +		u64 ns;
> +
> +		pl->flags |= CXL_GET_EVENT_FLAG_OVERFLOW;
> +		pl->overflow_err_count = cpu_to_le16(nr_overflow);
> +		ns = ktime_get_real_ns();
> +		ns -= 5000000000; /* 5s ago */
> +		pl->first_overflow_timestamp = cpu_to_le64(ns);
> +		ns = ktime_get_real_ns();
> +		ns -= 1000000000; /* 1s ago */
> +		pl->last_overflow_timestamp = cpu_to_le64(ns);
> +	}
> +
>  	memcpy(&pl->record[0], get_cur_event(log), sizeof(pl->record[0]));
>  	pl->record[0].hdr.handle = get_cur_event_handle(log);
>  	return 0;
> @@ -274,6 +298,19 @@ u32 cxl_mock_add_event_logs(struct cxl_dev_state *cxlds)
>  			      (struct cxl_event_record_raw *)&mem_module);
>  	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
>  
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &maint_needed);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL,
> +			      (struct cxl_event_record_raw *)&dram);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL,
> +			      (struct cxl_event_record_raw *)&gen_media);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL,
> +			      (struct cxl_event_record_raw *)&mem_module);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL,
> +			      (struct cxl_event_record_raw *)&dram);
> +	mes->ev_status |= CXLDEV_EVENT_STATUS_FAIL;
> +
>  	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
>  	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL,
>  			      (struct cxl_event_record_raw *)&dram);

