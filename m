Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1967363F9CF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiLAV3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiLAV2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:28:30 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FE3ABA2E;
        Thu,  1 Dec 2022 13:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669930101; x=1701466101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CZihDRocHMOT+JYXZESRl5AwDmyjKtqc0Mx+Iop7JLg=;
  b=noIDimK1Jy6soxQDzHhzuGc4u8Be88EqLP+Dws9m4CFeHwYRnMJVqkdu
   WB1eJ5Mnu181W0/bNOoawol6u7+ncf7ulk/njxQ/TueWrHUbAu06+vdWm
   JW7yZm1Z+ij3mngUwH57uAcTP2gzh2bgqV18CGSa5Hx/sGzBBlhn6X8Yi
   Z8Eq8aasDzWy0D/YnSEU4jHiOStKJzewDA44/aNDzvkm6rA2LTe2RIuv/
   9kdvJByU5eaPajMWOQGYhVzow3UJnuGoFYDCEalLK6Zr56QlURSkADUFf
   9145rlrXvOO42WVyXtQM+zzxxB5rl0EDu2rDubPj6gYCmXCG+0kCEOetG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="313442035"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="313442035"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 13:28:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="595223011"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="595223011"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.66.184]) ([10.212.66.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 13:28:20 -0800
Message-ID: <18ae6119-1265-11d1-9f0b-996239644a40@intel.com>
Date:   Thu, 1 Dec 2022 14:28:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH V2 11/11] cxl/test: Simulate event log overflow
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
 <20221201002719.2596558-12-ira.weiny@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221201002719.2596558-12-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/2022 5:27 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Log overflow is marked by a separate trace message.
> 
> Simulate a log with lots of messages and flag overflow until it is
> drained a bit.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> Changes from RFC
> 	Adjust for new struct changes
> ---
>   tools/testing/cxl/test/events.c | 49 ++++++++++++++++++++++++++++++++-
>   1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/events.c b/tools/testing/cxl/test/events.c
> index 0bcc485e07da..ceabefb526c2 100644
> --- a/tools/testing/cxl/test/events.c
> +++ b/tools/testing/cxl/test/events.c
> @@ -15,6 +15,8 @@ struct mock_event_log {
>   	u16 clear_idx;
>   	u16 cur_idx;
>   	u16 nr_events;
> +	u16 nr_overflow;
> +	u16 overflow_reset;
>   	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
>   };
>   
> @@ -45,6 +47,7 @@ void reset_event_log(struct mock_event_log *log)
>   {
>   	log->cur_idx = 0;
>   	log->clear_idx = 0;
> +	log->nr_overflow = log->overflow_reset;
>   }
>   
>   /* Handle can never be 0 use 1 based indexing for handle */
> @@ -76,8 +79,12 @@ static void event_store_add_event(struct mock_event_store *mes,
>   		return;
>   
>   	log = &mes->mock_logs[log_type];
> -	if (WARN_ON(log->nr_events >= CXL_TEST_EVENT_CNT_MAX))
> +
> +	if ((log->nr_events + 1) > CXL_TEST_EVENT_CNT_MAX) {
> +		log->nr_overflow++;
> +		log->overflow_reset = log->nr_overflow;
>   		return;
> +	}
>   
>   	log->events[log->nr_events] = event;
>   	log->nr_events++;
> @@ -87,6 +94,7 @@ int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   {
>   	struct cxl_get_event_payload *pl;
>   	struct mock_event_log *log;
> +	u16 nr_overflow;
>   	u8 log_type;
>   	int i;
>   
> @@ -118,6 +126,21 @@ int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   	if (!log_empty(log))
>   		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
>   
> +	if (log->nr_overflow) {
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
> +
> +		log->nr_overflow = 0;
> +	}
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(mock_get_event);
> @@ -297,6 +320,30 @@ u32 cxl_mock_add_event_logs(struct cxl_dev_state *cxlds)
>   			      (struct cxl_event_record_raw *)&mem_module);
>   	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
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
> +	/* Overflow this log */
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	mes->ev_status |= CXLDEV_EVENT_STATUS_FAIL;
> +
>   	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
>   	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL,
>   			      (struct cxl_event_record_raw *)&dram);
