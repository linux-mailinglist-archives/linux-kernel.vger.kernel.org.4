Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E664615674
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 01:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiKBANe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 20:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKBANa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 20:13:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AF1CC6;
        Tue,  1 Nov 2022 17:13:27 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A1MiRXB001653;
        Wed, 2 Nov 2022 00:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JfppMY0X0fYI0iXcP7M2po93gSaKxuFL5ujKH3pEeeg=;
 b=AHIsYmwT4yZf6FuHnT6RqAGS66FpLn0jogPpmku51l8J+g7t/9aX6EpEzbJKjT6KaEL1
 An3dckKeJ4/CulRKuFl8D+ggfzu0/Md0xL8zIB/vWBqwwaw4CNZnN5G/WkNqnMgvGe6u
 Y7nrnSD4zI08oB5kFUFAv26wiclhnjCOS/wC60oK2XhSuh2GwPMuPOGaWwVE5JiRzyDy
 vFjr8sZAigDPS1+EA5q3E4NUUZmBFAoSEZL9iMwiUolb6RAgn08TNgnj/bwTr5i9WqZe
 NCR91MmaeB7aXRwF7WtFqaQIn6TKWV1kLycDpZ5s4QccWjNfJ/YUaS/0e1zdzeMVQN/H 1Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kk7nfgpe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 00:13:01 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A20D0j6029653
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 00:13:00 GMT
Received: from [10.134.65.5] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 1 Nov 2022
 17:12:59 -0700
Message-ID: <3d2858fe-ea3e-159c-faff-5052cba1e08c@quicinc.com>
Date:   Tue, 1 Nov 2022 17:12:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 10/21] gunyah: rsc_mgr: Add resource manager RPC core
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-11-quic_eberman@quicinc.com>
 <Y2FfKCKZ3N8rOqcT@kroah.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y2FfKCKZ3N8rOqcT@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: v9smqBA09ubC9IbLN910FsFMUxKYYyx0
X-Proofpoint-GUID: v9smqBA09ubC9IbLN910FsFMUxKYYyx0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_11,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/2022 11:02 AM, Greg Kroah-Hartman wrote:
> On Wed, Oct 26, 2022 at 11:58:35AM -0700, Elliot Berman wrote:
>> The resource manager is a special virtual machine which is always
>> running on a Gunyah system. It provides APIs for creating and destroying
>> VMs, secure memory management, sharing/lending of memory between VMs,
>> and setup of inter-VM communication. Calls to the resource manager are
>> made via message queues.
>>
>> This patch implements the basic probing and RPC mechanism to make those
>> API calls. Request/response calls can be made with gh_rm_call.
>> Drivers can also register to notifications pushed by RM via
>> gh_rm_register_notifier
>>
>> Specific API calls that resource manager supports will be implemented in
>> subsequent patches.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   MAINTAINERS                    |   2 +-
>>   drivers/virt/gunyah/Kconfig    |  15 +
>>   drivers/virt/gunyah/Makefile   |   3 +
>>   drivers/virt/gunyah/rsc_mgr.c  | 602 +++++++++++++++++++++++++++++++++
>>   drivers/virt/gunyah/rsc_mgr.h  |  34 ++
>>   include/linux/gunyah_rsc_mgr.h |  26 ++
>>   6 files changed, 681 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/virt/gunyah/rsc_mgr.c
>>   create mode 100644 drivers/virt/gunyah/rsc_mgr.h
>>   create mode 100644 include/linux/gunyah_rsc_mgr.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 586539eadd3b..e072a0d2e553 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8945,7 +8945,7 @@ F:	Documentation/virt/gunyah/
>>   F:	arch/arm64/gunyah/
>>   F:	drivers/mailbox/gunyah-msgq.c
>>   F:	drivers/virt/gunyah/
>> -F:	include/linux/gunyah.h
>> +F:	include/linux/gunyah*.h
>>   
>>   HABANALABS PCI DRIVER
>>   M:	Oded Gabbay <ogabbay@kernel.org>
>> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
>> index 127156a678a6..4de88d80aa7b 100644
>> --- a/drivers/virt/gunyah/Kconfig
>> +++ b/drivers/virt/gunyah/Kconfig
>> @@ -10,3 +10,18 @@ config GUNYAH
>>   
>>   	  Say Y/M here to enable the drivers needed to interact in a Gunyah
>>   	  virtual environment.
>> +
>> +config GUNYAH_RESORUCE_MANAGER
>> +	tristate "Gunyah Resource Manager"
>> +	select MAILBOX
>> +	select GUNYAH_MESSAGE_QUEUES
>> +	depends on GUNYAH
>> +	default y
> 
> You only have "default y" if your machine can not boot without it.
> Please do not add that here.
> 

