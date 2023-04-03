Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C0C6D41BA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjDCKSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjDCKSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:18:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 745881043C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:17:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 885F41063;
        Mon,  3 Apr 2023 03:18:40 -0700 (PDT)
Received: from [10.57.54.53] (unknown [10.57.54.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35E863F840;
        Mon,  3 Apr 2023 03:17:54 -0700 (PDT)
Message-ID: <a25804a5-c949-098e-43de-9c9046fdb2de@arm.com>
Date:   Mon, 3 Apr 2023 11:17:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v3 09/13] coresight: Store in-connections as well as
 out-connections
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        quic_jinlmao@quicinc.com, mike.leach@linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230329115329.2747724-1-james.clark@arm.com>
 <20230329115329.2747724-10-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230329115329.2747724-10-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 12:53, James Clark wrote:
> This will allow CATU to get its associated ETR in a generic way where
> currently the enable path has some hard coded searches which avoid
> the need to store input connections.
> 
> This also means that the full search for connected devices on removal
> can be replaced with a loop through only the input and output devices.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c  | 79 ++++++++-----------
>   .../hwtracing/coresight/coresight-platform.c  | 31 +++++++-
>   drivers/hwtracing/coresight/coresight-sysfs.c |  7 --
>   include/linux/coresight.h                     | 26 ++++++
>   4 files changed, 90 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 2f4aa15ef8f9..be1e8be2459f 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1349,6 +1349,16 @@ static int coresight_orphan_match(struct device *dev, void *data)
>   			if (ret)
>   				return ret;
>   
> +			/*
> +			 * Install the device connection. This also indicates that
> +			 * the links are operational on both ends.
> +			 */
> +			conn->dest_dev = csdev;
> +			conn->src_dev = i_csdev;
> +
> +			ret = coresight_add_in_conn(conn);
> +			if (ret)
> +				return ret;

Do we need to clean up this "conn" in case of an error here ?

>   		} else {
>   			/* This component still has an orphan */
>   			still_orphan = true;
> @@ -1370,58 +1380,36 @@ static int coresight_fixup_orphan_conns(struct coresight_device *csdev)
>   			 csdev, coresight_orphan_match);
>   }
>   
> -static int coresight_remove_match(struct device *dev, void *data)
> +/* coresight_remove_conns - Remove other device's references to this device */
> +static void coresight_remove_conns(struct coresight_device *csdev)
>   {
> -	int i;
> -	struct coresight_device *csdev, *iterator;
> +	int i, j;
>   	struct coresight_connection *conn;
>   
> -	csdev = data;
> -	iterator = to_coresight_device(dev);
> -
> -	/* No need to check oneself */
> -	if (csdev == iterator)
> -		return 0;
> +	/* Remove input references on output devices */

minor nit: The term "output devices" is a bit confusing.
Could we simplify it as :

	/*
	 * Remove the input connection references from the
	 * destination device for each output connection.
	 */

> +	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
> +		conn = csdev->pdata->out_conns[i];
> +		if (!conn->dest_dev)
> +			continue;
>   
> -	/*
> -	 * Circle throuch all the connection of that component.  If we find
> -	 * a connection whose name matches @csdev, remove it.
> -	 */
> -	for (i = 0; i < iterator->pdata->nr_outconns; i++) {
> -		conn = iterator->pdata->out_conns[i];
> -
> -		/* Child_dev being set signifies that the links were made */
> -		if (csdev->dev.fwnode == conn->dest_fwnode && conn->dest_dev) {
> -			iterator->orphan = true;
> -			coresight_remove_links(iterator, conn);
> -			conn->dest_dev = NULL;
> -			/* No need to continue */
> -			break;
> -		}
> +		for (j = 0; j < conn->dest_dev->pdata->nr_inconns; ++j)
> +			if (conn->dest_dev->pdata->in_conns[j] == conn) {
> +				conn->dest_dev->pdata->in_conns[j] = NULL;
> +				break;
> +			}
>   	}
>   
> -	/*
> -	 * Returning '0' ensures that all known component on the
> -	 * bus will be checked.
> -	 */
> -	return 0;
> -}
> +	/* Remove output connections on input devices */

Similarly here :

	/*
	 * For all input connections, remove references in
	 * the output connection.
	 */
