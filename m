Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDE9692A72
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjBJWrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjBJWrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:47:17 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE61C392BC;
        Fri, 10 Feb 2023 14:47:10 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AM8Dm2014714;
        Fri, 10 Feb 2023 22:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OR+rSHgbq9Jb+h2z2LbeqbVbwF8TaXfjHan2tTJ6BNs=;
 b=ZMz7m5MbnxtGIMh0yIv6d2TkSsay3qMWCGy5q64jrzO7kHMCK4Efy/0xQegtCy0EOS7g
 s0va05ViU0dEmUhiGEKbObiys+DexMMGnkJV1uj8Zew8NnUHc45t2sYH64XhybO49uQk
 tnb73QypaUqJZ5NauIOaN9J1ThTh2G3WJcBAyP+weDp/YbUEN92cVl6d8SUuLJV9ejMe
 AGTwwVfWy7fARxvZK0vGJkaGMTRNdU1U8Odtx8PxK360Fb0EtFnXct2lvj+SJzw1neC9
 onplcMYGGcBn3CgDmlKu/O3KFbKBJPX6kE5pNpsCrp/dx/htzh8nc5034xyYFB7hVQ70 Sw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nndu5abxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 22:46:41 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31AMkexS017575
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 22:46:40 GMT
Received: from [10.110.21.35] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 10 Feb
 2023 14:46:39 -0800
Message-ID: <37ba7867-a952-4421-4124-af5b8442b3eb@quicinc.com>
Date:   Fri, 10 Feb 2023 14:46:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v2 07/22] ASoC: Add SOC USB APIs for adding an USB
 backend
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Thinh.Nguyen@synopsys.com>,
        <broonie@kernel.org>, <bgoswami@quicinc.com>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <agross@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-8-quic_wcheng@quicinc.com> <Y9UiiMbJFjkzyEol@kroah.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <Y9UiiMbJFjkzyEol@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9rtKWReMHrtolFjAe7gIZubfP2eCCq1J
X-Proofpoint-GUID: 9rtKWReMHrtolFjAe7gIZubfP2eCCq1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 suspectscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100195
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 1/28/2023 5:26 AM, Greg KH wrote:
> On Wed, Jan 25, 2023 at 07:14:09PM -0800, Wesley Cheng wrote:
>> diff --git a/include/sound/soc-usb.h b/include/sound/soc-usb.h
>> new file mode 100644
>> index 000000000000..ec422a8a834f
>> --- /dev/null
>> +++ b/include/sound/soc-usb.h
>> @@ -0,0 +1,33 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> + *
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> 
> It is now 2023 :)
> 

Sorry for the delayed response.  Will change the year for all the 
patches...time flies.