There's a guideline in Documentation/kbuild/kconfig-language.rst to 
provide some sane defaults for subdriver behavior. Here, CONFIG_GUNYAH 
is default n. It's unlikely for someone to want to have Linux with base 
Gunyah support (hypercalls and hypervisor detection) without also having 
the Resource Manager driver. If it's better, I could change to default m?

>> +	help
>> +	  The resource manager (RM) is a privileged application VM supporting
>> +	  the Gunyah Hypervisor. Enable this driver to support communicating
>> +	  with Gunyah RM. This is typically required for a VM running under
>> +	  Gunyah wanting to have Gunyah-awareness.
>> +
>> +	  Say Y/M here if unsure.
>> +
>> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
>> index 2ac4ee64b89d..2c18b0a56413 100644
>> --- a/drivers/virt/gunyah/Makefile
>> +++ b/drivers/virt/gunyah/Makefile
>> @@ -1 +1,4 @@
>>   obj-$(CONFIG_GUNYAH) += gunyah.o
>> +
>> +gunyah_rsc_mgr-y += rsc_mgr.o
>> +obj-$(CONFIG_GUNYAH_RESORUCE_MANAGER) += gunyah_rsc_mgr.o
>> diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
>> new file mode 100644
>> index 000000000000..a9fde703cbbe
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/rsc_mgr.c
>> @@ -0,0 +1,602 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#define pr_fmt(fmt) "gh_rsc_mgr: " fmt
> 
> This is a driver, you should never need this as you should be using the
> dev_*() calls, not pr_*() calls as you always have access to a struct
> device, right?
> 
> So you can drop this.
> 
> 

Ack

>> +
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +#include <linux/mutex.h>
>> +#include <linux/sched.h>
>> +#include <linux/gunyah.h>
>> +#include <linux/module.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/kthread.h>
>> +#include <linux/notifier.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/completion.h>
>> +#include <linux/gunyah_rsc_mgr.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "rsc_mgr.h"
>> +
>> +/* Resource Manager Header */
>> +struct gh_rm_rpc_hdr {
>> +	u8 version : 4, hdr_words : 4;
>> +	u8 type : 2, fragments : 6;
> 
> Ick, that's hard to read.  One variable per line please?

Ack.

> And why the bit packed stuff?  Are you sure this is the way to do this?
> Why not use a bitmask instead?
> 

I felt bit packed implementation is cleaner and easier to map to 
understanding what the fields are used for.

>> +	u16 seq;
>> +	u32 msg_id;
>> +} __packed;
>> +
>> +/* Standard reply header */
>> +struct gh_rm_rpc_reply_hdr {
>> +	struct gh_rm_rpc_hdr rpc_hdr;
>> +	u32 err_code;
>> +} __packed;
>> +
>> +/* RPC Header versions */
>> +#define GH_RM_RPC_HDR_VERSION_ONE	0x1
>> +
>> +/* RPC Header words */
>> +#define GH_RM_RPC_HDR_WORDS		0x2
>> +
>> +/* RPC Message types */
>> +#define GH_RM_RPC_TYPE_CONT		0x0
>> +#define GH_RM_RPC_TYPE_REQ		0x1
>> +#define GH_RM_RPC_TYPE_RPLY		0x2
>> +#define GH_RM_RPC_TYPE_NOTIF		0x3
>> +
>> +#define GH_RM_MAX_NUM_FRAGMENTS		62
>> +
>> +#define GH_RM_MAX_MSG_SIZE	(GH_MSGQ_MAX_MSG_SIZE - sizeof(struct gh_rm_rpc_hdr))
>> +
>> +/**
>> + * struct gh_rm_connection - Represents a complete message from resource manager
>> + * @payload: Combined payload of all the fragments (msg headers stripped off).
>> + * @size: Size of the payload.
>> + * @ret: Linux return code, set in case there was an error processing connection
>> + * @msg_id: Message ID from the header.
>> + * @type: GH_RM_RPC_TYPE_RPLY or GH_RM_RPC_TYPE_NOTIF.
>> + * @num_fragments: total number of fragments expected to be received.
>> + * @fragments_received: fragments received so far.
>> + * @rm_error: For request/reply sequences with standard replies.
>> + * @seq: Sequence ID for the main message.
>> + * @seq_done: Signals caller that the RM reply has been received
>> + */
>> +struct gh_rm_connection {
>> +	void *payload;
>> +	size_t size;
>> +	int ret;
>> +	u32 msg_id;
>> +	u8 type;
>> +
>> +	u8 num_fragments;
>> +	u8 fragments_received;
>> +
>> +	/* only for req/reply sequence */
>> +	u32 rm_error;
>> +	u16 seq;
>> +	struct completion seq_done;
>> +};
>> +
>> +struct gh_rm_notif_complete {
>> +	struct gh_rm_connection *conn;
>> +	struct work_struct work;
>> +};
>> +
>> +struct gh_rsc_mgr {
>> +	struct gunyah_resource tx_ghrsc, rx_ghrsc;
>> +	struct gh_msgq msgq;
>> +	struct mbox_client msgq_client;
>> +	struct gh_rm_connection *active_rx_connection;
>> +	int last_tx_ret;
>> +
>> +	struct idr call_idr;
>> +	struct mutex call_idr_lock;
>> +
>> +	struct mutex send_lock;
>> +
>> +	struct work_struct recv_work;
>> +};
>> +
>> +static struct gh_rsc_mgr *__rsc_mgr;
> 
> Sorry, no, you don't get to just limit yourself to one of these.  Please
> make this properly handle any number of "resource managers", static
> variables like this is not ok.
> 

