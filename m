Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D46B62C34D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiKPQBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiKPQA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:00:59 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7F254B04;
        Wed, 16 Nov 2022 08:00:57 -0800 (PST)
Received: from frapeml500008.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NC7273rndz67blg;
        Wed, 16 Nov 2022 23:56:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:00:55 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 16:00:54 +0000
Date:   Wed, 16 Nov 2022 16:00:53 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 09/11] cxl/test: Add generic mock events
Message-ID: <20221116160053.000015f8@Huawei.com>
In-Reply-To: <20221110185758.879472-10-ira.weiny@intel.com>
References: <20221110185758.879472-1-ira.weiny@intel.com>
        <20221110185758.879472-10-ira.weiny@intel.com>
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

On Thu, 10 Nov 2022 10:57:56 -0800
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Facilitate testing basic Get/Clear Event functionality by creating
> multiple logs and generic events with made up UUID's.
> 
> Data is completely made up with data patterns which should be easy to
> spot in trace output.
> 
> A single sysfs entry resets the event data and triggers collecting the
> events for testing.
> 
> Test traces are easy to obtain with a small script such as this:
> 
> 	#!/bin/bash -x
> 
> 	devices=`find /sys/devices/platform -name cxl_mem*`
> 
> 	# Turn on tracing
> 	echo "" > /sys/kernel/tracing/trace
> 	echo 1 > /sys/kernel/tracing/events/cxl/enable
> 	echo 1 > /sys/kernel/tracing/tracing_on
> 
> 	# Generate fake interrupt
> 	for device in $devices; do
> 	        echo 1 > $device/event_trigger
> 	done
> 
> 	# Turn off tracing and report events
> 	echo 0 > /sys/kernel/tracing/tracing_on
> 	cat /sys/kernel/tracing/trace
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Hi Ira,

I don't think your mocked device is now obeying the spec
after changes in the core code that mean it gets a larger
request than previously.
If it has more than 1 record and the read is for 3 it
must return more than 1 and only set MORE_RECORDS if there
are more than 3.

Gah. The more event records approach also suffers the
same problem that poison list does. You have no way
to be sure that "previous software" (which may have crashed)
hasn't already read some.  So in the core code we probably
need to do one more read on initial boot to be sure we have
all the records.  Not sure how I spotted that for poison
but never noticed it for these.  At least for these records
the expectation is that there won't be a huge number of them
so reading one more time is fine - particularly as you clear
them on that initial read so the list will get shorter.

Jonathan

> 
> ---
> Changes from RFC v2:
> 	Adjust to simulate the event status register
> 
> Changes from RFC:
> 	Separate out the event code
> 	Adjust for struct changes.
> 	Clean up devm_cxl_mock_event_logs()
> 	Clean up naming and comments
> 	Jonathan
> 		Remove dynamic allocation of event logs
> 		Clean up comment
> 		Remove unneeded xarray
> 		Ensure event_trigger sysfs is valid prior to the driver
> 		going active.
> 	Dan
> 		Remove the fill/reset event sysfs as these operations
> 		can be done together
> ---
>  drivers/cxl/core/mbox.c         |  31 +++--
>  drivers/cxl/cxlmem.h            |   1 +
>  tools/testing/cxl/test/Kbuild   |   2 +-
>  tools/testing/cxl/test/events.c | 222 ++++++++++++++++++++++++++++++++
>  tools/testing/cxl/test/events.h |   9 ++
>  tools/testing/cxl/test/mem.c    |  35 ++++-
>  6 files changed, 286 insertions(+), 14 deletions(-)
>  create mode 100644 tools/testing/cxl/test/events.c
>  create mode 100644 tools/testing/cxl/test/events.h


> diff --git a/tools/testing/cxl/test/events.c b/tools/testing/cxl/test/events.c
> new file mode 100644
> index 000000000000..a4816f230bb5
> --- /dev/null
> +++ b/tools/testing/cxl/test/events.c


xl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
> +};
> +
> +struct mock_event_store {
> +	struct cxl_dev_state *cxlds;
> +	struct mock_event_log mock_logs[CXL_EVENT_TYPE_MAX];
> +	u32 ev_status;
> +};
> +
> +DEFINE_XARRAY(mock_dev_event_store);

Perhaps add a comment on what this xarray is for.
I think it's all to allow associating some extra data with the devices
without bloating structures outside of tests?

> +
> +struct mock_event_log *find_event_log(struct device *dev, int log_type)
> +{
> +	struct mock_event_store *mes = xa_load(&mock_dev_event_store,
> +					       (unsigned long)dev);
> +
> +	if (!mes || log_type >= CXL_EVENT_TYPE_MAX)
> +		return NULL;
> +	return &mes->mock_logs[log_type];
> +}
> +

> +
> +int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_get_event_payload *pl;
> +	struct mock_event_log *log;
> +	u8 log_type;
> +
> +	/* Valid request? */
> +	if (cmd->size_in != sizeof(log_type))
> +		return -EINVAL;
> +
> +	log_type = *((u8 *)cmd->payload_in);
> +	if (log_type >= CXL_EVENT_TYPE_MAX)
> +		return -EINVAL;
> +
> +	log = find_event_log(cxlds->dev, log_type);
> +	if (!log || log_empty(log))
> +		goto no_data;
> +
> +	pl = cmd->payload_out;
> +	memset(pl, 0, sizeof(*pl));
> +
> +	pl->record_count = cpu_to_le16(1);

Not valid.  Kernel now requests 3 and as I read the spec we have
to return 3 if we have 3 or more to return. Can't send 1 and set
MORE_RECORDS as done here.

