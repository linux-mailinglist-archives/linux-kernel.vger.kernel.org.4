Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A146B8A70
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCNFgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCNFgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:36:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA5C173C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:35:57 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E3duEX023752;
        Tue, 14 Mar 2023 05:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1Cwi2udlyx50NbK3oP5Fm8bj2V8P0DfwAvN9UdcJrxI=;
 b=HsefCAS8voe8rswxAf1xiOnEDuEIH1eAcJPMpnaXbuVuBP5ha5bYMPjCsZ1/rQRwyZYn
 A7Ix3pwAAQjPWY3kLSYsxkwVcquojHOclHrCD4IlEj+b5K2Hsp1P2HO7Jg3D83Av/rBN
 onYJ3BArJGJxpicIC2t8dfIbFLBaUUKJ6CBuoU8VgqIyB7dztsE/0zoIZX/tk4oQ7H0Y
 a/EmGvuESBrnUM2UoWjcz3ur46DuFSx5YfN4VjdMK3iPbxBg1pX+T9WjHDbW4CqT3hAk
 SiH1847SJEgMCcNxUJJkB+bsVXDvLjR3kkCT993WHH077cAo3YO6O9RhMNT1WcOB9zMD BQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa6n31rrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 05:35:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32E5ZCl4021576
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 05:35:12 GMT
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 13 Mar
 2023 22:35:09 -0700
Message-ID: <b0cf2f22-1824-bb06-1648-3570fd6540a4@quicinc.com>
Date:   Tue, 14 Mar 2023 13:35:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 6/9] coresight: Store in-connections as well as
 out-connections
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, <coresight@lists.linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230310160610.742382-1-james.clark@arm.com>
 <20230310160610.742382-7-james.clark@arm.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <20230310160610.742382-7-james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SXpZOlh1g1iSeRvwi1nZXaCe1BqGiEzp