There will only ever be one resource manager. optee, psci, and qcom_scm 
use a similar approach.

>> +SRCU_NOTIFIER_HEAD_STATIC(gh_rm_notifier);
> 
> Why do you need a notifier list?
> 
> Who will register for this?  For what?  Why?
> 

The majority of notifications that RM sends to Linux will be related to 
VM state, e.g. "VM crashed." I've not added the handling in VM manager 
yet to reduce the number of patches in this series. It was used in the 
previous series for the console driver. I can remove for now and 
re-introduce it once VM manager makes use?

>> +static int gh_rm_drv_probe(struct platform_device *pdev)
>> +{
>> +	struct gh_rsc_mgr *rsc_mgr;
>> +	int ret;
>> +
>> +	rsc_mgr = devm_kzalloc(&pdev->dev, sizeof(*rsc_mgr), GFP_KERNEL);
>> +	if (!rsc_mgr)
>> +		return -ENOMEM;
>> +	platform_set_drvdata(pdev, rsc_mgr);
>> +
>> +	mutex_init(&rsc_mgr->call_idr_lock);
>> +	idr_init(&rsc_mgr->call_idr);
>> +	mutex_init(&rsc_mgr->send_lock);
>> +
>> +	ret = gh_msgq_platform_probe_direction(pdev, GUNYAH_RESOURCE_TYPE_MSGQ_TX, 0,
>> +						&rsc_mgr->tx_ghrsc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = gh_msgq_platform_probe_direction(pdev, GUNYAH_RESOURCE_TYPE_MSGQ_RX, 1,
>> +						&rsc_mgr->rx_ghrsc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	rsc_mgr->msgq_client.dev = &pdev->dev;
> 
> So your client device is the platform device, and not a new bridge
> device that you create instead?  Why?
> 

Answered below

>> +	rsc_mgr->msgq_client.tx_block = true;
>> +	rsc_mgr->msgq_client.rx_callback = gh_rm_msgq_rx_data;
>> +	rsc_mgr->msgq_client.tx_done = gh_rm_msgq_tx_done;
>> +
>> +	ret = gh_msgq_init(&pdev->dev, &rsc_mgr->msgq, &rsc_mgr->msgq_client,
>> +				&rsc_mgr->tx_ghrsc, &rsc_mgr->rx_ghrsc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	__rsc_mgr = rsc_mgr;
>> +
>> +	return 0;
>> +}
>> +static struct platform_driver gh_rm_driver = {
>> +	.probe = gh_rm_drv_probe,
>> +	.remove = gh_rm_drv_remove,
>> +	.driver = {
>> +		.name = "gh_rsc_mgr",
>> +		.of_match_table = gh_rm_of_match,
>> +	},
> 
> Wait, why is this a platform driver?  This is binding to a real device
> on a real bus, not a random platform description in DT, right?

This a binding for a real device and not a "random platform description" 
in DT to get the driver probed.

> Or is it controlled by your DT?  I can't figure that out here, sorry.

There is some info in Patch 2 about why the DT node exists and how it 
looks. Essentially, The DT node is provided by Gunyah during boot and 
describes how Linux can communicate with resource manager.

Thanks,
Elliot