> +	for (i = 0; i < csdev->pdata->nr_inconns; ++i) {
> +		conn = csdev->pdata->in_conns[i];
> +		/* Input conns array is sparse */
> +		if (!conn)
> +			continue;
>   
> -/*
> - * coresight_remove_conns - Remove references to this given devices
> - * from the connections of other devices.
> - */
> -static void coresight_remove_conns(struct coresight_device *csdev)
> -{
> -	/*
> -	 * Another device will point to this device only if there is
> -	 * an output port connected to this one. i.e, if the device
> -	 * doesn't have at least one input port, there is no point
> -	 * in searching all the devices.
> -	 */
> -	if (csdev->pdata->high_inport)
> -		bus_for_each_dev(&coresight_bustype, NULL,
> -				 csdev, coresight_remove_match);
> +		conn->src_dev->orphan = true;
> +		coresight_remove_links(conn->src_dev, conn);
> +		conn->dest_dev = NULL;
> +	}
>   }
>   
>   /**
> @@ -1531,6 +1519,7 @@ void coresight_release_platform_data(struct coresight_device *csdev,
>   		devm_kfree(dev, conns[i]);
>   	}
>   	devm_kfree(dev, pdata->out_conns);
> +	devm_kfree(dev, pdata->in_conns);

As mentioned earlier, this is not required.

>   	devm_kfree(dev, pdata);
>   	if (csdev)
>   		coresight_remove_conns_sysfs_group(csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index bea8f1ba309a..59583df2dc44 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -60,6 +60,35 @@ int coresight_add_out_conn(struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(coresight_add_out_conn);
>   
> +/*
> + * Add an input connection reference to @out_conn in the target's in_conns array
> + *
> + * @out_conn: Existing output connection to store as an input on the
> + *	      connection's remote device.
> + */
> +int coresight_add_in_conn(struct coresight_connection *out_conn)
> +{
> +	int i;
> +	struct device *dev = out_conn->dest_dev->dev.parent;
> +	struct coresight_platform_data *pdata = out_conn->dest_dev->pdata;
> +
> +	for (i = 0; i < pdata->nr_inconns; ++i)
> +		if (!pdata->in_conns[i]) {
> +			pdata->in_conns[i] = out_conn;
> +			return 0;
> +		}
> +
> +	pdata->nr_inconns++;
> +	pdata->in_conns =
> +		devm_krealloc_array(dev, pdata->in_conns, pdata->nr_inconns,
> +				    sizeof(*pdata->in_conns), GFP_KERNEL);
> +	if (!pdata->in_conns)
> +		return -ENOMEM;
> +	pdata->in_conns[pdata->nr_inconns - 1] = out_conn;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(coresight_add_in_conn);
> +
>   static struct device *
>   coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
>   {
> @@ -230,7 +259,7 @@ static int of_coresight_get_cpu(struct device *dev)
>   
>   /*
>    * of_coresight_parse_endpoint : Parse the given output endpoint @ep
> - * and fill the connection information in @conn
> + * and fill the connection information in @in_conn and @out_conn

We don't do anything about the in_conn here ? So this looks a bit
odd.


Rest looks good to me.

Suzuki


>    *
>    * Parses the local port, remote device name and the remote port.
>    *
> diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
> index a4a8e8e642e8..464ba5e1343b 100644
> --- a/drivers/hwtracing/coresight/coresight-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-sysfs.c
> @@ -173,12 +173,6 @@ int coresight_make_links(struct coresight_device *orig,
>   			break;
>   
>   		conn->link = link;
> -
> -		/*
> -		 * Install the device connection. This also indicates that
> -		 * the links are operational on both ends.
> -		 */
> -		conn->dest_dev = target;
>   		return 0;
>   	} while (0);
>   
> @@ -202,5 +196,4 @@ void coresight_remove_links(struct coresight_device *orig,
>   	devm_kfree(&orig->dev, conn->link->orig_name);
>   	devm_kfree(&orig->dev, conn->link);
>   	conn->link = NULL;
> -	conn->dest_dev = NULL;
>   }
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 7197b07deede..aa36680fd264 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -105,6 +105,9 @@ union coresight_dev_subtype {
>    * @nr_inconns: Number of elements for the input connections.
>    * @nr_outconns: Number of elements for the output connections.
>    * @out_conns:	Array of nr_outconns connections from this component.
> + * @in_conns: Sparse array of in_conns. Sparse because the source
> + *	      device owns the connection so when it's unloaded the
> + *	      connection leaves an empty slot.
>    */
>   struct coresight_platform_data {
>   	int high_inport;
> @@ -112,6 +115,7 @@ struct coresight_platform_data {
>   	int nr_inconns;
>   	int nr_outconns;
>   	struct coresight_connection **out_conns;
> +	struct coresight_connection **in_conns;
>   };
>   
>   /**
> @@ -172,6 +176,26 @@ struct coresight_desc {
>    * @dest_dev:	a @coresight_device representation of the component
>   		connected to @src_port. NULL until the device is created
>    * @link: Representation of the connection as a sysfs link.
> + *
> + * The full connection structure looks like this, where in_conns store
> + * references to same connection as the source device's out_conns.
> + *
> + * +-----------------------------+   +-----------------------------+
> + * |coresight_device             |   |coresight_connection         |
> + * |-----------------------------|   |-----------------------------|
> + * |                             |   |                             |
> + * |                             |   |                  remote_dev*|<--
> + * |pdata->out_conns[nr_outconns]|<->|src_dev*                     |   |
> + * |                             |   |                             |   |
> + * +-----------------------------+   +-----------------------------+   |
> + *                                                                     |
> + *                                   +-----------------------------+   |
> + *                                   |coresight_device             |   |
> + *                                   |------------------------------   |
> + *                                   |                             |   |
> + *                                   |  pdata->in_conns[nr_inconns]|<--
> + *                                   |                             |
> + *                                   +-----------------------------+
>    */
>   struct coresight_connection {
>   	int src_port;
> @@ -179,6 +203,7 @@ struct coresight_connection {
>   	struct fwnode_handle *dest_fwnode;
>   	struct coresight_device *dest_dev;
>   	struct coresight_sysfs_link *link;
> +	struct coresight_device *src_dev;
>   };
>   
>   /**
> @@ -614,5 +639,6 @@ struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
>   int coresight_add_out_conn(struct device *dev,
>   			   struct coresight_platform_data *pdata,
>   			   const struct coresight_connection *new_conn);
> +int coresight_add_in_conn(struct coresight_connection *conn);
>   
>   #endif		/* _LINUX_COREISGHT_H */