> +
> +	if (log_rec_left(log) > 1)
> +		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
> +
> +	memcpy(&pl->record[0], get_cur_event(log), sizeof(pl->record[0]));
> +	pl->record[0].hdr.handle = get_cur_event_handle(log);
> +	return 0;
> +
> +no_data:
> +	/* Room for header? */

Why check for space here, but not when setting records above?

> +	if (cmd->size_out < (sizeof(*pl) - sizeof(pl->record[0])))
> +		return -EINVAL;
> +
> +	memset(cmd->payload_out, 0, cmd->size_out);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mock_get_event);
> +
> +/*
> + * Get and clear event only handle 1 record at a time as this is what is
> + * currently implemented in the main code.
> + */
> +int mock_clear_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
> +	struct mock_event_log *log;
> +	u8 log_type = pl->event_log;
> +
> +	/* Don't handle more than 1 record at a time */
> +	if (pl->nr_recs != 1)
> +		return -EINVAL;
> +
> +	if (log_type >= CXL_EVENT_TYPE_MAX)
> +		return -EINVAL;
> +
> +	log = find_event_log(cxlds->dev, log_type);
> +	if (!log)
> +		return 0; /* No mock data in this log */
> +
> +	/*
> +	 * Test code only reported 1 event at a time.  So only support 1 event
> +	 * being cleared.
> +	 */
> +	if (log->cur_event != le16_to_cpu(pl->handle[0])) {
> +		dev_err(cxlds->dev, "Clearing events out of order\n");
> +		return -EINVAL;
> +	}
> +
> +	log->cur_event++;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mock_clear_event);

...

> +
> +struct cxl_event_record_raw maint_needed = {
> +	.hdr = {
> +		.id = UUID_INIT(0xDEADBEEF, 0xCAFE, 0xBABE,
> +				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
> +		.length = sizeof(struct cxl_event_record_raw),
> +		.flags[0] = CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,
> +		/* .handle = Set dynamically */

Multiple devices... So this should be const and a copy made for each one
to avoid races.

> +		.related_handle = cpu_to_le16(0xa5b6),
> +	},
> +	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
> +};
> +
> +struct cxl_event_record_raw hardware_replace = {
> +	.hdr = {
> +		.id = UUID_INIT(0xBABECAFE, 0xBEEF, 0xDEAD,
> +				0xa5, 0x5a, 0xa5, 0x5a, 0xa5, 0xa5, 0x5a, 0xa5),
> +		.length = sizeof(struct cxl_event_record_raw),
> +		.flags[0] = CXL_EVENT_RECORD_FLAG_HW_REPLACE,
> +		/* .handle = Set dynamically */
> +		.related_handle = cpu_to_le16(0xb6a5),
> +	},
> +	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
> +};
> +
> +u32 cxl_mock_add_event_logs(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct mock_event_store *mes;
> +
> +	mes = devm_kzalloc(dev, sizeof(*mes), GFP_KERNEL);
> +	if (WARN_ON(!mes))
> +		return 0;
> +	mes->cxlds = cxlds;
> +
> +	if (xa_insert(&mock_dev_event_store, (unsigned long)dev, mes,
> +		      GFP_KERNEL)) {
> +		dev_err(dev, "Event store not available for %s\n",
> +			dev_name(dev));
> +		return 0;
> +	}
> +
> +	event_store_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
> +	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
> +
> +	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> +	mes->ev_status |= CXLDEV_EVENT_STATUS_FATAL;
> +
> +	return mes->ev_status;
> +}
> +EXPORT_SYMBOL_GPL(cxl_mock_add_event_logs);
> +
> +void cxl_mock_remove_event_logs(struct device *dev)
> +{
> +	struct mock_event_store *mes;
> +
> +	mes = xa_erase(&mock_dev_event_store, (unsigned long)dev);
> +}
> +EXPORT_SYMBOL_GPL(cxl_mock_remove_event_logs);

> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index e2f5445d24ff..333fa8527a07 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
...


>  static int cxl_mock_mem_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_dev_state *cxlds;
> +	u32 ev_status;
>  	void *lsa;
>  	int rc;
>  
> @@ -281,11 +304,13 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> +	ev_status = cxl_mock_add_event_logs(cxlds);
For below comment, add a devm_add_action_or_reset() here to
undo this.  If nothing else, without one you should have error
handling...

> +
>  	cxlmd = devm_cxl_add_memdev(cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> -	cxl_mem_get_event_records(cxlds);
> +	__cxl_mem_get_event_records(cxlds, ev_status);
>  
>  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
>  		rc = devm_cxl_add_nvdimm(dev, cxlmd);
> @@ -293,6 +318,12 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int cxl_mock_mem_remove(struct platform_device *pdev)
> +{
> +	cxl_mock_remove_event_logs(&pdev->dev);

Given you have a bunch of devm above, probably better to just use
a devm_add_action_or_reset() to clean this up.
Saves on introducing remove for just this one call + any potential
ordering issues (I'm too lazy to check if there are any ;)


> +	return 0;
> +}
> +
>  static const struct platform_device_id cxl_mock_mem_ids[] = {
>  	{ .name = "cxl_mem", },
>  	{ },
> @@ -301,9 +332,11 @@ MODULE_DEVICE_TABLE(platform, cxl_mock_mem_ids);
>  
>  static struct platform_driver cxl_mock_mem_driver = {
>  	.probe = cxl_mock_mem_probe,
> +	.remove = cxl_mock_mem_remove,
>  	.id_table = cxl_mock_mem_ids,
>  	.driver = {
>  		.name = KBUILD_MODNAME,
> +		.dev_groups = cxl_mock_event_groups,
>  	},
>  };
>  