X-Proofpoint-GUID: SXpZOlh1g1iSeRvwi1nZXaCe1BqGiEzp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_13,2023-03-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=970 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/11/2023 12:06 AM, James Clark wrote:
> This will allow CATU to get its associated ETR in a generic way where
> currently the enable path has some hard coded searches which avoid
> the need to store input connections.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c  | 56 +++++++++++++++--
>   .../hwtracing/coresight/coresight-platform.c  | 61 ++++++++++++++++---
>   drivers/hwtracing/coresight/coresight-sysfs.c |  1 -
>   include/linux/coresight.h                     | 25 ++++++++
>   4 files changed, 130 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index f457914e445e..a8ba7493c09a 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -59,6 +59,7 @@ const u32 coresight_barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fff
>   EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
>   
>   static const struct cti_assoc_op *cti_assoc_ops;
> +static int coresight_fixup_inputs(struct coresight_device *csdev);
>   
>   ssize_t coresight_simple_show_pair(struct device *_dev,
>   			      struct device_attribute *attr, char *buf)
> @@ -1369,6 +1370,35 @@ static int coresight_fixup_orphan_conns(struct coresight_device *csdev)
>   			 csdev, coresight_orphan_match);
>   }
>   
> +/*
> + * Device connections are discovered before one/both devices have been created,
> + * so inputs must be added later.
> + */
> +static int coresight_fixup_inputs(struct coresight_device *csdev)
> +{
> +	int i, ret = 0;
> +	struct coresight_connection *out_conn;
> +	struct coresight_connection in_conn;
> +
> +	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
> +		out_conn = &csdev->pdata->out_conns[i];
> +		if (!out_conn->remote_dev || !out_conn->remote_dev->pdata)
> +			continue;

Hi James,

If out_conn->remote_dev is null here,  the in_conn of 
out_conn->remote_dev->pdata will never be set.
For example, device A is connected to in_port 0 of device B. If device A 
is probed first, the in_conn of device
B will not be set.
Do we need to add Defer probe return here ? I tested with defer probe 
return, it works.

         for (i = 0; i < csdev->pdata->nr_outconns; i++) {
                 out_conn = &csdev->pdata->out_conns[i];
                 if (!out_conn->remote_dev || !out_conn->remote_dev->pdata)
-                       continue;
+                        return -EPROBE_DEFER;

Thanks
Jinlong Mao

> +
> +		/* Reverse local/remote relationships for inputs */
> +		in_conn.remote_dev = csdev;
> +		in_conn.remote_port = out_conn->port;
> +		in_conn.port = out_conn->remote_port;
> +		in_conn.remote_fwnode = csdev->dev.fwnode;
> +		ret = coresight_add_in_conn(out_conn->remote_dev->dev.parent,
> +					    out_conn->remote_dev->pdata,
> +					    &in_conn);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
>   
>   static int coresight_fixup_device_conns(struct coresight_device *csdev)
>   {
> @@ -1427,11 +1457,20 @@ static int coresight_remove_match(struct device *dev, void *data)
>   			 */
>   			fwnode_handle_put(conn->remote_fwnode);
>   			conn->remote_fwnode = NULL;
> +			conn->remote_dev = NULL;
> +			/* No need to continue */
> +			break;
> +		}
> +	}
> +	for (i = 0; i < iterator->pdata->nr_inconns; i++) {
> +		conn = &iterator->pdata->in_conns[i];
> +		if (csdev == conn->remote_dev) {
> +			conn->remote_fwnode = NULL;
> +			conn->remote_dev = NULL;
>   			/* No need to continue */
>   			break;
>   		}
>   	}
> -
>   	/*
>   	 * Returning '0' ensures that all known component on the
>   	 * bus will be checked.
> @@ -1552,21 +1591,28 @@ void coresight_release_platform_data(struct coresight_device *csdev,
>   
>   	for (i = 0; i < pdata->nr_outconns; i++) {
>   		/* If we have made the links, remove them now */
> -		if (csdev && conns[i].remote_dev)
> +		if (csdev && conns[i].remote_dev) {
>   			coresight_remove_links(csdev, &conns[i]);
> +			conns[i].remote_dev = NULL;
> +		}
> +
>   		/*
>   		 * Drop the refcount and clear the handle as this device
>   		 * is going away
>   		 */
>   		if (conns[i].remote_fwnode) {
>   			fwnode_handle_put(conns[i].remote_fwnode);
> -			pdata->out_conns[i].remote_fwnode = NULL;
> +			conns[i].remote_fwnode = NULL;
>   		}
>   	}
> +	for (i = 0; i < pdata->nr_inconns; i++) {
> +		pdata->in_conns[i].remote_dev = NULL;
> +		pdata->in_conns[i].remote_fwnode = NULL;
> +	}
> +
>   	if (csdev)
>   		coresight_remove_conns_sysfs_group(csdev);
>   }
> -
>   struct coresight_device *coresight_register(struct coresight_desc *desc)
>   {
>   	int ret;
> @@ -1659,6 +1705,8 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   	ret = coresight_create_conns_sysfs_group(csdev);
>   	if (!ret)
>   		ret = coresight_fixup_device_conns(csdev);
> +	if (!ret)
> +		ret = coresight_fixup_inputs(csdev);
>   	if (!ret)
>   		ret = coresight_fixup_orphan_conns(csdev);
>   
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 16553f7dde12..20e3351cbdc2 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -20,8 +20,7 @@
>   
>   #include "coresight-priv.h"
>   /*
> - * coresight_alloc_conns: Allocate connections record for each output
> - * port from the device.
> + * coresight_alloc_conns: Allocate connections record for each input/output device.
>    */
>   static int coresight_alloc_conns(struct device *dev,
>   				 struct coresight_platform_data *pdata)
> @@ -33,7 +32,14 @@ static int coresight_alloc_conns(struct device *dev,
>   		if (!pdata->out_conns)
>   			return -ENOMEM;
>   	}
> -
> +	if (pdata->nr_inconns) {
> +		pdata->in_conns = devm_krealloc_array(dev, pdata->in_conns,
> +						      pdata->nr_inconns,
> +						      sizeof(*pdata->in_conns),
> +						      GFP_KERNEL | __GFP_ZERO);
> +		if (!pdata->in_conns)
> +			return -ENOMEM;
> +	}
>   	return 0;
>   }
>   
> @@ -79,6 +85,45 @@ int coresight_add_conn(struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(coresight_add_conn);
>   
> +/*
> + * Add a connection in the first free slot, or realloc
> + * if there is no space.
> + *
> + * Do nothing if the connection already exists because inputs are
> + * fixed up multiple times.
> + */
> +int coresight_add_in_conn(struct device *dev,
> +			  struct coresight_platform_data *pdata,
> +			  struct coresight_connection *conn)
> +{
> +	int ret;
> +	struct coresight_connection *free_conn = NULL;
> +	int i;
> +
> +	/* Search for a free slot or exit if a duplicate is found */
> +	if (pdata->in_conns) {
> +		for (i = 0; i < pdata->nr_inconns; ++i) {
> +			if (!free_conn && !pdata->in_conns[i].remote_fwnode)
> +				free_conn = &pdata->in_conns[i];
> +			if (pdata->in_conns[i].remote_fwnode ==
> +			    conn->remote_fwnode)
> +				return 0;
> +		}
> +	}
> +
> +	if (!free_conn) {
> +		pdata->nr_inconns++;
> +		ret = coresight_alloc_conns(dev, pdata);
> +		if (ret)
> +			return ret;
> +		free_conn = &pdata->in_conns[pdata->nr_inconns - 1];
> +	}
> +
> +	*free_conn = *conn;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(coresight_add_in_conn);
> +
>   static struct device *
>   coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
>   {
> @@ -249,7 +294,7 @@ static int of_coresight_get_cpu(struct device *dev)
>   
>   /*
>    * of_coresight_parse_endpoint : Parse the given output endpoint @ep
> - * and fill the connection information in @conn
> + * and fill the connection information in @in_conn and @out_conn
>    *
>    * Parses the local port, remote device name and the remote port.
>    *
> @@ -333,14 +378,14 @@ static int of_get_coresight_platform_data(struct device *dev,
>   	/* Get the number of input and output port for this component */
>   	of_coresight_get_ports(node, &pdata->nr_inconns, &pdata->nr_outconns);
>   
> -	/* If there are no output connections, we are done */
> -	if (!pdata->nr_outconns)
> -		return 0;
> -
>   	ret = coresight_alloc_conns(dev, pdata);
>   	if (ret)
>   		return ret;
>   
> +	/* If there are no output connections, we are done */
> +	if (!pdata->nr_outconns)
> +		return 0;
> +
>   	parent = of_coresight_get_output_ports_node(node);
>   	/*
>   	 * If the DT uses obsoleted bindings, the ports are listed
> diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
> index 3da9868d9237..2abf9639ac0f 100644
> --- a/drivers/hwtracing/coresight/coresight-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-sysfs.c
> @@ -202,5 +202,4 @@ void coresight_remove_links(struct coresight_device *orig,
>   	devm_kfree(&orig->dev, conn->link->orig_name);
>   	devm_kfree(&orig->dev, conn->link);
>   	conn->link = NULL;
> -	conn->remote_dev = NULL;
>   }
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 47fa58d6981d..fd268b24c761 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -110,6 +110,7 @@ struct coresight_platform_data {
>   	int nr_inconns;
>   	int nr_outconns;
>   	struct coresight_connection *out_conns;
> +	struct coresight_connection *in_conns;
>   };
>   
>   /**
> @@ -177,6 +178,27 @@ struct coresight_desc {
>    *               @remote_fwnode once the remote's coresight_device has
>    *               been created.
>    * @link: Representation of the connection as a sysfs link.
> + *
> + * The full connection structure looks like this, where in_conns store references to
> + * the parent device in the same remote_dev member as output connections.
> + *
> + *       +-----------------------------+            +-----------------------------+
> + *       |coresight_device             |            |coresight_connection         |
> + *       |-----------------------------|            |-----------------------------|
> + *  ---->|                             |            |                             |
> + *  |    |                             |            |                  remote_dev*|------
> + *  |    |pdata->out_conns[nr_outconns]|----------->|                             |      |
> + *  |    |                             |            |                             |      |
> + *  |    +-----------------------------+            +-----------------------------+      |
> + *  |                                                                                    |
> + *  |    +-----------------------------+            +-----------------------------+      |
> + *  |    |coresight_connection         |            |coresight_device             |      |
> + *  |    |-----------------------------|            |------------------------------      |
> + *  |    |                             |            |                             |<-----
> + *  -----|remote_dev*                  |            |                             |
> + *       |                             |<-----------|pdata->in_conns[nr_inconns]  |
> + *       |                             |            |                             |
> + *       +-----------------------------+            +-----------------------------+
>    */
>   struct coresight_connection {
>   	int port;
> @@ -619,5 +641,8 @@ struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
>   int coresight_add_conn(struct device *dev,
>   		       struct coresight_platform_data *pdata,
>   		       const struct coresight_connection *conn);
> +int coresight_add_in_conn(struct device *dev,
> +			  struct coresight_platform_data *pdata,
> +			  struct coresight_connection *conn);
>   
>   #endif		/* _LINUX_COREISGHT_H */
