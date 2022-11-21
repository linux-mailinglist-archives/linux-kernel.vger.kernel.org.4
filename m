Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB39631E16
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiKUKTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKUKTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:19:07 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6070483EBB;
        Mon, 21 Nov 2022 02:19:06 -0800 (PST)
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D913F74C;
        Mon, 21 Nov 2022 11:19:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669025944;
        bh=MWp2ArHwPgTyvxR4jLbCsfZJPBk4vU4SIcu04URLSyA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vMo4ntoUH6/TTZ1U3TXR/7DneD1f6M8+9hwapEO+PzEsW+CtRVS1wxWKUeC8y+A7P
         RClZQqFEqYuqXKwpv6WXIKIKsZakauQMJhRG353fUDr/njhIRBs2s4T9xMD1f+AEHl
         xT6LTNyzPnmaG1zmA/1p4BMn+bli3BBcFV9Bo6v4=
Message-ID: <2c69ae41-7920-1438-8bfc-8581aad0ee00@ideasonboard.com>
Date:   Mon, 21 Nov 2022 10:19:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/4] media: ipu3-cio2: Convert to use
 software_node_register_node_group()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>
References: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
 <20221118185617.33908-2-andriy.shevchenko@linux.intel.com>
From:   Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <20221118185617.33908-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

On 18/11/2022 18:56, Andy Shevchenko wrote:
> The currently used software_node_register_nodes() is going to
> be removed. Prepare driver by switchich to new API.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---


Also looks good to me:

Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>

>   drivers/media/pci/intel/ipu3/cio2-bridge.c | 21 ++++++++++++++++++---
>   drivers/media/pci/intel/ipu3/cio2-bridge.h |  5 +++--
>   2 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
> index 18974a72e94a..dfefe0d8aa95 100644
> --- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
> +++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
> @@ -195,6 +195,19 @@ static void cio2_bridge_init_swnode_names(struct cio2_sensor *sensor)
>   		 SWNODE_GRAPH_ENDPOINT_NAME_FMT, 0); /* And endpoint 0 */
>   }
>   
> +static void cio2_bridge_init_swnode_group(struct cio2_sensor *sensor)
> +{
> +	struct software_node *nodes = sensor->swnodes;
> +
> +	sensor->group[SWNODE_SENSOR_HID] = &nodes[SWNODE_SENSOR_HID];
> +	sensor->group[SWNODE_SENSOR_PORT] = &nodes[SWNODE_SENSOR_PORT];
> +	sensor->group[SWNODE_SENSOR_ENDPOINT] = &nodes[SWNODE_SENSOR_ENDPOINT];
> +	sensor->group[SWNODE_CIO2_PORT] = &nodes[SWNODE_CIO2_PORT];
> +	sensor->group[SWNODE_CIO2_ENDPOINT] = &nodes[SWNODE_CIO2_ENDPOINT];
> +	if (sensor->ssdb.vcmtype)
> +		sensor->group[SWNODE_VCM] =  &nodes[SWNODE_VCM];
> +}
> +
>   static void cio2_bridge_create_connection_swnodes(struct cio2_bridge *bridge,
>   						  struct cio2_sensor *sensor)
>   {
> @@ -219,6 +232,8 @@ static void cio2_bridge_create_connection_swnodes(struct cio2_bridge *bridge,
>   	if (sensor->ssdb.vcmtype)
>   		nodes[SWNODE_VCM] =
>   			NODE_VCM(cio2_vcm_types[sensor->ssdb.vcmtype - 1]);
> +
> +	cio2_bridge_init_swnode_group(sensor);
>   }
>   
>   static void cio2_bridge_instantiate_vcm_i2c_client(struct cio2_sensor *sensor)
> @@ -252,7 +267,7 @@ static void cio2_bridge_unregister_sensors(struct cio2_bridge *bridge)
>   
>   	for (i = 0; i < bridge->n_sensors; i++) {
>   		sensor = &bridge->sensors[i];
> -		software_node_unregister_nodes(sensor->swnodes);
> +		software_node_unregister_node_group(sensor->group);
>   		ACPI_FREE(sensor->pld);
>   		acpi_dev_put(sensor->adev);
>   		i2c_unregister_device(sensor->vcm_i2c_client);
> @@ -310,7 +325,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
>   		cio2_bridge_create_fwnode_properties(sensor, bridge, cfg);
>   		cio2_bridge_create_connection_swnodes(bridge, sensor);
>   
> -		ret = software_node_register_nodes(sensor->swnodes);
> +		ret = software_node_register_node_group(sensor->group);
>   		if (ret)
>   			goto err_free_pld;
>   
> @@ -337,7 +352,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
>   	return 0;
>   
>   err_free_swnodes:
> -	software_node_unregister_nodes(sensor->swnodes);
> +	software_node_unregister_node_group(sensor->group);
>   err_free_pld:
>   	ACPI_FREE(sensor->pld);
>   err_put_adev:
> diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.h b/drivers/media/pci/intel/ipu3/cio2-bridge.h
> index 4418cbd08208..b93b749c65bd 100644
> --- a/drivers/media/pci/intel/ipu3/cio2-bridge.h
> +++ b/drivers/media/pci/intel/ipu3/cio2-bridge.h
> @@ -117,8 +117,9 @@ struct cio2_sensor {
>   	struct acpi_device *adev;
>   	struct i2c_client *vcm_i2c_client;
>   
> -	/* SWNODE_COUNT + 1 for terminating empty node */
> -	struct software_node swnodes[SWNODE_COUNT + 1];
> +	/* SWNODE_COUNT + 1 for terminating NULL */
> +	const struct software_node *group[SWNODE_COUNT + 1];
> +	struct software_node swnodes[SWNODE_COUNT];
>   	struct cio2_node_names node_names;
>   
>   	struct cio2_sensor_ssdb ssdb;
