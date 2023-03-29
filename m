Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26E46CD8FD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjC2L7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjC2L7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:59:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 993B04C1C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:59:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 997341FB;
        Wed, 29 Mar 2023 04:59:51 -0700 (PDT)
Received: from [10.57.20.1] (unknown [10.57.20.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 156F13F6C4;
        Wed, 29 Mar 2023 04:59:05 -0700 (PDT)
Message-ID: <99668e71-8c5c-9781-4f6c-5feb3395d300@arm.com>
Date:   Wed, 29 Mar 2023 12:59:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   James Clark <james.clark@arm.com>
Subject: Re: [PATCH v2 6/9] coresight: Store in-connections as well as
 out-connections
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230310160610.742382-1-james.clark@arm.com>
 <20230310160610.742382-7-james.clark@arm.com>
 <5f0a3b47-4dd5-8afb-796e-ddde70bbbdbc@arm.com>
Content-Language: en-US
In-Reply-To: <5f0a3b47-4dd5-8afb-796e-ddde70bbbdbc@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/03/2023 20:23, Suzuki K Poulose wrote:
> On 10/03/2023 16:06, James Clark wrote:
>> This will allow CATU to get its associated ETR in a generic way where
>> currently the enable path has some hard coded searches which avoid
>> the need to store input connections.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c  | 56 +++++++++++++++--
>>   .../hwtracing/coresight/coresight-platform.c  | 61 ++++++++++++++++---
>>   drivers/hwtracing/coresight/coresight-sysfs.c |  1 -
>>   include/linux/coresight.h                     | 25 ++++++++
>>   4 files changed, 130 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c
>> b/drivers/hwtracing/coresight/coresight-core.c
>> index f457914e445e..a8ba7493c09a 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -59,6 +59,7 @@ const u32 coresight_barrier_pkt[4] = {0x7fffffff,
>> 0x7fffffff, 0x7fffffff, 0x7fff
>>   EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
>>     static const struct cti_assoc_op *cti_assoc_ops;
>> +static int coresight_fixup_inputs(struct coresight_device *csdev);
>>     ssize_t coresight_simple_show_pair(struct device *_dev,
>>                     struct device_attribute *attr, char *buf)
>> @@ -1369,6 +1370,35 @@ static int coresight_fixup_orphan_conns(struct
>> coresight_device *csdev)
>>                csdev, coresight_orphan_match);
>>   }
>>   +/*
>> + * Device connections are discovered before one/both devices have
>> been created,
>> + * so inputs must be added later.
>> + */
>> +static int coresight_fixup_inputs(struct coresight_device *csdev)
>> +{
>> +    int i, ret = 0;
>> +    struct coresight_connection *out_conn;
>> +    struct coresight_connection in_conn;
>> +
>> +    for (i = 0; i < csdev->pdata->nr_outconns; i++) {
>> +        out_conn = &csdev->pdata->out_conns[i];
>> +        if (!out_conn->remote_dev || !out_conn->remote_dev->pdata)
>> +            continue;
>> +
>> +        /* Reverse local/remote relationships for inputs */
>> +        in_conn.remote_dev = csdev;
>> +        in_conn.remote_port = out_conn->port;
>> +        in_conn.port = out_conn->remote_port;
>> +        in_conn.remote_fwnode = csdev->dev.fwnode;
>> +        ret = coresight_add_in_conn(out_conn->remote_dev->dev.parent,
>> +                        out_conn->remote_dev->pdata,
>> +                        &in_conn);
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>>     static int coresight_fixup_device_conns(struct coresight_device
>> *csdev)
>>   {
>> @@ -1427,11 +1457,20 @@ static int coresight_remove_match(struct
>> device *dev, void *data)
> 
> Removing the connection should be much simpler now with the inports
> connection tracking.
> 
> i.e., coresight_remove_conns() need not iterate over all the devices on
> the coresight bus. We had to do that to find all the devices connecting
> to the removed device.

Done in v3

> 
> Instead with the in_conns we could readily get the csdev instance and
> remove the connection from those devices.
> 
> Similarly for the out_conns can give you the remove device for removing
> the in_conns on that device.
> 
> i.e,
> 
> static void coresight_remove_conns(csdev)
> {
>     struct coresight_device *remote;
>     
>     for (i = 0; i < csdev->pdata->nr_outconns; i++) {
>         remote = csdev->data->out_conns[i].remote_dev;
> 
>         if (!remote)
>             continue;
> 
>         for (j = 0; j < remote->pdata->nr_inconns; j++) {
>             if (remote->pdata->in_conns[i].remote_dev ==  csdev)
>             /* Clear in_conns[i] on remote */
>        
>         }
>         }
> 
>     Similarly for in_conns
>     for (i = 0; i < csdev->pdata->nr_inconns; i++) {
>         remote = csdev->data->in_conns[i].remote_dev;
> 
>         if (!remote)
>             continue;
> 
>         for (j = 0; j < remote->pdata->nr_outconns; j++) {
>             if (remote->pdata->out_conns[i].remote_dev ==  csdev)
>             /* Clear out_conns[i] on remote */
> }
> 
> 
>>                */
>>               fwnode_handle_put(conn->remote_fwnode);
>>               conn->remote_fwnode = NULL;
>> +            conn->remote_dev = NULL;
>> +            /* No need to continue */
>> +            break;
>> +        }
>> +    }
>> +    for (i = 0; i < iterator->pdata->nr_inconns; i++) {
>> +        conn = &iterator->pdata->in_conns[i];
>> +        if (csdev == conn->remote_dev) {
>> +            conn->remote_fwnode = NULL;
>> +            conn->remote_dev = NULL;
>>               /* No need to continue */
>>               break;
>>           }
>>       }
>> -
>>       /*
>>        * Returning '0' ensures that all known component on the
>>        * bus will be checked.
>> @@ -1552,21 +1591,28 @@ void coresight_release_platform_data(struct
>> coresight_device *csdev,
>>         for (i = 0; i < pdata->nr_outconns; i++) {
>>           /* If we have made the links, remove them now */
>> -        if (csdev && conns[i].remote_dev)
>> +        if (csdev && conns[i].remote_dev) {
>>               coresight_remove_links(csdev, &conns[i]);
>> +            conns[i].remote_dev = NULL;
>> +        }
>> +
>>           /*
>>            * Drop the refcount and clear the handle as this device
>>            * is going away
>>            */
>>           if (conns[i].remote_fwnode) {
>>               fwnode_handle_put(conns[i].remote_fwnode);
>> -            pdata->out_conns[i].remote_fwnode = NULL;
>> +            conns[i].remote_fwnode = NULL;
>>           }
>>       }
>> +    for (i = 0; i < pdata->nr_inconns; i++) {
>> +        pdata->in_conns[i].remote_dev = NULL;
>> +        pdata->in_conns[i].remote_fwnode = NULL;
>> +    }
>> +
>>       if (csdev)
>>           coresight_remove_conns_sysfs_group(csdev);
>>   }
>> -
>>   struct coresight_device *coresight_register(struct coresight_desc
>> *desc)
>>   {
>>       int ret;
>> @@ -1659,6 +1705,8 @@ struct coresight_device
>> *coresight_register(struct coresight_desc *desc)
>>       ret = coresight_create_conns_sysfs_group(csdev);
>>       if (!ret)
>>           ret = coresight_fixup_device_conns(csdev);
>> +    if (!ret)
>> +        ret = coresight_fixup_inputs(csdev);
> Don't we also need to fixup the "input" connections on this
> device ? 

> It would be good move all of this connection stuff
> into a wrapper function.
> 

Should be simplified now with coresight_fixup_device_conns() dropped.


>>       if (!ret)
>>           ret = coresight_fixup_orphan_conns(csdev);
>>   diff --git a/drivers/hwtracing/coresight/coresight-platform.c
>> b/drivers/hwtracing/coresight/coresight-platform.c
>> index 16553f7dde12..20e3351cbdc2 100644
>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>> @@ -20,8 +20,7 @@
>>     #include "coresight-priv.h"
>>   /*
>> - * coresight_alloc_conns: Allocate connections record for each output
>> - * port from the device.
>> + * coresight_alloc_conns: Allocate connections record for each
>> input/output device.
>>    */
>>   static int coresight_alloc_conns(struct device *dev,
>>                    struct coresight_platform_data *pdata)
>> @@ -33,7 +32,14 @@ static int coresight_alloc_conns(struct device *dev,
>>           if (!pdata->out_conns)
>>               return -ENOMEM;
>>       }
>> -
>> +    if (pdata->nr_inconns) {
>> +        pdata->in_conns = devm_krealloc_array(dev, pdata->in_conns,
>> +                              pdata->nr_inconns,
>> +                              sizeof(*pdata->in_conns),
>> +                              GFP_KERNEL | __GFP_ZERO);
>> +        if (!pdata->in_conns)
>> +            return -ENOMEM;
>> +    }
> 
> devm_krealloc_array() skips any allocation if the requested new_size <=
> origin_size. So this should be fine for the out_conns, to not realloc
> the space again unnecessarily.

Now out_conns is contiguous so adding always allocates.

> 
>>       return 0;
>>   }
>>   @@ -79,6 +85,45 @@ int coresight_add_conn(struct device *dev,
>>   }
>>   EXPORT_SYMBOL_GPL(coresight_add_conn);
> 
> Should this be named as add_out_conn in the previous patch
> just to make it explicit and easier to read.

Done

> 
>>   +/*
>> + * Add a connection in the first free slot, or realloc
>> + * if there is no space.
>> + *
>> + * Do nothing if the connection already exists because inputs are
>> + * fixed up multiple times.
>> + */
>> +int coresight_add_in_conn(struct device *dev,
>> +              struct coresight_platform_data *pdata,
> 
> minor nit: Is there any reason why this can't simply be:
> 
>    int coresight_add_in_conn(struct coresight_device *csdev,
>                  struct coresight_connection *conn)
>    {
>         struct device *dev = csdev->dev.parent;
>         struct coresight_platform_data *pdata = csdev->pdata;
> 

No I can change it. I was going for consistency with
coresight_add_conn() which does need the device argument because it's
called both before and after the coresight_device is created. But yeah
it makes sense to simplify this one.

>> +              struct coresight_connection *conn)
> 
> 
> Suzuki
> 
> 
>> +{
>> +    int ret;
>> +    struct coresight_connection *free_conn = NULL;
>> +    int i;
>> +
>> +    /* Search for a free slot or exit if a duplicate is found */
>> +    if (pdata->in_conns) {
>> +        for (i = 0; i < pdata->nr_inconns; ++i) {
>> +            if (!free_conn && !pdata->in_conns[i].remote_fwnode)
>> +                free_conn = &pdata->in_conns[i];
>> +            if (pdata->in_conns[i].remote_fwnode ==
>> +                conn->remote_fwnode)
>> +                return 0;
>> +        }
>> +    }
>> +
>> +    if (!free_conn) {
>> +        pdata->nr_inconns++;
>> +        ret = coresight_alloc_conns(dev, pdata);
>> +        if (ret)
>> +            return ret;
>> +        free_conn = &pdata->in_conns[pdata->nr_inconns - 1];
>> +    }
>> +
>> +    *free_conn = *conn;
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(coresight_add_in_conn);
>> +
>>   static struct device *
>>   coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
>>   {
>> @@ -249,7 +294,7 @@ static int of_coresight_get_cpu(struct device *dev)
>>     /*
>>    * of_coresight_parse_endpoint : Parse the given output endpoint @ep
>> - * and fill the connection information in @conn
>> + * and fill the connection information in @in_conn and @out_conn
>>    *
>>    * Parses the local port, remote device name and the remote port.
>>    *
>> @@ -333,14 +378,14 @@ static int of_get_coresight_platform_data(struct
>> device *dev,
>>       /* Get the number of input and output port for this component */
>>       of_coresight_get_ports(node, &pdata->nr_inconns,
>> &pdata->nr_outconns);
>>   -    /* If there are no output connections, we are done */
>> -    if (!pdata->nr_outconns)
>> -        return 0;
>> -
>>       ret = coresight_alloc_conns(dev, pdata);
>>       if (ret)
>>           return ret;
>>   +    /* If there are no output connections, we are done */
>> +    if (!pdata->nr_outconns)
>> +        return 0;
>> +
>>       parent = of_coresight_get_output_ports_node(node);
>>       /*
>>        * If the DT uses obsoleted bindings, the ports are listed
>> diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c
>> b/drivers/hwtracing/coresight/coresight-sysfs.c
>> index 3da9868d9237..2abf9639ac0f 100644
>> --- a/drivers/hwtracing/coresight/coresight-sysfs.c
>> +++ b/drivers/hwtracing/coresight/coresight-sysfs.c
>> @@ -202,5 +202,4 @@ void coresight_remove_links(struct
>> coresight_device *orig,
>>       devm_kfree(&orig->dev, conn->link->orig_name);
>>       devm_kfree(&orig->dev, conn->link);
>>       conn->link = NULL;
>> -    conn->remote_dev = NULL;
>>   }
>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>> index 47fa58d6981d..fd268b24c761 100644
>> --- a/include/linux/coresight.h
>> +++ b/include/linux/coresight.h
>> @@ -110,6 +110,7 @@ struct coresight_platform_data {
>>       int nr_inconns;
>>       int nr_outconns;
>>       struct coresight_connection *out_conns;
>> +    struct coresight_connection *in_conns;
> 
> Please document the field above the structure.
> 
> Suzuki

Done

> 
> 
>>   };
>>     /**
>> @@ -177,6 +178,27 @@ struct coresight_desc {
>>    *               @remote_fwnode once the remote's coresight_device has
>>    *               been created.
>>    * @link: Representation of the connection as a sysfs link.
>> + *
>> + * The full connection structure looks like this, where in_conns
>> store references to
>> + * the parent device in the same remote_dev member as output
>> connections.
>> + *
>> + *       +-----------------------------+           
>> +-----------------------------+
>> + *       |coresight_device             |           
>> |coresight_connection         |
>> + *       |-----------------------------|           
>> |-----------------------------|
>> + *  ---->|                             |           
>> |                             |
>> + *  |    |                             |           
>> |                  remote_dev*|------
>> + *  |   
>> |pdata->out_conns[nr_outconns]|----------->|                             |      |
>> + *  |    |                             |           
>> |                             |      |
>> + *  |    +-----------------------------+           
>> +-----------------------------+      |
>> + * 
>> |                                                                                    |
>> + *  |    +-----------------------------+           
>> +-----------------------------+      |
>> + *  |    |coresight_connection         |           
>> |coresight_device             |      |
>> + *  |    |-----------------------------|           
>> |------------------------------      |
>> + *  |    |                             |           
>> |                             |<-----
>> + *  -----|remote_dev*                  |           
>> |                             |
>> + *       |                            
>> |<-----------|pdata->in_conns[nr_inconns]  |
>> + *       |                             |           
>> |                             |
>> + *       +-----------------------------+           
>> +-----------------------------+
>>    */
>>   struct coresight_connection {
>>       int port;
>> @@ -619,5 +641,8 @@ struct coresight_platform_data
>> *coresight_get_platform_data(struct device *dev);
>>   int coresight_add_conn(struct device *dev,
>>                  struct coresight_platform_data *pdata,
>>                  const struct coresight_connection *conn);
>> +int coresight_add_in_conn(struct device *dev,
>> +              struct coresight_platform_data *pdata,
>> +              struct coresight_connection *conn);
>>     #endif        /* _LINUX_COREISGHT_H */
> 
