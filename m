Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0D36D6506
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbjDDOSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjDDOSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:18:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 399DBBE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:18:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7617AD75;
        Tue,  4 Apr 2023 07:19:18 -0700 (PDT)
Received: from [10.57.53.173] (unknown [10.57.53.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 662453F762;
        Tue,  4 Apr 2023 07:18:32 -0700 (PDT)
Message-ID: <8a1065b0-27a2-5676-9141-2809322e4046@arm.com>
Date:   Tue, 4 Apr 2023 15:18:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v4 07/13] coresight: Store pointers to connections rather
 than an array of them
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        quic_jinlmao@quicinc.com, mike.leach@linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230404135401.1728919-1-james.clark@arm.com>
 <20230404135401.1728919-8-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230404135401.1728919-8-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 14:53, James Clark wrote:
> This will allow the same connection object to be referenced via the
> input connection list in a later commit rather than duplicating them.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c  | 47 ++++++++++---------
>   .../hwtracing/coresight/coresight-platform.c  | 10 ++--
>   drivers/hwtracing/coresight/coresight-priv.h  |  1 +
>   .../hwtracing/coresight/coresight-tmc-etr.c   |  2 +-
>   include/linux/coresight.h                     |  5 +-
>   5 files changed, 35 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 91274e7e6944..0b738960973b 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -119,7 +119,7 @@ static int coresight_find_link_inport(struct coresight_device *csdev,
>   	struct coresight_connection *conn;
>   
>   	for (i = 0; i < parent->pdata->nr_outconns; i++) {
> -		conn = &parent->pdata->out_conns[i];
> +		conn = parent->pdata->out_conns[i];
>   		if (conn->dest_dev == csdev)
>   			return conn->dest_port;
>   	}
> @@ -137,7 +137,7 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
>   	struct coresight_connection *conn;
>   
>   	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
> -		conn = &csdev->pdata->out_conns[i];
> +		conn = csdev->pdata->out_conns[i];
>   		if (conn->dest_dev == child)
>   			return conn->src_port;
>   	}
> @@ -606,7 +606,7 @@ coresight_find_enabled_sink(struct coresight_device *csdev)
>   	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
>   		struct coresight_device *child_dev;
>   
> -		child_dev = csdev->pdata->out_conns[i].dest_dev;
> +		child_dev = csdev->pdata->out_conns[i]->dest_dev;
>   		if (child_dev)
>   			sink = coresight_find_enabled_sink(child_dev);
>   		if (sink)
> @@ -722,7 +722,7 @@ static int coresight_grab_device(struct coresight_device *csdev)
>   	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
>   		struct coresight_device *child;
>   
> -		child = csdev->pdata->out_conns[i].dest_dev;
> +		child = csdev->pdata->out_conns[i]->dest_dev;
>   		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
>   			if (!coresight_get_ref(child))
>   				goto err;
> @@ -733,7 +733,7 @@ static int coresight_grab_device(struct coresight_device *csdev)
>   	for (i--; i >= 0; i--) {
>   		struct coresight_device *child;
>   
> -		child = csdev->pdata->out_conns[i].dest_dev;
> +		child = csdev->pdata->out_conns[i]->dest_dev;
>   		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
>   			coresight_put_ref(child);
>   	}
> @@ -752,7 +752,7 @@ static void coresight_drop_device(struct coresight_device *csdev)
>   	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
>   		struct coresight_device *child;
>   
> -		child = csdev->pdata->out_conns[i].dest_dev;
> +		child = csdev->pdata->out_conns[i]->dest_dev;
>   		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
>   			coresight_put_ref(child);
>   	}
> @@ -794,7 +794,7 @@ static int _coresight_build_path(struct coresight_device *csdev,
>   	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
>   		struct coresight_device *child_dev;
>   
> -		child_dev = csdev->pdata->out_conns[i].dest_dev;
> +		child_dev = csdev->pdata->out_conns[i]->dest_dev;
>   		if (child_dev &&
>   		    _coresight_build_path(child_dev, sink, path) == 0) {
>   			found = true;
> @@ -964,7 +964,7 @@ coresight_find_sink(struct coresight_device *csdev, int *depth)
>   		struct coresight_device *child_dev, *sink = NULL;
>   		int child_depth = curr_depth;
>   
> -		child_dev = csdev->pdata->out_conns[i].dest_dev;
> +		child_dev = csdev->pdata->out_conns[i]->dest_dev;
>   		if (child_dev)
>   			sink = coresight_find_sink(child_dev, &child_depth);
>   
> @@ -1334,7 +1334,7 @@ static int coresight_orphan_match(struct device *dev, void *data)
>   	 * an orphan connection whose name matches @csdev, link it.
>   	 */
>   	for (i = 0; i < i_csdev->pdata->nr_outconns; i++) {
> -		conn = &i_csdev->pdata->out_conns[i];
> +		conn = i_csdev->pdata->out_conns[i];
>   
>   		/* We have found at least one orphan connection */
>   		if (conn->dest_dev == NULL) {
> @@ -1372,7 +1372,7 @@ static int coresight_fixup_device_conns(struct coresight_device *csdev)
>   	int i, ret = 0;
>   
>   	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
> -		struct coresight_connection *conn = &csdev->pdata->out_conns[i];
> +		struct coresight_connection *conn = csdev->pdata->out_conns[i];
>   
>   		conn->dest_dev =
>   			coresight_find_csdev_by_fwnode(conn->dest_fwnode);
> @@ -1406,15 +1406,12 @@ static int coresight_remove_match(struct device *dev, void *data)
>   	 * a connection whose name matches @csdev, remove it.
>   	 */
>   	for (i = 0; i < iterator->pdata->nr_outconns; i++) {
> -		conn = &iterator->pdata->out_conns[i];
> +		conn = iterator->pdata->out_conns[i];
>   
> -		if (conn->dest_dev == NULL)
> -			continue;
> -
> -		if (csdev->dev.fwnode == conn->dest_fwnode) {
> +		/* Child_dev being set signifies that the links were made */
> +		if (csdev->dev.fwnode == conn->dest_fwnode && conn->dest_dev) {
>   			iterator->orphan = true;
>   			coresight_remove_links(iterator, conn);
> -
>   			conn->dest_dev = NULL;
>   			/* No need to continue */
>   			break;
> @@ -1534,22 +1531,26 @@ void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset)
>    * to the output port of this device.
>    */
>   void coresight_release_platform_data(struct coresight_device *csdev,
> +				     struct device *dev,
>   				     struct coresight_platform_data *pdata)
>   {
>   	int i;
> -	struct coresight_connection *conns = pdata->out_conns;
> +	struct coresight_connection **conns = pdata->out_conns;
>   
>   	for (i = 0; i < pdata->nr_outconns; i++) {
>   		/* If we have made the links, remove them now */
> -		if (csdev && conns[i].dest_dev)
> -			coresight_remove_links(csdev, &conns[i]);
> +		if (csdev && conns[i]->dest_dev)
> +			coresight_remove_links(csdev, conns[i]);
>   		/*
>   		 * Drop the refcount and clear the handle as this device
>   		 * is going away
>   		 */
> -		fwnode_handle_put(conns[i].dest_fwnode);
> -		conns[i].dest_fwnode = NULL;
> +		fwnode_handle_put(conns[i]->dest_fwnode);
> +		conns[i]->dest_fwnode = NULL;
> +		devm_kfree(dev, conns[i]);
>   	}
> +	devm_kfree(dev, pdata->out_conns);
> +	devm_kfree(dev, pdata);
>   	if (csdev)
>   		coresight_remove_conns_sysfs_group(csdev);
>   }
> @@ -1666,7 +1667,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   
>   err_out:
>   	/* Cleanup the connection information */
> -	coresight_release_platform_data(NULL, desc->pdata);
> +	coresight_release_platform_data(NULL, desc->dev, desc->pdata);
>   	return ERR_PTR(ret);
>   }
>   EXPORT_SYMBOL_GPL(coresight_register);
> @@ -1679,7 +1680,7 @@ void coresight_unregister(struct coresight_device *csdev)
>   		cti_assoc_ops->remove(csdev);
>   	coresight_remove_conns(csdev);
>   	coresight_clear_default_sink(csdev);
> -	coresight_release_platform_data(csdev, csdev->pdata);
> +	coresight_release_platform_data(csdev, csdev->dev.parent, csdev->pdata);
>   	device_unregister(&csdev->dev);
>   }
>   EXPORT_SYMBOL_GPL(coresight_unregister);
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 8c2029336161..017ea5762988 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -37,7 +37,7 @@ coresight_add_out_conn(struct device *dev,
>   	 * Warn on any existing duplicate output port.
>   	 */
>   	for (i = 0; i < pdata->nr_outconns; ++i) {
> -		conn = &pdata->out_conns[i];
> +		conn = pdata->out_conns[i];
>   		/* Output == -1 means ignore the port for example for helpers */
>   		if (conn->src_port != -1 &&
>   		    conn->src_port == new_conn->src_port) {
> @@ -54,8 +54,10 @@ coresight_add_out_conn(struct device *dev,
>   	if (!pdata->out_conns)
>   		return ERR_PTR(-ENOMEM);
>   
> -	pdata->out_conns[pdata->nr_outconns - 1] = *new_conn;
> -	return &pdata->out_conns[pdata->nr_outconns - 1];
> +	pdata->out_conns[pdata->nr_outconns - 1] = devm_kmalloc(
> +		dev, sizeof(struct coresight_connection), GFP_KERNEL);

Please check the error in allocation. While at it, please use a variable
to simplify the code reading.

Otherwise looks good to me

Suzuki