>> + */
>> +
>> +#ifndef __LINUX_SND_SOC_USB_H
>> +#define __LINUX_SND_SOC_USB_H
>> +
>> +/**
>> + * struct snd_soc_usb
>> + * @component - Reference to DAPM component
>> + * @connection_status_cb - callback to notify connection events
>> + * @priv_data - vendor data
> 
> You do not document all items in the structure so you will get build
> warnings :(
> 
> And what exactly is "vendor data"?  You use that term in a few places in
> this series, there is no such thing as a "vendor" in the kernel.  This
> could be a device or driver specific data, but not a "vendor".
> 

The term vendor data can be renamed to something else.  It essentially 
signifies that each platform can potentially have a different 
implementation of how these callbacks behave.  It makes sense to rename 
it into driver specific data, since it depends on how the offload driver 
is added.

>> --- /dev/null
>> +++ b/sound/soc/soc-usb.c
>> @@ -0,0 +1,202 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +#include <linux/of.h>
>> +#include <linux/usb.h>
>> +#include <sound/soc.h>
>> +#include <sound/soc-usb.h>
>> +#include "../usb/card.h"
>> +
>> +static DEFINE_MUTEX(ctx_mutex);
>> +static LIST_HEAD(usb_ctx_list);
> 
> What is this a list of?  Why a list?  This should be dynamic and tied to
> the device itself somehow, not a separate list you have to walk.
> 

This is a list of USB backends that have been registered.  At the moment 
we only have one USB backend, as the audio DSP only supports playback on 
a single device through the offload path (on our chipset).  Potentially, 
if there are other platforms that can support multiple, they can 
register several USB backends to control each offload path accordingly.

It was difficult to tie the "struct snd_soc_usb" into a device, because 
of how different the device lifetime is for the USB audio device (udev) 
and the USB backend (one is dynamically created/freed based on USB 
device plugged into the port, the other exists until the backend is 
removed), and the fact that communication has to happen both ways.  This 
warrented a need to have this structure exist as a separate entity, 
hence the reason why I went with a list.

>> +
>> +#define for_each_usb_ctx(ctx)			\
>> +	list_for_each_entry(ctx, &usb_ctx_list, list)
> 
> No need for a #define like this, just spell it out.
> 
> 

Sure.

>> +
>> +static struct device_node *snd_soc_find_phandle(struct device *dev)
>> +{
>> +	struct device_node *node;
>> +
>> +	node = of_parse_phandle(dev->of_node, "usb-soc-be", 0);
>> +	if (!node)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	return node;
>> +}
>> +
>> +static struct snd_soc_usb *snd_soc_find_usb_ctx(struct device *dev)
>> +{
>> +	struct device_node *node;
>> +	struct snd_soc_usb *ctx = NULL;
>> +
>> +	node = snd_soc_find_phandle(dev);
>> +	if (IS_ERR(node))
>> +		return NULL;
>> +
>> +	mutex_lock(&ctx_mutex);
>> +	for_each_usb_ctx(ctx) {
>> +		if (ctx->dev->of_node == node) {
>> +			of_node_put(node);
>> +			mutex_unlock(&ctx_mutex);
>> +			return ctx;
>> +		}
>> +	}
>> +	of_node_put(node);
>> +	mutex_unlock(&ctx_mutex);
>> +
>> +	return NULL;
>> +}
>> +
>> +/**
>> + * snd_soc_usb_get_priv_data() - Retrieve private data stored
>> + * @usbdev: USB bus sysdev
>> + *
>> + * Fetch the private data stored in the USB SND SOC structure.  This is
>> + * intended to be called by the USB offloading class driver, in order to
>> + * attain parameters about the USB backend device.
>> + *
>> + */
>> +void *snd_soc_usb_get_priv_data(struct device *usbdev)
>> +{
>> +	struct snd_soc_usb *ctx;
>> +
>> +	if (!usbdev)
>> +		return NULL;
> 
> How could usbdev ever be NULL?
> 
>> +
>> +	ctx = snd_soc_find_usb_ctx(usbdev);
>> +
>> +	return ctx ? ctx->priv_data : NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_usb_get_priv_data);
>> +
>> +/**
>> + * snd_soc_usb_set_priv_data() - Set private data stored
>> + * @dev: USB backend device
>> + * @priv: private data to store
>> + *
>> + * Save data describing the USB backend device parameters.  This is intended
>> + * to be called by the ASoC USB backend driver.
>> + *
>> + */
>> +void snd_soc_usb_set_priv_data(struct device *dev, void *priv)
>> +{
>> +	struct snd_soc_usb *ctx;
> 
> 
> Why does this function take a "struct device" but the get function take
> a USB device?
> 

I can modify that.  It was done this way with the intention to not have 
the USB SND offload driver worry about finding the USB backend device. 
But in a way, it does indirectly place a design where the USB SND 
offload is the consumer of the platform data, and the USB backend is the 
source.

>> +
>> +	mutex_lock(&ctx_mutex);
>> +	for_each_usb_ctx(ctx) {
>> +		if (dev->of_node == ctx->dev->of_node) {
>> +			ctx->priv_data = priv;
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&ctx_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_usb_set_priv_data);
>> +
>> +/**
>> + * snd_soc_usb_add_port() - Add a USB backend port
>> + * @dev: USB backend device
>> + * @connection_cb: connection status callback
>> + *
>> + * Register a USB backend device to the SND USB SOC framework.  Memory is
>> + * allocated as part of the USB backend device.
>> + *
>> + */
>> +struct snd_soc_usb *snd_soc_usb_add_port(struct device *dev,
>> +			int (*connection_cb)(struct snd_soc_usb *usb, int card_idx,
>> +			int connected))
>> +{
>> +	struct snd_soc_usb *usb;
>> +
>> +	usb = devm_kzalloc(dev, sizeof(*usb), GFP_KERNEL);
>> +	if (!usb)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	usb->connection_status_cb = connection_cb;
>> +	usb->dev = dev;
>> +
>> +	mutex_lock(&ctx_mutex);
>> +	list_add_tail(&usb->list, &usb_ctx_list);
>> +	mutex_unlock(&ctx_mutex);
> 
> Again, why a list?
> 
> 
>> +
>> +	return usb;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_usb_add_port);
>> +
>> +/**
>> + * snd_soc_usb_remove_port() - Remove a USB backend port
>> + * @dev: USB backend device
>> + *
>> + * Remove a USB backend device from USB SND SOC.  Memory is freed when USB
>> + * backend is removed.
>> + *
>> + */
>> +int snd_soc_usb_remove_port(struct device *dev)
>> +{
>> +	struct snd_soc_usb *ctx, *tmp;
>> +
>> +	mutex_lock(&ctx_mutex);
>> +	list_for_each_entry_safe(ctx, tmp, &usb_ctx_list, list) {
>> +		if (ctx->dev == dev) {
>> +			list_del(&ctx->list);
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&ctx_mutex);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_usb_remove_port);
>> +
>> +/**
>> + * snd_soc_usb_connect() - Notification of USB device connection
>> + * @usbdev: USB bus device
>> + * @card_idx: USB SND card instance
>> + *
>> + * Notify of a new USB SND device connection.  The card_idx can be used to
>> + * handle how the USB backend selects, which device to enable offloading on.
>> + *
>> + */
>> +int snd_soc_usb_connect(struct device *usbdev, int card_idx)
>> +{
>> +	struct snd_soc_usb *ctx;
>> +
>> +	if (!usbdev)
>> +		return -ENODEV;
>> +
>> +	ctx = snd_soc_find_usb_ctx(usbdev);
>> +	if (!ctx)
>> +		return -ENODEV;
>> +
>> +	if (ctx->connection_status_cb)
>> +		ctx->connection_status_cb(ctx, card_idx, 1);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_usb_connect);
>> +
>> +/**
>> + * snd_soc_usb_connect() - Notification of USB device connection
>> + * @usbdev: USB bus device
>> + *
>> + * Notify of a new USB SND device disconnection to the USB backend.
>> + *
>> + */
>> +int snd_soc_usb_disconnect(struct device *usbdev)
>> +{
>> +	struct snd_soc_usb *ctx;
>> +
>> +	if (!usbdev)
>> +		return -ENODEV;
>> +
>> +	ctx = snd_soc_find_usb_ctx(usbdev);
>> +	if (!ctx)
>> +		return -ENODEV;
>> +
>> +	if (ctx->connection_status_cb)
>> +		ctx->connection_status_cb(ctx, -1, 0);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_usb_disconnect);
> 
> Meta-comment, why are all of these in the sound directory?  They are
> only operating on USB devices, nothing else.  So why here?
> 

The USB SND exists in the sound directory as well as the ASoC framework. 
  The main goal of this is to abstract USB SND to components that ASoC 
requires, versus having to expose all of USB SND.

Thanks
Wesley Cheng

